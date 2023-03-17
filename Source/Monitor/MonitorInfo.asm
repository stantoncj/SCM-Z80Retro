; **********************************************************************
; **  ROM info: Monitor's own info              by Stephen C Cousins  **
; **********************************************************************

;	.CODE - Switch context to Code PC
	LUA ALLPASS
		if not in_code then
			data_pc = sj.current_address
			in_code = true
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		end
	ENDLUA

;	.ORG - Reset PC for the correct context
	LUA ALLPASS
		if in_code then
			code_pc = _c("0xF0+kROMTop*256")
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		else
			data_pc = _c("0xF0+kROMTop*256")
			_pc(".ORG 0x"..string.format("%04X",data_pc))
			_pc("OUTPUT "..build_dir.."data_output_"..string.format("%04X",data_pc)..".bin")
		end
	ENDLUA
            .DW  0xAA55         ;Identifier
            .DB  "Monitor "     ;File name ("Monitor.EXE")
            .DB  2              ;File type 2 = Executable from ROM
            .DB  0              ;Not used
            .DW  0x0000         ;Start address
            .DW  CodeEnd-CodeBegin  ;Length

; **********************************************************************
; **  End of ROM information module                                   **
; **********************************************************************



