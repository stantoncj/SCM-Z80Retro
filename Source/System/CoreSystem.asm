; **********************************************************************
; **  Include core system modules               by Stephen C Cousins  **
; **********************************************************************

; System version number
kSysMajor  = 1              ;System version revision
kSysMinor:  .EQU 2              ;System version: revision
kSysRevis  = 0              ;System version revision
;VerSTouch = 20220201       ;Last date system code touched


;StartOfCode:
;           = kCode          ;Start of monitor code

; Essential modules

; Core OS functions
	INCLUDE System/Alpha.asm ;This must be the first #include
	INCLUDE System/Console.asm ;Console support
	INCLUDE System/Idle.asm ;Idle events
	INCLUDE System/Ports.asm ;Port functions

; Optional modules (see #DEFINEs above)

; Exporting functions
	IFDEF IncludeAPI
	INCLUDE System/API.asm ;Application Programming Interface (API)
	ENDIF
	IFDEF IncludeFDOS
	INCLUDE System/FDOS.asm ;Very limited CP/M style FDOS support
	ENDIF

; Support functions
;#IFDEF     IncludeStrings
;#INCLUDE   System\Strings.asm  ;String support
;#ENDIF
	IFDEF IncludeUtilities
	INCLUDE System/Utilities.asm ;Utility functions (needs strings)
	ENDIF


	IFDEF IncludeHexLoader
	INCLUDE System/HexLoader.asm ;Intel hex loader
	ENDIF

	IFDEF IncludeRomFS
	INCLUDE System/RomFS.asm ;ROM filing system
	ENDIF
















