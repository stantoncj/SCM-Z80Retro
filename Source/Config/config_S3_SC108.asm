; **********************************************************************
; **  Build Small Computer Monitor Configuration SC108                **
; **********************************************************************

; Include standard configuration stuff
	INCLUDE Config/Common/Config_Standard.asm

; Build date
	DEFINE+ CDATE "20220227" ;Build date is embedded in the code

; Configuration identifiers
kConfMajor = 'S'            ;Config Letter = official, number = user
kConfMinor = '3'            ;Config 1 to 9 = official, 0 = user
	DEFINE+ CNAME "RC/Z80" ;Configuration name (max 11 characters)

; Hardware ID (use HW_UNKNOWN if not for a very specified product)
kConfHardw = HW_RCZ80_3     ;Hardware identifier (if known)

; Console devices
; Default to console device 1
; All baud rates are defaults for the hardware to avoid CTC screw ups
kConDef    = 1              ;Default console device (1 to 6)
kBaud1Def  = 0x11           ;Console device 1 default baud rate 
kBaud2Def  = 0x11           ;Console device 2 default baud rate 
kBaud3Def  = 0x11           ;Console device 3 default baud rate 
kBaud4Def  = 0x11           ;Console device 4 default baud rate 

; Simple I/O ports (o/p used for selftest/status display)
kPrtIn     = 0x00           ;General input port
kPrtOut    = 0x00           ;General output port

; System options
;#DEFINE    ROM_ONLY            ;No option to assemble to upper memory


; **********************************************************************
; Included BIOS support for optional hardware

;SC108 Z80 Processor (Z80 CPU, RAM, ROM, Clock)
	INCLUDE Config/Modules/SC108.asm

; Common RC2014 bus modules
	INCLUDE Config/Common/Generic_RC2014.asm


; **********************************************************************
; Any required customisations should be here, eg:
; kSIO1  = 0x80             ;Base address of serial Z80 SIO #1

; This prevents SIO port A from having baud rate set by CTC
; It is needed to make SC110 port A work correctly
kSIO1ACTC  = 0              ;Port A's CTC register (0 if n/a)


; **********************************************************************
; Build the code

	INCLUDE System/Begin.asm

	INCLUDE BIOS/SCZ80/Manager.asm

	INCLUDE System/End.asm

	INCLUDE Config/Common/ROM_Info_SC32k.asm






















