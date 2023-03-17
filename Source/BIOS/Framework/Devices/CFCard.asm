; **********************************************************************
; **  Device Driver                             by Stephen C Cousins  **
; **  Hardware:  Generic                                              **
; **  Interface: Compact Flash Card                                   **
; **********************************************************************

; This module is the driver for a Compact Flash card using an 8-bit
; interface direct on the processor bus
;
; Externally definitions required:
;kCFBase = kCFBase          ;I/O base address

; Memory map
NumSectors = 24             ;Number of 512 sectors to be loaded
TempStack  = $8800          ;Temporary stack
LoadAddr   = $9000          ;CP/M load address
LoadBytes  = $3000          ;Length = 24 sectors * 512 bytes
LoadNext   = LoadAddr+LoadBytes
LoadTop    = LoadNext-1     ;Top of loaded bytes
CPMTop     = $FFFF          ;Top location used by CP/M


; CF registers
CF_DATA     = kCFBase + 0
CF_FEATURES = kCFBase + 1
CF_ERROR    = kCFBase + 1
CF_SECCOUNT = kCFBase + 2
CF_SECTOR   = kCFBase + 3
CF_CYL_LOW  = kCFBase + 4
CF_CYL_HI   = kCFBase + 5
CF_HEAD     = kCFBase + 6
CF_STATUS   = kCFBase + 7
CF_COMMAND  = kCFBase + 7
CF_LBA0     = kCFBase + 3
CF_LBA1     = kCFBase + 4
CF_LBA2     = kCFBase + 5
CF_LBA3     = kCFBase + 6

;CF Features
CF_8BIT     = 1
CF_NOCACHE  = 082H
;CF Commands
CF_RD_SEC   = 020H
CF_WR_SEC   = 030H
CF_SET_FEAT = 0EFH


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
            .DW  .CF_Init       ;Pointer to initialisation code
            .DB  0              ;Hardware flags bit mask
            .DW  .CF_Set        ;Point to device settings code
            .DB  0              ;Number of console devices
.String:    .DB  "CF Card "
            .DB  "@ "
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" kCFBase / 16")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" kCFBase & 15")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
            .DB  kNull


; Initialise
;   On entry: No parameters required
;   On exit:  Z flagged if device is found and initialised
;             AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
; If the device is found it is initialised
; The test is repeated with a time-out as the CF card may take
; some time after power-up to start responding
.CF_Init:
; First check if I/O address appears occupied
            LD   C,CF_DATA      ;Digital I/O port address
            IN   C,(C)          ;Read from this port
            IN   A,(CF_DATA)    ;Read again using different instruction
            CP   C              ;Both the same? (bus not floating)
            RET  Z              ;Return Z flagged if found
            LD   C,CF_ERROR     ;Digital I/O port address
            IN   C,(C)          ;Read from this port
            IN   A,(CF_ERROR)   ;Read again using different instruction
            CP   C              ;Both the same? (bus not floating)
            RET                 ;Return Z flagged if found

	IFDEF NOCHANCE
; This method is better but rather slow as some cards take quite a
; while after a hardware reset before they respond correctly
;           RET  NZ             ;Return NZZ flagged if not found
; Wait for card to be ready
	IF PROCESSOR = "Z180"
            LD   BC,65000       ;Time-out (18.432MHz clock)
	ELSE
            LD   BC,26000       ;Time-out (7.3728MHz clock)
	ENDIF
.Loop:      LD   A,5            ;Test value for sector count register
            OUT  (CF_SECCOUNT),A  ;Write sector count register
            IN   A,(CF_SECCOUNT)  ;Read sector count register
            CP   5              ;Correct value read back?
            RET  Z              ;Return Z if found, NZ if not
            LD   A,4            ;Delay...
.Delay:     DEC  A
            JR   NZ,.Delay
            DEC  C              ;Test for time-out...
            JR   NZ,.Loop
            DEC  B
            JR   NZ,.Loop
            INC  B              ; Ensure NZ flagged as device not found
            RET
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
.CF_Set:    XOR  A              ;Return failed to set (Z flagged)
            RET


; **********************************************************************
; **  End of driver                                                   **
; **********************************************************************



















