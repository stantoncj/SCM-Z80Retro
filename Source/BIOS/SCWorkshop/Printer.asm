; **********************************************************************
; **  Device Driver                             by Stephen C Cousins  **
; **  Hardware:  SCWorkshop Simulator                                 **
; **  Interface: Printer                                              **
; **********************************************************************

; This modules is the driver for a simulated printer with an extemely
; simplifed interface.

;	.CODE - Switch context to Code PC
	LUA ALLPASS
		if not in_code then
			data_pc = sj.current_address
			in_code = true
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		end
	ENDLUA


; Simulated printer initialise
;   On entry: No parameters required
;   On exit:  Z flagged if device is found and initialised
;             AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
; If the device is found it is initialised
Simulated_Printer_Initialise:
            XOR  A              ;Return Z flag as device found
            RET


; Simulated printer output character
;   On entry: A = Character to be output to the printer
;   On exit:  If character output successful (eg. device was ready)
;               NZ flagged and A != 0
;             If character output failed (eg. device busy)
;               Z flagged and A = Character to output
;             BC DE HL IX IY I AF' BC' DE' HL' preserved
Simulated_Printer_OutputChar:
            OUT  (PrintOut),A   ; Transmit to printer
            OR   0xFF           ; Return success A=0xFF and NZ flagged
            RET











