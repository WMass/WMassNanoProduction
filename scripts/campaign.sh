# Shared by the makeNanoV15*.sh scripts and prepareCrab.py: the one table of the
# production campaigns -- detection from the dataset name, era, global tag,
# campaign-specific customise and label.
#
# Run 2 global tags: those of the central NanoAODv15 production (150X_*; the
# conditions the CVH refit depends on -- tracker alignment, APE, field, CPEs,
# templates, Lorentz angles, beam spot -- are identical to the UL 106X tags,
# checked with conddb). Run 3: the central NanoAODv15 tags (2022-2024 MC from
# the central requests; data 150X_dataRun3_v6 = v5 + newer JECs, offline
# alignment through 2026).
#
# campaigns:
#   Run 2: 2016preVFP 2016postVFP 2017 2018
#          2017LowPU      (2017H, 13 TeV, low pileup)
#          2017LowPU5TeV  (2017G, 5.02 TeV pp reference)
#   Run 3: 2022 2022EE 2023 2023BPix 2024 2025
#          2024ppRef      (2024J, 5.36 TeV pp reference)
#          2025LowPU      (13.6 TeV low-pileup fills of 2025; same PDs as 2025,
#                          select it with the 4th script argument / --campaign)

# campaign_from_input <das path or file/root URL>
campaign_from_input() {
    case "$1" in
        *pp5TeV*|*/Run2017G[-/]*)                    echo 2017LowPU5TeV ;;
        *RunIILowPU*|*/Run2017H[-/]*)                echo 2017LowPU ;;
        *UL16*APV*|*HIPM*)                        echo 2016preVFP ;;
        *UL16*|*UL2016*)                          echo 2016postVFP ;;
        *UL17*|*UL2017*)                          echo 2017 ;;
        *UL18*|*UL2018*)                          echo 2018 ;;
        *pp5p36*|*PPRef*|*/Run2024J[-/]*)            echo 2024ppRef ;;
        *Run3Summer22EE*|*/Run2022[EFG][-/]*)        echo 2022EE ;;
        *Run3Summer22*|*/Run2022[CD][-/]*)           echo 2022 ;;
        *Run3Summer23BPix*|*/Run2023D[-/]*)          echo 2023BPix ;;
        *Run3Summer23*|*/Run2023[BC][-/]*)           echo 2023 ;;
        *RunIII2024*|*/Run2024[A-I][-/]*)            echo 2024 ;;
        *RunIII2025*|*Run3Summer25*|*Run3Winter25*|*/Run2025*) echo 2025 ;;
        *) echo "campaign_from_input: cannot tell the campaign from '$1'; pass it explicitly" >&2; return 1 ;;
    esac
}

# era_of <campaign>: the Configuration.Eras era (used as is by the tag-and-probe nano)
era_of() {
    case "$1" in
        2016preVFP)  echo Run2_2016_HIPM ;;
        2016postVFP) echo Run2_2016 ;;
        2017|2017LowPU|2017LowPU5TeV) echo Run2_2017 ;;
        2018)        echo Run2_2018 ;;
        2022|2022EE) echo Run3 ;;
        2023|2023BPix) echo Run3_2023 ;;
        2024|2024ppRef) echo Run3_2024 ;;
        2025|2025LowPU) echo Run3_2025 ;;
        *) echo "era_of: unknown campaign '$1'" >&2; return 1 ;;
    esac
}

# nano_era_of <campaign>: era + NANO modifier for NANO on the campaign's MiniAOD
#   Run 2 UL MiniAODv2: run2_nanoAOD_106Xv2; Run 3 MiniAOD made before 14_2
#   (2022/2023 MiniAODv4, 2024: the 14_0 PromptReco / 2024CDEReprocessing data and
#   the 140X Summer24 MC, 2024J PromptReco in 14_1): run3_nanoAOD_pre142X;
#   2025 (15_0 PromptReco): none (Run3_2025 already contains run3_nanoAOD_2025).
#   The 15_0 MiniAODv6 of 2024 is NOT used: its muon strip clusters are empty.
nano_era_of() {
    local era; era=$(era_of "$1") || return 1
    case "$1" in
        2016*|2017*|2018) echo $era,run2_nanoAOD_106Xv2 ;;
        2022|2022EE|2023|2023BPix|2024|2024ppRef) echo $era,run3_nanoAOD_pre142X ;;
        *) echo $era ;;
    esac
}

# gt_of <campaign> <data|mc>
gt_of() {
    local c=$1 kind=$2
    if [[ $kind == data ]]; then
        case $c in
            2016*|2017*|2018) echo 150X_dataRun2_v1 ;;
            *) echo 150X_dataRun3_v6 ;;
        esac
        return
    fi
    case $c in
        2016preVFP)    echo 150X_mcRun2_asymptotic_preVFP_v1 ;;
        2016postVFP)   echo 150X_mcRun2_asymptotic_v1 ;;
        2017|2017LowPU) echo 150X_mc2017_realistic_v1 ;;   # no central low-PU v15 campaign: the 2017 MC tag
        # 5.02 TeV MC: its own 106X tag. Against 150X_mc2017_realistic_v1 (checked on the same
        # 578 events): identical tracking/CVH/muon/trigger-object/DeepMET output, but the 150X
        # tag carries the 13 TeV 2017 L1 menu (wrong L1_* names) and newer JER (PuppiMET cov)
        2017LowPU5TeV) echo 106X_mc2017_realistic_forppRef5TeV_v3 ;;
        2018)          echo 150X_mc2018_realistic_v1 ;;
        2022)          echo 150X_mcRun3_2022_realistic_v1 ;;
        2022EE)        echo 150X_mcRun3_2022_realistic_postEE_v1 ;;
        2023)          echo 150X_mcRun3_2023_realistic_v1 ;;
        2023BPix)      echo 150X_mcRun3_2023_realistic_postBPix_v1 ;;
        2024)          echo 150X_mcRun3_2024_realistic_v2 ;;
        2024ppRef)     echo 141X_mcRun3_2024_realistic_ppRef5TeV_v7 ;;   # the tag of the RunIIIpp5p36Winter24 MC; no 150X version
        2025|2025LowPU) echo 150X_mcRun3_2025_realistic_v3 ;;
        *) echo "gt_of: unknown campaign '$c'" >&2; return 1 ;;
    esac
}

# campaign_customise <campaign>: customise functions specific to the campaign
# (on top of the W-mass content and the CVH refit, which every campaign gets)
campaign_customise() {
    case "$1" in
        2017LowPU)     echo PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassLowPU ;;
        2017LowPU5TeV) echo PhysicsTools/NanoAOD/nano_cff.nanoAOD_wmassLowPU5TeV ;;
        *) echo "" ;;
    esac
}

# label_of <campaign>: the label in the output dataset names (MC<label>, Data<label>)
label_of() {
    case "$1" in
        2016preVFP)    echo PreVFP ;;
        2016postVFP)   echo PostVFP ;;
        2017LowPU)     echo LowPU ;;
        2017LowPU5TeV) echo LowPU5TeV ;;
        2024ppRef)     echo 2024PPRef ;;
        *)             echo $1 ;;
    esac
}

# run_range_of <campaign>: the run range a campaign is restricted to when it shares
# its datasets with another one (empty: the whole dataset)
run_range_of() {
    case "$1" in
        # the certified 13.6 TeV low-pileup physics runs of 2025 (Run2025G, mu ~ 7,
        # ~71.5 pb^-1): 398682, 398683, 398803; the July 2025 mu ~ 0.7 fills were
        # van der Meer scans (zero-bias menu only)
        2025LowPU) echo "398682-398803" ;;
        *) echo "" ;;
    esac
}

# lumi_mask_of <campaign>: the CRAB lumi mask a campaign must be restricted to (empty: none)
lumi_mask_of() {
    case "$1" in
        2025LowPU) echo /cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions25/latest/2025_lowPU_updated.json ;;
        *) echo "" ;;
    esac
}

# Per-sample fixes on top of the campaign (MC only).
#
# Beamspot of RunIILowPUSummer20UL17 (2017H, 13 TeV low PU): the POWHEG-MiNNLO W/Z,
# ttbar and single-top samples were generated with the 2018 vertex smearing
# (Realistic25ns13TeVEarly2018Collision, McM wmLHEGS requests) but reconstructed with
# the 2017 MC beamspot of 106X_mc2017_realistic_v9For2017H_v1, so the offlineBeamSpot
# of their MiniAOD/AOD is ~450 um off the collisions (measured genParticles:xyz0 -
# offlineBeamSpot = +356, -276 um) and every beamspot-constrained quantity is biased
# (CVH dimuon mass -1.9%). The nano re-makes offlineBeamSpot from the 2018 MC beamspot
# tag for them (nano_cff.nanoAOD_beamSpotEarly2018MC). The pomflux and MinBias samples
# of the campaign were generated with the 2017 smearing and are consistent (< 2 um).
# The upstream primary vertices of the affected samples stay degraded.
_lowPUBeamSpot2018=(
    DYJetsToMuMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    DYJetsToEE_M-50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    WplusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    WminusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    WplusJetsToENu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    WminusJetsToENu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    WplusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    WminusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos
    TTTo2L2Nu_TuneCP5_lowPU_13TeV-powheg-pythia8
    TTToSemiLeptonic_TuneCP5_lowPU_13TeV-powheg-pythia8
    TTToHadronic_TuneCP5_lowPU_13TeV-powheg-pythia8
    ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_lowPU_13TeV-powheg-pythia8
    ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_lowPU_13TeV-powheg-pythia8
    TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8
    ST_t-channel_antitop_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8
)
_isLowPUBeamSpot2018() {
    [[ $1 == *RunIILowPUSummer20UL17* ]] || return 1
    local pd
    for pd in "${_lowPUBeamSpot2018[@]}"; do
        [[ $1 == */$pd/* ]] && return 0
    done
    return 1
}

# sample_customise <das path or file/root URL>: customise of the sample's per-sample fix (empty: none)
sample_customise() {
    if _isLowPUBeamSpot2018 "$1"; then
        echo PhysicsTools/NanoAOD/nano_cff.nanoAOD_beamSpotEarly2018MC
    fi
}

# sample_tag <das path or file/root URL>: tag of the sample's per-sample fix in the config name (empty: none)
sample_tag() {
    if _isLowPUBeamSpot2018 "$1"; then
        echo BS2018
    fi
}

# allow `bash campaign.sh <function> <args>` (used by prepareCrab.py)
if [[ "${BASH_SOURCE[0]}" == "$0" && $# -gt 0 ]]; then
    "$@"
fi
