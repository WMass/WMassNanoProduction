#!/bin/bash
# CMSSW_15_0 custom NanoAOD (Data, every campaign of scripts/campaign.sh: Run 2,
# the 2017 low-PU runs at 13 and 5.02 TeV, Run 3 incl. the 2024 pp reference and
# the 2025 low-PU run).
# Stock NANO on the campaign's MiniAOD + the WMass content (nanoAOD_wmassContent)
# + the CVH muon refit (nanoAOD_addCvhMuon, every campaign) + the campaign's own
# customise (low PU: HI-menu trigger objects; 2017H also the low-PU DeepMET models).
# usage: makeNanoV15Data <das_path or file:/root:...> <name> [nthreads] [campaign]
#   campaign: see scripts/campaign.sh (default: from the dataset name)
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
era=$(nano_era_of $campaign) || exit 1
gt=$(gt_of $campaign data) || exit 1

config_name=configs/${name}_cfg.py
outfile=${name}.root

customise=Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent
extra=$(campaign_customise $campaign)
[[ -n $extra ]] && customise=$customise,$extra
customise=$customise,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuon

echo "makeNanoV15Data: campaign $campaign, era $era, GT $gt"
cmsDriver.py NANO --conditions $gt \
    --datatier NANOAOD --eventcontent NANOAOD \
    --era $era \
    --customise $customise \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --data \
    --scenario pp --step NANO -n $nevents
