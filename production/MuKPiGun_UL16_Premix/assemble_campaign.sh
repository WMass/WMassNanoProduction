#!/usr/bin/env bash
# Materialize a working MuKPiGun UL16 Premix campaign area from the two tagged
# forks (see coordination.md):
#   $1  checkout of emanca/WMassNanoProduction  (branch NanoV9_CMSSW_10_6)
#   $2  checkout of emanca/cmssw                (branch from-CMSSW_10_6_17_patch1, repo root == src/)
#   $3  destination campaign dir to create
# Ends by rebuilding the payload and running the full pre-submission gate
# (tests/test_workflow.sh). Refuses to proceed if either checkout is not at the
# expected campaign tag or if any gate step fails.
set -Eeuo pipefail

if [ $# -ne 3 ]; then
    echo "usage: $0 <nanoproduction checkout> <cmssw checkout> <destination>" >&2
    exit 1
fi
NANOPROD="$(readlink -f "$1")"
CMSSW_SRC="$(readlink -f "$2")"
DEST="$3"
EXPECTED_TAG="AlcaRecoGun_v1.0"

for repo in "$NANOPROD" "$CMSSW_SRC"; do
    tag="$(git -C "$repo" describe --tags --always 2>/dev/null || echo none)"
    if [ "$tag" != "$EXPECTED_TAG" ] && ! git -C "$repo" describe --tags --exact-match "$EXPECTED_TAG" >/dev/null 2>&1; then
        echo "ERROR: $repo is not at tag $EXPECTED_TAG (got $tag)" >&2
        exit 1
    fi
done

if [ -e "$DEST" ]; then
    echo "ERROR: destination exists: $DEST" >&2
    exit 1
fi
mkdir -p "$DEST"

SRC_NP="$NANOPROD/production/MuKPiGun_UL16_Premix"
cp "$SRC_NP"/README.md "$SRC_NP"/CAMPAIGN_NOTES.md "$SRC_NP"/coordination.md "$DEST/"
cp "$SRC_NP"/run_chain.sh "$SRC_NP"/prepare_payload.sh "$DEST/"
cp "$SRC_NP"/crab_pilot_guns.py "$SRC_NP"/crab_pset.py "$DEST/"
cp "$SRC_NP"/crab_MuGun.py "$SRC_NP"/crab_PiGun.py "$SRC_NP"/crab_KGun.py "$DEST/"
chmod +x "$DEST/run_chain.sh" "$DEST/prepare_payload.sh"

cp -r "$SRC_NP/runtime" "$DEST/runtime"
cp -r "$SRC_NP/tests" "$DEST/tests"
# Shared campaign helper (single source in production/common/)
cp "$NANOPROD/production/common/rewrite_fjr_paths.py" "$DEST/runtime/"

cp -r "$CMSSW_SRC/Generation/GunAlcaReco/Production/MuKPiGun_UL16_Premix/cfgs" "$DEST/cfgs"
rm -f "$DEST/cfgs"/*.pyc 2>/dev/null || true

cd "$DEST"
./prepare_payload.sh
./tests/test_workflow.sh

echo
echo "Campaign area ready: $DEST"
echo "Next: set up CRAB (runbook step 2) and submit with 'crab submit -c crab_<Species>.py' (step 3)."
