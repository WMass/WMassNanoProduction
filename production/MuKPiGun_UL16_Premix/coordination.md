# Coordination: emanca + pmlugato, MuKPiGun UL16 Premix ALCARECO

Two owners: **@emanca** and **@pmlugato**, equal control and responsibility on
everything - cmsw content, configs, payloads, grid submissions, monitoring,
recoveries, validation, and decisions. There are no fixed roles; the reason we
share submissions is to share computing resources, nothing else. David is not in
the loop on this campaign.

## Source of truth

Until PR #36 (WMassNanoProduction) and the cmssw-side PR merge into `WMass/*`,
the truth lives on the two forks, both tagged `AlcaRecoGun_v1.0`:

- `emanca/cmssw : from-CMSSW_10_6_17_patch1` - plugins, fragments, campaign cfgs
  (`Generation/GunAlcaReco/Production/MuKPiGun_UL16_Premix/`).
- `emanca/WMassNanoProduction : NanoV9_CMSSW_10_6` - pipeline machinery
  (this `production/MuKPiGun_UL16_Premix/` + `production/common/`).

After merge, the same tag is cut centrally on both `WMass/*` repos. Both of us
keep both forks remotes handy and both must be able to:

- build the campaign area (`assemble_campaign.sh`),
- submit / status / resubmit / recover the CRAB tasks,
- read the outputs on `T3_US_MIT` (`crab checkwrite` + ceph readback).

## Rules

1. **Report first, act second.** Anything grid-facing is posted in the issue
   before it is done: kills, resubmits with changed options, new sandboxes,
   site blacklists/whitelists, parameter or cfg changes, recoveries.
   Routine no-op actions (a plain `crab resubmit` of a known transient class,
   status checks) are reported the same day in the daily comment.
2. **One bump per round.** `VERSION`/`CAMPAIGN` in the crab configs change before
   every submission round; rounds and their labels are logged in the issue and
   in `CAMPAIGN_NOTES.md`.
3. **No unilateral output changes.** X version bumps (anything that changes file
   content: cfgs, plugin, GT, keep/drop decisions) need a green pilot readback
   and both owners' sign-off in the issue.
4. **Either of us may submit any species.** Tasks carry the submitter's CRAB
   prefix; whoever submits posts the task names at submission time and owns the
   daily monitoring comment for as long as they have capacity - not as a fixed
   roster, whoever posted last keeps the watch until they hand it off in writing.
5. **Witness readback after pilots.** At least one ALCARECO file per species is
   read back (branch list + event count) before any scale-up is discussed.
   Pilot scale for infrastructure tests: 1000 ev/job, 2 jobs/species (~40 min).
6. **Outputs are shared infrastructure.** LFN family
   `/store/group/zmass/MuKPiGun_UL16_Premix_*`; both owners must be able to read
   (ceph `drwxr-sr-x` chain), both submit under their own account name, and DAS
   publication is decided on the issue before it is touched.

## Issue protocol

- One issue per campaign round on `WMass/WMassNanoProduction`, template as in the
  runbook (task table + checklist like the NanoV15 issues). Before PR #36 merges,
  the same format is kept as comments on PR #36.
- Comment at submission, ~daily while running, at completion; the completion
  comment carries `crab report` numbers, output dir listing, and the readback note.
- Anything uncertain goes in the issue, including "I broke X, here is what
  happened" - the D* e2e and this campaign's failure lineage lives in
  `CAMPAIGN_NOTES.md`, every new class gets appended.

## Scope

Guns only. D* is out for now; its resubmission is not part of this coordination.
