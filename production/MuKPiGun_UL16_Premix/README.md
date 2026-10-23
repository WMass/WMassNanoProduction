# MuKPiGun UL16 Premix ALCARECO production (runbook)

Shared production of muon/pion/kaon gun MC at ALCARECO level for the Z-mass
calibration soaks. Owners (equal responsibility, no fixed roles): **@emanca** and
**@pmlugato**. Tracking: one issue per campaign round on
[WMass/WMassNanoProduction](https://github.com/WMass/WMassNanoProduction/issues) —
the issue is the coordination venue from day one (= today), independent of PR #36,
which is code-review only.
Coordination rules: [`coordination.md`](coordination.md). Decisions log:
[`CAMPAIGN_NOTES.md`](CAMPAIGN_NOTES.md).

## 0. What is produced

- **Code:** tag `AlcaRecoGun_v1.1` on **both forks** (until PR #36 and the cmssw-side
  PR are merged into WMass/*; then the same tag is made centrally). v1.1 is identical
  to v1.0 in output content — only submission tooling (labels, area protocol, runbook)
  changed.
  - `emanca/WMassNanoProduction`, branch `NanoV9_CMSSW_10_6` (this repo),
  - `emanca/cmssw`, branch `from-CMSSW_10_6_17_patch1`
    (plugins `GunAlcaReco/GenTrackMatch` + fragments `Configuration/GenProduction/python/`
    + campaign cfgs `Generation/GunAlcaReco/Production/MuKPiGun_UL16_Premix/`).
- **Versioning:** `AlcaRecoGun_vX.Y`.
  - X changes when the output changes (cfg, plugin, GT change). Y changes when existing
    outputs stay valid (new dataset size only).
  - Both forks are tagged together; the CRAB label is `vXpY` in the task campaign string.
- **Scope now:** guns only (MuGun/PiGun/KGun, flat pT 0.01-150 GeV, |eta| <= 2.4,
  anti-particles on). D* is explicitly out of this campaign.
- **Chain:** GENSIM -> premix DIGI (official UL16 premix lib, read via xrootd) -> RECO ->
  gen-match-filtered ALCARECO, one release (CMSSW_10_6_17_patch1, slc7,
  `106X_mcRun2_asymptotic_v13`, era `Run2_2016`), no HLT leg. Only the ALCARECO level is
  staged out; + monitoring.json per job.
- **Output:** site `T3_US_MIT`, LFN
  `/store/group/zmass/MuKPiGun_UL16_Premix_<campaign>/<Species>_<version>/<YYMMDD_HHMMSS>/0000/`.
  No DAS publication in the pilot phase (`Data.publication = False`).
- **Jobs:** `EventBased`, 1000 events/job for the pilot, 8 cores / 16 GB /
  10 h wall-clock. Measured on the pilot round: 32-42 min wall per job.
- **Sizes (measured, v14 genfilter pilot):** 10.1-11.6 MB ALCARECO per 1000-event file
  (matched-event retention 99.8-100%). At 150M events this projects to ~1.6-1.75 TB.

## 1. Prerequisites (once)

- Submit account in `submit-cms`; grid certificate with CMS VO; proxy
  `voms-proxy-init -voms cms -rfc -valid 168:00` at `/tmp/x509up_u$UID` before every CRAB day.
- `git config --global user.github <login>`.
- El9 submit node access; campaign area with ~8 GB free
  (e.g. `/work/submit/$USER/AlcaRecoGun`).

## 2. Setup at the tag

Everything happens in one fresh workspace per owner, rebuilt from the tags.
Two checkouts plus one fresh CMSSW area — no pre-existing CMSSW areas are
ever used for submission (see `coordination.md`).

```sh
mkdir -p /work/submit/$USER/AlcaRecoGun && cd /work/submit/$USER/AlcaRecoGun
TAG=AlcaRecoGun_v1.1
git clone --branch $TAG https://github.com/emanca/cmssw.git cmssw-src
git clone --branch $TAG https://github.com/emanca/WMassNanoProduction.git nanoproduction
```

**2a. Campaign area from the tags (host-side tag gate):**

```sh
bash nanoproduction/production/MuKPiGun_UL16_Premix/assemble_campaign.sh \
    nanoproduction cmssw-src campaign
```

- `assemble_campaign.sh` requires **exactly** the expected tag and a **clean
  worktree** on both checkouts (that is what makes the hash content a real pin
  to the tag). It composes `campaign/` from the two tags: cfgs from
  `cmssw-src/Generation/GunAlcaReco/Production/MuKPiGun_UL16_Premix/cfgs/`, runtime
  and chain scripts from this repo, the shared `production/common/`,
  then `prepare_payload.sh`. Note what the payload step proves:
  REFERENCE_SHA256SUMS regeneration + check is payload self-consistency; the true
  content pin is the clean-tree tag check above.
- It ends with `tests/test_workflow.sh` — must print `ALL CHECKS OK` before anyone
  submits. `campaign/history/` is created for the submission logs (step 6).

**2b. Fresh build area at the tag** (slc7 work runs in the EL7 container; run 2a
first — 2a is the tag gate; the container git cannot even read the checkouts):

```sh
SINGULARITY_BIND=/work,/scratch,/tmp /cvmfs/cms.cern.ch/common/cmssw-el7 \
  --command-to-run bash nanoproduction/production/MuKPiGun_UL16_Premix/build_area.sh \
  $PWD/cmssw-src $PWD/build_area
```

`build_area.sh` does `cmsrel CMSSW_10_6_17_patch1` in `$PWD/build_area`, copies only
`GunAlcaReco/GenTrackMatch` from the tagged cmssw clone into the area `src`, runs
`scram b -j8`, and fails unless `edmPluginHelp -p GenMatchedTrackFilter` finds the
plugin (stream::EDFilter). From clean, this takes a few minutes.

**2c. CRAB environment** (el9: enter the build area and `cmsenv` FIRST — bare
`PYTHONPATH` alone gives `No module named 'past'`):

```sh
cd build_area/CMSSW_10_6_17_patch1/src && cmsenv && cd -
export PYTHONPATH=/cvmfs/cms.cern.ch/share/cms/crab-prod/v3.260630.00/lib:${PYTHONPATH}
unset RUCIO_HOME
alias crab='python3 /cvmfs/cms.cern.ch/share/cms/crab-prod/v3.260630.00/bin/crab.py'
crab checkwrite --site=T3_US_MIT --lfn=/store/group/zmass/   # must print Success
```

## 3. Submit (pilot first, always)

Submissions run **from your own fresh build area of step 2b** (2c env active).
The area is part of the provenance: identical tag -> identical binaries, and the
job's sandbox ships that area's products. Never submit from someone else's area,
from any legacy/shared area, and specifically never from the ALCArequest area —
it is world-mutable legacy state, not campaign provenance.

```sh
cd build_area/CMSSW_10_6_17_patch1/src
crab submit -c /work/submit/$USER/AlcaRecoGun/campaign/crab_MuGun.py   # species per the issue table
```

- Edit `VERSION` / `CAMPAIGN` in `crab_pilot_guns.py` **before every round**
  (one bump per round; current rounds and labels are logged in the issue and
  `CAMPAIGN_NOTES.md`). The three `crab_<Species>.py` wrappers are version-free;
  the bump lives in one place. Label for this round: `v1p0_pilot`.
- Submission sharing: either of us may submit any species; the point of sharing is
  computing resources, not ownership. Tasks carry the submitter's CRAB prefix
  (`emanca_crab_*` / `plugato_crab_*`); both names go in the issue table.
- Post task names in the issue at submission (`2610xx_xxxxx:<user>_crab_<task>`).

## 4. Monitor

```sh
for d in campaign/crab_projects/crab_*; do
  crab status -d $d | grep -E "^Task name|Status on the scheduler|^Jobs status|finished|failed"
done
```

About once a day. The tracker at `https://submit.mit.edu/~emanca/crab_tracker/` renders
the same state live. CRAB auto-retries; then:

| exit code / signal | meaning | action |
|---|---|---|
| 8020-8021, 8001 | transient input read | `crab resubmit -d <dir>` once; if it repeats, report the file(s) in the issue |
| 50660 | memory limit | post in issue before raising memory (16 GB is already the floor rule) |
| 50664 | wall-clock | resubmit once; if again, recover (step 5) |
| 50664 twin: jobs "finished <70% memory" warn | CRAB mislabels clean fast jobs | informational only, NOT a failure |
| 8001 `PluginLibraryLoadError ... poisoned` | site-conditioned broken SCRAM tree (seen T2_IT_Bari, T2_TR_METU) | **do not fix unilaterally**; report - fix is campaign-side, never per-job |
| 50115 / BadFWJRXML | wrapper report empty | structurally impossible with this `run_chain.sh` (fallback trap); if seen, it is a new bug - report, stop |
| other | | `crab resubmit -d <dir>`; if it repeats, report with `crab status --long` lines |

## 5. Recover

`EventBased` supports `crab recover`, use it once retries are exhausted:

```sh
crab kill -d campaign/crab_projects/crab_<task>
crab recover -d campaign/crab_projects/crab_<task>   # creates a new task
```

Note the recovery task name in the issue. If `crab recover` refuses, do the
kill + report + manual resubmission of the complement lisumi bookkeeping by hand and
post the recipe used. Never `--ignoreLocality` without asking first in the issue.

## 6. Completion checks (per task)

1. `crab report -d <dir>`: events read == `Data.totalUnits` (2000 for the pilot
   across the two jobs; add up `_rec` tasks).
2. Output readable by everyone:
   `ls -ld /ceph/submit/data/group/cms/store/group/zmass/MuKPiGun_UL16_Premix_*/*/<task>/*`
   must be `drwxr-sr-x`; open with the `find ... -exec chmod 2755 {} +` trick if needed.
3. Content readback of one file per species (branches: `recoTracks_genMatchedTracks`,
   `genParticles`, SimTracks/SimVertexs, PV/BS), and event count == 1000.
4. Record the round in `history/` (task names, payloads' REF hash, job table) and attach
   to the issue.
5. Post the completion report in the issue and take the pilot go/no-go decision there.

## 7. Report

Status in the issue at submission, about daily while running, and at completion:

```
**<round/campaign label>**, <date>
| dataset/PD | CRAB task | jobs finished/total | failed | ev read / total | notes |
|---|---|---|---|---|---|
```

Rules in [`coordination.md`](coordination.md): report first, then act together.
Nothing grid-facing (kill, resubmit-with-changes, new sandbox, site blacklists,
parameter changes) is done unilaterally.
