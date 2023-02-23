; Test script for testing LUA replacement for .HEX

;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" .HEXCHAR kACIABase / 16")")")")")")")")")")")")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
;	HEXCHAR - Output hex digit from value
	LUA ALLPASS
		digit = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" = _c(" .HEXCHAR kACIABase & 15")")")")")")")")")")")")
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA
		if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
	ENDLUA

    OUTPUT test_lua_hex.bin

    DEFINE kACIABase 0xFC

    LUA
    function DEC_HEX(IN)
        local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
        while IN>0 do
            I=I+1
            IN,D=math.floor(IN/B),(IN%B)+1
            OUT=string.sub(K,D,D)..OUT
        end
        return OUT
    end
    ENDLUA

    LUA ALLPASS
        _pc('DB ' ..'"'..DEC_HEX(tonumber(_c("kACIABase / 16")))..'"')
    ENDLUA

    LUA ALLPASS
        digit = _c("kACIABase / 16")
        if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
    ENDLUA
    LUA ALLPASS
        digit = _c("kACIABase % 16")
        if (digit<10) then _pc('DB '..48+digit) else _pc('DB '..55+digit) end
    ENDLUA
; EOF
