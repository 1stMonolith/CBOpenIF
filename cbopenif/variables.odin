package cbopenif

Variables  :: distinct rawptr

VariablesIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^VariablesVTable,
}

VariablesVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:       proc "system" (this: ^VariablesIF, Variable: Variable) -> HResult,
    AddBefore: proc "system" (this: ^VariablesIF, Variable: Variable, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^VariablesIF, Name, TypeName: BStr, Variable: ^Variable) -> HResult,
    Add2:      proc "system" (this: ^VariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, Variable: ^Variable) -> HResult,
    Find:      proc "system" (this: ^VariablesIF, Name: BStr, Variable: ^Variable) -> HResult,
    FindNr:    proc "system" (this: ^VariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^VariablesIF, Index: i32, Variable: ^Variable) -> HResult,
    Count:     proc "system" (this: ^VariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^VariablesIF, Index: i32) -> HResult,
}

variables_add :: proc {
    variables_add_,
    variables_add_at_index,
}

@(private)
variables_add_ :: proc(variables: Variables, variable: Variable) -> (ok: bool) {
    ok = false

    if !connected() do return
    if variables == nil do return
    if variable == nil do return

    hr := (^VariablesIF)(variables)->Add(variable)
    if failed(hr) do return

    return true
}

variables_add_at_index :: proc(variables: Variables, variable: Variable, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if variables == nil do return
    if variable == nil do return
    
    hr := (^VariablesIF)(variables)->AddBefore(variable, index)
    if failed(hr) do return

    return true
}

variables_variable :: proc {
    variables_variable_by_name,
    variables_variable_by_index,
}

variables_variable_by_name :: proc(variables: Variables, name: string) -> (variable: Variable, ok: bool) {
    variable = nil
    ok = false

    if !connected() do return
    if variables == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->Find(bstr_name, &variable)
    if failed(hr) do return
    
    return variable, true
}

variables_variable_by_index :: proc(variables: Variables, index: i32) -> (variable: Variable, ok: bool) {
    variable = nil
    ok = false

    if !connected() do return
    if variables == nil do return
    
    hr := (^VariablesIF)(variables)->Item(index, &variable)
    if failed(hr) do return
    
    return variable, true
}

variables_variable_index :: proc(variables: Variables, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if variables == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

variables_count :: proc(variables: Variables) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if variables == nil do return
    
    hr := (^VariablesIF)(variables)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

variables_remove :: proc {
    variables_remove_by_name,
    variables_remove_by_index
}

variables_remove_by_name :: proc(variables: Variables, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if variables == nil do return

    index: i32
    index, ok = variables_variable_index(variables, name)
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if failed(hr) do return
    
    return true
}

variables_remove_by_index :: proc(variables: Variables, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if variables == nil do return
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if failed(hr) do return
    
    return true
}

variables_release :: proc(variables: Variables) {
    if variables != nil {
        (^VariablesIF)(variables)->Release()
    }
}