# scw2sjasm - v1.0 - modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to sjasmplus code
#
# Christian Stanton - written to be able to build SCM on OSX rather than install on SCW on Windows
#                   - Kudos to Steve Cousins for SCWorkshop, SCMonitor and his help understanding SCW directives

# Version 1.0
# Built and tested with:
# GNU Awk 5.2.1, API 3.2, PMA Avon 8-g1, (GNU MPFR 4.2.0, GNU MP 6.2.1)
# SjASMPlus Z80 Cross-Assembler v1.20.1 (https://github.com/z00m128/sjasmplus)
# SCW036_SCM130_20220325 - From: https://smallcomputercentral.com/small-computer-monitor-v1-3/

# Requirements to run: (for OSX)
# Install brew (see https://brew.sh/)
# Install gawk - brew install gawk (you cannot use the distributed OSX awk which is and old distro and missing essential commands)
# Install sjasmplus - https://github.com/z00m128/sjasmplus/blob/master/INSTALL.md (you may have to install other tools to have this make correctly)
# If commands from Terminal refuse to run, you need to run from Finder once and then allow execution in Control Panel

# Known bugs:
# 
# sjasmplus only compares the first 4 bytes of string constants -> no string constants can be non-unique in left most 4 characters
# this is not a problem in the existing SCM code base
#

# Discover What directives are actually in use:
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

# Detailed transforms

#================================================================================
#DEFINE
#UNDEFINE
#================================================================================

#SCW example: (note the lack of a value)
#DEFINE     xBUILD_AS_COM_FILE  ;Build as CP/M style .COM file (not as ROM)

#sjasmplus equivalent: (whitespace start, note define+ behaves properly with no replacement value )
#	DEFINE+ xBUILD_AS_COM_FILE ;Build as CP/M style .COM file (not as ROM)

# transform - strip #, add tab, changes DEFINE to DEFINE+, quote values so IF compares work correctly, do not double quote or allow null strings
#             for defines longer than 4 bytes that are non-quoted, limit to 4 bytes.  This is a limit in sjasmplus IF string compare
/^#DEFINE/ {gsub(/#DEFINE/,"\tDEFINE+",$1); if(length($3) > 0 && index($3,"\"") == 0 && index($3,";") == 0){ if(length($3)>4){$3=substr($3,1,4);} gsub(/\r/,"",$3); $3="\""$3"\"";} gsub(/""/,"\" \"",$3); print; next} 
/^#UNDEFINE/ {gsub(/#/,"\t",$1); print; next} 

#================================================================================
#IF
#ELSE
#ENDIF
#IFDEF
#IFNDEF
#================================================================================

# These all behave as expected once moved into OP column
# for compares longer than 4 bytes that are non-quoted, limit to 4 bytes.  This is a limit in sjasmplus IF string compare
/^#IF(.+)/ {gsub(/#/,"\t",$1); if(index($4,"\"") && length($4)>=6){$4="\"" substr($4,2,4) "\""} print; next} 
/^#ELSE(.+)/ {gsub(/#/,"\t",$1); print; next} 
/^#ENDIF(.+)/ {gsub(/#/,"\t",$1); print; next}

#================================================================================
#INCLUDE
#================================================================================

# SCW example:
#INCLUDE    BIOS\Framework\Devices\StatusLED.asm

#sjasmplus equivalent: (note whitespace start, unix path seperators)
#   INCLUDE BIOS/Framework/Devices/StatusLED.asm

# transform - strip #, add tab, backslash to slash in filename
/^#INCLUDE/ {gsub(/#/,"\t",$1) gsub(/\\/,"/"); print; next} 

#================================================================================
#INSERTHEX
#================================================================================

# SCW example:
#INSERTHEX  ..\Apps\MSBASIC_adapted_by_GSearle\SCMon_BASIC_code3000_data8000.hex

#sjasmplus equivalent: (NONE!)
# Used to include BASIC/CPM hex into the build ROM.
# Strategy: build a script which finds and converts hex to bin and then use INSERT?

# transform - comment out line
/^#INSERTHEX/ {gsub(/#/,"; #",$1); print; next} 

#================================================================================
#TARGET
#================================================================================

# SCW example:
#TARGET     Simulated_Z80       ;Determines hardware support included

#sjasmplus equivalent: (NONE!)
# Only used as an SCW directive

# transform - comment out line
/^#TARGET/ {gsub(/#/,"; #",$1); print; next}

#================================================================================
# .directives and other misc fixes

#================================================================================

#================================================================================
#.PROC
#================================================================================

# SCW example:
#                         .PROC Z80           ;Select processor for SCWorkshop

#sjasmplus equivalent: (NONE!)
# Only used as an SCW directive

# transform - comment out line
/\.PROC/ {printf ";%s",$0; next}

#================================================================================
#.EQU/.SET
#================================================================================

# SCW example:
#kSIO1:  .EQU 0x80             ;Base address of serial Z80 SIO #1
#kSIO1:  .SET 0x80             ;Base address of serial Z80 SIO #1

# sjasmplus equivalent: Should use = symbol for both

# transform - remove : and replace with =
/\.EQU/ {gsub(/:/,""); gsub(/.EQU/,"="); print; next}
/\.SET/ {gsub(/:/,""); gsub(/.SET/,"="); print; next}

#================================================================================
#.DB with divisor
#================================================================================

# SCW example:
# kaCodeBeg:  .DB  CodeBegin\256  ;0x004E  Start of SCM code (hi byte)

# sjasmplus equivalent: Slash is just backwards, SCW must flip all slashes

# transform - swap backslash for slash
/\.DB.+\\/ { gsub(/\\/,"/",$0); print; next} 

#================================================================================
##DB variation of .DB
#================================================================================

# SCW example:
# szCDate:    #DB  CDATE          ; Build date. eg: "20190627"

# sjasmplus equivalent: #DB is just .DB with interpretation, just use .DB as that is properly interpreted

# transform - 
/#DB/ { gsub(/#/,".",$0); gsub(/\\/,"/",$0); print; next} 


#================================================================================
#.HEXCHAR 
#================================================================================

# SCW example:
#            .HEXCHAR kACIABase \ 16
#            .HEXCHAR kACIABase & 15
# 
# Outputs single ascii hex character from the value

# sjasmplus equivalent: None, but we can fake it with LUA script

# transform
/\.HEXCHAR / { $1=""; gsub(/\\/,"/",$0); gsub(/\r/,"",$0);
    print ";\tHEXCHAR - Output hex digit from value"
    print "\tLUA ALLPASS"
    printf "\t\tdigit = _c(\"%s\")\n",$0
    print "\t\tif (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end" 
    print "\tENDLUA";  
next}

#    LUA ALLPASS
#        digit = _c("kACIABase / 16")
#        if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
#    ENDLUA

#================================================================================
#@Label - Local Labels
#================================================================================

# SCW example:
#@Loop:
# 
# Suspect this is local to the prior non-local label 

# sjasmplus equivalent: uses .Label as local after non-local label
#.Loop:
/@/ {gsub(/@/,".",$0); print; next}

#================================================================================
#.DATA / .CODE / .ORG
#================================================================================

# SCW example:
#   .DATA
#   .ORG 0xFC00
#   .CODE
# 
# Switches context for .ORG between .DATA (RAM) and .CODE segement (ROM)
# essentially runs two different Program Counters

# sjasmplus equivalent: None, but we can fake it with LUA script

# transform
{if (FILENAME == main && NR == 1){
    while(substr($0,1,1) == ";"){ # insert after the first comment block
        print
        getline
    }
    print "\n; Processed by scw2sjasm to modify code from SCWorkshop to sjasmplus"
    print ";\n; Initialize .CODE and .DATA PC"
    print "\tLUA ALLPASS"
    print "\t\tcode_pc = 0"
    print "\t\tdata_pc = 0"
    print "\t\tin_code = true"
    if(!build_dir){ # modify this by including -v build_dir="./my_build_dir/" in the awk command line
        print "\t\tbuild_dir = \"./build/\""
    }
    print "\tENDLUA";
    print "\n\tDEVICE NOSLOT64K"
    print "\tSLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION"
    output_file = FILENAME
    sub(/\.asm/,".bin",output_file)
    print "\n\tOUTPUT " output_file
}}

/\.DATA/ {
    print ";\t.DATA - Switch context to Data PC"
    print "\tLUA ALLPASS"
    print "\t\tif in_code then"
    print "\t\t\tcode_pc = sj.current_address"
    print "\t\t\tin_code = false"
    print "\t\t\t_pc(\".ORG 0x\"..string.format(\"%04X\",data_pc))" 
    print "\t\t\t_pc(\"OUTPUT \"..build_dir..\"data_output_\"..string.format(\"%04X\",data_pc)..\".bin\")" 
    print "\t\tend"
    print "\tENDLUA";
    next
}

/\.CODE/ {
    print ";\t.CODE - Switch context to Code PC"
    print "\tLUA ALLPASS"
    print "\t\tif not in_code then"
    print "\t\t\tdata_pc = sj.current_address"
    print "\t\t\tin_code = true"
    print "\t\t\t_pc(\".ORG 0x\"..string.format(\"%04X\",code_pc))"
    print "\t\t\t_pc(\"OUTPUT \"..build_dir..\"code_output_\"..string.format(\"%04X\",code_pc)..\".bin\")"
    print "\t\tend"
    print "\tENDLUA";
    next
}

/^\s+\.ORG/ {
    gsub(/\r/,"",$2);
    print ";\t.ORG - Reset PC for the correct context"
    print "\tLUA ALLPASS"
    print "\t\tif in_code then"
    print "\t\t\tcode_pc = _c(\""$2"\")"
    print "\t\t\t_pc(\".ORG 0x\"..string.format(\"%04X\",code_pc))"
    print "\t\t\t_pc(\"OUTPUT \"..build_dir..\"code_output_\"..string.format(\"%04X\",code_pc)..\".bin\")"
    print "\t\telse"
    print "\t\t\tdata_pc = _c(\""$2"\")"
    print "\t\t\t_pc(\".ORG 0x\"..string.format(\"%04X\",data_pc))"
    print "\t\t\t_pc(\"OUTPUT \"..build_dir..\"data_output_\"..string.format(\"%04X\",data_pc)..\".bin\")"
    print "\t\tend"
    print "\tENDLUA";    
    next
}

#================================================================================
#DEFAULT ACTION 
#================================================================================
# comment this out to only print modified lines

{print}

#================================================================================

#EOF