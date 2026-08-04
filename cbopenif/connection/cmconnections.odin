package connection

import "../com"
import "../controlbuilder"

@(private="file") BStr        :: com.BStr
@(private="file") HResult     :: com.HResult
@(private="file") VariantBool :: com.VariantBool

CMConnections :: distinct rawptr

CMConnectionsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^CMConnectionsVTable,
}

CMConnectionsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^CMConnectionsIF, CMConnection: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^CMConnectionsIF, CMConnection: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CMConnectionsIF, Name, ActualParameter: BStr, CMConnection: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^CMConnectionsIF, Name, ActualParameter: BStr, GraphicalConnection: VariantBool, CMConnection: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^CMConnectionsIF, Name: BStr, CMConnection: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^CMConnectionsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CMConnectionsIF, Index: i32, CMConnection: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^CMConnectionsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CMConnectionsIF, Index: i32) -> HResult,
}

cmconnections_add :: proc {
    cmconnections_add_,
    cmconnections_add_at_index,
}

cmconnections_add_ :: proc(cmconnections: CMConnections, cmconnection: CMConnection) -> (ok: bool) {
    if cmconnections == nil do return
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^CMConnectionsIF)(cmconnections)->Add(cmconnection)
    if com.failed(hr) do return

    return true
}

cmconnections_add_at_index :: proc(cmconnections: CMConnections, cmconnection: CMConnection, index: i32) -> (ok: bool) {
    if cmconnections == nil do return
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->AddBefore(cmconnection, index)
    if com.failed(hr) do return

    return true
}

cmconnections_cmconnection :: proc {
    cmconnections_cmconnection_by_name,
    cmconnections_cmconnection_by_index,
}
cmconnections_cmconnection_by_name :: proc(cmconnections: CMConnections, name: string) -> (cmconnection: CMConnection, ok: bool) {
    if cmconnections == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->Find(bstr_name, cast(^rawptr)&cmconnection)
    if com.failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_by_index :: proc(cmconnections: CMConnections, index: i32) -> (cmconnection: CMConnection, ok: bool) {
    if cmconnections == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Item(index, cast(^rawptr)&cmconnection)
    if com.failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_index :: proc(cmconnections: CMConnections, name: string) -> (index: i32, ok: bool) {
    if cmconnections == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

cmconnections_count :: proc(cmconnections: CMConnections) -> (count: i32, ok: bool) {
    if cmconnections == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

cmconnections_remove :: proc {
    cmconnections_remove_by_name,
    cmconnections_remove_by_index,
}

cmconnections_remove_by_name :: proc(cmconnections: CMConnections, name: string) -> (ok: bool) {
    if cmconnections == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    index: i32
    index, ok = cmconnections_cmconnection_index(cmconnections, name)
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

cmconnections_remove_by_index :: proc(cmconnections: CMConnections, index: i32) -> (ok: bool) {
    if cmconnections == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

cmconnections_release :: proc(cmconnections: CMConnections) {
    if cmconnections != nil {
        (^CMConnectionsIF)(cmconnections)->Release()
    }
}
