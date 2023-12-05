package cpu

@(private)
MaskHigh16 :: 0xFF00
@(private)
MaskLow16 :: 0x00FF

FlagRegister :: enum {
    Zero = 0x80,        // used to get zero flag from flag (f) registers in Bit 7 pos
    Substract = 0x40,   // used to get substract flag from flag (f) registers in Bit 6 pos
    HalfCarry = 0x20,   // used to get half carry flag from flag (f) registers in Bit 5 pos
    Carry = 0x10,       // used to get carry flag from flag (f) registers in Bit 4 pos
}

Register :: struct{
    a, b, c, d, e, f, h, l: u8
}

get_af :: proc(using reg: Register) -> (val: u16) {
    return get_combined_register(a, f)
}

set_af :: proc(using reg: ^Register, val: u16) {
    set_combined_register(&a, &f, val)
}

get_bc :: proc(using reg: Register) -> (val: u16) {
    return get_combined_register(b, c)
}

set_bc :: proc(using reg: ^Register, val: u16) {
    set_combined_register(&b, &c, val)
}

get_de :: proc(using reg: Register) -> (val: u16) {
    return get_combined_register(d, e)
}

set_de :: proc(using reg: ^Register, val: u16) {
    set_combined_register(&d, &e, val)
}

get_hl :: proc(using reg: Register) -> (val: u16) {
    return get_combined_register(h, l)
}

set_hl :: proc(using reg: ^Register, val: u16) {
    set_combined_register(&h, &l, val)
}

@(private)
get_combined_register :: proc(high: u8, low: u8) -> u16{
    return u16(high) << 8 | u16(low)
}

@(private)
set_combined_register :: proc(high: ^u8, low: ^u8, val: u16){
    high^ = u8((val & MaskHigh16) >> 8)
    low^ = u8(val & MaskLow16)
}

get_flag :: proc(reg: Register, val: FlagRegister) -> bool{
    return true if (reg.f & u8(val)) > 1 else false
}

set_flag :: proc{
    set_flag_from_flag,
    set_flag_from_u8
}

@(private)
set_flag_from_flag :: proc(reg: ^Register, val: FlagRegister){
    reg.f |= u8(val)
}

@(private)
set_flag_from_u8 :: proc(reg: ^Register, val: u8){
    reg.f |= val
}