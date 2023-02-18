# modify .asm files from SCWorkshop (https://smallcomputercentral.com/) to sjasmplus directives

# What tokens are actually in use?
find . -type f -name '*.asm' -exec awk '/^(#[^\s\\]+)/{print $1;}' '{}' \; | sort | uniq

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

# transform - strip #, add tab, changes DEFINE to DEFINE+
'!/^#DEFINE/ {print;next} gsub(/#DEFINE/,"\tDEFINE+",$1)'
'!/^#UNDEFINE/ {print;next} gsub(/#/,"\t",$1)'


#================================================================================
#IF
#ELSE
#ENDIF
#IFDEF
#IFNDEF
#================================================================================

# These all behave as expected, still need to move them into OPS colum
'!/^#IF(.+)/ {print;next} gsub(/#/,"\t",$1)'
'!/^#ELSE(.+)/ {print;next} gsub(/#/,"\t",$1)'
'!/^#ENDIF(.+)/ {print;next} gsub(/#/,"\t",$1)'

#================================================================================
#INCLUDE
#================================================================================

# SCW example:
#INCLUDE    BIOS\Framework\Devices\StatusLED.asm

#sjasmplus equivalent: (note whitespace start, unix path seperators)
#   INCLUDE BIOS/Framework/Devices/StatusLED.asm

# transform - strip #, add tab, backslash to slash in filename
'!/^#INCLUDE/ {print;next} gsub(/#/,"\t",$1) gsub(/\\/,"/")'

#================================================================================
#INSERTHEX
#================================================================================

# SCW example:
#INSERTHEX  ..\Apps\MSBASIC_adapted_by_GSearle\SCMon_BASIC_code3000_data8000.hex

#sjasmplus equivalent: (NONE!)
# Used to include BASIC/CPM hex into the build ROM.
# Can we use INSERT which inserts BIN instead of .HEX?

# transform - comment out line
'!/^#INSERTHEX/ {print;next} gsub(/#/,"; #",$1)'

#================================================================================
#TARGET
#================================================================================

# SCW example:
#TARGET     Simulated_Z80       ;Determines hardware support included

#sjasmplus equivalent: (NONE!)
# Only used as an SCW directive

# transform - comment out line
'!/^#TARGET/ {print;next} gsub(/#/,"; #",$1)'

#================================================================================









# collecting junk below this line


#INCLUDE
# 
# example:
#INCLUDE    BIOS\Framework\Devices\StatusLED.asm

# with file names
find . -type f -name '*.asm' -exec awk '/^#INCLUDE/{print FILENAME ":\t" $0;}' '{}' \;

# without file names
find . -type f -name '*.asm' -exec awk '/(^;)#INCLUDE/{print $0;}' '{}' \; 

find . -type f -name '*.asm' -exec awk '/^(#[^\s\\]+)/{print $1;}' '{}' \; | sort | uniq



