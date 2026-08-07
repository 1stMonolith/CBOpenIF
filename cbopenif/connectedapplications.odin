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

connectedapplications_new :: proc() -> (cas: ConnectedApplications, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewConnectedApplications(cast(^rawptr)&cas)
    if com_failed(hr) do return

    return cas, true
}

connectedapplications_deserialize :: proc(xml: string) -> (cas: ConnectedApplications, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeConnectedApplications(&bs, cast(^rawptr)&cas)
    if com_failed(hr) do return

    return cas, true
}

connectedapplications_serialize :: proc(cas: ConnectedApplications) -> (xml: string, ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationsIF)(cas)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplications_add :: proc {
    connectedapplications_add_,
    connectedapplications_add_at_index,
}

connectedapplications_add_ :: proc(cas: ConnectedApplications, ca: ConnectedApplication) -> (ok: bool) {
    if cas == nil do return
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(cas)->Add(ca)
    if com_failed(hr) do return

    return true
}

connectedapplications_add_at_index :: proc(cas: ConnectedApplications, ca: ConnectedApplication, index: i32) -> (ok: bool) {
    if cas == nil do return
    if ca == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(cas)->AddBefore(ca, index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication :: proc {
    connectedapplications_connectedapplication_by_name,
    connectedapplications_connectedapplication_by_index,
}

connectedapplications_connectedapplication_by_name :: proc(cas: ConnectedApplications, name: string) -> (ca: ConnectedApplication, ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(cas)->Find(bstr_name, cast(^rawptr)&ca)
    if com_failed(hr) do return

    return ca, true
}

connectedapplications_connectedapplication_by_index :: proc(cas: ConnectedApplications, index: i32) -> (ca: ConnectedApplication, ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(cas)->Item(index, cast(^rawptr)&ca)
    if com_failed(hr) do return

    return ca, true
}

connectedapplications_connectedapplication_index :: proc(cas: ConnectedApplications, name: string) -> (index: i32, ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(cas)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

connectedapplications_count :: proc(cas: ConnectedApplications) -> (count: i32, ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(cas)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedapplications_remove :: proc {
    connectedapplications_remove_by_name,
    connectedapplications_remove_by_index,
}

connectedapplications_remove_by_name :: proc(cas: ConnectedApplications, name: string) -> (ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = connectedapplications_connectedapplication_index(cas, name)
    if !ok do return

    hr := (^ConnectedApplicationsIF)(cas)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedapplications_remove_by_index :: proc(cas: ConnectedApplications, index: i32) -> (ok: bool) {
    if cas == nil do return
    if !controlbuilder_connected() do return

    hr := (^ConnectedApplicationsIF)(cas)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedapplications_release :: proc(cas: ConnectedApplications) {
    if cas != nil {
        (^ConnectedApplicationsIF)(cas)->Release()
    }
}
