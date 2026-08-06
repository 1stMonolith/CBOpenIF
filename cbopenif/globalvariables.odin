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

globalvariables_add :: proc {
    globalvariables_add_,
    globalvariables_add_at_index,
}

globalvariables_add_ :: proc(global_variables: GlobalVariables, global_variable: GlobalVariable) -> (ok: bool) {
    if global_variables == nil do return
    if global_variable == nil do return
    if !controlbuilder_connected() do return

    hr := (^GlobalVariablesIF)(global_variables)->Add(global_variable)
    if com_failed(hr) do return

    return true
}

globalvariables_add_at_index :: proc(global_variables: GlobalVariables, global_variable: GlobalVariable, index: i32) -> (ok: bool) {
    if global_variables == nil do return
    if global_variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(global_variables)->AddBefore(global_variable, index)
    if com_failed(hr) do return

    return true
}

globalvariables_global :: proc {
    globalvariables_global_by_name,
    globalvariables_global_by_index,
}

globalvariables_global_by_name :: proc(global_variables: GlobalVariables, name: string) -> (global_variable: GlobalVariable, ok: bool) {
    if global_variables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(global_variables)->Find(bstr_name, cast(^rawptr)&global_variable)
    if com_failed(hr) do return
    
    return global_variable, true
}

globalvariables_global_by_index :: proc(global_variables: GlobalVariables, index: i32) -> (global_variable: GlobalVariable, ok: bool) {
    if global_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(global_variables)->Item(index, cast(^rawptr)&global_variable)
    if com_failed(hr) do return
    
    return global_variable, true
}

globalvariables_global_index :: proc(global_variables: GlobalVariables, name: string) -> (index: i32, ok: bool) {
    if global_variables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(global_variables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index, true
}

globalvariables_count :: proc(global_variables: GlobalVariables) -> (count: i32, ok: bool) {
    if global_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(global_variables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

globalvariables_remove :: proc {
    globalvariables_remove_by_name,
    globalvariables_remove_by_index,
}

globalvariables_remove_by_name :: proc(global_variables: GlobalVariables, name: string) -> (ok: bool) {
    if global_variables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = globalvariables_global_index(global_variables, name)
    
    hr := (^GlobalVariablesIF)(global_variables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

globalvariables_remove_by_index :: proc(global_variables: GlobalVariables, index: i32) -> (ok: bool) {
    if global_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GlobalVariablesIF)(global_variables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

globalvariables_release :: proc(global_variables: GlobalVariables) {
    if global_variables != nil {
        (^GlobalVariablesIF)(global_variables)->Release()
    }
}
