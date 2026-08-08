package cbopenif

Parameters :: distinct rawptr

ParametersIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParametersVTable,
}

ParametersVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ParametersIF, Parameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ParametersIF, Parameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParametersIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ParametersIF, Name, TypeName, Attribute, Direction, InitialValue, ReadPermission, WritePermission, Description: BStr, Parameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ParametersIF, Name: BStr, Parameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParametersIF, Index: i32, Parameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ParametersIF, count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParametersIF, Index: i32) -> HResult,
}

parameters_parameter_add :: proc {
    parameters_parameter_add_,
    parameters_parameter_add_at_index,
}

parameters_parameter_add_ :: proc(parameters: Parameters, parameter: Parameter) -> (ok: bool) {
    if parameters == nil do return
    if parameter == nil do return
    if !controlbuilder_connected() do return

    hr := (^ParametersIF)(parameters)->Add(parameter)
    if com_failed(hr) do return

    return true
}

parameters_parameter_add_at_index :: proc(parameters: Parameters, parameter: Parameter, index: i32) -> (ok: bool) {
    if parameters == nil do return
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParametersIF)(parameters)->AddBefore(parameter, index)
    if com_failed(hr) do return

    return true
}

parameters_parameter :: proc {
    parameters_parameter_by_name,
    parameters_parameter_by_index,
}

parameters_parameter_by_name :: proc(parameters: Parameters, name: string) -> (parameter: Parameter, ok: bool) {
    if parameters == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParametersIF)(parameters)->Find(bstr_name, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

parameters_parameter_by_index :: proc(parameters: rawptr, index: i32) -> (parameter: rawptr, ok: bool) {
    if parameters == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParametersIF)(parameters)->Item(index, &parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

parameters_parameter_index :: proc(parameters: Parameters, name: string) -> (index: i32, ok: bool) {
    if parameters == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParametersIF)(parameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index, true
}

parameters_parameter_count :: proc(parameters: Parameters) -> (count: i32, ok: bool) {
    if parameters == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParametersIF)(parameters)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

parameters_parameter_remove :: proc {
    parameters_parameter_remove_by_name,
    parameters_parameter_remove_by_index,
}

parameters_parameter_remove_by_name :: proc(parameters: Parameters, name: string) -> (ok: bool) {
    if parameters == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = parameters_parameter_index(parameters, name)
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

parameters_parameter_remove_by_index :: proc(parameters: Parameters, index: i32) -> (ok: bool) {
    if parameters == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

parameters_release :: proc(parameters: Parameters) {
    if parameters != nil {
        (^ParametersIF)(parameters)->Release()
    }
}
