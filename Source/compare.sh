#!/bin/bash
#
# Compare build against pre-built hex files to unit test the scw2sjasm code
# Note that the default build in 1.3 from the distribution zip is SC516
# note, no extension

dist_fn="SCM-F1-2022-02-27-Monitor-v130-BIOS-v130-SC516"

if [ -z $1 ]; then
  builddir="build"
else
  builddir="$1"
fi
echo "Comparing $builddir"

# Make the hex dump of the distribution into a binary
srec_cat ../Builds/$dist_fn.hex -Intel -o ./build/$dist_fn.bin -binary

# Compare and dump the diff
#cmp --print-bytes --verbose ./build/$dist_fn.bin ./build/SCMonitor.bin > ./build/diff_scm.txt
cmp -l ./build/$dist_fn.bin ./build/SCMonitor.bin | gawk '{printf "%08X %02X %02X\n", $1, strtonum(0$2), strtonum(0$3)}' > ./build/diff_scm.txt

# EOF