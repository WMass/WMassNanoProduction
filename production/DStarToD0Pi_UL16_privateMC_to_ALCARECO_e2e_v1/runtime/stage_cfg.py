from __future__ import print_function

import json
import os
import sys

import FWCore.ParameterSet.Config as cms


REFERENCE_CONFIGS = {
    "GENSIM": "DStarToD0Pi_D0KPi_TuneCP5_GENSIM_cfg.py",
    "DIGIPremix": "DStarToD0Pi_D0KPi_TuneCP5_DIGIPremix_cfg.py",
    "HLT": "DStarToD0Pi_D0KPi_TuneCP5_HLT_cfg.py",
    "RECOALCA": "DStarToD0Pi_D0KPi_TuneCP5_RECOALCA_crab_cfg.py",
}


def required_environment(name):
    value = os.environ.get(name)
    if not value:
        raise RuntimeError("required environment variable {0} is not set".format(name))
    return value


def positive_integer(name):
    value = int(required_environment(name))
    if value <= 0:
        raise RuntimeError("{0} must be positive".format(name))
    return value


def execute_config(path):
    namespace = globals()
    previous_file = namespace.get("__file__")
    namespace["__file__"] = path
    try:
        try:
            execfile(path, namespace)  # noqa: F821 - CMSSW 8/10 use Python 2.
        except NameError:
            with open(path, "rb") as handle:
                exec(compile(handle.read(), path, "exec"), namespace)
    finally:
        if previous_file is None:
            namespace.pop("__file__", None)
        else:
            namespace["__file__"] = previous_file


stage = required_environment("CHAIN_STAGE")
if stage not in REFERENCE_CONFIGS:
    raise RuntimeError("unsupported CHAIN_STAGE: {0}".format(stage))

payload_dir = os.path.abspath(required_environment("CHAIN_PAYLOAD_DIR"))
reference_path = os.path.join(payload_dir, "reference", REFERENCE_CONFIGS[stage])
if not os.path.isfile(reference_path):
    raise RuntimeError("missing reference configuration: {0}".format(reference_path))

execute_config(reference_path)

job_id = positive_integer("CHAIN_JOB_ID")
events = positive_integer("CHAIN_EVENTS")
input_file = os.environ.get("CHAIN_INPUT_FILE")

if stage == "GENSIM":
    runtime_dir = os.path.join(payload_dir, "runtime")
    if runtime_dir not in sys.path:
        sys.path.insert(0, runtime_dir)
    from generator_identity import apply_generator_identity, generator_identity

    identity = generator_identity(job_id, 0, events)
    apply_generator_identity(process, cms, identity)
    with open(required_environment("CHAIN_IDENTITY_REPORT"), "w") as handle:
        json.dump(identity, handle, sort_keys=True, separators=(",", ":"))
        handle.write("\n")
elif stage in ("DIGIPremix", "HLT", "RECOALCA"):
    if not input_file:
        raise RuntimeError("CHAIN_INPUT_FILE is required for {0}".format(stage))
    process.maxEvents.input = cms.untracked.int32(-1)
    process.source.fileNames = cms.untracked.vstring("file:" + os.path.abspath(input_file))

if stage == "DIGIPremix":
    process.options.numberOfThreads = cms.untracked.uint32(
        positive_integer("CHAIN_DIGI_THREADS")
    )
    process.options.numberOfStreams = cms.untracked.uint32(0)

if stage == "RECOALCA":
    process.TFileService = cms.Service(
        "TFileService",
        fileName=cms.string("dst_alca_threshold_scan_hlt.root"),
    )
    process.dstAlcaThresholdScan = cms.EDAnalyzer(
        "DstAlcaThresholdScanAnalyzer",
        tracks=cms.InputTag("generalTracks"),
        genParticles=cms.InputTag("genParticles"),
    )
    process.dstAlcaThresholdScanPath = cms.Path(process.dstAlcaThresholdScan)
    process.schedule = cms.Schedule(
        process.raw2digi_step,
        process.L1Reco_step,
        process.reconstruction_step,
        process.recosim_step,
        process.pathALCARECOTkAlDstToD0Pi,
        process.dstAlcaThresholdScanPath,
        process.endjob_step,
        process.ALCARECOStreamTkAlDstToD0PiOutPath,
    )

runtime_dir = os.path.join(payload_dir, "runtime")
if runtime_dir not in sys.path:
    sys.path.insert(0, runtime_dir)
from deterministic_seeds import insert_deterministic_seeds

seeds = insert_deterministic_seeds(process, job_id, stage)
seed_report = required_environment("CHAIN_SEED_REPORT")
with open(seed_report, "w") as handle:
    json.dump(seeds, handle, sort_keys=True, separators=(",", ":"))
    handle.write("\n")
