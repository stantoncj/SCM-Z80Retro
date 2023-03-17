; **********************************************************************
; **  Device Driver                             by Stephen C Cousins  **
; **  Hardware:  Generic                                              **
; **  Interface: Status LED                                           **
; **********************************************************************

; This module is the driver for a single LED diagnostic indicator
;
; Externally definitions required:
;kStatBase = kPrtLED          ;I/O base address


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
.String:    .DB  "Status LED "
            .DB  "@ "
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" kStatBase / 16")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" kStatBase & 15")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
            .DB  kNull


; Initialise
;   On entry: No parameters required
;   On exit:  Z flagged if device is found and initialised
;             AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
; If the device is found it is initialised
.Init:      XOR  A              ;Always return device detected 
            RET                 ;Return Z if found, NZ if not


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

