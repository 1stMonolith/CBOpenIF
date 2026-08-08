package cbopenif

ConnectedApplications :: distinct rawptr

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

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Item(index, cast(^rawptr)&connectedapplication)
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

    return index, true
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

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedapplications_release :: proc(connectedapplications: ConnectedApplications) {
    if connectedapplications != nil {
        (^ConnectedApplicationsIF)(connectedapplications)->Release()
    }
}
