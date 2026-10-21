from __future__ import print_function

import json
import os
import pickle
import sys

import FWCore.ParameterSet.Config as cms


def required_environment(name):
    value = os.environ.get(name)
    if not value:
        raise RuntimeError("required environment variable {0} is not set".format(name))
    return value


def integer_environment(name):
    try:
        return int(required_environment(name))
    except ValueError:
        raise RuntimeError("{0} must be an integer".format(name))


def execute_config(path):
    namespace = globals()
    previous_file = namespace.get("__file__")
    namespace["__file__"] = path
    try:
        try:
            execfile(path, namespace)  # noqa: F821 - CMSSW 10 uses Python 2.
        except NameError:
            with open(path, "rb") as handle:
                exec(compile(handle.read(), path, "exec"), namespace)
    finally:
        if previous_file is None:
            namespace.pop("__file__", None)
        else:
            namespace["__file__"] = previous_file


crab_pset = os.path.abspath(required_environment("CHAIN_CRAB_PSET"))
if not os.path.isfile(crab_pset):
    raise RuntimeError("CRAB process configuration is missing: {0}".format(crab_pset))
if crab_pset.endswith(".pkl"):
    with open(crab_pset, "rb") as handle:
        process = pickle.load(handle)
else:
    execute_config(crab_pset)

payload_dir = os.path.abspath(required_environment("CHAIN_PAYLOAD_DIR"))
runtime_dir = os.path.join(payload_dir, "runtime")
if runtime_dir not in sys.path:
    sys.path.insert(0, runtime_dir)

from deterministic_seeds import insert_deterministic_seeds
from generator_identity import apply_generator_identity, generator_identity

crab_job_id = integer_environment("CHAIN_CRAB_JOB_ID")
job_offset = integer_environment("CHAIN_JOB_OFFSET")
events = integer_environment("CHAIN_EVENTS")
identity = generator_identity(crab_job_id, job_offset, events)

incoming_first_event = int(process.source.firstEvent.value())
incoming_first_lumi = int(process.source.firstLuminosityBlock.value())
expected_first_event = (crab_job_id - 1) * events + 1
if incoming_first_event != expected_first_event or incoming_first_lumi != crab_job_id:
    raise RuntimeError(
        "unexpected CRAB generator identity: event {0} (expected {1}), "
        "lumi {2} (expected {3})".format(
            incoming_first_event,
            expected_first_event,
            incoming_first_lumi,
            crab_job_id,
        )
    )

apply_generator_identity(process, cms, identity)
seeds = insert_deterministic_seeds(
    process, identity["global_job_id"], "GENSIM"
)

with open(required_environment("CHAIN_SEED_REPORT"), "w") as handle:
    json.dump(seeds, handle, sort_keys=True, separators=(",", ":"))
    handle.write("\n")
with open(required_environment("CHAIN_IDENTITY_REPORT"), "w") as handle:
    json.dump(identity, handle, sort_keys=True, separators=(",", ":"))
    handle.write("\n")

