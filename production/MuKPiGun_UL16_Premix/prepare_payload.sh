#!/usr/bin/env bash
# Rebuild the hash-pinned CRAB payload for the MuKPi gun campaign.
# Every payload member (cfg, runtime module, plugin binary + cache) must be
# listed in REFERENCE_SHA256SUMS; run_chain.sh verifies it at job start.
set -Eeuo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
find cfgs runtime -type f -not -path '*/__pycache__/*' | sort | xargs sha256sum > REFERENCE_SHA256SUMS
sha256sum -c REFERENCE_SHA256SUMS >/dev/null
tar czf payload.tar.gz REFERENCE_SHA256SUMS cfgs runtime
ls -la payload.tar.gz
tar tzf payload.tar.gz | wc -l
