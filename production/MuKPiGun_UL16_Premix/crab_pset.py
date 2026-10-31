# Dummy PSet for CRAB PrivateMC validation only; the real chain is driven by
# run_chain.sh via scriptExe (cf. the D* UL16 e2e pattern).
import FWCore.ParameterSet.Config as cms

process = cms.Process("MuKPiGunChainStub")
process.source = cms.Source("EmptySource")
process.maxEvents = cms.untracked.PSet(input=cms.untracked.int32(1))
process.options = cms.untracked.PSet(numberOfThreads=cms.untracked.uint32(4))

# PoolOutputModule declarations: CRAB's publication machinery classifies the
# <species>_ALCARECO.root output as an EDM file only when a PoolOutputModule
# for it exists in the PSet (publication-ready hook; the stub never runs).
# Monitoring.json moved out of JobType.outputFiles for the same LFN rule.
for species in ("MuGun", "PiGun", "KGun"):
    setattr(process, "out_" + species,
            cms.OutputModule("PoolOutputModule",
                             fileName=cms.untracked.string(species + "_ALCARECO.root"),
                             dataset=cms.untracked.PSet(
                                 dataTier=cms.untracked.string("ALCARECO"),
                                 filterName=cms.untracked.string(species),
                             )))
process.outpath = cms.EndPath(process.out_MuGun + process.out_PiGun + process.out_KGun)
