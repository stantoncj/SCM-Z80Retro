; **********************************************************************
; **  Device Driver                             by Stephen C Cousins  **
; **  Hardware: Z80 Retro by P Wilson                                 **
; **  Interface: Banked RAM                                           **
; **********************************************************************

; TODO

; SCM BIOS framework compliant driver for banked RAM for Z80 Retro
; Although Z80 Retro Supports 4M of RAM, this simulates the RC2014 behavior with 2x32k banks at 0x80-FF
; Primary and secondary

; The hardware interface consists of:
; Bank selection ports:
;   0x60..0x63 - 00-3F,40-7F,80-CF,D0-FF memory blocks
;     write with bank numbers:
;   0x00-1F - 32 banks of 16k ROM
;   0x20-3F - 32 banks of 16k RAM
; Write 0x64, bit 0 to 1 to enable banks
;
; Externally definitions required:
;kBankPrt  = 0x60           ;Start of Bank Selection Ports
;kBankSel  = 0x64           ;LED/Bank Enable


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
; Initialize RAM banking for now lower 32K=ROM, upper 32k=RAM
; Because of the structure of the code, this has to be moved to
; selftest.asm
; Ideally the code would call this here, but it has to be called before
; we have a SP.
;
;   On entry: None required
;   On exit:  A = not specified
;             F BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved;
;
; TODO: Make this general to swap banks

H_InitRAM:
            ld a,0x00   			; $0000 = FLASH bank 0
            OUT (kBankPrt),A
            inc A
            OUT (kBankPrt+1),A	    ; $4000 = FLASH bank 1

            ld a,0x20   			; $8000 = RAM bank 0
            OUT (kBankPrt+2),A
            inc a					; $C000 = RAM bank 1
            OUT (kBankPrt+3),A

            ld a,0x01               ; set bit 0 to enable paging
            OUT (kBankSel),a	    ; turn on paging, turns off all LEDs

            RET


; **********************************************************************
; Read from banked RAM - Swap entire 32k top RAM, read byte, Swap back
;   On entry: DE = Address in secondary bank
;   On exit:  A = Byte read from RAM
;             F BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
;
; TODO: Refine - Only swap the proper bank specified by DE
;
H_RdRAM:    
            ld b,0x22   			; $0000 = RAM bank 2 (secondary)
            ld c,kBankPrt+2         ; Swap 0x80-CF to bank 2
            OUT (c),b
            inc c                   ; Switch to 0xD0-FF
            inc b                   ; Switch to RAM bank 3 (secondary)
            OUT (c),b	            ; Swap 0xD0-FF to bank 3

            LD   A,(DE)             ;Read from RAM

            ld b,0x20   			; $0000 = RAM bank 2 
            ld c,kBankPrt+2         ; Swap 0x80-CF to bank 2
            OUT (c),b
            inc c                   ; Switch to 0xD0-FF
            inc b                   ; Switch to RAM bank 3
            OUT (c),b	            ; Swap 0xD0-FF to bank 3
            
            RET


; **********************************************************************
; Write to banked RAM
;   On entry: A = Byte to be written to RAM
;             DE = Address in secondary bank
;   On exit:  AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
;
; TODO: Refine - Only swap the proper bank specified by DE
;

H_WrRAM:
            ld b,0x22   			; $0000 = RAM bank 2 (secondary)
            ld c,kBankPrt+2         ; Swap 0x80-CF to bank 2
            OUT (c),b
            inc c                   ; Switch to 0xD0-FF
            inc b                   ; Switch to RAM bank 3 (secondary)
            OUT (c),b	            ; Swap 0xD0-FF to bank 3

            LD   (DE),A         ;Write to RAM

            ld b,0x20   			; $0000 = RAM bank 2 
            ld c,kBankPrt+2         ; Swap 0x80-CF to bank 2
            OUT (c),b
            inc c                   ; Switch to 0xD0-FF
            inc b                   ; Switch to RAM bank 3
            OUT (c),b	            ; Swap 0xD0-FF to bank 3
       
            RET


; **********************************************************************
; **  End of device driver                                            **
; **********************************************************************







