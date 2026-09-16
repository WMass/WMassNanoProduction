#!/bin/bash
# CMSSW_15_0 custom NanoAOD (2016 preVFP MC): stock NANO + the WMass content
# (nanoAOD_wmassContent) + the gen customisations (nanoGenWmassCustomize) + the CVH muon refit (nanoAOD_addCvhMuonMC).
# usage: makeNanoV15MCPreVFP <das_path or file:...> <name> [nthreads]
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

cmsDriver.py NANO --conditions 106X_mcRun2_asymptotic_preVFP_v11 \
    --datatier NANOAODSIM --eventcontent NANOAODSIM \
    --era Run2_2016_HIPM,run2_nanoAOD_106Xv2 \
    --customise Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent,PhysicsTools/NanoAOD/nano_cff.nanoGenWmassCustomize,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuonMC \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --mc \
    --scenario pp --step NANO -n $nevents
