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
/^#DEFINE/ {gsub(/#DEFINE/,"\tDEFINE+",$1); print; next} 
/^#UNDEFINE/ {gsub(/#/,"\t",$1); print; next} 


#================================================================================
#IF
#ELSE
#ENDIF
#IFDEF
#IFNDEF
#================================================================================

# These all behave as expected once moved into OP column
/^#IF(.+)/ {gsub(/#/,"\t",$1); print; next} 
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
#DEFAULT ACTION 
#================================================================================

{print}

#================================================================================

#EOF

