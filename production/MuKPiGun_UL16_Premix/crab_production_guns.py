import os

# MuKPi gun PRODUCTION round: 150M events in 15 block-tasks.
# 3 species x 5 blocks. Each block-task: 10M events = 4,000 jobs x 2,500
# events/job, ~1.5-3.5 h per job (premix xrootd variance), 8 cores/16 GB,
# ASO to T3_US_MIT with DAS publication (phys03) ON.
#
# Blocks exist because CRAB caps a task at ~10k jobs and because seeds must
# never repeat across tasks: deterministic seeding keys on CHAIN_JOB_ID =
# jobIndex + jobOffset, so every block carries a distinct jobOffset
# (block * EVENTS_PER_TASK). Wrappers crab_prod_<Species_version_blockN>.py
# import make_configs(); use `python crab_production_guns.py` to (re)create them.

EVENTS_PER_JOB = 2500
EVENTS_PER_TASK = 10000000            # 4,000 jobs per task
BLOCKS_PER_SPECIES = 5
VERSION = "v1_150M_20261030"
CAMPAIGN = "prod_v1_150M"
SPECIES = ["MuGun", "PiGun", "KGun"]


def make_configs():
    from CRABClient.UserUtilities import config as crab_config

    cfgs = {}
    here = os.path.dirname(os.path.abspath(__file__))
    for species in SPECIES:
        primary = {"MuGun": "SingleMuGun_Pt0p01To150_Eta2p4",
                   "PiGun": "SinglePiGun_Pt0p01To150_Eta2p4",
                   "KGun": "SingleKGun_Pt0p01To150_Eta2p4"}[species]
        for block in range(BLOCKS_PER_SPECIES):
            tag = "{0}_{1}_block{2}".format(species, VERSION, block)
            cfg = crab_config()
            cfg.General.requestName = "{0}_UL16Premix_{1}".format(species, tag)
            cfg.General.workArea = os.path.join(here, "crab_projects")
            cfg.General.transferOutputs = True
            cfg.General.transferLogs = True
            cfg.JobType.pluginName = "PrivateMC"
            cfg.JobType.psetName = os.path.join(here, "crab_pset.py")
            cfg.JobType.scriptExe = os.path.join(here, "run_chain.sh")
            cfg.JobType.scriptArgs = [
                "events={0}".format(EVENTS_PER_JOB),
                "species={0}".format(species),
                "jobOffset={0}".format(block * EVENTS_PER_TASK),
            ]
            cfg.JobType.inputFiles = [os.path.join(here, "payload.tar.gz")]
            cfg.JobType.disableAutomaticOutputCollection = True
            cfg.JobType.outputFiles = ["{0}_ALCARECO.root".format(species), "monitoring.json"]
            cfg.JobType.allowUndistributedCMSSW = True
            cfg.JobType.maxMemoryMB = 16000
            cfg.JobType.maxJobRuntimeMin = 600
            cfg.JobType.numCores = 8
            cfg.Data.splitting = "EventBased"
            cfg.Data.unitsPerJob = EVENTS_PER_JOB
            cfg.Data.totalUnits = EVENTS_PER_TASK
            cfg.Data.lumisPerFile = 1
            cfg.Data.publication = True
            cfg.Data.publishDBS = "phys03"
            cfg.Data.outputPrimaryDataset = primary
            cfg.Data.outputDatasetTag = tag
            cfg.Data.outLFNDirBase = "/store/group/zmass/MuKPiGun_UL16_Premix_{0}/{1}".format(CAMPAIGN, tag)
            cfg.Site.storageSite = "T3_US_MIT"
            cfgs.setdefault(species, {})[tag] = cfg
    return cfgs


if __name__ == "__main__":
    here = os.path.dirname(os.path.abspath(__file__))
    header = ("import os, sys\n"
              "sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))\n"
              "from crab_production_guns import make_configs as _make\n")
    # Only names are needed here - the configs themselves are built by
    # make_configs() on the submit host, where CRABClient exists.
    for species in SPECIES:
        for block in range(BLOCKS_PER_SPECIES):
            tag = "{0}_{1}_block{2}".format(species, VERSION, block)
            name = os.path.join(here, "crab_prod_{0}.py".format(tag.replace(species + "_", "")))
            body = header + "config = _make()['{0}']['{1}']\n".format(species, tag)
            with open(name, "w") as f:
                f.write(body)
            print(name)
