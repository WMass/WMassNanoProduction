# WMass NanoAOD production (CMSSW_15_0_19_patch2)

Scripts to run and keep track of the private W-mass NanoAOD production on the
CMSSW_15_0_19_patch2 branch of WMass/cmssw (`WmassNanoProd_15_0_19_patch2_dev`,
PR #46). `scripts/prepareCrab.py` generates the cmsDriver configs from
`scripts/makeNanoV15<Sample>.sh` and the crab submit files from
`Templates/submitCrabNanoV15Template`, splits a production between people and
records every submission under `history/`.

Workflows (one script per era and sample type, `prepareCrab.py` picks it from the
dataset name):

* **W-mass nano** (`makeNanoV15{MC,Data}{PreVFP,PostVFP,2017,2018}.sh`): stock 15_0
  NANO on the UL MiniAODv2 + `nanoAOD_wmassContent` (+ `nanoGenWmassCustomize` for MC)
  + the CVH muon refit `nanoAOD_addCvhMuon[MC]`. The refit is multithreaded (`-j 4`,
  the default; the crab jobs get `numCores = nThreads`). Inputs: `inputs/dyMC_v15.txt`,
  `wMC_v15.txt`, `bkgMC.txt`, `data_{pre,post}VFP.txt`, `*2017*`, `*2018*`.
* **2017 low-PU run (2017H)** on the UL re-reconstruction (`makeNanoV15{MC,Data}LowPU.sh`,
  `inputs/lowPU{MC,Data}_UL.txt`): the standard path plus `nanoAOD_wmassLowPU` (HI-menu
  trigger objects, low-PU DeepMET models), no CVH refit; labelled `MCLowPU` / `DataLowPU`.
* **Muon tag-and-probe** (`--tagAndProbe`; `makeNanoV15{MC,Data}TagAndProbe{PreVFP,PostVFP}.sh`,
  `makeNanoV15{MC,Data}{2017,2018}TagAndProbe.sh`, `makeNanoV15{MC,Data}LowPUTagAndProbe.sh`;
  inputs `dy*_TnP_v15.txt`, `data_*_TnP.txt`, `lowPU{MC,Data}_TnP_UL.txt`): one `PAT,NANO`
  job from AOD with `PhysicsTools/NanoAOD/nanoTP_cff.customizeNANOTP[LowPU]`, era `Run2_20xx`
  with `--procModifiers run2_miniAOD_UL` and deliberately without `run2_nanoAOD_106Xv2`
  (its PUPPI re-clustering / tau re-wiring is circular when PAT runs in the same process).
  Content as in the 10_6 T&P nano: Muon (+ `standaloneExtraIdx`, `innerTrackExtraIdx`,
  `isStandAloneUpdatedAtVtx`, vertex-agnostic isolation), Track (generalTracks pT > 8),
  StandAloneMuon / StandAloneMuonUpdatedAtVtx / MergedStandAloneMuon, IsoTrack, PV/SV,
  TrigObj (with the IsoMu24/IsoTkMu24 bits), L1/HLT; MC adds GenPart/GenVtx/Pileup, the
  grouped LHE weights and the muon gen match. No jets, MET, electrons, photons, taus.

The scripts accept `file:/path/to.root` and `root://...` inputs for local tests.

Example: `./scripts/prepareCrab.py --makeConfig -i inputs/dyMC_v15.txt -v v1 --dryRun`

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
