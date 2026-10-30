#!/usr/bin/env bash
# Pre-submission verification gate for the MuKPi gun campaign.
# Mirrors tests/test_workflow.sh of the D* e2e campaign: rebuilds the payload,
# verifies reference hashes, checks shell/Python syntax, and proves that two
# different job IDs produce different deterministic GENSIM seeds.
# Usage: tests/test_workflow.sh [release-area]   (see step 2a of the runbook)
set -Eeuo pipefail
CAMPAIGN_DIR="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")"
cd "$CAMPAIGN_DIR"

./prepare_payload.sh

bash -n run_chain.sh
echo "run_chain.sh syntax OK"

for f in runtime/stage_runner.py runtime/deterministic_seeds.py runtime/rewrite_fjr_paths.py crab_pilot_guns.py; do
    python3 -m py_compile "$f"
done
echo "python syntax OK"

sha256sum -c REFERENCE_SHA256SUMS >/dev/null
echo "reference hashes OK"

LISTING="$(tar tzf payload.tar.gz)"
for need in \
    cfgs/MuGun_GENSIM_cfg.py cfgs/PiGun_GENSIM_cfg.py cfgs/KGun_GENSIM_cfg.py \
    cfgs/DIGIPremix_cfg.py cfgs/RECO_simtruth_cfg.py \
    cfgs/ALCA_Muon_cfg.py cfgs/ALCA_Pion_cfg.py cfgs/ALCA_Kaon_cfg.py \
    runtime/stage_runner.py runtime/deterministic_seeds.py runtime/rewrite_fjr_paths.py \
    REFERENCE_SHA256SUMS \
; do
    grep -qxF "$need" <<<"$LISTING" || { echo "payload missing: $need"; exit 1; }
done
echo "payload contents OK"

# Seed-difference proof: drive stage_runner main() against the MuGun GENSIM
# cfg at job 17 vs job 18 and require the resulting seeds to differ.
#
# Release area for the proof, in order of precedence (coordination.md rule 0:
# never a shared or pre-existing area):
#   1. the area passed as $1;
#   2. the step-2b build area beside this campaign dir, once it exists;
#   3. an ephemeral `scram project` inside this test's own temp dir -- the case
#      on a fresh setup, where 2a necessarily runs before 2b.
RELEASE="CMSSW_10_6_17_patch1"
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc700

is_release_area() { [ -d "$1/.SCRAM" ] && [ -d "$1/src" ]; }

RELEASE_AREA="${1:-}"
if [ -n "$RELEASE_AREA" ]; then
    RELEASE_AREA="$(readlink -f "$RELEASE_AREA")"
    is_release_area "$RELEASE_AREA" \
        || { echo "ERROR: not a CMSSW release area: $RELEASE_AREA" >&2; exit 1; }
    echo "seed proof: release area from argument ($RELEASE_AREA)"
elif is_release_area "$(dirname "$CAMPAIGN_DIR")/build_area/$RELEASE"; then
    RELEASE_AREA="$(readlink -f "$(dirname "$CAMPAIGN_DIR")/build_area/$RELEASE")"
    echo "seed proof: release area from step 2b ($RELEASE_AREA)"
else
    (cd "$TMPDIR_TEST" && scram project CMSSW "$RELEASE" >/dev/null)
    RELEASE_AREA="$TMPDIR_TEST/$RELEASE"
    echo "seed proof: ephemeral $RELEASE (no step-2b area yet)"
fi

cd "$RELEASE_AREA/src"
eval "$(scramv1 runtime -sh)"
[ "${CMSSW_VERSION:-}" = "$RELEASE" ] \
    || { echo "ERROR: expected $RELEASE, activated ${CMSSW_VERSION:-unset}" >&2; exit 1; }
cd "$TMPDIR_TEST"
export CAMPAIGN_DIR
for jid in 17 18; do
    CHAIN_STAGE=GENSIM CHAIN_JOB_ID=$jid CHAIN_EVENTS=3 CHAIN_SPECIES=MuGun \
    CHAIN_SEED_REPORT="$TMPDIR_TEST/seeds_$jid.json" \
    python3 - <<'PYEOF'
import importlib.util
import json
import os
import sys

campaign = os.environ["CAMPAIGN_DIR"]
runner = os.path.join(campaign, "runtime", "stage_runner.py")
sys.path.insert(0, os.path.join(campaign, "runtime"))
os.environ["CHAIN_CFG"] = os.path.join(campaign, "cfgs", "MuGun_GENSIM_cfg.py")
os.environ["CHAIN_PAYLOAD_DIR"] = campaign
spec = importlib.util.spec_from_file_location("chain_stage_cfg_shell", runner)
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)  # module body runs main() at import time
jid = int(os.environ["CHAIN_JOB_ID"])
with open(os.path.join(os.environ["CHAIN_SEED_REPORT"])) as handle:
    report = json.load(handle)
with open("seeds_%d_flat.json" % jid, "w") as out:
    json.dump(report["after"], out)
PYEOF
done
CHAIN_STAGE=GENSIM CHAIN_JOB_ID=17 CHAIN_EVENTS=3 CHAIN_SPECIES=PiGun \
CHAIN_SEED_REPORT="$TMPDIR_TEST/seeds_pigun.json" \
python3 - <<'PYEOF'
import importlib.util
import json
import os
import sys

campaign = os.environ["CAMPAIGN_DIR"]
runner = os.path.join(campaign, "runtime", "stage_runner.py")
sys.path.insert(0, os.path.join(campaign, "runtime"))
os.environ["CHAIN_CFG"] = os.path.join(campaign, "cfgs", "MuGun_GENSIM_cfg.py")
os.environ["CHAIN_PAYLOAD_DIR"] = campaign
spec = importlib.util.spec_from_file_location("chain_stage_cfg_shell", runner)
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
with open(os.path.join(os.environ["CHAIN_SEED_REPORT"])) as handle:
    report = json.load(handle)
with open("seeds_pigun_flat.json", "w") as out:
    json.dump(report["after"], out)
PYEOF
python3 - <<'PYEOF'
import json
a = json.load(open("seeds_17_flat.json"))
b = json.load(open("seeds_18_flat.json"))
assert a and b, "seed maps must be non-empty"
assert a != b, "job 17 and 18 seeds must differ"
assert any(a[k] != b[k] for k in a), "per-service seeds must differ"
print("deterministic seeds differ across job IDs OK")
mu = json.load(open("seeds_17_flat.json"))
pi = json.load(open("seeds_pigun_flat.json"))
assert mu != pi and any(mu[k] != pi[k] for k in mu), \
    "same job ID across species must give DIFFERENT seeds (v1_150M decision)"
print("deterministic seeds differ across species OK")
PYEOF
echo "ALL CHECKS OK"
