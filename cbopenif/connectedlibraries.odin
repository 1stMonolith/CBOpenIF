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

connectedlibraries_new :: proc() -> (cls: ConnectedLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewConnectedLibraries(cast(^rawptr)&cls)
    if com_failed(hr) do return

    return cls, true
}

connectedlibraries_deserialize :: proc(xml: string) -> (cls: ConnectedLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeConnectedLibraries(&bs, cast(^rawptr)&cls)
    if com_failed(hr) do return

    return cls, true
}

connectedlibraries_serialize :: proc(cls: ConnectedLibraries) -> (xml: string, ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibrariesIF)(cls)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibraries_add :: proc {
    connectedlibraries_add_,
    connectedlibraries_add_at_index,
}

connectedlibraries_add_ :: proc(cls: ConnectedLibraries, cl: ConnectedLibrary) -> (ok: bool) {
    if cls == nil do return
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(cls)->Add(cl)
    if com_failed(hr) do return

    return true
}

connectedlibraries_add_at_index :: proc(cls: ConnectedLibraries, cl: ConnectedLibrary, index: i32) -> (ok: bool) {
    if cls == nil do return
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(cls)->AddBefore(cl, index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary :: proc {
    connectedlibraries_connectedlibrary_by_name,
    connectedlibraries_connectedlibrary_by_index,
}

connectedlibraries_connectedlibrary_by_name :: proc(cls: ConnectedLibraries, name: string) -> (cl: ConnectedLibrary, ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedLibrariesIF)(cls)->Find(bstr_name, cast(^rawptr)&cl)
    if com_failed(hr) do return

    return cl, true
}

connectedlibraries_connectedlibrary_by_index :: proc(cls: ConnectedLibraries, index: i32) -> (cl: ConnectedLibrary, ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(cls)->Item(index, cast(^rawptr)&cl)
    if com_failed(hr) do return

    return cl, true
}

connectedlibraries_connectedlibrary_index :: proc(cls: ConnectedLibraries, name: string) -> (index: i32, ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedLibrariesIF)(cls)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

connectedlibraries_count :: proc(cls: ConnectedLibraries) -> (count: i32, ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(cls)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedlibraries_remove :: proc {
    connectedlibraries_remove_by_name,
    connectedlibraries_remove_by_index,
}

connectedlibraries_remove_by_name :: proc(cls: ConnectedLibraries, name: string) -> (ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = connectedlibraries_connectedlibrary_index(cls, name)
    if !ok do return

    hr := (^ConnectedLibrariesIF)(cls)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_remove_by_index :: proc(cls: ConnectedLibraries, index: i32) -> (ok: bool) {
    if cls == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibrariesIF)(cls)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_release :: proc(cls: ConnectedLibraries) {
    if cls != nil {
        (^ConnectedLibrariesIF)(cls)->Release()
    }
}
