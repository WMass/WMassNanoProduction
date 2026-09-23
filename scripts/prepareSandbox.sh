#!/bin/bash
# Prepare the CMSSW area for CRAB submission of the W-mass nano (run after cmsenv).
#
# 1. The CVH refit of DATA uses the OPERA/TOSCA field map 170812
#    (Analysis/HitAnalyzer/python/cvhOperaField.py). Its merged interpolation
#    tables are not in the CMSSW_15_0 data package, so they are shipped in
#    $CMSSW_BASE/external/$SCRAM_ARCH/data (on CMSSW_SEARCH_PATH in the job;
#    the crab template sets config.JobType.sendExternalFolder = True).
# 2. CRAB refuses sandboxes above 120 MB (compressed). The CVH plugin library is
#    ~160 MB, ~98 % of it debug information (42 MB compressed); stripped it is
#    ~1 MB, which leaves room for the 68 MB (compressed) of tables. Stripping is
#    in place: rebuild (touch a source or scram b clean) to get debug info back.
#
# usage: scripts/prepareSandbox.sh [directory holding grid_170812_3_8t/merged.{bin,index}]
set -euo pipefail
: "${CMSSW_BASE:?run cmsenv first}"
SRC=${1:-/work/submit/david_w/ZMass/MagneticField-Interpolation}
DEST=$CMSSW_BASE/external/$SCRAM_ARCH/data/MagneticField/Interpolation/data/grid_170812_3_8t
# sha1sum of grid_170812_3_8t/merged.bin (= git blob 935c83d2 of cms-data/MagneticField-Interpolation#5)
SHA1_BIN=6161bc26197ce68d4d875efea836b57270a8fa2b

if [[ ! -f $DEST/merged.bin || ! -f $DEST/merged.index ]]; then
    mkdir -p "$DEST"
    cp "$SRC/grid_170812_3_8t/merged.bin" "$SRC/grid_170812_3_8t/merged.index" "$DEST/"
fi
got=$(sha1sum "$DEST/merged.bin" | cut -d' ' -f1)
if [[ $got != "$SHA1_BIN" ]]; then
    echo "ERROR: $DEST/merged.bin sha1 $got != $SHA1_BIN" >&2
    exit 1
fi
echo "OPERA 170812 tables: $DEST (sha1 ok)"

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
