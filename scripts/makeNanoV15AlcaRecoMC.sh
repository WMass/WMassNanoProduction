#!/bin/bash
# CMSSW_15_0 AlCaReco NanoAOD (MC, Run 2 campaigns): the CVH single-track refit of the
# W-mass nano on the muon tracks of a tracker-alignment AlCaReco (TkAlJpsiMuMu,
# TkAlUpsilonMuMu), with the Muon columns of the W-mass nano that a track determines
# (PhysicsTools/NanoAOD/alcareco_nano_cff.py). The NANO step runs its alcarecoNanoSequence
# instead of the stock nano (alcarecoNanoSequenceMC: also the ideal-geometry refit, the gen
# match and the gen tables); nanoAOD_alcareco<skim> selects the skim's tracks. The refit of
# MC keeps the default field, the field of the simulation, as in the W-mass nano.
# usage: makeNanoV15AlcaRecoMC <das_path or file:/root:...> <name> [nthreads] [campaign]
#   campaign: see scripts/campaign.sh (default: from the dataset name)
#   the skim comes from the dataset name or file path (scripts/campaign.sh alcareco_skim_of)
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
case $campaign in
    2016*|2017|2018) ;;
    *) echo "makeNanoV15AlcaRecoMC: the AlCaReco nano is set up for the Run 2 campaigns 2016preVFP, 2016postVFP, 2017, 2018, not $campaign" >&2; exit 1 ;;
esac
era=$(nano_era_of $campaign) || exit 1
gt=$(gt_of $campaign mc) || exit 1
skim=$(alcareco_skim_of "$1") || exit 1

config_name=configs/${name}_cfg.py
outfile=${name}.root

echo "makeNanoV15AlcaRecoMC: campaign $campaign, era $era, GT $gt, skim $skim"
cmsDriver.py NANO --conditions $gt \
    --datatier NANOAODSIM --eventcontent NANOAODSIM \
    --era $era \
    --step NANO:PhysicsTools/NanoAOD/alcareco_nano_cff.alcarecoNanoSequenceMC \
    --customise Configuration/DataProcessing/Utils.addMonitoring,PhysicsTools/NanoAOD/alcareco_nano_cff.nanoAOD_alcareco$skim \
    --filein $input --fileout file:$outfile --nThreads $nThreads --no_exec \
    --python_filename $config_name --mc \
    --scenario pp -n $nevents
