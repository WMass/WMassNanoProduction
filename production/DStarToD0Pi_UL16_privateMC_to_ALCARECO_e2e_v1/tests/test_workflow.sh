#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CMSSW_106="/work/submit/emanca/zmass/ALCArequest/CMSSW_10_6_17_patch1"
CMSSW_80="/work/submit/emanca/zmass/ALCArequest/CMSSW_8_0_36_UL_patch1"
TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/dstar_e2e_test.XXXXXX")"
trap 'rm -rf -- "$TEMP_DIR"' EXIT

if [[ "${CHAIN_TEST_IN_EL7:-0}" != 1 ]]; then
    command -v cmssw-el7 >/dev/null || { echo "cmssw-el7 is unavailable" >&2; exit 2; }
    printf -v COMMAND 'CHAIN_TEST_IN_EL7=1 %q' "$0"
    exec cmssw-el7 --command-to-run "$COMMAND"
fi

cd "$ROOT"
sha256sum -c REFERENCE_SHA256SUMS
bash -n run_chain.sh prepare_payload.sh run_local_test.sh tests/test_workflow.sh
python - \
    crabConfig_pilot.py \
    crabConfig_production100M_block1.py \
    crabConfig_production100M_block2.py \
    crabConfig_production100M_block3.py \
    crabConfig_production100M_block4.py \
    crabConfig_production100M_block5.py \
    crabConfig_thresholdRetention100k.py \
    crab_production500M.py \
    crab_pset.py \
    runtime/crab_gensim_cfg.py \
    runtime/deterministic_seeds.py \
    runtime/dump_process_seeds.py \
    runtime/generator_identity.py \
    runtime/rewrite_fjr_paths.py \
    runtime/stage_cfg.py \
    monitoring/aggregate_summaries.py \
    monitoring/build_summary.py <<'PY'
from __future__ import print_function
import sys

for path in sys.argv[1:]:
    with open(path, "rb") as handle:
        compile(handle.read(), path, "exec")
print("Python syntax checks passed without writing bytecode")
PY

grep -q 'disableAutomaticOutputCollection = True' crabConfig_pilot.py
grep -q 'publication = False' crabConfig_pilot.py
grep -q 'helper.insertSeeds' runtime/deterministic_seeds.py
grep -q 'cd "$INITIAL_DIR"' run_chain.sh
grep -q 'cmsRun -j "$report" "$PAYLOAD_DIR/runtime/crab_gensim_cfg.py"' run_chain.sh
grep -q 'jobOffset=' run_chain.sh
grep -q 'jobOffset={0}' crab_production500M.py
if grep -q 'dump_process_seeds.py.*crab_pset' run_chain.sh; then
    echo "CRAB's relative PSet.py/PSet.pkl wrapper must not be imported from the stage directory" >&2
    exit 1
fi
if grep -q '\.populate(' runtime/deterministic_seeds.py runtime/stage_cfg.py; then
    echo "nondeterministic RandomNumberServiceHelper.populate() is forbidden" >&2
    exit 1
fi

python - "$ROOT" <<'PY'
from __future__ import print_function
import os
import sys

sys.path.insert(0, os.path.join(sys.argv[1], "runtime"))
from generator_identity import generator_identity

first = generator_identity(1, 0, 12500)
second = generator_identity(1, 8000, 12500)
last = generator_identity(8000, 32000, 12500)
assert first["first_event"] == 1
assert first["last_event"] == 12500
assert second["global_job_id"] == 8001
assert second["first_event"] == 100000001
assert second["first_lumi"] == 8001
assert last["global_job_id"] == 40000
assert last["last_event"] == 500000000
print("500M block identities cover events 1 through 500000000 without overlap")
PY

cat > "$TEMP_DIR/report.xml" <<EOF
<FrameworkJobReport><File><PFN>$TEMP_DIR/work/scan.root</PFN></File></FrameworkJobReport>
EOF
python runtime/rewrite_fjr_paths.py \
    "$TEMP_DIR/report.xml" "$TEMP_DIR/work" "$TEMP_DIR/final"
grep -q "$TEMP_DIR/final/scan.root" "$TEMP_DIR/report.xml"
python -c 'import sys, xml.etree.ElementTree as ET; ET.parse(sys.argv[1])' \
    "$TEMP_DIR/report.xml"

dump_stage_seeds() {
    local stage="$1"
    local release_dir="$2"
    local arch="$3"
    local job_id="$4"
    local destination="$5"
    (
        export SCRAM_ARCH="$arch"
        cd "$release_dir/src"
        eval "$(scram runtime -sh)"
        cd "$TEMP_DIR"
        export CHAIN_PAYLOAD_DIR="$ROOT"
        export CHAIN_STAGE="$stage"
        export CHAIN_JOB_ID="$job_id"
        export CHAIN_EVENTS=1
        export CHAIN_CAMPAIGN=test
        export CHAIN_DIGI_THREADS=4
        export CHAIN_INPUT_FILE="$TEMP_DIR/not_opened.root"
        export CHAIN_SEED_REPORT="$destination"
        export CMSSW_SEARCH_PATH="$ROOT/packages:${CMSSW_SEARCH_PATH:-}"
        python "$ROOT/runtime/stage_cfg.py"
    )
}

cat > "$TEMP_DIR/crab_test_pset.py" <<EOF
import FWCore.ParameterSet.Config as cms
execfile("$ROOT/reference/DStarToD0Pi_D0KPi_TuneCP5_GENSIM_cfg.py")
process.source.firstRun = cms.untracked.uint32(1)
process.source.firstLuminosityBlock = cms.untracked.uint32(1)
process.source.firstEvent = cms.untracked.uint64(1)
process.source.numberEventsInLuminosityBlock = cms.untracked.uint32(12500)
EOF

dump_crab_gensim() {
    local offset="$1"
    local label="$2"
    (
        export SCRAM_ARCH=slc7_amd64_gcc700
        cd "$CMSSW_106/src"
        eval "$(scram runtime -sh)"
        cd "$TEMP_DIR"
        export CHAIN_PAYLOAD_DIR="$ROOT"
        export CHAIN_CRAB_PSET="$TEMP_DIR/crab_test_pset.py"
        export CHAIN_CRAB_JOB_ID=1
        export CHAIN_JOB_OFFSET="$offset"
        export CHAIN_EVENTS=12500
        export CHAIN_SEED_REPORT="$TEMP_DIR/crab_${label}_seeds.json"
        export CHAIN_IDENTITY_REPORT="$TEMP_DIR/crab_${label}_identity.json"
        python "$ROOT/runtime/crab_gensim_cfg.py"
    )
}

dump_crab_gensim 0 block1
dump_crab_gensim 8000 block2
python - "$TEMP_DIR" <<'PY'
from __future__ import print_function
import json
import os
import sys

root = sys.argv[1]
def load(name):
    with open(os.path.join(root, name)) as handle:
        return json.load(handle)

first_identity = load("crab_block1_identity.json")
second_identity = load("crab_block2_identity.json")
first_seeds = load("crab_block1_seeds.json")
second_seeds = load("crab_block2_seeds.json")
assert first_identity["first_event"] == 1
assert second_identity["first_event"] == 100000001
assert first_seeds and second_seeds
assert first_seeds != second_seeds
print("CRAB GEN-SIM wrapper offsets identities and seeds across blocks")
PY

for stage_release in \
    "DIGIPremix:$CMSSW_106:slc7_amd64_gcc700" \
    "HLT:$CMSSW_80:slc7_amd64_gcc530" \
    "RECOALCA:$CMSSW_106:slc7_amd64_gcc700"; do
    stage="${stage_release%%:*}"
    remainder="${stage_release#*:}"
    release_dir="${remainder%%:*}"
    arch="${remainder##*:}"
    dump_stage_seeds "$stage" "$release_dir" "$arch" 17 "$TEMP_DIR/${stage}_17.json"
    dump_stage_seeds "$stage" "$release_dir" "$arch" 18 "$TEMP_DIR/${stage}_18.json"
    python - "$stage" "$TEMP_DIR/${stage}_17.json" "$TEMP_DIR/${stage}_18.json" <<'PY'
from __future__ import print_function
import json
import sys

stage, first_path, second_path = sys.argv[1:]
with open(first_path) as handle:
    first = json.load(handle)
with open(second_path) as handle:
    second = json.load(handle)
if not first or not second:
    raise RuntimeError("{0} produced an empty seed dump".format(stage))
if first == second:
    raise RuntimeError("{0} reused seeds across job IDs".format(stage))
print("{0}: distinct seeds for jobs 17 and 18".format(stage))
PY
done

./prepare_payload.sh
tar -tzf payload.tar.gz | sort > "$TEMP_DIR/payload_files.txt"
if grep -E '(\.pyc$|/__pycache__/?$)' "$TEMP_DIR/payload_files.txt"; then
    echo "generated Python cache files must not enter payload.tar.gz" >&2
    exit 1
fi
for required in \
    REFERENCE_SHA256SUMS \
    runtime/crab_gensim_cfg.py \
    runtime/stage_cfg.py \
    runtime/deterministic_seeds.py \
    runtime/generator_identity.py \
    runtime/rewrite_fjr_paths.py \
    monitoring/aggregate_summaries.py \
    monitoring/build_summary.py; do
    grep -qx "$required" "$TEMP_DIR/payload_files.txt"
done

echo "Workflow static and deterministic-seed checks passed"
