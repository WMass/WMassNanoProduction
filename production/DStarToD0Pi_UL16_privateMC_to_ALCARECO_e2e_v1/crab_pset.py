from __future__ import print_function

import os

import FWCore.ParameterSet.Config as cms


here = os.path.dirname(os.path.abspath(__file__))
reference = os.path.join(
    here, "reference", "DStarToD0Pi_D0KPi_TuneCP5_GENSIM_cfg.py"
)

try:
    execfile(reference, globals())  # noqa: F821 - CMSSW 10 uses Python 2.
except NameError:
    with open(reference, "rb") as handle:
        exec(compile(handle.read(), reference, "exec"), globals())

process.options.numberOfThreads = cms.untracked.uint32(4)
process.options.numberOfStreams = cms.untracked.uint32(0)
