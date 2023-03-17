; **********************************************************************
; **  Device Driver                             by Stephen C Cousins  **
; **  Hardware:  Generic                                              **
; **  Interface: Diagnositc LEDs                                      **
; **********************************************************************

; This module is the driver for a simple 8 LED diagnostic port
;
; Externally definitions required:
;kDiagBase = kDiagLEDs          ;I/O base address


;	.CODE - Switch context to Code PC
	LUA ALLPASS
		if not in_code then
			data_pc = sj.current_address
			in_code = true
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		end
	ENDLUA

; Interface descriptor
            .DB  0              ;Device ID code (not currently used)
            .DW  .String        ;Pointer to device string
            .DW  .Init          ;Pointer to initialisation code
            .DB  0              ;Hardware flags bit mask
            .DW  .Setting       ;Point to device settings code
            .DB  0              ;Number of console devices
.String:    .DB  "Diagnostic LEDs "
            .DB  "@ "
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" kDiagBase / 16")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" kDiagBase & 15")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
            .DB  kNull


; Initialise
;   On entry: No parameters required
;   On exit:  Z flagged if device is found and initialised
;             AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
; If the device is found it is initialised
.Init:
	IF DiagLEDs_DETECTED = "TEST"
; Test if reading from port appears to be an unused address (floating)
; This only works if the data bus is not terminated and the diagnostic
; LED port address also includes an input port
            LD   C,kDiagBase    ;Digital I/O port address
            IN   C,(C)          ;Read from this port
            IN   A,(kDiagBase)  ;Read again using different instruction
            CP   C              ;Both the same? (bus not floating)
            RET                 ;Return Z flagged if found
	ENDIF
	IF DiagLEDs_DETECTED = "ALWA"
            XOR  A              ;Always return device detected 
            RET                 ;Return Z flagged if found
	ENDIF
	IF DiagLEDs_DETECTED = "NEVE"
            OR   0xFF           ;Never return device detected 
            RET                 ;Return Z flagged if found
	ENDIF

; Device settings
;   On entry: No parameters required
;   On entry: A = Property to set: 1 = Baud rate
;             B = Baud rate code
;             C = Console device number (1 to 6)
;   On exit:  IF successful: (ie. valid device and baud code)
;               A != 0 and NZ flagged
;             BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
.Setting:   XOR  A              ;Return failed to set (Z flagged)
            RET


; **********************************************************************
; **  End of driver                                                   **
; **********************************************************************









