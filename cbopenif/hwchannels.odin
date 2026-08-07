package cbopenif

HWChannels :: distinct rawptr

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

hwchannels_add :: proc {
    hwchannels_add_,
    hwchannels_add_at_index,
}

hwchannels_add_ :: proc(hwchannels: HWChannels, hwchannel: HWChannel) -> (ok: bool) {
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Add(hwchannel)
    if com_failed(hr) do return

    return true
}

hwchannels_add_at_index :: proc(hwchannels: HWChannels, hwchannel: HWChannel, index: i32) -> (ok: bool) {
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->AddBefore(hwchannel, index)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel :: proc {
    hwchannels_hwchannel_by_address,
    hwchannels_hwchannel_by_index,
}

hwchannels_hwchannel_by_address :: proc(hwchannels: HWChannels, address: string) -> (hwchannel: HWChannel, ok: bool) {
    if hwchannels == nil do return
    if !controlbuilder_connected() do return

    bstr_address := to_bstr(address)
    defer bstr_free(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->Find(bstr_address, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannels_hwchannel_by_index :: proc(hwchannels: HWChannels, index: i32) -> (hwchannel: HWChannel, ok: bool) {
    if hwchannels == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Item(index, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannels_hwchannel_index :: proc(hwchannels: HWChannels, address: string) -> (index: i32, ok: bool) {
    if hwchannels == nil do return
    if !controlbuilder_connected() do return

    bstr_address := to_bstr(address)
    defer bstr_free(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->FindNr(bstr_address, &index)
    if com_failed(hr) do return

    return index, true
}

hwchannels_hwchannel_count :: proc(hwchannels: HWChannels) -> (count: i32, ok: bool) {
    if hwchannels == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

hwchannels_hwchannel_remove :: proc {
    hwchannels_hwchannel_remove_by_address,
    hwchannels_hwchannel_remove_by_index,
}

hwchannels_hwchannel_remove_by_address :: proc(hwchannels: HWChannels, address: string) -> (ok: bool) {
    if hwchannels == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = hwchannels_hwchannel_index(hwchannels, address)
    if !ok do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_remove_by_index :: proc(hwchannels: HWChannels, index: i32) -> (ok: bool) {
    if hwchannels == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwchannels_release :: proc(hwchannels: HWChannels) {
    if hwchannels != nil {
        (^HWChannelsIF)(hwchannels)->Release()
    }
}
