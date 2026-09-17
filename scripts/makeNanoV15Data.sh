#!/bin/bash
# CMSSW_15_0 custom NanoAOD (Data, every Run 2 campaign incl. the 2017H low-PU run).
# Stock NANO on the UL MiniAODv2 + the WMass content (nanoAOD_wmassContent) + the CVH muon refit
# (nanoAOD_addCvhMuon); the 2017H low-PU run instead gets nanoAOD_wmassLowPU
# (HI-menu trigger objects, low-PU DeepMET models) and no refit.
# usage: makeNanoV15Data <das_path or file:/root:...> <name> [nthreads] [campaign]
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
    *) gt=150X_dataRun2_v1 ;;   # the central NanoAODv15 tag for every Run 2 era
esac
customise=Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent
if [[ $campaign == 2017LowPU ]]; then customise=$customise,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassLowPU
else customise=$customise,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuon; fi

cmsDriver.py NANO --conditions $gt \
    --datatier NANOAOD --eventcontent NANOAOD \
    --era $era,run2_nanoAOD_106Xv2 \
    --customise $customise \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --data \
    --scenario pp --step NANO -n $nevents
