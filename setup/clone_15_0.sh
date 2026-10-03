#!/bin/bash
# CMSSW_15_0_19_patch2 (el9) area with the WMass NanoAOD branch and this package.
# Usage: bash <(curl -s https://raw.githubusercontent.com/WMass/WMassNanoProduction/main/setup/clone_15_0.sh)
# cmssw: WMass/cmssw branch WmassNanoProd_15_0_19_patch2 (the stable nano v15 branch, PR #48);
# this package: WMass/WMassNanoProduction main. Both can be overridden (e.g. to test a PR
# branch): CMSSW_TOPIC=user:branch PROD_REPO=<git url> PROD_BRANCH=<branch>.
#
# Only the packages the branch modifies are checked out and built, NOT their dependents
# (no `git cms-checkdeps -a`): the release headers it changes are compatible with the
# release libraries the nano job loads (MagneticField.h: a static constant only, the
# inline function unchanged; SimG4Core Field.h / GeometryProducer.h: classes built only
# by the checked-out SimG4Core packages; TrackProducerBase.icc: a template instantiated
# with local symbols in every library), and the ~260 dependent packages would push the
# CRAB sandbox far beyond its 120 MB limit.
set -e
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=el9_amd64_gcc12
cmssw=15_0_19_patch2
CMSSW_TOPIC=${CMSSW_TOPIC:-WMass:WmassNanoProd_$cmssw}
PROD_REPO=${PROD_REPO:-git@github.com:WMass/WMassNanoProduction.git}
PROD_BRANCH=${PROD_BRANCH:-main}
scramv1 project CMSSW_$cmssw
cd CMSSW_$cmssw/src
eval `scramv1 runtime -sh`
git cms-init
git cms-checkout-topic -u $CMSSW_TOPIC
path=Configuration/WMassNanoProduction
git clone -b $PROD_BRANCH $PROD_REPO $path
scram b -j8

cd $path
echo "Before submitting: scripts/prepareSandbox.sh (field tables, sandbox size)"
