package cmconnection

import "../com"
import "../controlbuilder"
import "../bstr"

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

@(private)
cmconnections_add_ :: proc(cmconnections: rawptr, cmconnection: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    if cmconnection == nil do return

    hr := (^CMConnectionsIF)(cmconnections)->Add(cmconnection)
    if com.failed(hr) do return

    return true
}

cmconnections_add_at_index :: proc(cmconnections: rawptr, cmconnection: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    if cmconnection == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->AddBefore(cmconnection, index)
    if com.failed(hr) do return

    return true
}

cmconnections_cmconnection :: proc {
    cmconnections_cmconnection_by_name,
    cmconnections_cmconnection_by_index,
}

cmconnections_cmconnection_by_name :: proc(cmconnections: rawptr, name: string) -> (cmconnection: rawptr, ok: bool) {
    cmconnection = nil
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->Find(bstr_name, &cmconnection)
    if com.failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_by_index :: proc(cmconnections: rawptr, index: i32) -> (cmconnection: rawptr, ok: bool) {
    cmconnection = nil
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Item(index, &cmconnection)
    if com.failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_index :: proc(cmconnections: rawptr, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

cmconnections_count :: proc(cmconnections: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

cmconnections_remove :: proc {
    cmconnections_remove_by_name,
    cmconnections_remove_by_index,
}

cmconnections_remove_by_name :: proc(cmconnections: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return

    index: i32
    index, ok = cmconnections_cmconnection_index(cmconnections, name)
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

cmconnections_remove_by_index :: proc(cmconnections: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmconnections == nil do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

cmconnections_release :: proc(cmconnections: rawptr) {
    if cmconnections != nil {
        (^CMConnectionsIF)(cmconnections)->Release()
    }
}
