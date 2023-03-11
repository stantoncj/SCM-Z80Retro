#!/bin/bash
#
# Compare build against pre-built hex files to unit test the scw2sjasm code
# Note that the default build in 1.3 from the distribution zip is SC516

dist_fn=SCM-F1-2022-02-27-Monitor-v130-BIOS-v130-SC516
dist_dir=../Builds

if [ -z $1 ]; then
  builddir=build
else
  builddir=$1
fi
echo "Comparing $dist_fn to $builddir/SCMonitor.bin"

# Make the hex dump of the distribution into a binary
srec_cat $dist_dir/$dist_fn.hex -Intel -o ./build/$dist_fn.bin -binary

# Compare and dump the diff, ignore any FF->00 padding differences
cmp -l ./build/$dist_fn.bin ./build/SCMonitor.bin | gawk '{if(0$2 != "FF" && 0$3 != "00")printf "%08X %02X %02X\n", $1, strtonum(0$2), strtonum(0$3)}' > ./build/diff_scm.txt

# Is there a diff?
if [ -s ./build/diff_scm.txt ]; then
  echo -e "\033[0;31mBinary differences!  See ./build/diff_scm.txt\033[0m"  # in red text!
else
  echo -e "\033[0;32mW00t! - Binary equivalent!\033[0m"
fi

# EOF