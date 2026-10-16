# AlCaReco inputs of the AlCaReco nano -- 2026-10-16

The samples of AN-21-131 (v9), 2016 postVFP. Built from DAS (status, `summary dataset=...`) and Rucio (disk
replicas; `disk` = every file at the site) on 2026-10-16. All datasets are VALID. CRAB reads only from disk:
the `TAPE` datasets need a recall to a disk site before submission.

## `inputs/alcareco_data_postVFP.txt`

6 datasets, 98,600,845 events, 0.44 TB.

| dataset | events | files | size [TB] | replicas |
|---|---|---|---|---|
| `/Charmonium/Run2016F-TkAlJpsiMuMu-21Feb2020_UL2016-v1/ALCARECO` | 2,288,895 | 7 | 0.010 | disk: T2_CH_CERN |
| `/Charmonium/Run2016G-TkAlJpsiMuMu-21Feb2020_UL2016-v1/ALCARECO` | 41,103,908 | 121 | 0.181 | disk: T2_CH_CERN |
| `/Charmonium/Run2016H-TkAlJpsiMuMu-21Feb2020_UL2016-v1/ALCARECO` | 46,975,701 | 122 | 0.213 | disk: T2_CH_CERN |
| `/MuOnia/Run2016F-TkAlUpsilonMuMu-31Aug2023_UL2016_WMass-v1/ALCARECO` | 214,784 | 2 | 0.001 | TAPE-ONLY |
| `/MuOnia/Run2016G-TkAlUpsilonMuMu-31Aug2023_UL2016_WMass-v1/ALCARECO` | 3,782,522 | 22 | 0.017 | TAPE-ONLY |
| `/MuOnia/Run2016H-TkAlUpsilonMuMu-31Aug2023_UL2016_WMass-v1/ALCARECO` | 4,235,035 | 41 | 0.019 | TAPE-ONLY |

## `inputs/alcareco_mc_postVFP.txt`

7 datasets, 187,484,641 events, 7.54 TB.

| dataset | events | files | size [TB] | replicas |
|---|---|---|---|---|
| `/JPsiToMuMu_Pt0to8-pythia8/RunIISummer20UL16RECO-TkAlJpsiMuMu-106X_mcRun2_asymptotic_v13-v2/ALCARECO` | 456,470 | 23 | 0.017 | disk: T2_CH_CERN |
| `/JPsiToMuMu_Pt0to8-pythia8/RunIISummer20UL16RECO-TkAlJpsiMuMu-106X_mcRun2_asymptotic_v13_ext1-v3/ALCARECO` | 1,373,184 | 75 | 0.055 | disk: T2_CH_CERN |
| `/JPsiToMuMu_Pt8toInf-pythia8/RunIISummer20UL16RECO-TkAlJpsiMuMu-106X_mcRun2_asymptotic_v13-v2/ALCARECO` | 30,117,032 | 569 | 1.163 | disk: T2_CH_CERN |
| `/JPsiToMuMu_Pt8toInf-pythia8/RunIISummer20UL16RECO-TkAlJpsiMuMu-106X_mcRun2_asymptotic_v13_ext1-v3/ALCARECO` | 90,839,033 | 1462 | 3.730 | disk: T2_CH_CERN |
| `/Upsilon_MultiResonanceFilter_Pt0to8-pythia8/RunIISummer20UL16RECO-TkAlUpsilonMuMu-106X_mcRun2_asymptotic_v13-v2/ALCARECO` | 2,980,640 | 100 | 0.105 | TAPE-ONLY |
| `/Upsilon_MultiResonanceFilter_Pt8to13-pythia8/RunIISummer20UL16RECO-TkAlUpsilonMuMu-106X_mcRun2_asymptotic_v13-v2/ALCARECO` | 13,756,522 | 215 | 0.520 | TAPE-ONLY |
| `/Upsilon_MultiResonanceFilter_Pt13toInf-pythia8/RunIISummer20UL16RECO-TkAlUpsilonMuMu-106X_mcRun2_asymptotic_v13-v2/ALCARECO` | 47,961,760 | 724 | 1.945 | TAPE (5/724 files at T2_RU_IHEP) |
