#!/usr/bin/env python3

import argparse
import os
import subprocess
import string
import logging
import hashlib
import getpass
import sys
import datetime
import json
import re

def fillTemplatedFile(template_file_name, out_file_name, template_dict):
    with open(template_file_name, "r") as templateFile:
        source = string.Template(templateFile.read())
        result = source.substitute(template_dict)
    with open(out_file_name, "w") as outFile:
        outFile.write(result)

_CAMPAIGN_SH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "campaign.sh")

def campaignTable(function, *args):
    """scripts/campaign.sh is the one table of the campaigns (detection, era,
    global tag, customise, label); ask it."""
    return subprocess.check_output(["bash", _CAMPAIGN_SH, function, *args]).decode().strip()

def campaignFromInput(das_path):
    """The campaign of a dataset (--campaign overrides it), as scripts/campaign.sh derives it."""
    if args.campaign:
        return args.campaign
    return campaignTable("campaign_from_input", das_path)

def isAlcaReco(das_path):
    """An AlCaReco input: the AlCaReco nano (makeNanoV15AlcaReco*.sh) refits its muon tracks."""
    return das_path.split(" ")[0].endswith("/ALCARECO")

def isMCInput(das_path):
    """MC: a *SIM tier (of the last dataset of the line: a weight-fix line ends with the MINIAODSIM), or an
    ALCARECO of an MC campaign (the processed datasets of data start with the run era, Run2016F-...)."""
    return "SIM" in das_path[-3:] or (isAlcaReco(das_path) and not re.match(r"Run20\d\d", das_path.split("/")[2]))

def alcarecoSkim(das_path):
    """The AlCaReco skim of the input (TkAlJpsiMuMu, TkAlUpsilonMuMu), whose tracks the AlCaReco nano refits."""
    return campaignTable("alcareco_skim_of", das_path.split(" ")[0])

def nameFromInput(das_path, tagAndProbe=False):
    """Data<label> / MC<label> (+TagAndProbe); 2016 keeps its historical order
    (MCTagAndProbePostVFP)."""
    campaign = campaignFromInput(das_path)
    label = "MC" if isMCInput(das_path) else "Data"
    tnp = "TagAndProbe" if tagAndProbe else ""
    if campaign.startswith("2016"):
        return label + tnp + campaignTable("label_of", campaign)
    return label + campaignTable("label_of", campaign) + tnp

def gitHash(path):
    return subprocess.check_output(['git', 'log', '-1', '--format="%H"'], cwd=path).decode('UTF-8')

def gitDiff(path):
    return subprocess.check_output(['git', 'diff',], cwd=path).decode('UTF-8')

def scriptCall():
    return ' '.join(sys.argv)

# Crab submit doesn't like names over 100 chars long
# Replace last 5 characters with hash in case of duplicates after truncation
def hashedName(name, bits=5):
    if len(name) < 100:
        return name
    
    h = hashlib.sha256(name.encode('utf-8')).hexdigest()
    return name[:(100-bits)] + h[:bits]

def makeConfig(path, era, das, config_name, nThreads, isData, tagAndProbe):
    # one script per (nano/AlCaReco nano, data/MC, nano/tag-and-probe); the campaign selects the
    # conditions inside it, the AlCaReco scripts also the skim
    script = "./scripts/make%s%s%s%s.sh" % (era, "AlcaReco" if isAlcaReco(das) else "", "Data" if isData else "MC",
                                            "TagAndProbe" if tagAndProbe else "")
    cmd = [script, *das.split(" "), config_name, str(nThreads), campaignFromInput(das)]
    print(cmd)
    subprocess.call(cmd, cwd=path)

def makeWhitelist(das):
    out = subprocess.check_output([f'dasgoclient --query="site dataset={das}" -json'], shell=True)
    res = json.loads(out)
    sort = sorted(res, key = lambda x: float(str(x[u'site'][0][u'block_completion']).replace("%", "")), reverse=True)
    whitelist = []
    for r in sort:
        site = r[u'site'][0]
        if (len(whitelist) == 0 or float(str(site[u'block_completion']).strip("%")) > 75) and site[u'kind'] == u'DISK':
            whitelist.append(str(site[u'name']))
    whitelist_text = f"config.Site.whitelist = {whitelist}"
    whitelist_text += "\nconfig.section_('Debug')\nconfig.Debug.extraJDL = ['+CMS_ALLOW_OVERFLOW=False']"
    return whitelist_text

# CRAB refuses tasks with more jobs than this
_MAX_JOBS_PER_TASK = 10000

def logJobSize(das, eventsPerJob, cpuPerEvent, dbs):
    """Print the job size and, if DAS answers, the number of jobs of the whole dataset (a lumi
    mask or run range makes it smaller)."""
    hours = eventsPerJob*cpuPerEvent/3600.
    msg = "%s: %d events/job at %.3g s CPU/event = %.1f h CPU (%.1f h wall with %d threads at 90%% efficiency)" % (
        das, eventsPerJob, cpuPerEvent, hours, hours/(0.9*args.nThreads), args.nThreads)
    try:
        query = "summary dataset=%s" % das + (" instance=prod/phys03" if dbs == "phys03" else "")
        out = subprocess.check_output(["dasgoclient", "--query", query], stderr=subprocess.DEVNULL)
        nevents = json.loads(out)[0]["nevents"]
        njobs = -(-nevents//eventsPerJob)
        msg += "; dataset %d events, at most ~%d jobs" % (nevents, njobs)
        if njobs > _MAX_JOBS_PER_TASK:
            logging.warning("%s: ~%d jobs, more than CRAB's %d per task: raise --cpuHoursPerJob or split the "
                            "dataset with --runRange" % (das, njobs, _MAX_JOBS_PER_TASK))
    except Exception:
        pass
    logging.info(msg)

def submitCrab(outfile, history_file, dryRun):
    # run crab from the submit-file directory without changing this process's working
    # directory (an os.chdir here broke relative paths of the next input file)
    submit_dir = os.path.dirname(outfile)
    command = ["crab", "submit", outfile]
    if dryRun:
        command.insert(0, "echo")
    output = ["\nRunning command: %s" % " ".join(command)]
    try:
        out = subprocess.check_output(command, cwd = submit_dir).decode("UTF-8")
        sys.stdout.write(out)
    except subprocess.CalledProcessError as e:
        out = "--> Failed to submit file %s" % outfile
        logging.warning(out)
    output.append(out)
    with open(history_file, "a") as f:
        f.write("\n".join(output))

def writeHistory(path, history_file, inputFile):
    cmssw_dir = os.environ["CMSSW_BASE"]+"/src"
    # append: a second submission from the same input list on the same day must not
    # overwrite the record of the first
    with open(history_file, "a") as f:
        f.write("Submit log for inputs: %s\n" % inputFile)
        f.write("Auto-generated with command %s\n" % scriptCall())
        f.write("Script ran at %s\n" % str(datetime.datetime.now()))
        f.write("Git hash of scripts is %s" % gitHash(path))
        f.write("Git hash of CMSSW is %s\n" % gitHash(cmssw_dir))
        f.write("Git diff of scripts is \n%s\n" % gitDiff(path))
        f.write("Git diff of CMSSW is \n%s\n" % gitDiff(cmssw_dir))
        f.write("-"*80+"\n")

def makeSubmitFiles(inputFile, nThreads, submit, doConfig, dryRun, match_expr, version, storage, site):
    path = os.environ['CMSSW_BASE']+"/src/Configuration/WMassNanoProduction"
    if not os.path.isfile(inputFile):
        raise ValueError("Could not open file %s" % inputFile)
    inputs = [i.strip() for i in open(inputFile).readlines() if i.strip() and not i.strip().startswith("#")]

    if not inputs:
        raise RuntimeError("The input dataset %s is empty" % input_path)
    
    fname = inputFile.split("/")[-1].split(".")[0]
    date =  datetime.datetime.now().strftime("%y_%m_%d")
    history_file = "/".join([path, "history","_".join([fname, date, "submit{0}{1}_{2}.txt".format(*submit, getpass.getuser())])])
    if submit[0] != 0:
        writeHistory(path, history_file, inputFile)

    era = args.era

    for i, das in enumerate(inputs):
        if match_expr and not re.match(match_expr, das):
            continue

        alcareco = isAlcaReco(das)
        if alcareco and args.tagAndProbe:
            raise ValueError("%s: the tag-and-probe nano runs on AOD, not on an AlCaReco" % das)
        # the AlCaReco nano: the skim in the config and output names, NanoV15TkAlJpsiMuMuDataPostVFP
        name = era + (alcarecoSkim(das) if alcareco else "") + nameFromInput(das, args.tagAndProbe)
        isData = not isMCInput(das)
        config_name = name 
        das_split = das.split(" ")
        if len(das_split) > 1:
            config_name += "_weightFix"
        # a per-sample fix (scripts/campaign.sh sample_tag/sample_customise) gets its own config
        sampleTag = "" if isData else campaignTable("sample_tag", das_split[0])
        if sampleTag:
            config_name += "_" + sampleTag

        if doConfig and config_name not in configsMade:
            makeConfig(path, era, das, config_name, nThreads, isData, args.tagAndProbe)
            configsMade.append(config_name)

        config_name += "_cfg.py"
        config_path = "/".join([path, "configs", config_name])
        if not os.path.isfile(config_path):
            raise RuntimeError("Config file %s does not exist. Rerun with --makeConfig" % config_path)

        outname = "_".join(das.split("/")[1:(3 if isData else 2)])
        if isData:
            if args.campaign:
                # a campaign that shares its datasets with another one (2025LowPU)
                outname += "_" + args.campaign
            if args.tagAndProbe:
                outname += "_TagAndProbe"
        else:
            if alcareco:
                outname += "_" + alcarecoSkim(das)
            outname += "_"+nameFromInput(das)
            # check if it is extension samples, where we need to add the extension number to the label
            matched = re.search("_ext(\d+)", das.split('/')[2])
            if matched:
                outname += matched.group(0)
            if len(das_split) > 1:
                name += "WeightFix"
                outname += "WeightFix"
            if args.tagAndProbe:
                outname += "TagAndProbe"

        das = das_split[0]

        run_match = re.search("(Run20\d\d[A-Z])", das)
        if isData and run_match:
            name = name.replace("Data", f"{run_match.group(1)}Data")

        requestName = hashedName("_".join([outname, version]))
        outfile = "/".join([path, "crab_submit", "submit"+outname+".py"])
        
        # job size: EventAwareLumiBased with the events that fill --cpuHoursPerJob CPU hours at the
        # campaign's grid CPU time per event (scripts/campaign.sh cpu_per_event_of); --eventsPerJob
        # sets the events directly, --lumisPerJob (data) and --filesPerJob (MC) switch to fixed
        # LumiBased / FileBased jobs
        if isData and args.lumisPerJob > 0:
            splitting, units = "LumiBased", args.lumisPerJob
        elif not isData and args.filesPerJob > 0:
            splitting, units = "FileBased", args.filesPerJob
        elif args.tagAndProbe and args.eventsPerJob <= 0:
            # the tag-and-probe nano (PAT from AOD, no CVH refit) is not timed: fixed jobs as before
            splitting, units = ("LumiBased", 10*args.nThreads) if isData else ("FileBased", 2*args.nThreads)
        else:
            splitting = "EventAwareLumiBased"
            cpuPerEvent = float(campaignTable("cpu_per_event_of", campaignFromInput(das), "data" if isData else "mc",
                                              "alcareco" if alcareco else "nano"))
            units = args.eventsPerJob if args.eventsPerJob > 0 else max(1000, int(round(args.cpuHoursPerJob*3600/cpuPerEvent, -3)))
            logJobSize(das, units, cpuPerEvent, "phys03" if len(das_split) > 1 else "global")

        extra = ""
        runRange = args.runRange or (campaignTable("run_range_of", campaignFromInput(das)) if isData else "")
        if isData and runRange:
            extra += f"config.Data.runRange = '{runRange}'\n"
        lumiMask = args.lumiMask or ((campaignTable("dataset_lumi_mask_of", das)
                                      or campaignTable("lumi_mask_of", campaignFromInput(das))) if isData else "")
        if isData and lumiMask:
            extra += f"config.Data.lumiMask = '{lumiMask}'\n"

        fillTemplatedFile("/".join([path, "Templates", "submitCrab%sTemplate" % era]),
            outfile, 
            {"era" : name, "splitting" : splitting,
                "threads" : nThreads, "memory" : nThreads*2000, "name" : requestName, 
                "input" : das, "config" : config_name, "units" : units,
                "dbs" : "global" if len(das_split) == 1 else "phys03",
                "useParent" : "False" if len(das_split) == 1 else "True",
                "version" : version, "outstorage" : storage, "site" : site,
                "extra" : extra
            })
        logging.info("Wrote config file %s" % "/".join(outfile.split("/")[-2:]))
        if submit[0] >= 1 and i % submit[0] == (submit[1]-1):
            submitCrab(outfile, history_file, dryRun)

parser = argparse.ArgumentParser()
parser.add_argument('-v', '--version', type=str, required=True, help='Version label to append to output tag')
parser.add_argument('--dryRun', action='store_true', help='print submit commands rather than executing them')
parser.add_argument('--makeConfig', action='store_true', help='run cmsDriver to build config file')
parser.add_argument('--tagAndProbe', action='store_true', help='Submit tag and probe nano')
parser.add_argument('-i', '--inputFiles', required=True, type=str, nargs='*', help='inputFiles to process')
parser.add_argument('-m', '--filterExpr', default='', type=str, help='Expression to filter out files from the input list')
parser.add_argument('-s', '--submit', type=int, nargs=2, help='Number of splits to make, which split to submit' \
        ' ex: 1 1 for all, 2 1 for every second file', default=(0,0))
parser.add_argument('-j', '--nThreads', type=int, default=4,
    help="number of threads (make sure its consistent if you're not regenerating configs); the CVH refit is multithreaded in CMSSW_15_0")
parser.add_argument('--cpuHoursPerJob', type=float, default=8,
    help="CPU hours per job (all threads together): the events per job are this over the campaign's grid "
         "CPU time per event (scripts/campaign.sh cpu_per_event_of). Default 8 h, ~2.2 h wall with 4 threads")
parser.add_argument('--eventsPerJob', type=int, default=0,
    help='events per job (EventAwareLumiBased) instead of the CPU budget')
parser.add_argument('--lumisPerJob', type=int, default=0,
    help='fixed lumi sections per job for data (LumiBased) instead of events, e.g. for recovery tasks')
parser.add_argument('--filesPerJob', type=int, default=0,
    help='fixed input files per job for MC (FileBased) instead of events')
parser.add_argument('--era', type=str, default='NanoV15', help='production label: selects scripts/make<era><Sample>.sh and Templates/submitCrab<era>Template')
parser.add_argument('--storage', default='/store/group/cmst3/group/wmass/w-mass-13TeV/NanoAOD', type=str, help='Storage path of output Ntuples(default CERN storage)')
parser.add_argument('--site', default='T2_CH_CERN', type=str, help='Site of the output storage(default:T2_CH_CERN)')
parser.add_argument('--campaign', default='', type=str, help='campaign of every input (scripts/campaign.sh), instead of deriving it from the dataset name; needed for 2025LowPU, which shares its datasets with 2025')
parser.add_argument('--runRange', default='', type=str, help='CRAB run range for data (default: the campaign\'s, scripts/campaign.sh run_range_of)')
parser.add_argument('--lumiMask', default='', type=str, help='CRAB lumi mask (JSON file or URL) for data')

args = parser.parse_args()
if args.submit[1] > args.submit[0] or (args.submit[1] == 0 and args.submit[1] != args.submit[0]):
    raise ValueError("Second argument of --submit must be non-zero and less than first argument. " \
                        " Instead found %i %i" % args.submit)

logging.basicConfig(level=logging.INFO)

configsMade = []
for i in args.inputFiles:
    makeSubmitFiles(i, args.nThreads, args.submit, args.makeConfig, args.dryRun, args.filterExpr, args.version, args.storage, args.site)

