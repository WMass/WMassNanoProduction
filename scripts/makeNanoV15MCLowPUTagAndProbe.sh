#!/bin/bash
# CMSSW_15_0 muon tag-and-probe NanoAOD (2017 low-PU MC, UL re-reco): PAT + NANO from AOD in one job
# with the T&P content + the 2017H HI-menu muon trigger bit (nanoTP_cff.customizeNANOTPLowPU) + the gen customisations (nanoGenWmassCustomize). Era WITHOUT
# run2_nanoAOD_106Xv2 (circular with PAT in the same process; see nanoTP_cff.py),
# PAT behaves as UL MiniAODv2 via the run2_miniAOD_UL process modifier.
# usage: makeNanoV15MCLowPUTagAndProbe <das_path or file:...> <name> [nthreads]
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

cmsDriver.py NANO --conditions 106X_mc2017_realistic_v9For2017H_v1 \
    --datatier NANOAODSIM --eventcontent NANOAODSIM \
    --era Run2_2017 --procModifiers run2_miniAOD_UL --geometry DB:Extended \
    --customise Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nanoTP_cff.customizeNANOTPLowPU,PhysicsTools/NanoAOD/nano_cff.nanoGenWmassCustomize \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --mc \
    --scenario pp --step PAT,NANO -n $nevents
