#!/bin/bash

# SCWorkshop allows non-linear code output, sjasmplus requires linear
# The scw2sjasm outputs multiple files which then need to be assembled
# in the correct .ORG locations
#
# The data segments are built, but not used in the final code assembly
#

if [ -z $1 ]; then
  builddir="build"
else
  builddir="$1"
fi

if [ -z $2 ]; then
  target="bin"  # use either "bin" or "hex", default bin
else
  target="$2"
fi
echo "Linking in ./$builddir to $target"

# Kill the stray code segment in SCM - this is a kludge
#rm ./$builddir/code*FE00.bin 2> /dev/null

# Build all of the seperate bin files into a single bin with the correct offsets
find ./$builddir/code_output_*.bin | sort > ./$builddir/build.txt
gawk -i inplace "// {s=substr(\$0,index(\$0,\"t_\")+2,4); print \$0 \" -binary -offset 0x\" s; next}\
  ENDFILE {if(\"$target\"==\"bin\") {print \"-o ./$builddir/SCMonitor.bin -binary\"} \
           else {print \"--line-length=44 -o ./$builddir/SCMonitor.hex -Intel\"}}"\
  ./$builddir/build.txt
srec_cat @./$builddir/build.txt

# EOF