package mbc

import "core:fmt"

Mbc1 :: struct{
    using mbc: Mbc,
    rom: Rom,
    selected_rom_bank: u8,
    selected_ram_bank: u8,
}

mbc1_read :: proc(self: ^Mbc, addr: u16) -> (u8, CartridgeError){
    mbc := cast(^Mbc1)self

    if addr < 0x4000{
        return mbc.rom[addr], nil
    }

    if addr > 0x7FFF {
        return 0, CartridgeError.WrongAddressRead
    }

    fmt.printf("read addr: %x\n", addr)
    fmt.printf("selected rom bank: %d\n", mbc.selected_rom_bank)
    fmt.printf("bank rom rel addr: %#04x\n", u32(addr) + (u32(MbcOffset) * u32(mbc.selected_rom_bank - 1)))

    return mbc.rom[u32(addr) + (u32(MbcOffset) * u32(mbc.selected_rom_bank - 1))], nil
}

mbc1_write :: proc(self: ^Mbc, addr: u16, val: u8) -> CartridgeError{
    mbc := cast(^Mbc1)self

    if addr < 0x2000{
        return nil
    }

    if addr < 0x4000{
        mbc.selected_rom_bank = (val & 0b11111) == 0 ? 1 : (val & 0b11111)
        return nil
    }

    if addr > 0x7FFF {
        return CartridgeError.WrongAddressWrite
    }

    return nil
}

mbc1_get_rom :: proc(self: ^Mbc) -> ^Rom{
    mbc := cast(^Mbc1)self
    return &mbc.rom
}