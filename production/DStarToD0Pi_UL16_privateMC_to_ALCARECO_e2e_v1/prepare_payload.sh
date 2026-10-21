#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINATION="$ROOT/payload.tar.gz"
TEMPORARY="$(mktemp "$ROOT/.payload.XXXXXX.tar.gz")"
trap 'rm -f -- "$TEMPORARY"' EXIT

(
    cd "$ROOT"
    sha256sum -c REFERENCE_SHA256SUMS
    tar --exclude='*.pyc' --exclude='__pycache__' -czf "$TEMPORARY" \
        REFERENCE_SHA256SUMS reference packages runtime monitoring
)

mv "$TEMPORARY" "$DESTINATION"
trap - EXIT
printf 'Created %s (%s bytes)\n' "$DESTINATION" "$(stat -c '%s' "$DESTINATION")"
