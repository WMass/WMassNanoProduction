#!/bin/bash
# CMSSW_15_0 custom NanoAOD (2017 MC): stock NANO + the WMass content
# (nanoAOD_wmassContent) + the gen customisations (nanoGenWmassCustomize) + the CVH muon refit (nanoAOD_addCvhMuonMC).
# usage: makeNanoV15MC2017 <das_path or file:...> <name> [nthreads]
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

cmsDriver.py NANO --conditions 106X_mc2017_realistic_v9 \
    --datatier NANOAODSIM --eventcontent NANOAODSIM \
    --era Run2_2017,run2_nanoAOD_106Xv2 \
    --customise Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent,PhysicsTools/NanoAOD/nano_cff.nanoGenWmassCustomize,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuonMC \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --mc \
    --scenario pp --step NANO -n $nevents
