# NanoV15_v1.3: AlCaReco nano of the WMass ALCARECO (#54 pilots) and of the gun ALCARECO

Code: WMass/cmssw `NanoV15_v1.3` (#55 on top of #51) and this repository at `NanoV15_v1.3`. The outputs of
v1.2 and of the MiniAOD nano stay valid: the central-AlCaReco and MiniAOD nano outputs are bit-identical to
v1.2 (WMass/cmssw#55).

## Samples
- `inputs/alcareco_wmass_postVFP.txt`: the 100k-event review pilots of issue #41, TkAlJpsiMuMu: Charmonium
  2016H (default and calibration version) and the J/psi MC rounds r1c (full genParticles,
  `nanoAOD_alcarecoFullGen`), r2 and r3. Small: 70 + 3 x 100 files, about 67k data and 43k MC events.
- `inputs/alcareco_gun_postVFP_test.txt`: 10 files per gun species, a test of the chain. The full gun
  production (`inputs/alcareco_gun_postVFP.txt`, 30 block lines, 59,749 files) is the lane of @pmlugato in
  issue #42.

## Steps
1. Area at the tag, on el9 (submit82):
   `CMSSW_TOPIC=WMass:NanoV15_v1.3 PROD_BRANCH=NanoV15_v1.3 bash setup/clone_15_0.sh`, then `cmsenv` and
   `scripts/prepareSandbox.sh` in `Configuration/WMassNanoProduction`.
2. Configs and submit files:
   `./scripts/prepareCrab.py --makeConfig -v v1p3 --storage /store/group/zmass/NanoAOD --site T3_US_MIT --filesPerJob 10 -i inputs/alcareco_wmass_postVFP.txt`
   and `./scripts/prepareCrab.py --makeConfig -v v1p3 --cpuHoursPerJob 2 --storage /store/group/zmass/NanoAOD --site T3_US_MIT -i inputs/alcareco_gun_postVFP_test.txt`
   (7-10 jobs per pilot task, one gun file per job).
3. Submit in the CRAB environment with a valid proxy: the same commands with `--submit 1 1`; the history file
   `history/<list>_<date>_submit11_<user>.txt` is committed afterwards. A `crab submit --dryrun` leaves
   `crab_projects/<task>/local/` with a copy of the field tables, which the sandbox of every later submission
   packs (over CRAB's 120 MB): move it out of the area before submitting anything else.
4. Checks when the tasks are done: every input event in the output (Events entries = the ALCARECO events),
   the files readable, the content of WMass/cmssw#55 (TrigObj with the quarkonium bits, PAT muon columns,
   `CvhParm` in the Runs tree of the calibration version, GenPart and Pileup in MC, the `Track` table of the
   guns).

Outputs: `/store/group/zmass/NanoAOD/<primary>/<NanoV15<tag><Data|MC><label>_v1p3>/` at T3_US_MIT, not published.
