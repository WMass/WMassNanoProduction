#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EVENTS="${1:-1}"
JOB_ID="${2:-1}"
OUTPUT_DIR="${3:-$ROOT/local_runs/job_${JOB_ID}}"

[[ "$EVENTS" =~ ^[1-9][0-9]*$ ]] || { echo "EVENTS must be positive" >&2; exit 2; }
[[ "$JOB_ID" =~ ^[1-9][0-9]*$ ]] || { echo "JOB_ID must be positive" >&2; exit 2; }
command -v cmssw-el7 >/dev/null || { echo "cmssw-el7 is unavailable" >&2; exit 2; }

mkdir -p "$OUTPUT_DIR"
OUTPUT_DIR="$(cd "$OUTPUT_DIR" && pwd)"
printf -v COMMAND '%q ' \
    "$ROOT/run_chain.sh" "$JOB_ID" "local=1" "events=$EVENTS" "output_dir=$OUTPUT_DIR"
cmssw-el7 --command-to-run "$COMMAND"
