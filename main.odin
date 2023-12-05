package main

import "core:fmt"
import "cpu"

main :: proc(){
    fmt.println("GIMBOT")

    reg1 := cpu.Register{}
    reg1.b = 5
    reg1.c = 9

    fmt.printf("reg1 b: %d\n", reg1.b)
    fmt.printf("reg1 c: %d\n", reg1.c)
    fmt.printf("reg1 bc: %d\n", cpu.get_bc(reg1))

    reg2 := cpu.Register{}
    cpu.set_bc(&reg2, 1289)

    fmt.printf("reg2 b: %d\n", reg2.b)
    fmt.printf("reg2 c: %d\n", reg2.c)
    fmt.printf("reg2 bc: %d\n", cpu.get_bc(reg2))

    reg3 := cpu.Register{}
    reg3.a = 5
    reg3.f = 9

    fmt.printf("reg3 a: %d\n", reg3.a)
    fmt.printf("reg3 f: %d\n", reg3.f)
    fmt.printf("reg3 af: %d\n", cpu.get_af(reg3))

    reg4 := cpu.Register{}
    cpu.set_af(&reg4, 1289)

    fmt.printf("reg4 a: %d\n", reg4.a)
    fmt.printf("reg4 f: %d\n", reg4.f)
    fmt.printf("reg4 af: %d\n", cpu.get_af(reg4))

    x: u8
    fmt.printf("x: %b\n", x)

    x = u8(cpu.FlagRegister.Carry | cpu.FlagRegister.Zero)
    fmt.printf("x: %b\n", x)

    x |= u8(cpu.FlagRegister.Carry | cpu.FlagRegister.HalfCarry)
    fmt.printf("x: %b\n", x)

    reg5 := cpu.Register{}
    reg5.f = 0b0101_0000

    fmt.printf("is reg5 zero enable: %t\n", cpu.get_flag(reg5, cpu.FlagRegister.Zero))
    fmt.printf("is reg5 substract enable: %t\n", cpu.get_flag(reg5, cpu.FlagRegister.Substract))
    fmt.printf("is reg5 half carry enable: %t\n", cpu.get_flag(reg5, cpu.FlagRegister.HalfCarry))
    fmt.printf("is reg5 carry enable: %t\n", cpu.get_flag(reg5, cpu.FlagRegister.Carry))

    reg6 := cpu.Register{}
    // cpu.set_flag(&reg6, (cpu.FlagRegister.Zero | cpu.FlagRegister.Substract))
    // cpu.set_flag(&reg6, 64 | 16)
    cpu.set_flag(&reg6, 80)

    fmt.printf("is reg6 zero enable: %t\n", cpu.get_flag(reg6, cpu.FlagRegister.Zero))
    fmt.printf("is reg6 substract enable: %t\n", cpu.get_flag(reg6, cpu.FlagRegister.Substract))
    fmt.printf("is reg6 half carry enable: %t\n", cpu.get_flag(reg6, cpu.FlagRegister.HalfCarry))
    fmt.printf("is reg6 carry enable: %t\n", cpu.get_flag(reg6, cpu.FlagRegister.Carry))
}