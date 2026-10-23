#!/usr/bin/env bash
# Build a fresh CMSSW_10_6_17_patch1 submission area for the AlcaRecoGun campaign.
# Run INSIDE the EL7 container (cmssw-el7); see README step 2a.
#   $1  tagged checkout of emanca/cmssw (repo root == src/; read-only here)
#   $2  destination dir for the area (must not exist)
# The area must be per-owner and per-tag: identical tag -> identical binaries.
set -Eeuo pipefail

if [ $# -ne 2 ]; then
    echo "usage: $0 <cmssw checkout root> <area destination>" >&2
    exit 1
fi
CMSSW_SRC="$(readlink -f "$1")"
DEST="$(readlink -f "$2" 2>/dev/null || echo "$2")"
EXPECTED_TAG="AlcaRecoGun_v1.1"

tag="$(git -C "$CMSSW_SRC" describe --tags --exact-match 2>/dev/null || echo none)"
[ "$tag" = "$EXPECTED_TAG" ] || { echo "ERROR: $CMSSW_SRC not at tag $EXPECTED_TAG (got $tag)" >&2; exit 1; }
git -C "$CMSSW_SRC" diff --quiet && git -C "$CMSSW_SRC" diff --cached --quiet \
    || { echo "ERROR: $CMSSW_SRC worktree is dirty" >&2; exit 1; }
[ ! -e "$DEST" ] || { echo "ERROR: destination exists: $DEST" >&2; exit 1; }

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc700
mkdir -p "$DEST" && cd "$DEST"
cmsrel CMSSW_10_6_17_patch1 >/dev/null
cd CMSSW_10_6_17_patch1/src
cmsenv

mkdir -p GunAlcaReco
cp -r "$CMSSW_SRC/GunAlcaReco/GenTrackMatch" GunAlcaReco/
find GunAlcaReco -name '*.pyc' -delete

scram b -j8
edmPluginHelp -p GenMatchedTrackFilter >/dev/null \
    && echo "plugin gate OK: pluginGenMatchedTrackFilter.so found" \
    || { echo "ERROR: pluginGenMatchedTrackFilter.so not discoverable" >&2; exit 1; }

echo "Area ready: $DEST"
