package cbopenif

ExternalVariables :: distinct rawptr

ExternalVariablesIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ExternalVariablesVTable,
}

ExternalVariablesVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:       proc "system" (this: ^ExternalVariablesIF, ExternalVariable: ExternalVariable) -> HResult,
    AddBefore: proc "system" (this: ^ExternalVariablesIF, ExternalVariable: ExternalVariable, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExternalVariablesIF, Name, TypeName: BStr, ExternalVariable: ^ExternalVariable) -> HResult,
    Add2:      proc "system" (this: ^ExternalVariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, ExternalVariable: ^ExternalVariable) -> HResult,
    Find:      proc "system" (this: ^ExternalVariablesIF, Name: BStr, ExternalVariable: ^ExternalVariable) -> HResult,
    FindNr:    proc "system" (this: ^ExternalVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExternalVariablesIF, Index: i32, ExternalVariable: ^ExternalVariable) -> HResult,
    Count:     proc "system" (this: ^ExternalVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExternalVariablesIF, Index: i32) -> HResult,
}

externalvariables_add :: proc {
    externalvariables_add_,
    externalvariables_add_at_index,
}

@(private)
externalvariables_add_ :: proc(external_variables: ExternalVariables, external_variable: ExternalVariable) -> (ok: bool) {
    ok = false

    if !connected() do return
    if external_variables == nil do return
    if external_variable == nil do return

    hr := (^ExternalVariablesIF)(external_variables)->Add(external_variable)
    if failed(hr) do return

    return true
}

externalvariables_add_at_index :: proc(external_variables: ExternalVariables, external_variable: ExternalVariable, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if external_variables == nil do return
    if external_variable == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->AddBefore(external_variable, index)
    if failed(hr) do return

    return true
}

externalvariables_external :: proc {
    externalvariables_external_by_name,
    externalvariables_external_by_index,
}

externalvariables_external_by_name :: proc(external_variables: ExternalVariables, name: string) -> (external_variable: ExternalVariable, ok: bool) {
    external_variable = nil
    ok = false

    if !connected() do return
    if external_variables == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(external_variables)->Find(bstr_name, &external_variable)
    if failed(hr) do return
    
    return external_variable, true
}

externalvariables_external_by_index :: proc(external_variables: ExternalVariables, index: i32) -> (external_variable: ExternalVariable, ok: bool) {
    external_variable = nil
    ok = false

    if !connected() do return
    if external_variables == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->Item(index, &external_variable)
    if failed(hr) do return
    
    return external_variable, true
}

externalvariables_external_index :: proc(external_variables: ExternalVariables, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if external_variables == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(external_variables)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

externalvariables_count :: proc(external_variables: ExternalVariables) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if external_variables == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

externalvariables_remove :: proc {
    externalvariables_remove_by_name,
    externalvariables_remove_by_index,
}

externalvariables_remove_by_name :: proc(external_variables: ExternalVariables, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if external_variables == nil do return

    index: i32
    index, ok = externalvariables_external_index(external_variables, name)
    
    hr := (^ExternalVariablesIF)(external_variables)->Remove(index)
    if failed(hr) do return
    
    return true
}

externalvariables_remove_by_index :: proc(external_variables: ExternalVariables, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if external_variables == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->Remove(index)
    if failed(hr) do return
    
    return true
}

externalvariables_release :: proc(external_variables: ExternalVariables) {
    if external_variables != nil {
        (^ExternalVariablesIF)(external_variables)->Release()
    }
}