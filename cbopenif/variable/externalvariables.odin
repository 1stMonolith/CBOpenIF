package variable

import "../com"
import "../controlbuilder"
import "../bstr"

ExternalVariablesIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ExternalVariablesVTable,
}

ExternalVariablesVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

externalvariables_add :: proc {
    externalvariables_add_,
    externalvariables_add_at_index,
}

externalvariables_add_ :: proc(external_variables: rawptr, external_variable: rawptr) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    if external_variable == nil do return

    hr := (^ExternalVariablesIF)(external_variables)->Add(external_variable)
    if com.failed(hr) do return

    return true
}

externalvariables_add_at_index :: proc(external_variables: rawptr, external_variable: rawptr, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    if external_variable == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->AddBefore(external_variable, index)
    if com.failed(hr) do return

    return true
}

externalvariables_external :: proc {
    externalvariables_external_by_name,
    externalvariables_external_by_index,
}

externalvariables_external_by_name :: proc(external_variables: rawptr, name: string) -> (external_variable: rawptr, ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^ExternalVariablesIF)(external_variables)->Find(bstr_name, &external_variable)
    if com.failed(hr) do return
    
    return external_variable, true
}

externalvariables_external_by_index :: proc(external_variables: rawptr, index: i32) -> (external_variable: rawptr, ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->Item(index, &external_variable)
    if com.failed(hr) do return
    
    return external_variable, true
}

externalvariables_external_index :: proc(external_variables: rawptr, name: string) -> (index: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^ExternalVariablesIF)(external_variables)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

externalvariables_count :: proc(external_variables: rawptr) -> (count: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

externalvariables_remove :: proc {
    externalvariables_remove_by_name,
    externalvariables_remove_by_index,
}

externalvariables_remove_by_name :: proc(external_variables: rawptr, name: string) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return

    index: i32
    index, ok = externalvariables_external_index(external_variables, name)
    
    hr := (^ExternalVariablesIF)(external_variables)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

externalvariables_remove_by_index :: proc(external_variables: rawptr, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if external_variables == nil do return
    
    hr := (^ExternalVariablesIF)(external_variables)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

externalvariables_release :: proc(external_variables: rawptr) {
    if external_variables != nil {
        (^ExternalVariablesIF)(external_variables)->Release()
    }
}
