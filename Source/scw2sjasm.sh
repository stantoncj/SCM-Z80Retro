# scw2sjasm.sh - modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to sjasmplus directives
#
# Created to allow build of SCWorkshop files on OSX in Microsoft Code
# Christian Stanton 2023
#
# Notes and Detailed transforms can be found in scw2sjam.awk

find . -type f -name '*.asm' -exec gawk -i inplace -v main="./!Main.asm" -f ./scw2sjasm.awk '{}' \;

#EOF