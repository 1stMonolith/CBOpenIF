package controlmodule

CMConnections :: distinct rawptr

CMConnectionsIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^CMConnectionsVTable,
}

CMConnectionsVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:       proc "system" (this: ^CMConnectionsIF, CMConnection: CMConnection) -> HResult,
    AddBefore: proc "system" (this: ^CMConnectionsIF, CMConnection: CMConnection, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CMConnectionsIF, Name, ActualParameter: BStr, CMConnection: ^CMConnection) -> HResult,
    Add2:      proc "system" (this: ^CMConnectionsIF, Name, ActualParameter: BStr, GraphicalConnection: VariantBool, CMConnection: ^CMConnection) -> HResult,
    Find:      proc "system" (this: ^CMConnectionsIF, Name: BStr, CMConnection: ^CMConnection) -> HResult,
    FindNr:    proc "system" (this: ^CMConnectionsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CMConnectionsIF, Index: i32, CMConnection: ^CMConnection) -> HResult,
    Count:     proc "system" (this: ^CMConnectionsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CMConnectionsIF, Index: i32) -> HResult,
}

cmconnections_add :: proc {
    cmconnections_add_,
    cmconnections_add_at_index,
}

@(private)
cmconnections_add_ :: proc(cmconnections: CMConnections, cmconnection: CMConnection) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    if cmconnection == nil do return

    hr := (^CMConnectionsIF)(cmconnections)->Add(cmconnection)
    if failed(hr) do return

    return true
}

cmconnections_add_at_index :: proc(cmconnections: CMConnections, cmconnection: CMConnection, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    if cmconnection == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->AddBefore(cmconnection, index)
    if failed(hr) do return

    return true
}

cmconnections_cmconnection :: proc {
    cmconnections_cmconnection_by_name,
    cmconnections_cmconnection_by_index,
}

cmconnections_cmconnection_by_name :: proc(cmconnections: CMConnections, name: string) -> (cmconnection: CMConnection, ok: bool) {
    cmconnection = nil
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->Find(bstr_name, &cmconnection)
    if failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_by_index :: proc(cmconnections: CMConnections, index: i32) -> (cmconnection: CMConnection, ok: bool) {
    cmconnection = nil
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Item(index, &cmconnection)
    if failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_index :: proc(cmconnections: CMConnections, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

cmconnections_count :: proc(cmconnections: CMConnections) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

cmconnections_remove :: proc {
    cmconnections_remove_by_name,
    cmconnections_remove_by_index,
}

cmconnections_remove_by_name :: proc(cmconnections: CMConnections, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmconnections == nil do return

    index: i32
    index, ok = cmconnections_cmconnection_index(cmconnections, name)
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if failed(hr) do return
    
    return true
}

cmconnections_remove_by_index :: proc(cmconnections: CMConnections, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmconnections == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if failed(hr) do return
    
    return true
}

cmconnections_release :: proc(cmconnections: CMConnections) {
    if cmconnections != nil {
        (^CMConnectionsIF)(cmconnections)->Release()
    }
}
