package tests_cpu_registers

import "core:testing"
import "core:fmt"
import "../../cpu"

@(test)
test_get_af :: proc(t: ^testing.T){
    N :: 3
    
    regs := #soa[N]cpu.Register{}
    regs[0].a = 5   // 0x05
    regs[0].f = 9   // 0x09
    regs[1].a = 79  // 0x4F
    regs[1].f = 163 // 0xA3
    regs[2].a = 137 // 0x89
    regs[2].f = 255 // 0xFF

    expected := [N]u16{1289, 20387, 35327}

    for regs, i in regs{
        testing.expect(
            t, 
            expected[i] == cpu.get_af(regs), 
            fmt.tprintf("Expected af[%d] is: %d, got: %d", i, expected[i], cpu.get_af(regs)),
        )
    }
}

@(test)
test_set_af :: proc(t: ^testing.T){
    N :: 3
    
    afs := [N]u16{1289, 20387, 35327}

    expect :: struct{
        a: u8,
        f: u8
    }
    expected := #soa[N]expect{}
    expected[0].a = 5   // 0x05
    expected[0].f = 9   // 0x09
    expected[1].a = 79  // 0x4F
    expected[1].f = 163 // 0xA3
    expected[2].a = 137 // 0x89
    expected[2].f = 255 // 0xFF

    reg := cpu.Register{}

    for af, i in afs{
        cpu.set_af(&reg, af)

        testing.expect(
            t, 
            expected[i].a == reg.a, 
            fmt.tprintf("Expected a[%d] is: %d, got: %d", i, expected[i].a, reg.a),
        )

        testing.expect(
            t, 
            expected[i].f == reg.f, fmt.tprintf("Expected f[%d] is: %d, got: %d", i, expected[i].a, reg.a),
        )
    }
}

@(test)
test_get_bc :: proc(t: ^testing.T){
    N :: 3
    
    regs := #soa[N]cpu.Register{}
    regs[0].b = 5   // 0x05
    regs[0].c = 9   // 0x09
    regs[1].b = 79  // 0x4F
    regs[1].c = 163 // 0xA3
    regs[2].b = 137 // 0x89
    regs[2].c = 255 // 0xFF

    expected := [N]u16{1289, 20387, 35327}

    for regs, i in regs{
        testing.expect(
            t, 
            expected[i] == cpu.get_bc(regs), 
            fmt.tprintf("Expected bc[%d] is: %d, got: %d", i, expected[i], cpu.get_bc(regs)),
        )
    }
}

@(test)
test_set_bc :: proc(t: ^testing.T){
    N :: 3
    
    bcs := [N]u16{1289, 20387, 35327}

    expect :: struct{
        b: u8,
        c: u8
    }
    expected := #soa[N]expect{}
    expected[0].b = 5   // 0x05
    expected[0].c = 9   // 0x09
    expected[1].b = 79  // 0x4F
    expected[1].c = 163 // 0xA3
    expected[2].b = 137 // 0x89
    expected[2].c = 255 // 0xFF

    reg := cpu.Register{}

    for bc, i in bcs{
        cpu.set_bc(&reg, bc)

        testing.expect(
            t, 
            expected[i].b == reg.b, 
            fmt.tprintf("Expected b[%d] is: %d, got: %d", i, expected[i].b, reg.b),
        )

        testing.expect(
            t, 
            expected[i].c == reg.c, 
            fmt.tprintf("Expected c[%d] is: %d, got: %d", i, expected[i].c, reg.c),
        )
    }
}

@(test)
test_get_de :: proc(t: ^testing.T){
    N :: 3
    
    regs := #soa[N]cpu.Register{}
    regs[0].d = 5   // 0x05
    regs[0].e = 9   // 0x09
    regs[1].d = 79  // 0x4F
    regs[1].e = 163 // 0xA3
    regs[2].d = 137 // 0x89
    regs[2].e = 255 // 0xFF

    expected := [N]u16{1289, 20387, 35327}

    for regs, i in regs{
        testing.expect(
            t, 
            expected[i] == cpu.get_de(regs), 
            fmt.tprintf("Expected de[%d] is: %d, got: %d", i, expected[i], cpu.get_de(regs)),
        )
    }
}

@(test)
test_set_de :: proc(t: ^testing.T){
    N :: 3
    
    des := [N]u16{1289, 20387, 35327}

    expect :: struct{
        d: u8,
        e: u8
    }
    expected := #soa[N]expect{}
    expected[0].d = 5   // 0x05
    expected[0].e = 9   // 0x09
    expected[1].d = 79  // 0x4F
    expected[1].e = 163 // 0xA3
    expected[2].d = 137 // 0x89
    expected[2].e = 255 // 0xFF

    reg := cpu.Register{}

    for de, i in des{
        cpu.set_de(&reg, de)

        testing.expect(
            t, 
            expected[i].d == reg.d, 
            fmt.tprintf("Expected d[%d] is: %d, got: %d", i, expected[i].d, reg.d),
        )

        testing.expect(
            t, 
            expected[i].e == reg.e, 
            fmt.tprintf("Expected e[%d] is: %d, got: %d", i, expected[i].e, reg.e),
        )
    }
}

@(test)
test_get_hl :: proc(t: ^testing.T){
    N :: 3
    
    regs := #soa[N]cpu.Register{}
    regs[0].h = 5   // 0x05
    regs[0].l = 9   // 0x09
    regs[1].h = 79  // 0x4F
    regs[1].l = 163 // 0xA3
    regs[2].h = 137 // 0x89
    regs[2].l = 255 // 0xFF

    expected := [N]u16{1289, 20387, 35327}

    for regs, i in regs{
        testing.expect(
            t, 
            expected[i] == cpu.get_hl(regs), 
            fmt.tprintf("Expected hl[%d] is: %d, got: %d", i, expected[i], cpu.get_hl(regs)),
        )
    }
}

@(test)
test_set_hl :: proc(t: ^testing.T){
    N :: 3
    
    hls := [N]u16{1289, 20387, 35327}

    expect :: struct{
        h: u8,
        l: u8
    }
    expected := #soa[N]expect{}
    expected[0].h = 5   // 0x05
    expected[0].l = 9   // 0x09
    expected[1].h = 79  // 0x4F
    expected[1].l = 163 // 0xA3
    expected[2].h = 137 // 0x89
    expected[2].l = 255 // 0xFF

    reg := cpu.Register{}

    for hl, i in hls{
        cpu.set_hl(&reg, hl)

        testing.expect(
            t, 
            expected[i].h == reg.h, 
            fmt.tprintf("Expected h[%d] is: %d, got: %d", i, expected[i].h, reg.l),
        )

        testing.expect(
            t, 
            expected[i].l == reg.l, 
            fmt.tprintf("Expected l[%d] is: %d, got: %d", i, expected[i].l, reg.l),
        )
    }
}

@(test)
test_get_flag :: proc(t: ^testing.T){
    reg := cpu.Register{
        f = 96, // 0b0110_0000
    }

    expect :: struct{
        Zero: bool,
        Substract: bool,
        HalfCarry: bool,
        Carry: bool
    }

    expected := expect{false, true, true, false}

    result := cpu.get_flag(reg, cpu.FlagRegister.Zero)
    testing.expect(
        t, 
        result == expected.Zero,
        fmt.tprintf("Expected zero flag is: %t, got: %t", expected.Zero, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.Substract)
    testing.expect(
        t, 
        result == expected.Substract,
        fmt.tprintf("Expected substract flag is: %t, got: %t", expected.Substract, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.HalfCarry)
    testing.expect(
        t, 
        result == expected.HalfCarry,
        fmt.tprintf("Expected half carry flag is: %t, got: %t", expected.HalfCarry, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.Carry)
    testing.expect(
        t, 
        result == expected.Carry,
        fmt.tprintf("Expected carry flag is: %t, got: %t", expected.Carry, result),
    )
}

@(test)
test_set_flag_from_u8 :: proc(t: ^testing.T){
    reg := cpu.Register{}

    cpu.set_flag(&reg, 80) // 80 = 0b0101_0000

    expect :: struct{
        Zero: bool,
        Substract: bool,
        HalfCarry: bool,
        Carry: bool
    }

    expected := expect{false, true, false, true}

    result := cpu.get_flag(reg, cpu.FlagRegister.Zero)
    testing.expect(
        t, 
        result == expected.Zero,
        fmt.tprintf("Expected zero flag is: %t, got: %t", expected.Zero, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.Substract)
    testing.expect(
        t, 
        result == expected.Substract,
        fmt.tprintf("Expected substract flag is: %t, got: %t", expected.Substract, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.HalfCarry)
    testing.expect(
        t, 
        result == expected.HalfCarry,
        fmt.tprintf("Expected half carry flag is: %t, got: %t", expected.HalfCarry, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.Carry)
    testing.expect(
        t, 
        result == expected.Carry,
        fmt.tprintf("Expected carry flag is: %t, got: %t", expected.Carry, result),
    )
}

@(test)
test_set_flag_from_flag :: proc(t: ^testing.T){
    reg := cpu.Register{}

    cpu.set_flag(&reg, cpu.FlagRegister.Zero)
    cpu.set_flag(&reg, cpu.FlagRegister.Carry)

    expect :: struct{
        Zero: bool,
        Substract: bool,
        HalfCarry: bool,
        Carry: bool
    }

    expected := expect{true, false, false, true}

    result := cpu.get_flag(reg, cpu.FlagRegister.Zero)
    testing.expect(
        t, 
        result == expected.Zero,
        fmt.tprintf("Expected zero flag is: %t, got: %t", expected.Zero, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.Substract)
    testing.expect(
        t, 
        result == expected.Substract,
        fmt.tprintf("Expected substract flag is: %t, got: %t", expected.Substract, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.HalfCarry)
    testing.expect(
        t, 
        result == expected.HalfCarry,
        fmt.tprintf("Expected half carry flag is: %t, got: %t", expected.HalfCarry, result),
    )

    result = cpu.get_flag(reg, cpu.FlagRegister.Carry)
    testing.expect(
        t, 
        result == expected.Carry,
        fmt.tprintf("Expected carry flag is: %t, got: %t", expected.Carry, result),
    )
}