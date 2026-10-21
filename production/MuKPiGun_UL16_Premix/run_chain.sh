#!/usr/bin/env bash
# MuKPiGun UL16 Premix pilot: end-to-end GEN-SIM -> DIGIPremix -> RECO -> ALCARECO
# chain driver. Architecture ported 1:1 from the D* UL16 e2e chain
# (run_chain.sh of DStarToD0Pi_UL16_privateMC_to_ALCARECO_e2e_v1):
#   * payload extracted + sha256-verified inside a private WORK_DIR
#   * custom modules via CMSSW_SEARCH_PATH (payload packages/), never touching
#     the site release lib tree: no cache recache, no poisoned-stub paths
#   * cmsRun -j FrameworkJobReport.xml per stage + guaranteed-parseable
#     report fallback in cleanup trap (BadFWJRXML is structurally impossible)
#   * deterministic per-job RNG seeds (runtime/deterministic_seeds.py)
#   * per-stage edmFileUtil validation + event counting + stage rows
set -Eeuo pipefail

CAMPAIGN="MuKPiGun_UL16_Premix_e2e_v1"
RELEASE="CMSSW_10_6_17_patch1"
ARCH="slc7_amd64_gcc700"
SUMMARY_OUTPUT="monitoring.json"

die() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 2
}

is_positive_integer() { [[ "$1" =~ ^[1-9][0-9]*$ ]]; }
is_nonnegative_integer() { [[ "$1" =~ ^[0-9]+$ ]]; }
file_size() { stat -c '%s' "$1"; }

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
    source /cvmfs/cms.cern.ch/cmsset_default.sh
    set -u
}

setup_release() {
    local configured_dir="$1"
    local release_dir

    source_cms_defaults
    export SCRAM_ARCH="$ARCH"

    if [[ -n "$configured_dir" ]]; then
        release_dir="$configured_dir"
    elif [[ "${INITIAL_CMSSW_VERSION:-}" == "$RELEASE" && -n "${INITIAL_CMSSW_BASE:-}" ]]; then
        release_dir="$INITIAL_CMSSW_BASE"
    else
        release_dir="$WORK_DIR/releases/$RELEASE"
        if [[ ! -d "$release_dir/.SCRAM" ]]; then
            mkdir -p "$WORK_DIR/releases"
            (
                cd "$WORK_DIR/releases"
                scram project CMSSW "$RELEASE"
            )
        fi
    fi

    [[ -d "$release_dir/src" && -d "$release_dir/.SCRAM" ]] || \
        die "invalid $RELEASE release area: $release_dir"
    cd "$release_dir/src"
    set +u
    eval "$(scram runtime -sh)"
    set -u
    cd "$WORK_DIR"
    export CMSSW_SEARCH_PATH="$PAYLOAD_DIR/packages:${CMSSW_SEARCH_PATH:-}"
    command -v cmsRun >/dev/null || die "cmsRun is unavailable for $RELEASE"
    command -v edmFileUtil >/dev/null || die "edmFileUtil is unavailable for $RELEASE"
    [[ "${CMSSW_VERSION:-}" == "$RELEASE" ]] || \
        die "requested $RELEASE but activated ${CMSSW_VERSION:-unset}"
}

validate_edm_output() {
    local output="$1"
    [[ -s "$output" ]] || die "expected non-empty output is missing: $output"
    edmFileUtil "file:$output" >/dev/null 2>&1 || die "invalid EDM output: $output"
}

run_stage() {
    local stage="$1" cfg="$2" input="$3" output="$4" delete_input="$5"
    local report="$WORK_DIR/FrameworkJobReport.xml"
    local start end input_name input_bytes output_bytes output_events deleted="false"

    [[ -e "$output" ]] && die "refusing stale stage output: $output"
    [[ -s "$cfg" ]] || die "stage cfg missing: $cfg"
    if [[ "$input" == "-" ]]; then
        input_name="none"
        input_bytes=0
    else
        [[ -s "$input" ]] || die "$stage input is missing or empty: $input"
        input_name="$(basename "$input")"
        input_bytes="$(file_size "$input")"
    fi

    export CHAIN_STAGE="$stage"
    export CHAIN_SEED_REPORT="$WORK_DIR/seeds_${stage}.json"
    export CHAIN_CFG="$(readlink -f "$cfg")"
    export CHAIN_OUTPUT_ABS="$(readlink -f "$output")"

    start="$(date +%s)"
    printf '=== %s start: job=%s events=%s ===\n' "$stage" "$JOB_ID" "$EVENTS"
    rm -f -- "$report"
    cmsRun -j "$report" "$PAYLOAD_DIR/runtime/stage_runner.py"
    validate_edm_output "$output"
    output_events="$(edm_event_count "$output")"
    [[ "$output_events" =~ ^[0-9]+$ ]] || die "could not count events in $output"
    end="$(date +%s)"
    output_bytes="$(file_size "$output")"

    if [[ "$delete_input" == "true" ]]; then
        rm -f -- "$input"
        [[ ! -e "$input" ]] || die "failed to delete consumed input: $input"
        deleted="true"
    fi

    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
        "$stage" "$start" "$end" "$input_name" "$input_bytes" \
        "$(basename "$output")" "$output_bytes" "$output_events" >> "$STAGE_ROWS"
    printf '=== %s success: %ss, %s events, %s bytes ===\n' \
        "$stage" "$((end - start))" "$output_events" "$output_bytes"
}

[[ $# -ge 1 ]] || die "usage: run_chain.sh JOB_ID [events=N] [species=NAME] [jobOffset=N] [local=0|1] [output_dir=PATH]"
CRAB_JOB_ID="$1"
shift
EVENTS="${CHAIN_EVENTS_PER_JOB:-100}"
SPECIES=""
JOB_OFFSET=0
LOCAL_MODE=0
OUTPUT_DIR="$PWD"

for argument in "$@"; do
    case "$argument" in
        events=*) EVENTS="${argument#events=}" ;;
        species=*) SPECIES="${argument#species=}" ;;
        jobOffset=*) JOB_OFFSET="${argument#jobOffset=}" ;;
        local=0) LOCAL_MODE=0 ;;
        local=1) LOCAL_MODE=1 ;;
        output_dir=*) OUTPUT_DIR="${argument#output_dir=}" ;;
        *) die "unknown argument: $argument" ;;
    esac
done

case "$SPECIES" in MuGun|PiGun|KGun) ;; *) die "bad species '$SPECIES'" ;; esac
is_positive_integer "$CRAB_JOB_ID" || die "JOB_ID must be a positive integer"
is_positive_integer "$EVENTS" || die "events must be a positive integer"
is_nonnegative_integer "$JOB_OFFSET" || die "jobOffset must be a nonnegative integer"
JOB_ID="$((CRAB_JOB_ID + JOB_OFFSET))"
is_positive_integer "$JOB_ID" || die "global JOB_ID must be a positive integer"
[[ "$OUTPUT_DIR" = /* ]] || OUTPUT_DIR="$PWD/$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
FINAL_OUTPUT="${SPECIES}_ALCARECO.root"
[[ ! -e "$OUTPUT_DIR/$FINAL_OUTPUT" ]] || die "final output already exists in $OUTPUT_DIR"
[[ ! -e "$OUTPUT_DIR/$SUMMARY_OUTPUT" ]] || die "monitoring output already exists in $OUTPUT_DIR"

INITIAL_CMSSW_BASE="${CMSSW_BASE:-}"
INITIAL_CMSSW_VERSION="${CMSSW_VERSION:-}"
INITIAL_DIR="$PWD"
WORK_DIR="$(mktemp -d "$INITIAL_DIR/.chain_${SPECIES}_${JOB_ID}_XXXXXX")"
trap cleanup_work_dir EXIT
STAGE_ROWS="$WORK_DIR/stages.tsv"
touch "$STAGE_ROWS"

if [[ "$LOCAL_MODE" -eq 1 ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PAYLOAD_DIR="$SCRIPT_DIR"
    LOCAL_RELEASE_DIR="${CHAIN_CMSSW_DIR:-/work/submit/emanca/zmass/ALCArequest/CMSSW_10_6_17_patch1}"
else
    [[ -s "$INITIAL_DIR/payload.tar.gz" ]] || die "payload.tar.gz is missing from the CRAB sandbox"
    PAYLOAD_DIR="$WORK_DIR/payload"
    mkdir -p "$PAYLOAD_DIR"
    tar -xzf "$INITIAL_DIR/payload.tar.gz" -C "$PAYLOAD_DIR"
    # On a real CRAB job the release area is built from the sandbox; locally,
    # CHAIN_CMSSW_DIR supplies the reference area (and its custom products).
    LOCAL_RELEASE_DIR="${CHAIN_CMSSW_DIR:-}"
fi

export CHAIN_PAYLOAD_DIR="$PAYLOAD_DIR"
export CHAIN_JOB_ID="$JOB_ID"
export CHAIN_CRAB_JOB_ID="$CRAB_JOB_ID"
export CHAIN_OFFSET="$JOB_OFFSET"
export CHAIN_EVENTS="$EVENTS"
export CHAIN_CAMPAIGN="$CAMPAIGN"

(
    cd "$PAYLOAD_DIR"
    sha256sum -c REFERENCE_SHA256SUMS
) || die "reference payload integrity check failed"

setup_release "$LOCAL_RELEASE_DIR"

GENSIM_OUT="$WORK_DIR/${SPECIES}Pt0p01To150_Eta2p4_pythia8_gun_cfi_py_GEN_SIM.root"
PREMIX_OUT="$WORK_DIR/step2_DIGI_DATAMIX_L1_DIGI2RAW.root"
RECO_OUT="$WORK_DIR/step3_RAW2DIGI_L1Reco_RECO.root"

case "$SPECIES" in
  MuGun) ALCA_STREAM="Muon" ;;
  PiGun) ALCA_STREAM="Pion" ;;
  KGun)  ALCA_STREAM="Kaon" ;;
esac

CFGDIR="$PAYLOAD_DIR/cfgs"

run_stage "GENSIM"     "$CFGDIR/${SPECIES}_GENSIM_cfg.py" "-" "$GENSIM_OUT" "false"
ln -sf "$GENSIM_OUT" "$WORK_DIR/step2_SIM.root"

run_stage "DIGIPremix" "$CFGDIR/DIGIPremix_cfg.py" "$GENSIM_OUT" "$PREMIX_OUT" "true"
ln -sf "$PREMIX_OUT" "$WORK_DIR/step3_DIGI2RAW.root"

run_stage "RECO"       "$CFGDIR/RECO_simtruth_cfg.py" "$PREMIX_OUT" "$RECO_OUT" "true"
ln -sf "$RECO_OUT" "$WORK_DIR/step4_RECO.root"

run_stage "ALCA"       "$CFGDIR/ALCA_${ALCA_STREAM}_cfg.py" "$RECO_OUT" "$WORK_DIR/$FINAL_OUTPUT" "true"

python - <<PYEOF
import csv, json, os
rep = {"campaign": "$CAMPAIGN", "species": "$SPECIES", "alca_stream": "$ALCA_STREAM",
       "jobId": $JOB_ID, "crabJobId": $CRAB_JOB_ID, "jobOffset": $JOB_OFFSET,
       "events_requested": $EVENTS,
       "outputs": {"$FINAL_OUTPUT": os.path.getsize("$WORK_DIR/$FINAL_OUTPUT")}}
rows = []
with open("$STAGE_ROWS") as handle:
    for fields in csv.reader(handle, delimiter="\t"):
        rows.append({"stage": fields[0], "start": int(fields[1]), "end": int(fields[2]),
                     "input": fields[3], "inputBytes": int(fields[4]),
                     "output": fields[5], "outputBytes": int(fields[6]),
                     "outputEvents": int(fields[7])})
rep["stages"] = rows
with open("$WORK_DIR/$SUMMARY_OUTPUT", "w") as handle:
    handle.write(json.dumps(rep) + "\n")
print(json.dumps(rep))
PYEOF

mv "$WORK_DIR/$FINAL_OUTPUT" "$OUTPUT_DIR/$FINAL_OUTPUT"
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
trap - EXIT

printf 'Chain complete: %s\nMonitoring: %s\n' \
    "$OUTPUT_DIR/$FINAL_OUTPUT" "$OUTPUT_DIR/$SUMMARY_OUTPUT"
