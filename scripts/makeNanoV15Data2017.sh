#!/bin/bash
# CMSSW_15_0 custom NanoAOD (2017 data): stock NANO + the WMass content
# (nanoAOD_wmassContent) + the CVH muon refit (nanoAOD_addCvhMuon).
# usage: makeNanoV15Data2017 <das_path or file:...> <name> [nthreads]
if [[ $# -lt 2 ]]; then
    echo "usage: $0 <das_path or file:path> <name> [nthreads]"
    exit 1
fi

input=$1
if [[ "$input" != file:* ]]; then
    input=dbs:$input
fi
nevents=1000
name=$2
nThreads=${3:-4}

config_name=configs/${name}_cfg.py
outfile=${name}.root

cmsDriver.py NANO --conditions 106X_dataRun2_v35 \
    --datatier NANOAOD --eventcontent NANOAOD \
    --era Run2_2017,run2_nanoAOD_106Xv2 \
    --customise Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuon \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --data \
    --scenario pp --step NANO -n $nevents
