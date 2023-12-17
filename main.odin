package main

import "core:fmt"
import "core:runtime"
import "core:log"
import "core:os"
import "cpu"
import "cartridge"

main :: proc(){
    defer cleanup_system()

    context.allocator = runtime.default_allocator()
    context.logger = log.create_console_logger()

    fmt.println("GIMBOT")
    
    if len(os.args) == 1 {
        log.panicf("No rom file provided.\n")
    }

    cart, err := cartridge.load(os.args[1])
    if err == cartridge.CartridgeError.ReadFileFailed{
        log.panicf("Error when reading file or file not exists: %v\n", os.args[1])
    }
    if err != nil{
        log.panicf("Error loading rom: %v\n", err)
    }

    fmt.println("Cartridge loaded")
    fmt.printf("Title: %s\n", cartridge.title(cart->get_rom()))
    fmt.printf("license: %v\n", cartridge.license(cart->get_rom()))
    fmt.printf("cartridge type: %d\n", cartridge.cart_type(cart->get_rom()))
    fmt.printf("rom size: %d\n", cartridge.rom_size(cart->get_rom()))

    cart->write(0x2000, 0)
    val: u8

    val, err = cart->read(0x2000)
    if err != nil{
        log.panicf("Error reading rom: %v\n", err)
    }

    fmt.printf("Val 1: %d\n", val)

    val, err = cart->read(0x7000)
    if err != nil{
        log.panicf("Error reading rom: %v\n", err)
    }

    fmt.printf("Val 2: %d\n", val)
}

cleanup_system :: proc(){
    
}