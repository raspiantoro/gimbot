package main

import "core:fmt"
import "core:runtime"
import "core:log"
import "core:os"
import "cpu"
import "cartridge"

main :: proc(){
    context.allocator = runtime.default_allocator()
    context.logger = log.create_console_logger()

    fmt.println("GIMBOT")
    
    if len(os.args) == 1 {
        log.panicf("No rom file provided.\n")
    }

    err := cartridge.load(os.args[1])
    if err == cartridge.CartridgeError.ReadFileFailed{
        log.panicf("Error when reading file or file not exists: %v\n", os.args[1])
    }
    if err != nil{
        log.panicf("Error loading rom: %v\n", err)
    }

    fmt.printf("Title: %s\n", cartridge.title())
    fmt.printf("license: %v\n", cartridge.license())
}