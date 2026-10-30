# D* UL16 private MC to ALCARECO, single-job chain v1

This directory is a new, self-contained production wrapper around the validated
private-v2 physics configurations. One CRAB `PrivateMC` job runs GEN-SIM,
DIGI premix, 8X HLT, and RECO+`TkAlDstToD0Pi` ALCARECO. Intermediate EDM files
stay on worker-local disk and are deleted only after the consuming stage has
succeeded and its output has passed `edmFileUtil` validation.

The 1k pilot and 100k threshold-retention validation were completed on
2026-08-09. The latter finished 100/100 jobs without retries or restarts.

## Preserved production configuration

| Stage | CMSSW | Step/global tag | Reference SHA-256 |
|---|---|---|---|
| GEN-SIM | `CMSSW_10_6_17_patch1` | `GEN,SIM`; `106X_mcRun2_asymptotic_v13` | `f5421ec7...` |
| DIGI premix | `CMSSW_10_6_17_patch1` | `DIGI,DATAMIX,L1,DIGI2RAW`; `106X_mcRun2_asymptotic_v13` | `7026982b...` |
| HLT | `CMSSW_8_0_36_UL_patch1` | `HLT:25ns15e33_v4`; `80X_mcRun2_asymptotic_2016_TrancheIV_v6` | `4e9b36e1...` |
| RECO+ALCA | `CMSSW_10_6_17_patch1` | `RAW2DIGI,L1Reco,RECO,RECOSIM,ALCA:TkAlDstToD0Pi`; `106X_mcRun2_asymptotic_v13` | `2368e948...` |

The generator fragment, forced EvtGen decay, generated configs, and the
historical output-suppression wrapper are byte-for-byte copies. Their complete
hashes are pinned in `REFERENCE_SHA256SUMS`. In particular, this preserves CP5
hard-`ccbar`, the forced `D*+ -> D0 pi+`, `D0 -> K- pi+` decay and conjugate,
the D* mother `pT > 3.9 GeV` filter, the UL16 premix file set, beam spot,
geometry, eras, global tags, and the intentional 8X input-version bypass.

The only process additions are operational: deterministic downstream RNG
seeds, the four-thread DIGI setting used by private v2, suppression of the
large RECOSIM side output, and the non-filtering compact threshold-scan
analyzer. `crab_pset.py` is a submit-time wrapper around the hash-pinned GENSIM
configuration that advertises the same four-core allocation to CRAB; it does
not change generator or filter parameters.

## Outputs and cleanup

CRAB is configured with `disableAutomaticOutputCollection=True` and transfers
only:

- `TkAlDstToD0Pi.root`: final ALCARECO.
- `dst_alca_threshold_scan_hlt.root`: compact reconstruction/selection scan.
- `monitoring.json`: stage releases, wall times, input/output sizes, cleanup
  state, accepted/output event counts, and actual RNG seeds.

`GENSIM.root` is deleted after DIGI succeeds, DIGI is deleted after HLT
succeeds, and HLT is deleted after RECOALCA plus both final-output validations
succeed. Every `cmsRun` writes `FrameworkJobReport.xml`; the report from the
last completed stage is retained if the chain fails, while the successful
RECOALCA report is returned to CRAB at the end. CRAB logs are transferred for
the pilot so failures can be diagnosed, but no intermediate EDM files are
included in them. `publication=False` is intentional: this is a file-based
ALCARECO production and no output is DBS-published.

Before the successful report is returned, `runtime/rewrite_fjr_paths.py`
replaces the temporary work-directory prefix with the CRAB sandbox prefix.
This keeps the report PFNs synchronized with the final locations of the moved
ALCARECO and compact scan outputs during CRAB checksum handling.

## CRAB and random seeds

CRAB invokes `scriptExe` as `run_chain.sh JOB_NUMBER ...`. For GEN-SIM the
runner loads CRAB's tweaked `PSet.py` or `PSet.pkl` from the original sandbox
through `runtime/crab_gensim_cfg.py`. The wrapper verifies CRAB's incoming
event/lumi assignment before applying the configured production-block offset
and deterministic GEN seeds. CRAB does not rewrite the static downstream
configs, so `runtime/deterministic_seeds.py` also calls
`RandomNumberServiceHelper.insertSeeds()` for DIGI, HLT, and RECOALCA. Seeds
for all four stages are a deterministic function of global job number, stage
offset, and seed index; `populate()` is never used. `monitoring.json` records
the CRAB job number, block offset, global job number, first/last event, and
luminosity identity.

The runner captures the original 10.6 `CMSSW_BASE` before any switch, creates
or uses the worker-local CVMFS-backed `CMSSW_8_0_36_UL_patch1` area for HLT,
then explicitly restores the captured 10.6 area for RECOALCA.

## Prerequisites

Submit from the existing `CMSSW_10_6_17_patch1` area. It must contain the
built `AlignmentCommonAlignmentProducerDstarDiagnostics` plugin used by the
compact scan. The current area already contains that library, and CRAB includes
local CMSSW products in its job sandbox in addition to the explicit payload.
The runner also verifies the analyzer plugin before RECOALCA starts. The two
reference release areas are used directly by local mode.

Build the hash-pinned CRAB payload and run checks:

```bash
cd /work/submit/emanca/zmass/ALCArequest/DStarToD0Pi_UL16_privateMC_to_ALCARECO_e2e_v1
./tests/test_workflow.sh
```

The test verifies reference hashes, shell/Python syntax, payload contents, and
loads the real DIGI, HLT, and RECOALCA configs for job IDs 17 and 18 to prove
their dumped seeds differ.

## Local test mode

Run the complete chain inside the EL7 compatibility environment. One generator
attempt is the smallest orchestration test; because the generator filter
efficiency is about 4.82%, it may legitimately contain no accepted event.

```bash
./run_local_test.sh 1 1
```

Arguments are `EVENTS`, `JOB_ID`, and optional output directory. Local mode
emulates job identity and writes the same three deliverables under
`local_runs/job_JOB_ID/`. Increase `EVENTS` for a physics-content test. Local
mode permits zero accepted generator events for orchestration testing;
production mode rejects such a job rather than transferring an empty ALCARECO.

## Validated configurations

`crabConfig_pilot.py` is a one-job, 1,000-generator-attempt pilot. This is
large enough to measure end-to-end runtime and scratch usage while remaining
small compared with a production block.

`crabConfig_thresholdRetention100k.py` ran 100 jobs of 1,000 attempts. Its
aggregate monitoring measured 4.795% generator acceptance, 69.72% retention
from accepted generation to final ALCARECO, and 3.343% final events per
generator attempt. The current ALCARECO working point retained 774 of 4,953
strict generated D* chains; looser pT points increased combinatorics and flat
track load much faster than signal retention. The reports are stored under
`validation_v5/`.

`crabConfig_production100M_block1.py` through
`crabConfig_production100M_block5.py` form one 500-million-attempt campaign.
Each block contains 100 million attempts, split into 8,000 jobs of 12,500
attempts. The blocks run independently and concurrently, but their offsets
produce one disjoint global identity range: events 1 through 500,000,000 and
global jobs 1 through 40,000. All five configs are built by
`crab_production500M.py`, so only the request/LFN block label and identity
offset differ. The 100k validation projects about 16.7 million final ALCARECO
events and 1.54 TiB of final ALCARECO for the full campaign.

Before any future submission:

1. Run `./tests/test_workflow.sh`, which also rebuilds `payload.tar.gz`.
2. Enter `/work/submit/emanca/zmass/ALCArequest/CMSSW_10_6_17_patch1/src` and
   run `cmsenv`.
3. Review the request name, LFN, storage site, memory, and runtime expectations.
4. Keep `scriptArgs` `events=N` and `Data.unitsPerJob=N` identical, with
   `Data.lumisPerFile=1` so CRAB assigns the full job to one luminosity block.
5. Keep `Data.totalUnits` an integer multiple of `Data.unitsPerJob`, because
   the compact JSON records the configured attempts per job.

No submit helper is provided intentionally. A production expansion must use a
new request/LFN name and should follow a successful pilot inspection; it will
remain file-based unless the architecture is changed to support publication.
