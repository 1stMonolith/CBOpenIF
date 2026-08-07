package cbopenif

Variables :: distinct rawptr

VariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VariablesVTable,
}

VariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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

variables_add_ :: proc(variables: Variables, variable: Variable) -> (ok: bool) {
    if variables == nil do return
    if variable == nil do return
    if !controlbuilder_connected() do return

    hr := (^VariablesIF)(variables)->Add(variable)
    if com_failed(hr) do return

    return true
}

variables_add_at_index :: proc(variables: Variables, variable: Variable, index: i32) -> (ok: bool) {
    if variables == nil do return
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->AddBefore(variable, index)
    if com_failed(hr) do return

    return true
}

variables_variable :: proc {
    variables_variable_by_name,
    variables_variable_by_index,
}

variables_variable_by_name :: proc(variables: Variables, name: string) -> (variable: Variable, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->Find(bstr_name, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variables_variable_by_index :: proc(variables: Variables, index: i32) -> (variable: Variable, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->Item(index, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variables_variable_index :: proc(variables: Variables, name: string) -> (index: i32, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index, true
}

variables_variable_count :: proc(variables: Variables) -> (count: i32, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

variables_variable_remove :: proc {
    variables_variable_remove_by_name,
    variables_variable_remove_by_index
}

variables_variable_remove_by_name :: proc(variables: Variables, name: string) -> (ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = variables_variable_index(variables, name)
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

variables_variable_remove_by_index :: proc(variables: Variables, index: i32) -> (ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

variables_release :: proc(variables: Variables) {
    if variables != nil {
        (^VariablesIF)(variables)->Release()
    }
}
