; **********************************************************************
; **  Build Small Computer Monitor Configuration Z80Retro - P.Wilson  **
; **********************************************************************

; Include standard configuration stuff
	INCLUDE Config/Common/Config_Standard.asm

; Build date
	DEFINE+ CDATE "20230317" ;Build date is embedded in the code

; Configuration identifiers
kConfMajor = '1'            ;Config Letter = official, number = user
kConfMinor = '0'            ;Config 1 to 9 = official, 0 = user
	DEFINE+ CNAME "Z80Rtr/Z80" ;Configuration name (max 11 characters)

; Hardware ID (use HW_UNKNOWN if not for a very specified product)
kConfHardw = HW_UNKNOWN     ;Hardware identifier (if known)

; Console devices
; Default to console device 1
; All baud rates are defaults for the hardware to avoid CTC screw ups
;kConDef    = 1              ;Default console device (1 to 6)
;kBaud1Def  = 0x11           ;Console device 1 default baud rate 
;kBaud2Def  = 0x11           ;Console device 2 default baud rate 
;kBaud3Def  = 0x11           ;Console device 3 default baud rate 
;kBaud4Def  = 0x11           ;Console device 4 default baud rate 

; Simple I/O ports (o/p used for selftest/status display)
;kPrtIn     = 0xA0           ;General input port
;kPrtOut    = 0xA0           ;General output port

; System options
;#DEFINE    ROM_ONLY            ;No option to assemble to upper memory


; **********************************************************************
; Included BIOS support for optional hardware

; Z80 Retro by P Wilson - Z80 Processor (CPU, RAM, ROM, SIO, CTC)
	INCLUDE Config/Modules/Z80Retro.asm

; Common Z50Bus bus modules
;	INCLUDE Config/Common/Generic_Z50Bus.asm 

; **********************************************************************
; Any required customisations should be here, eg:
kBankPrt   = 0x60           ; Beginning of the bank controls
kBankSel   = 0x64			; LED/Bank Enable Switch
kLEDSel	   = kBankSel		; 

; *** Z80 SIO/0 with Z80 Retro order (different than RC2014 or Intel)
; *** SIO 0x80 BD, 0x81 AD, 0x82 BC, 0x83 AC
; Externally definitions required:
kSIO1 	   = 0x80
;kSIOBase   = 0x80           ;Base address of serial Z80 SIO
;kSIOACont  = kSIOBase+3     ;I/O address of control register A
;kSIOAData  = kSIOBase+1     ;I/O address of data register A
;kSIOBCont  = kSIOBase+2     ;I/O address of control register B
;kSIOBData  = kSIOBase+0     ;I/O address of data register B
;kSIOFlags  = 0b00000010     ;Hardware flags = SIO #1
; No CTC
;kSIOACTC  = 0        ;Port A's CTC register (0 if n/a)
;kSIOBCTC  = 0        ;Port B's CTC register (0 if n/a)

  MACRO LED_ON mask
    LD A,mask
	OR A,0x1 				; Make sure bank select stays on
    OUT (kBankSel),A
  ENDM

  MACRO LED_OFF
	XOR A
	OR A,0x1		
	OUT (kBankSel),A
  ENDM

; **********************************************************************
; Build the code

	INCLUDE System/Begin.asm

	INCLUDE BIOS/SCZ80/Manager.asm

	INCLUDE System/End.asm

	INCLUDE Config/Common/ROM_Info_SC32k.asm
























