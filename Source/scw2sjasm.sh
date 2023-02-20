# scw2sjasm.sh - Christian Stanton 2023
#
# modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to sjasmplus directives

# What tokens are actually in use?
# find . -type f -name '*.asm' -exec awk '/^(#[^\s\\]+)/{print $1;}' '{}' \; | sort | uniq

# This a static list based on SCM v1.3 (i.e. output from above run in /SCMonitor/Source )

#DEFINE
#ELSE
#ENDIF
#ENDIF
#IF
#IFDEF
#IFNDEF
#INCLUDE
#INSERTHEX
#TARGET
#UNDEFINE

# Detailed transforms can be found in scw2sjam.awk

find . -type f -name '*.asm' -exec awk -f ./scw2sjasm.awk '{}' \;

#EOF