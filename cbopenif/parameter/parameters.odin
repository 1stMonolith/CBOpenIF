package parameter

import "../com"
import "../controlbuilder"
import "../bstr"

ParametersIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ParametersVTable,
}

ParametersVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^ParametersIF, Parameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ParametersIF, Parameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParametersIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ParametersIF, Name, TypeName, Attribute, Direction, InitialValue, ReadPermission, WritePermission, Description: BStr, Parameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ParametersIF, Name: BStr, Parameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParametersIF, Index: i32, Parameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ParametersIF, count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParametersIF, Index: i32) -> HResult,
    NewEnum:   proc "system" (this: ^ParametersIF, Enum: ^rawptr) -> HResult,
}

parameters_add :: proc {
    parameters_add_,
    parameters_add_at_index,
}

parameters_add_ :: proc(parameters: rawptr, parameter: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    if parameter == nil do return

    hr := (^ParametersIF)(parameters)->Add(parameter)
    if com.failed(hr) do return

    return true
}

parameters_add_at_index :: proc(parameters: rawptr, parameter: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    if parameter == nil do return
    
    hr := (^ParametersIF)(parameters)->AddBefore(parameter, index)
    if com.failed(hr) do return

    return true
}

parameters_external :: proc {
    parameters_external_by_name,
    parameters_external_by_index,
}

parameters_external_by_name :: proc(parameters: rawptr, name: string) -> (parameter: rawptr, ok: bool) {
    parameter = nil
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^ParametersIF)(parameters)->Find(bstr_name, &parameter)
    if com.failed(hr) do return
    
    return parameter, true
}

parameters_external_by_index :: proc(parameters: rawptr, index: i32) -> (parameter: rawptr, ok: bool) {
    parameter = nil
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    
    hr := (^ParametersIF)(parameters)->Item(index, &parameter)
    if com.failed(hr) do return
    
    return parameter, true
}

parameters_external_index :: proc(parameters: rawptr, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^ParametersIF)(parameters)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

parameters_count :: proc(parameters: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    
    hr := (^ParametersIF)(parameters)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

parameters_remove :: proc {
    parameters_remove_by_name,
    parameters_remove_by_index,
}

parameters_remove_by_name :: proc(parameters: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return

    index: i32
    index, ok = parameters_external_index(parameters, name)
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

parameters_remove_by_index :: proc(parameters: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if parameters == nil do return
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

parameters_release :: proc(parameters: rawptr) {
    if parameters != nil {
        (^ParametersIF)(parameters)->Release()
    }
}
