package cbopenif

ConnectedHWLibrary   :: distinct rawptr
ConnectedHWLibraries :: distinct rawptr

ConnectedHWLibraryIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedHWLibraryVTable,
}

ConnectedHWLibraryVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedHWLibraryIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedHWLibraryIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedHWLibraryIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedHWLibraryIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedHWLibraryIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedHWLibraryIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedHWLibraryIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedHWLibraryIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedHWLibraryIF, Guid: ^BStr) -> HResult,
}

connectedhwlibrary_new :: proc(name: string) -> (chl: ConnectedHWLibrary, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewConnectedHWLibrary(bstr_name, cast(^rawptr)&chl)
    if com_failed(hr) do return

    return chl, true
}

connectedhwlibrary_name :: proc {
    connectedhwlibrary_name_get,
    connectedhwlibrary_name_set,
}

connectedhwlibrary_name_get :: proc(chl: ConnectedHWLibrary) -> (name: string, ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibraryIF)(chl)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibrary_name_set :: proc(chl: ConnectedHWLibrary, name: string) -> (ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedHWLibraryIF)(chl)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_major_version :: proc {
    connectedhwlibrary_major_version_get,
    connectedhwlibrary_major_version_set,
}

connectedhwlibrary_major_version_get :: proc(chl: ConnectedHWLibrary) -> (major_version: i32, ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedhwlibrary_major_version_set :: proc(chl: ConnectedHWLibrary, major_version: i32) -> (ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_minor_version :: proc {
    connectedhwlibrary_minor_version_get,
    connectedhwlibrary_minor_version_set,
}

connectedhwlibrary_minor_version_get :: proc(chl: ConnectedHWLibrary) -> (minor_version: i32, ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedhwlibrary_minor_version_set :: proc(chl: ConnectedHWLibrary, minor_version: i32) -> (ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_revision :: proc {
    connectedhwlibrary_revision_get,
    connectedhwlibrary_revision_set,
}

connectedhwlibrary_revision_get :: proc(chl: ConnectedHWLibrary) -> (revision: i32, ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedhwlibrary_revision_set :: proc(chl: ConnectedHWLibrary, revision: i32) -> (ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_guid_get :: proc(chl: ConnectedHWLibrary) -> (guid: string, ok: bool) {
    if chl == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibraryIF)(chl)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibrary_release :: proc(chl: ConnectedHWLibrary) {
    if chl != nil {
        (^ConnectedHWLibraryIF)(chl)->Release()
    }
}

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

connectedhwlibraries_new :: proc() -> (connectedhwlibraries: ConnectedHWLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewConnectedHWLibraries(cast(^rawptr)&connectedhwlibraries)
    if com_failed(hr) do return

    return connectedhwlibraries, true
}

connectedhwlibraries_deserialize :: proc(xml: string) -> (connectedhwlibraries: ConnectedHWLibraries, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeConnectedHWLibraries(&bs, cast(^rawptr)&connectedhwlibraries)
    if com_failed(hr) do return

    return connectedhwlibraries, true
}

connectedhwlibraries_serialize :: proc(connectedhwlibraries: ConnectedHWLibraries) -> (xml: string, ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibraries_connectedhwlibrary_add :: proc {
    connectedhwlibraries_connectedhwlibrary_add_,
    connectedhwlibraries_connectedhwlibrary_add_at_index,
}

connectedhwlibraries_connectedhwlibrary_add_ :: proc(connectedhwlibraries: ConnectedHWLibraries, connectedhwlibrary: ConnectedHWLibrary) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if connectedhwlibrary == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Add(connectedhwlibrary)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary_add_at_index :: proc(connectedhwlibraries: ConnectedHWLibraries, connectedhwlibrary: ConnectedHWLibrary, index: i32) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if connectedhwlibrary == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->AddBefore(connectedhwlibrary, index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary :: proc {
    connectedhwlibraries_connectedhwlibrary_by_name,
    connectedhwlibraries_connectedhwlibrary_by_index,
}

connectedhwlibraries_connectedhwlibrary_by_name :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Find(bstr_name, cast(^rawptr)&connectedhwlibrary)
    if com_failed(hr) do return

    return connectedhwlibrary, true
}

connectedhwlibraries_connectedhwlibrary_by_index :: proc(connectedhwlibraries: ConnectedHWLibraries, index: i32) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Item(index + 1, cast(^rawptr)&connectedhwlibrary)
    if com_failed(hr) do return

    return connectedhwlibrary, true
}

connectedhwlibraries_connectedhwlibrary_index :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (index: i32, ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedhwlibraries_connectedhwlibrary_count :: proc(connectedhwlibraries: ConnectedHWLibraries) -> (count: i32, ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedhwlibraries_connectedhwlibrary_remove :: proc {
    connectedhwlibraries_connectedhwlibrary_remove_by_name,
    connectedhwlibraries_connectedhwlibrary_remove_by_index,
}

connectedhwlibraries_connectedhwlibrary_remove_by_name :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = connectedhwlibraries_connectedhwlibrary_index(connectedhwlibraries, name)
    if !ok do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary_remove_by_index :: proc(connectedhwlibraries: ConnectedHWLibraries, index: i32) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_release :: proc(connectedhwlibraries: ConnectedHWLibraries) {
    if connectedhwlibraries != nil {
        (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Release()
    }
}
