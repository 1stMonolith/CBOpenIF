package variable

import "../com"
import "../controlbuilder"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

GlobalVariables :: distinct rawptr

GlobalVariablesIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^GlobalVariablesVTable,
}

GlobalVariablesVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    if global_variable == nil do return

    hr := (^GlobalVariablesIF)(global_variables)->Add(global_variable)
    if com.failed(hr) do return

    return true
}

globalvariables_add_at_index :: proc(global_variables: GlobalVariables, global_variable: GlobalVariable, index: i32) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    if global_variable == nil do return
    
    hr := (^GlobalVariablesIF)(global_variables)->AddBefore(global_variable, index)
    if com.failed(hr) do return

    return true
}

globalvariables_global :: proc {
    globalvariables_global_by_name,
    globalvariables_global_by_index,
}

globalvariables_global_by_name :: proc(global_variables: GlobalVariables, name: string) -> (global_variable: GlobalVariable, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    
    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(global_variables)->Find(bstr_name, cast(^rawptr)&global_variable)
    if com.failed(hr) do return
    
    return global_variable, true
}

globalvariables_global_by_index :: proc(global_variables: GlobalVariables, index: i32) -> (global_variable: GlobalVariable, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    
    hr := (^GlobalVariablesIF)(global_variables)->Item(index, cast(^rawptr)&global_variable)
    if com.failed(hr) do return
    
    return global_variable, true
}

globalvariables_global_index :: proc(global_variables: GlobalVariables, name: string) -> (index: i32, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    
    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(global_variables)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

globalvariables_count :: proc(global_variables: GlobalVariables) -> (count: i32, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    
    hr := (^GlobalVariablesIF)(global_variables)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

globalvariables_remove :: proc {
    globalvariables_remove_by_name,
    globalvariables_remove_by_index,
}

globalvariables_remove_by_name :: proc(global_variables: GlobalVariables, name: string) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return

    index: i32
    index, ok = globalvariables_global_index(global_variables, name)
    
    hr := (^GlobalVariablesIF)(global_variables)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

globalvariables_remove_by_index :: proc(global_variables: GlobalVariables, index: i32) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if global_variables == nil do return
    
    hr := (^GlobalVariablesIF)(global_variables)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

globalvariables_release :: proc(global_variables: GlobalVariables) {
    if global_variables != nil {
        (^GlobalVariablesIF)(global_variables)->Release()
    }
}
