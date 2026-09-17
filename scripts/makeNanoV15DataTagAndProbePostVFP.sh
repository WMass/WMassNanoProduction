#!/bin/bash
# CMSSW_15_0 muon tag-and-probe NanoAOD (2016 postVFP data): PAT + NANO from AOD in one job
# with the T&P content (nanoTP_cff.customizeNANOTP). Era WITHOUT
# run2_nanoAOD_106Xv2 (circular with PAT in the same process; see nanoTP_cff.py),
# PAT behaves as UL MiniAODv2 via the run2_miniAOD_UL process modifier.
# usage: makeNanoV15DataTagAndProbePostVFP <das_path or file:...> <name> [nthreads]
if [[ $# -lt 2 ]]; then
    echo "usage: $0 <das_path or file:path> <name> [nthreads]"
    exit 1
fi

input=$1
if [[ "$input" != file:* && "$input" != root://* ]]; then
    input=dbs:$input
fi
nevents=1000
name=$2
nThreads=${3:-4}

config_name=configs/${name}_cfg.py
outfile=${name}.root

cmsDriver.py NANO --conditions 106X_dataRun2_v35 \
    --datatier NANOAOD --eventcontent NANOAOD \
    --era Run2_2016 --procModifiers run2_miniAOD_UL --geometry DB:Extended \
    --customise Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nanoTP_cff.customizeNANOTP \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --data \
    --scenario pp --step PAT,NANO -n $nevents
