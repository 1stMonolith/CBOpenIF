package com

import t "../types"

HWChannel  :: distinct rawptr
HWChannels :: distinct rawptr

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

hwchannel_name_get :: proc(hwchannel: HWChannel) -> (name: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_name_set :: proc(hwchannel: HWChannel, name: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_address_get :: proc(hwchannel: HWChannel) -> (address: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_address_set :: proc(hwchannel: HWChannel, address: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(address)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_min_get :: proc(hwchannel: HWChannel) -> (min: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MinGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_min_set :: proc(hwchannel: HWChannel, min: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(min)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MinPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_max_get :: proc(hwchannel: HWChannel) -> (max: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_max_set :: proc(hwchannel: HWChannel, max: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(max)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_unit_get :: proc(hwchannel: HWChannel) -> (unit: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_unit_set :: proc(hwchannel: HWChannel, unit: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(unit)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_fraction_get :: proc(hwchannel: HWChannel) -> (fraction: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_fraction_set :: proc(hwchannel: HWChannel, fraction: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(fraction)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_reversed_get :: proc(hwchannel: HWChannel) -> (reversed: bool, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->ReversedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwchannel_reversed_set :: proc(hwchannel: HWChannel, reversed: bool) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelIF)(hwchannel)->ReversedPut(to_variantbool(reversed))
    if com_failed(hr) do return

    return true
}

hwchannel_con_variable_get :: proc(hwchannel: HWChannel) -> (con_variable: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariableGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_con_variable_set :: proc(hwchannel: HWChannel, con_variable: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(con_variable)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariablePut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_io_description_get :: proc(hwchannel: HWChannel) -> (io_description: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_io_description_set :: proc(hwchannel: HWChannel, io_description: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(io_description)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_channel_type_get :: proc(hwchannel: HWChannel) -> (channel_type: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ChannelTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_is_signal_get :: proc(hwchannel: HWChannel) -> (is_signal: bool, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->IsSignalGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwchannel_is_signal_set :: proc(hwchannel: HWChannel, is_signal: bool) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelIF)(hwchannel)->IsSignalPut(to_variantbool(is_signal))
    if com_failed(hr) do return

    return true
}

hwchannel_release :: proc(hwchannel: HWChannel) {
    if hwchannel != nil {
        (^HWChannelIF)(hwchannel)->Release()
    }
}

hwchannel_from_com :: proc(hwchannel: HWChannel, allocator := context.allocator) -> (result: t.HWChannel, ok: bool) {
    if hwchannel == nil do return

    context.allocator = allocator

    result.name, ok = name(hwchannel)
    if !ok do return
    result.address, ok = address(hwchannel)
    if !ok do return
    result.min, ok = min(hwchannel)
    if !ok do return
    result.max, ok = max(hwchannel)
    if !ok do return
    result.unit, ok = unit(hwchannel)
    if !ok do return
    result.fraction, ok = fraction(hwchannel)
    if !ok do return
    result.reversed, ok = reversed(hwchannel)
    if !ok do return
    result.con_variable, ok = con_variable(hwchannel)
    if !ok do return
    result.io_description, ok = hwchannel_io_description_get(hwchannel)
    if !ok do return

    return result, true
}

hwchannel_to_com :: proc(src: t.HWChannel) -> (result: HWChannel, ok: bool) {
    hwchannel: HWChannel
    hwchannel, ok = hwchannel_new1(
        src.address,
        src.name,
        src.con_variable,
        src.io_description,
        src.min,
        src.max,
        src.unit,
        src.fraction,
        src.reversed,
    )
    if !ok do return

    return hwchannel, true
}

HWChannelsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWChannelsVTable,
}

HWChannelsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^HWChannelsIF, HWChannel: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^HWChannelsIF, HWChannel: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^HWChannelsIF, Address, Name, ConVariable, IODescription: BStr, HWChannel: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^HWChannelsIF, Address, Name, ConVariable, IODescription, Min, Max, Unit, Fraction: BStr, Reversed: VariantBool, HWChannel: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^HWChannelsIF, Address: BStr, HWChannel: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^HWChannelsIF, Address: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^HWChannelsIF, Index: i32, HWChannel: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^HWChannelsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^HWChannelsIF, Index: i32) -> HResult,
}

hwchannels_hwchannel_add :: proc(hwchannels: HWChannels, hwchannel: HWChannel) -> (ok: bool) {
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Add(hwchannel)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_add_at_index :: proc(hwchannels: HWChannels, hwchannel: HWChannel, index: i32) -> (ok: bool) {
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->AddBefore(hwchannel, index)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_by_address :: proc(hwchannels: HWChannels, address: string) -> (hwchannel: HWChannel, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    bstr_address := to_bstr(address)
    defer bstr_free(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->Find(bstr_address, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannels_hwchannel_by_index :: proc(hwchannels: HWChannels, index: i32) -> (hwchannel: HWChannel, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Item(index + 1, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannels_hwchannel_index :: proc(hwchannels: HWChannels, address: string) -> (index: i32, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    bstr_address := to_bstr(address)
    defer bstr_free(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->FindNr(bstr_address, &index)
    if com_failed(hr) do return

    return index - 1, true
}

hwchannels_hwchannel_count :: proc(hwchannels: HWChannels) -> (count: i32, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

hwchannels_hwchannel_remove_by_address :: proc(hwchannels: HWChannels, address: string) -> (ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    index: i32
    index, ok = hwchannels_hwchannel_index(hwchannels, address)
    if !ok do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_remove_by_index :: proc(hwchannels: HWChannels, index: i32) -> (ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

hwchannels_release :: proc(hwchannels: HWChannels) {
    if hwchannels != nil {
        (^HWChannelsIF)(hwchannels)->Release()
    }
}
