from __future__ import print_function


def generator_identity(crab_job_id, job_offset, events):
    crab_job_id = int(crab_job_id)
    job_offset = int(job_offset)
    events = int(events)
    if crab_job_id <= 0:
        raise RuntimeError("CRAB job ID must be positive")
    if job_offset < 0:
        raise RuntimeError("job offset must be nonnegative")
    if events <= 0:
        raise RuntimeError("events per job must be positive")

    global_job_id = crab_job_id + job_offset
    first_event = (global_job_id - 1) * events + 1
    return {
        "crab_job_id": crab_job_id,
        "job_offset": job_offset,
        "global_job_id": global_job_id,
        "first_run": 1,
        "first_lumi": global_job_id,
        "first_event": first_event,
        "last_event": first_event + events - 1,
        "events_per_job": events,
    }


def apply_generator_identity(process, cms, identity):
    process.maxEvents.input = cms.untracked.int32(identity["events_per_job"])
    process.source.firstRun = cms.untracked.uint32(identity["first_run"])
    process.source.firstLuminosityBlock = cms.untracked.uint32(
        identity["first_lumi"]
    )
    process.source.firstEvent = cms.untracked.uint64(identity["first_event"])
    process.source.numberEventsInLuminosityBlock = cms.untracked.uint32(
        identity["events_per_job"]
    )

