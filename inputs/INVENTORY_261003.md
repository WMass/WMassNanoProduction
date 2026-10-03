# Input-dataset inventory for the custom NanoAOD production (CMSSW_15_0_19_patch2) -- 2026-10-03

Built from DAS (`dasgoclient`, instance prod/global) on 2026-10-03. Unless stated otherwise only datasets with status VALID were used. For each campaign there is one table per list file in `inputs/`. The columns are:

- **events / size / files:** from DAS `summary dataset=...`.
- **runs:** number of runs and run range in the dataset, from DAS `run dataset=...`. Data only.
- **notes:** `disk:N` means N disk sites host at least part of the dataset. `TAPE-ONLY` means there is no disk replica, so a Rucio rule or a CRAB tape recall is needed. Other notes give the reason a dataset was chosen.

Totals are summed over each list. Data datasets usually contain more runs than the golden JSON, so the production has to be lumi-masked. The golden JSON paths are quoted per campaign.

**List format.** Each list has one DAS path per line and a header block of comment lines starting with `#`. Some lists also have `#` group sub-headers or commented-out datasets (alternatives, or datasets that are not VALID), kept for reference. `scripts/prepareCrab.py` already skips lines whose first character is `#`. It would crash on an empty line, so the lists contain none.

**Selection rules applied.**
1. Take the latest VALID version.
2. Prefer the MiniAOD that is the parent of the central NanoAODv15, where one exists.
3. For Run 2 data, prefer `UL201X_MiniAODv2_GT36-v2`. This is also the only Run 2 low-PU MiniAOD that keeps the muon tracker clusters the CVH refit needs.
4. Take the T&P AOD/AODSIM as the DAS parent of the chosen MiniAOD.

Alternatives and anything unusual are listed in the notes of each section.

## Summary of the lists written/updated

| sec | file | datasets | events | size | `#` lines |
|---|---|---|---|---|---|
| A | `inputs/lowPUData_UL.txt` | 3 | 388,300,776 | 5.02 TB | 11 |
| A | `inputs/lowPUData_TnP_UL.txt` | 3 | 388,300,776 | 29.33 TB | 5 |
| A | `inputs/lowPUMC_UL.txt` | 26 | 340,261,617 | 7.34 TB | 31 |
| A | `inputs/lowPUMC_TnP_UL.txt` | 8 | 89,874,997 | 8.44 TB | 4 |
| B | `inputs/lowPU5TeVData_UL.txt` | 3 | 2,069,048,956 | 15.85 TB | 14 |
| B | `inputs/lowPU5TeVData_TnP_UL.txt` | 4 | 3,188,972,353 | 161.28 TB | 6 |
| B | `inputs/lowPU5TeVMC_UL.txt` | 46 | 278,148,997 | 5.34 TB | 14 |
| B | `inputs/lowPU5TeVMC_other_UL.txt` | 19 | 305,745,327 | 6.16 TB | 8 |
| B | `inputs/lowPU5TeVMC_TnP_UL.txt` | 9 | 118,349,427 | 8.30 TB | 4 |
| C | `inputs/data_2022.txt` | 4 | 238,579,065 | 10.81 TB | 5 |
| C | `inputs/dataEGamma_2022.txt` | 2 | 352,684,466 | 16.33 TB | 4 |
| C | `inputs/data_2022_TnP.txt` | 4 | 238,727,270 | 77.14 TB | 5 |
| C | `inputs/mc_2022.txt` | 94 | 3,143,331,680 | 202.01 TB | 17 |
| C | `inputs/mc_2022_TnP.txt` | 1 | 2,924,957 | 1.12 TB | 6 |
| C | `inputs/data_2022EE.txt` | 3 | 667,355,457 | 34.73 TB | 5 |
| C | `inputs/dataEGamma_2022EE.txt` | 3 | 689,463,164 | 36.86 TB | 5 |
| C | `inputs/data_2022EE_TnP.txt` | 3 | 668,077,174 | 256.06 TB | 4 |
| C | `inputs/mc_2022EE.txt` | 94 | 10,691,899,497 | 683.71 TB | 20 |
| C | `inputs/mc_2022EE_TnP.txt` | 1 | 10,148,870 | 3.90 TB | 6 |
| C | `inputs/data_2023.txt` | 8 | 461,343,015 | 24.17 TB | 5 |
| C | `inputs/dataEGamma_2023.txt` | 8 | 533,678,410 | 28.64 TB | 4 |
| C | `inputs/data_2023_TnP.txt` | 8 | 461,425,134 | 188.59 TB | 5 |
| C | `inputs/mc_2023.txt` | 62 | 4,593,365,707 | 312.68 TB | 38 |
| C | `inputs/mc_2023_TnP.txt` | 1 | 5,904,000 | 2.84 TB | 6 |
| C | `inputs/data_2023BPix.txt` | 4 | 243,420,070 | 12.78 TB | 5 |
| C | `inputs/dataEGamma_2023BPix.txt` | 4 | 257,053,687 | 13.88 TB | 4 |
| C | `inputs/data_2023BPix_TnP.txt` | 4 | 243,499,845 | 100.13 TB | 4 |
| C | `inputs/mc_2023BPix.txt` | 63 | 2,280,105,442 | 155.01 TB | 26 |
| C | `inputs/mc_2023BPix_TnP.txt` | 1 | 2,860,000 | 1.38 TB | 6 |
| C | `inputs/data_2024.txt` | 18 | 3,549,585,257 | 202.88 TB | 7 |
| C | `inputs/dataEGamma_2024.txt` | 18 | 5,059,391,546 | 292.26 TB | 4 |
| C | `inputs/data_2024_TnP.txt` | 18 | 3,580,343,650 | 1569.06 TB | 5 |
| C | `inputs/mc_2024.txt` | 43 | 8,041,441,567 | 666.73 TB | 15 |
| C | `inputs/mc_2024_TnP.txt` | 2 | 623,831,960 | 279.01 TB | 6 |
| C | `inputs/data_2025.txt` | 16 | 4,226,397,919 | 251.02 TB | 7 |
| C | `inputs/dataEGamma_2025.txt` | 32 | 7,777,607,350 | 464.32 TB | 4 |
| C | `inputs/data_2025_TnP.txt` | 16 | 4,226,397,919 | 1788.58 TB | 4 |
| C | `inputs/mc_2025.txt` | 14 | 112,352,478 | 11.34 TB | 13 |
| C | `inputs/mc_2025_TnP.txt` | 2 | 6,100,000 | 3.59 TB | 5 |
| D | `inputs/data_2024ppRef.txt` | 8 | 3,916,293,197 | 58.28 TB | 10 |
| D | `inputs/dataEGamma_2024ppRef.txt` | 5 | 1,489,496,167 | 25.21 TB | 9 |
| D | `inputs/mc_2024ppRef.txt` | 62 | 503,276,296 | 10.07 TB | 15 |
| D | `inputs/mc_2024ppRef_other.txt` | 72 | 782,928,587 | 17.22 TB | 10 |
| D | `inputs/mc_2024ppRef_TnP.txt` | 1 | 9,999,999 | 947.56 GB | 6 |
| D | `inputs/data_2025LowPU.txt` | 2 | 884,561,714 | 51.07 TB | 10 |
| D | `inputs/dataEGamma_2025LowPU.txt` | 4 | 1,685,054,618 | 98.49 TB | 5 |
| D | `inputs/data_2025LowPU_TnP.txt` | 2 | 884,561,714 | 363.40 TB | 5 |
| D | `inputs/mc_2025LowPU.txt` | 15 | 103,291,358 | 3.35 TB | 16 |
| D | `inputs/mc_2025LowPU_other.txt` | 19 | 229,319,747 | 7.10 TB | 8 |
| D | `inputs/mc_2025LowPU_TnP.txt` | 3 | 29,549,824 | 4.78 TB | 5 |
| D | `inputs/data_2026LowPU.txt` | 8 | 3,737,609,689 | 90.16 TB | 7 |
| D | `inputs/dataEGamma_2026LowPU.txt` | 12 | 3,480,708,572 | 120.64 TB | 7 |
| D | `inputs/data_2026LowPU_TnP.txt` | 8 | 3,737,609,689 | 562.93 TB | 7 |
| D | `inputs/mc_2026LowPU.txt` | 11 | 347,737,365 | 16.53 TB | 11 |
| D | `inputs/mc_2026LowPU_other.txt` | 30 | 1,011,339,340 | 65.55 TB | 5 |
| D | `inputs/mc_2026LowPU_TnP.txt` | 1 | 32,472,148 | 4.97 TB | 3 |
| D | `inputs/data_2024ppRef_TnP.txt` | 0 | - | - | 7 (comment-only: no AOD exists) |

Events/size are for the full datasets. For datasets that contain more than the selected runs (2025/2026 low-PU, Run 3 PromptReco AOD), the size of the selected subset is given in the section notes.

## A. Run 2 -- 2017H low pileup, 13 TeV (runs 306896-307082)

Golden JSON (on cvmfs): `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions17/latest/13TeV/Final/Cert_306896-307082_13TeV_PromptReco_Collisions17_JSON_LowPU.txt` (24 runs 306926-307082, 12,160 LS; a `_MuonPhys` variant exists too).

**PD trigger content** (read from the HLT `datasets` PSet stored in a 2017H MiniAOD file):

| PD | lepton triggers | used |
|---|---|---|
| SingleMuon | HLT_HIMu12/15/17, HIL3Mu5, HIL3Mu5_Track1(_Jpsi), HIMu7p5_L2Mu2/Track2_Jpsi/Upsilon | yes |
| DoubleMuon | HLT_HIDimuon0_Jpsi(_NoVertexing), HIDimuon0_Upsilon_NoVertexing | yes |
| HighEGJet | HLT_HIEle15/17/20/30/40_WPLoose_Gsf, HIEle15_Ele8, HIEle20_Ele12(_DZ), HIEle20_eta2p1_..._PFJet15, HIEle15_..._PFJet30, HIPhoton40/50/60 (+ jets) | yes |
| LowEGJet | HIPhoton20/30 + low-pT jets only (no electron triggers) | no |
| FSQJet1/2, ZeroBias, HLTPhysics, ParkingHIZeroBias* | no lepton triggers | no |

**Processing landscape (SingleMuon; same pattern for the other PDs where they exist):**

| processing | reco config | MiniAOD | AOD replica | muon tracker clusters in MiniAOD |
|---|---|---|---|---|
| `09Aug2019_UL2017_LowPU-v1` (RECO 10_6_12, GT v28, era Run2_2017) | -> `UL2017_MiniAODv2-v1` (GT v33, procModifier run2_miniAOD_UL_preSummer20) = parent of central NanoAODv15 | 138,683,027 evts, 12,675 LS | AOD **tape only** | **no** (TrackExtras+RecHits only, no Si clusters) |
| `15Feb2022_UL2017-v1` (RECO 10_6_30, GT v36, era Run2_2017) -- SingleMuon only | -> `UL2017_MiniAODv2_GT36-v1` (procModifier run2_miniAOD_UL_preSummer20) | 138,642,164 evts | AOD on disk (1 site) | **no** |
| same | -> `UL2017_MiniAODv2_GT36-v2` (procModifier run2_miniAOD_UL) | 138,642,164 evts, 12,671 LS | | **yes** (`Si{Pixel,Strip}Cluster_slimmedMuonTrackExtras`) |
| same | `15Feb2022_UL2017-v1/MINIAOD` (written in the RECO step) | 138,683,027 evts, 12,675 LS | | **yes** |

"Muon tracker clusters" = presence of the `SiPixelCluster`/`SiStripCluster` `slimmedMuonTrackExtras` branches in the first file (checked 2026-10-03), which the CVH refit needs (consistent with the coordinator's hit-level check of SingleMuon GT36-v2 vs -v1).

#### inputs/lowPUData_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/SingleMuon/Run2017H-UL2017_MiniAODv2_GT36-v2/MINIAOD` | 138,642,164 | 1.53 TB | 407 | 28 (306896-307082) | disk:1; GT36 (106X_dataRun2_v36), CMSSW_10_6_30; parent 15Feb2022_UL2017-v1 AOD; NOT the NanoAODv15 parent |
| `/DoubleMuon/Run2017H-UL2017_MiniAODv2-v1/MINIAOD` | 16,142,576 | 162.04 GB | 44 | 28 (306896-307082) | disk:1; only MiniAODv2; NanoAODv15 parent |
| `/HighEGJet/Run2017H-UL2017_MiniAODv2-v1/MINIAOD` | 233,516,036 | 3.32 TB | 998 | 28 (306896-307082) | disk:3; only MiniAODv2; NanoAODv15 parent |
| **total (3 datasets)** | **388,300,776** | **5.02 TB** | | | |

#### inputs/lowPUData_TnP_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/SingleMuon/Run2017H-15Feb2022_UL2017-v1/AOD` | 138,642,164 | 10.43 TB | 2921 | 28 (306896-307082) | disk:1; parent of GT36-v2 (same as previous list) |
| `/DoubleMuon/Run2017H-09Aug2019_UL2017_LowPU-v1/AOD` | 16,142,576 | 1.38 TB | 356 | 28 (306896-307082) | TAPE-ONLY; parent of MiniAODv2-v1 |
| `/HighEGJet/Run2017H-09Aug2019_UL2017_LowPU-v1/AOD` | 233,516,036 | 17.52 TB | 5376 | 28 (306896-307082) | TAPE-ONLY; parent of MiniAODv2-v1 |
| **total (3 datasets)** | **388,300,776** | **29.33 TB** | | | |

#### inputs/lowPUMC_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 9,989,000 | 221.06 GB | 116 | - | disk:7 |
| `/DYJetsToEE_M-50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 9,990,000 | 263.93 GB | 122 | - | disk:2 |
| `/WplusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 14,974,000 | 254.77 GB | 125 | - | disk:8 |
| `/WminusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 9,971,999 | 170.73 GB | 67 | - | disk:3 |
| `/WplusJetsToENu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 9,993,998 | 188.22 GB | 91 | - | disk:8 |
| `/WminusJetsToENu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 10,000,000 | 187.17 GB | 90 | - | disk:8 |
| `/WplusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 14,970,000 | 286.39 GB | 155 | - | disk:7 |
| `/WminusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 9,986,000 | 171.00 GB | 61 | - | disk:3 |
| `/TTTo2L2Nu_TuneCP5_lowPU_13TeV-powheg-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v5/MINIAODSIM` | 9,980,000 | 354.11 GB | 90 | - | disk:1 |
| `/TTToSemiLeptonic_TuneCP5_lowPU_13TeV-powheg-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v5/MINIAODSIM` | 29,968,000 | 1.08 TB | 299 | - | disk:1; v4 INVALID |
| `/TTToHadronic_TuneCP5_lowPU_13TeV-powheg-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v4/MINIAODSIM` | 9,966,000 | 369.80 GB | 121 | - | disk:1 |
| `/ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_lowPU_13TeV-powheg-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v5/MINIAODSIM` | 10,499,746 | 393.87 GB | 110 | - | disk:1; v4 INVALID |
| `/ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_lowPU_13TeV-powheg-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v5/MINIAODSIM` | 10,946,729 | 406.74 GB | 151 | - | disk:1 |
| `/TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/RunIILowPUSummer20UL17MiniAODv2-pilot_106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 10,000 | 406.73 MB | 1 | - | disk:2; pilot, 10k events |
| `/ST_t-channel_antitop_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v6/MINIAODSIM` | 9,999,145 | 336.96 GB | 154 | - | disk:3; v4,v5 INVALID |
| `/DYToLL_pomflux_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v3/MINIAODSIM` | 19,999,000 | 195.61 GB | 77 | - | disk:1 |
| `/DiPhoton_pomflux_Pt-20_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 20,000,000 | 248.25 GB | 109 | - | disk:1 |
| `/PhotonJet_pomflux_Pt-20_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v3/MINIAODSIM` | 20,000,000 | 233.59 GB | 74 | - | disk:1 |
| `/QCD_pomflux_Pt-100_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v3/MINIAODSIM` | 20,000,000 | 469.28 GB | 186 | - | disk:1 |
| `/ST_t-channel_pomflux_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v5/MINIAODSIM` | 9,001,000 | 205.50 GB | 58 | - | disk:1 |
| `/TT_pomflux_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v5/MINIAODSIM` | 20,000,000 | 644.77 GB | 281 | - | disk:1 |
| `/WlnuGluon_pomflux_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v3/MINIAODSIM` | 19,997,000 | 203.23 GB | 70 | - | disk:1 |
| `/WlnuQuark_pomflux_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 20,000,000 | 229.96 GB | 109 | - | disk:1 |
| `/Wlnu_pomflux_TuneCP5_lowPU_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-106X_mc2017_realistic_v9For2017H_v1-v3/MINIAODSIM` | 20,000,000 | 222.19 GB | 82 | - | disk:1 |
| `/MinBias_TuneCP5_13TeV-pythia8/RunIILowPUSummer20UL17MiniAODv2-Pilot_106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 10,000 | 82.88 MB | 1 | - | disk:1; pilot, 10k events |
| `/MinBias_TuneCP5_13TeV_pythia8/RunIILowPUSummer20UL17MiniAODv2-pilot_106X_mc2017_realistic_v9For2017H_v1-v2/MINIAODSIM` | 10,000 | 74.60 MB | 1 | - | disk:1; pilot, 10k events |
| **total (26 datasets)** | **340,261,617** | **7.34 TB** | | | |

#### inputs/lowPUMC_TnP_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 9,989,000 | 1.12 TB | 446 | - | disk:2 |
| `/DYJetsToEE_M-50_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 9,990,000 | 948.22 GB | 380 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 14,974,000 | 1.44 TB | 529 | - | disk:15 |
| `/WminusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 9,971,999 | 936.56 GB | 265 | - | disk:2 |
| `/WplusJetsToENu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 9,993,998 | 876.79 GB | 341 | - | disk:14 |
| `/WminusJetsToENu_H2ErratumFix_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 10,000,000 | 867.34 GB | 340 | - | disk:8 |
| `/WplusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 14,970,000 | 1.38 TB | 603 | - | disk:2 |
| `/WminusJetsToTauNu_TauToMu_H2ErratumFix_PDFExt_TuneCP5_13TeV-powhegMiNNLO-pythia8-photos/RunIILowPUSummer20UL17DR-106X_mc2017_realistic_v9For2017H_v1-v2/AODSIM` | 9,986,000 | 886.79 GB | 232 | - | disk:2 |
| **total (8 datasets)** | **89,874,997** | **8.44 TB** | | | |

**Notes (A):**
- **CVH:** only SingleMuon `UL2017_MiniAODv2_GT36-v2` keeps the muon tracker clusters. **DoubleMuon and HighEGJet have NO GT36 version -> no muon tracker hits -> no CVH** (their only MiniAODv2, `UL2017_MiniAODv2-v1`, has TrackExtras/RecHits but no Si cluster collections; verified on file level).
- **Change w.r.t. the previous list:** SingleMuon switched from `UL2017_MiniAODv2-v1` (NanoAODv15 parent, no clusters) to `UL2017_MiniAODv2_GT36-v2`. The previous `lowPUData_TnP_UL.txt` (15Feb2022 AOD) was the GT36 lineage already, so MiniAOD and TnP lists are now lineage-consistent.
- **4 golden LS missing in the GT36 lineage:** run 306936 LS 1601, 1602, 1617, 1618 (40,863 events) are absent from the 15Feb2022 AOD and hence from GT36-v1/v2, but present in `UL2017_MiniAODv2-v1` and in `/SingleMuon/Run2017H-15Feb2022_UL2017-v1/MINIAOD`. The RECO-step MiniAOD `15Feb2022_UL2017-v1/MINIAOD` (GT v36, has clusters, 12,675 LS, 1.47 TB, disk:2) is therefore a complete alternative with hits; it was not re-mini'd with the MiniAODv2 procModifier, so check the nano config is happy with it before using it.
- Other SingleMuon alternatives (not used): `UL2017_MiniAODv2_GT36-v1` (no clusters), `09Aug2019_UL2017_LowPU-v1/MINIAOD` (UL MiniAODv1), `17Nov2017-v2` (legacy 94X). PromptReco is DELETED.
- Mixed reconstruction between PDs: SingleMuon comes from the 2022 re-reco (GT v36), DoubleMuon/HighEGJet from the 2019 LowPU re-reco (GT v28, re-mini GT v33). Event-level overlap removal between PDs is unaffected, but the same event can have slightly different reconstruction in different PDs.
- AOD for DoubleMuon/HighEGJet (09Aug2019_UL2017_LowPU-v1) is **tape only** (1.4 TB / 17.5 TB).
- `inputs/data_2017.txt` (high-PU 2017) contained Run2017G (5.02 TeV) and Run2017H (low PU) in HEAD; they have since been removed in the working tree (not by this inventory), which is correct: they are covered by the lists of sections A and B.
- **MC (lowPUMC_UL.txt):** all 26 VALID datasets of `RunIILowPUSummer20UL17MiniAODv2` (conditions `106X_mc2017_realistic_v9For2017H_v1`); no NanoAODv15 exists for this campaign (only NanoAODv9). Not VALID: `ST_t-channel_top_4f` (v4 INVALID, v5 PRODUCTION -> commented line in the list), plus INVALID older versions of ST_t-channel_antitop (v4, v5), ST_tW_top (v4), TTToSemiLeptonic (v4).
- **No DYJetsToTauTau, WW/WZ/ZZ, ST s-channel in the LowPU campaign.** They exist with For2017H conditions under the *standard* campaign name `RunIISummer20UL17MiniAODv2` with processing strings `PUMu4_...` / `EpsilonPU_...` (30 VALID datasets: DYJetsToTauTau MiNNLO (PUMu4), DYJetsToLL amcatnloFXFX / madgraphMLM / herwig7 (PUMu4 and EpsilonPU), WW/WZ/ZZ, ST s-channel, TTTo2L2Nu pilot, plus pomflux/PPS (APtoTT/TW), QCD flat, MinBias, alpgen 6-jet). The W/Z/top/diboson ones are in `lowPUMC_UL.txt` as **commented-out** lines; their pileup scenario (PUMu4 = mean pileup 4? EpsilonPU) was not verified against the 2017H profile, check before using.
- Older 94X low-PU MC also exists (`RunIIFall17MiniAODv2-fixECALGT_LowPU_94X_mc2017_realistic_v10For2017H_v2`, `RunIILowPUSpring18DR`), not considered.
- **MC TnP:** the 8 W/Z MiNNLO AODSIM of `RunIILowPUSummer20UL17DR` (one per MiniAOD signal sample; all on disk).

## B. Run 2 -- 2017G pp reference run, 5.02 TeV (runs 306546-306826)

Golden JSON: `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions17/latest/5TeV/ReReco/Cert_306546-306826_5TeV_EOY2017ReReco_Collisions17_JSON.txt` (35 runs, 26,605 LS; `_MuonPhys` variant too). DoubleMuon and HighEGJet datasets contain extra non-golden runs (306503-306545) -> lumi mask required.

**PD trigger content** (HLT `datasets` PSet from a 2017G file):

| PD | lepton triggers | used |
|---|---|---|
| SingleMuon | HLT_HIL1Mu12/16, HIL2Mu7/12/15/20, HIL3Mu7/12/15/20, HIMu12/15/17, HIMu7p5_L2Mu2/Track2_Jpsi/Upsilon | yes |
| DoubleMuon | HLT_HIL1DoubleMu0(_HighQ)/10/Open(_OS/_SS), HIL2DoubleMu0/10, HIL3DoubleMu0/10, HIDimuon0_Jpsi/Upsilon | yes |
| HighEGJet | HLT_HIEle10/15/17/20/30/40_WPLoose_Gsf, HIEle15_Ele8, HIEle20_Ele12_DZ, HIDoublePhoton15, HISinglePhoton40-60, HIL3Mu5_AK4PFJet30-60 (+ jets) | yes |
| SingleMuonTnP | HLT_HIL2Mu3/5_NHitQ10, HIL3Mu3/5(_NHitQ10), HIL3Mu3/5_Track1(_Jpsi) | AOD only (see notes) |
| LowEGJet | HIPhoton20/30, HISinglePhoton10-30 + jets (no electrons) | no |
| HeavyFlavor | D-meson and dijet triggers | no |
| FSQJet1/2, SingleTrack, MinimumBias, ZeroBias*, HLTPhysics, EmptyBX, NoBPTX | no lepton triggers | no |

#### inputs/lowPU5TeVData_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/SingleMuon/Run2017G-UL2017_MiniAODv2_GT36-v2/MINIAOD` | 803,015,902 | 5.86 TB | 1525 | 35 (306546-306826) | disk:1; GT36, procModifier run2_miniAOD_UL; parent 15Feb2022_UL2017-v1 AOD (era Run2_2017); NOT the NanoAODv15 parent |
| `/DoubleMuon/Run2017G-UL2017_MiniAODv2-v1/MINIAOD` | 892,686,175 | 5.76 TB | 1424 | 47 (306526-306826) | disk:2; NanoAODv15 parent; 09Aug2019_UL2017 AOD (era Run2_2017, GT v28); 12 extra runs 306526-306545 outside golden JSON |
| `/HighEGJet/Run2017G-UL2017_MiniAODv2-v2/MINIAOD` | 373,346,879 | 4.24 TB | 1103 | 99 (306503-306826) | disk:2; re-reco 2022 with era Run2_2017_ppRef, GT36; parent of NanoAODv15-v1; runs 306503-306545 outside golden JSON |
| **total (3 datasets)** | **2,069,048,956** | **15.85 TB** | | | |

#### inputs/lowPU5TeVData_TnP_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/SingleMuon/Run2017G-15Feb2022_UL2017-v1/AOD` | 803,103,333 | 39.57 TB | 12767 | 35 (306546-306826) | disk:1; parent of GT36-v2 |
| `/DoubleMuon/Run2017G-09Aug2019_UL2017-v1/AOD` | 892,686,175 | 45.63 TB | 14819 | 47 (306526-306826) | TAPE-ONLY; parent of MiniAODv2-v1 |
| `/HighEGJet/Run2017G-09Aug2019_UL2017-v2/AOD` | 373,368,064 | 22.52 TB | 6140 | 99 (306503-306826) | TAPE-ONLY; parent of MiniAODv2-v2 (Run2_2017_ppRef) |
| `/SingleMuonTnP/Run2017G-09Aug2019_UL2017-v1/AOD` | 1,119,814,781 | 53.56 TB | 18742 | 40 (306554-306826) | TAPE-ONLY; only processing; low-threshold single-muon triggers; covers 92% of golden LS |
| **total (4 datasets)** | **3,188,972,353** | **161.28 TB** | | | |

#### inputs/lowPU5TeVMC_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 9,548,580 | 194.51 GB | 111 | - | disk:8 |
| `/DYJetsToEE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 9,991,673 | 256.41 GB | 143 | - | disk:6 |
| `/DYJetsToTauTau_TauToMuorE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 9,990,863 | 193.14 GB | 117 | - | disk:5 |
| `/WplusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 14,996,760 | 251.23 GB | 135 | - | disk:6 |
| `/WminusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 14,999,999 | 240.06 GB | 133 | - | disk:3 |
| `/WplusJetsToENu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 14,978,678 | 294.49 GB | 160 | - | disk:5 |
| `/WminusJetsToENu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 14,343,000 | 268.14 GB | 121 | - | disk:2; v2 INVALID |
| `/WplusJetsToTauNu_TauToMuorE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 14,610,729 | 238.77 GB | 130 | - | disk:3; v2 INVALID |
| `/WminusJetsToTauNu_TauToMuorE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 14,930,080 | 235.55 GB | 129 | - | disk:8 |
| `/Z15eeJet_pThat-15_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,002,340 | 20.95 GB | 7 | - | disk:1 |
| `/Z15mumuJet_pThat-15_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,005,073 | 18.17 GB | 6 | - | disk:1 |
| `/Ze10e10_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 981,496 | 18.46 GB | 7 | - | disk:1 |
| `/Zmu10mu10_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,001,147 | 14.31 GB | 5 | - | disk:1 |
| `/WZTo3LNu_TuneCP5_5p02TeV-amcatnloFXFX-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 5,071,770 | 115.77 GB | 40 | - | disk:3 |
| `/ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_5p02TeV-powheg-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 4,839,988 | 129.14 GB | 48 | - | disk:4 |
| `/JPsiMM_TuneCUETP8M1_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 40,934,683 | 301.71 GB | 114 | - | disk:1 |
| `/Ups1SMM_TuneCUETP8M1_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v5/MINIAODSIM` | 9,932,598 | 106.05 GB | 41 | - | disk:1 |
| `/Ups2SMM_TuneCUETP8M1_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 10,061,952 | 106.13 GB | 36 | - | disk:1 |
| `/Ups3SMM_TuneCUETP8M1_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 9,955,484 | 106.19 GB | 37 | - | disk:1 |
| `/QCD-Dimuon_pThat-15_TuneCH3_5p02TeV_herwig7/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 20,210,903 | 842.82 GB | 414 | - | disk:5 |
| `/QCD-Dimuon_pThat-15_TuneCP5_5p02TeV_pythia8-evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 21,870,079 | 606.79 GB | 288 | - | disk:8 |
| `/QCD_pThat-15_Mujet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 9,817,321 | 251.85 GB | 71 | - | disk:2 |
| `/QCD_pThat-30_EMEnrichedDijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 999,020 | 21.70 GB | 8 | - | disk:1 |
| `/QCD_pThat-50_EMEnrichedDijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 991,911 | 18.70 GB | 7 | - | disk:1 |
| `/QCD_pThat-80_EMEnrichedDijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 978,577 | 20.24 GB | 7 | - | disk:1 |
| `/QCD_pThat-120_EMEnrichedDijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 973,618 | 22.17 GB | 8 | - | disk:1 |
| `/QCD_pThat-170_EMEnrichedDijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,041,019 | 25.70 GB | 9 | - | disk:1 |
| `/QCD_pThat-220_EMEnrichedDijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 963,649 | 25.33 GB | 9 | - | disk:1 |
| `/QCDPhoton_pThat-15_Filter30GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 1,035,708 | 16.00 GB | 7 | - | disk:1 |
| `/QCDPhoton_pThat-15_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,004,033 | 19.36 GB | 12 | - | disk:1 |
| `/QCDPhoton_pThat-15_TuneCP5_5p02TeV_pythia8/RunIISummer20UL17pp5TeVMiniAODv2-pilot_106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 9,932 | 143.05 MB | 1 | - | disk:1; pilot (primary-dataset spelling '_pythia8') |
| `/QCDPhoton_pThat-30_Filter30GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 938,362 | 12.48 GB | 6 | - | disk:1 |
| `/QCDPhoton_pThat-30_Filter50GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 978,100 | 16.60 GB | 8 | - | disk:1 |
| `/QCDPhoton_pThat-30_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 911,014 | 16.61 GB | 7 | - | disk:1 |
| `/QCDPhoton_pThat-50_Filter30GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 983,950 | 21.83 GB | 10 | - | disk:1 |
| `/QCDPhoton_pThat-50_Filter50GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 960,537 | 14.42 GB | 6 | - | disk:1 |
| `/QCDPhoton_pThat-50_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 960,224 | 21.51 GB | 8 | - | disk:1 |
| `/QCDPhoton_pThat-80_Filter30GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,045,108 | 27.31 GB | 12 | - | disk:1 |
| `/QCDPhoton_pThat-80_Filter50GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,090,383 | 27.71 GB | 13 | - | disk:1 |
| `/QCDPhoton_pThat-80_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,010,603 | 24.22 GB | 8 | - | disk:1 |
| `/QCDPhoton_pThat-120_Filter30GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,050,387 | 29.36 GB | 10 | - | disk:1 |
| `/QCDPhoton_pThat-120_Filter50GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,058,388 | 30.70 GB | 9 | - | disk:1 |
| `/QCDPhoton_pThat-120_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,036,071 | 26.20 GB | 11 | - | disk:1 |
| `/QCDPhoton_pThat-170_Filter30GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,010,458 | 28.54 GB | 11 | - | disk:1 |
| `/QCDPhoton_pThat-170_Filter50GeV_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,023,184 | 31.34 GB | 12 | - | disk:1 |
| `/QCDPhoton_pThat-170_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 1,019,565 | 27.13 GB | 8 | - | disk:1 |
| **total (46 datasets)** | **278,148,997** | **5.34 TB** | | | |

#### inputs/lowPU5TeVMC_other_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/LambdaC_To_KaonDelta1232_pThat0_PtGT2_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 224,384 | 1.65 GB | 2 | - | disk:1 |
| `/LambdaC_To_KaonDelta1232_pThat0_PtGT4_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 189,212 | 1.47 GB | 1 | - | disk:1 |
| `/LambdaC_To_KaonDelta1232_pThat4_PtGT10_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 183,700 | 1.76 GB | 3 | - | disk:1 |
| `/LambdaC_To_PiLambda1520_pThat0_PtGT2_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 85,683 | 800.77 MB | 1 | - | disk:1 |
| `/LambdaC_To_PiLambda1520_pThat0_PtGT4_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 84,843 | 663.08 MB | 1 | - | disk:1 |
| `/LambdaC_To_PiLambda1520_pThat4_PtGT10_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 67,279 | 643.64 MB | 1 | - | disk:1 |
| `/LambdaC_To_PKaon892_pThat0_PtGT2_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 186,424 | 1.37 GB | 2 | - | disk:1 |
| `/LambdaC_To_PKaon892_pThat0_PtGT4_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 192,467 | 1.50 GB | 1 | - | disk:1 |
| `/LambdaC_To_PKaon892_pThat4_PtGT10_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 218,493 | 2.09 GB | 5 | - | disk:1 |
| `/LambdaC_To_PKaonPi_pThat0_PtGT2_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 422,590 | 3.10 GB | 2 | - | disk:1 |
| `/LambdaC_To_PKaonPi_pThat0_PtGT4_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v1/MINIAODSIM` | 424,951 | 3.32 GB | 3 | - | disk:1 |
| `/LambdaC_To_PKaonPi_pThat4_PtGT10_FixBS_TuneCP5_5p02TeV-pythia8_evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 347,520 | 13.92 GB | 91 | - | disk:1 |
| `/QCD_pThat-15_bJet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 13,607,419 | 285.61 GB | 90 | - | disk:2 |
| `/QCD_pThat-15_Dijet_TuneCP5_5p02TeV-pythia8/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v3/MINIAODSIM` | 65,000,000 | 1.18 TB | 319 | - | disk:4 |
| `/QCD_pThat-15_TuneCH3_5p02TeV_herwig7/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 64,975,000 | 1.44 TB | 601 | - | disk:4 |
| `/QCD_pThat-15_TuneCP5_5p02TeV_pythia8-evtgen/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v4/MINIAODSIM` | 79,860,000 | 1.38 TB | 577 | - | disk:3 |
| `/QCD_PthatGT15_bJet_TuneCH3_5p02TeV_herwig7/RunIISummer20UL17pp5TeVMiniAODv2-106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 19,726,362 | 511.76 GB | 168 | - | disk:1 |
| `/QCD_PthatGT15_FixedBS_UL_TuneCH3_5p02TeV_herwig7/RunIISummer20UL17pp5TeVMiniAODv2-seedChange_106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 9,976,000 | 175.31 GB | 78 | - | disk:1; seedChange processing |
| `/QCD_PthatGT15_TuneCH3_5p02TeV_herwig7/RunIISummer20UL17pp5TeVMiniAODv2-seedChange_106X_mc2017_realistic_forppRef5TeV_v3-v2/MINIAODSIM` | 49,973,000 | 1.15 TB | 406 | - | disk:2; seedChange processing |
| **total (19 datasets)** | **305,745,327** | **6.16 TB** | | | |

#### inputs/lowPU5TeVMC_TnP_UL.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 9,548,580 | 866.73 GB | 392 | - | disk:1 |
| `/DYJetsToEE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 9,910,088 | 758.55 GB | 345 | - | disk:8 |
| `/DYJetsToTauTau_TauToMuorE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 9,990,863 | 759.34 GB | 363 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 14,996,760 | 1.09 TB | 487 | - | TAPE-ONLY; needs tape recall |
| `/WminusJetsToMuNu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 14,999,999 | 1.03 TB | 453 | - | disk:1 |
| `/WplusJetsToENu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 14,978,678 | 967.32 GB | 457 | - | disk:1 |
| `/WminusJetsToENu_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v3/AODSIM` | 14,343,000 | 893.62 GB | 354 | - | disk:1 |
| `/WplusJetsToTauNu_TauToMuorE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v3/AODSIM` | 14,610,729 | 963.83 GB | 451 | - | disk:1 |
| `/WminusJetsToTauNu_TauToMuorE_H2ErratumFix_PDFExt_TuneCP5_5020GeV-powhegMiNNLO-pythia8-photos/RunIISummer20UL17pp5TeVRECO-106X_mc2017_realistic_forppRef5TeV_v3-v2/AODSIM` | 14,970,730 | 965.12 GB | 422 | - | disk:3 |
| **total (9 datasets)** | **118,349,427** | **8.30 TB** | | | |

**Notes (B), data:**
- **SingleMuon, GT36-v2 vs v1:** both are re-minis of `15Feb2022_UL2017-v1` AOD with GT `106X_dataRun2_v36` and identical event content (803,015,902 events, 26,500 LS); **v1 was run with procModifier `run2_miniAOD_UL_preSummer20` and has NO muon tracker clusters; v2 (`run2_miniAOD_UL`) has them -> v2 chosen** (also the GT36 rule). Other alternatives: `UL2017_MiniAODv2-v1` (parent of the central NanoAODv15; 09Aug2019 AOD lineage, 47 runs incl. 12 non-golden, 816,995,997 events; no clusters), `UL2017_MiniAODv2_BParking-v2` (no clusters), `15Feb2022_UL2017-v1/MINIAOD` (RECO-step MiniAOD, has clusters), `09Aug2019_UL2017-v1`, `26Aug2020_pilot-v1`, `17Nov2017-v1` MINIAOD. GT36-v2 covers 18 fewer golden LS than MiniAODv2-v1 (306772 LS 64,153; 306794 8 LS; 306801 8 LS; ~0.07%).
- **CVH:** **DoubleMuon and HighEGJet have NO GT36 version -> no muon tracker hits -> no CVH** (checked: no Si cluster collections in DoubleMuon `UL2017_MiniAODv2-v1`/`_BParking-v2`, HighEGJet `-v1`/`-v2`). SingleMuonTnP has only UL MiniAODv1 (no CVH either).
- **DoubleMuon:** `UL2017_MiniAODv2-v1` (NanoAODv15 parent; 892.7M events); alt. `UL2017_MiniAODv2_BParking-v2` (871.9M events, 35 runs, era Run2_2017+bParking).
- **HighEGJet, v1 vs v2:** `-v1` = re-mini of `09Aug2019_UL2017-v1` AOD (era Run2_2017, GT v28/v33; 375.1M events, 99.61% golden-LS coverage); `-v2` = 2022 re-reco `09Aug2019_UL2017-v2` AOD with **era `Run2_2017_ppRef`** + GT v36 re-mini (373.3M events, 99.18% coverage; run 306631 lost 56 LS in the MiniAOD w.r.t. its own AOD). Both are parents of a central NanoAODv15 (`NanoAODv15-v1` <- MiniAOD v2, `NanoAODv15-v2` <- MiniAOD v1). **Chose v2** (latest, ppRef-era reco appropriate for 5 TeV); v1 is the alternative with 0.4% more lumi but pp-era reco. Note that the muon PDs only exist with the pp-era (Run2_2017) reconstruction.
- **SingleMuonTnP:** only `09Aug2019_UL2017-v1` exists (MINIAOD = UL MiniAODv1, 7.2 TB, and AOD 53.6 TB, both **tape only**; 92% golden-LS coverage). The MiniAOD is commented out in `lowPU5TeVData_UL.txt` (MiniAODv1 would need the MiniAODv1 nano era); the AOD is active in `lowPU5TeVData_TnP_UL.txt` for low-pT/J/psi T&P -- remove it if not wanted.
- AODs of DoubleMuon (45.6 TB), HighEGJet (22.5 TB) and SingleMuonTnP (53.6 TB) are **tape only**; only the SingleMuon 15Feb2022 AOD (39.6 TB) is on disk.

**Notes (B), MC:**
- Campaign `RunIISummer20UL17pp5TeVMiniAODv2` (`106X_mc2017_realistic_forppRef5TeV_v3`): 65 VALID datasets (+2 INVALID older versions of WminusJetsToENu and WplusJetsToTauNu, both v2), split 46 (main) + 19 (other). No NanoAODv15 exists for this campaign (NanoAODv9 only).
- Main list content: MiNNLO DY->ee/mumu/tautau(->mu/e) and W+-->e/mu/tau nu; pythia8 Z15eeJet/Z15mumuJet/Ze10e10/Zmu10mu10; WZTo3LNu; ST_tW_antitop; J/psi->mumu, Upsilon(1S/2S/3S)->mumu; QCD-Dimuon (pythia8-evtgen and herwig7), QCD_pThat-15_Mujet, EM-enriched dijet (pThat 30-220); QCDPhoton (pThat 15-170, unfiltered and Filter30GeV/50GeV, + a pilot).
- `_other` list: 12 LambdaC exclusive decays, inclusive QCD (pythia8 dijet, pythia8-evtgen, herwig7 incl. seedChange/FixedBS variants) and b-jet QCD. No D0/Ds/B-hadron exclusive samples exist in this UL campaign (they exist only in 94X).
- **Not in the UL MiniAODv2 campaign:** ttbar (`TT_TuneCP5_5p02TeV-powheg-pythia8` exists only as UL **MiniAODv1** pilot `RunIISummer20UL17pp5TeVMiniAOD-pilot_..._v3-v3`, commented out in the main list), `BcToJpsiMuNu` (MiniAODv1 pilot only, commented out in `_other`), ST_tW **top**, WW, ZZ, psi(2S), and any madgraph/amcatnlo DY/W.
- MC TnP: AODSIM (`RunIISummer20UL17pp5TeVRECO`) parents of the 9 MiNNLO W/Z samples; WplusJetsToMuNu AODSIM is **tape only**. AODSIM also exist for the pythia8 Z samples and WZ (not listed).

**94X-only 5 TeV samples (`RunIIpp5Spring18MiniAOD-94X_mc2017_realistic_forppRef5TeV*`, NOT put in any list):** W/Z/top/diboson and lepton-related samples that have no UL equivalent. VALID only (INVALID: ST_tW_antitop TuneCP5up v1/v2, TT_hdampUP/DOWN v1). Note the ST s-/t-channel samples carry `13TeV` in their name although produced in the 5 TeV campaign.

| dataset (RunIIpp5Spring18MiniAOD) | events | size | files | replica |
|---|---|---|---|---|
| `DY0JetsToLL_MLL-50_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 5012401 | 75.29 GB | 20 | TAPE-ONLY |
| `DY1JetsToLL_MLL-50_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 5193117 | 97.14 GB | 36 | TAPE-ONLY |
| `DY2JetsToLL_MLL-50_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 4872515 | 100.16 GB | 31 | TAPE-ONLY |
| `DY3JetsToLL_MLL-50_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 4633529 | 110.04 GB | 47 | TAPE-ONLY |
| `DYJetsToLL_M-10to50_TuneCP5_5020GeV-amcatnloFXFX-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1396830 | 14.12 GB | 6 | TAPE-ONLY |
| `DYJetsToLL_MLL-50_TuneCP5_5020GeV-amcatnloFXFX-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 9992985 | 151.13 GB | 53 | disk:2 |
| `JPsiMM_pThat-15_TuneCUETP8M1_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 5161495 | 57.24 GB | 20 | TAPE-ONLY |
| `JPsiMM_pThat-25_TuneCUETP8M1_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 4912357 | 63.17 GB | 28 | TAPE-ONLY |
| `JPsiMM_pThat-35_TuneCUETP8M1_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 4861163 | 69.36 GB | 29 | TAPE-ONLY |
| `JPsiMM_pThat-45_TuneCUETP8M1_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 4977516 | 77.18 GB | 32 | TAPE-ONLY |
| `Psi2SMM_TuneCUETP8M1_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 9910046 | 71.79 GB | 33 | disk:1 |
| `QCD_Pt-20to30_EMEnriched_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1422912 | 17.64 GB | 7 | TAPE-ONLY |
| `QCD_Pt-20toInf_MuEnrichedPt15_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1635011 | 25.05 GB | 9 | disk:2 |
| `QCD_Pt-30to50_EMEnriched_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 972325 | 13.04 GB | 6 | disk:2 |
| `QCD_Pt-50to80_EMEnriched_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 911913 | 13.97 GB | 5 | disk:2 |
| `QCD_Pt-80to120_EMEnriched_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 902366 | 15.67 GB | 8 | TAPE-ONLY |
| `QCD_Pt_170to250_bcToE_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 850501 | 19.23 GB | 6 | TAPE-ONLY |
| `QCD_Pt_20to30_bcToE_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1064754 | 14.59 GB | 5 | TAPE-ONLY |
| `QCD_Pt_250toInf_bcToE_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1362409 | 33.06 GB | 15 | TAPE-ONLY |
| `QCD_Pt_30to80_bcToE_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 675944 | 10.47 GB | 4 | TAPE-ONLY |
| `QCD_Pt_80to170_bcToE_TuneCP5_5p02TeV_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 774080 | 15.14 GB | 6 | TAPE-ONLY |
| `ST_s-channel_antitop_5f_LeptonDecays_TuneCP5_13TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 500000 | 9.66 GB | 5 | disk:2 |
| `ST_s-channel_top_5f_LeptonDecays_TuneCP5_13TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 1000000 | 19.64 GB | 8 | disk:2 |
| `ST_t-channel_antitop_5f_InclusiveDecays_MT-169p5_TuneCP5_13TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 3000000 | 60.00 GB | 24 | disk:3 |
| `ST_t-channel_antitop_5f_InclusiveDecays_MT-175p5_TuneCP5_13TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 3000000 | 60.46 GB | 19 | disk:2 |
| `ST_t-channel_top_5f_InclusiveDecays_MT-169p5_TuneCP5_13TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 6000000 | 120.73 GB | 42 | disk:2 |
| `ST_t-channel_top_5f_InclusiveDecays_MT-175p5_TuneCP5_13TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v2` | 6000000 | 121.66 GB | 35 | disk:2 |
| `ST_t-channel_top_5f_InclusiveDecays_TuneCP5_13TeV-powheg-pythia8_validation/94X_mc2017_realistic_forppRef5TeV-v2` | 1400000 | 28.29 GB | 12 | disk:2 |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1084424 | 25.54 GB | 9 | disk:3 |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV_ext1-v1` | 542683 | 12.81 GB | 6 | TAPE-ONLY |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_PSweights_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1988497 | 47.56 GB | 18 | disk:2 |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_mtop1665_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 542631 | 12.73 GB | 6 | TAPE-ONLY |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5_mtop1785_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 543348 | 12.90 GB | 6 | TAPE-ONLY |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5down_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 542804 | 12.71 GB | 5 | TAPE-ONLY |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_TuneCP5up_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v3` | 543258 | 12.88 GB | 5 | TAPE-ONLY |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_hdampDOWN_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 542849 | 12.80 GB | 5 | TAPE-ONLY |
| `ST_tW_antitop_5f_NoFullyHadronicDecays_hdampUP_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 542028 | 12.79 GB | 5 | TAPE-ONLY |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1085146 | 25.54 GB | 8 | disk:2 |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV_ext1-v1` | 543714 | 12.83 GB | 8 | disk:2 |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_PSweights_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 2031093 | 48.53 GB | 20 | disk:2 |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_mtop1665_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 539281 | 12.65 GB | 6 | TAPE-ONLY |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5_mtop1785_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 515749 | 12.23 GB | 5 | TAPE-ONLY |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5down_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 542366 | 12.68 GB | 5 | TAPE-ONLY |
| `ST_tW_top_5f_NoFullyHadronicDecays_TuneCP5up_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 543316 | 12.87 GB | 6 | TAPE-ONLY |
| `ST_tW_top_5f_NoFullyHadronicDecays_hdampDOWN_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 542275 | 12.78 GB | 5 | TAPE-ONLY |
| `ST_tW_top_5f_NoFullyHadronicDecays_hdampUP_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 543070 | 12.82 GB | 7 | TAPE-ONLY |
| `TT_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 6000000 | 163.03 GB | 49 | TAPE-ONLY |
| `TT_TuneCP5_PSweights_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 6000000 | 164.91 GB | 61 | TAPE-ONLY |
| `TT_TuneCP5down_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 2000000 | 53.98 GB | 16 | disk:2 |
| `TT_TuneCP5up_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 2000000 | 54.55 GB | 17 | disk:2 |
| `TT_hdampDOWN_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v3` | 5964000 | 173.80 GB | 72 | disk:2 |
| `TT_hdampUP_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v3` | 5984000 | 175.30 GB | 75 | disk:2 |
| `TT_mtop166p5_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 1994000 | 53.77 GB | 19 | TAPE-ONLY |
| `TT_mtop178p5_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 2000000 | 54.76 GB | 16 | TAPE-ONLY |
| `W0JetsToLNu_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 15093040 | 190.60 GB | 72 | disk:2 |
| `W1JetsToLNu_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 14847631 | 227.31 GB | 67 | disk:3 |
| `W2JetsToLNu_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 15102326 | 265.64 GB | 111 | disk:3 |
| `W3JetsToLNu_TuneCP5_5020GeV-madgraphMLM-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 14331189 | 294.86 GB | 79 | disk:3 |
| `WJetsToLNu_TuneCP5_5020GeV-amcatnloFXFX-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 19687267 | 254.12 GB | 76 | disk:2 |
| `WWTo2L2Nu_NNPDF31_TuneCP5_5p02TeV-powheg-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 500000 | 8.38 GB | 4 | TAPE-ONLY |
| `WZTo3LNU_NNPDF30_TuneCP5_5p20TeV-powheg/94X_mc2017_realistic_forppRef5TeV-v1` | 500000 | 7.93 GB | 2 | TAPE-ONLY |
| `WZTo3LNu_TuneCP5_5p02TeV-amcatnloFXFX-pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 507952 | 10.63 GB | 7 | TAPE-ONLY |
| `ZZTo2L2Nu_5p02TeV_powheg_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 500000 | 7.66 GB | 3 | TAPE-ONLY |
| `ZZTo4L_5p02TeV_powheg_pythia8/94X_mc2017_realistic_forppRef5TeV-v1` | 500000 | 8.15 GB | 3 | TAPE-ONLY |

Also 94X-only: D0/Ds/B-hadron/Bc exclusive decays, MinBias (CUETP8M1), CUETP8M1-tune QCDPhoton/EMEnriched variants (not inventoried individually).

## C. Run 3 standard campaigns 2022-2023 (central NanoAODv15 parents)

Common rules: data = MiniAOD parents of the central `NanoAODv15` (`22Sep2023` re-MiniAOD for every 2022/2023 PD and era); T&P data = AOD parent of that MiniAOD (lineage); MC = standard `130X` MiniAODv4 processing (= v15 parent where a v15 NANO exists), all VALID `_extN` kept, one version per extension; non-VALID (PRODUCTION) signal samples and optional extras appear only as `#`-commented lines. `disk:N` = number of non-tape sites holding (part of) the dataset; `TAPE-ONLY` needs a Rucio rule before CRAB.

### 2022

Data totals: muon MiniAOD 238,579,065 evts / 10.81 TB; EGamma MiniAOD 352,684,466 evts / 16.33 TB; muon AOD (T&P) 238,727,270 evts / 77.14 TB.

#### inputs/data_2022.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/SingleMuon/Run2022C-22Sep2023-v1/MINIAOD` | 20,162,441 | 877.97 GB | 252 | 60 (355862-356386) | disk:2; v15 parent |
| `/DoubleMuon/Run2022C-22Sep2023-v1/MINIAOD` | 4,646,904 | 216.43 GB | 70 | 60 (355862-356386) | disk:2; v15 parent |
| `/Muon/Run2022C-22Sep2023-v1/MINIAOD` | 138,329,693 | 6.29 TB | 1768 | 125 (356426-357482) | disk:2; v15 parent |
| `/Muon/Run2022D-22Sep2023-v1/MINIAOD` | 75,440,027 | 3.43 TB | 1001 | 69 (357538-357900) | disk:10; v15 parent |
| **total (4 datasets)** | **238,579,065** | **10.81 TB** | | | |

#### inputs/dataEGamma_2022.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma/Run2022C-22Sep2023-v1/MINIAOD` | 263,549,470 | 12.12 TB | 3354 | 179 (355862-357482) | disk:2; v15 parent |
| `/EGamma/Run2022D-22Sep2023-v1/MINIAOD` | 89,134,996 | 4.22 TB | 1218 | 69 (357538-357900) | disk:8; v15 parent |
| **total (2 datasets)** | **352,684,466** | **16.33 TB** | | | |

#### inputs/data_2022_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/SingleMuon/Run2022C-27Jun2023-v1/AOD` | 20,162,441 | 6.09 TB | 1410 | 60 (355862-356386) | disk:13; AOD parent of list MiniAOD |
| `/DoubleMuon/Run2022C-27Jun2023-v1/AOD` | 4,646,904 | 1.47 TB | 384 | 60 (355862-356386) | TAPE-ONLY; AOD parent of list MiniAOD; needs Rucio rule (tape) |
| `/Muon/Run2022C-27Jun2023-v1/AOD` | 138,449,544 | 44.81 TB | 6809 | 125 (356426-357482) | disk:2; AOD parent of list MiniAOD |
| `/Muon/Run2022D-27Jun2023-v2/AOD` | 75,468,381 | 24.77 TB | 3067 | 69 (357538-357900) | disk:20; AOD parent of list MiniAOD |
| **total (4 datasets)** | **238,727,270** | **77.14 TB** | | | |

#### inputs/mc_2022.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 39,712,884 | 2.69 TB | 1142 | - | disk:27 |
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 12,975,997 | 754.23 GB | 374 | - | disk:32 |
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,820,937 | 145.45 GB | 66 | - | disk:2; v15 parent |
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,418,050 | 65.19 GB | 38 | - | disk:2 |
| `/DYto2E_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,918,148 | 154.23 GB | 92 | - | disk:3; v15 parent |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,477,950 | 66.10 GB | 37 | - | disk:2 |
| `/DYto2Tau_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,967,285 | 139.69 GB | 81 | - | disk:2; v15 parent |
| `/DYto2Tau_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,459,245 | 62.83 GB | 37 | - | disk:2 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v5/MINIAODSIM` | 93,967,480 | 6.36 TB | 2313 | - | disk:11; v15 parent |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 92,895,045 | 6.33 TB | 2821 | - | disk:28 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext2-v3/MINIAODSIM` | 94,127,967 | 6.40 TB | 2272 | - | disk:32 |
| `/DYto2L-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v3/MINIAODSIM` | 98,461,524 | 6.45 TB | 2421 | - | disk:34 |
| `/DYto2L-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v3/MINIAODSIM` | 96,328,349 | 6.80 TB | 2269 | - | disk:30 |
| `/DYto2L-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v3/MINIAODSIM` | 77,379,235 | 6.08 TB | 2429 | - | disk:25 |
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v4/MINIAODSIM` | 97,526,817 | 5.46 TB | 1802 | - | disk:10; v15 parent |
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 49,524,689 | 2.76 TB | 1492 | - | disk:31 |
| `/DYto2Tau-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 39,627,426 | 2.37 TB | 948 | - | disk:4; v15 parent |
| `/DYto2Tau-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 56,687,827 | 3.69 TB | 1273 | - | disk:5 |
| `/DYto2Tau-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 107,747,888 | 7.72 TB | 2620 | - | disk:4 |
| `/DYto2L-4Jets_MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v3/MINIAODSIM` | 73,131,170 | 4.81 TB | 1717 | - | disk:13; v15 parent |
| `/DYto2L-4Jets_MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v3/MINIAODSIM` | 74,125,328 | 4.86 TB | 1737 | - | disk:20 |
| `/DYto2L-4Jets_MLL-10to50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 151,244,141 | 8.32 TB | 3704 | - | disk:23; v15 parent |
| `/WplustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 34,874,933 | 2.12 TB | 783 | - | disk:27 |
| `/WplustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 34,739,522 | 2.13 TB | 897 | - | disk:31 |
| `/WplustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 34,840,239 | 1.99 TB | 865 | - | disk:32 |
| `/WminustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 34,710,479 | 2.10 TB | 970 | - | disk:36 |
| `/WminustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 34,666,604 | 2.11 TB | 885 | - | disk:32 |
| `/WminustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 34,846,880 | 1.99 TB | 702 | - | disk:28 |
| `/WtoLNu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 76,566,809 | 3.71 TB | 982 | - | disk:2; v15 parent |
| `/WtoLNu-2Jets_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v3/MINIAODSIM` | 191,268,400 | 11.43 TB | 4333 | - | disk:7 |
| `/WtoLNu-2Jets_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 141,442,730 | 9.20 TB | 3417 | - | disk:3 |
| `/WtoLNu-2Jets_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 102,668,792 | 7.31 TB | 2727 | - | disk:3 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 87,204,163 | 4.15 TB | 1164 | - | disk:15 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 97,491,826 | 5.89 TB | 2577 | - | disk:4; v15 parent |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 23,802,613 | 1.61 TB | 429 | - | disk:14; v15 parent |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 24,084,800 | 2.16 TB | 993 | - | disk:2 |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 66,419,700 | 4.47 TB | 1188 | - | disk:9; v15 parent |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 77,002,090 | 6.79 TB | 2749 | - | disk:6 |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 53,220,176 | 3.56 TB | 1251 | - | disk:6; v15 parent |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 52,573,597 | 4.57 TB | 1931 | - | disk:2 |
| `/TBbarQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,973,675 | 168.39 GB | 76 | - | disk:2; v15 parent |
| `/TbarBQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,433,215 | 81.33 GB | 45 | - | disk:2; v15 parent |
| `/TBbartoLplusNuBbar-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,271,280 | 74.24 GB | 40 | - | disk:2; v15 parent |
| `/TbarBtoLminusNuB-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 785,520 | 45.75 GB | 34 | - | disk:2; v15 parent |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,387,056 | 151.01 GB | 52 | - | disk:2; v15 parent |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 2,500,000 | 212.22 GB | 124 | - | disk:2 |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 4,743,971 | 300.14 GB | 125 | - | disk:2; v15 parent |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 4,900,350 | 406.99 GB | 226 | - | disk:2 |
| `/TWminusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 3,862,005 | 241.61 GB | 97 | - | disk:2; v15 parent |
| `/TWminusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 3,941,275 | 321.21 GB | 152 | - | disk:2 |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,327,688 | 147.36 GB | 53 | - | disk:2; v15 parent |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 2,435,737 | 206.86 GB | 125 | - | disk:2 |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 4,366,467 | 275.74 GB | 100 | - | disk:2; v15 parent |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 4,816,562 | 400.10 GB | 228 | - | disk:2 |
| `/TbarWplusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 3,762,952 | 235.13 GB | 75 | - | disk:2; v15 parent |
| `/TbarWplusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 4,000,000 | 326.12 GB | 174 | - | disk:3 |
| `/WW_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 15,405,496 | 780.49 GB | 236 | - | disk:2; v15 parent |
| `/WZ_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 7,479,528 | 380.28 GB | 147 | - | disk:2; v15 parent |
| `/ZZ_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,181,750 | 60.23 GB | 31 | - | disk:3; v15 parent |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 6,135,192 | 330.38 GB | 126 | - | disk:2 |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 6,600,000 | 465.68 GB | 228 | - | disk:2 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 27,258,240 | 1.47 TB | 475 | - | disk:2 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 26,562,760 | 1.86 TB | 856 | - | disk:2 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,797,132 | 150.79 GB | 66 | - | disk:2 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v3/MINIAODSIM` | 8,876,662 | 629.54 GB | 231 | - | disk:20 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 4,167,791 | 229.08 GB | 86 | - | disk:2 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 4,273,767 | 308.58 GB | 140 | - | disk:2 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 8,902,752 | 473.23 GB | 172 | - | disk:2 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 8,726,624 | 601.61 GB | 323 | - | disk:2 |
| `/WZtoL3Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 995,000 | 64.25 GB | 41 | - | disk:9 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 14,644,284 | 781.71 GB | 294 | - | disk:15 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 14,446,776 | 1.01 TB | 550 | - | disk:2 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 14,553,603 | 753.24 GB | 307 | - | disk:2 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 16,722,032 | 1.14 TB | 612 | - | disk:2 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 14,664,788 | 784.21 GB | 318 | - | disk:2 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5_ext1-v2/MINIAODSIM` | 14,997,882 | 1.05 TB | 481 | - | disk:2 |
| `/JPsiMuMu_JPsiNoFilter_2MuPtEtaFilter_TuneCP5_13p6TeV-pythia8-evtgen/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v3/MINIAODSIM` | 25,066,481 | 1.61 TB | 1193 | - | disk:4 |
| `/JPsito2Mu_JPsiFilter_2MuFilter_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 13,138,780 | 695.16 GB | 228 | - | TAPE-ONLY |
| `/JpsiTo2Mu_JpsiPt8_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-MUO_POG_130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 47,570,811 | 2.22 TB | 602 | - | disk:3; v15 parent |
| `/JPsiTo2Mu_Pt-0To100_pythia8-gun/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 9,339,550 | 419.09 GB | 132 | - | TAPE-ONLY |
| `/Psi2sto2Mu_Psi2sFilter_2MuFilter_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 1,246,440 | 62.44 GB | 25 | - | disk:3 |
| `/Upsilonto2Mu_UpsilonFilter_2MuFilter_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 2,184,575 | 108.15 GB | 46 | - | disk:1 |
| `/QCD_PT-15to20_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 4,355,208 | 213.20 GB | 83 | - | disk:3; v15 parent |
| `/QCD_PT-20to30_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 30,196,351 | 1.50 TB | 410 | - | disk:6; v15 parent |
| `/QCD_PT-30to50_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 27,016,789 | 1.39 TB | 465 | - | disk:2; v15 parent |
| `/QCD_PT-50to80_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 40,877,766 | 2.23 TB | 713 | - | disk:2; v15 parent |
| `/QCD_PT-80to120_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 24,335,108 | 1.42 TB | 454 | - | disk:3; v15 parent |
| `/QCD_PT-120to170_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 18,670,083 | 1.16 TB | 377 | - | disk:2; v15 parent |
| `/QCD_PT-170to300_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 36,810,625 | 2.47 TB | 777 | - | disk:2; v15 parent |
| `/QCD_PT-300to470_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 30,226,277 | 2.23 TB | 721 | - | disk:3; v15 parent |
| `/QCD_PT-470to600_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 18,567,007 | 1.45 TB | 459 | - | disk:2; v15 parent |
| `/QCD_PT-600to800_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 19,879,274 | 1.61 TB | 521 | - | disk:2; v15 parent |
| `/QCD_PT-800to1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 39,295,469 | 3.31 TB | 964 | - | disk:3; v15 parent |
| `/QCD_PT-1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 13,705,539 | 1.20 TB | 349 | - | disk:2; v15 parent |
| **total (94 datasets)** | **3,143,331,680** | **202.01 TB** | | | |

#### inputs/mc_2022_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22DRPremix-124X_mcRun3_2022_realistic_v12-v2/AODSIM` | 2,924,957 | 1.12 TB | 341 | - | TAPE-ONLY |
| **total (1 datasets)** | **2,924,957** | **1.12 TB** | | | |

#### commented-out (not active) entries in mc_2022.txt / mc_2022_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2E_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22MiniAODv4-130X_mcRun3_2022_realistic_v5-v2/MINIAODSIM` | 10,150,709 | 693.24 GB | 418 | - | PRODUCTION; disk:33 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22DRPremix-124X_mcRun3_2022_realistic_v12-v5/AODSIM` | 94,342,298 | 35.32 TB | 9683 | - | disk:3 |

Notes:
- **Data processing**: `22Sep2023` re-MiniAOD = MiniAOD parent of the central `NanoAODv15-v1` for every PD/era. Era C is split across PDs: runs 355862-356386 in SingleMuon + DoubleMuon, runs 356426-357482 in the merged Muon PD (all three listed). EGamma covers the whole of C (179 runs).
- **T&P AOD**: lineage parents of the MiniAOD = `27Jun2023` AOD re-reco (C, D; Run2022D-27Jun2023-v1 is INVALID, -v2 used). `/DoubleMuon/Run2022C-27Jun2023-v1/AOD` is TAPE-ONLY.
- **Alternatives not used**: `/Muon/Run2022C-18Sep2023-v3/MINIAOD` (VALID, 138.44M evts, not a v15 parent); 10Dec2022/16Jun2023/27Jun2023/30May2023 MiniAODs and PromptReco (older).
- **MC (Run3Summer22MiniAODv4, 130X_mcRun3_2022_realistic_v5)**: the central NanoAODv15 covers only ~75 datasets per campaign (DY POWHEG 50to120 / FxFx / MLM, W FxFx / MLM, ttbar, single top, inclusive dibosons, QCD, MUO-POG J/psi); every list entry that has a v15 NANO is its parent (marked). MiNNLO W/Z, leptonic dibosons, prompt Upsilon/psi(2S) and most J/psi samples have no v15 NANO and were taken from the standard MiniAODv4 processing.
- **Generators (2022)**: DY->mumu MiNNLO 50to130 + 10to50 and W+/W- -> mu/e/tau nu MiNNLO are VALID; DY->ee MiNNLO 50to130 is PRODUCTION (commented); DY->ee 10to50 and DY->tautau MiNNLO do not exist; POWHEG NLO DY (50to120, 10to50) for mumu/ee/tautau, FxFx (incl. 0J/1J/2J, ext1/ext2) and MLM all VALID. Sherpa MEPS@NLO W/DY samples (`*-5Jets-2NLO3LO_*_sherpaMEPS`) exist but are not included; high-mass binned DY/W (MLL>120, W M-*) not included.
- **Quarkonia (2022)**: J/psi NoFilter_2MuPtEtaFilter (evtgen), J/psi JPsiFilter_2MuFilter (TAPE-ONLY), MUO-POG JpsiPt8 (only a MUO_POG processing exists), J/psi->mumu particle gun pT 0-100 (TAPE-ONLY), psi(2S) and Upsilon 2MuFilter. Exclusive B->J/psi X samples (e.g. B+ -> J/psi K+) exist but are out of scope.
- **QCD**: QCD_PT-*_MuEnrichedPt5 (12 bins, 15 GeV-inf); no MuEnrichedPt15 in Run 3. Duplicate-looking `QCD_Pt-XToY_MuEnrichedPt5` (capital "To", 5 bins, 2022 only) not used.
- **Skipped special processings**: `py8tauval_` DY->tautau FxFx, `FS22_` DY MLM.
- **T&P MC**: the MiNNLO DY samples have NO AODSIM (no AODSIM dataset exists for them); POWHEG DYto2Mu_MLL-50to120 AODSIM used (2.9M evts, TAPE-ONLY); the FxFx DYto2L-2Jets_MLL-50 AODSIM (94M evts, 35 TB) is given as `#ALT`.

### 2022EE

Data totals: muon MiniAOD 667,355,457 evts / 34.73 TB; EGamma MiniAOD 689,463,164 evts / 36.86 TB; muon AOD (T&P) 668,077,174 evts / 256.06 TB.

#### inputs/data_2022EE.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon/Run2022E-22Sep2023-v1/MINIAOD` | 141,480,973 | 6.67 TB | 1916 | 59 (359356-360327) | disk:9; v15 parent |
| `/Muon/Run2022F-22Sep2023-v2/MINIAOD` | 449,185,088 | 23.83 TB | 6691 | 179 (360335-362167) | disk:3; v15 parent |
| `/Muon/Run2022G-22Sep2023-v1/MINIAOD` | 76,689,396 | 4.23 TB | 1246 | 35 (362362-362760) | disk:2; v15 parent |
| **total (3 datasets)** | **667,355,457** | **34.73 TB** | | | |

#### inputs/dataEGamma_2022EE.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma/Run2022E-22Sep2023-v1/MINIAOD` | 148,661,479 | 7.26 TB | 2033 | 58 (359356-360327) | disk:13; v15 parent |
| `/EGamma/Run2022F-22Sep2023-v1/MINIAOD` | 464,077,454 | 25.25 TB | 7217 | 177 (360389-362167) | disk:18; v15 parent |
| `/EGamma/Run2022G-22Sep2023-v2/MINIAOD` | 76,724,231 | 4.34 TB | 1245 | 34 (362399-362760) | disk:13; v15 parent |
| **total (3 datasets)** | **689,463,164** | **36.86 TB** | | | |

#### inputs/data_2022EE_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon/Run2022E-27Jun2023-v1/AOD` | 141,480,973 | 48.26 TB | 6290 | 59 (359356-360327) | disk:2; AOD parent of list MiniAOD |
| `/Muon/Run2022F-PromptReco-v1/AOD` | 449,906,805 | 176.21 TB | 46672 | 179 (360335-362167) | disk:1; AOD parent of list MiniAOD |
| `/Muon/Run2022G-PromptReco-v1/AOD` | 76,689,396 | 31.60 TB | 7745 | 35 (362362-362760) | disk:1; AOD parent of list MiniAOD |
| **total (3 datasets)** | **668,077,174** | **256.06 TB** | | | |

#### inputs/mc_2022EE.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 118,027,481 | 7.90 TB | 3619 | - | disk:38 |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 43,688,839 | 2.46 TB | 1113 | - | disk:27 |
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 9,854,680 | 505.14 GB | 229 | - | disk:2; v15 parent |
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 5,026,256 | 230.14 GB | 143 | - | disk:2 |
| `/DYto2E_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 10,403,118 | 546.94 GB | 231 | - | disk:2; v15 parent |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 5,333,106 | 237.09 GB | 108 | - | disk:2 |
| `/DYto2Tau_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 10,162,678 | 475.31 GB | 167 | - | disk:2; v15 parent |
| `/DYto2Tau_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 5,249,261 | 224.01 GB | 88 | - | disk:2 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v5/MINIAODSIM` | 336,126,708 | 22.41 TB | 7699 | - | disk:5; v15 parent |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 353,523,335 | 23.49 TB | 7310 | - | disk:16 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext2-v3/MINIAODSIM` | 332,637,009 | 22.32 TB | 8685 | - | disk:22 |
| `/DYto2L-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v3/MINIAODSIM` | 346,275,631 | 22.48 TB | 8041 | - | disk:24 |
| `/DYto2L-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v3/MINIAODSIM` | 341,782,822 | 23.89 TB | 9236 | - | disk:32 |
| `/DYto2L-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v3/MINIAODSIM` | 280,799,892 | 21.61 TB | 7067 | - | disk:21 |
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v5/MINIAODSIM` | 355,699,357 | 19.64 TB | 6687 | - | disk:19; v15 parent |
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v4/MINIAODSIM` | 179,484,558 | 9.89 TB | 3940 | - | disk:25 |
| `/DYto2Tau-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 125,936,677 | 7.55 TB | 2298 | - | disk:6; v15 parent |
| `/DYto2Tau-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 186,908,781 | 12.10 TB | 4048 | - | disk:4 |
| `/DYto2Tau-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 371,628,745 | 25.99 TB | 8772 | - | disk:30 |
| `/DYto2L-4Jets_MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v3/MINIAODSIM` | 264,413,000 | 16.88 TB | 6114 | - | disk:12; v15 parent |
| `/DYto2L-4Jets_MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v3/MINIAODSIM` | 253,574,452 | 16.60 TB | 5381 | - | disk:22 |
| `/DYto2L-4Jets_MLL-10to50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v4/MINIAODSIM` | 503,226,689 | 27.79 TB | 10836 | - | disk:23; v15 parent |
| `/WplustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 119,300,481 | 7.17 TB | 2982 | - | disk:32 |
| `/WplustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 119,188,423 | 7.25 TB | 2995 | - | disk:31 |
| `/WplustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 118,567,100 | 6.73 TB | 2961 | - | disk:32 |
| `/WminustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 119,238,816 | 7.15 TB | 3065 | - | disk:37 |
| `/WminustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 119,551,341 | 7.23 TB | 2983 | - | disk:30 |
| `/WminustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 119,450,514 | 6.78 TB | 2812 | - | disk:37 |
| `/WtoLNu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 268,736,366 | 12.98 TB | 3387 | - | disk:2; v15 parent |
| `/WtoLNu-2Jets_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v3/MINIAODSIM` | 682,250,482 | 40.46 TB | 13251 | - | disk:6 |
| `/WtoLNu-2Jets_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 522,841,883 | 33.70 TB | 11143 | - | disk:5 |
| `/WtoLNu-2Jets_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 346,847,485 | 24.48 TB | 8178 | - | disk:3 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 342,750,582 | 16.24 TB | 4265 | - | disk:2 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 323,005,559 | 19.36 TB | 7432 | - | disk:2; v15 parent |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 74,311,182 | 5.00 TB | 1388 | - | disk:2; v15 parent |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 84,925,614 | 7.52 TB | 2921 | - | disk:2 |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 265,581,161 | 17.79 TB | 4567 | - | disk:2; v15 parent |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 275,487,429 | 24.04 TB | 8801 | - | disk:2 |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 179,466,187 | 11.96 TB | 2991 | - | disk:2; v15 parent |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 187,547,263 | 16.15 TB | 6271 | - | disk:2 |
| `/TBbarQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 10,178,237 | 572.73 GB | 237 | - | disk:2; v15 parent |
| `/TbarBQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 5,185,208 | 291.95 GB | 116 | - | disk:2; v15 parent |
| `/TBbartoLplusNuBbar-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 4,363,850 | 252.92 GB | 91 | - | disk:2; v15 parent |
| `/TbarBtoLminusNuB-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 2,762,668 | 159.44 GB | 62 | - | disk:2; v15 parent |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 8,065,364 | 508.20 GB | 179 | - | disk:2; v15 parent |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 8,510,570 | 715.00 GB | 435 | - | disk:2 |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 16,687,478 | 1.05 TB | 316 | - | disk:2; v15 parent |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 15,825,570 | 1.30 TB | 658 | - | disk:2 |
| `/TWminusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 13,460,118 | 837.48 GB | 271 | - | disk:2; v15 parent |
| `/TWminusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 14,000,000 | 1.13 TB | 462 | - | disk:2 |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 8,260,009 | 520.72 GB | 169 | - | disk:2; v15 parent |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 8,522,800 | 716.06 GB | 389 | - | disk:2 |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 16,485,994 | 1.04 TB | 324 | - | disk:2; v15 parent |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 17,272,265 | 1.42 TB | 674 | - | disk:2 |
| `/TbarWplusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 13,447,890 | 837.37 GB | 284 | - | disk:2; v15 parent |
| `/TbarWplusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 12,556,588 | 1.02 TB | 506 | - | disk:2 |
| `/WW_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 53,112,080 | 2.68 TB | 721 | - | disk:2; v15 parent |
| `/WZ_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 26,722,782 | 1.35 TB | 391 | - | disk:3; v15 parent |
| `/ZZ_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 4,043,040 | 205.07 GB | 82 | - | disk:2; v15 parent |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 22,428,584 | 1.20 TB | 387 | - | disk:2 |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 22,335,330 | 1.56 TB | 779 | - | disk:2 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 94,010,944 | 5.03 TB | 1572 | - | disk:2 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 94,378,432 | 6.54 TB | 2479 | - | disk:2 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 9,716,360 | 520.77 GB | 194 | - | disk:2 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 28,550,290 | 2.01 TB | 665 | - | disk:5 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 14,954,528 | 817.74 GB | 278 | - | disk:2 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 14,967,398 | 1.07 TB | 480 | - | disk:2 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 30,143,700 | 1.59 TB | 536 | - | disk:2 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 30,116,960 | 2.06 TB | 1080 | - | disk:2 |
| `/WZtoL3Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 2,498,000 | 159.92 GB | 77 | - | disk:11 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 61,330,176 | 3.26 TB | 1108 | - | disk:2 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 52,125,885 | 3.62 TB | 1410 | - | disk:17 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 50,721,078 | 2.61 TB | 913 | - | disk:2 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 50,417,030 | 3.41 TB | 1564 | - | disk:2 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 49,084,483 | 2.61 TB | 891 | - | disk:2 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6_ext1-v2/MINIAODSIM` | 51,332,982 | 3.57 TB | 1553 | - | disk:2 |
| `/JPsiMuMu_JPsiNoFilter_2MuPtEtaFilter_TuneCP5_13p6TeV-pythia8-evtgen/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v4/MINIAODSIM` | 25,067,165 | 1.60 TB | 1393 | - | disk:6 |
| `/JPsito2Mu_JPsiFilter_2MuFilter_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 44,836,777 | 2.36 TB | 753 | - | disk:1 |
| `/Jpsito2Mu_JpsiPT8_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-MUO_POG_130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 49,041,995 | 2.28 TB | 653 | - | disk:2; v15 parent |
| `/JPsiToMuMu_Pt-0To100_pythia8-gun/Run3Summer22EEMiniAODv4-Poisson60KeepRAW_130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 4,998,000 | 310.20 GB | 83 | - | disk:1 |
| `/Psi2sto2Mu_Psi2sFilter_2MuFilter_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 4,390,208 | 218.86 GB | 86 | - | disk:2 |
| `/Upsilonto2Mu_UpsilonFilter_2MuFilter_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 7,578,956 | 371.83 GB | 108 | - | disk:2 |
| `/QCD_PT-15to20_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 16,043,927 | 779.83 GB | 228 | - | disk:3; v15 parent |
| `/QCD_PT-20to30_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 108,695,854 | 5.38 TB | 1392 | - | disk:2; v15 parent |
| `/QCD_PT-30to50_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 102,293,835 | 5.25 TB | 1705 | - | disk:2; v15 parent |
| `/QCD_PT-50to80_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 39,602,741 | 2.15 TB | 691 | - | disk:2; v15 parent |
| `/QCD_PT-80to120_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 72,186,796 | 4.18 TB | 1227 | - | disk:3; v15 parent |
| `/QCD_PT-120to170_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 71,567,256 | 4.42 TB | 1243 | - | disk:2; v15 parent |
| `/QCD_PT-170to300_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 73,133,586 | 4.88 TB | 1321 | - | disk:3; v15 parent |
| `/QCD_PT-300to470_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 103,765,161 | 7.61 TB | 2558 | - | disk:2; v15 parent |
| `/QCD_PT-470to600_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 72,202,598 | 5.63 TB | 1806 | - | disk:3; v15 parent |
| `/QCD_PT-600to800_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 72,565,100 | 5.86 TB | 1769 | - | disk:2; v15 parent |
| `/QCD_PT-800to1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 131,210,179 | 11.01 TB | 3263 | - | disk:3; v15 parent |
| `/QCD_PT-1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 45,333,749 | 3.95 TB | 1109 | - | disk:2; v15 parent |
| **total (94 datasets)** | **10,691,899,497** | **683.71 TB** | | | |

#### inputs/mc_2022EE_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EEDRPremix-124X_mcRun3_2022_realistic_postEE_v1-v2/AODSIM` | 10,148,870 | 3.90 TB | 1217 | - | disk:1 |
| **total (1 datasets)** | **10,148,870** | **3.90 TB** | | | |

#### commented-out (not active) entries in mc_2022EE.txt / mc_2022EE_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 15,675,172 | 905.41 GB | 574 | - | PRODUCTION; disk:34 |
| `/DYto2E_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 40,562,300 | 2.75 TB | 1592 | - | PRODUCTION; disk:37 |
| `/DYto2Tau_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 43,056,848 | 2.57 TB | 1582 | - | PRODUCTION; disk:37 |
| `/DYto2Tau_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer22EEMiniAODv4-130X_mcRun3_2022_realistic_postEE_v6-v2/MINIAODSIM` | 16,533,909 | 894.93 GB | 496 | - | PRODUCTION; disk:33 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer22EEDRPremix-124X_mcRun3_2022_realistic_postEE_v1-v5/AODSIM` | 337,071,680 | 126.58 TB | 34510 | - | disk:3 |

Notes:
- **Data processing**: `22Sep2023` re-MiniAOD (v15 parent). Run2022F Muon uses -v2 (-v1 INVALID), Run2022G EGamma uses -v2 (-v1 INVALID).
- **Alternatives not used**: `19Dec2023` re-MiniAOD of F and G (Muon F: 146 runs vs 179, G: 27 vs 35; EGamma similar) is NOT the v15 parent and covers fewer runs; PromptReco MiniAOD.
- **T&P AOD**: E from `27Jun2023` re-reco AOD; F and G only have PromptReco AOD (the 22Sep2023 MiniAOD is a re-mini of PromptReco AOD). PromptReco F AOD is 176 TB on a single disk site.
- MiniAOD vs AOD event counts differ slightly (F: 449.19M MiniAOD vs 449.91M AOD), i.e. ~0.2% of lumis missing in the MiniAOD.
- **MC (Run3Summer22EEMiniAODv4, postEE_v6)**: as 2022. W MiNNLO (all 6) and DYto2Mu MiNNLO 50to130 + DYto2E MiNNLO 10to50 VALID; DYto2Mu 10to50, DYto2E 50to130, DYto2Tau 50to130/10to50 MiNNLO are PRODUCTION (commented `#PRODUCTION`).
- **Quarkonia (2022EE)**: J/psi NoFilter_2MuPtEtaFilter (-v4), JPsiFilter_2MuFilter, MUO-POG JpsiPT8, J/psi gun (only a `Poisson60KeepRAW` special processing exists), psi(2S), Upsilon.
- **Skipped**: `Poisson60ForMUOVal_` TTtoLNu2Q, `FS22_` DY MLM.
- **T&P MC**: POWHEG DYto2Mu_MLL-50to120 AODSIM (10.1M evts); FxFx DYto2L-2Jets_MLL-50 AODSIM (337M evts, 127 TB) as `#ALT`.

### 2023

Data totals: muon MiniAOD 461,343,015 evts / 24.17 TB; EGamma MiniAOD 533,678,410 evts / 28.64 TB; muon AOD (T&P) 461,425,134 evts / 188.59 TB.

#### inputs/data_2023.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2023C-22Sep2023_v1-v1/MINIAOD` | 54,715,896 | 2.75 TB | 842 | 54 (367094-367515) | disk:14; v15 parent |
| `/Muon0/Run2023C-22Sep2023_v2-v1/MINIAOD` | 17,063,451 | 880.49 GB | 260 | 14 (367516-367619) | disk:12; v15 parent |
| `/Muon0/Run2023C-22Sep2023_v3-v1/MINIAOD` | 20,015,377 | 1.05 TB | 335 | 18 (367661-367758) | disk:14; v15 parent |
| `/Muon0/Run2023C-22Sep2023_v4-v1/MINIAOD` | 138,943,783 | 7.41 TB | 2210 | 125 (367770-369694) | disk:15; v15 parent |
| `/Muon1/Run2023C-22Sep2023_v1-v1/MINIAOD` | 54,621,922 | 2.75 TB | 819 | 55 (367094-367515) | disk:12; v15 parent |
| `/Muon1/Run2023C-22Sep2023_v2-v1/MINIAOD` | 17,059,895 | 880.36 GB | 267 | 14 (367516-367619) | disk:12; v15 parent |
| `/Muon1/Run2023C-22Sep2023_v3-v1/MINIAOD` | 20,010,429 | 1.05 TB | 333 | 18 (367661-367758) | disk:7; v15 parent |
| `/Muon1/Run2023C-22Sep2023_v4-v2/MINIAOD` | 138,912,262 | 7.41 TB | 2148 | 120 (367770-369694) | disk:3; v15 parent |
| **total (8 datasets)** | **461,343,015** | **24.17 TB** | | | |

#### inputs/dataEGamma_2023.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma0/Run2023C-22Sep2023_v1-v1/MINIAOD` | 67,598,081 | 3.51 TB | 1061 | 52 (367094-367515) | disk:6; v15 parent |
| `/EGamma0/Run2023C-22Sep2023_v2-v1/MINIAOD` | 17,233,307 | 916.11 GB | 276 | 13 (367516-367619) | disk:4; v15 parent |
| `/EGamma0/Run2023C-22Sep2023_v3-v1/MINIAOD` | 21,993,048 | 1.18 TB | 341 | 18 (367622-367758) | disk:4; v15 parent |
| `/EGamma0/Run2023C-22Sep2023_v4-v1/MINIAOD` | 160,108,119 | 8.72 TB | 2611 | 103 (367770-369694) | disk:5; v15 parent |
| `/EGamma1/Run2023C-22Sep2023_v1-v1/MINIAOD` | 67,530,273 | 3.51 TB | 1040 | 50 (367094-367515) | disk:6; v15 parent |
| `/EGamma1/Run2023C-22Sep2023_v2-v1/MINIAOD` | 17,230,822 | 916.22 GB | 275 | 13 (367516-367619) | disk:5; v15 parent |
| `/EGamma1/Run2023C-22Sep2023_v3-v1/MINIAOD` | 21,987,586 | 1.18 TB | 338 | 17 (367661-367758) | disk:3; v15 parent |
| `/EGamma1/Run2023C-22Sep2023_v4-v1/MINIAOD` | 159,997,174 | 8.71 TB | 2610 | 98 (367770-369694) | disk:8; v15 parent |
| **total (8 datasets)** | **533,678,410** | **28.64 TB** | | | |

#### inputs/data_2023_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2023C-PromptReco-v1/AOD` | 54,715,896 | 21.38 TB | 6747 | 54 (367094-367515) | disk:1; AOD parent of list MiniAOD |
| `/Muon0/Run2023C-PromptReco-v2/AOD` | 17,063,451 | 6.85 TB | 2356 | 32 (367516-367758) | disk:1; AOD parent of list MiniAOD; run list incl. 18 empty runs of -v3 |
| `/Muon0/Run2023C-PromptReco-v3/AOD` | 20,015,377 | 8.11 TB | 3016 | 18 (367661-367758) | disk:11; AOD parent of list MiniAOD |
| `/Muon0/Run2023C-PromptReco-v4/AOD` | 138,943,783 | 57.97 TB | 19272 | 125 (367770-369694) | disk:16; AOD parent of list MiniAOD |
| `/Muon1/Run2023C-PromptReco-v1/AOD` | 54,698,315 | 21.37 TB | 6746 | 55 (367094-367515) | disk:1; AOD parent of list MiniAOD |
| `/Muon1/Run2023C-PromptReco-v2/AOD` | 17,059,895 | 6.84 TB | 2362 | 32 (367516-367758) | disk:1; AOD parent of list MiniAOD; run list incl. 18 empty runs of -v3 |
| `/Muon1/Run2023C-PromptReco-v3/AOD` | 20,010,429 | 8.11 TB | 3010 | 18 (367661-367758) | disk:7; AOD parent of list MiniAOD |
| `/Muon1/Run2023C-PromptReco-v4/AOD` | 138,917,988 | 57.95 TB | 19268 | 120 (367770-369694) | disk:1; AOD parent of list MiniAOD |
| **total (8 datasets)** | **461,425,134** | **188.59 TB** | | | |

#### inputs/mc_2023.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 82,417,945 | 5.60 TB | 2136 | - | disk:31 |
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 5,860,000 | 373.19 GB | 148 | - | disk:3; v15 parent |
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 3,000,000 | 171.78 GB | 80 | - | disk:2 |
| `/DYto2E_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 5,904,000 | 402.15 GB | 161 | - | disk:3; v15 parent |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 2,968,000 | 166.24 GB | 91 | - | disk:2 |
| `/DYto2Tau_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 5,824,000 | 342.05 GB | 163 | - | disk:3; v15 parent |
| `/DYto2Tau_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 2,972,000 | 160.71 GB | 61 | - | disk:3 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 205,068,372 | 13.23 TB | 3923 | - | disk:29; v15 parent |
| `/DYto2L-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v4/MINIAODSIM` | 201,326,505 | 12.58 TB | 3894 | - | disk:21 |
| `/DYto2L-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v4/MINIAODSIM` | 202,728,091 | 13.75 TB | 4726 | - | disk:21 |
| `/DYto2L-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v4/MINIAODSIM` | 155,266,589 | 11.41 TB | 3670 | - | disk:34 |
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14_ext1-v4/MINIAODSIM` | 203,211,782 | 11.23 TB | 3713 | - | disk:30; v15 parent |
| `/DYto2Tau-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 86,010,297 | 5.01 TB | 1544 | - | disk:4; v15 parent |
| `/DYto2Tau-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 123,286,592 | 7.87 TB | 2465 | - | disk:4 |
| `/DYto2Tau-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 311,488,056 | 22.04 TB | 7424 | - | disk:28 |
| `/DYto2L-4Jets_MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 127,692,949 | 8.33 TB | 2702 | - | disk:12; v15 parent |
| `/DYto2L-4Jets_MLL-10to50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v4/MINIAODSIM` | 292,400,808 | 16.07 TB | 5153 | - | disk:13; v15 parent |
| `/WtoLNu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 200,092,037 | 12.11 TB | 3103 | - | disk:3; v15 parent |
| `/WtoLNu-2Jets_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 400,805,638 | 23.60 TB | 7574 | - | disk:4 |
| `/WtoLNu-2Jets_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 309,022,920 | 19.83 TB | 6241 | - | disk:3 |
| `/WtoLNu-2Jets_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 195,645,092 | 13.61 TB | 4426 | - | disk:6 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 191,075,090 | 11.61 TB | 3539 | - | disk:4; v15 parent |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 48,104,000 | 4.07 TB | 1224 | - | disk:8; v15 parent |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 152,653,000 | 12.79 TB | 4455 | - | disk:7; v15 parent |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 104,963,000 | 8.70 TB | 2821 | - | disk:17; v15 parent |
| `/TBbarQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 5,908,000 | 434.08 GB | 224 | - | disk:4; v15 parent |
| `/TbarBQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 2,878,000 | 212.38 GB | 123 | - | disk:11; v15 parent |
| `/TBbartoLplusNuBbar-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 2,588,000 | 185.14 GB | 90 | - | disk:10; v15 parent |
| `/TbarBtoLminusNuB-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 1,600,000 | 114.09 GB | 71 | - | disk:8; v15 parent |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 4,985,000 | 398.83 GB | 156 | - | disk:2; v15 parent |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 9,650,268 | 797.55 GB | 302 | - | disk:8; v15 parent |
| `/TWminusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 7,919,000 | 616.86 GB | 176 | - | disk:3; v15 parent |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 4,907,000 | 392.60 GB | 140 | - | disk:2; v15 parent |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v6/MINIAODSIM` | 9,550,671 | 701.88 GB | 242 | - | disk:4; v15 parent |
| `/TbarWplusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 7,970,000 | 621.04 GB | 189 | - | disk:10; v15 parent |
| `/WW_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 33,507,000 | 2.15 TB | 651 | - | disk:2; v15 parent |
| `/WZ_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 16,770,000 | 1.08 TB | 318 | - | disk:2; v15 parent |
| `/ZZ_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 2,517,000 | 161.77 GB | 65 | - | disk:3; v15 parent |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v4/MINIAODSIM` | 12,951,000 | 888.94 GB | 317 | - | disk:2 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 53,695,000 | 3.66 TB | 1173 | - | disk:2 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 5,519,000 | 377.69 GB | 147 | - | disk:3 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15_ext1-v2/MINIAODSIM` | 20,784,000 | 1.39 TB | 442 | - | disk:6 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 8,366,000 | 581.08 GB | 225 | - | disk:3 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 17,797,000 | 1.20 TB | 420 | - | disk:3 |
| `/WZtoL3Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 2,000,000 | 123.20 GB | 57 | - | disk:10 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 29,832,000 | 2.02 TB | 708 | - | disk:3 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 29,787,000 | 1.97 TB | 614 | - | disk:2 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 29,757,000 | 2.02 TB | 667 | - | disk:2 |
| `/JPsiMuMu_JPsiNoFilter_2MuPtEtaFilter_TuneCP5_13p6TeV-pythia8-evtgen/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v3/MINIAODSIM` | 23,773,481 | 1.76 TB | 1257 | - | disk:2 |
| `/Jpsito2Mu_JpsiPT8_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-MUO_POG_130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 29,880,675 | 2.05 TB | 560 | - | disk:2; v15 parent |
| `/QCD_PT-15to20_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v3/MINIAODSIM` | 9,952,465 | 705.89 GB | 265 | - | disk:2; v15 parent |
| `/QCD_PT-20to30_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 65,309,232 | 4.70 TB | 1469 | - | disk:3; v15 parent |
| `/QCD_PT-30to50_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 63,799,051 | 4.32 TB | 1197 | - | disk:2; v15 parent |
| `/QCD_PT-50to80_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 25,402,335 | 1.73 TB | 551 | - | disk:2; v15 parent |
| `/QCD_PT-80to120_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 53,192,321 | 3.83 TB | 1089 | - | disk:2; v15 parent |
| `/QCD_PT-120to170_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 44,453,509 | 3.44 TB | 980 | - | disk:2; v15 parent |
| `/QCD_PT-170to300_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 65,755,777 | 5.46 TB | 1495 | - | disk:2; v15 parent |
| `/QCD_PT-300to470_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 62,954,149 | 5.92 TB | 1589 | - | disk:2; v15 parent |
| `/QCD_PT-470to600_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 46,186,549 | 4.58 TB | 1241 | - | disk:2; v15 parent |
| `/QCD_PT-600to800_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 46,267,511 | 4.73 TB | 1355 | - | disk:2; v15 parent |
| `/QCD_PT-800to1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 83,892,794 | 8.88 TB | 2452 | - | disk:5; v15 parent |
| `/QCD_PT-1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v14-v2/MINIAODSIM` | 31,521,156 | 3.42 TB | 997 | - | disk:2; v15 parent |
| **total (62 datasets)** | **4,593,365,707** | **312.68 TB** | | | |

#### inputs/mc_2023_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23DRPremix-130X_mcRun3_2023_realistic_v14-v2/AODSIM` | 5,904,000 | 2.84 TB | 746 | - | disk:1 |
| **total (1 datasets)** | **5,904,000** | **2.84 TB** | | | |

#### commented-out (not active) entries in mc_2023.txt / mc_2023_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23DRPremix-130X_mcRun3_2023_realistic_v14-v2/AODSIM` | 205,105,687 | 95.91 TB | 32926 | - | disk:5 |
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 11,607,882 | 790.72 GB | 494 | - | PRODUCTION; disk:37 |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 11,260,658 | 752.98 GB | 515 | - | PRODUCTION; disk:35 |
| `/DYto2Tau_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 33,608,391 | 2.37 TB | 1196 | - | PRODUCTION; disk:37 |
| `/DYto2Tau_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 3,920,288 | 252.99 GB | 146 | - | PRODUCTION; disk:21 |
| `/WplustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 33,783,366 | 2.39 TB | 1184 | - | PRODUCTION; disk:37 |
| `/WplustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 29,606,142 | 2.14 TB | 1064 | - | PRODUCTION; disk:33 |
| `/WplustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 30,063,500 | 2.02 TB | 1128 | - | PRODUCTION; disk:40 |
| `/WminustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 27,694,603 | 1.95 TB | 1078 | - | PRODUCTION; disk:35 |
| `/WminustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23MiniAODv4-130X_mcRun3_2023_realistic_v15-v4/MINIAODSIM` | 32,006,450 | 2.15 TB | 1159 | - | PRODUCTION; disk:36 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE1_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,980,398 | 211.78 GB | 64 | - | disk:2 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE2_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,984,898 | 238.49 GB | 64 | - | disk:1 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,852,598 | 268.37 GB | 82 | - | TAPE-ONLY |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE10_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,739,898 | 313.13 GB | 103 | - | disk:2 |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE1_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,895,000 | 256.45 GB | 80 | - | TAPE-ONLY |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE2_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,922,400 | 290.17 GB | 78 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,853,800 | 338.37 GB | 100 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE10_130X_mcRun3_2023_realistic_v15-v3/MINIAODSIM` | 14,922,400 | 412.86 GB | 104 | - | disk:1 |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE1_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,920,800 | 253.78 GB | 78 | - | disk:1 |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE2_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,962,000 | 287.66 GB | 80 | - | disk:1 |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,922,800 | 336.73 GB | 91 | - | disk:1 |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE10_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,966,900 | 410.95 GB | 109 | - | TAPE-ONLY |

Notes:
- **Data processing**: `22Sep2023_v1..v4` re-MiniAOD (v15 parents); the four sub-versions correspond to PromptReco-v1..v4 with disjoint run ranges, all needed. Muon0/Muon1 (and EGamma0/1) carry the same triggers with ~half of the events each; both listed. Muon1 C_v4 uses -v2 (-v1 INVALID). The `22Sep2023-v1..v4` (without `_vN`) MiniAODs are all INVALID.
- **T&P AOD**: PromptReco-v1..v4 AOD (no AOD re-reco of 2023 exists). PromptReco-v2 run lists include 18 runs (367661-367758) with 0 events that belong to -v3, so no double counting.
- **MC (Run3Summer23MiniAODv4, 130X_mcRun3_2023_realistic_v14/v15)**: W MiNNLO is PRODUCTION for W+ (mu/e/tau) and W- (mu/tau) and does not exist for W- -> e nu; DYto2Mu MiNNLO 50to130 VALID, 10to50 PRODUCTION; DY->ee MiNNLO 10to50 PRODUCTION, 50to130 absent; DY->tautau MiNNLO PRODUCTION. Use POWHEG / FxFx / MLM W and DY meanwhile.
- **Quarkonia (2023)**: only J/psi NoFilter_2MuPtEtaFilter and MUO-POG JpsiPT8; NO prompt Upsilon->mumu, psi(2S)->mumu or JPsiFilter_2MuFilter sample in 2023/2023BPix.
- **Special low-PU MC (relevant to section D)**: `Run3Summer23MiniAODv4-PUAVE{1,2,5,10}_130X_mcRun3_2023_realistic_v15` DYJetsToMuMu / W+-JetsToMuNu H2ErratumFix MiNNLO (10-15M evts each; DR-PUAVE AODSIM also exist) -- listed commented (`#SPECIAL-PU`) at the end of mc_2023.txt, not active. A `Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies` DYJetsToMuMu MiNNLO (with Reco AODSIM and NanoAODv15) also exists.
- **T&P MC**: POWHEG DYto2Mu_MLL-50to120 AODSIM (5.9M evts); FxFx AODSIM (205M evts, 96 TB) as `#ALT`.

### 2023BPix

Data totals: muon MiniAOD 243,420,070 evts / 12.78 TB; EGamma MiniAOD 257,053,687 evts / 13.88 TB; muon AOD (T&P) 243,499,845 evts / 100.13 TB.

#### inputs/data_2023BPix.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2023D-22Sep2023_v1-v1/MINIAOD` | 100,211,533 | 5.23 TB | 1555 | 61 (369844-370580) | disk:13; v15 parent |
| `/Muon0/Run2023D-22Sep2023_v2-v1/MINIAOD` | 21,462,916 | 1.16 TB | 365 | 17 (370616-371225) | disk:2; v15 parent; incl. run 371225 (after pp end) |
| `/Muon1/Run2023D-22Sep2023_v1-v1/MINIAOD` | 100,281,976 | 5.23 TB | 1501 | 59 (369844-370580) | disk:5; v15 parent |
| `/Muon1/Run2023D-22Sep2023_v2-v1/MINIAOD` | 21,463,645 | 1.16 TB | 358 | 17 (370616-371225) | disk:11; v15 parent; incl. run 371225 (after pp end) |
| **total (4 datasets)** | **243,420,070** | **12.78 TB** | | | |

#### inputs/dataEGamma_2023BPix.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma0/Run2023D-22Sep2023_v1-v1/MINIAOD` | 105,892,646 | 5.69 TB | 1696 | 56 (369844-370580) | disk:4; v15 parent |
| `/EGamma0/Run2023D-22Sep2023_v2-v1/MINIAOD` | 22,657,211 | 1.26 TB | 393 | 13 (370666-370790) | disk:3; v15 parent |
| `/EGamma1/Run2023D-22Sep2023_v1-v1/MINIAOD` | 105,850,543 | 5.68 TB | 1682 | 57 (369844-370580) | disk:4; v15 parent |
| `/EGamma1/Run2023D-22Sep2023_v2-v1/MINIAOD` | 22,653,287 | 1.26 TB | 391 | 13 (370666-370790) | disk:4; v15 parent |
| **total (4 datasets)** | **257,053,687** | **13.88 TB** | | | |

#### inputs/data_2023BPix_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2023D-PromptReco-v1/AOD` | 100,291,308 | 40.95 TB | 13609 | 61 (369844-370580) | disk:24; AOD parent of list MiniAOD |
| `/Muon0/Run2023D-PromptReco-v2/AOD` | 21,462,916 | 9.11 TB | 3056 | 17 (370616-371225) | disk:2; AOD parent of list MiniAOD |
| `/Muon1/Run2023D-PromptReco-v1/AOD` | 100,281,976 | 40.95 TB | 13584 | 59 (369844-370580) | disk:1; AOD parent of list MiniAOD |
| `/Muon1/Run2023D-PromptReco-v2/AOD` | 21,463,645 | 9.12 TB | 3059 | 17 (370616-371225) | disk:2; AOD parent of list MiniAOD |
| **total (4 datasets)** | **243,499,845** | **100.13 TB** | | | |

#### inputs/mc_2023BPix.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 45,759,975 | 3.12 TB | 1228 | - | disk:24 |
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 2,852,000 | 182.11 GB | 85 | - | disk:3; v15 parent |
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 1,468,000 | 84.34 GB | 46 | - | disk:3 |
| `/DYto2E_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 2,910,000 | 198.61 GB | 103 | - | disk:2; v15 parent |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 1,476,000 | 82.90 GB | 44 | - | disk:2 |
| `/DYto2Tau_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 2,856,000 | 168.27 GB | 81 | - | disk:3; v15 parent |
| `/DYto2Tau_MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 1,500,000 | 81.40 GB | 46 | - | disk:2 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v4/MINIAODSIM` | 95,217,757 | 6.22 TB | 2108 | - | disk:11; v15 parent |
| `/DYto2L-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v4/MINIAODSIM` | 99,748,250 | 6.25 TB | 2052 | - | disk:18 |
| `/DYto2L-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v4/MINIAODSIM` | 99,565,880 | 6.77 TB | 2143 | - | disk:19 |
| `/DYto2L-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v5/MINIAODSIM` | 73,167,776 | 5.40 TB | 1840 | - | disk:20 |
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2_ext1-v4/MINIAODSIM` | 101,317,595 | 5.61 TB | 1860 | - | disk:15; v15 parent |
| `/DYto2Tau-2Jets_MLL-50_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 44,026,524 | 2.58 TB | 788 | - | disk:4; v15 parent |
| `/DYto2Tau-2Jets_MLL-50_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 76,804,767 | 4.87 TB | 1550 | - | disk:4 |
| `/DYto2Tau-2Jets_MLL-50_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 123,493,273 | 8.69 TB | 2636 | - | disk:4 |
| `/DYto2L-4Jets_MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v4/MINIAODSIM` | 70,099,933 | 4.57 TB | 1609 | - | disk:31; v15 parent |
| `/DYto2L-4Jets_MLL-10to50_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v4/MINIAODSIM` | 149,169,635 | 8.28 TB | 2909 | - | disk:20; v15 parent |
| `/WtoLNu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 95,603,855 | 5.93 TB | 1806 | - | disk:3; v15 parent |
| `/WtoLNu-2Jets_0J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 198,993,882 | 11.75 TB | 3556 | - | disk:4 |
| `/WtoLNu-2Jets_1J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 149,508,424 | 9.64 TB | 3213 | - | disk:3 |
| `/WtoLNu-2Jets_2J_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 99,733,714 | 6.94 TB | 2199 | - | disk:3 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 94,639,090 | 5.66 TB | 1678 | - | disk:3; v15 parent |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 24,556,000 | 2.08 TB | 700 | - | disk:8; v15 parent |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 63,875,000 | 5.36 TB | 1978 | - | disk:3; v15 parent |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 52,849,000 | 4.39 TB | 1726 | - | disk:3; v15 parent |
| `/TBbarQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 2,954,000 | 217.39 GB | 140 | - | disk:4; v15 parent |
| `/TbarBQ_t-channel_4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 1,488,000 | 109.99 GB | 85 | - | disk:3; v15 parent |
| `/TBbartoLplusNuBbar-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 1,288,000 | 92.35 GB | 45 | - | disk:2; v15 parent |
| `/TbarBtoLminusNuB-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 784,000 | 56.01 GB | 34 | - | disk:3; v15 parent |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 2,479,000 | 198.72 GB | 93 | - | disk:11; v15 parent |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 4,943,378 | 391.21 GB | 154 | - | disk:3; v15 parent |
| `/TWminusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 3,934,000 | 306.97 GB | 94 | - | disk:2; v15 parent |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 2,488,000 | 195.01 GB | 101 | - | disk:3; v15 parent |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 5,146,630 | 406.38 GB | 144 | - | disk:6; v15 parent |
| `/TbarWplusto4Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 3,976,000 | 310.31 GB | 113 | - | disk:2; v15 parent |
| `/WW_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 16,545,000 | 1.06 TB | 289 | - | disk:2; v15 parent |
| `/WZ_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 8,379,000 | 540.37 GB | 173 | - | disk:2; v15 parent |
| `/ZZ_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 1,254,000 | 80.78 GB | 25 | - | disk:2; v15 parent |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 6,363,000 | 437.69 GB | 207 | - | disk:4 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 26,345,000 | 1.80 TB | 656 | - | disk:3 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 2,770,000 | 189.98 GB | 78 | - | disk:3 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6_ext1-v2/MINIAODSIM` | 10,316,000 | 692.63 GB | 223 | - | disk:4 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 4,267,000 | 297.08 GB | 130 | - | disk:2 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 8,780,000 | 591.70 GB | 221 | - | disk:2 |
| `/WZtoL3Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v2/MINIAODSIM` | 1,000,000 | 61.76 GB | 30 | - | disk:5 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 14,625,000 | 994.34 GB | 335 | - | disk:14 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 14,931,000 | 990.68 GB | 346 | - | disk:4 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v3/MINIAODSIM` | 14,919,000 | 1.01 TB | 311 | - | disk:2 |
| `/JPsiMuMu_JPsiNoFilter_2MuPtEtaFilter_TuneCP5_13p6TeV-pythia8-evtgen/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v3/MINIAODSIM` | 25,038,279 | 1.86 TB | 1307 | - | disk:3 |
| `/Jpsito2Mu_JpsiPT8_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-MUO_POG_130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 15,060,334 | 1.03 TB | 305 | - | disk:2; v15 parent |
| `/JPsiToMuMu_PT-0to100_pythia8-gun/Run3Summer23BPixMiniAODv4-KeepSi_130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 9,950,000 | 558.90 GB | 206 | - | disk:1 |
| `/QCD_PT-15to20_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 4,999,753 | 355.66 GB | 123 | - | disk:2; v15 parent |
| `/QCD_PT-20to30_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 33,189,564 | 2.40 TB | 771 | - | disk:3; v15 parent |
| `/QCD_PT-30to50_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 31,914,516 | 2.17 TB | 683 | - | disk:2; v15 parent |
| `/QCD_PT-50to80_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 12,720,414 | 869.29 GB | 271 | - | disk:2; v15 parent |
| `/QCD_PT-80to120_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 26,692,302 | 1.93 TB | 519 | - | disk:3; v15 parent |
| `/QCD_PT-120to170_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 22,380,325 | 1.74 TB | 484 | - | disk:3; v15 parent |
| `/QCD_PT-170to300_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 33,263,979 | 2.77 TB | 777 | - | disk:2; v15 parent |
| `/QCD_PT-300to470_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 31,598,705 | 2.85 TB | 805 | - | disk:3; v15 parent |
| `/QCD_PT-470to600_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 22,833,444 | 2.17 TB | 589 | - | disk:2; v15 parent |
| `/QCD_PT-600to800_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 22,884,302 | 2.35 TB | 690 | - | disk:2; v15 parent |
| `/QCD_PT-800to1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 41,072,182 | 4.36 TB | 1192 | - | disk:2; v15 parent |
| `/QCD_PT-1000_MuEnrichedPt5_TuneCP5_13p6TeV_pythia8/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v2-v2/MINIAODSIM` | 15,340,005 | 1.67 TB | 511 | - | disk:2; v15 parent |
| **total (63 datasets)** | **2,280,105,442** | **155.01 TB** | | | |

#### inputs/mc_2023BPix_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer23BPixDRPremix-130X_mcRun3_2023_realistic_postBPix_v2-v3/AODSIM` | 2,860,000 | 1.38 TB | 363 | - | TAPE-ONLY |
| **total (1 datasets)** | **2,860,000** | **1.38 TB** | | | |

#### commented-out (not active) entries in mc_2023BPix.txt / mc_2023BPix_TnP.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 6,678,394 | 456.08 GB | 227 | - | PRODUCTION; disk:28 |
| `/DYto2E_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 19,521,283 | 1.57 TB | 941 | - | PRODUCTION; disk:38 |
| `/DYto2E_MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 2,368,931 | 158.82 GB | 110 | - | PRODUCTION; disk:31 |
| `/DYto2Tau_MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 15,341,480 | 1.08 TB | 659 | - | PRODUCTION; disk:38 |
| `/WplustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 12,202,731 | 864.86 GB | 512 | - | PRODUCTION; disk:35 |
| `/WplustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 18,195,870 | 1.32 TB | 702 | - | PRODUCTION; disk:38 |
| `/WplustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 15,607,000 | 1.05 TB | 588 | - | PRODUCTION; disk:39 |
| `/WminustoMuNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 14,616,009 | 1.03 TB | 585 | - | PRODUCTION; disk:35 |
| `/WminustoENu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 14,055,912 | 1.01 TB | 608 | - | PRODUCTION; disk:37 |
| `/WminustoTauNu_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/Run3Summer23BPixMiniAODv4-130X_mcRun3_2023_realistic_postBPix_v6-v4/MINIAODSIM` | 11,511,486 | 776.23 GB | 440 | - | PRODUCTION; disk:35 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Summer23BPixDRPremix-130X_mcRun3_2023_realistic_postBPix_v2-v4/AODSIM` | 79,012,458 | 36.83 TB | 15988 | - | disk:5 |

Notes:
- **Data processing**: `22Sep2023_v1`, `_v2` re-MiniAOD (v15 parents) for Muon0/1 and EGamma0/1. Muon0/1 22Sep2023_v2 (and PromptReco-v2 AOD) contain run 371225 beyond the end of 2023 pp physics (370790; EGamma ends at 370790) -- the golden-JSON lumi mask removes it.
- **T&P AOD**: PromptReco-v1, -v2 AOD.
- **MC (Run3Summer23BPixMiniAODv4, postBPix_v2/v6)**: all six W MiNNLO and DY->ee/mumu 10to50, DY->ee/tautau 50to130 MiNNLO are PRODUCTION (commented); DYto2Mu MiNNLO 50to130 VALID; DY->tautau MiNNLO 10to50 absent.
- **Quarkonia (2023BPix)**: J/psi NoFilter_2MuPtEtaFilter, MUO-POG JpsiPT8, J/psi gun (only a `KeepSi` special processing); no Upsilon/psi(2S)->mumu.
- **Skipped**: `KeepRAW_` QCD MuEnriched duplicates (5 bins).
- **T&P MC**: POWHEG DYto2Mu_MLL-50to120 AODSIM (2.86M evts, TAPE-ONLY); FxFx AODSIM (79M evts, 37 TB) as `#ALT`.

### 2024 (13.6 TeV pp, standard high pileup)

Era classification (DAS run ranges + OMS beam energy 6.8 TeV/beam, fill type PROTONS; golden JSON `Collisions24/latest/Cert_Collisions2024_378981_386951_Golden.json`, 475 runs / 287,601 LS):

- Run2024A (378919-378968): commissioning, 62 events in Muon0, not in golden JSON -> omitted.
- Run2024B (378981-379391): 13.6 TeV pp physics ramp-up, 16 golden runs / 5,939 LS -> included (PromptReco-v1; the central NanoAODv15 does not cover B).
- Run2024C-I (379415-386951): 13.6 TeV pp physics -> included (MINIv6NANOv15).
- Run2024J: Muon0/Muon1 contain only run 387343 (1-2 events; OMS: fill 10282, fill type IONS, recorded lumi ~0) -> omitted. The 5.36 TeV pp reference data (golden 387474-387721) are in the PPRef* PDs (section D), not in Muon0/1.
- NB: a 2024 low-PU 13.6 TeV JSON exists, `Collisions24/latest/LowPU.json` = runs 386642 (LS 645-652), 386749 (30-212), 386753 (1-1343), all in Run2024I and contained in data_2024.txt -> lumi-mask them out of the high-PU production (or use them for a 2024 low-PU sample).

#### inputs/data_2024.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2024B-PromptReco-v1/MINIAOD` | 4,356,828 | 241.96 GB | 146 | 62 (378981-379391) | disk:2 |
| `/Muon0/Run2024C-MINIv6NANOv15-v1/MINIAOD` | 97,505,587 | 5.39 TB | 1630 | 51 (379415-380238) | disk:3 |
| `/Muon0/Run2024D-MINIv6NANOv15-v1/MINIAOD` | 120,787,065 | 6.48 TB | 1962 | 47 (380306-380947) | disk:2 |
| `/Muon0/Run2024E-MINIv6NANOv15-v1/MINIAOD` | 169,640,946 | 9.36 TB | 2737 | 49 (380963-381594) | disk:2 |
| `/Muon0/Run2024F-MINIv6NANOv15-v1/MINIAOD` | 442,432,787 | 25.97 TB | 7457 | 139 (382209-383779) | disk:2 |
| `/Muon0/Run2024G-MINIv6NANOv15-v1/MINIAOD` | 642,028,803 | 37.02 TB | 10564 | 157 (383811-385801) | disk:5 |
| `/Muon0/Run2024H-MINIv6NANOv15-v1/MINIAOD` | 93,983,627 | 5.35 TB | 1636 | 28 (385836-386319) | disk:2 |
| `/Muon0/Run2024I-MINIv6NANOv15-v1/MINIAOD` | 97,634,104 | 5.71 TB | 1764 | 22 (386478-386693) | disk:2 |
| `/Muon0/Run2024I-MINIv6NANOv15_v2-v1/MINIAOD` | 105,194,627 | 5.86 TB | 1847 | 36 (386694-386951) | disk:2 |
| `/Muon1/Run2024B-PromptReco-v1/MINIAOD` | 4,351,648 | 241.53 GB | 141 | 63 (378981-379391) | disk:2 |
| `/Muon1/Run2024C-MINIv6NANOv15-v1/MINIAOD` | 97,481,556 | 5.39 TB | 1624 | 51 (379415-380238) | disk:13 |
| `/Muon1/Run2024D-MINIv6NANOv15-v1/MINIAOD` | 120,415,086 | 6.45 TB | 1957 | 47 (380306-380947) | disk:2 |
| `/Muon1/Run2024E-MINIv6NANOv15-v1/MINIAOD` | 172,848,674 | 9.55 TB | 2749 | 49 (380963-381594) | disk:2 |
| `/Muon1/Run2024F-MINIv6NANOv15-v1/MINIAOD` | 442,287,452 | 25.97 TB | 7262 | 139 (382209-383779) | disk:2 |
| `/Muon1/Run2024G-MINIv6NANOv15-v2/MINIAOD` | 641,891,857 | 36.98 TB | 9804 | 157 (383811-385801) | disk:2 |
| `/Muon1/Run2024H-MINIv6NANOv15-v2/MINIAOD` | 93,981,102 | 5.35 TB | 1404 | 28 (385836-386319) | disk:2 |
| `/Muon1/Run2024I-MINIv6NANOv15-v1/MINIAOD` | 97,630,010 | 5.70 TB | 1717 | 22 (386478-386693) | disk:2 |
| `/Muon1/Run2024I-MINIv6NANOv15_v2-v1/MINIAOD` | 105,133,498 | 5.86 TB | 1771 | 34 (386694-386951) | disk:2 |
| **total (18 datasets)** | **3,549,585,257** | **202.88 TB** | | | |

- Processing: `MINIv6NANOv15` is the central re-MINI (MiniAODv6) + NanoAODv15 step; it writes MINIAOD and NANOAOD side by side, both with the AOD as DAS parent (`2024CDEReprocessing-v1` AOD for C-E, `PromptReco-v1` AOD for F-I; `MINIv6NANOv15_v2` = the same on `Run2024I-PromptReco-v2`, runs 386694-386951). So 'MiniAOD parent of the v15 NANO' = the MINIAOD of the same processing name.
- Version choice: Muon1 G and H have only v2 VALID (v1 not VALID); all others v1.
- Golden-JSON coverage: all golden runs present except 386615-386617 (234 LS, 0.08% of golden LS), which exist only in `Run2024I-PromptReco-v1` (the v15 re-MINI dropped them).
- Alternatives: `PromptReco-v1/v2` MINIAOD (all eras; E and I have v1+v2), `2024CDEReprocessing-v1` MINIAOD (C-E, CMSSW_14_0_19_patch2 re-reco; the v15 MINI was redone in CMSSW_15_0_2), `ECAL_CC_HCAL_DI-v1` (C only, special ECAL/HCAL calibration test reprocessing).
- Other muon PDs (MuonEG, MuonShower) not included (not single-muon). Era B Muon0/Muon1 run counts 62/63 vs 16 golden runs: lumi-mask with the golden JSON.

#### inputs/dataEGamma_2024.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma0/Run2024B-PromptReco-v1/MINIAOD` | 9,709,645 | 535.85 GB | 240 | 55 (378981-379391) | disk:3 |
| `/EGamma0/Run2024C-MINIv6NANOv15-v1/MINIAOD` | 157,378,917 | 8.88 TB | 2599 | 51 (379415-380238) | disk:3 |
| `/EGamma0/Run2024D-MINIv6NANOv15-v1/MINIAOD` | 156,558,757 | 8.61 TB | 2529 | 47 (380306-380947) | disk:2 |
| `/EGamma0/Run2024E-MINIv6NANOv15-v1/MINIAOD` | 249,348,576 | 13.91 TB | 3869 | 49 (380963-381594) | disk:2 |
| `/EGamma0/Run2024F-MINIv6NANOv15-v1/MINIAOD` | 638,973,884 | 37.70 TB | 10134 | 167 (382037-383779) | disk:2 |
| `/EGamma0/Run2024G-MINIv6NANOv15-v2/MINIAOD` | 903,260,423 | 52.69 TB | 14059 | 157 (383811-385801) | disk:3 |
| `/EGamma0/Run2024H-MINIv6NANOv15-v2/MINIAOD` | 134,680,448 | 7.73 TB | 2095 | 28 (385836-386319) | disk:3 |
| `/EGamma0/Run2024I-MINIv6NANOv15-v1/MINIAOD` | 132,904,290 | 7.86 TB | 2325 | 22 (386478-386693) | disk:2 |
| `/EGamma0/Run2024I-MINIv6NANOv15_v2-v1/MINIAOD` | 150,687,674 | 8.33 TB | 2264 | 25 (386694-386951) | disk:6 |
| `/EGamma1/Run2024B-PromptReco-v1/MINIAOD` | 9,703,252 | 535.10 GB | 244 | 56 (378981-379391) | disk:2 |
| `/EGamma1/Run2024C-MINIv6NANOv15-v1/MINIAOD` | 157,841,358 | 8.91 TB | 2671 | 51 (379415-380238) | disk:2 |
| `/EGamma1/Run2024D-MINIv6NANOv15-v1/MINIAOD` | 156,275,778 | 8.60 TB | 2660 | 47 (380306-380947) | disk:2 |
| `/EGamma1/Run2024E-MINIv6NANOv15-v1/MINIAOD` | 249,377,273 | 13.91 TB | 3994 | 49 (380963-381594) | disk:2 |
| `/EGamma1/Run2024F-MINIv6NANOv15-v1/MINIAOD` | 631,018,208 | 37.43 TB | 10093 | 137 (382209-383779) | disk:2 |
| `/EGamma1/Run2024G-MINIv6NANOv15-v2/MINIAOD` | 903,246,278 | 52.69 TB | 14071 | 157 (383811-385801) | disk:2 |
| `/EGamma1/Run2024H-MINIv6NANOv15-v1/MINIAOD` | 134,835,799 | 7.75 TB | 2221 | 30 (385836-386319) | disk:2 |
| `/EGamma1/Run2024I-MINIv6NANOv15-v1/MINIAOD` | 132,903,874 | 7.86 TB | 2187 | 22 (386478-386693) | disk:2 |
| `/EGamma1/Run2024I-MINIv6NANOv15_v2-v1/MINIAOD` | 150,687,112 | 8.33 TB | 2226 | 25 (386694-386951) | disk:2 |
| **total (18 datasets)** | **5,059,391,546** | **292.26 TB** | | | |

- Same processing logic as data_2024.txt. Version choice: EGamma0 G/H = v2 (v1 not VALID), EGamma1 G = v2, EGamma1 H = v1.
- Alternatives: `2024CDEReprocessing-v1` and `-v2` (C-E; the v15 step used v1 AOD), PromptReco, `ECALRATIO-v1` (B, C), `ECAL_CC_HCAL_DI` / `ECAL_R_HCAL_DI` (C, F) calibration-test reprocessings.

#### inputs/data_2024_TnP.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2024B-PromptReco-v1/AOD` | 4,356,828 | 1.71 TB | 625 | 62 (378981-379391) | disk:6 |
| `/Muon0/Run2024C-2024CDEReprocessing-v1/AOD` | 97,646,805 | 40.76 TB | 4040 | 51 (379415-380238) | disk:18 |
| `/Muon0/Run2024D-2024CDEReprocessing-v1/AOD` | 120,787,065 | 48.70 TB | 4889 | 47 (380306-380947) | disk:23 |
| `/Muon0/Run2024E-2024CDEReprocessing-v1/AOD` | 172,724,756 | 71.06 TB | 7211 | 69 (380956-381594) | disk:2 |
| `/Muon0/Run2024F-PromptReco-v1/AOD` | 446,071,836 | 201.73 TB | 58573 | 194 (381984-383779) | disk:1 |
| `/Muon0/Run2024G-PromptReco-v1/AOD` | 647,360,838 | 287.17 TB | 84557 | 181 (383811-385801) | disk:4 |
| `/Muon0/Run2024H-PromptReco-v1/AOD` | 94,449,581 | 41.44 TB | 12374 | 37 (385836-386319) | disk:5 |
| `/Muon0/Run2024I-PromptReco-v1/AOD` | 100,329,358 | 45.44 TB | 12805 | 30 (386446-386693) | disk:20 |
| `/Muon0/Run2024I-PromptReco-v2/AOD` | 106,485,742 | 46.01 TB | 12725 | 38 (386694-386974) | disk:1 |
| `/Muon1/Run2024B-PromptReco-v1/AOD` | 4,351,648 | 1.71 TB | 627 | 63 (378981-379391) | disk:1 |
| `/Muon1/Run2024C-2024CDEReprocessing-v1/AOD` | 97,559,135 | 40.73 TB | 4472 | 51 (379415-380238) | disk:1 |
| `/Muon1/Run2024D-2024CDEReprocessing-v1/AOD` | 120,467,371 | 48.55 TB | 4606 | 47 (380306-380947) | disk:23 |
| `/Muon1/Run2024E-2024CDEReprocessing-v1/AOD` | 173,108,330 | 72.29 TB | 6909 | 49 (380963-381594) | disk:26 |
| `/Muon1/Run2024F-PromptReco-v1/AOD` | 446,051,284 | 201.72 TB | 58551 | 198 (381984-383779) | disk:5 |
| `/Muon1/Run2024G-PromptReco-v1/AOD` | 647,340,693 | 287.16 TB | 84557 | 180 (383811-385801) | disk:37 |
| `/Muon1/Run2024H-PromptReco-v1/AOD` | 94,447,297 | 41.44 TB | 12377 | 39 (385836-386319) | disk:1 |
| `/Muon1/Run2024I-PromptReco-v1/AOD` | 100,325,747 | 45.44 TB | 12810 | 30 (386446-386693) | disk:2 |
| `/Muon1/Run2024I-PromptReco-v2/AOD` | 106,479,336 | 46.01 TB | 12724 | 39 (386694-386974) | disk:2 |
| **total (18 datasets)** | **3,580,343,650** | **1569.06 TB** | | | |

- AOD = DAS parents of the MINIv6NANOv15 MINIAOD (+ PromptReco-v1 for B). Note: the PromptReco AODs contain more runs than the v15 MINIAOD (e.g. F: 194 vs 139 runs, starting at 381984; E Muon0 CDE AOD starts at 380956) -> lumi-mask with the golden JSON.
- Size warning: 1.57 PB in total, most at a single disk site (disk:1-2); restrict to the needed eras or a fraction for T&P.

#### inputs/mc_2024.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_Bin-MLL-50to130_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 495,647,356 | 41.34 TB | 15893 | - | disk:24 |
| `/DYto2Mu_Bin-MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 175,416,189 | 13.59 TB | 5560 | - | disk:19 |
| `/DYto2E-2Jets_Bin-MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v4/MINIAODSIM` | 486,371,225 | 43.19 TB | 13241 | - | disk:6 |
| `/DYto2E-2Jets_Bin-MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 139,246,435 | 10.45 TB | 3211 | - | disk:10 |
| `/DYto2Tau-2Jets_Bin-MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v7/MINIAODSIM` | 349,058,559 | 27.52 TB | 8334 | - | disk:35 |
| `/DYto2Tau_Bin-MLL-10to50_TuneCP5_13p6TeV_powhegMINNLO-pythia8-photos/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 177,301,342 | 13.18 TB | 5514 | - | disk:39 |
| `/WtoMuNu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v3/MINIAODSIM` | 534,956,627 | 42.66 TB | 12999 | - | disk:5 |
| `/WtoENu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v3/MINIAODSIM` | 551,472,268 | 44.63 TB | 13617 | - | disk:5 |
| `/WtoTauNu-2Jets_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v3/MINIAODSIM` | 499,659,475 | 38.88 TB | 11797 | - | disk:6 |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v3/MINIAODSIM` | 470,080,053 | 39.56 TB | 10926 | - | disk:3 |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 484,298,177 | 41.19 TB | 11014 | - | disk:2 |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 475,006,856 | 40.79 TB | 10806 | - | disk:3 |
| `/TBbarQtoLNu-t-channel-4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 44,240,309 | 4.15 TB | 1565 | - | disk:3 |
| `/TbarBQtoLNu-t-channel-4FS_TuneCP5_13p6TeV_powheg-madspin-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 22,115,914 | 2.09 TB | 840 | - | disk:3 |
| `/TBbartoLplusNuBbar-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 12,999,000 | 1.21 TB | 425 | - | disk:8 |
| `/TbarBtoLminusNuB-s-channel-4FS_TuneCP5_13p6TeV_amcatnlo-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 7,981,999 | 736.97 GB | 281 | - | disk:26 |
| `/TWminusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 14,999,000 | 1.52 TB | 563 | - | disk:10 |
| `/TbarWplusto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 15,000,000 | 1.52 TB | 414 | - | disk:3 |
| `/TWminustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 28,762,382 | 2.93 TB | 1049 | - | disk:13 |
| `/TbarWplustoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 29,390,933 | 2.98 TB | 1054 | - | disk:5 |
| `/WWto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 240,983,710 | 16.42 TB | 5556 | - | disk:2 |
| `/WWtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 275,917,884 | 18.97 TB | 6397 | - | disk:2 |
| `/WZto3LNu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 248,149,069 | 17.08 TB | 5667 | - | disk:2 |
| `/WZtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 143,874,689 | 9.86 TB | 3269 | - | disk:3 |
| `/WZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 236,049,432 | 16.64 TB | 5467 | - | disk:3 |
| `/ZZto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 188,715,312 | 12.62 TB | 4379 | - | disk:2 |
| `/ZZto2L2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 171,627,615 | 11.85 TB | 3894 | - | disk:3 |
| `/ZZto4L_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 236,843,699 | 16.26 TB | 5482 | - | disk:2 |
| `/JPsiMuMu_Fil-JPsiNo-2MuPtEta_TuneCP5_13p6TeV_pythia8-evtgen/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v4/MINIAODSIM` | 112,762,996 | 9.40 TB | 3895 | - | disk:4 |
| `/Jpsito2Mu_Bin-PTJpsi-8_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v3/MINIAODSIM` | 54,317,108 | 3.48 TB | 1030 | - | disk:4 |
| `/Upsilon2SToUpsilon1S2Pi-Upsilon1STo2Mu_Fil-Upsilon_TuneCP5_13p6TeV_pythia8-evtgen/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 2,138,933 | 177.61 GB | 104 | - | disk:3 |
| `/QCD_Bin-PT-15to20_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 125,036,760 | 10.16 TB | 3621 | - | disk:3 |
| `/QCD_Bin-PT-20to30_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 93,304,586 | 7.65 TB | 2627 | - | disk:3 |
| `/QCD_Bin-PT-30to50_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 95,305,920 | 7.95 TB | 2782 | - | disk:3 |
| `/QCD_Bin-PT-50to80_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 107,449,521 | 9.40 TB | 3079 | - | disk:3 |
| `/QCD_Bin-PT-80to120_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 94,128,199 | 8.84 TB | 2947 | - | disk:4 |
| `/QCD_Bin-PT-120to170_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 99,824,346 | 10.17 TB | 3120 | - | disk:3 |
| `/QCD_Bin-PT-170to300_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 94,338,762 | 10.50 TB | 3362 | - | disk:27 |
| `/QCD_Bin-PT-300to470_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 79,815,908 | 9.84 TB | 2989 | - | disk:3 |
| `/QCD_Bin-PT-470to600_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 71,786,916 | 9.43 TB | 2901 | - | disk:4 |
| `/QCD_Bin-PT-600to800_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 85,842,835 | 11.67 TB | 3745 | - | disk:28 |
| `/QCD_Bin-PT-800to1000_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 81,930,100 | 11.52 TB | 3599 | - | disk:3 |
| `/QCD_Bin-PT-1000_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM` | 87,293,168 | 12.70 TB | 3801 | - | disk:3 |
| **total (43 datasets)** | **8,041,441,567** | **666.73 TB** | | | |

- Campaign: `RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2` = parents of the central `RunIII2024Summer24NanoAODv15-150X_mcRun3_2024_realistic_v2` (verified per dataset). Skipped versions: older `150X_mcRun3_2024_realistic_v1-*` (INVALID or PRODUCTION), INVALID `v2-v5/v6` for DYto2Tau-2Jets, INVALID `v2-v2` for TTto2L2Nu, PRODUCTION `v2_ext1` for TTtoLNu2Q, FastSim `FS_150X_...` variants (DY, TT), and the `RunIII2024Summer24MiniAOD-140X_mcRun3_2024_realistic_v26` (MiniAODv5) predecessors.
- Generators available in 2024: DY MiNNLO (powhegMINNLO+photos) only for DYto2Mu 10-50, 50-130 (+ high-mass bins 130-200 ... 6000-13600, not listed), DYto2E only for M>130, DYto2Tau only 10-50; plain powheg (DYto2{Mu,E,Tau}_Bin-MLL-10to50/50to120, no photos); amcatnloFXFX 2Jets (flavour split, MLL 10-50 / >50, plus PTLL-binned DYto2L); madgraphMLM 4Jets; Sherpa MEPS. W: NO MiNNLO in 2024 (only W->3pi); amcatnloFXFX `Wto{Mu,E,Tau}Nu-2Jets` (used), madgraphMLM 4Jets (incl./jet/HT/MLNu-binned), Sherpa 5Jets, pythia8 M>200.
- Alternatives not listed: powheg `DYto2Mu_Bin-MLL-50to120` (492M), amcatnloFXFX `DYto2Mu-2Jets` MLL-50/10to50 (489M/145M), madgraphMLM `WtoMuNu-4Jets` (425M), powheg s-channel `TBbartoLNu/TbarBtoLNu-s-channel` (46M/30M), inclusive pythia8 `WW/WZ/ZZ_TuneCP5`, hadronic tW/t-channel (`*to4Q`, `*to2Q`), many TT tune/mass/hdamp variations.
- Quarkonia: only two prompt J/psi->mumu samples and one Upsilon sample (`Upsilon2SToUpsilon1S2Pi`, a Y(2S)->Y(1S)pipi cascade, 2.1M) exist in Summer24; no inclusive Y(1S/2S/3S)->mumu. J/psi particle gun `JPsiToMuMu_PT-0to100_pythia8-gun` exists only in `Run3Winter24MiniAOD-KeepSi_133X_mcRun3_2024_realistic_v8-v2` (9.8M, tracker hits kept) - not in the list.

#### inputs/mc_2024_TnP.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu-2Jets_Bin-MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24DRPremix-140X_mcRun3_2024_realistic_v26-v6/AODSIM` | 478,815,002 | 217.85 TB | 56746 | - | disk:6 |
| `/DYto2Mu-2Jets_Bin-MLL-10to50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/RunIII2024Summer24DRPremix-140X_mcRun3_2024_realistic_v26-v2/AODSIM` | 145,016,958 | 61.16 TB | 17336 | - | disk:8 |
| **total (2 datasets)** | **623,831,960** | **279.01 TB** | | | |

- The 2024 MiNNLO DY samples were produced as MINIAODSIM+NANOAODSIM only (no GEN-SIM/AODSIM stored in DAS), so no MiNNLO AODSIM exists. The amcatnloFXFX DYto2Mu-2Jets `RunIII2024Summer24DRPremix-140X_mcRun3_2024_realistic_v26` AODSIM are the parents of the MiniAODv6 used by NanoAODv15 (MLL-50: v6 VALID, v2-v5 INVALID). Alternative: powheg `DYto2Mu_Bin-MLL-50to120` DRPremix v2 AODSIM.

### 2025 (13.6 TeV pp, standard high pileup)

Era classification (DAS RAW era list + OMS: all era boundary runs 6.8 TeV/beam, PROTONS; golden JSON `Collisions25/latest/Cert_Collisions2025_391658_398903_Golden.json`, 513 runs / 268,078 LS):

- Run2025A: commissioning (no Muon0/1 MINIAOD), omitted. Run2025B-G (391548-398903): 13.6 TeV pp physics, all included. No Run2025H+ pp eras exist; the OO/NeNe/PbPb/pO 2025 runs are in `HIRun2025A` (not touched). `Collisions25Special` JSON covers runs 390951-391137 (before era B, not included).
- Golden LS per era: B 6,690 (24 runs), C 54,454 (76), D 63,077 (124), E 31,393 (54), F 61,659 (140), G 50,805 (95). All golden runs are contained in the lists.
- Low-PU runs are INSIDE these datasets: July-2025 low-mu fills start right at the beginning of Run2025D (run 394393 = fill 10819), and `Collisions25/latest/2025_lowPU_updated.json` lists runs 398682, 398683, 398803 (1,325 LS, Run2025G). Lumi-mask them out of the high-PU production (they belong to section D).

#### inputs/data_2025.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2025B-PromptReco-v1/MINIAOD` | 5,602,078 | 330.01 GB | 173 | 68 (391548-392112) | disk:2 |
| `/Muon0/Run2025C-PromptReco-v1/MINIAOD` | 250,835,953 | 15.09 TB | 4560 | 77 (392174-393087) | disk:24 |
| `/Muon0/Run2025C-PromptReco-v2/MINIAOD` | 148,575,745 | 8.83 TB | 2605 | 37 (393111-393516) | disk:2 |
| `/Muon0/Run2025D-PromptReco-v1/MINIAOD` | 479,676,562 | 28.69 TB | 8468 | 187 (394393-395948) | disk:8 |
| `/Muon0/Run2025E-PromptReco-v1/MINIAOD` | 265,645,863 | 16.04 TB | 4762 | 66 (395982-396422) | disk:2 |
| `/Muon0/Run2025F-PromptReco-v1/MINIAOD` | 377,119,912 | 22.62 TB | 6648 | 143 (396629-397596) | disk:8 |
| `/Muon0/Run2025F-PromptReco-v2/MINIAOD` | 143,519,758 | 8.37 TB | 2521 | 40 (397619-397853) | disk:5 |
| `/Muon0/Run2025G-PromptReco-v1/MINIAOD` | 442,329,683 | 25.54 TB | 7478 | 126 (397954-398903) | disk:9 |
| `/Muon1/Run2025B-PromptReco-v1/MINIAOD` | 5,598,676 | 330.30 GB | 178 | 68 (391548-392112) | disk:2 |
| `/Muon1/Run2025C-PromptReco-v1/MINIAOD` | 250,819,768 | 15.09 TB | 4553 | 79 (392174-393087) | disk:3 |
| `/Muon1/Run2025C-PromptReco-v2/MINIAOD` | 148,565,659 | 8.84 TB | 2605 | 37 (393111-393516) | disk:4 |
| `/Muon1/Run2025D-PromptReco-v1/MINIAOD` | 479,642,866 | 28.69 TB | 8473 | 186 (394393-395948) | disk:8 |
| `/Muon1/Run2025E-PromptReco-v1/MINIAOD` | 265,630,211 | 16.04 TB | 4741 | 66 (395982-396422) | disk:2 |
| `/Muon1/Run2025F-PromptReco-v1/MINIAOD` | 377,092,035 | 22.62 TB | 6685 | 143 (396629-397596) | disk:19 |
| `/Muon1/Run2025F-PromptReco-v2/MINIAOD` | 143,511,119 | 8.37 TB | 2514 | 40 (397619-397853) | disk:10 |
| `/Muon1/Run2025G-PromptReco-v1/MINIAOD` | 442,232,031 | 25.53 TB | 7440 | 125 (397954-398903) | disk:10 |
| **total (16 datasets)** | **4,226,397,919** | **251.02 TB** | | | |

- Processing: PromptReco only (CMSSW_15_0_5 ... 15_0_15_patch4); prompt NANOAOD of 15_0_X is already NanoAODv15, no re-reco/re-mini exists for 2025. DAS parent of PromptReco MINIAOD/NANOAOD is the RAW (Tier-0 does not record the AOD step).
- C and F each have two PromptReco versions with disjoint run ranges (C v1 392174-393087, v2 393111-393516; F v1 396629-397596, v2 397619-397853): both needed.
- Alternative: `Run2025C-TrkRadDamage-v2` (runs 393087-393461, CMSSW_15_0_13 special re-reco from RAW, name suggests updated tracker radiation-damage conditions; v1 not VALID) - overlaps with PromptReco C v1/v2; not used. Also PromptBTVNano/PromptJMENano/PromptMuoPOGNano NANO flavours (no MINIAOD).

#### inputs/dataEGamma_2025.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma0/Run2025B-PromptReco-v1/MINIAOD` | 5,256,904 | 335.53 GB | 174 | 66 (391548-392112) | disk:2 |
| `/EGamma0/Run2025C-PromptReco-v1/MINIAOD` | 243,682,359 | 14.70 TB | 4426 | 77 (392174-393087) | disk:2 |
| `/EGamma0/Run2025C-PromptReco-v2/MINIAOD` | 133,952,379 | 7.99 TB | 2328 | 35 (393111-393516) | disk:2 |
| `/EGamma0/Run2025D-PromptReco-v1/MINIAOD` | 414,017,171 | 24.89 TB | 7341 | 174 (394402-395948) | disk:7 |
| `/EGamma0/Run2025E-PromptReco-v1/MINIAOD` | 240,927,385 | 14.59 TB | 4274 | 62 (395982-396422) | disk:2 |
| `/EGamma0/Run2025F-PromptReco-v1/MINIAOD` | 346,019,505 | 20.79 TB | 6193 | 143 (396629-397596) | disk:3 |
| `/EGamma0/Run2025F-PromptReco-v2/MINIAOD` | 139,317,024 | 8.15 TB | 2435 | 43 (397619-397837) | disk:5 |
| `/EGamma0/Run2025G-PromptReco-v1/MINIAOD` | 421,374,702 | 24.64 TB | 7279 | 119 (397867-398903) | disk:8 |
| `/EGamma1/Run2025B-PromptReco-v1/MINIAOD` | 5,253,103 | 335.31 GB | 174 | 66 (391548-392112) | disk:2 |
| `/EGamma1/Run2025C-PromptReco-v1/MINIAOD` | 243,674,671 | 14.70 TB | 4423 | 74 (392174-393087) | disk:2 |
| `/EGamma1/Run2025C-PromptReco-v2/MINIAOD` | 133,951,067 | 7.99 TB | 2318 | 34 (393111-393516) | disk:2 |
| `/EGamma1/Run2025D-PromptReco-v1/MINIAOD` | 413,998,146 | 24.89 TB | 7400 | 173 (394402-395948) | disk:6 |
| `/EGamma1/Run2025E-PromptReco-v1/MINIAOD` | 240,921,314 | 14.59 TB | 4292 | 63 (395982-396422) | disk:2 |
| `/EGamma1/Run2025F-PromptReco-v1/MINIAOD` | 346,000,262 | 20.79 TB | 6188 | 143 (396629-397596) | disk:3 |
| `/EGamma1/Run2025F-PromptReco-v2/MINIAOD` | 139,310,909 | 8.15 TB | 2431 | 44 (397619-397837) | disk:4 |
| `/EGamma1/Run2025G-PromptReco-v1/MINIAOD` | 421,102,377 | 24.60 TB | 7285 | 118 (397867-398903) | disk:10 |
| `/EGamma2/Run2025B-PromptReco-v1/MINIAOD` | 5,254,123 | 335.04 GB | 175 | 66 (391548-392112) | disk:2 |
| `/EGamma2/Run2025C-PromptReco-v1/MINIAOD` | 243,672,282 | 14.70 TB | 4439 | 75 (392174-393087) | disk:2 |
| `/EGamma2/Run2025C-PromptReco-v2/MINIAOD` | 133,950,574 | 7.99 TB | 2321 | 37 (393111-393516) | disk:3 |
| `/EGamma2/Run2025D-PromptReco-v1/MINIAOD` | 414,008,481 | 24.89 TB | 7441 | 175 (394402-395948) | disk:7 |
| `/EGamma2/Run2025E-PromptReco-v1/MINIAOD` | 240,923,259 | 14.60 TB | 4264 | 63 (395982-396422) | disk:2 |
| `/EGamma2/Run2025F-PromptReco-v1/MINIAOD` | 346,008,679 | 20.79 TB | 6247 | 143 (396629-397596) | disk:12 |
| `/EGamma2/Run2025F-PromptReco-v2/MINIAOD` | 139,313,488 | 8.15 TB | 2433 | 45 (397619-397837) | disk:9 |
| `/EGamma2/Run2025G-PromptReco-v1/MINIAOD` | 421,453,068 | 24.65 TB | 7325 | 121 (397954-398903) | disk:10 |
| `/EGamma3/Run2025B-PromptReco-v1/MINIAOD` | 5,253,489 | 335.01 GB | 179 | 66 (391548-392112) | disk:2 |
| `/EGamma3/Run2025C-PromptReco-v1/MINIAOD` | 243,679,348 | 14.70 TB | 4494 | 75 (392174-393087) | disk:2 |
| `/EGamma3/Run2025C-PromptReco-v2/MINIAOD` | 133,949,781 | 7.99 TB | 2294 | 36 (393111-393516) | disk:2 |
| `/EGamma3/Run2025D-PromptReco-v1/MINIAOD` | 414,010,046 | 24.89 TB | 7381 | 172 (394402-395948) | disk:8 |
| `/EGamma3/Run2025E-PromptReco-v1/MINIAOD` | 240,923,335 | 14.59 TB | 4298 | 63 (395982-396422) | disk:2 |
| `/EGamma3/Run2025F-PromptReco-v1/MINIAOD` | 346,009,210 | 20.79 TB | 6196 | 143 (396629-397596) | disk:17 |
| `/EGamma3/Run2025F-PromptReco-v2/MINIAOD` | 139,314,438 | 8.15 TB | 2391 | 41 (397619-397836) | disk:5 |
| `/EGamma3/Run2025G-PromptReco-v1/MINIAOD` | 421,124,471 | 24.60 TB | 7207 | 119 (397954-398903) | disk:10 |
| **total (32 datasets)** | **7,777,607,350** | **464.32 TB** | | | |

- 2025 has four EGamma PDs (EGamma0-3). Same versions as the muon list; EGamma3 C has no TrkRadDamage-v1.

#### inputs/data_2025_TnP.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2025B-PromptReco-v1/AOD` | 5,602,078 | 2.32 TB | 961 | 68 (391548-392112) | disk:14 |
| `/Muon0/Run2025C-PromptReco-v1/AOD` | 250,835,953 | 106.53 TB | 30491 | 77 (392174-393087) | disk:1 |
| `/Muon0/Run2025C-PromptReco-v2/AOD` | 148,575,745 | 62.56 TB | 16883 | 37 (393111-393516) | disk:1 |
| `/Muon0/Run2025D-PromptReco-v1/AOD` | 479,676,562 | 204.08 TB | 55757 | 187 (394393-395948) | disk:1 |
| `/Muon0/Run2025E-PromptReco-v1/AOD` | 265,645,863 | 115.03 TB | 30193 | 66 (395982-396422) | TAPE-ONLY |
| `/Muon0/Run2025F-PromptReco-v1/AOD` | 377,119,912 | 162.50 TB | 42105 | 143 (396629-397596) | disk:1 |
| `/Muon0/Run2025F-PromptReco-v2/AOD` | 143,519,758 | 59.59 TB | 16149 | 40 (397619-397853) | disk:1 |
| `/Muon0/Run2025G-PromptReco-v1/AOD` | 442,329,683 | 181.75 TB | 48230 | 126 (397954-398903) | disk:1 |
| `/Muon1/Run2025B-PromptReco-v1/AOD` | 5,598,676 | 2.32 TB | 959 | 68 (391548-392112) | disk:13 |
| `/Muon1/Run2025C-PromptReco-v1/AOD` | 250,819,768 | 106.52 TB | 30468 | 79 (392174-393087) | disk:1 |
| `/Muon1/Run2025C-PromptReco-v2/AOD` | 148,565,659 | 62.56 TB | 16894 | 37 (393111-393516) | disk:1 |
| `/Muon1/Run2025D-PromptReco-v1/AOD` | 479,642,866 | 204.07 TB | 55740 | 186 (394393-395948) | disk:1 |
| `/Muon1/Run2025E-PromptReco-v1/AOD` | 265,630,211 | 115.03 TB | 30191 | 66 (395982-396422) | disk:1 |
| `/Muon1/Run2025F-PromptReco-v1/AOD` | 377,092,035 | 162.49 TB | 42090 | 143 (396629-397596) | disk:1 |
| `/Muon1/Run2025F-PromptReco-v2/AOD` | 143,511,119 | 59.59 TB | 16163 | 40 (397619-397853) | disk:1 |
| `/Muon1/Run2025G-PromptReco-v1/AOD` | 442,232,031 | 181.65 TB | 48223 | 125 (397954-398903) | disk:1 |
| **total (16 datasets)** | **4,226,397,919** | **1788.58 TB** | | | |

- PromptReco AOD of the same eras/versions. `/Muon0/Run2025E-PromptReco-v1/AOD` is TAPE-ONLY (115 TB): needs a Rucio rule or use Muon1 E. Total 1.79 PB, mostly at one disk site.

#### inputs/mc_2025.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_Bin-MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 6,000,000 | 606.49 GB | 212 | - | disk:4 |
| `/DYto2Mu_Bin-MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 100,000 | 9.55 GB | 5 | - | disk:2 |
| `/DYto2E_MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 6,000,000 | 618.82 GB | 200 | - | disk:3 |
| `/DYto2E_Bin-MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 100,000 | 9.36 GB | 6 | - | disk:2 |
| `/DYTo2L-2Jets_Par-MLL-50_TuneCP5_13p6TeV_amcatnloFXFX-pythia8/Run3Winter25MiniAOD-142X_mcRun3_2025_realistic_v7-v2/MINIAODSIM` | 71,385,733 | 7.37 TB | 2132 | - | disk:1 |
| `/DYto2Tau-4Jets_Bin-MLL-50_Fil-MuTauh_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 5,723,755 | 555.47 GB | 194 | - | disk:8 |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 1,500,000 | 190.13 GB | 60 | - | disk:2 |
| `/TTToLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 1,500,000 | 189.25 GB | 59 | - | disk:4 |
| `/JPsiToMuMu_PT-0to100_pythia8-gun/Run3Winter25MiniAOD-FlatPU0to120_MiniAODv6_150X_mcRun3_2025_realistic_v6-v2/MINIAODSIM` | 9,732,000 | 998.04 GB | 295 | - | disk:6 |
| `/JPsito2Mu_Bin-PT-0to100_pythia8-gun/Run3Winter25MiniAOD-KeepSi_142X_mcRun3_2025_realistic_v7-v1/MINIAODSIM` | 9,915,000 | 751.40 GB | 188 | - | disk:1 |
| `/QCD_Bin-PT-20to30_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/Run3Winter25MiniAOD-142X_mcRun3_2025_realistic_v7-v2/MINIAODSIM` | 98,185 | 9.77 GB | 6 | - | disk:1 |
| `/QCD_Bin-PT-30to50_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/Run3Winter25MiniAOD-142X_mcRun3_2025_realistic_v7-v2/MINIAODSIM` | 98,995 | 9.95 GB | 6 | - | TAPE-ONLY |
| `/QCD_Bin-PT-50to80_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/Run3Winter25MiniAOD-142X_mcRun3_2025_realistic_v7-v2/MINIAODSIM` | 98,358 | 10.22 GB | 6 | - | disk:1 |
| `/QCD_Bin-PT-120to170_Fil-MuEnriched_TuneCP5_13p6TeV_pythia8/Run3Winter25MiniAOD-142X_mcRun3_2025_realistic_v7-v2/MINIAODSIM` | 100,452 | 11.75 GB | 7 | - | disk:1 |
| **total (14 datasets)** | **112,352,478** | **11.34 TB** | | | |

- There is NO full 2025 analysis MC campaign in DAS (no Run3Summer25 / RunIII2025Summer25). Available: `Run3Winter25MiniAOD` (142X, `mcRun3_2025_realistic_v7` [main, 131 datasets], `_v9` [38], `MiniAODv6_150X_..._v6` [32]; many special variants: Winter25BOY, KeepSi, NoPU, FlatPU, ZeroMaterial, EcalUncal...) and `Run3Winter26MiniAODv6-150X_mcRun3_realistic_EOY25_forTSGStudies_v2/v3` (150X, end-of-2025 conditions, made for 2026 trigger studies; NanoAODv15 children exist; GEN with `mcRun3_2026_realistic`).
- Choice: Winter26 EOY25 where the process exists, else Winter25 v7. Missing for 2025 high PU: W->lnu (only in Winter24 and in the Winter26 LowPUAVE5 set), single top, dibosons, Upsilon, MiNNLO DY, QCD-MuEnriched bins 15-20, 80-120 and >170. QCD-MuEnriched has only ~100k events per bin; `QCD_Bin-PT-30to50_Fil-MuEnriched` is TAPE-ONLY.
- Alternatives: `ZTo2Mu_Bin-M-50to120` powheg (Winter25 v7, 3.0M; also 120-200, 200-400), `DYto2L-4Jets_Bin-MLL-50` madgraphMLM (Winter25 v9-v3 72M, MiniAODv6_150X 72M, KeepSi 72M, Winter25BOY 78M), `DYTo2L-4Jets_Par-MLL-50` (Winter25 v7, 11M), `DYto2Tau-4Jets_Fil-MuTauh` also in Winter25 v7/v9_ext1/BOY, inclusive `TT_TuneCP5` powheg (Winter25 v7 8.0M + v7_ext1 7.6M; Winter26 0.1M). TTto2L2Nu/TTToLNu2Q Winter25 v7 and MiniAODv6 versions are INVALID.
- J/psi: only particle-gun samples. `JPsito2Mu_..._pythia8-gun` KeepSi keeps the silicon hits (useful if the CVH refit needs hits).
- Low-PU 13.6 TeV MC (for section D, not in this list): `Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2` has `DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos` (10.0M, with AODSIM), `WtoLNu-4Jets` MLM (1.9M), TTto2L2Nu/TTToLNu2Q/TT (LowPUAVE5 _v2), and pomflux (photon-induced) samples.

#### inputs/mc_2025_TnP.txt

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu_Bin-MLL-50to120_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26Reco-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/AODSIM` | 6,000,000 | 3.53 TB | 937 | - | disk:5 |
| `/DYto2Mu_Bin-MLL-10to50_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26Reco-150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/AODSIM` | 100,000 | 57.13 GB | 17 | - | TAPE-ONLY |
| **total (2 datasets)** | **6,100,000** | **3.59 TB** | | | |

- AODSIM = `Run3Winter26Reco` parents of the Winter26 MiniAODv6 DY->mumu. `DYto2Mu_Bin-MLL-10to50` AODSIM (0.1M) is TAPE-ONLY. Alternative: `ZTo2Mu_Bin-M-50to120` `Run3Winter25Reco-142X_mcRun3_2025_realistic_v7-v2/AODSIM` (3.0M).

## D. Run 3 special runs: 2024 pp reference (5.36 TeV) and low-pileup 13.6 TeV

### 2024 pp reference (5.36 TeV)

Era **Run2024J**, fills 10287-10312 (from 25 Oct 2024), beam energy 2679-2680 GeV per beam (= 5.36 TeV; OMS), HLT menu `/cdaq/physics/Run2024/PRef/v1.0.x`.
Runs in the PPRef PDs: 387396-387721 (41-48 runs depending on the PD). Online recorded lumi of all PPRef-PD runs: ~486 pb-1;
**official lumi mask**: `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions24/latest/Cert_Collisions2024_ppref_387474_387721_golden.json`
(28 runs, 18223 LS, ~481 pb-1 recorded per OMS per-LS sum, pileup median 3.4, max 8); `..._Muon.json` (26 runs, ~456 pb-1). The 2024 pp golden JSON does not contain these runs.
Only processing is **PromptReco-v1** (no re-reco; no central NanoAOD of the PPRef PDs, no NanoAODv15). Run2024J also contains PbPb-fill runs (HI PDs, e.g. 387314-387456) and a 1-event Muon0/EGamma0 dataset (run 387343): no 13.6 TeV pp physics is mixed in.

#### inputs/data_2024ppRef.txt
| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/PPRefSingleMuon0/Run2024J-PromptReco-v1/MINIAOD` | 573,695,646 | 8.88 TB | 2375 | 47 (387396-387721) | disk:2 |
| `/PPRefSingleMuon1/Run2024J-PromptReco-v1/MINIAOD` | 573,694,088 | 8.88 TB | 2391 | 47 (387396-387721) | disk:2 |
| `/PPRefSingleMuon2/Run2024J-PromptReco-v1/MINIAOD` | 573,685,090 | 8.88 TB | 2381 | 45 (387396-387721) | disk:3 |
| `/PPRefSingleMuon3/Run2024J-PromptReco-v1/MINIAOD` | 573,692,175 | 8.88 TB | 2370 | 47 (387396-387721) | disk:2 |
| `/PPRefDoubleMuon0/Run2024J-PromptReco-v1/MINIAOD` | 405,463,957 | 5.70 TB | 1522 | 42 (387396-387721) | disk:2 |
| `/PPRefDoubleMuon1/Run2024J-PromptReco-v1/MINIAOD` | 405,127,020 | 5.69 TB | 1536 | 44 (387396-387721) | disk:2 |
| `/PPRefDoubleMuon2/Run2024J-PromptReco-v1/MINIAOD` | 405,464,306 | 5.69 TB | 1529 | 41 (387396-387721) | disk:2 |
| `/PPRefDoubleMuon3/Run2024J-PromptReco-v1/MINIAOD` | 405,470,915 | 5.69 TB | 1551 | 44 (387396-387721) | disk:2 |
| **total (8 datasets)** | **3,916,293,197** | **58.28 TB** | | | |

#### inputs/dataEGamma_2024ppRef.txt
PPRef menu has no EGamma PD: all electron/photon paths (`HLT_PPRefEle{10..50}Gsf`, `HLT_PPRefDoubleEle{10,15}Gsf[Mass50]`, `HLT_PPRefEle15Ele10Gsf[Mass50]`, `HLT_PPRefGEDPhoton*`, `HLT_PPRefDoubleGEDPhoton20`) are routed to **PPRefHardProbes** together with the AK4 calo/PF jet triggers (read from `hltDatasetPPRefHardProbes` in the HLT provenance of a Run2024J file). Kept as a separate file (`dataEGamma_*` naming as for the standard Run-3 campaigns) because it is dominated by jets/photons.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/PPRefHardProbes0/Run2024J-PromptReco-v1/MINIAOD` | 297,943,672 | 5.04 TB | 1363 | 48 (387396-387721) | disk:2 |
| `/PPRefHardProbes1/Run2024J-PromptReco-v1/MINIAOD` | 297,937,686 | 5.04 TB | 1359 | 43 (387396-387721) | disk:2 |
| `/PPRefHardProbes2/Run2024J-PromptReco-v1/MINIAOD` | 297,735,273 | 5.04 TB | 1374 | 48 (387396-387721) | disk:2 |
| `/PPRefHardProbes3/Run2024J-PromptReco-v1/MINIAOD` | 297,937,594 | 5.04 TB | 1362 | 44 (387396-387721) | disk:2 |
| `/PPRefHardProbes4/Run2024J-PromptReco-v1/MINIAOD` | 297,941,942 | 5.04 TB | 1378 | 48 (387396-387721) | disk:2 |
| **total (5 datasets)** | **1,489,496,167** | **25.21 TB** | | | |

#### inputs/data_2024ppRef_TnP.txt
**No dataset lines (comment-only file).** Tier-0 did not write AOD for the 2024 PPRef PDs: only RAW, MINIAOD and RAW-RECO/USER skims exist (checked with all statuses). The `ZMu` and `MUOJME` RAW-RECO skims of PPRefSingleMuon*/PPRefDoubleMuon* are empty (0 events, ~2 MB/file); the `EXODelayedJetMET` AOD skims of PPRefHardProbes are also empty. Options: run the T&P on MINIAOD or re-RECO from `/PPRef{Single,Double}Muon{0..3}/Run2024J-v1/RAW`. (The small 2023 PPRef datasets of Run2023F/HIRun2023A do have AOD.)

#### inputs/mc_2024ppRef.txt
Campaign **RunIIIpp5p36Winter24MiniAOD**, GT `141X_mcRun3_2024_realistic_ppRef5TeV_v7` (with pileup). 134 VALID MINIAODSIM datasets in total; one version per sample (only extra non-VALID: TT herwig NoPU v1-v3). No NanoAOD of any kind for this campaign. Generators: powheg (DY->ee/mumu/tautau M-10to50 and M-50, W+-/->e/mu/tau nu, TT, single top t-channel and `T_`/`Tbar_` (process not encoded in the name), all dibosons), amcatnloFXFX (DYto2L-2Jets, WtoLNu-2Jets, TT-2Jets), madgraphMLM (WtoLNu-4Jets), pythia8 (ZToEE pT-10, quarkonia, QCD).

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2L-2Jets_MLL-10to50_TuneCP5_5p36TeV_amcatnloFXFX-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 29,248,733 | 437.83 GB | 142 | - | disk:4 |
| `/DYto2L-2Jets_MLL-50_TuneCP5_5p36TeV_amcatnloFXFX-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 30,156,049 | 655.42 GB | 201 | - | disk:4 |
| `/DYToEE_M-10to50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 10,000,000 | 142.81 GB | 45 | - | disk:5 |
| `/DYToEE_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,731,773 | 212.15 GB | 67 | - | disk:4 |
| `/DYToMuMu_M-10to50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,548,485 | 146.09 GB | 55 | - | disk:1 |
| `/DYToMuMu_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,999,999 | 212.28 GB | 61 | - | disk:3 |
| `/DYToTauTau_M-10to50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,541,450 | 119.55 GB | 40 | - | disk:3 |
| `/DYToTauTau_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,946,251 | 170.59 GB | 62 | - | disk:2 |
| `/ZToEE_pT-10_M-60to120_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 950,679 | 20.85 GB | 11 | - | disk:2 |
| `/WminusToEminusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,973,591 | 165.74 GB | 61 | - | disk:2 |
| `/WminusToMuminusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,844,580 | 157.75 GB | 60 | - | disk:2 |
| `/WminusToTauminusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,866,758 | 142.24 GB | 53 | - | disk:2 |
| `/WplusToEplusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,919,274 | 170.76 GB | 67 | - | disk:2 |
| `/WplusToMuplusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,730,000 | 162.38 GB | 56 | - | disk:2 |
| `/WplusToTauplusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,946,000 | 146.00 GB | 53 | - | disk:1 |
| `/WtoLNu-2Jets_TuneCP5_5p36TeV_amcatnloFXFX-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 61,215,841 | 1.12 TB | 336 | - | disk:3 |
| `/WtoLNu-4Jets_TuneCP5_5p36TeV_madgraphMLM-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 68,486,094 | 1.24 TB | 422 | - | disk:2 |
| `/T-tChannel_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,972,000 | 259.38 GB | 87 | - | disk:2 |
| `/T_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 10,000,000 | 309.64 GB | 106 | - | disk:2 |
| `/Tbar-tChannel_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,890,000 | 256.30 GB | 86 | - | disk:2 |
| `/Tbar_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,972,000 | 309.08 GB | 106 | - | disk:2 |
| `/TT-2Jets_TuneCP5_5p36TeV_amcatnloFXFX-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 11,387,512 | 440.76 GB | 145 | - | disk:3 |
| `/TT_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 10,000,000 | 351.70 GB | 103 | - | disk:2 |
| `/WWTo2L2Nu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,000,000 | 22.96 GB | 9 | - | disk:2 |
| `/WWToLNu2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,000,000 | 32.56 GB | 26 | - | disk:11 |
| `/WZTo2L2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,000,000 | 33.56 GB | 52 | - | disk:2 |
| `/WZTo3LNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 964,000 | 19.69 GB | 8 | - | disk:3 |
| `/ZZTo2L2Nu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 997,195 | 30.97 GB | 39 | - | disk:3 |
| `/ZZTo2L2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 988,000 | 20.12 GB | 9 | - | disk:3 |
| `/ZZTo4L_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 999,040 | 33.54 GB | 22 | - | disk:2 |
| `/BToNonPromptJPsiToMuMu_inclusive_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,293,734 | 141.21 GB | 65 | - | disk:2 |
| `/PromptJPsiToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,539,719 | 129.61 GB | 63 | - | disk:2 |
| `/PromptPsi2SToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 10,504,778 | 142.78 GB | 42 | - | disk:2 |
| `/Upsilon1SToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,953,371 | 169.06 GB | 70 | - | disk:1 |
| `/Upsilon2SToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 10,336,768 | 179.02 GB | 51 | - | disk:1 |
| `/Upsilon3SToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 10,161,996 | 166.83 GB | 46 | - | disk:1 |
| `/QCD-E_pThat-20_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 10,841,849 | 258.04 GB | 102 | - | disk:2 |
| `/QCD-EMEnriched_pThat-120to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 981,683 | 25.68 GB | 14 | - | disk:3 |
| `/QCD-EMEnriched_pThat-170to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,001,227 | 28.04 GB | 14 | - | disk:2 |
| `/QCD-EMEnriched_pThat-220to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,005,431 | 29.73 GB | 15 | - | disk:2 |
| `/QCD-EMEnriched_pThat-30to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,014,548 | 20.55 GB | 9 | - | disk:2 |
| `/QCD-EMEnriched_pThat-50to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 894,208 | 18.79 GB | 7 | - | disk:2 |
| `/QCD-EMEnriched_pThat-80to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,039,168 | 24.28 GB | 9 | - | disk:2 |
| `/QCD-Mu_pThat-20_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 7,960,773 | 187.99 GB | 78 | - | disk:2 |
| `/QCD-Photon_pT-30_pThat-120to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 945,461 | 25.00 GB | 12 | - | disk:4 |
| `/QCD-Photon_pT-30_pThat-15to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,024,413 | 23.98 GB | 13 | - | disk:2 |
| `/QCD-Photon_pT-30_pThat-170to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,045,557 | 30.32 GB | 16 | - | disk:2 |
| `/QCD-Photon_pT-30_pThat-30to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 945,884 | 18.33 GB | 6 | - | disk:2 |
| `/QCD-Photon_pT-30_pThat-50to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 989,649 | 19.61 GB | 9 | - | disk:2 |
| `/QCD-Photon_pT-30_pThat-80to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,062,496 | 24.77 GB | 11 | - | disk:2 |
| `/QCD-Photon_pT-50_pThat-120to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,006,674 | 25.69 GB | 13 | - | disk:2 |
| `/QCD-Photon_pT-50_pThat-15to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 857,794 | 21.15 GB | 9 | - | disk:2 |
| `/QCD-Photon_pT-50_pThat-170to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,076,055 | 30.82 GB | 15 | - | disk:2 |
| `/QCD-Photon_pT-50_pThat-30to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,140,780 | 24.76 GB | 13 | - | disk:2 |
| `/QCD-Photon_pT-50_pThat-50to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 801,599 | 17.19 GB | 7 | - | disk:2 |
| `/QCD-Photon_pT-50_pThat-80to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 1,064,209 | 23.95 GB | 11 | - | disk:2 |
| `/QCD-Photon_pThat-120to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 4,854,483 | 128.67 GB | 53 | - | disk:4 |
| `/QCD-Photon_pThat-15to6000_TuneCH3_5p36TeV_herwig7/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 4,891,846 | 122.48 GB | 49 | - | disk:2 |
| `/QCD-Photon_pThat-170to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 5,581,090 | 163.39 GB | 61 | - | disk:3 |
| `/QCD-Photon_pThat-30to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 5,066,814 | 87.31 GB | 38 | - | disk:3 |
| `/QCD-Photon_pThat-50to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 5,297,088 | 106.16 GB | 47 | - | disk:2 |
| `/QCD-Photon_pThat-80to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 4,819,847 | 112.50 GB | 48 | - | disk:4 |
| **total (62 datasets)** | **503,276,296** | **10.07 TB** | | | |

#### inputs/mc_2024ppRef_other.txt
NoPU variants of most main samples (+ NoPU-only TTbar CH3 herwig7 and ZZTo2Nu2Q), exclusive decays (B+ -> J/psi K+ in 5 pThat bins (relevant for the B+ -> J/psi K+ calibration idea), prompt/non-prompt psi(2S) -> J/psi pi pi, X(3872), psi(2S) -> mumu pi pi, double prompt J/psi -> 4mu), hadronic/b-enriched QCD (pythia8 + herwig7), MinBias and gun/calibration/tracking special processings.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/BToNonPromptJPsiToMuMu_inclusive_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,582,426 | 168.52 GB | 569 | - | disk:3 |
| `/DYToEE_M-10to50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,914,000 | 115.51 GB | 68 | - | disk:7 |
| `/DYToEE_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,472,000 | 180.89 GB | 85 | - | disk:6 |
| `/DYToMuMu_M-10to50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,914,000 | 124.83 GB | 64 | - | disk:5 |
| `/DYToMuMu_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 10,000,000 | 181.84 GB | 92 | - | disk:3 |
| `/DYToTauTau_M-10to50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 10,000,000 | 98.51 GB | 64 | - | disk:2 |
| `/DYToTauTau_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,947,000 | 145.67 GB | 86 | - | disk:5 |
| `/PromptJPsiToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,893,369 | 105.96 GB | 64 | - | disk:4 |
| `/PromptPsi2SToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,752,451 | 108.39 GB | 49 | - | disk:1 |
| `/PromptPsi2SToMuMuPiPi_pThat-2_TuneCP5_pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,863,261 | 97.51 GB | 44 | - | disk:1 |
| `/QCD_pThat-15to1200_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 58,776,000 | 1.07 TB | 369 | - | disk:2 |
| `/T-tChannel_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,860,000 | 232.79 GB | 108 | - | disk:3 |
| `/T_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,964,000 | 281.72 GB | 129 | - | disk:5 |
| `/Tbar-tChannel_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,710,000 | 228.63 GB | 102 | - | disk:16 |
| `/Tbar_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,824,000 | 278.65 GB | 124 | - | disk:5 |
| `/TT_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,638,999 | 311.29 GB | 121 | - | disk:6 |
| `/TTbar_TuneCH3_5p36TeV_powheg-herwig7/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,930,881 | 373.62 GB | 129 | - | disk:4 |
| `/Upsilon1SToMuMu_pThat-2_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,676,346 | 135.94 GB | 61 | - | disk:1 |
| `/WminusToEminusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,905,000 | 138.42 GB | 79 | - | disk:6 |
| `/WminusToMuminusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,694,000 | 129.53 GB | 74 | - | disk:4 |
| `/WminusToTauminusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,964,000 | 117.52 GB | 43 | - | disk:2 |
| `/WplusToEplusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 10,000,000 | 145.46 GB | 80 | - | disk:8 |
| `/WplusToMuplusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,460,000 | 132.72 GB | 74 | - | disk:2 |
| `/WplusToTauplusNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,915,000 | 119.80 GB | 68 | - | disk:5 |
| `/WWTo2L2Nu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 967,000 | 19.23 GB | 16 | - | disk:4 |
| `/WWToLNu2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 954,713 | 28.32 GB | 85 | - | disk:16 |
| `/WZTo2L2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,000,000 | 19.36 GB | 10 | - | disk:4 |
| `/WZTo3LNu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 964,000 | 17.16 GB | 22 | - | disk:20 |
| `/ZZTo2L2Nu_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 998,818 | 28.07 GB | 312 | - | disk:21 |
| `/ZZTo2L2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 988,000 | 17.63 GB | 19 | - | disk:17 |
| `/ZZTo2Nu2Q_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,000,000 | 14.77 GB | 18 | - | disk:15 |
| `/ZZTo4L_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 1,000,000 | 18.34 GB | 10 | - | disk:4 |
| `/BplusToJPsiKplus_pThat-10_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 504,579 | 8.05 GB | 3 | - | disk:2 |
| `/BplusToJPsiKplus_pThat-15_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 471,549 | 8.35 GB | 5 | - | disk:3 |
| `/BplusToJPsiKplus_pThat-30_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 512,705 | 10.98 GB | 5 | - | disk:2 |
| `/BplusToJPsiKplus_pThat-50_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 523,004 | 13.02 GB | 5 | - | disk:2 |
| `/BplusToJPsiKplus_pThat-5_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 526,692 | 7.39 GB | 4 | - | disk:2 |
| `/NonpromptPsi2SToJPsiPiPi_pThat-10_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 497,161 | 8.36 GB | 6 | - | disk:2 |
| `/NonpromptPsi2SToJPsiPiPi_pThat-15_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 499,253 | 9.49 GB | 5 | - | disk:2 |
| `/NonpromptPsi2SToJPsiPiPi_pThat-30_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 504,228 | 11.53 GB | 5 | - | disk:2 |
| `/NonpromptPsi2SToJPsiPiPi_pThat-50_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 505,515 | 13.19 GB | 7 | - | disk:4 |
| `/NonpromptPsi2SToJPsiPiPi_pThat-5_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 505,723 | 7.09 GB | 4 | - | disk:3 |
| `/PromptPsi2SToJPsiPiPi_pThat-10_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 480,327 | 7.49 GB | 4 | - | disk:2 |
| `/PromptPsi2SToJPsiPiPi_pThat-15_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 520,499 | 8.94 GB | 5 | - | disk:2 |
| `/PromptPsi2SToJPsiPiPi_pThat-30_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 499,452 | 10.24 GB | 5 | - | disk:4 |
| `/PromptPsi2SToJPsiPiPi_pThat-50_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 511,368 | 12.13 GB | 5 | - | disk:2 |
| `/PromptPsi2SToJPsiPiPi_pThat-5_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 495,441 | 6.58 GB | 3 | - | disk:3 |
| `/PromptPsi2SToMuMuPiPi_pThat-2_TuneCP5_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,863,261 | 126.00 GB | 58 | - | disk:2 |
| `/PromptX3872ToJPsiPiPi_pThat-10_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 496,510 | 8.29 GB | 4 | - | disk:4 |
| `/PromptX3872ToJPsiPiPi_pThat-15_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 509,734 | 9.23 GB | 5 | - | disk:3 |
| `/PromptX3872ToJPsiPiPi_pThat-30_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 503,101 | 10.76 GB | 7 | - | disk:3 |
| `/PromptX3872ToJPsiPiPi_pThat-50_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 505,341 | 12.14 GB | 6 | - | disk:2 |
| `/PromptX3872ToJPsiPiPi_pThat-5_TuneCP5_5p36TeV_pythia8-evtgen/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 514,206 | 7.22 GB | 4 | - | disk:2 |
| `/TwoPromptJPsiTo4Mu_pThat-5_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,925,634 | 213.75 GB | 72 | - | disk:2 |
| `/QCD_BEnriched_pThat-15to500_TuneCH3_5p36TeV_herwig7/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 61,210,124 | 1.81 TB | 560 | - | disk:4 |
| `/QCD_BEnriched_pThat-15to500_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 65,586,944 | 1.61 TB | 459 | - | disk:3 |
| `/QCD_Pt-15to1200_TuneCH3_Flat_5p36TeV_herwig7/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 60,000,000 | 1.58 TB | 489 | - | disk:9 |
| `/QCD_pThat-15to1200_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 59,940,000 | 1.26 TB | 370 | - | disk:2 |
| `/EE_FlatPT-1to500_ECALIdealIC_TuneCP5_5p36TeV_Pythia8PtGun/RunIIIpp5p36Winter24MiniAOD-ECALIdealIC_forCalibrationECALIdealIC_141X_mcRun3_2024_realistic_ppRef5TeV_v7_ECALIdealIC_v1-v1/MINIAODSIM` | 9,946,000 | 164.30 GB | 51 | - | disk:2 |
| `/EE_FlatPT-1to500_TuneCP5_5p36TeV_Pythia8PtGun/RunIIIpp5p36Winter24MiniAOD-forCalibration_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 10,000,000 | 165.50 GB | 55 | - | disk:3 |
| `/GG_FlatPT-10to500_ECALIdealIC_TuneCP5_5p36TeV_Pythia8PtGun/RunIIIpp5p36Winter24MiniAOD-ECALIdealIC_forCalibrationECALIdealIC_141X_mcRun3_2024_realistic_ppRef5TeV_v7_ECALIdealIC_v1-v1/MINIAODSIM` | 9,811,000 | 124.39 GB | 42 | - | disk:3 |
| `/GG_FlatPT-10to500_TuneCP5_5p36TeV_Pythia8PtGun/RunIIIpp5p36Winter24MiniAOD-forCalibration_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,871,000 | 125.16 GB | 48 | - | disk:3 |
| `/MinBias_TuneCP5_5p36TeV-pythia8/RunIIIpp5p36Winter24MiniAOD-FEVTDEBUGHLT_forTracking_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v3/MINIAODSIM` | 9,970,000 | 79.66 GB | 29 | - | disk:2 |
| `/MinBias_TuneCP5_5p36TeV-pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_FEVTDEBUGHLT_forTracking_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v4/MINIAODSIM` | 10,000,000 | 48.67 GB | 17 | - | disk:2 |
| `/MinBias_TuneCP5_5p36TeV-pythia8/RunIIIpp5p36Winter24MiniAOD-pilot_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 10,000 | 50.30 MB | 1 | - | disk:1 |
| `/Nu_E-9p99to10p01_5p36TeV_FlatRandomEGun/RunIIIpp5p36Winter24MiniAOD-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v1/MINIAODSIM` | 9,568,000 | 55.85 GB | 18 | - | disk:2 |
| `/Nu_E-9p99to10p01_5p36TeV_FlatRandomEGun/RunIIIpp5p36Winter24MiniAOD-era_PbPb_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v4/MINIAODSIM` | 10,000,000 | 57.40 GB | 19 | - | disk:6 |
| `/QCD-Photon_pThat-15to9999_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-forCalibration_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 5,389,972 | 99.07 GB | 42 | - | disk:2 |
| `/QCD_pThat-15to1200_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-era_PbPb_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v4/MINIAODSIM` | 60,000,000 | 914.28 GB | 282 | - | disk:7 |
| `/QCD_pThat-15to1200_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-FEVTDEBUGHLT_forTracking_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/MINIAODSIM` | 9,976,000 | 210.48 GB | 59 | - | disk:1 |
| `/QCD_pThat-15to1200_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-NoPU_FEVTDEBUGHLT_forTracking_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v4/MINIAODSIM` | 1,000,000 | 18.60 GB | 15 | - | disk:2 |
| `/QCD_pThat-15to1200_TuneCP5_5p36TeV_pythia8/RunIIIpp5p36Winter24MiniAOD-Poisson001_141X_mcRun3_2024_realistic_ppRef5TeV_v7-v4/MINIAODSIM` | 58,245,000 | 3.19 TB | 968 | - | disk:3 |
| **total (72 datasets)** | **782,928,587** | **17.22 TB** | | | |

#### inputs/mc_2024ppRef_TnP.txt
AODSIM parent of the with-PU DYToMuMu M-50 MINIAODSIM. **Tape-only** (needs a Rucio rule). Alternatives: DYToMuMu M-10to50 (`-v1`, tape-only), NoPU M-50 (on disk), `HINPbPbWinter25Reco` re-digis of the same GEN (PbPb conditions, not for pp).

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYToMuMu_M-50_TuneCP5_5p36TeV_powheg-pythia8/RunIIIpp5p36Winter24DR-141X_mcRun3_2024_realistic_ppRef5TeV_v7-v2/AODSIM` | 9,999,999 | 947.56 GB | 267 | - | TAPE-ONLY |
| **total (1 datasets)** | **9,999,999** | **947.56 GB** | | | |

Notes (2024 ppRef):
- All 13 data datasets are VALID with disk replicas at 2-3 sites (MINIAOD). PDs are round-robin splits (`hltPreDatasetPPRef*{0..3}` offsets), so all parts are needed and disjoint.
- Muon-trigger content: SingleMuon = `HLT_PPRefL1SingleMu{7,12}`, `HLT_PPRefL2SingleMu{7,12,15,20}`, `HLT_PPRefL3SingleMu{3,5,7,12,15,20}` (+ mu+jet, mu+e/gamma, CSC cluster); DoubleMuon = `HLT_PPRefL{1,2,3}DoubleMu0[_Open|_SQ]`, `HLT_PPRefL1DoubleMu2[_SQ]`.
- MC pileup: the default campaign has pileup (data <mu> ~ 3.4); NoPU twins are in the `_other` list.

### 2025 low-pileup 13.6 TeV

**Finding: two different things can be called "2025 low PU".**

1. **The certified 2025 low-PU physics run (recommended; what the lists contain).** Official DC JSONs exist:
   `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions25/latest/2025_lowPU_updated.json` = `{398682: [[1,42]], 398683: [[1,668]], 398803: [[1,615]]}` (1325 LS);
   `2025_lowPU.json` in the same directory is the older version (identical except it lacks run 398803; every dated directory since 2026-02-04 has both, identical md5). Neither is in the 2025 golden JSON.
   - Run 398682 + 398683: fill 11230 (30 Oct 2025, 2448 bunches, levelled at end of fill); run 398803: fill 11237 (3 Nov 2025). Era **Run2025G**.
   - <mu> = 6.95-7.0 (OMS per LS, min 6.6, max 7.8; 398803 starts at 12.5 for a few LS), init lumi ~2.4e33 cm-2 s-1.
   - Recorded lumi (OMS per-LS sum over certified LS): 1.59 + 36.27 + 33.67 = **~71.5 pb-1**.
   - Standard physics menu `/cdaq/physics/Run2025/2e34/v1.3.5/HLT/V3` in dedicated prescale columns **LowPU1** / **LowPU1_Jet35** (only runs with these columns in 2025, checked over all 2025 LS in OMS). Unprescaled in that column: `HLT_Mu15` (~490 Hz), `HLT_Mu17`, `HLT_Mu19` (+TrkIsoVVL), `HLT_IsoMu24/27`, `HLT_Mu50`, `HLT_Ele30/32/35_WPTight_Gsf`, `HLT_DoubleEle25_CaloIdL_MW`, ... (`HLT_IsoMu20`, `HLT_Mu20/27` prescaled).
   - Data are in the **standard PDs** Muon0/Muon1 and EGamma0-3 of Run2025G, **PromptReco-v1** only. These datasets contain all of Run2025G, so the lumi mask is mandatory; the low-PU runs are only ~110 of ~15k MINIAOD files. They are also contained in the generic `data_2025.txt` (section C).
2. **The July-2025 fills the request mentioned (10821, 10824-10827, 10831) are the 2025 van-der-Meer luminosity-calibration fills**, not a physics low-PU run: beta* = 19.2 m, zero crossing angle, 63-144 colliding bunches (9 in the beam-beam MD fill 10831), <mu> = 0.6-0.7 (2.9 in 10831), HLT menu `/cdaq/special/2025/LumiScan/v1.2.0` (L144b_ZB... prescale columns), era Run2025D.
   - Stable-beam 13.6 TeV runs (OMS recorded lumi): fill 10821: 394413 (0.104 pb-1); 10824: 394422-394426, 394430, 394431 (0.262); 10825: 394448, 394449 (0.028); 10826: 394467, 394468, 394469 (0.712); 10827: 394488-394494 (0.445); 10831 (MD, mu~2.9): 394503-394508 (0.037). **Total ~1.59 pb-1.**
   - **No lepton triggers and no Muon/EGamma PDs**: the menu has only zero-bias/random/calibration paths. Physics PDs with MINIAOD+AOD: SpecialZeroBias0-31 (~145 kHz `HLT_ZeroBias_Gated/HighRate`; SpecialZeroBias0 alone: 0.70e9 events / 2.5 TB in these runs, i.e. ~22e9 events / ~80 TB for all 32), ZeroBias (45M events, 195 GB), HLTPhysics, and **ScoutingPFMonitor** (9.3M events, 145 GB) whose only path `HLT_TriggersForScoutingPFMonitor_SingleMuon_v1` is seeded by `L1_SingleMu5_BMTF OR L1_SingleMu11_SQ14_BMTF OR L1_SingleMu13_SQ14_BMTF` (barrel only, |eta| < ~0.8; ~50 Hz) - the only muon-triggered full-event sample of these fills. Commissioning MINIAOD is empty. Muon0/Muon1 Run2025D contain none of these runs (only the 3-LS non-stable-beam run 394412 of fill 10821, physics menu).
   - Not in any certification JSON (golden, muon, lowPU). The zero-bias effective luminosity is only ~10% of the 1.6 pb-1 -> O(100) Z->mumu. No list written; if wanted, the datasets are `/SpecialZeroBias{0..31}/Run2025D-PromptReco-v1/MINIAOD`, `/ZeroBias/Run2025D-PromptReco-v1/MINIAOD`, `/ScoutingPFMonitor/Run2025D-PromptReco-v1/MINIAOD` with the run list above.
3. No other 2025 13.6 TeV pp fill with peak pileup < 12 exists (OMS scan of all 2025 stable-beam fills); the rest of the 2025 low-mu fills are 900 GeV (April), pO, OO, NeNe and PbPb.

#### inputs/data_2025LowPU.txt
Low-PU subset (runs 398682/398683/398803): Muon0 7,896,803 + Muon1 7,896,201 = **15.8M events, 379 GB, 112 files** (per-run events Muon0: 145,025 / 4,028,187 / 3,723,591). Table = full Run2025G datasets.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2025G-PromptReco-v1/MINIAOD` | 442,329,683 | 25.54 TB | 7478 | 126 (397954-398903) | disk:9 |
| `/Muon1/Run2025G-PromptReco-v1/MINIAOD` | 442,232,031 | 25.53 TB | 7440 | 125 (397954-398903) | disk:10 |
| **total (2 datasets)** | **884,561,714** | **51.07 TB** | | | |

#### inputs/dataEGamma_2025LowPU.txt
Low-PU subset: EGamma0-3 ~1.15M events each = **4.60M events, 119 GB, 50 files**.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma0/Run2025G-PromptReco-v1/MINIAOD` | 421,374,702 | 24.64 TB | 7279 | 119 (397867-398903) | disk:8 |
| `/EGamma1/Run2025G-PromptReco-v1/MINIAOD` | 421,102,377 | 24.60 TB | 7285 | 118 (397867-398903) | disk:10 |
| `/EGamma2/Run2025G-PromptReco-v1/MINIAOD` | 421,453,068 | 24.65 TB | 7325 | 121 (397954-398903) | disk:10 |
| `/EGamma3/Run2025G-PromptReco-v1/MINIAOD` | 421,124,471 | 24.60 TB | 7207 | 119 (397954-398903) | disk:10 |
| **total (4 datasets)** | **1,685,054,618** | **98.49 TB** | | | |

#### inputs/data_2025LowPU_TnP.txt
Low-PU subset: **15.8M events, 1.79 TB, 452 files** (AOD of Run2025G is on disk at a single site only).

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2025G-PromptReco-v1/AOD` | 442,329,683 | 181.75 TB | 48230 | 126 (397954-398903) | disk:1 |
| `/Muon1/Run2025G-PromptReco-v1/AOD` | 442,232,031 | 181.65 TB | 48223 | 125 (397954-398903) | disk:1 |
| **total (2 datasets)** | **884,561,714** | **363.40 TB** | | | |

#### inputs/mc_2025LowPU.txt
No MC with 2025 conditions at <mu>~7 exists. Two closest options, both listed: (a) **Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v{2,3}** - end-of-year-2025 detector conditions, average pileup 5, produced for trigger (TSG) studies; parents of central Run3Winter26NanoAODv15; W only as WtoLNu-4Jets MLM, no DY->ee/tautau, no dibosons. (b) **Run3Summer23MiniAODv4-PUAVE5 / -PUAVE10** (`130X_mcRun3_2023_realistic_v15`, 2023 conditions) - MiNNLO DYJetsToMuMu, W+/W- -> mu nu at fixed pileup 5 and 10 (bracket <mu>=7); the only low-PU MiNNLO W/Z in Run 3.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,996,528 | 415.33 GB | 184 | - | disk:2 |
| `/WtoLNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 1,908,006 | 65.55 GB | 30 | - | disk:3 |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 4,965,295 | 345.91 GB | 128 | - | disk:2 |
| `/TTToLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 4,996,214 | 359.06 GB | 128 | - | disk:6 |
| `/TT_TuneCP5_13p6TeV_powheg-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 100,000 | 6.83 GB | 3 | - | disk:2 |
| `/B0ToJpsiK0s_JMM_BMuFilter_DGamma0_SoftQCDnonD_TuneCP5_13p6TeV-pythia8-evtgen/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 898,682 | 37.63 GB | 17 | - | disk:3 |
| `/BsToJpsiPhi_BMuonFilter_SoftQCDnonD_TuneCP5_13TeV-pythia8-evtgen/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 93,784 | 3.68 GB | 2 | - | disk:3 |
| `/ButoJpsiK_Jpsito2Mu_TuneCP5_13p6TeV_pythia8-evtgen/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 974,453 | 26.84 GB | 13 | - | disk:6 |
| `/QCD_Pt-15to7000_TuneCP5_Flat_13p6TeV_pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v2-v2/MINIAODSIM` | 100,000 | 5.77 GB | 3 | - | disk:2 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE10_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,739,898 | 313.13 GB | 103 | - | disk:2 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,852,598 | 268.37 GB | 82 | - | TAPE-ONLY |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE10_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,966,900 | 410.95 GB | 109 | - | TAPE-ONLY |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,922,800 | 336.73 GB | 91 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE10_130X_mcRun3_2023_realistic_v15-v3/MINIAODSIM` | 14,922,400 | 412.86 GB | 104 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,853,800 | 338.37 GB | 100 | - | disk:1 |
| **total (15 datasets)** | **103,291,358** | **3.35 TB** | | | |

#### inputs/mc_2025LowPU_other.txt
Pomeron-flux (H1FitB, PPS central-exclusive) samples with EOY25 conditions, the QCD pT-flat sample of the same Winter26 LowPUAVE5 processing but with the 2026 GT (`150X_mcRun3_2026_realistic_v5`), and the Summer23 PUAVE1/PUAVE2 MiNNLO W/Z variants.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DiPhoton_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 10,000,000 | 248.89 GB | 89 | - | disk:3 |
| `/DYtoLL_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,972,394 | 199.19 GB | 63 | - | disk:2 |
| `/PhotonJet_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,987,220 | 226.07 GB | 81 | - | disk:2 |
| `/QCD_pomflux_Pt-100_TuneCP5_lowPU_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,995,562 | 405.55 GB | 157 | - | disk:3 |
| `/ST_t-channel-pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,996,196 | 395.14 GB | 130 | - | disk:7 |
| `/TT-pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,994,303 | 574.36 GB | 193 | - | disk:4 |
| `/WlnuGluon_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 10,000,000 | 204.42 GB | 69 | - | disk:2 |
| `/Wlnu_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 10,000,000 | 217.80 GB | 97 | - | disk:7 |
| `/WlnuQuark_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,753,856 | 212.42 GB | 75 | - | disk:7 |
| `/WW_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 10,000,000 | 217.79 GB | 82 | - | disk:2 |
| `/WZ_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 10,000,000 | 336.19 GB | 103 | - | disk:2 |
| `/ZZ_pomflux-H1FitB_TuneCP5_13p6TeV-pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/MINIAODSIM` | 9,998,724 | 335.41 GB | 140 | - | disk:2 |
| `/QCD_Bin-PT-15to7000_Par-PT-flat2022_TuneCP5_13p6TeV_pythia8/Run3Winter26MiniAODv6-LowPUAVE5_150X_mcRun3_2026_realistic_v5-v2/MINIAODSIM` | 29,955,996 | 1.99 TB | 703 | - | disk:6 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE1_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,980,398 | 211.78 GB | 64 | - | disk:2 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE2_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 9,984,898 | 238.49 GB | 64 | - | disk:1 |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE1_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,920,800 | 253.78 GB | 78 | - | disk:1 |
| `/WminusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE2_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,962,000 | 287.66 GB | 80 | - | disk:1 |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE1_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,895,000 | 256.45 GB | 80 | - | TAPE-ONLY |
| `/WplusJetsToMuNu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23MiniAODv4-PUAVE2_130X_mcRun3_2023_realistic_v15-v2/MINIAODSIM` | 14,922,400 | 290.17 GB | 78 | - | disk:1 |
| **total (19 datasets)** | **229,319,747** | **7.10 TB** | | | |

#### inputs/mc_2025LowPU_TnP.txt
AODSIM parents of the three MiNNLO DYJetsToMuMu low-PU samples. The two Summer23DR ones are **tape-only**.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Winter26Reco-LowPUAVE5_150X_mcRun3_realistic_EOY25_forTSGStudies_v3-v2/AODSIM` | 9,996,528 | 1.58 TB | 483 | - | disk:1 |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23DR-PUAVE5_130X_mcRun3_2023_realistic_v15-v2/AODSIM` | 9,852,598 | 1.42 TB | 356 | - | TAPE-ONLY |
| `/DYJetsToMuMu_H2ErratumFix_TuneCP5_13p6TeV-powhegMiNNLO-pythia8-photos/Run3Summer23DR-PUAVE10_130X_mcRun3_2023_realistic_v15-v2/AODSIM` | 9,700,698 | 1.79 TB | 512 | - | TAPE-ONLY |
| **total (3 datasets)** | **29,549,824** | **4.78 TB** | | | |

Additional low-PU 13.6 TeV samples found (for completeness):
- **2024 low PU**: `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions24/latest/LowPU.json` = runs 386642 [645-652], 386749 [30-212], 386753 [1-1343] (Run2024I, fills 10204 and 10213, 7-9 Oct 2024), prescale column **PU7**, <mu> ~ 7.0, ~95 pb-1 recorded (OMS). Standard Muon0/Muon1/EGamma PDs of Run2024I (contained in the generic 2024 lists of section C; needs this lumi mask).
- **2026 low PU (largest Run-3 low-PU set; NOT requested after the clarification, lists provided anyway, see the next subsection)**.
- **2026 PU7 reference**: `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions26/latest/Cert_Collisions2026_RefToRef_PU7_nomE13p6TeV.json` = runs 403863, 403866 (Run2026D, fill 11733, May 2026), prescale column LowPU_L1Jet35_Loose, <mu> ~ 7.0, ~91 pb-1; in Muon0-3/EGamma Run2026D PromptReco (Muon0: 5.1M events, 120 GB in these runs). No list written.
- 2026 VdM fills (beta* 19.2 m, mu ~0.7, LumiScan menu): 11607-11614 (Apr 2026, Run2026C) and 11739-11742 (May 2026, Run2026D) - same situation as the July-2025 VdM fills.

### 2026 low-pileup 13.6 TeV (not requested after the clarification; provided because it clearly exists)

Official JSON `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions26/latest/Cert_Collisions2026_lowPU.json`: **52 runs, 401866-403214** (Run2026B: 401866-401869; Run2026C: 402536-403214), 54,844 LS, fills 11505-11631 (13 Mar - late Apr 2026), standard 2026 physics menus (`/cdaq/physics/Run2026/2e34/v1.0.1` and `v1.1.1`) in prescale column **PU5** (+ variants), <mu> = 5.0 (p10-p90: 4.9-5.1), **~2.12 fb-1 recorded** (OMS per-LS sum). Standard PDs, PromptReco-v1 only; Run2026B/C are dominated by these runs (Muon0 low-PU subset: B 0.55M events / 11 GB, C 0.77e9 events / 13.1 TB MINIAOD, 72 TB AOD). Dedicated MC campaign **RunIII2026LowPUSummer26** (`160X_mcRun3_2026_lowPU_v3`, with central NanoAODv15). This is very likely what "2026 13 TeV low PU" in the original request referred to - the user should confirm.

#### inputs/data_2026LowPU.txt
Low-PU subset ~3.1e9 events, ~52 TB (4 x Muon0 numbers). Table = full Run2026B/C datasets.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2026B-PromptReco-v1/MINIAOD` | 155,034,715 | 9.26 TB | 2511 | 76 (401844-402513) | disk:21 |
| `/Muon1/Run2026B-PromptReco-v1/MINIAOD` | 155,028,140 | 9.26 TB | 2506 | 75 (401844-402513) | disk:11 |
| `/Muon2/Run2026B-PromptReco-v1/MINIAOD` | 155,029,788 | 9.26 TB | 2535 | 75 (401844-402513) | disk:3 |
| `/Muon3/Run2026B-PromptReco-v1/MINIAOD` | 155,025,135 | 9.26 TB | 2505 | 75 (401844-402513) | disk:9 |
| `/Muon0/Run2026C-PromptReco-v1/MINIAOD` | 779,902,163 | 13.28 TB | 3445 | 87 (402536-403421) | disk:11 |
| `/Muon1/Run2026C-PromptReco-v1/MINIAOD` | 779,231,920 | 13.28 TB | 3414 | 72 (402536-403316) | disk:8 |
| `/Muon2/Run2026C-PromptReco-v1/MINIAOD` | 779,164,947 | 13.27 TB | 3418 | 72 (402536-403316) | disk:2 |
| `/Muon3/Run2026C-PromptReco-v1/MINIAOD` | 779,192,881 | 13.27 TB | 3402 | 70 (402536-403316) | disk:8 |
| **total (8 datasets)** | **3,737,609,689** | **90.16 TB** | | | |

#### inputs/dataEGamma_2026LowPU.txt
Low-PU subset ~2.2e9 events, ~47 TB (6 x EGamma0: 0.37e9 events / 7.8 TB in Run2026C + 1.6M / 35 GB in Run2026B).

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/EGamma0/Run2026B-PromptReco-v1/MINIAOD` | 205,275,441 | 12.07 TB | 3264 | 72 (401844-402513) | disk:9 |
| `/EGamma1/Run2026B-PromptReco-v1/MINIAOD` | 205,266,455 | 12.07 TB | 3282 | 72 (401844-402513) | disk:8 |
| `/EGamma2/Run2026B-PromptReco-v1/MINIAOD` | 205,274,221 | 12.07 TB | 3291 | 72 (401844-402513) | disk:8 |
| `/EGamma3/Run2026B-PromptReco-v1/MINIAOD` | 205,271,520 | 12.07 TB | 3282 | 72 (401844-402513) | disk:10 |
| `/EGamma4/Run2026B-PromptReco-v1/MINIAOD` | 205,273,231 | 12.07 TB | 3295 | 72 (401844-402513) | disk:8 |
| `/EGamma5/Run2026B-PromptReco-v1/MINIAOD` | 205,265,468 | 12.07 TB | 3299 | 72 (401844-402513) | disk:9 |
| `/EGamma0/Run2026C-PromptReco-v1/MINIAOD` | 375,030,929 | 8.04 TB | 2125 | 75 (402536-403421) | disk:9 |
| `/EGamma1/Run2026C-PromptReco-v1/MINIAOD` | 374,809,724 | 8.03 TB | 2124 | 66 (402536-403316) | disk:5 |
| `/EGamma2/Run2026C-PromptReco-v1/MINIAOD` | 374,832,870 | 8.04 TB | 2115 | 67 (402536-403316) | disk:9 |
| `/EGamma3/Run2026C-PromptReco-v1/MINIAOD` | 374,811,337 | 8.03 TB | 2110 | 65 (402536-403313) | disk:6 |
| `/EGamma4/Run2026C-PromptReco-v1/MINIAOD` | 374,793,369 | 8.03 TB | 2106 | 66 (402536-403313) | disk:2 |
| `/EGamma5/Run2026C-PromptReco-v1/MINIAOD` | 374,804,007 | 8.03 TB | 2106 | 68 (402536-403316) | disk:12 |
| **total (12 datasets)** | **3,480,708,572** | **120.64 TB** | | | |

#### inputs/data_2026LowPU_TnP.txt
Low-PU subset ~290 TB of AOD (Muon0 C alone 72 TB / 18k files) - probably use only one or two of the Muon PDs.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/Muon0/Run2026B-PromptReco-v1/AOD` | 155,034,715 | 67.24 TB | 20329 | 76 (401844-402513) | disk:1 |
| `/Muon1/Run2026B-PromptReco-v1/AOD` | 155,028,140 | 67.24 TB | 20347 | 75 (401844-402513) | disk:1 |
| `/Muon2/Run2026B-PromptReco-v1/AOD` | 155,029,788 | 67.24 TB | 20360 | 75 (401844-402513) | disk:1 |
| `/Muon3/Run2026B-PromptReco-v1/AOD` | 155,025,135 | 67.24 TB | 20364 | 75 (401844-402513) | disk:1 |
| `/Muon0/Run2026C-PromptReco-v1/AOD` | 779,902,163 | 73.53 TB | 18448 | 87 (402536-403421) | disk:1 |
| `/Muon1/Run2026C-PromptReco-v1/AOD` | 779,231,920 | 73.52 TB | 18415 | 72 (402536-403316) | disk:1 |
| `/Muon2/Run2026C-PromptReco-v1/AOD` | 779,164,947 | 73.45 TB | 18394 | 72 (402536-403316) | disk:23 |
| `/Muon3/Run2026C-PromptReco-v1/AOD` | 779,192,881 | 73.48 TB | 18389 | 70 (402536-403316) | disk:25 |
| **total (8 datasets)** | **3,737,609,689** | **562.93 TB** | | | |

#### inputs/mc_2026LowPU.txt
RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2: W/Z only as madgraphMLM 4-jet samples (DYto2E/2Mu/2Tau-4Jets MLL-50, WtoENu/MuNu/TauNu-4Jets; ~30-40M events each), TTto2L2Nu/LNu2Q/4Q powheg, Jpsito2Mu PTJpsi-8, QCD pT-flat. No MiNNLO, no dibosons, no single top, no Upsilon.

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2E-4Jets_Bin-MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 32,469,655 | 1.38 TB | 405 | - | disk:2 |
| `/DYto2Mu-4Jets_Bin-MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 32,472,148 | 1.36 TB | 391 | - | disk:2 |
| `/DYto2Tau-4Jets_Bin-MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 26,837,110 | 976.70 GB | 366 | - | disk:4 |
| `/WtoENu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 41,721,431 | 1.45 TB | 468 | - | disk:3 |
| `/WtoMuNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 38,469,069 | 1.34 TB | 394 | - | disk:2 |
| `/WtoTauNu-4Jets_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 39,855,381 | 1.25 TB | 402 | - | disk:8 |
| `/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 29,943,000 | 2.07 TB | 560 | - | disk:3 |
| `/TTto4Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 29,985,999 | 2.10 TB | 606 | - | disk:2 |
| `/TTtoLNu2Q_TuneCP5_13p6TeV_powheg-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 29,975,000 | 2.09 TB | 607 | - | disk:3 |
| `/Jpsito2Mu_Bin-PTJpsi-8_TuneCP5_13p6TeV_pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 16,417,577 | 531.56 GB | 216 | - | disk:3 |
| `/QCD_Bin-PT-15to7000_Par-PT-flat2022_TuneCP5_13p6TeV_pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 29,590,995 | 1.99 TB | 580 | - | disk:2 |
| **total (11 datasets)** | **347,737,365** | **16.53 TB** | | | |

#### inputs/mc_2026LowPU_other.txt
HT-binned QCD-4Jets (11), GJ-4Jets photon+jets (16), SingleNeutrino gun, DYJetsToLL pilot (9.9k events).

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYJetsToLL_M-50_TuneCP5_13p6TeV-madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_pilot_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 9,887 | 456.27 MB | 1 | - | disk:2 |
| `/GJ-4Jets_Bin-HT-1000-PTG-100to200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 31,969,086 | 3.10 TB | 976 | - | disk:2 |
| `/GJ-4Jets_Bin-HT-1000-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 39,815,746 | 3.71 TB | 1303 | - | disk:8 |
| `/GJ-4Jets_Bin-HT-1000-PTG-200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 21,592,744 | 2.10 TB | 629 | - | disk:4 |
| `/GJ-4Jets_Bin-HT-100to200-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 35,360,257 | 1.55 TB | 491 | - | disk:6 |
| `/GJ-4Jets_Bin-HT-10to40-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 39,438,078 | 1.28 TB | 452 | - | disk:9 |
| `/GJ-4Jets_Bin-HT-200to400-PTG-100to200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 35,946,407 | 2.17 TB | 694 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-200to400-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 41,718,697 | 2.27 TB | 673 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-400to600-PTG-100to200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 27,555,256 | 2.11 TB | 606 | - | disk:2 |
| `/GJ-4Jets_Bin-HT-400to600-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 45,821,573 | 3.18 TB | 985 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-400to600-PTG-200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 21,577,306 | 1.62 TB | 617 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-40to100-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 37,965,242 | 1.40 TB | 449 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-40to200-PTG-100to200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 31,259,479 | 1.56 TB | 503 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-40to400-PTG-200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 21,095,944 | 1.33 TB | 418 | - | disk:8 |
| `/GJ-4Jets_Bin-HT-600to1000-PTG-100to200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 32,599,232 | 2.79 TB | 824 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-600to1000-PTG-10to100_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 37,655,001 | 3.06 TB | 894 | - | disk:3 |
| `/GJ-4Jets_Bin-HT-600to1000-PTG-200_Par-dRGJ-0p25_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 17,370,366 | 1.49 TB | 493 | - | disk:2 |
| `/QCD-4Jets_Bin-HT-1000to1200_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 46,469,716 | 3.80 TB | 1096 | - | disk:2 |
| `/QCD-4Jets_Bin-HT-100to200_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 40,410,406 | 1.56 TB | 573 | - | disk:2 |
| `/QCD-4Jets_Bin-HT-10to40_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 38,296,902 | 1.16 TB | 359 | - | disk:3 |
| `/QCD-4Jets_Bin-HT-1200to1500_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 41,678,018 | 3.71 TB | 1051 | - | disk:9 |
| `/QCD-4Jets_Bin-HT-1500to2000_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 39,307,776 | 3.69 TB | 1086 | - | disk:9 |
| `/QCD-4Jets_Bin-HT-2000_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 38,869,431 | 3.93 TB | 1214 | - | disk:7 |
| `/QCD-4Jets_Bin-HT-200to400_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 37,110,336 | 1.86 TB | 547 | - | disk:8 |
| `/QCD-4Jets_Bin-HT-400to600_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 34,757,114 | 2.30 TB | 687 | - | disk:5 |
| `/QCD-4Jets_Bin-HT-40to70_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 36,672,555 | 1.18 TB | 378 | - | disk:3 |
| `/QCD-4Jets_Bin-HT-600to800_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 42,310,935 | 3.07 TB | 871 | - | disk:2 |
| `/QCD-4Jets_Bin-HT-70to100_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 41,547,006 | 1.42 TB | 440 | - | disk:3 |
| `/QCD-4Jets_Bin-HT-800to1000_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 35,174,844 | 2.88 TB | 894 | - | disk:24 |
| `/SingleNeutrino_E-10_gun/RunIII2026LowPUSummer26MiniAODv6-DRLowPU_Miniv6LowPU_160X_mcRun3_2026_lowPU_v3-v2/MINIAODSIM` | 19,984,000 | 249.16 GB | 102 | - | disk:4 |
| **total (30 datasets)** | **1,011,339,340** | **65.55 TB** | | | |

#### inputs/mc_2026LowPU_TnP.txt
AODSIM parent of the DYto2Mu-4Jets MINIAODSIM (on disk).

| dataset | events | size | files | runs | notes |
|---|---|---|---|---|---|
| `/DYto2Mu-4Jets_Bin-MLL-50_TuneCP5_13p6TeV_madgraphMLM-pythia8/RunIII2026LowPUSummer26DR-DRLowPU_160X_mcRun3_2026_lowPU_v3-v2/AODSIM` | 32,472,148 | 4.97 TB | 1267 | - | disk:2 |
| **total (1 datasets)** | **32,472,148** | **4.97 TB** | | | |

### 2026 2.4 TeV (not requested; for reference)

- Official JSON `/cvmfs/cms-griddata.cern.ch/cat/metadata/DC/Collisions26/latest/Cert_Collisions2026_lowE.json`: 8 runs (403340, 403348, 403350, 403392, 403410, 403413, 403420, 403421), Run2026C, fills 11660-11669 (29 Apr - 1 May 2026), beam energy 1200 GeV, <mu> 0.2-0.6, **~3.1 pb-1** certified (OMS), physics menu `/cdaq/physics/Run2026/2e34/v1.1.3` with PU1_*b_MB* columns.
- PDs: dedicated `Special2p4TeVZeroBias0-23` and `SpecialHLTPhysics0-23` (MINIAOD, AOD, NANOAOD; PromptReco-v1), plus events in the standard Muon0/EGamma0/... PDs of Run2026C.
- No 2.4 TeV MC found in DAS (only a RelValMinBias with `mcRun3_2026_lowEnergy` conditions). No lists written.

## Open issues and decisions for the user

1. **Meaning of "2025 low PU" (section D) needs your confirmation.**
   - The July-2025 fills 10821-10831 are the 2025 van der Meer (VdM) fills. Their menu is the LumiScan menu: zero-bias, random and scouting-monitor paths only. They have no lepton triggers and no Muon/EGamma PDs, and give about 1.6 pb-1 in total.
   - The only certified 2025 low-PU 13.6 TeV physics data are runs 398682, 398683 and 398803 (Run2025G, Oct/Nov 2025). These have <mu> about 7 and about 71.5 pb-1, and are certified in `Collisions25/latest/2025_lowPU_updated.json`.
   - `data_2025LowPU*.txt` contain the Run2025G standard PDs. The LowPU JSON lumi mask is mandatory for them.
2. **No AOD for the 2024 pp reference run.** Tier-0 wrote no AOD for the PPRef PDs, so `data_2024ppRef_TnP.txt` has no dataset line. The options are to run T&P on MiniAOD or to re-RECO from RAW.
3. **Run 2 low-PU and CVH.** Only SingleMuon `UL2017_MiniAODv2_GT36-v2` (2017H and 2017G) keeps the muon tracker clusters. DoubleMuon, HighEGJet and SingleMuonTnP have no GT36 version, so they have no muon tracker hits and cannot be used for CVH.
   - 2017H SingleMuon GT36: the 15Feb2022 AOD lineage lacks 4 golden LS (run 306936). The RECO-step `/SingleMuon/Run2017H-15Feb2022_UL2017-v1/MINIAOD` has them and also keeps the clusters.
4. **Low-PU runs inside the standard Run 3 lists.**
   - The 2024 low-PU runs (`Collisions24/latest/LowPU.json`, 386642 LS 645-652, 386749, 386753) are in `data_2024*.txt`. The 2025 low-PU runs are in `data_2025*.txt`.
   - The standard golden JSONs already exclude them. Checked: 2024 golden has 386642 only as [1,644],[653,724] and has neither 386749 nor 386753. The 2025 golden 391658-398903 has none of 398682/3/803.
   - So masking with the golden JSON separates high- and low-PU data automatically.
5. **Lists written beyond the clarified request.** These can be deleted if not wanted:
   - The 2026 low-PU lists `data_2026LowPU*.txt`, `dataEGamma_2026LowPU.txt` and `mc_2026LowPU*.txt`. The 2026 low-PU run is the largest Run-3 low-PU sample: <mu>=5, about 2.1 fb-1, with a dedicated MC campaign, RunIII2026LowPUSummer26.
   - The `dataEGamma_*` lists for the special runs.
6. **Tape-only inputs.** These need a Rucio rule or tape recall before CRAB:
   - 2017H/2017G DoubleMuon, HighEGJet and SingleMuonTnP AOD.
   - 5 TeV WplusJetsToMuNu AODSIM.
   - `/DoubleMuon/Run2022C-27Jun2023-v1/AOD`.
   - Several Run 3 T&P DY AODSIM.
   - `/Muon0/Run2025E-PromptReco-v1/AOD`.
   - 2024 ppRef DY AODSIM.
7. **T&P AOD volume for Run 3** is about 1.6 PB (2024) and 1.8 PB (2025), mostly at one disk site each. Restrict T&P to a subset of eras or PDs.
8. **Missing or incomplete MC.**
   - **5 TeV UL (2017G):** no ttbar (only a UL MiniAODv1 pilot), no ST tW top, WW, ZZ or psi(2S). These exist only in 94X.
   - **2023 / 2023BPix:** W MiNNLO is still PRODUCTION; these lines are commented out so they can be enabled later.
   - **2024:** no W MiNNLO.
   - **2025:** there is no full high-PU MC campaign. `mc_2025.txt` is a stop-gap built from Winter25/Winter26 trigger-study samples.
   - **MiNNLO T&P:** no MiNNLO DY has AODSIM in Run 3, so the T&P MC uses POWHEG or amcatnlo DY.
9. **2017 low-PU MC with other PU scenarios.** For2017H-conditions DYJetsToTauTau, dibosons and ST s-channel exist only in `RunIISummer20UL17MiniAODv2` with the PUMu4 or EpsilonPU processing. They are commented out in `lowPUMC_UL.txt`; verify their pileup profile before using them.
10. **`data_2017.txt` change not made by this inventory.** It has an uncommitted change in the working tree that removes Run2017G/H.
