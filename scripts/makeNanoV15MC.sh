#!/bin/bash
# CMSSW_15_0 custom NanoAOD (MC, every Run 2 campaign incl. the 2017H low-PU run).
# Stock NANO on the UL MiniAODv2 + the WMass content (nanoAOD_wmassContent)
# + the gen customisations (nanoGenWmassCustomize) + the CVH muon refit
# (nanoAOD_addCvhMuonMC); the 2017H low-PU run instead gets nanoAOD_wmassLowPU
# (HI-menu trigger objects, low-PU DeepMET models) and no refit.
# usage: makeNanoV15MC <das_path or file:/root:...> <name> [nthreads] [campaign]
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
    2016preVFP)  gt=106X_mcRun2_asymptotic_preVFP_v11 ;;
    2016postVFP) gt=106X_mcRun2_asymptotic_v17 ;;
    2017)        gt=106X_mc2017_realistic_v9 ;;
    2018)        gt=106X_upgrade2018_realistic_v16_L1v1 ;;
    2017LowPU)   gt=106X_mc2017_realistic_v9For2017H_v1 ;;
esac
customise=Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent,PhysicsTools/NanoAOD/nano_cff.nanoGenWmassCustomize
if [[ $campaign == 2017LowPU ]]; then customise=$customise,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassLowPU
else customise=$customise,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuonMC; fi

cmsDriver.py NANO --conditions $gt \
    --datatier NANOAODSIM --eventcontent NANOAODSIM \
    --era $era,run2_nanoAOD_106Xv2 \
    --customise $customise \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --mc \
    --scenario pp --step NANO -n $nevents
