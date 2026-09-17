# CMSSW_15_0 production (branch WmassNanoProd_15_0_19_patch2)

The CMSSW_15_0_19_patch2 port of the custom NanoAOD (WMass/cmssw PR #46 and
its follow-ups) is driven from the same scripts with `--era NanoV15` (the
default on this branch): `scripts/makeNanoV15<Sample>.sh` are the cmsDriver
recipes (stock NANO + `nanoAOD_wmassContent` + `nanoGenWmassCustomize` for
MC + the CVH refit `nanoAOD_addCvhMuon[MC]`) and `Templates/submitCrabNanoV15Template`
the crab template. Differences to the 10_6 production:

* the area is el9 (`SCRAM_ARCH=el9_amd64_gcc12`), no container needed:
  `bash <(curl -s https://raw.githubusercontent.com/WMass/WMassNanoProduction/WmassNanoProd_15_0_19_patch2/setup/clone_15_0.sh)`
* the CVH refit is multithreaded: `-j 4` (the default) instead of the old
  `-j1`, and the crab jobs get `numCores = nThreads`
* the scripts accept `file:/path/to.root` as input for local tests
* the 2017 low-PU run (2017H) uses the UL re-reconstruction
  (`inputs/lowPUMC_UL.txt`, `inputs/lowPUData_UL.txt`: RunIILowPUSummer20UL17MiniAODv2 and
  Run2017H-UL2017_MiniAODv2) with `scripts/makeNanoV15{MC,Data}LowPU.sh` -- the standard
  `run2_nanoAOD_106Xv2` path plus `nanoAOD_wmassLowPU` (HI-menu trigger objects, low-PU DeepMET
  models), no CVH refit; `prepareCrab.py` labels these datasets `MCLowPU` / `DataLowPU`
* the scripts also accept `root://...` inputs
* the muon tag-and-probe nano (`--tagAndProbe`, `PhysicsTools/NanoAOD/nanoTP_cff.customizeNANOTP`):
  one `PAT,NANO` job from AOD, `scripts/makeNanoV15{MC,Data}TagAndProbe{PreVFP,PostVFP}.sh`,
  `makeNanoV15{MC,Data}{2017,2018}TagAndProbe.sh`, `makeNanoV15{MC,Data}LowPUTagAndProbe.sh`
  (inputs: `dy*_TnP_v15.txt`, `data_{pre,post}VFP_TnP.txt`, `data_{2017,2018}_TnP.txt`,
  `lowPU{MC,Data}_TnP_UL.txt`). The era is `Run2_20xx` with `--procModifiers run2_miniAOD_UL`
  and deliberately without `run2_nanoAOD_106Xv2` (its PUPPI re-clustering / tau re-wiring is
  circular when PAT runs in the same process). Content as in 10_6: Muon (+ `standaloneExtraIdx`,
  `innerTrackExtraIdx`, `isStandAloneUpdatedAtVtx`, vertex-agnostic isolation), Track (generalTracks
  pT > 8), StandAloneMuon / StandAloneMuonUpdatedAtVtx / MergedStandAloneMuon, IsoTrack, PV/SV,
  TrigObj (with the IsoMu24/IsoTkMu24 bits), L1/HLT; MC adds GenPart/GenVtx/Pileup, the grouped LHE
  weights and the muon gen match. No jets, MET, electrons, photons, taus. The electron low-PU T&P
  of 10_6 is not ported.

Example: `./scripts/prepareCrab.py --makeConfig -i inputs/dyMC_v9.txt -v v1 --dryRun`

Scripts for keeping track of private nanoaod production. Auto-generates config files from cmsDriver and crab_submit files. Divides the production into X pieces and submits every Y jobs.

# To clone with CMSSW setup

# Needed if on a non-slc7 machine
```sh
cmssw-cc7
bash <(curl -s https://raw.githubusercontent.com/WMass/WMassNanoProduction/main/setup/clone.sh)

cd CMSSW_10_6_26/src/Configuration/WMassNanoProduction
```

# Running

Ex: ```./scripts/prepareCrab.py --makeConfig -j1 -i inputs/data.txt```

Will make all the crab submit files for the data samples in that text file. ```--makeConfig``` generates the configs from the cmsDriver scripts in the scripts directory, in order to ensure things are up to date.  ```-j1``` forces single core running which is needed for the Geant4e propagator.

Add ```--submit X Y``` to split the submission into X pieces and submit every Y sample. For example, to divide production between 3 people, ./scripts/prepareCrab.py inputs/data.txt --submit 3 i for i = 1,2,3 for the 3 different people.

After you submit, a file named ```history/<dataset>_<date>_<submitArgs>_<username>.txt``` is created. Commit this back to this repo for bookkeeping.
