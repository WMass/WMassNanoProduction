#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Generic chain-stage runner for the MuKPi UL16 gun ALCARECO campaign.

Pattern ported from the D* UL16 e2e chain (runtime/stage_cfg.py):
loads a chain cfg module, inserts deterministic per-job seeds via
deterministic_seeds.insert_deterministic_seeds(), caps GENSIM events
from CHAIN_EVENTS, and renames the stage output to the absolute path
given by CHAIN_OUTPUT_ABS so the framework job report records
WORK_DIR-prefixed PFNs (later rewritten by runtime/rewrite_fjr_paths.py).

Invoked from run_chain.sh as:
    CHAIN_STAGE=<stage> CHAIN_JOB_ID=<id> CHAIN_EVENTS=<n> \
    CHAIN_CFG=<cfg-path> CHAIN_OUTPUT_ABS=<abs-output-path> \
        cmsRun -j FrameworkJobReport.xml "$PAYLOAD_DIR/runtime/stage_runner.py"

cmsRun consumes positional CLI arguments itself, so everything travels
through the environment.
"""
from __future__ import print_function

import json
import os
import sys

import FWCore.ParameterSet.Config as cms


def load_process(cfg_path):
    """Import a chain cfg module by file path (py2/py3 compatible)."""
    try:
        import imp
        sys.modules.pop("chain_stage_cfg", None)
        module = imp.load_source("chain_stage_cfg", cfg_path)
    except ImportError:
        import importlib.util
        spec = importlib.util.spec_from_file_location("chain_stage_cfg", cfg_path)
        if spec is None or spec.loader is None:
            raise RuntimeError("cannot import cfg module: {0}".format(cfg_path))
        module = importlib.util.module_from_spec(spec)
        sys.modules.pop("chain_stage_cfg", None)
        spec.loader.exec_module(module)
    process = getattr(module, "process", None)
    if process is not None:
        return process
    # cfg module executed without producing `process`: fallback for cmsRun
    # exec contexts in which the module is defined in this namespace.
    return None


def main():
    cfg_path = os.environ["CHAIN_CFG"]
    stage = os.environ["CHAIN_STAGE"]
    job_id = int(os.environ["CHAIN_JOB_ID"])

    # cmsRun execution defines no __file__; the runtime dir is known via the
    # chain environment (same convention as the D* e2e chain).
    runtime_dir = os.path.join(os.environ["CHAIN_PAYLOAD_DIR"], "runtime")
    if runtime_dir not in sys.path:
        sys.path.insert(0, runtime_dir)
    from deterministic_seeds import insert_deterministic_seeds, seed_map

    process = load_process(cfg_path)
    if process is None:
        raise RuntimeError("cfg does not define a process: {0}".format(cfg_path))

    service = getattr(process, "RandomNumberGeneratorService", None)
    seeds_before = seed_map(service) if service is not None else {}
    insert_deterministic_seeds(process, job_id, stage)
    seeds_after = seed_map(service) if service is not None else {}

    if stage == "GENSIM":
        events = int(os.environ["CHAIN_EVENTS"])
        process.maxEvents.input = cms.untracked.int32(events)

    # Force absolute output paths so the framework job report names the
    # WORK_DIR-prefixed PFN; runtime/rewrite_fjr_paths.py rewrites the prefix
    # to the CRAB sandbox prefix after the files are moved into place.
    output_abs = os.environ.get("CHAIN_OUTPUT_ABS")
    if output_abs:
        for module in process.outputModules_().values():
            module.fileName = cms.untracked.string("file:" + output_abs)

    seed_report = os.environ.get("CHAIN_SEED_REPORT")
    if seed_report:
        with open(seed_report, "w") as handle:
            json.dump(
                {
                    "jobId": job_id,
                    "stage": stage,
                    "before": seeds_before,
                    "after": seeds_after,
                },
                handle,
                indent=2,
                sort_keys=True,
            )
            handle.write("\n")

    # cmsRun resolves the configuration by looking up `process` in the
    # namespace of the executed python file: publish it there.
    globals()["process"] = process


main()
