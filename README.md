# WMass NanoAOD production (CMSSW_15_0_19_patch2)

Scripts to run and keep track of the private W-mass NanoAOD production with CMSSW_15_0_19_patch2
(the stable branch `WmassNanoProd_15_0_19_patch2_nanoV15` of the cmssw fork, WMass/cmssw PR #48;
`WmassNanoProd_15_0_19_patch2_dev`, PR #46, is the development branch).
`scripts/prepareCrab.py` generates the cmsDriver configs from the four scripts
`scripts/makeNanoV15{MC,Data}[TagAndProbe].sh` and the crab submit files from
`Templates/submitCrabNanoV15Template`, splits a production between people and records every
submission under `history/`.

## Campaigns

`scripts/campaign.sh` is the one table of the campaigns: detection from the dataset name (DAS path
or LFN), era (+ NANO modifier), global tag, campaign-specific customise and output label.
`prepareCrab.py` asks it; `--campaign` overrides the detection.

| campaign | data | era (NANO) | GT data / MC | label |
|---|---|---|---|---|
| 2016preVFP, 2016postVFP | UL2016 | Run2_2016[_HIPM],run2_nanoAOD_106Xv2 | 150X_dataRun2_v1 / 150X_mcRun2_asymptotic[_preVFP]_v1 | PreVFP, PostVFP |
| 2017, 2018 | UL2017 B-F, UL2018 | Run2_201x,run2_nanoAOD_106Xv2 | 150X_dataRun2_v1 / 150X_mc201x_realistic_v1 | 2017, 2018 |
| 2017LowPU | 2017H, 13 TeV low PU | Run2_2017,run2_nanoAOD_106Xv2 | 150X_dataRun2_v1 / 150X_mc2017_realistic_v1 | LowPU |
| 2017LowPU5TeV | 2017G, 5.02 TeV pp ref | Run2_2017,run2_nanoAOD_106Xv2 | 150X_dataRun2_v1 / 106X_mc2017_realistic_forppRef5TeV_v3 | LowPU5TeV |
| 2022, 2022EE | 2022 C-D, E-G (MiniAODv4) | Run3,run3_nanoAOD_pre142X | 150X_dataRun3_v6 / 150X_mcRun3_2022_realistic[_postEE]_v1 | 2022, 2022EE |
| 2023, 2023BPix | 2023 C, D (MiniAODv4) | Run3_2023,run3_nanoAOD_pre142X | 150X_dataRun3_v6 / 150X_mcRun3_2023_realistic[_postBPix]_v1 | 2023, 2023BPix |
| 2024 | 2024 (14_0: PromptReco B, F-I; 2024CDEReprocessing C-E; 140X Summer24 MC) | Run3_2024,run3_nanoAOD_pre142X | 150X_dataRun3_v6 / 150X_mcRun3_2024_realistic_v2 | 2024 |
| 2024ppRef | 2024J, 5.36 TeV pp ref (PromptReco 14_1) | Run3_2024,run3_nanoAOD_pre142X | 150X_dataRun3_v6 / 141X_mcRun3_2024_realistic_ppRef5TeV_v7 | 2024PPRef |
| 2025 | 2025 (PromptReco 15_0) | Run3_2025 | 150X_dataRun3_v6 / 150X_mcRun3_2025_realistic_v3 | 2025 |
| 2025LowPU | 13.6 TeV low-PU fills of 2025 | Run3_2025 | as 2025 | 2025LowPU |

* Global tags: Run 2 and 2022-2024 MC are the tags of the central NanoAODv15 production;
  `150X_dataRun3_v6` = the central `150X_dataRun3_v5` + newer JECs, offline tracker alignment
  through 2026 (covers 2025). The 5.02 TeV MC keeps its own 106X tag: checked on the same events
  against `150X_mc2017_realistic_v1`, the tracking, CVH, muon, trigger-object and DeepMET output is
  identical, but the 150X tag carries the 13 TeV 2017 L1 menu (wrong `L1_*` names for the 5 TeV MC)
  and a different JER (PuppiMET covariance/significance). For the same reason the 2024 pp-reference
  MC keeps its 141X tag (pp-reference L1 menu); the 13 TeV low-PU MC tag has the standard 2017 L1 menu,
  so the 150X 2017 tag is used there.
* 2025LowPU shares the 2025 primary datasets: run it with `--campaign 2025LowPU` and the run range
  of the low-pileup runs (`--runRange`, or `run_range_of` in `campaign.sh`).

## Workflows

* **W-mass nano** (`makeNanoV15{MC,Data}.sh`, every campaign): stock 15_0 NANO on the campaign's
  MiniAOD + `nanoAOD_wmassContent` (+ `nanoGenWmassCustomize` for MC) + the campaign's customise
  + the CVH muon refit `nanoAOD_addCvhMuon[MC]`, which every campaign gets. The refit keeps the
  pixel edge and single-column hits (`nanoAOD_cvhPixelClassHits`) and exports the columns of
  their class corrections (parmtypes 16-21, 8640 parameters appended to the catalog): the
  calibration applied to this nano must be derived with the same setting. The refit is
  multithreaded (`-j 4`, the default; the crab jobs get `numCores = nThreads`). Its Geant4 world
  is the sim geometry of the detector era (`nano_cff._cvhSimGeometry`).
  The refit needs the muon tracker hits in the MiniAOD: the MC MiniAODv2/v4/v6 keep them; for the
  2017 data only the `UL2017_MiniAODv2_GT36` versions do (the plain `UL2017_MiniAODv2` versions of
  2017G/H have no muon track extras, so their muons would get no CVH values).
* **2017 low-PU runs**: 2017H (13 TeV, `inputs/lowPU{MC,Data}_UL.txt`) adds `nanoAOD_wmassLowPU`
  (HI-menu trigger objects, low-PU DeepMET models); 2017G (5.02 TeV, `inputs/lowPU5TeV{MC,Data}_UL.txt`)
  adds `nanoAOD_wmassLowPU5TeV` (the same HI-menu trigger objects, stock DeepMET).
* **Muon tag-and-probe** (`--tagAndProbe`; `makeNanoV15{MC,Data}TagAndProbe.sh`, Run 2 campaigns
  incl. 2017LowPU5TeV; inputs `dy*_TnP_v15.txt`, `data_*_TnP.txt`, `lowPU*_TnP_UL.txt`): one `PAT,NANO`
  job from AOD with `PhysicsTools/NanoAOD/nanoTP_cff.customizeNANOTP[LowPU]`, era `Run2_20xx`
  with `--procModifiers run2_miniAOD_UL` and deliberately without `run2_nanoAOD_106Xv2`
  (its PUPPI re-clustering / tau re-wiring is circular when PAT runs in the same process).
  Content as in the 10_6 T&P nano: Muon (+ `standaloneExtraIdx`, `innerTrackExtraIdx`,
  `isStandAloneUpdatedAtVtx`, vertex-agnostic isolation), Track (generalTracks pT > 8),
  StandAloneMuon / StandAloneMuonUpdatedAtVtx / MergedStandAloneMuon, IsoTrack, PV/SV,
  TrigObj (with the IsoMu24/IsoTkMu24 bits), L1/HLT; MC adds GenPart/GenVtx/Pileup, the
  grouped LHE weights and the muon gen match. No jets, MET, electrons, photons, taus, no CVH refit.

The scripts accept `file:/path/to.root` and `root://...` inputs for local tests.

Example: `./scripts/prepareCrab.py --makeConfig -i inputs/dyMC_v15.txt -v v1 --dryRun`

## Input lists and known issues (2026-10-03)

The lists in `inputs/` were rebuilt from DAS on 2026-10-03; `inputs/INVENTORY_261003.md` has
per-dataset events/sizes, the choices and the alternatives. Lines starting with `#` are comments.

* Run 2 low-PU data: only `SingleMuon/...UL2017_MiniAODv2_GT36-v2` keeps the muon tracker hits;
  DoubleMuon and HighEGJet exist only without GT36 (nano fine, no CVH values).
* 2024: the 15_0 MiniAODv6 (data MINIv6NANOv15, RunIII2024Summer24MiniAODv6 MC incl. the MiNNLO
  DY) has EMPTY muon strip clusters on disk: the central 15_0 re-MINI read the 14_0 AOD
  (SiStripCluster v13, split 99) through read rules ROOT does not feed for split > 1
  (root-project/root#19773). The CVH refit diverges on it, so the 2024 lists use the 14_0 MiniAOD
  instead (PromptReco B, F-I; 2024CDEReprocessing C-E; 140X Summer24 MC), which the cmssw branch
  reads correctly with its SiStripCluster read-rule fix. 13 MC samples exist only as MiniAODv6
  (incl. MiNNLO DY->mumu): commented out in `mc_2024.txt`, they would need a re-MINI.
* 2024 pp reference (2024J): 14_1 PromptReco, read correctly with the read-rule fix; not every run
  has muon inner tracks (run 387396 has none).
* 2025LowPU: the certified low-pileup physics runs 398682-398803 of Run2025G with
  `Collisions25/latest/2025_lowPU_updated.json` (set by `campaign.sh`); run with
  `--campaign 2025LowPU`. No MC with the 2025 low-PU conditions exists (`mc_2025LowPU.txt` is the
  closest available).
* 2026 low PU (`*_2026LowPU*.txt`, ~2.1 fb-1, own MC campaign RunIII2026LowPUSummer26): data and
  MC were produced with CMSSW_16_0 and cannot be read by this 15_0 setup; lists kept for reference.
* Tag-and-probe nano: Run 2 campaigns only, without the CVH refit.

# To clone with CMSSW setup

el9 host (`SCRAM_ARCH=el9_amd64_gcc12`), no container:
```sh
bash <(curl -s https://raw.githubusercontent.com/WMass/WMassNanoProduction/WmassNanoProd_15_0_19_patch2/setup/clone_15_0.sh)

cd CMSSW_15_0_19_patch2/src/Configuration/WMassNanoProduction
```
`setup/sparse-checkout_15_0` lists the packages the cmssw branch modifies (informational; the
clone script uses `git cms-checkout-topic`).

# Running

Ex: ```./scripts/prepareCrab.py --makeConfig -i inputs/data_postVFP.txt -v v1```

Will make all the crab submit files for the data samples in that text file. ```--makeConfig``` generates the configs from the cmsDriver scripts in the scripts directory, in order to ensure things are up to date.  `-j` sets the threads per job (default 4; the CVH refit is multithreaded).

Add ```--submit X Y``` to split the submission into X pieces and submit every Y sample. For example, to divide production between 3 people, ./scripts/prepareCrab.py inputs/data.txt --submit 3 i for i = 1,2,3 for the 3 different people.

After you submit, a file named ```history/<dataset>_<date>_<submitArgs>_<username>.txt``` is created. Commit this back to this repo for bookkeeping.
