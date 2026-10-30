from __future__ import print_function

from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper


MAX_SEED = 900000000
JOB_STRIDE = 1000
STAGE_WIDTH = 200
STAGE_OFFSETS = {
    "GENSIM": 0,
    "DIGIPremix": 200,
    "HLT": 400,
    "RECOALCA": 600,
}


def _seed_values(service, job_id, stage):
    if stage not in STAGE_OFFSETS:
        raise RuntimeError("unknown RNG stage: {0}".format(stage))
    if job_id <= 0:
        raise RuntimeError("job ID must be positive")

    helper = RandomNumberServiceHelper(service)
    count = helper.countSeeds()
    if count > STAGE_WIDTH:
        raise RuntimeError(
            "stage {0} requires {1} seeds; reserved width is {2}".format(
                stage, count, STAGE_WIDTH
            )
        )
    first = (job_id - 1) * JOB_STRIDE + STAGE_OFFSETS[stage] + 1
    last = first + count - 1
    if last > MAX_SEED:
        raise RuntimeError(
            "job ID {0} exceeds deterministic seed range for {1}".format(job_id, stage)
        )
    return helper, list(range(first, last + 1))


def seed_map(service):
    result = {}
    for name in sorted(service.parameters_()):
        parameters = getattr(service, name, None)
        if parameters is None:
            continue
        if hasattr(parameters, "initialSeed"):
            result[name] = [parameters.initialSeed.value()]
        elif hasattr(parameters, "initialSeedSet"):
            result[name] = list(parameters.initialSeedSet.value())
    return result


def insert_deterministic_seeds(process, job_id, stage):
    service = getattr(process, "RandomNumberGeneratorService", None)
    if service is None:
        return {}
    helper, seeds = _seed_values(service, job_id, stage)
    helper.insertSeeds(*seeds)
    return seed_map(service)
