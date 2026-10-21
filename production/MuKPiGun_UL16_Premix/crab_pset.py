# Dummy PSet for CRAB PrivateMC validation only; the real chain is driven by
# run_chain.sh via scriptExe (cf. the D* UL16 e2e pattern).
import FWCore.ParameterSet.Config as cms

process = cms.Process("MuKPiGunChainStub")
process.source = cms.Source("EmptySource")
process.maxEvents = cms.untracked.PSet(input=cms.untracked.int32(1))
process.options = cms.untracked.PSet(numberOfThreads=cms.untracked.uint32(8))
