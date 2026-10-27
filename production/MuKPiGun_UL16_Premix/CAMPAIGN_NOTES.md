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
