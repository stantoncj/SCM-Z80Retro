; **********************************************************************
; **  Build Small Computer Monitor Configuration E1 (CPM)             **
; **********************************************************************

; Include standard configuration stuff
	INCLUDE Config/Common/Config_Standard.asm

; Build date
	DEFINE+ CDATE "20210508" ;Build date is embedded in the code

; Configuration identifiers
kConfMajor = 'E'            ;Config Letter = official, number = user
kConfMinor = '1'            ;Config 1 to 9 = official, 0 = user
	DEFINE+ CNAME "CPM" ;Configuration name (max 11 characters)

; Hardware ID (use HW_UNKNOWN if not for a very specified product)
kConfHardw = HW_UNKNOWN     ;Hardware identifier (if known)

; Console devices
kConDef    = 1              ;Default console device (1 to 6)
kBaud1Def  = 0x11           ;Console device 1 default baud rate 
kBaud2Def  = 0x11           ;Console device 2 default baud rate 

; Simple I/O ports
kPrtIn     = 0x00           ;General input port
kPrtOut    = 0x00           ;General output port

; ROM filing system
kROMBanks  = 1              ;Number of software selectable ROM banks
kROMTop    = 0x7F           ;Top of banked ROM (hi byte only)

; Processor
	DEFINE+ PROCESSOR "Z80" ;Processor type "Z80", "Z180"
kCPUClock  = 4000000        ;CPU clock speed in Hz
;kZ180Base = 0xC0           ;Z180 internal register base address

; OS
	DEFINE+ EXTERNALOS ;Run from external OS (eg. CP/M)

; Memory map
kCode      = 0x0100         ;Typically 0x0000 or 0xE000
kData      = 0x2C00         ;Typically 0xFC00 (to 0xFFFF)

; Exclude
	UNDEFINE IncludeRomFS ;Do not include RomFS
	UNDEFINE IncludeBaud ;Do not include Baud rate setting


; **********************************************************************
; Build the code

	INCLUDE System/Begin.asm

	INCLUDE BIOS/CPM/Manager.asm

	INCLUDE System/End.asm

	INCLUDE Config/Common/ROM_Info_SC32k_NoApps.asm








