#!/bin/bash
# CMSSW_15_0 custom NanoAOD (MC, every campaign of scripts/campaign.sh: Run 2,
# the 2017 low-PU runs at 13 and 5.02 TeV, Run 3 incl. the 2024 pp reference and
# the 2025 low-PU run).
# Stock NANO on the campaign's MiniAOD + the WMass content (nanoAOD_wmassContent)
# + the gen customisations (nanoGenWmassCustomize) + the CVH muon refit
# (nanoAOD_addCvhMuonMC, every campaign, with the pixel edge / single-column
# hits and their class corrections: nanoAOD_cvhPixelClassHits) + the campaign's own customise
# (low PU: HI-menu trigger objects; 2017H also the low-PU DeepMET models).
# + the sample's own fix, if any (scripts/campaign.sh sample_customise: the beamspot of
# the RunIILowPUSummer20UL17 samples generated with the 2018 vertex smearing).
# usage: makeNanoV15MC <das_path or file:/root:...> <name> [nthreads] [campaign]
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
gt=$(gt_of $campaign mc) || exit 1

config_name=configs/${name}_cfg.py
outfile=${name}.root

customise=Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassContent,PhysicsTools/NanoAOD/nano_cff.nanoGenWmassCustomize
extra=$(campaign_customise $campaign)
[[ -n $extra ]] && customise=$customise,$extra
customise=$customise,PhysicsTools/NanoAOD/nano_cff.nanoAOD_addCvhMuonMC,PhysicsTools/NanoAOD/nano_cff.nanoAOD_cvhPixelClassHits
fix=$(sample_customise "$1")
[[ -n $fix ]] && customise=$customise,$fix

echo "makeNanoV15MC: campaign $campaign, era $era, GT $gt${fix:+, sample fix $fix}"
cmsDriver.py NANO --conditions $gt \
    --datatier NANOAODSIM --eventcontent NANOAODSIM \
    --era $era \
    --customise $customise \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --mc \
    --scenario pp --step NANO -n $nevents
