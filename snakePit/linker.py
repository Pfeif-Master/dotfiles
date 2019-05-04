import sys
import os
import copy
import subprocess

if len(sys.argv) != 4:
    print("bad arguments: arg[1]: source; arg[2]: targ; arg[3]: t|r")
    quit()

source = sys.argv[1]
targ = sys.argv[2]
if sys.argv[3] == "t":
    dryrun = True
elif sys.argv[3] == "r":
    dryrun = False
    from loadingBar import printBar
else:
    print("arg[3] must be t (dryrun) or r (real run)")
    print(sys.argv[3])
    quit()


#get list of dot files
srcs = os.listdir(source);
justName = copy.deepcopy(srcs);
i = 0
#complete rel path
while i < len(srcs):
    srcs[i] = source + srcs[i]
    i += 1

i = 0
while i < len(srcs):
    RMcommand = "rm -r" + " " + targ + "/" + justName[i];
    command = "ln -srf " + srcs[i] + " " + targ;
    msg = "Linking " + srcs[i] + " in " + targ;
    if dryrun:
        print("Dryrun mode{ " + command + " }");
    else:
        #subprocess.check_call(RMcommand.split())
        printBar(msg, i, len(srcs) - 1);
        os.system(RMcommand)
        os.system(command)
    i += 1;
