# MuKPiGun UL16 Premix campaign — decisions log

## Locked design decisions (chronological)

1. **Chain**: GENSIM -> premix DIGI (UL16 official premix lib, premix_stage2) -> RECO -> (matched-track) ALCARECO. **No HLT leg** (user, 2026-10-16). One release: CMSSW_10_6_17_patch1 (slc7), 106X_mcRun2_asymptotic_v13, era Run2_2016.
2. **Model**: /DoubleMuonGun_Pt3To150/RunIISummer20UL16RECO-NoPU_106X_mcRun2_asymptotic_v13-v2 (SMP-RunIISummer20UL16RECO-00001 family) as chain convention; widened pT.
3. **Kinematics**: flat pT **0.01-150 GeV/c**, |eta|<=2.4, anti-particles on (user, 2026-10-16).
4. **SIM step**: custom G4 magnetic-field stepper params (carried from D* chain):
   DeltaOneStep=1e-5, DeltaIntersection=1e-6.
5. **Sim-truth (revised)**: SimTracks/SimVertices KEPT in the pilot to measure their size
   (user 2026-10-16); RECO leg = RECO_simtruth_cfg.py. Main-run persistence decided after pilot.
6. **ALCA selection (revised)**: NO cuts at alca level at all (user 2026-10-16): not even
   highPurity. Trigger prefilters removed; matcher runs in PASS-THROUGH (keepUnmatchedAll=True)
   so the match maps exist for downstream flexibility while dropping nothing.
   Extra flexibility keeps: muons, beamspot, primary vertices, genParticles, SimTracks/SimVertices.
   **Per-species stream naming** (user, 2026-10-16): stock TkAl skeletons abandoned;
   clean-room cfgs mk_alca_cfgs.py produce ALCA_{Muon,Pion,Kaon}_cfg.py with selector
   ALCARECO{Muon,Pion,Kaon}, filterName={Muon,Pion,Kaon}, files {Muon,Pion,Kaon}.root.
7. **Output tier**: pilot and main produce ALCARECO only (user, 2026-10-16);
   GENSIM/DIGI/RECO intermediates are job-local (not staged out via crab).
8. **MAIN SAMPLE SELECTION = loose-gen-match preselection** (user, 2026-10-16):
   matched gun tracks stored (stable-gen ΔR/pT loose match; possible small PU
   overflow margin), genParticles + match map persisted; raw generalTracks dropped.
   Consequence: small outputs; occurrence/decay maps come from the match itself;
   PU fake-rate NOT measurable from the main sample (accepted).
9. **Destination/site**: T3_US_MIT (ceph), LFN /store/user/emanca/<campaign>;
   DAS publication ON, phys03.
10. **Volumes**: pilot 3 species x 2 jobs x 5000 ev; full ~150M total.
11. **Driver**: run_chain.sh (D* e2e pattern, single release, no HLT).
    crab configs: crab_pilot_guns.py + crab_{Mu,Pi,K}Gun_pilot.py (self-contained).

## Open follow-ups
- Brownfield: exact branch for the gun ALCA sequence home (WMass cmssw branch).
- deterministic seeds machinery from D* e2e to port for the full run.
- CPU/size quotes from smoke (smoke_simtruth.sh) to finalize job splitting.

## Plugin decision (2026-10-16, user)
- **GenMatchedTrackFilter** built (GunAlcaReco/GenTrackMatch in clean /scratch
  area, lib shipped in payload): loose ΔR(0.1)+ΔpTrel(1.0) match to stable
  charged gen products; keeps matched subset (TrackExtra-preserving clones),
  emits dRMatch/dPtRelMatch/genMatched ValueMaps; unmatched kept none (PU out).
  Wired into both ALCA cfgs after the selector; validated via edmConfigDump.

## Pilot submissions (2026-10-16)
- MuGun: 261016_193647:emanca_crab_MuGun_UL16Premix_MuGun_v0_20261016
- PiGun: 261016_193740:emanca_crab_PiGun_UL16Premix_PiGun_v0_20261016
- KGun: 261016_193816:emanca_crab_KGun_UL16Premix_KGun_v0_20261016
- Each: 2 jobs x 5000 events, PrivateMC + scriptExe run_chain.sh, T3_US_MIT stageout,
  DAS publication requested (phys03). OUT: {Species}_ALCARECO.root + monitoring.json.

## Pilot v4 adjustments (2026-10-17)
- publication=False for pilot tasks (crabserver refused publication=True+phys03
  for scriptExe outputs; reopen with a proper output-module pset for the 150M run).
- outLFNDirBase moved to /store/group/zmass/... on T3_US_MIT: /store/user/emanca/...
  is POSIX-blocked (drwx--S--- cmsuser) so no tracker listing/counting possible;
  /store/group/zmass is group-traversable => tracker bars work via plain fs.
- v4 tasks: MuGun 261017_093906, PiGun 261017_093933, KGun 261017_094006.
- v0..v3 tasks superseded (left for server GC; no jobs harmed).

## Premix segfault root cause + fix (2026-10-19)
- v6 Pi/KGun cmsRun SEGV at DIGIPremix: pileup mixing is not stream-safe; my
  pinning of process.options.numberOfStreams = 8 (paired to user-requested
  numberOfThreads=8) caused the crash. numberOfThreads=8 KEPT (user policy);
  streams left AT DEFAULT (single). Local 1-event validation: PREMIX-1EVT-RC=0.
- Resubmitted as v7 (same knobs otherwise, T3_US_MIT, group/zmass LFN).

## v1.1 tag: issue #37 review round (2026-10-23)
- pmlugato's setup review (issue WMass/WMassNanoProduction#37) found:
  (1) labels at the v1.0 tag were still v14_genfilter; outLFNDirBase template
  hardcoded "_pilot", making the issue-header LFN unreachable. FIXED:
  VERSION=v1p0_pilot_20261023, CAMPAIGN=v1p0_pilot, template is now
  MuKPiGun_UL16_Premix_{CAMPAIGN}. No output-content change.
  (2) Binary provenance follows the submission area under scriptExe; Pietro's
  and emanca's areas diverge (51 vs 11 libs). RESOLVED the stricter way: each
  owner submits from their own FRESH area built at the round tag (build_area.sh,
  cmsrel + GunAlcaReco/GenTrackMatch only, scram b, edmPluginHelp gate).
  ALCArequest area is explicitly FORBIDDEN for submission (mutable legacy state).
  (3) minors accepted: cmsenv-before-CRAB-env on el9 (past/future import chain),
  campaign/history/ created by the assembler, REFERENCE_SHA256SUMS regen labelled
  honestly as payload self-consistency (true pin = exact-tag + clean worktree).
- Versioning: AlcaRecoGun_v1.1 on both forks. v1.1 == v1.0 in output content by
  construction (only submission tooling/labels/docs changed; cfgs, plugin, GT,
  filters untouched) so v13/v14 pilot outputs stay valid.

## v1.2 tag: gate release area (2026-10-23)
- pmlugato's v1.1 setup review found the last ALCArequest dependency: the
  assembler's exit gate (tests/test_workflow.sh) still cd'd into
  /work/submit/emanca/zmass/ALCArequest/CMSSW_10_6_17_patch1/src for the scram
  runtime driving the seed-difference proof. Not a rule-0 violation (2a does not
  submit), but it put the gate on the one path we had just declared world-mutable
  and made 2a unrunnable for anyone without read access to that /work tree.
- FIXED: tests/test_workflow.sh takes the release area as an optional argument and
  otherwise resolves it as step-2b build_area beside the campaign dir -> ephemeral
  `scram project` in its own temp dir. Precedence is argument > build_area >
  ephemeral; the activated CMSSW_VERSION is asserted against the expected release.
  On a first setup 2a precedes 2b so the ephemeral path is the normal one, and the
  gate can be re-run on tag-matched binaries with
  `campaign/tests/test_workflow.sh build_area/CMSSW_10_6_17_patch1`.
- Versioning: AlcaRecoGun_v1.2 on both forks (cmssw side re-tagged at the same
  commit as v1.0/v1.1, no cmssw content change). Tooling-only => Y bump; v1.0-v1.2
  are identical in output content, so v13/v14 pilot outputs stay valid.
- run_chain.sh local mode: ALCArequest default for LOCAL_RELEASE_DIR dropped;
  local=1 now requires CHAIN_CMSSW_DIR explicitly (decision from #37 review round).

## v1.3 tag: round-root ownership fix + v1p1_pilot (2026-10-24)
- v1p0_pilot round-0 blocker: pmlugato's MuGun submission came back
  SUBMITREFUSED (MAKE_PARENT 403). Root cause: CRAB/WebDAV creates LFN dirs as
  the submitter's LOCAL account (pool cmsuser for emanca, personal pmlugato for
  pmlugato) at 0755; the first-submitter CRAB-created campaign root
  MuKPiGun_UL16_Premix_v1p0_pilot (cmsuser-owned) therefore locked out the
  second submitter. gfal-chmod over davs: protocol not supported. Admin chmod
  (zmass maintainer) was available but rejected: policy is no third-party
  mediation and root ownership would recur every round.
- Durable fix (pmlugato's step-2d proposal, adopted): pre-create the round root
  on ceph by hand (2775) before the first CRAB submission; checkwrite retargeted
  at the CAMPAIGN root. Coordination rule #5; README step 2d. Cost rule versioned
  in: a locked root => new version round, never admin chmod, never LFN hacks.
- Round labels bumped for the fresh root: CAMPAIGN=v1p1_pilot,
  VERSION=v1p1_pilot_20261024. Round-0 (v1p0_pilot PiGun+KGun in flight) runs to
  completion untouched as alpha material.
- AlcaRecoGun_v1.3 on both forks (cmssw side unchanged since v1.0). v1.1-v1.3
  all content-identical in output terms; v13/v14 practicality unaffected.

## v2.0 tag: hit-rich ALCARECO content (X bump, 2026-10-26)
- pmlugato's witness readback of v1p1_pilot (issue #37, 2026-10-26) found that
  track.extra() dangled on all v1p1 files: the keep list carried matched-track
  clones only, and the clones' TrackExtra refs pointed at products never kept.
  Root = porting miss, not selector absence: the upstream ALCARECO selector
  (AlignmentTrackSelectorModule / ObjectSelectorStream) ALWAYS emits the
  five-product clone family (tracks, TrackExtras, TrackingRecHitsOwned,
  Si{Pixel,Strip}Clusters with recursively relinked refs) - we just kept the
  clones' silhouettes. This violated the explicit D*-parity ask.
- FIX (the stock ALCARECO way): per-species keeps "keep *_genMatchedTracks_*_*"
  + "keep *_ALCARECO<S>_*_*" (S = Muon/Pion/Kaon). Interim designs that were
  tried and rejected: pass-through TrackSelector stage (emits track-only in
  this release; EDFilter/EDProducer mismatch), literal class-name keeps for
  TrackingRecHitsOwned (keep matching uses actual branch names, not friendly
  names - resolved by the wildcard line).
- Validated locally on a 10-event no-PU GENSIM->DIGI->RECO->ALCA chain:
  Muon.root carries the full 5-product family under the ALCARECOMuon label.
- v2.0 = first content-changing bump (X). v1.0-v1.3 stays the infra-pilot
  lineage; its physics completeness caveat is now closed. 150M sizing numbers
  get re-quoted from the v2.0 pilot (hit-rich content adds per-event overhead
  which the v1.0-v1.3 file sizes did not include).

## Corrections to older note lines (from pmlugato's v1p1 readback, 2026-10-26)
- Line 41 ("emits dRMatch/dPtRelMatch/genMatched ValueMaps"): STALE wording kept
  for history. The 2026-10-21 EDFilter decision removed all ValueMap products;
  files since v14 confirm none are produced. The note above predates it.
- Line 64 ("streams left AT DEFAULT (single)"): TRUE ONLY FOR THE LOCAL LEG
  CONFIGS. On the grid the jobs inherit options from the chain env:
  numberOfThreads=8 with numberOfStreams left at CMSSW default (streams ==
  threads), which is why v1p1 files show ~8 streams worth of out-of-order
  event ids (381-433 inversions). Not a premix-mixing bug: mixing is confined
  to the DIGIPremix leg, and event ids are not an ordering constraint of our
  analysis. No action; wording updated here so nobody chases a phantom.

## v2.4 tag: locale-pinned payload manifest (2026-10-27)
- v2_pilot round: emanca logged REF hash bf625f35efed7017, pmlugato bbbad36bb7ffa566, from two
  assemblies of the SAME tag (nanoproduction c297750 / cmssw cbb1af7b2e3) whose 13 payload members
  were byte-identical to the tag blobs on both sides. Cause: `prepare_payload.sh` sorted the
  manifest with a bare `sort`, and collation is locale-dependent. Under C it is byte order, so
  'P' (0x50) < '_' (0x5F) puts DIGIPremix_cfg.py first; under en_US.UTF-8 punctuation is ignored
  at the first level, so DIGI_noPU_cfg.py comes first. The two owners run in different locales.
  Reproduced exactly: the same 13 files hashed through `LC_ALL=C sort` give bf625f35efed7017 and
  through `LC_ALL=en_US.UTF-8 sort` give bbbad36bb7ffa566.
- No functional impact: `sha256sum -c` does not care about line order, so every v1.x/v2.x job
  verified its payload correctly and the v2_pilot round is one payload in content. What broke is
  the cross-owner REF-hash comparison, i.e. the check we rely on to SEE that it is one payload.
- FIXED: `LC_ALL=C sort` in prepare_payload.sh. The manifest is now a function of the tag alone,
  so the existing one-line REF-hash comparison keeps working and no extra bookkeeping ritual
  (wc -l, second digest) is needed.
- Also in this tag: README §1 states the credential check is `voms-proxy-info -actimeleft`, not
  `-timeleft` — an expired VOMS AC under a still-valid proxy makes CRAB stall on the grid
  passphrase and `crab checkwrite` then prints no verdict line at all (measured 2026-10-27).
- Versioning: AlcaRecoGun_v2.4, tooling/docs only => Y bump. Payload MEMBERS are unchanged from
  v2.0-v2.3; only the manifest's line order changes, so v2_pilot outputs stay valid and the
  round in flight is unaffected.
## v3.0 tag: gen-match via ObjectSelectorStream (X bump, 2026-10-27)
- Final architecture for the matched-track persistence (settled after the
  v1.1 dangling-extra report and the v2.0 PU-inclusive fallout measured by
  pmlugato at ~38 TB/150M): the gen-match logic is a UtilAlgos selector
  functor (GenMatchedTrackSelector) behind ObjectSelectorStream, so the
  persistence is the stock TkAl clone family (tracks + TrackExtras + owned
  TrackingRecHits + SiPixel/SiStripClusters, refs recursively re-pointed)
  under the genMatchedTracks label, on matched tracks only. Filter=True
  keeps the pure-PU veto semantics of the 2026-10-21 filter decision.
- Load-bearing quirk: ObjectSelectorStream emits track-only clones unless
  CommonTools/RecoAlgos/interface/TrackSelector.h is included in the module
  (the specialization hook lives in that header; the TkAl module documents
  the same trap). 
- Validated: local 10-event no-PU chain, products dump complete; FWLite
  witness on 200 matched tracks gives 200/200 resolvable extra() with >0
  hits (~18 hits/track) => downstream Kalman refit of matched tracks works,
  i.e. the D* ALCARECO parity now holds at ~2.0-2.3 TB/150M projected
  (floor 1.6-1.75 TB + matched-only hit content).
- Replaces GenMatchedTrackFilter (v1.x-era EDFilter, removed with this
  commit) and supersedes the v2.0 keep-list workaround.

## v3.1 tag: the plugin gate was certifying nothing (2026-10-27)
- Reviewing v3.0 on a real build area showed step 2b passing with
  `plugin gate OK: pluginGenMatchedTrackFilter.so found` — for a plugin deleted in that
  same tag. The built library is pluginGenMatchedTrackSelector.so and the registered
  module is GenMatchedTrackSelectorModule; nothing named GenMatchedTrackFilter exists.
- Cause: the gate tested `edmPluginHelp`'s exit code, which is 0 whether or not the
  plugin is there. Measured in CMSSW_10_6_17_patch1:
    edmPluginHelp -p DefinitelyNotAPluginXYZ    -> exit 0, 0 bytes of output
    edmPluginHelp -p GenMatchedTrackFilter      -> exit 0, 0 bytes of output
    edmPluginHelp -p GenMatchedTrackSelectorModule -> exit 0, 292 bytes
  So the gate has never discriminated; at v1.x-v2.x it passed for a plugin that happened
  to exist, at v3.0 it passed for one that does not. A build that produced no plugin at
  all would also have passed.
- FIXED: the gate captures the output and requires it to be non-empty, and names
  GenMatchedTrackSelectorModule — the module the cfgs instantiate.
- Related, on the cmssw side (separate PR): the v3.0 cfgs lost the event veto. The old
  EDFilter returned eventMatched; ObjectSelector takes it from a bool parameter named
  `filter` which the genMatchedTracks PSet does not have, and ObjectSelector.h defaults
  filter_ to false (lines 46, 50-53, 69). Pure-pileup events would have been written
  instead of dropped, visible at readback only as 1000/1000 instead of 999/1000 events.
- Versioning: AlcaRecoGun_v3.1, tooling only on this side => Y bump; the cmssw cfg fix
  that rides with it restores v3.0's intended content rather than changing it.

## v4.0 tag: analyzer-complete MC truth (Josh Bendavid's review, X bump, 2026-10-29)
- Review of WMass/WMassNanoProduction#36 + WMass/cmssw#53 (his branches
  bendavid/cmssw:alcareco-gun-review merged on top of b0d2c7d6521):
  (1) ResidualGlobalCorrectionMaker doGen/doSim paths FAIL with ProductNotFound
  on v3 pilot files -> generator/GenRunInfoProduct/LumiInfo products +
  slimmedAddPileupInfo (produced in-path) + int_*_bunchSpacing +
  PSimHits_g4SimHits_TrackerHits* kept. Rationale now explicit: only PSimHits
  separate the gun track's hits from the pileup companions' at the hit level
  that ΔR matching cannot reach.
  (2) full `muons` collection had all track refs dangling; replaced by
  genMatchedMuons via Alignment/AlCaRecoMuons AlCaRecoMuonRelinker, re-pointed
  innerTrack to genMatchedTracks (plus the track->muon association product).
  (3) No HLT leg => doTrigger=False is the downstream contract.
  (4) Measured cost: 19.3 -> 21.8 kB/ev on a 300-event MuGun production test
  (i.e. ~2.5 kB/ev, ≈ +0.4 TB at 150M; total target becomes ~2.6-2.9 TB).
- build_area.sh builds Alignment/AlCaRecoMuons as the second package and the
  hardened plugin gate now probes BOTH GenMatchedTrackSelectorModule and
  AlCaRecoMuonRelinker. REFERENCE_SHA256SUMS retired (it was a stale tracked
  manifest from before cfg moved to cmssw - per-assembly regen stands).
- README 2b and §6.3 wording aligned (plugin name + genMatchedTracks label for
  the hit family; labels bumped for the v4_pilot round).

## production tag: AlcaRecoGun_production_v1 for the 150M round (2026-10-30)
- PR #36 (nanoproduction) and WMass/cmssw#53 (gun/D* cfgs) merged on 2026-10-30;
  both forks fast-forwarded so their branches pinpoint the org branch tips
  (666bd8559 / 8d6f1a2aa). Tag AlcaRecoGun_production_v1 sits at those synced
  states on both forks. This is the first tag whose meaning is provenance-to-
  org rather than provenance-to-fork.
- Production round structure: 15 block-tasks (3 species x 5 blocks),
  10M events per task = 4,000 jobs x 2,500 events/job (~1.5-3.5 h/job),
  8 cores/16 GB, T3_US_MIT, DAS publication phys03 ON (user decision
  2026-10-30). crab_production_guns.py is the factory; block uniqueness of
  seeds flows from scriptArg jobOffset = block x EVENTS_PER_TASK (the
  deterministic seeding keys on CHAIN_JOB_ID). TOTAL ~3.05 TB ALCARECO at
  20.7 kB/ev measured at v4_pilot; premix xrootd transit 45-90 TB - the
  largest quantifier of the campaign listed in writing here.
- Publication smoke plan: first a publication-verify block per species
  (weekend-scale floor), the rest of the fleet in the same label cadence.
- Block granularity retuned after opening discussion (2026-10-30): 10 blocks
  per species of 5M events each (2,000 jobs x 2,500 ev/job) = 30 tasks total,
  instead of 5 blocks x 10M. Same totals, same seed-offset discipline
  (jobOffset = block x EVENTS_PER_TASK), better failure-cell containment and
  ASO transfer smoothing. CRAB 10k-job cap stays far off either way.

## pre-salvo fixes riding PR #39 (pmlugato review 2026-10-30, accepted)
- jobOffset units bug (mine): block x EVENTS_PER_TASK would exceed the seed
  cap (>~900k) -> 27/30 tasks dead at GENSIM. Fixed: block x JOBS_PER_TASK
  (jobs, not events). Seed test proofs now also include the species-difference
  assertions, not only job-index differences.
- firstLuminosityBlock = job_id at GENSIM (stage_runner): jobs previously
  shared run1/lumi1, which meant downstream PoolSource checkAllFilesOpened
  silently skipped files beyond one per (run,lumi) group. Closed on the
  runner side since the cfgs declare an unconfigured EmptySource.
- Species seeds now independent: SPECIES_STRIDE=250000 job slots per species
  in deterministic_seeds._seed_values (species_index from CHAIN_SPECIES,
  exported by run_chain). Rationale from v4_pilot measurement: 981/998
  identical gun pT between PiGun and KGun at equal job ids - perfectly
  correlated ensembles are fine for clean A/B but poison for training sets.
- Resources rebalanced for the 30-task round: numCores 8->4, maxMemoryMB
  16000->8000 (pilots peaked 3.6 GB processed, 38% CPU), core-hour estimate
  of the 150M round halves.
- README clones point at WMass/* now; next central tag = production_v2 on the
  post-merge tips of both org repos (never move production_v1).
- Items 1-4 from pmlugato's smoke-readiness hold (2026-10-31): v2 labels end to end
  in the factories (v2_150M / prod_v2_150M) because labels-as-LFN-mismatch would
  re-create the v1.0 campaign-lockout class; dedicated crab_smoke_guns.py
  (2 jobs/species at block 1, publication phys03 ON) committed; CHAIN_SPECIES
  now raises instead of taking the MuGun lane on typos; high-ID seed proofs
  at job 2001 and job 20000/KGun added to the gate. Ephemeral-tag-chunched
  validation kept to throwaway clones; org-tag clones stay for production.
- Publication contingency: if phys03 listing stays empty after the smoke phase,
  the fix pre-diagnosed by pmlugato rides the next PR (crab_pset.py declares a
  formal PoolOutputModule); decided 2026-10-31 to try the ASO path unchanged first
  and only touch the PSet afterward (user call).
