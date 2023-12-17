package mbc

import "../../error"

Rom :: []byte
MbcOffset :: 0x4000
CartridgeError :: error.CartridgeError

Mbc :: struct{
    read: proc(self: ^Mbc, addr: u16) -> (u8, CartridgeError),
    write: proc(self: ^Mbc, addr: u16, val: u8) -> CartridgeError,
    get_rom: proc(self: ^Mbc) -> ^Rom
}

setup_mbc :: proc(rom: Rom, type: u8, allocator:= context.allocator) -> ^Mbc{
    if type == 0 {
        no_mbc := new(NoMbc, allocator)
        no_mbc.read = no_mbc_read
        no_mbc.write = no_mbc_write
        no_mbc.get_rom = no_mbc_get_rom
        no_mbc.rom = rom
        
        return no_mbc
    }

    mbc1 := new(Mbc1, allocator)
    mbc1.read = mbc1_read
    mbc1.write = mbc1_write
    mbc1.get_rom = mbc1_get_rom
    mbc1.rom = rom

    return mbc1
}