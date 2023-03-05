#!/bin/bash

# SCWorkshop allows non-linear code output, sjasmplus requires linear
# The scw2sjasm outputs multiple files which then need to be assembled
# in the correct .ORG locations
#
# The data segments are built, but not used to assemble the final code
#
# OBS! There is one stray code segment at FE00 (kJumpTab) that needs to be excluded

if [ -z $1 ]; then
  builddir="build"
else
  builddir="$1"
fi
echo "Linking in $builddir"

# Kill the stray code segment in SCM - this is a kludge
rm ./$builddir/code*FE00.bin 2> /dev/null

# Build all of the seperate bin files into a single bin with the correct offsets
# Note there is a byte or two of overlap where the warning has been suppressed
find ./$builddir/code_output_*.bin | sort > ./$builddir/build.txt
gawk -i inplace "// {s=substr(\$0,index(\$0,\"t_\")+2,4); print \$0 \" -binary -offset 0x\" s; next}\
  BEGINFILE {print \"--multiple\"};\
  ENDFILE {print \"--line-length=44 -o ./$builddir/SCMonitor.bin -binary\"}"\
  ./$builddir/build.txt
# for some reason putting the offset 0x0000 file fail to create a full file
# putting it last (but not reversing order!) will work properly
# gawk -i inplace "/0000/ {s=\$0; next;}; /line-length/ {print s \"\\n\" \$0; next;}; {print}" ./Output/build_hex.txt
srec_cat @./$builddir/build.txt