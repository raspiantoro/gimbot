package tests_cartridge

import "core:testing"
import "core:fmt"
import "../../cartridge"

@(test)
test_cart_load_file_exists :: proc(t: ^testing.T){
    expecetd_err :cartridge.CartridgeError = nil
    _, err := cartridge.load("test-rom/01-special.gb")
    testing.expect_value(t, err, expecetd_err)
}

@(test)
test_cart_load_file_not_exists :: proc(t: ^testing.T){
    expecetd_err :cartridge.CartridgeError = cartridge.CartridgeError.ReadFileFailed
    _, err := cartridge.load("abc")
    testing.expect_value(t, err, expecetd_err)
}