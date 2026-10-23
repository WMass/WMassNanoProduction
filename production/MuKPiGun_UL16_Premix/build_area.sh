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
EXPECTED_TAG="AlcaRecoGun_v1.2"

# Tag pin: verified on the host (modern git) by assemble_campaign.sh, which must be
# run first per the runbook. Inside slc7, git 1.8.3 cannot read a modern sparse
# checkout at all (repositoryformatversion=1) — so here we verify only if the repo
# happens to be readable, and otherwise rely on the host-side gate + file presence.
if (cd "$CMSSW_SRC" && git rev-parse --git-dir) >/dev/null 2>&1; then
    head="$(cd "$CMSSW_SRC" && git rev-parse HEAD)"
    tagged="$(cd "$CMSSW_SRC" && git rev-parse --verify "$EXPECTED_TAG^{commit}" 2>/dev/null || echo none)"
    [ "$head" = "$tagged" ] || { echo "ERROR: $CMSSW_SRC HEAD is not at tag $EXPECTED_TAG" >&2; exit 1; }
    (cd "$CMSSW_SRC" && git diff --quiet && git diff --cached --quiet) \
        || { echo "ERROR: $CMSSW_SRC worktree is dirty" >&2; exit 1; }
    echo "cmssw checkout at $EXPECTED_TAG (verified)"
else
    echo "NOTE: git in this environment cannot parse $CMSSW_SRC; tag pin carried"
    echo "      by the host-side gate (assemble_campaign.sh) as per the runbook."
fi
[ -d "$CMSSW_SRC/GunAlcaReco/GenTrackMatch" ] || { echo "ERROR: GunAlcaReco/GenTrackMatch not in $CMSSW_SRC" >&2; exit 1; }
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
