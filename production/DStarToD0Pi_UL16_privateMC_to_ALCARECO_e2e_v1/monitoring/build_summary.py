from __future__ import print_function

import json
import os
import platform
import sys
import time


def read_rows(path):
    rows = []
    with open(path) as handle:
        for line in handle:
            fields = line.rstrip("\n").split("\t")
            if len(fields) != 10:
                raise RuntimeError("malformed stage row: {0}".format(line.rstrip()))
            (
                stage,
                release,
                start,
                end,
                input_name,
                input_size,
                output_name,
                output_size,
                output_events,
                deleted,
            ) = fields
            seed_path = os.path.join(os.path.dirname(path), "seeds_{0}.json".format(stage))
            with open(seed_path) as seed_handle:
                seeds = json.load(seed_handle)
            rows.append(
                {
                    "stage": stage,
                    "cmssw": release,
                    "start_epoch": int(start),
                    "end_epoch": int(end),
                    "wall_seconds": int(end) - int(start),
                    "input": input_name,
                    "input_bytes": int(input_size),
                    "output": output_name,
                    "output_bytes": int(output_size),
                    "output_events": int(output_events),
                    "input_deleted_after_success": deleted == "true",
                    "rng_seeds": seeds,
                }
            )
    return rows


if len(sys.argv) != 9:
    raise RuntimeError(
        "usage: build_summary.py JOB_ID EVENTS CAMPAIGN ROWS FINAL_OUTPUT "
        "SCAN_OUTPUT IDENTITY DESTINATION"
    )

(
    job_id,
    events,
    campaign,
    rows_path,
    final_output,
    scan_output,
    identity_path,
    destination,
) = sys.argv[1:]
stages = read_rows(rows_path)
with open(identity_path) as identity_handle:
    generator_identity = json.load(identity_handle)
summary = {
    "schema_version": 2,
    "status": "success",
    "campaign": campaign,
    "job_id": int(job_id),
    "generator_attempts": int(events),
    "generator_identity": generator_identity,
    "host": platform.node(),
    "created_epoch": int(time.time()),
    "final_output": os.path.basename(final_output),
    "final_output_bytes": os.path.getsize(final_output),
    "scan_output": os.path.basename(scan_output),
    "scan_output_bytes": os.path.getsize(scan_output),
    "accepted_generator_events": stages[0]["output_events"],
    "final_events": stages[-1]["output_events"],
    "stages": stages,
}

with open(destination, "w") as handle:
    json.dump(summary, handle, sort_keys=True, separators=(",", ":"))
    handle.write("\n")
