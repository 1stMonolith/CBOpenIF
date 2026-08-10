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

ConnectedApplicationsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationsVTable,
}

ConnectedApplicationsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedApplicationsIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedApplicationsIF, ConnectedApplication: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedApplicationsIF, ConnectedApplication: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedApplication: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedApplicationsIF, Index: i32, ConnectedApplication: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedApplicationsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedApplicationsIF, Index: i32) -> HResult,
}

connectedapplications_new :: proc() -> (connectedapplications: ConnectedApplications, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewConnectedApplications(cast(^rawptr)&connectedapplications)
    if com_failed(hr) do return

    return connectedapplications, true
}

connectedapplications_deserialize :: proc(xml: string) -> (connectedapplications: ConnectedApplications, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeConnectedApplications(&bs, cast(^rawptr)&connectedapplications)
    if com_failed(hr) do return

    return connectedapplications, true
}

connectedapplications_serialize :: proc(connectedapplications: ConnectedApplications) -> (xml: string, ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplications_connectedapplication_add :: proc {
    connectedapplications_connectedapplication_add_,
    connectedapplications_connectedapplication_add_at_index,
}

connectedapplications_connectedapplication_add_ :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication) -> (ok: bool) {
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Add(connectedapplication)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_add_at_index :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication, index: i32) -> (ok: bool) {
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->AddBefore(connectedapplication, index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication :: proc {
    connectedapplications_connectedapplication_by_name,
    connectedapplications_connectedapplication_by_index,
}

connectedapplications_connectedapplication_by_name :: proc(connectedapplications: ConnectedApplications, name: string) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Find(bstr_name, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return

    return connectedapplication, true
}

connectedapplications_connectedapplication_by_index :: proc(connectedapplications: ConnectedApplications, index: i32) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Item(index + 1, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return

    return connectedapplication, true
}

connectedapplications_connectedapplication_index :: proc(connectedapplications: ConnectedApplications, name: string) -> (index: i32, ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedapplications_connectedapplication_count :: proc(connectedapplications: ConnectedApplications) -> (count: i32, ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedapplications_connectedapplication_remove :: proc {
    connectedapplications_connectedapplication_remove_by_name,
    connectedapplications_connectedapplication_remove_by_index,
}

connectedapplications_connectedapplication_remove_by_name :: proc(connectedapplications: ConnectedApplications, name: string) -> (ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = connectedapplications_connectedapplication_index(connectedapplications, name)
    if !ok do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_remove_by_index :: proc(connectedapplications: ConnectedApplications, index: i32) -> (ok: bool) {
    if connectedapplications == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedapplications_release :: proc(connectedapplications: ConnectedApplications) {
    if connectedapplications != nil {
        (^ConnectedApplicationsIF)(connectedapplications)->Release()
    }
}
