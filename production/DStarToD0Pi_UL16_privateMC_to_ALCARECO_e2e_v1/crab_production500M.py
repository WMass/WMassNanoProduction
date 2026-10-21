import os

from CRABClient.UserUtilities import config as crab_config


EVENTS_PER_JOB = 12500
EVENTS_PER_BLOCK = 100000000
JOBS_PER_BLOCK = EVENTS_PER_BLOCK // EVENTS_PER_JOB
NUMBER_OF_BLOCKS = 5
VERSION = "v1_20260809"


def make_config(block):
    if block < 1 or block > NUMBER_OF_BLOCKS:
        raise RuntimeError("production block must be in [1, {0}]".format(NUMBER_OF_BLOCKS))

    here = os.path.dirname(os.path.abspath(__file__))
    job_offset = (block - 1) * JOBS_PER_BLOCK
    tag = "prod500M_b{0}_{1}".format(block, VERSION)
    cfg = crab_config()

    cfg.General.requestName = "DStarToD0Pi_UL16_privateMCToALCA_{0}".format(tag)
    cfg.General.workArea = os.path.join(here, "crab_projects")
    cfg.General.transferOutputs = True
    cfg.General.transferLogs = True

    cfg.JobType.pluginName = "PrivateMC"
    cfg.JobType.psetName = os.path.join(here, "crab_pset.py")
    cfg.JobType.scriptExe = os.path.join(here, "run_chain.sh")
    cfg.JobType.scriptArgs = [
        "events={0}".format(EVENTS_PER_JOB),
        "jobOffset={0}".format(job_offset),
    ]
    cfg.JobType.inputFiles = [os.path.join(here, "payload.tar.gz")]
    cfg.JobType.disableAutomaticOutputCollection = True
    cfg.JobType.outputFiles = [
        "TkAlDstToD0Pi.root",
        "dst_alca_threshold_scan_hlt.root",
        "monitoring.json",
    ]
    cfg.JobType.allowUndistributedCMSSW = True
    cfg.JobType.maxMemoryMB = 5000
    cfg.JobType.maxJobRuntimeMin = 600
    cfg.JobType.numCores = 4

    cfg.Data.splitting = "EventBased"
    cfg.Data.unitsPerJob = EVENTS_PER_JOB
    cfg.Data.totalUnits = EVENTS_PER_BLOCK
    cfg.Data.lumisPerFile = 1
    cfg.Data.publication = False
    cfg.Data.outputPrimaryDataset = (
        "DStarToD0Pi_D0KPi_TuneCP5_13TeV_pythia8_evtgen"
    )
    cfg.Data.outLFNDirBase = (
        "/store/group/cmst3/group/wmass/MC/"
        "DStarToD0Pi_D0KPi_TuneCP5_UL16/"
        "privateMCToALCARECO_e2e_v1_{0}".format(tag)
    )

    cfg.Site.storageSite = "T2_CH_CERN"
    return cfg

