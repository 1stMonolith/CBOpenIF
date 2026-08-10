package cbopenif

ConnectedLibraries :: distinct rawptr

ConnectedLibrariesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedLibrariesVTable,
}

ConnectedLibrariesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedLibrariesIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedLibrariesIF, ConnectedLibrary: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedLibrariesIF, ConnectedLibrary: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, ConnectedLibrary: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedLibrary: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, ConnectedLibrary: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedLibrariesIF, Index: i32, ConnectedLibrary: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedLibrariesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedLibrariesIF, Index: i32) -> HResult,
}

connectedlibraries_new :: proc() -> (connectedlibraries: ConnectedLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewConnectedLibraries(cast(^rawptr)&connectedlibraries)
    if com_failed(hr) do return

    return connectedlibraries, true
}

connectedlibraries_deserialize :: proc(xml: string) -> (connectedlibraries: ConnectedLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeConnectedLibraries(&bs, cast(^rawptr)&connectedlibraries)
    if com_failed(hr) do return

    return connectedlibraries, true
}

connectedlibraries_serialize :: proc(connectedlibraries: ConnectedLibraries) -> (xml: string, ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibraries_connectedlibrary_add :: proc {
    connectedlibraries_connectedlibrary_add_,
    connectedlibraries_connectedlibrary_add_at_index,
}

connectedlibraries_connectedlibrary_add_ :: proc(connectedlibraries: ConnectedLibraries, connectedlibrary: ConnectedLibrary) -> (ok: bool) {
    if connectedlibraries == nil do return
    if connectedlibrary == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Add(connectedlibrary)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary_add_at_index :: proc(connectedlibraries: ConnectedLibraries, connectedlibrary: ConnectedLibrary, index: i32) -> (ok: bool) {
    if connectedlibraries == nil do return
    if connectedlibrary == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->AddBefore(connectedlibrary, index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary :: proc {
    connectedlibraries_connectedlibrary_by_name,
    connectedlibraries_connectedlibrary_by_index,
}

connectedlibraries_connectedlibrary_by_name :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (connectedlibrary: ConnectedLibrary, ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Find(bstr_name, cast(^rawptr)&connectedlibrary)
    if com_failed(hr) do return

    return connectedlibrary, true
}

connectedlibraries_connectedlibrary_by_index :: proc(connectedlibraries: ConnectedLibraries, index: i32) -> (connectedlibrary: ConnectedLibrary, ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Item(index + 1, cast(^rawptr)&connectedlibrary)
    if com_failed(hr) do return

    return connectedlibrary, true
}

connectedlibraries_connectedlibrary_index :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (index: i32, ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedlibraries_connectedlibrary_count :: proc(connectedlibraries: ConnectedLibraries) -> (count: i32, ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedlibraries_connectedlibrary_remove :: proc {
    connectedlibraries_connectedlibrary_remove_by_name,
    connectedlibraries_connectedlibrary_remove_by_index,
}

connectedlibraries_connectedlibrary_remove_by_name :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = connectedlibraries_connectedlibrary_index(connectedlibraries, name)
    if !ok do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary_remove_by_index :: proc(connectedlibraries: ConnectedLibraries, index: i32) -> (ok: bool) {
    if connectedlibraries == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedlibraries_release :: proc(connectedlibraries: ConnectedLibraries) {
    if connectedlibraries != nil {
        (^ConnectedLibrariesIF)(connectedlibraries)->Release()
    }
}
