; **********************************************************************
; **  Configuration file                        by Stephen C Cousins  **
; **  Module: SC126 (Z180 SBC with RC2014 bus)                        **
; **********************************************************************

; This card contains a Z180 CPU, ROM, RAM, Clock, Reset, Serial port

; Processor
	DEFINE+ PROCESSOR "Z180" ;Processor type "Z80", "Z180"
kCPUClock  = 18432000       ;CPU clock speed in Hz
kZ180Base  = 0xC0           ;Z180 internal register base address

; ROM filing system
kROMBanks  = 1              ;Number of software selectable ROM banks

; Z180 ASCI
	IFNDEF INCLUDE_ASCI_n1
kASCI1     = kZ180Base+0x00 ;Base address of Z180 serial ports (CNTLA0)
	DEFINE+ INCLUDE_ASCI_n1 ;Include ASCI #1 
	ENDIF

; Diagnostic LEDs
	IFNDEF INCLUDE_DiagLEDs
	IFNDEF DiagLEDs_DETECTED
	DEFINE+ DiagLEDs_DETECTED "ALWA" ;ALWAYS | NEVER | TESTABLE
	ENDIF
kDiagLEDs  = 0x0D           ;Base address of diagnostic LEDs
	DEFINE+ INCLUDE_DiagLEDs ;Include diagnostic LEDs in this build
	ENDIF











