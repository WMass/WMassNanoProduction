#!/usr/bin/env bash
# Pre-submission verification gate for the MuKPi gun campaign.
# Mirrors tests/test_workflow.sh of the D* e2e campaign: rebuilds the payload,
# verifies reference hashes, checks shell/Python syntax, and proves that two
# different job IDs produce different deterministic GENSIM seeds.
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
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc700
cd /work/submit/emanca/zmass/ALCArequest/CMSSW_10_6_17_patch1/src
eval "$(scramv1 runtime -sh)"
cd "$TMPDIR_TEST"
export CAMPAIGN_DIR
for jid in 17 18; do
    CHAIN_STAGE=GENSIM CHAIN_JOB_ID=$jid CHAIN_EVENTS=3 \
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
python3 - <<'PYEOF'
import json
a = json.load(open("seeds_17_flat.json"))
b = json.load(open("seeds_18_flat.json"))
assert a and b, "seed maps must be non-empty"
assert a != b, "job 17 and 18 seeds must differ"
assert any(a[k] != b[k] for k in a), "per-service seeds must differ"
print("deterministic seeds differ across job IDs OK")
PYEOF
echo "ALL CHECKS OK"
