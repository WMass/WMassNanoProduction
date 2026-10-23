#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINATION="$ROOT/payload.tar.gz"
TEMPORARY="$(mktemp "$ROOT/.payload.XXXXXX.tar.gz")"
trap 'rm -f -- "$TEMPORARY"' EXIT

# The FJR path rewriter is shared with the MuKPiGun campaign; its canonical
# copy lives in production/common/. Stage it into runtime/ so the payload
# layout (runtime/rewrite_fjr_paths.py, consumed by run_chain.sh) is unchanged.
trek_rewriter=0
if [ ! -f "$ROOT/runtime/rewrite_fjr_paths.py" ]; then
    cp "$ROOT/../common/rewrite_fjr_paths.py" "$ROOT/runtime/rewrite_fjr_paths.py"
    trek_rewriter=1
fi
trap 'rm -f -- "$TEMPORARY"; [ "$trek_rewriter" = 1 ] && rm -f "$ROOT/runtime/rewrite_fjr_paths.py" || true' EXIT

(
    cd "$ROOT"
    sha256sum -c REFERENCE_SHA256SUMS
    tar --exclude='*.pyc' --exclude='__pycache__' -czf "$TEMPORARY" \
        REFERENCE_SHA256SUMS reference packages runtime monitoring
)

mv "$TEMPORARY" "$DESTINATION"
[ "$trek_rewriter" = 1 ] && rm -f "$ROOT/runtime/rewrite_fjr_paths.py" || true
trap - EXIT
printf 'Created %s (%s bytes)\n' "$DESTINATION" "$(stat -c '%s' "$DESTINATION")"
