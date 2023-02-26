# scw2sjasm.sh - modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to sjasmplus directives
#
# Christian Stanton - 2023

# Detailed transforms can be found in scw2sjam.awk

find . -type f -name '*.asm' -exec gawk -i inplace -v main="./!Main.asm" -f ./scw2zasm.awk '{}' \;

#EOF