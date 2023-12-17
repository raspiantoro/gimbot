package mbc

NoMbc :: struct{
    using mbc: Mbc,
    rom: Rom,
}

no_mbc_read :: proc(self: ^Mbc, addr: u16) -> (u8, CartridgeError){
    if addr > 0x7FFF {
        return 0, CartridgeError.WrongAddressRead
    }

    mbc := cast(^NoMbc)self
    return mbc.rom[addr], nil
}

no_mbc_write :: proc(self: ^Mbc, addr: u16, val: u8) -> CartridgeError{
    return CartridgeError.ReadonlyRom
}

no_mbc_get_rom :: proc(self: ^Mbc) -> ^Rom{
    mbc := cast(^NoMbc)self
    return &mbc.rom
}