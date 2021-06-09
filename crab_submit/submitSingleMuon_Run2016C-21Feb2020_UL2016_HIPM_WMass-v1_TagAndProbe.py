from CRABClient.UserUtilities import config
config = config()

config.General.requestName = 'SingleMuon_Run2016C-21Feb2020_UL2016_HIPM_WMass-v1_TagAndProbe'
config.General.workArea = 'crab_projects'
config.General.transferOutputs = True
config.General.transferLogs = True

config.JobType.numCores = 8
config.JobType.maxMemoryMB = 16000
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = '../configs/NanoV8DataPreVFP_TagAndProbe_cfg.py'
config.JobType.allowUndistributedCMSSW = True

config.Data.inputDataset = '/SingleMuon/Run2016C-21Feb2020_UL2016_HIPM_WMass-v1/AOD'

config.Data.splitting = 'LumiBased'
config.Data.unitsPerJob = 100
config.Data.outLFNDirBase = '/store/group/cmst3/group/wmass/w-mass-13TeV/NanoAOD' 
config.Data.publication = True
config.Data.outputDatasetTag = 'NanoV8DataPreVFP_TagAndProbe'
config.Data.inputDBS = 'global'
config.Data.useParent = False

config.Site.storageSite = 'T2_CH_CERN'

