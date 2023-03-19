; **********************************************************************
; **  Configuration file                        by Christian Stanton  **
; **  Module: Z80Retro (by P. Wilson) 		  		                  **
; **********************************************************************

; This card contains a Z80 CPU, ROM, RAM, Clock, Reset, SIO and CTC
;
; This file defines some constants and then what to actually include when
; building.  Note that this doesn't actually include, only flags things
; to include in the build.

; Processor
	DEFINE+ PROCESSOR "Z80" ;Processor type "Z80", "Z180"
kCPUClock  = 14745600       ;CPU clock speed in Hz - CPUCLK FAST
;kCPUClock  = 7432800		;CPU clock speed in Hz - CPUCLK SLOW


; Where is this implemented? Can I use it?
; ROM filing system
;kROMBanks  = 1              ;Number of software selectable ROM banks
;kROMTop    = 0x7F           ;Top of banked ROM (hi byte only)

; *** LED module assumes a single port for an LED, need to rewrite to use shared bit
; *** Is not actually implemented in LED module
; *** Add a mask define for set and reset LEDs
; *** Z80 Retro use 0x64 masked by bit (LED1 = bit 2 -> LED5 = bit 6)
; *** OBS! Bit 0 is the memory map enabled pin!
; kPrdLED = 0x64
; kPrdLEDOn = 0x7c	; Z80 Retro has 5 LEDs on bits 2-6
; kPrdLEDOff = 0x00 ; Note that this turns off all LEDs, needs to be 1 after Memory Management is on

; Status LED
;	IFNDEF INCLUDE_StatusLED
;kPrtLED    = 0x08           ;Single status LED port (active low)
;	DEFINE+ INCLUDE_StatusLED
 
;	ENDIF

; *** Banked RAM only assumes it's a single bank selected by a single port on Bit 7
; *** Z80Retro has 64 x 16K banks 00-1F (Flash ROM) and 20-3F (Static RAM)
; *** Port 0x60-0x63 are the physical 16K blocks
; *** To map blocks to banks, write the bank # to the port of the block
; *** To enable memory map after config, set bit 0 of 0x64 to 1
; *** Need to write another device driver that has:
; *** Init (setup Banked RAM/ROM)
; *** Copy (from BANK to BANK)

; Banked RAM
	IFNDEF INCLUDE_BankedRAM_ZR1
	DEFINE+ INCLUDE_BankedRAM_ZR1
	ENDIF

; *** Banked ROM here isn't implemented - This is just temporary
; *** We do have banked ROM, but this is just a stub
; Banked ROM
	IFNDEF INCLUDE_BankedROM_SC1
	DEFINE+ INCLUDE_BankedROM_SC1
	ENDIF

; Z80 CTC common (all CTCs share this setting)
	IFNDEF CTC_CLK_7372800
	DEFINE+ CTC_CLK_7372800 ;7372800 | 1843200
	ENDIF

; Z80 CTC #1
	IFNDEF INCLUDE_CTC_n1
kCTC1      = 0x40           ;Base address of Z80 CTC #1
kDevTick   = kCTC1+2        ;Control register for 200Hz tick
	DEFINE+ INCLUDE_CTC_n1 ;Include CTC #1 support in this build
	ENDIF

; *** Include SIO/0 Code but with config defined register order
	IFNDEF INCLUDE_SIO_n1_std
	DEFINE+ INCLUDE_SIO_n1_std
	ENDIF
	
; EOF

