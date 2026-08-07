package cbopenif

ConnectedHWLibraries :: distinct rawptr

ConnectedHWLibrariesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedHWLibrariesVTable,
}

ConnectedHWLibrariesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedHWLibrariesIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedHWLibrariesIF, ConnectedHWLibrary: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedHWLibrariesIF, ConnectedHWLibrary: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, ConnectedHWLibrary: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedHWLibrary: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, ConnectedHWLibrary: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedHWLibrariesIF, Index: i32, ConnectedHWLibrary: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedHWLibrariesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedHWLibrariesIF, Index: i32) -> HResult,
}

connectedhwlibraries_new :: proc() -> (chls: ConnectedHWLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewConnectedHWLibraries(cast(^rawptr)&chls)
    if com_failed(hr) do return

    return chls, true
}

connectedhwlibraries_deserialize :: proc(xml: string) -> (chls: ConnectedHWLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeConnectedHWLibraries(&bs, cast(^rawptr)&chls)
    if com_failed(hr) do return

    return chls, true
}

connectedhwlibraries_serialize :: proc(chls: ConnectedHWLibraries) -> (xml: string, ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibrariesIF)(chls)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibraries_add :: proc {
    connectedhwlibraries_add_,
    connectedhwlibraries_add_at_index,
}

connectedhwlibraries_add_ :: proc(chls: ConnectedHWLibraries, chl: ConnectedHWLibrary) -> (ok: bool) {
    if chls == nil do return
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(chls)->Add(chl)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_add_at_index :: proc(chls: ConnectedHWLibraries, chl: ConnectedHWLibrary, index: i32) -> (ok: bool) {
    if chls == nil do return
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(chls)->AddBefore(chl, index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary :: proc {
    connectedhwlibraries_connectedhwlibrary_by_name,
    connectedhwlibraries_connectedhwlibrary_by_index,
}

connectedhwlibraries_connectedhwlibrary_by_name :: proc(chls: ConnectedHWLibraries, name: string) -> (chl: ConnectedHWLibrary, ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(chls)->Find(bstr_name, cast(^rawptr)&chl)
    if com_failed(hr) do return

    return chl, true
}

connectedhwlibraries_connectedhwlibrary_by_index :: proc(chls: ConnectedHWLibraries, index: i32) -> (chl: ConnectedHWLibrary, ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(chls)->Item(index, cast(^rawptr)&chl)
    if com_failed(hr) do return

    return chl, true
}

connectedhwlibraries_connectedhwlibrary_index :: proc(chls: ConnectedHWLibraries, name: string) -> (index: i32, ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(chls)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

connectedhwlibraries_count :: proc(chls: ConnectedHWLibraries) -> (count: i32, ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(chls)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedhwlibraries_remove :: proc {
    connectedhwlibraries_remove_by_name,
    connectedhwlibraries_remove_by_index,
}

connectedhwlibraries_remove_by_name :: proc(chls: ConnectedHWLibraries, name: string) -> (ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = connectedhwlibraries_connectedhwlibrary_index(chls, name)
    if !ok do return

    hr := (^ConnectedHWLibrariesIF)(chls)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_remove_by_index :: proc(chls: ConnectedHWLibraries, index: i32) -> (ok: bool) {
    if chls == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(chls)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_release :: proc(chls: ConnectedHWLibraries) {
    if chls != nil {
        (^ConnectedHWLibrariesIF)(chls)->Release()
    }
}
