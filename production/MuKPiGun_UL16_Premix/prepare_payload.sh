#!/usr/bin/env bash
# Rebuild the hash-pinned CRAB payload for the MuKPi gun campaign.
# Every payload member (cfg, runtime module, plugin binary + cache) must be
# listed in REFERENCE_SHA256SUMS; run_chain.sh verifies it at job start.
set -Eeuo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
# The FJR path rewriter is shared with the D* e2e campaign; its canonical copy
# lives in production/common/. Stage it into runtime/ so the payload layout
# (runtime/rewrite_fjr_paths.py, consumed by run_chain.sh) is unchanged.
trek_rewriter=0
if [ ! -f runtime/rewrite_fjr_paths.py ]; then
    cp ../common/rewrite_fjr_paths.py runtime/rewrite_fjr_paths.py
    trek_rewriter=1
fi
trap '[ "$trek_rewriter" = 1 ] && rm -f runtime/rewrite_fjr_paths.py || true' EXIT
# LC_ALL=C: collation is locale-dependent, and the manifest's line ORDER decides the
# hash of REFERENCE_SHA256SUMS even when every member is byte-identical. Under
# en_US.UTF-8 punctuation is ignored at the first level, so DIGI_noPU_cfg.py sorts
# before DIGIPremix_cfg.py; under C it is byte order and 'P' (0x50) < '_' (0x5F), so
# they swap. Two owners on the same tag then log two different REF hashes with
# identical payloads (measured, v2_pilot round). Pin the collation here.
find cfgs runtime -type f -not -path '*/__pycache__/*' | LC_ALL=C sort | xargs sha256sum > REFERENCE_SHA256SUMS
sha256sum -c REFERENCE_SHA256SUMS >/dev/null
# __pycache__ is excluded from the hash list above, so it must be excluded from
# the tar too: otherwise re-running the gate in a campaign dir that has already
# been used ships the host's .pyc files and the payload stops being a function
# of the tag alone.
tar czf payload.tar.gz --exclude='__pycache__' REFERENCE_SHA256SUMS cfgs runtime
ls -la payload.tar.gz
tar tzf payload.tar.gz | wc -l
