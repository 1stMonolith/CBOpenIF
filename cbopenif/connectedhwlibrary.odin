package cbopenif

ConnectedHWLibrary :: distinct rawptr

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
