from __future__ import print_function

from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper


MAX_SEED = 900000000
JOB_STRIDE = 1000
STAGE_WIDTH = 200
SPECIES_STRIDE = 250000  # axis of global job slots per species (see below)
STAGE_OFFSETS = {
    "GENSIM": 0,
    "DIGIPremix": 200,
    "RECO": 400,
    "ALCA": 600,
}

# Species carry distinct RNG ensembles so identically-indexed jobs of two
# species are DIFFERENT events (v4_pilot measurement: identical gun paT in
# 981/998 jobs where not separated). The API is additive on top of the job
# axis: slot = (job_id - 1) + (species_index - 1) * SPECIES_STRIDE. With
# the 30-block layout (max slot ~60k), MAX_SEED stays far away; species
# count up to 3 keeps slots < 500k.


def _seed_values(service, job_id, stage, species_index=1):
    if stage not in STAGE_OFFSETS:
        raise RuntimeError("unknown RNG stage: {0}".format(stage))
    if job_id <= 0:
        raise RuntimeError("job ID must be positive")
    if species_index < 1:
        raise RuntimeError("species index must be >= 1")
    slot = (job_id - 1) + (species_index - 1) * SPECIES_STRIDE

    helper = RandomNumberServiceHelper(service)
    count = helper.countSeeds()
    if count > STAGE_WIDTH:
        raise RuntimeError(
            "stage {0} requires {1} seeds; reserved width is {2}".format(
                stage, count, STAGE_WIDTH
            )
        )
    first = slot * JOB_STRIDE + STAGE_OFFSETS[stage] + 1
    last = first + count - 1
    if last > MAX_SEED:
        raise RuntimeError(
            "job ID {0} (species index {1}) exceeds deterministic seed range for {2}".format(
                job_id, species_index, stage
            )
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


def insert_deterministic_seeds(process, job_id, stage, species_index=1):
    service = getattr(process, "RandomNumberGeneratorService", None)
    if service is None:
        return {}
    helper, seeds = _seed_values(service, job_id, stage, species_index)
    helper.insertSeeds(*seeds)
    return seed_map(service)
