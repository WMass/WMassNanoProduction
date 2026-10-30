import os

from CRABClient.UserUtilities import config as crab_config

# MuKPi gun pilot: 3 species x 2 jobs x 5000 events, PrivateMC, no HLT,
# RECO-level output (GEN-SIM-RECO), staged to T3_US_MIT with DAS publication.

EVENTS_PER_JOB = 1000
JOBS_PER_SPECIES = 2
VERSION = "v4_pilot_20261030"
SPECIES = ["MuGun", "PiGun", "KGun"]
CAMPAIGN = "v4_pilot"


def make_config(species):
    if species not in SPECIES:
        raise RuntimeError("unknown species: {0}".format(species))
    here = os.path.dirname(os.path.abspath(__file__))
    primary = {"MuGun": "SingleMuGun_Pt0p01To150_Eta2p4",
               "PiGun": "SinglePiGun_Pt0p01To150_Eta2p4",
               "KGun": "SingleKGun_Pt0p01To150_Eta2p4"}[species]
    tag = "{0}_{1}".format(species, VERSION)
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
        "jobOffset=0",
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
    cfg.Data.totalUnits = EVENTS_PER_JOB * JOBS_PER_SPECIES
    cfg.Data.lumisPerFile = 1
    cfg.Data.publication = False
    cfg.Data.publishDBS = "phys03"
    cfg.Data.outputPrimaryDataset = primary
    cfg.Data.outLFNDirBase = "/store/group/zmass/MuKPiGun_UL16_Premix_{0}/{1}".format(CAMPAIGN, tag)

    cfg.Site.storageSite = "T3_US_MIT"
    return cfg
