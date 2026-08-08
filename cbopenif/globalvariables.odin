package cbopenif

GlobalVariables :: distinct rawptr

GlobalVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GlobalVariablesVTable,
}

GlobalVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^GlobalVariablesIF, GlobalVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^GlobalVariablesIF, GlobalVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^GlobalVariablesIF, Name, TypeName: BStr, GlobalVariable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^GlobalVariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, GlobalVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^GlobalVariablesIF, Name: BStr, GlobalVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^GlobalVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^GlobalVariablesIF, Index: i32, GlobalVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^GlobalVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^GlobalVariablesIF, Index: i32) -> HResult,
}

globalvariables_globalvariable_add :: proc {
    globalvariables_globalvariable_add_,
    globalvariables_globalvariable_add_at_index,
}

globalvariables_globalvariable_add_ :: proc(globalvariables: GlobalVariables, globalvariable: GlobalVariable) -> (ok: bool) {
    if globalvariables == nil do return
    if globalvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^GlobalVariablesIF)(globalvariables)->Add(globalvariable)
    if com_failed(hr) do return

    return true
}

globalvariables_globalvariable_add_at_index :: proc(globalvariables: GlobalVariables, globalvariable: GlobalVariable, index: i32) -> (ok: bool) {
    if globalvariables == nil do return
    if globalvariable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->AddBefore(globalvariable, index)
    if com_failed(hr) do return

    return true
}

globalvariables_globalvariable :: proc {
    globalvariables_globalvariable_by_name,
    globalvariables_globalvariable_by_index,
}

globalvariables_globalvariable_by_name :: proc(globalvariables: GlobalVariables, name: string) -> (globalvariable: GlobalVariable, ok: bool) {
    if globalvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(globalvariables)->Find(bstr_name, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

globalvariables_globalvariable_by_index :: proc(globalvariables: GlobalVariables, index: i32) -> (globalvariable: GlobalVariable, ok: bool) {
    if globalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Item(index, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

globalvariables_globalvariable_index :: proc(globalvariables: GlobalVariables, name: string) -> (index: i32, ok: bool) {
    if globalvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(globalvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index, true
}

globalvariables_globalvariable_count :: proc(globalvariables: GlobalVariables) -> (count: i32, ok: bool) {
    if globalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

globalvariables_globalvariable_remove :: proc {
    globalvariables_globalvariable_remove_by_name,
    globalvariables_globalvariable_remove_by_index,
}

globalvariables_globalvariable_remove_by_name :: proc(globalvariables: GlobalVariables, name: string) -> (ok: bool) {
    if globalvariables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = globalvariables_globalvariable_index(globalvariables, name)
    
    hr := (^GlobalVariablesIF)(globalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

globalvariables_globalvariable_remove_by_index :: proc(globalvariables: GlobalVariables, index: i32) -> (ok: bool) {
    if globalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

globalvariables_release :: proc(globalvariables: GlobalVariables) {
    if globalvariables != nil {
        (^GlobalVariablesIF)(globalvariables)->Release()
    }
}
