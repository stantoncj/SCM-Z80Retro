; **********************************************************************
; **  Common start                              by Stephen C Cousins  **
; **********************************************************************

; Set default processor
	IFNDEF PROCESSOR
	DEFINE+ PROCESSOR "Z80"
	ENDIF

; Configure assembler to generate Z80 code from Zilog mnemonics
	IF PROCESSOR = "Z80""
;            .PROC Z80           ;Select processor for SCWorkshop	ENDIF

; Configure assembler to generate Z180 code from Zilog mnemonics
	IF PROCESSOR = "Z180"
;            .PROC Z180          ;Select processor for SCWorkshop	ENDIF

;#INCLUDE   Config\Config_Standard.asm

;	.ORG - Reset PC for the correct context
	LUA ALLPASS
		if in_code then
			code_pc = _c("kCode")
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		else
			data_pc = _c("kCode")
			_pc(".ORG 0x"..string.format("%04X",data_pc))
			_pc("OUTPUT "..build_dir.."data_output_"..string.format("%04X",data_pc)..".bin")
		end
	ENDLUA
CodeBegin:

	INCLUDE System/Common.asm

	INCLUDE System/CoreSystem.asm

	IFDEF IncludeMonitor
	INCLUDE Monitor/CoreMonitor.asm
	ENDIF

	INCLUDE BIOS/BIOS_Constants.asm 

	INCLUDE Config/Common/Config_Common.asm

;	.CODE - Switch context to Code PC
	LUA ALLPASS
		if not in_code then
			data_pc = sj.current_address
			in_code = true
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		end
	ENDLUA

; BIOS begins here...

















