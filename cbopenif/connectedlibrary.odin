package cbopenif

ConnectedLibrary   :: distinct rawptr
ConnectedLibraries :: distinct rawptr

ConnectedLibraryIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedLibraryVTable,
}

ConnectedLibraryVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedLibraryIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedLibraryIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedLibraryIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedLibraryIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedLibraryIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedLibraryIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedLibraryIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedLibraryIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedLibraryIF, Guid: ^BStr) -> HResult,
}

connectedlibrary_new :: proc(name: string) -> (cl: ConnectedLibrary, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewConnectedLibrary(bstr_name, cast(^rawptr)&cl)
    if com_failed(hr) do return

    return cl, true
}

connectedlibrary_name :: proc {
    connectedlibrary_name_get,
    connectedlibrary_name_set,
}

connectedlibrary_name_get :: proc(cl: ConnectedLibrary) -> (name: string, ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibraryIF)(cl)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibrary_name_set :: proc(cl: ConnectedLibrary, name: string) -> (ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedLibraryIF)(cl)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedlibrary_major_version :: proc {
    connectedlibrary_major_version_get,
    connectedlibrary_major_version_set,
}

connectedlibrary_major_version_get :: proc(cl: ConnectedLibrary) -> (major_version: i32, ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedlibrary_major_version_set :: proc(cl: ConnectedLibrary, major_version: i32) -> (ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}

connectedlibrary_minor_version :: proc {
    connectedlibrary_minor_version_get,
    connectedlibrary_minor_version_set,
}

connectedlibrary_minor_version_get :: proc(cl: ConnectedLibrary) -> (minor_version: i32, ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedlibrary_minor_version_set :: proc(cl: ConnectedLibrary, minor_version: i32) -> (ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedlibrary_revision :: proc {
    connectedlibrary_revision_get,
    connectedlibrary_revision_set,
}

connectedlibrary_revision_get :: proc(cl: ConnectedLibrary) -> (revision: i32, ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedlibrary_revision_set :: proc(cl: ConnectedLibrary, revision: i32) -> (ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedlibrary_guid_get :: proc(cl: ConnectedLibrary) -> (guid: string, ok: bool) {
    if cl == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibraryIF)(cl)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibrary_release :: proc(cl: ConnectedLibrary) {
    if cl != nil {
        (^ConnectedLibraryIF)(cl)->Release()
    }
}
