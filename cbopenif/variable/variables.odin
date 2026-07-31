package variable

import "../com"
import "../controlbuilder"
import "../bstr"

VariablesIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^VariablesVTable,
}

VariablesVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^VariablesIF, Variable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^VariablesIF, Variable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^VariablesIF, Name, TypeName: BStr, Variable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^VariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, Variable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^VariablesIF, Name: BStr, Variable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^VariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^VariablesIF, Index: i32, Variable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^VariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^VariablesIF, Index: i32) -> HResult,
}

variables_add :: proc {
    variables_add_,
    variables_add_at_index,
}

@(private)
variables_add_ :: proc(variables: rawptr, variable: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    if variable == nil do return

    hr := (^VariablesIF)(variables)->Add(variable)
    if com.failed(hr) do return

    return true
}

variables_add_at_index :: proc(variables: rawptr, variable: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    if variable == nil do return
    
    hr := (^VariablesIF)(variables)->AddBefore(variable, index)
    if com.failed(hr) do return

    return true
}

variables_variable :: proc {
    variables_variable_by_name,
    variables_variable_by_index,
}

variables_variable_by_name :: proc(variables: rawptr, name: string) -> (variable: rawptr, ok: bool) {
    variable = nil
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^VariablesIF)(variables)->Find(bstr_name, &variable)
    if com.failed(hr) do return
    
    return variable, true
}

variables_variable_by_index :: proc(variables: rawptr, index: i32) -> (variable: rawptr, ok: bool) {
    variable = nil
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    
    hr := (^VariablesIF)(variables)->Item(index, &variable)
    if com.failed(hr) do return
    
    return variable, true
}

variables_variable_index :: proc(variables: rawptr, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^VariablesIF)(variables)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

variables_count :: proc(variables: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    
    hr := (^VariablesIF)(variables)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

variables_remove :: proc {
    variables_remove_by_name,
    variables_remove_by_index
}

variables_remove_by_name :: proc(variables: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return

    index: i32
    index, ok = variables_variable_index(variables, name)
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

variables_remove_by_index :: proc(variables: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if variables == nil do return
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

variables_release :: proc(variables: rawptr) {
    if variables != nil {
        (^VariablesIF)(variables)->Release()
    }
}