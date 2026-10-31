# Publication smoke round for the 150M production (issue WMass/WMassNanoProduction#38).
# 3 species x 1 task. Each task: 2 jobs x 2,500 events = 5,000 events, block 1
# (jobOffset = 2000 jobs), 4 cores / 8 GB, ASO to T3_US_MIT, DAS publication
# (phys03) ON. This is the pre-merge DAS+seeds+lumi validation lane defined in
# the #38 planning matrix: it exists to verify what no pilot ever verified --
# publication of scriptExe-shaped output, species-independent RNG ensembles
# (v2 seeds stride), and one-lumi-per-job bookkeeping.

import os

EVENTS_PER_JOB = 2500
BLOCK_INDEX = 1
JOBS_PER_TASK = 2
VERSION = "v2_smoke_20261031"
CAMPAIGN = "prod_v2_publication_smoke"
SPECIES = ["MuGun", "PiGun", "KGun"]


def make_configs():
    from CRABClient.UserUtilities import config as crab_config

    cfgs = {}
    here = os.path.dirname(os.path.abspath(__file__))
    for species in SPECIES:
        primary = {"MuGun": "SingleMuGun_Pt0p01To150_Eta2p4",
                   "PiGun": "SinglePiGun_Pt0p01To150_Eta2p4",
                   "KGun": "SingleKGun_Pt0p01To150_Eta2p4"}[species]
        tag = "{0}_{1}_block{2}".format(species, VERSION, BLOCK_INDEX)
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
            "jobOffset={0}".format(BLOCK_INDEX * 2000),  # block 1 -> jobs 2001-2002
        ]
        cfg.JobType.inputFiles = [os.path.join(here, "payload.tar.gz")]
        cfg.JobType.disableAutomaticOutputCollection = True
        cfg.JobType.outputFiles = ["{0}_ALCARECO.root".format(species)]
# WMCore Lexicon: ALL output LFNs of a publishing task must end in .root -
# monitoring.json trips it at submit time (measured, SUBMITREFUSED 2026-10-31).
# run_chain.sh echoes the monitoring block into the job log (transferLogs=True),
# so accounting continues from logs instead.
        cfg.JobType.allowUndistributedCMSSW = True
        cfg.JobType.maxMemoryMB = 8000
        cfg.JobType.maxJobRuntimeMin = 600
        cfg.JobType.numCores = 4
        cfg.Data.splitting = "EventBased"
        cfg.Data.unitsPerJob = EVENTS_PER_JOB
        cfg.Data.totalUnits = EVENTS_PER_JOB * JOBS_PER_TASK
        cfg.Data.lumisPerFile = 1
        cfg.Data.publication = True
        cfg.Data.publishDBS = "phys03"
        cfg.Data.outputPrimaryDataset = primary
        cfg.Data.outputDatasetTag = tag
        cfg.Data.outLFNDirBase = "/store/group/zmass/MuKPiGun_UL16_Premix_{0}/{1}".format(CAMPAIGN, tag)
        cfg.Site.storageSite = "T3_US_MIT"
        cfgs[tag] = cfg
    return cfgs


if __name__ == "__main__":
    here = os.path.dirname(os.path.abspath(__file__))
    header = ("import os, sys\n"
              "sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))\n"
              "from crab_smoke_guns import make_configs as _make\n")
    for tag in ("{0}_{1}_block{2}".format(s, VERSION, BLOCK_INDEX) for s in SPECIES):
        name = os.path.join(here, "crab_smoke_{0}.py".format(tag))
        body = header + "config = _make()['{0}']\n".format(tag)
        with open(name, "w") as f:
            f.write(body)
        print(name)
