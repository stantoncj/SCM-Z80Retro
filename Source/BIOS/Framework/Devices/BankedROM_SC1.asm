; **********************************************************************
; **  Device Driver                             by Stephen C Cousins  **
; **  Hardware: SC114, and compatibles                                **
; **  Interface: Banked ROM                                           **
; **********************************************************************

; SCM BIOS framework compliant driver for banked ROM type SC1.
; A single 32k ROM does not support multiple banks


;	.CODE - Switch context to Code PC
	LUA ALLPASS
		if not in_code then
			data_pc = sj.current_address
			in_code = true
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		end
	ENDLUA


; **********************************************************************
; Copy from banked ROM to RAM
;   On entry: A = ROM bank number (0 to n)
;             HL = Source start address (in ROM)
;             DE = Destination start address (in RAM)
;             BC = Number of bytes to copy
;   On exit:  AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
H_CopyROM:  LDIR                ;Only one bank so just copy memory
            RET


; **********************************************************************
; Execute code in ROM bank
;   On entry: A = ROM bank number (0 to 3)
;             DE = Absolute address to execute
;   On exit:  AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
H_ExecROM:  PUSH DE             ;Jump to DE by pushing on
            RET                 ;  to stack and 'returning'


; **********************************************************************
; **  End of device driver                                            **
; **********************************************************************



