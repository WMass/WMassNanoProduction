# Handoff: 2016 postVFP MC, NanoV15_v1.0 (Luca)

Luca, you produce the custom NanoAOD v15 (version `NanoV15_v1.0`) of the 2016 postVFP MiniAOD simulation, in three
phases.
- Your issue: [#28](https://github.com/WMass/WMassNanoProduction/issues/28). The overall status is in
  [#26](https://github.com/WMass/WMassNanoProduction/issues/26).
- Follow the [runbook](README.md); this page lists only what is specific to your part.

Start a phase when the previous one is complete: every task finished, or recovered, and checked (runbook step 6).

All MC goes to `/ceph/submit/data/group/cms/store/group/zmass/NanoAOD/<PD>/NanoV15MCPostVFP_v1p0/`. Each job has 125k
events, about 2.2 h on 4 cores for DY→μμ; samples with fewer muons take less time.

## Setup

Runbook steps 1–2. Post "setup OK" with the `crab checkwrite` result in #28. Then, in every shell:

```sh
OPTS="-v v1p0 --site T3_US_MIT --storage /store/group/zmass/NanoAOD"
```

## Phase 1: Z

```sh
./scripts/prepareCrab.py --makeConfig -i inputs/dyMC_v15.txt $OPTS
./scripts/prepareCrab.py -i inputs/dyMC_v15.txt $OPTS --submit 1 1
```

| dataset | events (DAS) | jobs | on disk at |
|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v3/MINIAODSIM` | 297,324,977 | 2379 | T2_UK_SGrid_RALPP, T1_IT_CNAF_Disk |
| `/DYJetsToTauTau_M-50_AtLeastOneEorMuDecay_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 149,940,115 | 1200 | T2_FR_GRIF, T2_UK_London_IC |
| `/DYJetsToTauTau_M-50_AtLeastOneEorMuDecay_H2ErratumFix_PDF_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v3/MINIAODSIM` | 148,941,820 | 1192 | T2_US_Florida |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 96,424,820 | 772 | T1_US_FNAL_Disk, T1_FR_CCIN2P3_Disk |
| `/DYJetsToMuMu_M-10to50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17_ext1-v2/MINIAODSIM` | 19,999,995 | 160 | T1_ES_PIC_Disk, T1_US_FNAL_Disk |
| `/DYJetsToMuMu_M-10to50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 3,300,000 | 27 | T2_US_Nebraska, T2_DE_RWTH |

This is 716M events, 5730 jobs and about 4.6 TB.

## Phase 2: top and diboson

```sh
./scripts/prepareCrab.py --makeConfig -i inputs/bkgMC.txt $OPTS -m '/(TT|ST_|WW|WZ|ZZ)'
./scripts/prepareCrab.py -i inputs/bkgMC.txt $OPTS -m '/(TT|ST_|WW|WZ|ZZ)' --submit 1 1
```

| dataset | events (DAS) | jobs | on disk at |
|---|---|---|---|
| `/TTToSemiLeptonic_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 144,974,000 | 1160 | T2_US_Wisconsin, T1_FR_CCIN2P3_Disk |
| `/ST_t-channel_top_5f_InclusiveDecays_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 55,783,000 | 447 | T2_DE_DESY, T1_US_FNAL_Disk, T2_US_UCSD |
| `/TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 43,630,000 | 350 | T2_US_Wisconsin, T2_IT_Pisa |
| `/ST_t-channel_antitop_5f_InclusiveDecays_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 29,394,000 | 236 | T1_US_FNAL_Disk, T2_US_Florida |
| `/WWTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 19,976,139 | 160 | T2_US_Wisconsin |
| `/ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 15,928,000 | 128 | T2_IT_Pisa, T2_US_Wisconsin |
| `/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 13,740,600 | 110 | T2_BE_UCL, T2_US_MIT, T2_FR_IPHC |
| `/WZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 13,526,954 | 109 | T1_US_FNAL_Disk, T2_ES_CIEMAT |
| `/WZTo3LNu_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 10,441,724 | 84 | T1_US_FNAL_Disk, T1_FR_CCIN2P3_Disk |
| `/ST_s-channel_4f_leptonDecays_TuneCP5_13TeV-amcatnlo-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 5,471,000 | 44 | T2_US_Nebraska, T1_US_FNAL_Disk, T2_UK_London_Brunel |
| `/WZTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 3,690,271 | 30 | T2_DE_DESY |
| `/ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 3,654,510 | 30 | T1_DE_KIT_Disk, T2_US_Nebraska, T2_BE_UCL |
| `/ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 3,368,375 | 27 | T2_US_Nebraska, T2_UK_London_Brunel, T2_IT_Bari, T1_FR_CCIN2P3_Disk |
| `/WWTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v1/MINIAODSIM` | 2,900,000 | 24 | T2_CH_CERN, T1_US_FNAL_Disk, T2_FR_IPHC |

This is 366M events, 2939 jobs and about 2.3 TB.

## Phase 3: W and the other backgrounds

```sh
./scripts/prepareCrab.py --makeConfig -i inputs/wMC_v15.txt $OPTS
./scripts/prepareCrab.py -i inputs/wMC_v15.txt $OPTS --submit 1 1
./scripts/prepareCrab.py --makeConfig -i inputs/bkgMC.txt $OPTS -m '/(QCD|GGTo|QGTo)'
./scripts/prepareCrab.py -i inputs/bkgMC.txt $OPTS -m '/(QCD|GGTo|QGTo)' --submit 1 1
```

W (`inputs/wMC_v15.txt`): 2.62B events, 20982 jobs, about 16.7 TB.
- This is the largest part. Several datasets are on disk at a single site, so their jobs may wait there. Ask in #28
  before using `--ignoreLocality`.
- The largest task, W+→μν PDFExt, has 7164 jobs; CRAB's limit is 10000.

| dataset | events (DAS) | jobs | on disk at |
|---|---|---|---|
| `/WplusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 895,389,656 | 7164 | T1_US_FNAL_Disk |
| `/WminusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 656,366,999 | 5251 | T2_IT_Legnaro |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 297,006,993 | 2377 | T1_FR_CCIN2P3_Disk, T1_ES_PIC_Disk |
| `/WplusJetsToTauNu_TauToMu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 249,750,517 | 1999 | T1_IT_CNAF_Disk |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 219,574,999 | 1757 | T2_BE_IIHE |
| `/WplusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 164,953,886 | 1320 | T2_DE_DESY |
| `/WminusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 104,298,567 | 835 | T2_UK_London_IC |
| `/WminusJetsToTauNu_TauToMu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 34,767,637 | 279 | T1_FR_CCIN2P3_Disk |

Other backgrounds (`inputs/bkgMC.txt`, QCD μ-enriched, γγ→ℓℓ, qg→Wq, qg→DYq): 273M events, 2189 jobs, about 1.7 TB.

| dataset | events (DAS) | jobs | on disk at |
|---|---|---|---|
| `/QCD_Pt-20_MuEnrichedPt15_TuneCP5_13TeV-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17_ext2-v2/MINIAODSIM` | 212,511,764 | 1701 | T1_DE_KIT_Disk, T2_CH_CERN |
| `/QCD_Pt-20_MuEnrichedPt15_TuneCP5_13TeV-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17_ext1-v2/MINIAODSIM` | 40,584,743 | 325 | T1_FR_CCIN2P3_Disk |
| `/GGToLL_M-5To50_TuneCP5_13TeV-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 8,943,660 | 72 | T1_FR_CCIN2P3_Disk |
| `/QCD_Pt-20_MuEnrichedPt15_TuneCP5_13TeV-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 8,884,250 | 72 | T1_US_FNAL_Disk |
| `/GGToLL_TuneCP5_13TeV-pythia8/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 1,200,000 | 10 | T2_BE_UCL |
| `/QGToWQToLNu_TuneCP5_13TeV-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 1,000,000 | 8 | T2_DE_RWTH |
| `/QGToDYQTo2L_TuneCP5_13TeV-pythia8-photos/RunIISummer20UL16MiniAODv2-106X_mcRun2_asymptotic_v17-v2/MINIAODSIM` | 100,000 | 1 | T2_UK_SGrid_RALPP |

## For every phase

- Check the submit files before submitting. Each must show `EventAwareLumiBased`, `125000`,
  `/store/group/zmass/NanoAOD`, `NanoV15MCPostVFP_v1p0` and `T3_US_MIT`.
- Post the task names in #28.
- Monitor and recover with runbook steps 4–5. For MC recoveries, use `unitsPerJob = 30` lumis.
- At completion, run the checks of runbook step 6 (the events read must equal the DAS numbers above) and report as in
  step 7.
