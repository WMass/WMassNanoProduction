# Handoff: 2016 postVFP SingleMuon data, NanoV15_v1.0 (Pietro)

Pietro, you produce the custom NanoAOD v15 (version `NanoV15_v1.0`) of the full 2016 postVFP SingleMuon data.
- Your issue: [#27](https://github.com/WMass/WMassNanoProduction/issues/27). The overall status is in
  [#26](https://github.com/WMass/WMassNanoProduction/issues/26).
- Follow the [runbook](README.md); this page lists only what is specific to your part.

## Your datasets (`inputs/data_postVFP.txt`)

| dataset | events (DAS) | jobs | on disk at |
|---|---|---|---|
| `/SingleMuon/Run2016F-21Feb2020_UL2016_WMass_MiniAODv2-v1/MINIAOD` | 8,024,195 | 56 | T1_US_FNAL_Disk, T2_CH_CERN |
| `/SingleMuon/Run2016G-21Feb2020_UL2016_WMass_MiniAODv2-v1/MINIAOD` | 152,881,545 | 1062 | T1_FR_CCIN2P3_Disk, T2_CH_CERN |
| `/SingleMuon/Run2016H-21Feb2020_UL2016_WMass_MiniAODv2-v4/MINIAOD` | 175,524,652 | 1219 | T2_CH_CERN, T2_BE_UCL |

This is 336M events in about 2.3k jobs of 144k events (about 2.2 h each on 4 cores), and about 1.0 TB. The output goes to
`/ceph/submit/data/group/cms/store/group/zmass/NanoAOD/SingleMuon/NanoV15Run2016{F,G,H}DataPostVFP_v1p0/`.

## Steps

1. **Setup:** runbook steps 1–2. Post "setup OK" with the `crab checkwrite` result in #27.
2. **Submit:**
   ```sh
   OPTS="-v v1p0 --site T3_US_MIT --storage /store/group/zmass/NanoAOD"
   ./scripts/prepareCrab.py --makeConfig -i inputs/data_postVFP.txt $OPTS
   grep -h "inputDataset\|splitting\|unitsPerJob\|outLFNDirBase\|outputDatasetTag\|storageSite" crab_submit/submitSingleMuon_*.py
   ./scripts/prepareCrab.py -i inputs/data_postVFP.txt $OPTS --submit 1 1
   ```
   Each of the three submit files must show `EventAwareLumiBased`, `144000`, `/store/group/zmass/NanoAOD`,
   `NanoV15Run2016<era>DataPostVFP_v1p0` and `T3_US_MIT`. Post the three task names in #27.
3. **Monitor and recover:** runbook steps 4–5. For data recoveries, use `unitsPerJob = 10` lumis.
4. **Completion:** runbook step 6, for each era. The events read must equal the numbers above.
5. **Report:** runbook step 7, in #27.

The data jobs also refit with the OPERA field map. Its tables travel in the CRAB sandbox, which is why
`prepareSandbox.sh` must have printed `sha1 ok`.
