; **********************************************************************
; **  Common definitions                        by Stephen C Cousins  **
; **********************************************************************

; Common constants
kNull       = 0              ;Null character/byte (0x00)
kNewLine    = 5              ;New line character (0x05)
kBackspace = 8              ;Backspace character (0x08)
kLinefeed  = 10             ;Line feed character (0x0A)
kReturn    = 13             ;Return character (0x0D)
kEscape    = 27             ;Escape character (0x1B)
kSpace     = 32             ;Space character (0x20)
kApostroph = 39             ;Apostrophe character (0x27)
kComma     = 44             ;Comma character (0x2C)
kPeriod    = 46             ;Period character (0x2E)
kColon     = 58             ;Colon character (0x3A)
kSemicolon = 59             ;Semicolon character (0x3B)
kDelete    = 127            ;Delete character (0x7F)


; System jump table constants
; The jump table contains a number of "JP nn" instructions which are
; used to redirect functions. Each entry in the table takes 3 bytes.
; The jump table is created in RAM on cold start of the monitor.
; Jump table constants - jump number (0 to n)
kFnNMI     = 0x00           ;Fn 0x00 non-maskable interrupt handler
kFnRST08   = 0x01           ;Fn 0x01 restart 08 handler
kFnRST10   = 0x02           ;Fn 0x02 restart 10 handler
kFnRST18   = 0x03           ;Fn 0x03 restart 18 handler
kFnRST20   = 0x04           ;Fn 0x04 restart 20 handler
kFnRST28   = 0x05           ;Fn 0x05 restart 18 breakpoint
kFnRST30   = 0x06           ;Fn 0x06 restart 30 API handler
kFnINT     = 0x07           ;Fn 0x07 restart 38 interrupt handler
kFnConIn   = 0x08           ;Fn 0x08 console input character
kFnConOut  = 0x09           ;Fn 0x09 console output character
;FnConISta = 0x0A           ;Fn 0x0A console get input status
;FnConOSta = 0x0B           ;Fn 0x0B console get output status
kFnIdle    = 0x0C           ;Fn 0x0C Jump to idle handler
kFnTimer1  = 0x0D           ;Fn 0x0D Jump to timer 1 handler
kFnTimer2  = 0x0E           ;Fn 0x0E Jump to timer 2 handler
kFnTimer3  = 0x0F           ;Fn 0x0F Jump to timer 3 handler
;FnDevN    = 0x10           ;Fn 0x10 device 1 to n input & output
kFnDev1In  = 0x10           ;Fn 0x10 device 1 input
kFnDev1Out = 0x11           ;Fn 0x11 device 1 output
;kFnDev2In = 0x12           ;Fn 0x12 device 2 input
;FnDev2Out = 0x13           ;Fn 0x13 device 2 output
kFnDev3In  = 0x14           ;Fn 0x14 device 3 input
;FnDev3Out = 0x15           ;Fn 0x15 device 3 output
kFnDev4In  = 0x16           ;Fn 0x16 device 4 input
;FnDev4Out = 0x17           ;Fn 0x17 device 4 output
;FnDev5In  = 0x18           ;Fn 0x18 device 5 input
;FnDev5Out = 0x19           ;Fn 0x19 device 5 output
kFnDev6In  = 0x1A           ;Fn 0x1A device 6 input
;FnDev6Out = 0x1B           ;Fn 0x1B device 6 output

; System message numbers
kMsgNull   = 0              ;Null message
kMsgProdID = 1              ;Product identifier
kMsgDevice = 2              ;="Devices"
kMsgAbout  = 3              ;About SCMonitor inc version
kMsgDevLst = 4              ;Device list
kMsgReady  = 5              ;Ready
kMsgFileEr = 6              ;File error
kMsgLstSys = 6              ;Last system message number


; Defaults stored at fixed locations for easy customisation
;kaConDev  = 0x0040         ;0x0040  Default console device (1 to 6)
;kaBaud1Def = 0x0041        ;0x0041  Default device 1 baud rate
;kaBaud2Def = 0x0042        ;0x0042  Default device 2 baud rate
;kaBaud3Def = 0x0043        ;0x0043  Default device 3 baud rate
;kaBaud4Def = 0x0044        ;0x0044  Default device 4 baud rate
;kaPortIn  = 0x0045         ;0x0045  Default status input port
;kaPortOut = 0x0046         ;0x0046  Default status output port

; Constants stored at fixed locations so rest of binary is identical
;kaRomTop  = 0x004D         ;0x004D  Top of RomFS (hi byte)
;kaCodeBeg = 0x004E         ;0x004E  Start of SCM code (hi byte)
;kaCodeEnd = 0x004F         ;0x004F  End of SCM code (hi byte)

; Entry points
;CStrt     = 0x000C         ;Cold start (following selftest)


            ;.ORG 0x0000        ;Establish start of code

;	.CODE - Switch context to Code PC
	LUA ALLPASS
		if not in_code then
			data_pc = sj.current_address
			in_code = true
			_pc(".ORG 0x"..string.format("%04X",code_pc))
			_pc("OUTPUT "..build_dir.."code_output_"..string.format("%04X",code_pc)..".bin")
		end
	ENDLUA










