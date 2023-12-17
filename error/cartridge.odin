package error

CartridgeError :: enum{
    None,
    ReadFileFailed,
    InvalidChecksum,
    ReadonlyRom,
    WrongAddressRead,
    WrongAddressWrite,
}