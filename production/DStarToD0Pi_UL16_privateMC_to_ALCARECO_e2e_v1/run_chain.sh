#!/usr/bin/env bash
set -Eeuo pipefail

CAMPAIGN="DStarToD0Pi_D0KPi_TuneCP5_UL16_privateMC_to_ALCARECO_e2e_v1"
RELEASE_106="CMSSW_10_6_17_patch1"
ARCH_106="slc7_amd64_gcc700"
RELEASE_80="CMSSW_8_0_36_UL_patch1"
ARCH_80="slc7_amd64_gcc530"
DIGI_THREADS=4
FINAL_OUTPUT="TkAlDstToD0Pi.root"
SCAN_OUTPUT="dst_alca_threshold_scan_hlt.root"
SUMMARY_OUTPUT="monitoring.json"

die() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 2
}

is_positive_integer() {
    [[ "$1" =~ ^[1-9][0-9]*$ ]]
}

is_nonnegative_integer() {
    [[ "$1" =~ ^[0-9]+$ ]]
}

file_size() {
    stat -c '%s' "$1"
}

edm_event_count() {
    edmFileUtil -j -f "file:$1" | python -c \
        'import json,sys; print(sum(int(item.get("events", 0)) for item in json.load(sys.stdin)))'
}

cleanup_work_dir() {
    local status=$?
    local report temporary_report
    trap - EXIT
    if [[ "${LOCAL_MODE:-1}" -eq 0 && -n "${INITIAL_DIR:-}" && "$status" -ne 0 ]]; then
        report="${WORK_DIR:-}/FrameworkJobReport.xml"
        temporary_report="$INITIAL_DIR/.FrameworkJobReport.xml.$$"
        if [[ -s "$report" ]] && \
            python -c 'import sys, xml.etree.ElementTree as ET; ET.parse(sys.argv[1])' "$report"; then
            cp -f "$report" "$temporary_report"
        else
            cat > "$temporary_report" <<EOF
<FrameworkJobReport>
  <FrameworkError ExitStatus="$status" Type="ScriptExeFailure"><![CDATA[run_chain.sh failed before cmsRun produced a framework job report.]]></FrameworkError>
</FrameworkJobReport>
EOF
        fi
        mv -f "$temporary_report" "$INITIAL_DIR/FrameworkJobReport.xml"
    fi
    if [[ -n "${WORK_DIR:-}" && -d "$WORK_DIR" ]]; then
        rm -rf -- "$WORK_DIR"
    fi
    exit "$status"
}

source_cms_defaults() {
    [[ -r /cvmfs/cms.cern.ch/cmsset_default.sh ]] || die "CMS CVMFS setup is unavailable"
    set +u
    # shellcheck disable=SC1091
    source /cvmfs/cms.cern.ch/cmsset_default.sh
    set -u
}

setup_release() {
    local release="$1"
    local arch="$2"
    local configured_dir="$3"
    local release_dir

    source_cms_defaults
    export SCRAM_ARCH="$arch"

    if [[ -n "$configured_dir" ]]; then
        release_dir="$configured_dir"
    elif [[ "${INITIAL_CMSSW_VERSION:-}" == "$release" && -n "${INITIAL_CMSSW_BASE:-}" ]]; then
        release_dir="$INITIAL_CMSSW_BASE"
    else
        release_dir="$WORK_DIR/releases/$release"
        if [[ ! -d "$release_dir/.SCRAM" ]]; then
            mkdir -p "$WORK_DIR/releases"
            (
                cd "$WORK_DIR/releases"
                scram project CMSSW "$release"
            )
        fi
    fi

    [[ -d "$release_dir/src" && -d "$release_dir/.SCRAM" ]] || \
        die "invalid $release release area: $release_dir"
    cd "$release_dir/src"
    set +u
    eval "$(scram runtime -sh)"
    set -u
    cd "$WORK_DIR"
    export CMSSW_SEARCH_PATH="$PAYLOAD_DIR/packages:${CMSSW_SEARCH_PATH:-}"
    command -v cmsRun >/dev/null || die "cmsRun is unavailable for $release"
    command -v edmFileUtil >/dev/null || die "edmFileUtil is unavailable for $release"
    [[ "${CMSSW_VERSION:-}" == "$release" ]] || \
        die "requested $release but activated ${CMSSW_VERSION:-unset}"
}

validate_edm_output() {
    local output="$1"
    [[ -s "$output" ]] || die "expected non-empty output is missing: $output"
    edmFileUtil "file:$output" >/dev/null 2>&1 || die "invalid EDM output: $output"
}

run_stage() {
    local stage="$1"
    local release="$2"
    local arch="$3"
    local configured_dir="$4"
    local input="$5"
    local output="$6"
    local delete_input="$7"
    local report="$WORK_DIR/FrameworkJobReport.xml"
    local crab_pset start end input_name input_bytes output_bytes output_events deleted="false"

    [[ ! -e "$output" ]] || die "refusing stale stage output: $output"
    if [[ "$input" == "-" ]]; then
        input_name="none"
        input_bytes=0
        unset CHAIN_INPUT_FILE || true
    else
        [[ -s "$input" ]] || die "$stage input is missing or empty: $input"
        input_name="$(basename "$input")"
        input_bytes="$(file_size "$input")"
        export CHAIN_INPUT_FILE="$input"
    fi

    setup_release "$release" "$arch" "$configured_dir"
    if [[ "$stage" == "RECOALCA" ]]; then
        edmPluginHelp -p DstAlcaThresholdScanAnalyzer >/dev/null || \
            die "DstAlcaThresholdScanAnalyzer is unavailable in the packaged 10.6 release"
    fi
    export CHAIN_STAGE="$stage"
    export CHAIN_SEED_REPORT="$WORK_DIR/seeds_${stage}.json"

    start="$(date +%s)"
    printf '=== %s start: release=%s job=%s events=%s ===\n' \
        "$stage" "$release" "$JOB_ID" "$EVENTS"
    rm -f -- "$report"
    if [[ "$stage" == "GENSIM" && "$LOCAL_MODE" -eq 0 ]]; then
        if [[ -s "$INITIAL_DIR/PSet.py" ]]; then
            crab_pset="$INITIAL_DIR/PSet.py"
        elif [[ -s "$INITIAL_DIR/PSet.pkl" ]]; then
            crab_pset="$INITIAL_DIR/PSet.pkl"
        else
            die "CRAB PSet.py or PSet.pkl is missing"
        fi
        export CHAIN_CRAB_PSET="$crab_pset"
        (
            cd "$INITIAL_DIR"
            cmsRun -j "$report" "$PAYLOAD_DIR/runtime/crab_gensim_cfg.py"
        )
        [[ -s "$INITIAL_DIR/$(basename "$output")" ]] || \
            die "CRAB GENSIM output is missing: $INITIAL_DIR/$(basename "$output")"
        mv "$INITIAL_DIR/$(basename "$output")" "$output"
    else
        cmsRun -j "$report" "$PAYLOAD_DIR/runtime/stage_cfg.py"
    fi
    validate_edm_output "$output"
    output_events="$(edm_event_count "$output")"
    [[ "$output_events" =~ ^[0-9]+$ ]] || die "could not count events in $output"
    if [[ "$stage" == "GENSIM" && "$LOCAL_MODE" -eq 0 && "$output_events" -eq 0 ]]; then
        die "GENSIM accepted zero events from $EVENTS generator attempts"
    fi
    if [[ "$stage" == "RECOALCA" ]]; then
        [[ -s "$WORK_DIR/$SCAN_OUTPUT" ]] || die "compact scan ROOT output is missing"
        command -v rootls >/dev/null || die "rootls is unavailable for scan validation"
        rootls "$WORK_DIR/$SCAN_OUTPUT" >/dev/null 2>&1 || \
            die "invalid compact scan ROOT output"
    fi
    end="$(date +%s)"
    output_bytes="$(file_size "$output")"

    if [[ "$delete_input" == "true" ]]; then
        rm -f -- "$input"
        [[ ! -e "$input" ]] || die "failed to delete consumed input: $input"
        deleted="true"
    fi

    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
        "$stage" "$release" "$start" "$end" "$input_name" "$input_bytes" \
        "$(basename "$output")" "$output_bytes" "$output_events" "$deleted" >> "$STAGE_ROWS"
    printf '=== %s success: %ss, %s events, %s bytes ===\n' \
        "$stage" "$((end - start))" "$output_events" "$output_bytes"
}

[[ $# -ge 1 ]] || die "usage: run_chain.sh JOB_ID [events=N] [jobOffset=N] [local=0|1] [output_dir=PATH]"
CRAB_JOB_ID="$1"
shift
EVENTS="${CHAIN_EVENTS_PER_JOB:-100}"
JOB_OFFSET=0
LOCAL_MODE=0
OUTPUT_DIR="$PWD"

for argument in "$@"; do
    case "$argument" in
        events=*) EVENTS="${argument#events=}" ;;
        jobOffset=*) JOB_OFFSET="${argument#jobOffset=}" ;;
        local=0) LOCAL_MODE=0 ;;
        local=1) LOCAL_MODE=1 ;;
        output_dir=*) OUTPUT_DIR="${argument#output_dir=}" ;;
        *) die "unknown argument: $argument" ;;
    esac
done

is_positive_integer "$CRAB_JOB_ID" || die "JOB_ID must be a positive integer"
is_positive_integer "$EVENTS" || die "events must be a positive integer"
is_nonnegative_integer "$JOB_OFFSET" || die "jobOffset must be a nonnegative integer"
JOB_ID="$((CRAB_JOB_ID + JOB_OFFSET))"
is_positive_integer "$JOB_ID" || die "global JOB_ID must be a positive integer"
[[ "$OUTPUT_DIR" = /* ]] || OUTPUT_DIR="$PWD/$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
[[ ! -e "$OUTPUT_DIR/$FINAL_OUTPUT" ]] || die "final output already exists in $OUTPUT_DIR"
[[ ! -e "$OUTPUT_DIR/$SCAN_OUTPUT" ]] || die "scan output already exists in $OUTPUT_DIR"
[[ ! -e "$OUTPUT_DIR/$SUMMARY_OUTPUT" ]] || die "monitoring output already exists in $OUTPUT_DIR"

INITIAL_CMSSW_BASE="${CMSSW_BASE:-}"
INITIAL_CMSSW_VERSION="${CMSSW_VERSION:-}"
INITIAL_DIR="$PWD"
WORK_DIR="$(mktemp -d "$OUTPUT_DIR/.dstar_chain_${JOB_ID}_XXXXXX")"
trap cleanup_work_dir EXIT
STAGE_ROWS="$WORK_DIR/stages.tsv"
touch "$STAGE_ROWS"

if [[ "$LOCAL_MODE" -eq 1 ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PAYLOAD_DIR="$SCRIPT_DIR"
    LOCAL_106_DIR="${CHAIN_CMSSW_106_DIR:-/work/submit/emanca/zmass/ALCArequest/CMSSW_10_6_17_patch1}"
    LOCAL_80_DIR="${CHAIN_CMSSW_80_DIR:-/work/submit/emanca/zmass/ALCArequest/CMSSW_8_0_36_UL_patch1}"
else
    [[ -s "$INITIAL_DIR/payload.tar.gz" ]] || die "payload.tar.gz is missing from the CRAB sandbox"
    PAYLOAD_DIR="$WORK_DIR/payload"
    mkdir -p "$PAYLOAD_DIR"
    tar -xzf "$INITIAL_DIR/payload.tar.gz" -C "$PAYLOAD_DIR"
    LOCAL_106_DIR=""
    LOCAL_80_DIR=""
fi

export CHAIN_PAYLOAD_DIR="$PAYLOAD_DIR"
export CHAIN_JOB_ID="$JOB_ID"
export CHAIN_CRAB_JOB_ID="$CRAB_JOB_ID"
export CHAIN_JOB_OFFSET="$JOB_OFFSET"
export CHAIN_EVENTS="$EVENTS"
export CHAIN_CAMPAIGN="$CAMPAIGN"
export CHAIN_DIGI_THREADS="$DIGI_THREADS"
export CHAIN_IDENTITY_REPORT="$WORK_DIR/generator_identity.json"

(
    cd "$PAYLOAD_DIR"
    sha256sum -c REFERENCE_SHA256SUMS
) || die "reference payload integrity check failed"

GENSIM="$WORK_DIR/DStarToD0Pi_D0KPi_TuneCP5_GENSIM.root"
DIGI="$WORK_DIR/DStarToD0Pi_D0KPi_TuneCP5_DIGIPremix.root"
HLT="$WORK_DIR/DStarToD0Pi_D0KPi_TuneCP5_HLT.root"
FINAL="$WORK_DIR/$FINAL_OUTPUT"
SCAN="$WORK_DIR/$SCAN_OUTPUT"

run_stage "GENSIM" "$RELEASE_106" "$ARCH_106" "$LOCAL_106_DIR" "-" "$GENSIM" "false"
run_stage "DIGIPremix" "$RELEASE_106" "$ARCH_106" "$LOCAL_106_DIR" "$GENSIM" "$DIGI" "true"
run_stage "HLT" "$RELEASE_80" "$ARCH_80" "$LOCAL_80_DIR" "$DIGI" "$HLT" "true"
run_stage "RECOALCA" "$RELEASE_106" "$ARCH_106" "$LOCAL_106_DIR" "$HLT" "$FINAL" "true"

python "$PAYLOAD_DIR/monitoring/build_summary.py" \
    "$JOB_ID" "$EVENTS" "$CAMPAIGN" "$STAGE_ROWS" "$FINAL" "$SCAN" \
    "$WORK_DIR/generator_identity.json" "$WORK_DIR/$SUMMARY_OUTPUT"
[[ -s "$WORK_DIR/$SUMMARY_OUTPUT" ]] || die "monitoring summary was not created"

mv "$FINAL" "$OUTPUT_DIR/$FINAL_OUTPUT"
mv "$SCAN" "$OUTPUT_DIR/$SCAN_OUTPUT"
mv "$WORK_DIR/$SUMMARY_OUTPUT" "$OUTPUT_DIR/$SUMMARY_OUTPUT"
if [[ "$LOCAL_MODE" -eq 0 ]]; then
    python "$PAYLOAD_DIR/runtime/rewrite_fjr_paths.py" \
        "$WORK_DIR/FrameworkJobReport.xml" "$WORK_DIR" "$INITIAL_DIR"
    mv "$WORK_DIR/FrameworkJobReport.xml" "$INITIAL_DIR/FrameworkJobReport.xml"
else
    rm -f -- "$WORK_DIR/FrameworkJobReport.xml"
fi

find "$WORK_DIR" -maxdepth 1 -type f -name '*.root' -print -quit | \
    grep -q . && die "unexpected ROOT intermediate remains in $WORK_DIR"
rm -rf -- "$WORK_DIR"

printf 'Chain complete: %s\nScan: %s\nMonitoring: %s\n' \
    "$OUTPUT_DIR/$FINAL_OUTPUT" "$OUTPUT_DIR/$SCAN_OUTPUT" \
    "$OUTPUT_DIR/$SUMMARY_OUTPUT"
