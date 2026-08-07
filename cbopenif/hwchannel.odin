package cbopenif

HWChannel :: distinct rawptr

HWChannelIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWChannelVTable,
}

HWChannelVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:          proc "system" (this: ^HWChannelIF, Name: ^BStr) -> HResult,
    NamePut:          proc "system" (this: ^HWChannelIF, Name: BStr) -> HResult,
    AddressGet:       proc "system" (this: ^HWChannelIF, Address: ^BStr) -> HResult,
    AddressPut:       proc "system" (this: ^HWChannelIF, Address: BStr) -> HResult,
    MinGet:           proc "system" (this: ^HWChannelIF, Min: ^BStr) -> HResult,
    MinPut:           proc "system" (this: ^HWChannelIF, Min: BStr) -> HResult,
    MaxGet:           proc "system" (this: ^HWChannelIF, Max: ^BStr) -> HResult,
    MaxPut:           proc "system" (this: ^HWChannelIF, Max: BStr) -> HResult,
    UnitGet:          proc "system" (this: ^HWChannelIF, Unit: ^BStr) -> HResult,
    UnitPut:          proc "system" (this: ^HWChannelIF, Unit: BStr) -> HResult,
    FractionGet:      proc "system" (this: ^HWChannelIF, Fraction: ^BStr) -> HResult,
    FractionPut:      proc "system" (this: ^HWChannelIF, Fraction: BStr) -> HResult,
    ReversedGet:      proc "system" (this: ^HWChannelIF, Reversed: ^VariantBool) -> HResult,
    ReversedPut:      proc "system" (this: ^HWChannelIF, Reversed: VariantBool) -> HResult,
    ConVariableGet:   proc "system" (this: ^HWChannelIF, ConVariable: ^BStr) -> HResult,
    ConVariablePut:   proc "system" (this: ^HWChannelIF, ConVariable: BStr) -> HResult,
    IODescriptionGet: proc "system" (this: ^HWChannelIF, IODescription: ^BStr) -> HResult,
    IODescriptionPut: proc "system" (this: ^HWChannelIF, IODescription: BStr) -> HResult,
    ChannelTypeGet:   proc "system" (this: ^HWChannelIF, ChannelType: ^BStr) -> HResult,
    IsSignalGet:      proc "system" (this: ^HWChannelIF, IsSignal: ^VariantBool) -> HResult,
    IsSignalPut:      proc "system" (this: ^HWChannelIF, IsSignal: VariantBool) -> HResult,
}

hwchannel_new :: proc(address, name, con_variable, io_description, min, max, unit, fraction: string, reversed: bool) -> (hwchannel: HWChannel, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_address        := to_bstr(address)
    bstr_name           := to_bstr(name)
    bstr_con_variable   := to_bstr(con_variable)
    bstr_io_description := to_bstr(io_description)
    bstr_min            := to_bstr(min)
    bstr_max            := to_bstr(max)
    bstr_unit           := to_bstr(unit)
    bstr_fraction       := to_bstr(fraction)
    defer {
        bstr_free(bstr_address)
        bstr_free(bstr_name)
        bstr_free(bstr_con_variable)
        bstr_free(bstr_io_description)
        bstr_free(bstr_min)
        bstr_free(bstr_max)
        bstr_free(bstr_unit)
        bstr_free(bstr_fraction)
    }
    hr := factoryif->NewHWChannel1(
        bstr_address, bstr_name, bstr_con_variable, bstr_io_description,
        bstr_min, bstr_max, bstr_unit, bstr_fraction,
        to_variantbool(reversed),
        cast(^rawptr)&hwchannel,
    )
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannel_name :: proc {
    hwchannel_name_get,
    hwchannel_name_set,
}

hwchannel_name_get :: proc(hwchannel: HWChannel) -> (name: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_name_set :: proc(hwchannel: HWChannel, name: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_address :: proc {
    hwchannel_address_get,
    hwchannel_address_set,
}

hwchannel_address_get :: proc(hwchannel: HWChannel) -> (address: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_address_set :: proc(hwchannel: HWChannel, address: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(address)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_min :: proc {
    hwchannel_min_get,
    hwchannel_min_set,
}

hwchannel_min_get :: proc(hwchannel: HWChannel) -> (min: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MinGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_min_set :: proc(hwchannel: HWChannel, min: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(min)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MinPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_max :: proc {
    hwchannel_max_get,
    hwchannel_max_set,
}

hwchannel_max_get :: proc(hwchannel: HWChannel) -> (max: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_max_set :: proc(hwchannel: HWChannel, max: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(max)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_unit :: proc {
    hwchannel_unit_get,
    hwchannel_unit_set,
}

hwchannel_unit_get :: proc(hwchannel: HWChannel) -> (unit: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_unit_set :: proc(hwchannel: HWChannel, unit: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(unit)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_fraction :: proc {
    hwchannel_fraction_get,
    hwchannel_fraction_set,
}

hwchannel_fraction_get :: proc(hwchannel: HWChannel) -> (fraction: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_fraction_set :: proc(hwchannel: HWChannel, fraction: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(fraction)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_reversed :: proc {
    hwchannel_reversed_get,
    hwchannel_reversed_set,
}

hwchannel_reversed_get :: proc(hwchannel: HWChannel) -> (reversed: bool, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->ReversedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwchannel_reversed_set :: proc(hwchannel: HWChannel, reversed: bool) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelIF)(hwchannel)->ReversedPut(to_variantbool(reversed))
    if com_failed(hr) do return

    return true
}

hwchannel_con_variable :: proc {
    hwchannel_con_variable_get,
    hwchannel_con_variable_set,
}

hwchannel_con_variable_get :: proc(hwchannel: HWChannel) -> (con_variable: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariableGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_con_variable_set :: proc(hwchannel: HWChannel, con_variable: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(con_variable)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariablePut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_io_description :: proc {
    hwchannel_io_description_get,
    hwchannel_io_description_set,
}

hwchannel_io_description_get :: proc(hwchannel: HWChannel) -> (io_description: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_io_description_set :: proc(hwchannel: HWChannel, io_description: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(io_description)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_channel_type_get :: proc(hwchannel: HWChannel) -> (channel_type: string, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ChannelTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_is_signal :: proc {
    hwchannel_is_signal_get,
    hwchannel_is_signal_set,
}

hwchannel_is_signal_get :: proc(hwchannel: HWChannel) -> (is_signal: bool, ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->IsSignalGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwchannel_is_signal_set :: proc(hwchannel: HWChannel, is_signal: bool) -> (ok: bool) {
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelIF)(hwchannel)->IsSignalPut(to_variantbool(is_signal))
    if com_failed(hr) do return

    return true
}

hwchannel_release :: proc(hwchannel: HWChannel) {
    if hwchannel != nil {
        (^HWChannelIF)(hwchannel)->Release()
    }
}
