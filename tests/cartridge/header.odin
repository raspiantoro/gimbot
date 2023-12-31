package tests_cartridge

import "core:testing"
import "core:fmt"
import "core:strings"
import "../../cartridge"
import "../../cartridge/mbc"

EndOfHeader :: 0x14F

@(test)
test_header_get_title :: proc(t: ^testing.T){
    title_bytes := [cartridge.HEADER_TITLE.length]byte{70, 73, 71, 72, 84, 73, 78, 71, 32, 71, 65, 77, 69, 0, 0, 0} // "FIGHTING GAME"

    rom := make(mbc.Rom, EndOfHeader)

    for i := cartridge.HEADER_TITLE.start; i < cartridge.HEADER_TITLE.start + cartridge.HEADER_TITLE.length ; i += 1{
        rom[i] = title_bytes[i - cartridge.HEADER_TITLE.start]
    }

    cart := cartridge.Cart{
       mbc = mbc.setup_mbc(rom, cartridge.cart_type(&rom)),
    }
    

    expected_title := "FIGHTING GAME"

    title := cartridge.title(cart->get_rom())
    testing.expect_value(t, strings.trim_null(title), expected_title)
}

@(test)
test_header_get_logo :: proc(t: ^testing.T){
    logo_bytes := [cartridge.HEADER_LOGO.length]byte{
        0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B, 0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D,
        0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00,0x0E, 0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99,
        0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC, 0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E,
    }

    rom := make(mbc.Rom, EndOfHeader)

    for i := cartridge.HEADER_LOGO.start; i < cartridge.HEADER_LOGO.start + cartridge.HEADER_LOGO.length ; i += 1{
        rom[i] = logo_bytes[i - cartridge.HEADER_LOGO.start]
    }

    cart := cartridge.Cart{
        mbc = mbc.setup_mbc(rom, cartridge.cart_type(&rom)),
     }

    expected_logo_bytes := logo_bytes

    result := cartridge.logo(cart->get_rom())

    for i :u16 = 0; i < cartridge.HEADER_LOGO.length; i += 1{
        testing.expect(
            t, 
            result[i] == expected_logo_bytes[i], 
            fmt.tprintf("failed on index %d, expected: %d, got: %d", i, expected_logo_bytes[i], result[i]),
        )
    }
}

@(test)
test_header_get_old_license :: proc(t: ^testing.T){
    rom := make(mbc.Rom, EndOfHeader)
    rom[cartridge.HEADER_OLD_LICENSE_CODE.start] = 0x08 // capcom lic code

    cart := cartridge.Cart{
        mbc = mbc.setup_mbc(rom, cartridge.cart_type(&rom)),
     }

    expected_license_name := "Capcom"

    license_name := cartridge.license(cart->get_rom())
    testing.expect_value(t, license_name, expected_license_name)
}

@(test)
test_header_get_new_license :: proc(t: ^testing.T){
    rom := make(mbc.Rom, EndOfHeader)
    rom[cartridge.HEADER_OLD_LICENSE_CODE.start] = 0x33        // indicates using new license code
    rom[cartridge.HEADER_NEW_LICENSE_CODE.start] = 0x35        // set high bytes of new license code
    rom[cartridge.HEADER_NEW_LICENSE_CODE.start + 1] = 0x34    // set low bytes of new license code

    cart := cartridge.Cart{
        mbc = mbc.setup_mbc(rom, cartridge.cart_type(&rom)),
     }

    expected_license_name := "Konami"

    license_name := cartridge.license(cart->get_rom())
    testing.expect_value(t, license_name, expected_license_name)
}

@(test)
test_header_valid_checksum :: proc(t: ^testing.T){
    rom := make(mbc.Rom, EndOfHeader)
    rom[0x134] = 30     // checksum compute bytes
    rom[0x135] = 30     // checksum compute bytes
    rom[0x136] = 30     // checksum compute bytes
    rom[0x137] = 30     // checksum compute bytes
    rom[0x138] = 30     // checksum compute bytes
    rom[0x139] = 30     // checksum compute bytes
    rom[0x13A] = 30     // checksum compute bytes
    rom[0x13B] = 30     // checksum compute bytes
    rom[0x13C] = 30     // checksum compute bytes
    rom[0x13D] = 30     // checksum compute bytes
    rom[0x13E] = 30     // checksum compute bytes
    rom[0x13F] = 30     // checksum compute bytes
    rom[0x140] = 30     // checksum compute bytes
    rom[0x141] = 30     // checksum compute bytes
    rom[0x145] = 30     // checksum compute bytes
    rom[0x146] = 30     // checksum compute bytes
    rom[0x147] = 30     // checksum compute bytes
    rom[0x148] = 30     // checksum compute bytes
    rom[0x149] = 30     // checksum compute bytes
    rom[0x14A] = 30     // checksum compute bytes
    rom[0x14B] = 30     // checksum compute bytes
    rom[0x14C] = 30     // checksum compute bytes

    // checkusm value, compare with lower 8 bits of checksum bytes compute result of 0x134 to 0x14C
    rom[cartridge.HEADER_CHECK_SUM.start] = 83  

    cart := cartridge.Cart{
        mbc = mbc.setup_mbc(rom, cartridge.cart_type(&rom)),
     }

    expected_err :cartridge.CartridgeError = nil

    err := cartridge.checksum(cart->get_rom())
    testing.expect_value(t, err, expected_err)
}

@(test)
test_header_invalid_checksum :: proc(t: ^testing.T){
    rom := make(mbc.Rom, EndOfHeader)
    rom[0x134] = 30     // checksum compute bytes
    rom[0x135] = 30     // checksum compute bytes
    rom[0x136] = 30     // checksum compute bytes
    rom[0x137] = 30     // checksum compute bytes
    rom[0x138] = 30     // checksum compute bytes
    rom[0x139] = 30     // checksum compute bytes
    rom[0x13A] = 30     // checksum compute bytes
    rom[0x13B] = 30     // checksum compute bytes
    rom[0x13C] = 30     // checksum compute bytes
    rom[0x13D] = 30     // checksum compute bytes
    rom[0x13E] = 30     // checksum compute bytes
    rom[0x13F] = 30     // checksum compute bytes
    rom[0x140] = 30     // checksum compute bytes
    rom[0x141] = 30     // checksum compute bytes
    rom[0x145] = 30     // checksum compute bytes
    rom[0x146] = 30     // checksum compute bytes
    rom[0x147] = 30     // checksum compute bytes
    rom[0x148] = 30     // checksum compute bytes
    rom[0x149] = 30     // checksum compute bytes
    rom[0x14A] = 30     // checksum compute bytes
    rom[0x14B] = 30     // checksum compute bytes
    rom[0x14C] = 30     // checksum compute bytes

    // checkusm value, compare with lower 8 bits of checksum bytes compute result of 0x134 to 0x14C
    rom[cartridge.HEADER_CHECK_SUM.start] = 145  

    cart := cartridge.Cart{
        mbc = mbc.setup_mbc(rom, cartridge.cart_type(&rom)),
     }

    expected_err := cartridge.CartridgeError.InvalidChecksum

    err := cartridge.checksum(cart->get_rom())
    testing.expect_value(t, err, expected_err)
}