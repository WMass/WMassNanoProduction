# NanoV15_v1.0 production: 2016 postVFP data and MC (runbook)

Tracking: [#26](https://github.com/WMass/WMassNanoProduction/issues/26) (overall),
[#27](https://github.com/WMass/WMassNanoProduction/issues/27) (data, Pietro),
[#28](https://github.com/WMass/WMassNanoProduction/issues/28) (MC, Luca). Coordination: @davidwalter2.
Handoffs: [`handoff_pietro_data.md`](handoff_pietro_data.md), [`handoff_luca_mc.md`](handoff_luca_mc.md).

## 0. What is produced

- **Code:** tag `NanoV15_v1.0` in both repositories:
  - WMass/cmssw `WmassNanoProd_15_0_19_patch2` at 659d3bd;
  - WMass/WMassNanoProduction `main` at 8b232c2.
- **Inputs:** 2016 postVFP SingleMuon (`inputs/data_postVFP.txt`) and MiniAOD MC (`inputs/dyMC_v15.txt`,
  `inputs/bkgMC.txt`, `inputs/wMC_v15.txt`). Every input dataset is VALID and fully on disk at one site or more.
  There is no lumi mask, as in the previous productions; the analysis applies the golden JSON.
- **Output:** site `T3_US_MIT`, LFN `/store/group/zmass/NanoAOD`, that is
  `/ceph/submit/data/group/cms/store/group/zmass/NanoAOD/<primary dataset>/<output tag>/<YYMMDD_HHMMSS>/<NNNN>/*.root`.
  - Output tags: `NanoV15Run2016<era>DataPostVFP_v1p0` and `NanoV15MCPostVFP_v1p0`.
  - The outputs are published in DBS `phys03` under the submitter's name.
- **Versioning:** `NanoV15_vX.Y`.
  - X changes when the output changes (a bug fix or a track-fit improvement).
  - Y changes when existing outputs stay valid (e.g. new datasets).
  - Both repositories are tagged together, and the CRAB label is `vXpY`.
- **Jobs:** `EventAwareLumiBased`, 144k events per job for data and 125k for MC. That is 8 CPU hours, about 2.2 h
  with 4 cores (less for MC samples with fewer muons), with 8000 MB of memory.

The setup below was checked in a fresh area at the tagged commits:
- the clone, the build and `prepareSandbox` (76 MB);
- configs and dry runs of all four lists;
- 100-event runs of the data and MC configs;
- `crab checkwrite` on the output directory.

## 1. Prerequisites (once)

- A submit account in the `submit-cms` group (`id` lists it).
- A grid certificate in `~/.globus` with CMS VO membership. Make a proxy with
  `voms-proxy-init -voms cms -rfc -valid 192:00` and renew it before it expires; CRAB needs it for every command.
- `git config --global user.github <your GitHub login>`; `git cms-init` uses it.
- An el9 submit node and a directory with about 2 GB free, e.g. `/work/submit/$USER/NanoV15_v1.0`.

## 2. Setup at the tag

```sh
mkdir -p /work/submit/$USER/NanoV15_v1.0 && cd /work/submit/$USER/NanoV15_v1.0
CMSSW_TOPIC=WMass:NanoV15_v1.0 PROD_BRANCH=NanoV15_v1.0 PROD_REPO=https://github.com/WMass/WMassNanoProduction.git \
  bash <(curl -s https://raw.githubusercontent.com/WMass/WMassNanoProduction/NanoV15_v1.0/setup/clone_15_0.sh)
cd CMSSW_15_0_19_patch2/src && cmsenv && cd Configuration/WMassNanoProduction
git describe --tags        # NanoV15_v1.0
./scripts/prepareSandbox.sh
source /cvmfs/cms.cern.ch/common/crab-setup.sh
crab checkwrite --site=T3_US_MIT --lfn=/store/group/zmass/NanoAOD/
```

- The build takes about 10 minutes.
- `prepareSandbox.sh` must report the OPERA tables with `sha1 ok` and an estimated sandbox below 120 MB.
- `crab checkwrite` must end with `Success: Able to write in /store/group/zmass/NanoAOD/ on site T3_US_MIT`. If it
  fails, post its output in your issue: your certificate is probably not mapped to your submit account.

In a new shell: `cd .../CMSSW_15_0_19_patch2/src && cmsenv && source /cvmfs/cms.cern.ch/common/crab-setup.sh && cd Configuration/WMassNanoProduction`.

## 3. Submit

```sh
OPTS="-v v1p0 --site T3_US_MIT --storage /store/group/zmass/NanoAOD"
./scripts/prepareCrab.py --makeConfig -i inputs/<list>.txt $OPTS [-m '<regex>']
grep -h "inputDataset\|splitting\|unitsPerJob\|outLFNDirBase\|outputDatasetTag\|storageSite" crab_submit/submit*.py
./scripts/prepareCrab.py -i inputs/<list>.txt $OPTS [-m '<regex>'] --submit 1 1
```

- Your handoff gives the lists and filters (`-m`) of your part.
- The first command writes the configs and the submit files and prints, per dataset, the events per job, the
  expected CPU and wall time and the number of jobs. Check the submit files before submitting.
- Keep the job size, cores and memory as they are; ask in the issue before changing them.
- The CRAB project directories are `crab_submit/crab_projects/crab_<task>`. Each submission is appended to
  `history/<list>_<date>_submit11_<user>.txt`.

## 4. Monitor

```sh
cd crab_submit
for d in crab_projects/crab_*; do crab status -d $d | grep -E "^Task name|Status on the scheduler|^Jobs status|finished|failed|Publication status"; done
```

Check once or twice a day. CRAB retries failed jobs automatically. For jobs in `failed`:

| exit code | meaning | action |
|---|---|---|
| 50660 | memory limit | `crab resubmit -d <dir> --maxmemory 10000` |
| 50664 | wall-clock limit (20.8 h) | resubmit once; if it happens again, recover (step 5) |
| 60307, 60326 | stage-out to T3_US_MIT | `crab resubmit -d <dir>`; if it repeats at one site, add `--siteblacklist=<site>` (in 2017G: T2_US_Vanderbilt) |
| 8001, 8028 | reading an input file | `crab resubmit -d <dir>`; if it repeats, report the file in your issue |
| other | | `crab resubmit -d <dir>`; if it repeats, report it in your issue with the `crab status --long` lines |

Several datasets are on disk at one site only, so their jobs may wait there. Do not use `--ignoreLocality` without
asking in the issue: in the 2017G production, reading remotely brought the CPU efficiency down to 0.4.

## 5. Recover jobs that keep failing

`crab recover` does not support `EventAwareLumiBased` tasks, so recover by hand. Do this only once the remaining jobs
have failed their retries:

```sh
crab kill -d crab_projects/crab_<task>
crab report -d crab_projects/crab_<task>      # writes crab_projects/crab_<task>/results/notFinishedLumis.json
cp submit<name>.py submit<name>_rec1.py
```

In `submit<name>_rec1.py`, change:

```python
config.General.requestName = '<original requestName>_rec1'
config.Data.splitting = 'LumiBased'
config.Data.unitsPerJob = 10        # data; 30 for MC
config.Data.lumiMask = 'crab_projects/crab_<task>/results/notFinishedLumis.json'
```

Then run `crab submit -c submit<name>_rec1.py`. The recovery task writes to the same output tag, so it is the same
dataset in DBS with a new timestamp directory. Note the recovery in your issue.

## 6. Completion checks (per task)

When all jobs are finished and publication is done:

1. `crab report -d <dir>`: the number of events read must equal the dataset's events in DAS, which are listed in your
   issue. For a recovered task, add up the task and its `_rec` tasks.
2. Check that the output is readable: `ls -ld /ceph/submit/data/group/cms/store/group/zmass/NanoAOD/<PD>/<output tag>`
   must show `drwxr-sr-x`. Since 2026-10-16 the XRootD WebDAV door on submit55 creates directories readable by
   everyone, so nothing needs to be done. If a directory is still owner-only (`drwx--S---`), open it:
   ```sh
   find /ceph/submit/data/group/cms/store/group/zmass/NanoAOD/<PD>/<output tag> -user $USER -type d -exec chmod 2755 {} +
   ```
3. Commit your history files on a branch (`history-NanoV15_v1.0-$USER`), push it to your fork and open a PR to
   `WMass/WMassNanoProduction` `main`.
4. Post the completion report in your issue.

## 7. Report

Post in your issue (#27 data, #28 MC) when you submit, about once a day while tasks run, and at completion:

```
**<phase or list>**, <date>
| dataset | CRAB task | jobs finished/total | failed | publication | events read / DAS | notes |
|---|---|---|---|---|---|---|
```

If something blocks you, describe it in your issue and mention @davidwalter2.

## 8. Working with Claude Code

If you use Claude Code, start it in `.../CMSSW_15_0_19_patch2/src/Configuration/WMassNanoProduction` and point it to
your handoff, for example:

> Read https://github.com/WMass/WMassNanoProduction/blob/main/production/NanoV15_v1.0/handoff_luca_mc.md and the
> runbook next to it, then do the next open step. Post the report in WMass/WMassNanoProduction#28 with `gh issue comment`.

It needs your grid proxy for the CRAB commands and `gh auth login` to post in the issue. Let it ask you before
`crab kill`, `--ignoreLocality` or any change of the job settings.
