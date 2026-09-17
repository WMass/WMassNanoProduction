# Shared by the makeNanoV15*.sh scripts: campaign detection from the dataset
# name and the era of each campaign. The global tags (in the four scripts) are
# the ones of the central NanoAODv15 production (150X_*; the conditions the CVH
# refit depends on -- tracker alignment, APE, field, CPEs, templates, Lorentz
# angles, beam spot -- are identical to the UL 106X tags, checked with conddb).
#
# campaign_from_input <das path or file/root URL>
#   -> 2016preVFP | 2016postVFP | 2017 | 2018 | 2017LowPU
campaign_from_input() {
    case "$1" in
        *RunIILowPU*|*Run2017H-*) echo 2017LowPU ;;
        *UL16*APV*|*HIPM*)        echo 2016preVFP ;;
        *UL16*|*UL2016*)          echo 2016postVFP ;;
        *UL17*|*UL2017*)          echo 2017 ;;
        *UL18*|*UL2018*)          echo 2018 ;;
        *) echo "campaign_from_input: cannot tell the campaign from '$1'; pass it as the 4th argument" >&2; return 1 ;;
    esac
}

# era_of <campaign>: the Configuration.Eras era of the campaign
era_of() {
    case "$1" in
        2016preVFP)  echo Run2_2016_HIPM ;;
        2016postVFP) echo Run2_2016 ;;
        2017|2017LowPU) echo Run2_2017 ;;
        2018)        echo Run2_2018 ;;
    esac
}
