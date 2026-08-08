package cbopenif

ExternalVariables :: distinct rawptr

ExternalVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExternalVariablesVTable,
}

ExternalVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ExternalVariablesIF, ExternalVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ExternalVariablesIF, ExternalVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExternalVariablesIF, Name, TypeName: BStr, ExternalVariable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ExternalVariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, ExternalVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ExternalVariablesIF, Name: BStr, ExternalVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ExternalVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExternalVariablesIF, Index: i32, ExternalVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ExternalVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExternalVariablesIF, Index: i32) -> HResult,
}

externalvariables_externalvariable_add :: proc {
    externalvariables_externalvariable_add_,
    externalvariables_externalvariable_add_at_index,
}

externalvariables_externalvariable_add_ :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable) -> (ok: bool) {
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExternalVariablesIF)(externalvariables)->Add(externalvariable)
    if com_failed(hr) do return

    return true
}

externalvariables_externalvariable_add_at_index :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable, index: i32) -> (ok: bool) {
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->AddBefore(externalvariable, index)
    if com_failed(hr) do return

    return true
}

externalvariables_externalvariable :: proc {
    externalvariables_externalvariable_by_name,
    externalvariables_externalvariable_by_index,
}

externalvariables_externalvariable_by_name :: proc(externalvariables: ExternalVariables, name: string) -> (externalvariable: ExternalVariable, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->Find(bstr_name, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariables_externalvariable_by_index :: proc(externalvariables: ExternalVariables, index: i32) -> (externalvariable: ExternalVariable, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Item(index, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariables_externalvariable_index :: proc(externalvariables: ExternalVariables, name: string) -> (index: i32, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index, true
}

externalvariables_externalvariable_count :: proc(externalvariables: ExternalVariables) -> (count: i32, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

externalvariables_externalvariable_remove :: proc {
    externalvariables_externalvariable_remove_by_name,
    externalvariables_externalvariable_remove_by_index,
}

externalvariables_externalvariable_remove_by_name :: proc(externalvariables: ExternalVariables, name: string) -> (ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = externalvariables_externalvariable_index(externalvariables, name)
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

externalvariables_externalvariable_remove_by_index :: proc(externalvariables: ExternalVariables, index: i32) -> (ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

externalvariables_release :: proc(externalvariables: ExternalVariables) {
    if externalvariables != nil {
        (^ExternalVariablesIF)(externalvariables)->Release()
    }
}
