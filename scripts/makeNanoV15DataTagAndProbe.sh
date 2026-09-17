#!/bin/bash
# CMSSW_15_0 muon tag-and-probe NanoAOD (Data, every Run 2 campaign incl. the 2017H low-PU run).
# PAT + NANO from AOD in one job with the T&P content (nanoTP_cff.customizeNANOTP,
# customizeNANOTPLowPU for 2017H).
# Era WITHOUT run2_nanoAOD_106Xv2 (its PUPPI re-clustering / tau re-wiring is
# circular with PAT in the same process; see nanoTP_cff.py); PAT behaves as the
# UL MiniAODv2 via the run2_miniAOD_UL process modifier.
# usage: makeNanoV15DataTagAndProbe <das_path or file:/root:...> <name> [nthreads] [campaign]
#   campaign: 2016preVFP | 2016postVFP | 2017 | 2018 | 2017LowPU (default: from the dataset name)
if [[ $# -lt 2 ]]; then
    echo "usage: $0 <das_path or file:path> <name> [nthreads] [campaign]"
    exit 1
fi
source "$(dirname "$0")/campaign.sh"

input=$1
if [[ "$input" != file:* && "$input" != root://* ]]; then
    input=dbs:$input
fi
nevents=1000
name=$2
nThreads=${3:-4}
campaign=${4:-$(campaign_from_input "$1")} || exit 1
era=$(era_of $campaign)

config_name=configs/${name}_cfg.py
outfile=${name}.root

case $campaign in
    2016preVFP|2016postVFP|2017LowPU) gt=106X_dataRun2_v35 ;;
    2017|2018)                        gt=106X_dataRun2_v37 ;;
esac
tnp=PhysicsTools/NanoAOD/nanoTP_cff.customizeNANOTP; [[ $campaign == 2017LowPU ]] && tnp=${tnp}LowPU

cmsDriver.py NANO --conditions $gt \
    --datatier NANOAOD --eventcontent NANOAOD \
    --era $era --procModifiers run2_miniAOD_UL --geometry DB:Extended \
    --customise Configuration/DataProcessing/Utils.addMonitoring,$tnp \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --data \
    --scenario pp --step PAT,NANO -n $nevents
