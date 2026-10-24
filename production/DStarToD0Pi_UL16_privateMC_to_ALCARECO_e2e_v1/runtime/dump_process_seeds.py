from __future__ import print_function

import json
import os
import sys


def execute_config(path):
    namespace = {"__file__": path}
    try:
        execfile(path, namespace)  # noqa: F821 - CMSSW 8/10 use Python 2.
    except NameError:
        with open(path, "rb") as handle:
            exec(compile(handle.read(), path, "exec"), namespace)
    return namespace["process"]


if len(sys.argv) != 3:
    raise RuntimeError("usage: dump_process_seeds.py CONFIG OUTPUT_JSON")

runtime_dir = os.path.dirname(os.path.abspath(__file__))
if runtime_dir not in sys.path:
    sys.path.insert(0, runtime_dir)
from deterministic_seeds import seed_map

process = execute_config(os.path.abspath(sys.argv[1]))
service = getattr(process, "RandomNumberGeneratorService", None)
seeds = {} if service is None else seed_map(service)
with open(sys.argv[2], "w") as handle:
    json.dump(seeds, handle, sort_keys=True, separators=(",", ":"))
    handle.write("\n")
