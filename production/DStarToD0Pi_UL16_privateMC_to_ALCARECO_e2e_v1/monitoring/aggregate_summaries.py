#!/usr/bin/env python3
"""Aggregate per-job end-to-end production monitoring JSON files."""

from __future__ import print_function

import argparse
import glob
import json
import os


def safe_ratio(numerator, denominator):
    return None if not denominator else float(numerator) / float(denominator)


def expand_inputs(patterns):
    paths = []
    for pattern in patterns:
        if os.path.isdir(pattern):
            matches = sorted(
                os.path.join(directory, filename)
                for directory, _, filenames in os.walk(pattern)
                for filename in filenames
                if filename.endswith(".json")
            )
        else:
            matches = sorted(glob.glob(pattern))
            if not matches and os.path.isfile(pattern):
                matches = [pattern]
        paths.extend(matches)
    return list(dict.fromkeys(os.path.abspath(path) for path in paths))


def distribution(values):
    if not values:
        return {"min": None, "median": None, "mean": None, "max": None}
    ordered = sorted(values)
    midpoint = len(ordered) // 2
    if len(ordered) % 2:
        median = ordered[midpoint]
    else:
        median = 0.5 * (ordered[midpoint - 1] + ordered[midpoint])
    return {
        "min": min(values),
        "median": median,
        "mean": float(sum(values)) / len(values),
        "max": max(values),
    }


def load_summaries(paths):
    summaries = []
    seen_jobs = set()
    for path in paths:
        with open(path) as handle:
            summary = json.load(handle)
        if summary.get("status") != "success":
            raise RuntimeError("unsuccessful monitoring record: {0}".format(path))
        job_key = (summary.get("campaign"), int(summary["job_id"]))
        if job_key in seen_jobs:
            raise RuntimeError("duplicate campaign/job_id: {0}".format(job_key))
        seen_jobs.add(job_key)
        summaries.append(summary)
    return summaries


def build_report(summaries, paths, projected_attempts):
    attempts = sum(int(item["generator_attempts"]) for item in summaries)
    accepted = sum(int(item["accepted_generator_events"]) for item in summaries)
    final_events = sum(int(item["final_events"]) for item in summaries)
    final_bytes = sum(int(item["final_output_bytes"]) for item in summaries)
    scan_bytes = sum(int(item["scan_output_bytes"]) for item in summaries)

    stage_names = []
    for summary in summaries:
        for stage in summary["stages"]:
            if stage["stage"] not in stage_names:
                stage_names.append(stage["stage"])

    stages = {}
    for stage_name in stage_names:
        rows = [
            stage
            for summary in summaries
            for stage in summary["stages"]
            if stage["stage"] == stage_name
        ]
        stages[stage_name] = {
            "jobs": len(rows),
            "output_events": sum(int(row["output_events"]) for row in rows),
            "input_bytes": sum(int(row["input_bytes"]) for row in rows),
            "output_bytes": sum(int(row["output_bytes"]) for row in rows),
            "wall_seconds": distribution([int(row["wall_seconds"]) for row in rows]),
        }

    report = {
        "inputs": {"files": paths, "jobs": len(summaries)},
        "campaigns": sorted(set(item["campaign"] for item in summaries)),
        "totals": {
            "generator_attempts": attempts,
            "accepted_generator_events": accepted,
            "final_events": final_events,
            "final_output_bytes": final_bytes,
            "scan_output_bytes": scan_bytes,
        },
        "rates": {
            "generator_acceptance": safe_ratio(accepted, attempts),
            "final_events_per_attempt": safe_ratio(final_events, attempts),
            "final_retention_from_accepted": safe_ratio(final_events, accepted),
            "final_output_bytes_per_attempt": safe_ratio(final_bytes, attempts),
            "scan_output_bytes_per_attempt": safe_ratio(scan_bytes, attempts),
        },
        "job_distributions": {
            "generator_attempts": distribution(
                [int(item["generator_attempts"]) for item in summaries]
            ),
            "accepted_generator_events": distribution(
                [int(item["accepted_generator_events"]) for item in summaries]
            ),
            "final_events": distribution([int(item["final_events"]) for item in summaries]),
            "final_output_bytes": distribution(
                [int(item["final_output_bytes"]) for item in summaries]
            ),
        },
        "stages": stages,
    }

    if projected_attempts:
        report["projection"] = {
            "generator_attempts": projected_attempts,
            "accepted_generator_events": projected_attempts
            * report["rates"]["generator_acceptance"],
            "final_events": projected_attempts
            * report["rates"]["final_events_per_attempt"],
            "final_output_bytes": projected_attempts
            * report["rates"]["final_output_bytes_per_attempt"],
            "scan_output_bytes": projected_attempts
            * report["rates"]["scan_output_bytes_per_attempt"],
        }
    return report


def format_rate(value):
    return "undefined" if value is None else "{0:.6g}".format(value)


def print_report(report):
    totals = report["totals"]
    rates = report["rates"]
    print("jobs                         {0}".format(report["inputs"]["jobs"]))
    print("generator_attempts           {0}".format(totals["generator_attempts"]))
    print("accepted_generator_events    {0}".format(totals["accepted_generator_events"]))
    print("final_events                 {0}".format(totals["final_events"]))
    print("generator_acceptance         {0}".format(format_rate(rates["generator_acceptance"])))
    print("final_events_per_attempt     {0}".format(format_rate(rates["final_events_per_attempt"])))
    print("final_retention_from_accepted {0}".format(
        format_rate(rates["final_retention_from_accepted"])
    ))
    print("final_output_bytes           {0}".format(totals["final_output_bytes"]))
    print("scan_output_bytes            {0}".format(totals["scan_output_bytes"]))
    print("")
    print("stage jobs output_events output_bytes wall_min wall_median wall_mean wall_max")
    for name, stage in report["stages"].items():
        wall = stage["wall_seconds"]
        print(
            "{0} {1} {2} {3} {4:.0f} {5:.1f} {6:.1f} {7:.0f}".format(
                name,
                stage["jobs"],
                stage["output_events"],
                stage["output_bytes"],
                wall["min"],
                wall["median"],
                wall["mean"],
                wall["max"],
            )
        )
    if "projection" in report:
        projection = report["projection"]
        print("")
        print("projection_attempts          {0}".format(projection["generator_attempts"]))
        print("projection_accepted_events   {0:.0f}".format(
            projection["accepted_generator_events"]
        ))
        print("projection_final_events      {0:.0f}".format(projection["final_events"]))
        print("projection_final_output_GiB  {0:.3f}".format(
            projection["final_output_bytes"] / float(1024 ** 3)
        ))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("inputs", nargs="+", help="JSON files, globs, or directories")
    parser.add_argument("--json-output", help="write the aggregate report as JSON")
    parser.add_argument(
        "--project-attempts",
        type=int,
        default=0,
        help="project yields and output sizes to this number of generator attempts",
    )
    args = parser.parse_args()

    paths = expand_inputs(args.inputs)
    if not paths:
        parser.error("no monitoring JSON files matched the supplied inputs")
    summaries = load_summaries(paths)
    report = build_report(summaries, paths, args.project_attempts)
    print_report(report)
    if args.json_output:
        with open(args.json_output, "w") as handle:
            json.dump(report, handle, indent=2, sort_keys=True)
            handle.write("\n")


if __name__ == "__main__":
    main()
