package cbopenif

ConnectedApplication :: distinct rawptr

ConnectedApplicationIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationVTable,
}

ConnectedApplicationVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedApplicationIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedApplicationIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedApplicationIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedApplicationIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedApplicationIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedApplicationIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedApplicationIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedApplicationIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedApplicationIF, Guid: ^BStr) -> HResult,
}

connectedapplication_new :: proc(name: string) -> (ca: ConnectedApplication, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewConnectedApplication(bstr_name, cast(^rawptr)&ca)
    if com_failed(hr) do return

    return ca, true
}

connectedapplication_name :: proc {
    connectedapplication_name_get,
    connectedapplication_name_set,
}

connectedapplication_name_get :: proc(ca: ConnectedApplication) -> (name: string, ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplication_name_set :: proc(ca: ConnectedApplication, name: string) -> (ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedapplication_major_version :: proc {
    connectedapplication_major_version_get,
    connectedapplication_major_version_set,
}

connectedapplication_major_version_get :: proc(ca: ConnectedApplication) -> (major_version: i32, ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedapplication_major_version_set :: proc(ca: ConnectedApplication, major_version: i32) -> (ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}

connectedapplication_minor_version :: proc {
    connectedapplication_minor_version_get,
    connectedapplication_minor_version_set,
}

connectedapplication_minor_version_get :: proc(ca: ConnectedApplication) -> (minor_version: i32, ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedapplication_minor_version_set :: proc(ca: ConnectedApplication, minor_version: i32) -> (ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedapplication_revision :: proc {
    connectedapplication_revision_get,
    connectedapplication_revision_set,
}

connectedapplication_revision_get :: proc(ca: ConnectedApplication) -> (revision: i32, ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedapplication_revision_set :: proc(ca: ConnectedApplication, revision: i32) -> (ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedapplication_guid_get :: proc(ca: ConnectedApplication) -> (guid: string, ok: bool) {
    if ca == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplication_release :: proc(ca: ConnectedApplication) {
    if ca != nil {
        (^ConnectedApplicationIF)(ca)->Release()
    }
}
