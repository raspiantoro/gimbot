package cartridge

import "core:os"
import "core:fmt"
import "mbc"
import "../error"

Rom :: mbc.Rom
Mbc :: mbc.Mbc
CartridgeError :: error.CartridgeError


Cart :: struct{
    using mbc: ^Mbc,
}

load :: proc(filename: string, do_checksum:= true) -> (cart: Cart, err: CartridgeError){
    data, ok := os.read_entire_file_from_filename(filename)
    if !ok {
        return cart, CartridgeError.ReadFileFailed
    }

    checksum(&data) or_return

    cart = Cart{
        mbc = mbc.setup_mbc(data, cart_type(&data))
    }

    return
}