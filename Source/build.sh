# scw2sjasm.sh - modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to sjasmplus directives
#
# Christian Stanton - 2023

# Detailed transforms can be found in scw2sjam.awk

# for testing, restore from repository
cp -pR ../../SCW036_SCM130_20220325/SCMonitor/Source/ .

# run transforms
find . -type f -name '*.asm' -exec gawk -i inplace -v main="./!Main.asm" -f ./scw2sjasm.awk '{}' \;

# compile
if [ $? -eq 0 ]; 
then
sjasmplus --lst '!Main.asm'
fi

# convert to .hex file, length 44 to match existing builds
if [ $? -eq 0 ]; 
then
srec_cat '!Main.bin' -binary -offset 0x0000 -line-length=44 -o '!Main.hex' -Intel
fi

#EOF