#!/bin/bash
# Prepare the CMSSW area for CRAB submission of the W-mass nano (run after cmsenv,
# after every build, before submitting).
#
# 1. The CVH refit of DATA uses the OPERA/TOSCA field map 170812
#    (Analysis/HitAnalyzer/python/cvhOperaField.py). Its merged interpolation
#    tables are not in the CMSSW_15_0 data package, so they are shipped in
#    $CMSSW_BASE/external/$SCRAM_ARCH/data (on CMSSW_SEARCH_PATH in the job;
#    the crab template sets config.JobType.sendExternalFolder = True).
#    They are taken from a local directory if one is given, else downloaded
#    from the head of cms-data/MagneticField-Interpolation#5 (N. Amapane,
#    "Add tables for MF model 170812"; pinned commit), and checked by sha1.
# 2. CRAB refuses sandboxes above 120 MB (compressed). The CVH plugin library is
#    ~160 MB, ~98 % of it debug information (42 MB compressed); stripped it is
#    ~1 MB, which leaves room for the 68 MB (compressed) of tables. Stripping is
#    in place: rebuild (touch a source or scram b clean) to get debug info back.
# 3. CRAB also ships every src/*/*/data directory. The resolution-model tables of
#    the CVH development (TrackPropagation/Geant4e/data/cvhcf_*.bin, 90 MB, read
#    only by the doRes fits, never by the nano) are kept out of the work tree with
#    a sparse-checkout exclusion, so git status stays clean (undo: delete the
#    line from .git/info/sparse-checkout and run git sparse-checkout reapply).
#
# usage: scripts/prepareSandbox.sh [directory holding grid_170812_3_8t/merged.{bin,index}]
set -euo pipefail
: "${CMSSW_BASE:?run cmsenv first}"
SRC=${1:-}
DEST=$CMSSW_BASE/external/$SCRAM_ARCH/data/MagneticField/Interpolation/data/grid_170812_3_8t
# head of cms-data/MagneticField-Interpolation#5 (namapane/MagneticField-Interpolation master)
URL=https://raw.githubusercontent.com/namapane/MagneticField-Interpolation/a2f0f3783d823f8332db0bd355b00ec50435e886/grid_170812_3_8t
SHA1_BIN=6161bc26197ce68d4d875efea836b57270a8fa2b
SHA1_INDEX=60e8f84ba63c03bf7a9b1693370426d7b50b0fcf

check() {
    [[ -f $DEST/merged.bin && -f $DEST/merged.index ]] &&
        [[ $(sha1sum "$DEST/merged.bin" | cut -d' ' -f1) == "$SHA1_BIN" ]] &&
        [[ $(sha1sum "$DEST/merged.index" | cut -d' ' -f1) == "$SHA1_INDEX" ]]
}

if ! check; then
    mkdir -p "$DEST"
    rm -f "$DEST/merged.bin" "$DEST/merged.index"
    if [[ -n $SRC ]]; then
        cp "$SRC/grid_170812_3_8t/merged.bin" "$SRC/grid_170812_3_8t/merged.index" "$DEST/"
    else
        for f in merged.bin merged.index; do
            curl -sfL --retry 3 -o "$DEST/$f" "$URL/$f"
        done
    fi
    if ! check; then
        echo "ERROR: the OPERA 170812 tables in $DEST do not have the expected sha1" >&2
        exit 1
    fi
fi
echo "OPERA 170812 tables: $DEST (sha1 ok)"

EXCL='!/TrackPropagation/Geant4e/data/cvhcf_*.bin'
SPARSE=$CMSSW_BASE/src/.git/info/sparse-checkout
if compgen -G "$CMSSW_BASE/src/TrackPropagation/Geant4e/data/cvhcf_*.bin" >/dev/null; then
    if [[ ! -f $SPARSE ]]; then
        echo "ERROR: $CMSSW_BASE/src is not a sparse checkout; remove the cvhcf_*.bin tables by hand" >&2
        exit 1
    fi
    # the exclusion must come after the package line, so (re)append it at the end
    grep -vxF -- "$EXCL" "$SPARSE" > "$SPARSE.tmp" || true
    echo "$EXCL" >> "$SPARSE.tmp"
    mv "$SPARSE.tmp" "$SPARSE"
    git -C "$CMSSW_BASE/src" sparse-checkout reapply
fi
if compgen -G "$CMSSW_BASE/src/TrackPropagation/Geant4e/data/cvhcf_*.bin" >/dev/null; then
    echo "ERROR: the cvhcf development tables are still in the work tree (modified?)" >&2
    exit 1
fi
echo "cvhcf development tables: not in the work tree"

nstrip=0
for so in "$CMSSW_BASE"/lib/"$SCRAM_ARCH"/*.so; do
    if readelf -S "$so" 2>/dev/null | grep -q '\.debug_info'; then
        strip --strip-debug "$so"
        nstrip=$((nstrip + 1))
    fi
done
echo "stripped debug information from $nstrip libraries"

est=$(cd "$CMSSW_BASE" && tar czf - lib python cfipython external $(ls -d src/*/*/data 2>/dev/null) 2>/dev/null | wc -c)
echo "estimated sandbox: $((est / 1048576)) MB (CRAB limit 120 MB)"
if (( est > 120 * 1048576 )); then
    echo "ERROR: sandbox above the CRAB limit" >&2
    exit 1
fi
