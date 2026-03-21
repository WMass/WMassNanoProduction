from CRABClient.UserUtilities import config
config = config()

config.General.requestName = 'ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8_MC2018TagAndProbe_1'
config.General.workArea = 'crab_projects'
config.General.transferOutputs = True
config.General.transferLogs = True

config.JobType.numCores = 8
config.JobType.maxMemoryMB = 16000
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = '../configs/NanoV9MC2018TagAndProbe_cfg.py'
config.JobType.allowUndistributedCMSSW = True

config.Data.inputDataset = '/ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8/RunIISummer20UL18RECO-106X_upgrade2018_realistic_v11_L1v1-v1/AODSIM'

config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 16
config.Data.outLFNDirBase = '/eos/cms/store/group/cmst3/group/wmass/w-mass-13TeV/NanoAOD_TnP_v9/Tnp_NanoV9/'
config.Data.publication = True
config.Data.outputDatasetTag = 'NanoV9MC2018TagAndProbe_1'
config.Data.inputDBS = 'global'
config.Data.useParent = False

config.Site.storageSite = 'T2_CH_CERN'
