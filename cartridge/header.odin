package cartridge

@(private)
Offset :: struct{
    start: u16,
    length: u16,
}


// setup header information locations
// https://gbdev.io/pandocs/The_Cartridge_Header.html


@(private)
HEADER_ENTRY_POINT :: Offset{0x100, 4}
HEADER_LOGO :: Offset{0x104, 48}
HEADER_TITLE :: Offset{0x134, 16}
HEADER_MANUFACURE_CODE :: Offset{0x13F, 4}
HEADER_CGB_FLAG :: Offset{0x143, 1}
HEADER_NEW_LICENSE_CODE :: Offset{0x144, 2}
HEADER_SGB_FLAG :: Offset{0x146, 1}
HEADER_CARTRIGE_TYPE :: Offset{0x147, 1}
HEADER_ROM_SIZE :: Offset{0x148, 1}
HEADER_RAM_SIZE :: Offset{0x149, 1}
HEADER_DEST_CODE :: Offset{0x14A, 1}
HEADER_OLD_LICENSE_CODE :: Offset{0x14B, 1}
HEADER_VERSION_NUMBER :: Offset{0x14C, 1}
HEADER_CHECK_SUM :: Offset{0x14D, 1}
HEADER_GLOBAL_CHECK_SUM :: Offset{0x14E, 2}

logo :: proc() -> []byte{
    return ctx.data[HEADER_LOGO.start:][:HEADER_LOGO.length]
}

title :: proc() -> string{
    return string(ctx.data[HEADER_TITLE.start:][:HEADER_TITLE.length])
}

license :: proc() -> string{
    if old_license() == 0x33{
        v := ctx.data[HEADER_NEW_LICENSE_CODE.start:][:HEADER_NEW_LICENSE_CODE.length]
        key: string = string(v)
        return new_license_name[key]
    }
    
    return old_license_name[old_license()]
}

@(private)
old_license :: proc() -> u8{
    v := ctx.data[HEADER_OLD_LICENSE_CODE.start]
    return v
}

checksum :: proc() -> CartridgeError{
    val := 0
    for i :u16 = 0x134; i <= 0x14C; i+=1 {
        val = val - int(ctx.data[i]) - 1
    }

    return nil if u8(val) == ctx.data[HEADER_CHECK_SUM.start] else CartridgeError.InvalidChecksum
}