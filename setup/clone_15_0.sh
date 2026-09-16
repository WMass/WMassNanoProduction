#!/bin/bash
# CMSSW_15_0_19_patch2 (el9) area with the WMass NanoAOD branch and this package.
# Usage: bash <(curl -s https://raw.githubusercontent.com/WMass/WMassNanoProduction/WmassNanoProd_15_0_19_patch2/setup/clone_15_0.sh)
set -e
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=el9_amd64_gcc12
cmssw=15_0_19_patch2
scramv1 project CMSSW_$cmssw
cd CMSSW_$cmssw/src
eval `scramv1 runtime -sh`
git cms-init
git cms-checkout-topic -u WMass:WmassNanoProd_$cmssw
git cms-checkdeps -a
path=Configuration/WMassNanoProduction
git clone -b WmassNanoProd_$cmssw git@github.com:WMass/WMassNanoProduction.git $path
scram b -j8

cd $path
