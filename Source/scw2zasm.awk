# scw2zasm - v1.0 - modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to zasm code
#
# Christian Stanton - written to be able to build SCM on OSX rather than install on SCW on Windows
#                   - Kudos to Steve Cousins for SCWorkshop, SCMonitor and his help understanding SCW directives

# Version 1.0
# Built and tested with:
# GNU Awk 5.2.1, API 3.2, PMA Avon 8-g1, (GNU MPFR 4.2.0, GNU MP 6.2.1)
# SjASMPlus Z80 Cross-Assembler v1.20.1 (https://github.com/z00m128/sjasmplus)
# zasm - 8080/z80/z180 assembler (c) 1994 - 2021 Günter Woigk. version 4.4.7, 2021-02-02, for Unix-MacOSX. https://k1.spdns.de/Develop/Projects/zasm/Distributions/
#        from here: (listed as 4.4.10) - https://k1.spdns.de/Develop/Projects/zasm/Distributions/zasm-4.4.10-macos10.12.zip
# SCW036_SCM130_20220325 - From: https://smallcomputercentral.com/small-computer-monitor-v1-3/

# Requirements to run: (for OSX)
# Install brew (see https://brew.sh/)
# Install gawk - brew install gawk (you cannot use the distributed OSX awk which is and old distro and missing essential commands)
# Install zasm -
# If commands from Terminal refuse to run, you need to run from Finder once and then allow execution in Control Panel


# Detailed transforms

#================================================================================
#DEFINE
#================================================================================

#SCW example: (note the lack of a value)
#DEFINE     xBUILD_AS_COM_FILE  ;Build as CP/M style .COM file (not as ROM)

#zasm equivalent: (no defines without a value, insert dummy value)
#DEFINE      xBUILD_AS_COM_FILE 1 ;Build as CP/M style .COM file (not as ROM)

# transform - insert dummy value if no value 
/^#DEFINE/ {
if((length($3) > 0 && index($3,";") > 0) || (NF == 2)){gsub(/\r/,"",$2); $2 = $2 " 1 "};
if(index($3,"\"")>0){$1=""; $2 = $2 " defm"};
print; next} 

#================================================================================
#INCLUDE
#================================================================================

# SCW example:
#INCLUDE    BIOS\Framework\Devices\StatusLED.asm

#zasm equivalent: include quotes
#INCLUDE "BIOS/Framework/Devices/StatusLED.asm"

# transform - quote path, switch backslash to slash
/^#INCLUDE/ {gsub(/\\/,"/"); if(index($2,"\"") == 0){gsub(/\r/,"",$2); s="./"; for(i=gsub(/\//,"/",FILENAME);i>1;i--){s=s "../";};$2 = "\"" s $2 "\""}; print; next} 

#================================================================================
#IF
#ELSE
#ENDIF
#IFDEF
#IFNDEF
#================================================================================

#SCW example:
#IFDEF      IncludeMonitor

#zasm equivalent: use defined() funtion
#IF     defined(IncludeMonitor)

# There is no IFDEF, use IF 1=label
/^#IFDEF(.+)/ {gsub(/#IFDEF/,"#IF",$1); gsub(/\r/,"",$2); $2 = "defined(" $2 ")";  print; next}
/^#IFNDEF(.+)/ {gsub(/#IFNDEF/,"#IF",$1); gsub(/\r/,"",$2); $2 = "!defined(" $2 ")";  print; next}


#================================================================================
#DEFAULT ACTION 
#================================================================================
# comment this out to only print modified lines

{print}

#================================================================================

#EOF