package parameter

Parameters  :: distinct rawptr

ParametersIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^ParametersVTable,
}

ParametersVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:       proc "system" (this: ^ParametersIF, Parameter: Parameter) -> HResult,
    AddBefore: proc "system" (this: ^ParametersIF, Parameter: Parameter, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParametersIF, Name, TypeName: BStr, Parameter: ^Parameter) -> HResult,
    Add2:      proc "system" (this: ^ParametersIF, Name, TypeName, Attribute, Direction, InitialValue, ReadPermission, WritePermission, Description: BStr, Parameter: ^Parameter) -> HResult,
    Find:      proc "system" (this: ^ParametersIF, Name: BStr, Parameter: ^Parameter) -> HResult,
    FindNr:    proc "system" (this: ^ParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParametersIF, Index: i32, Parameter: ^Parameter) -> HResult,
    Count:     proc "system" (this: ^ParametersIF, count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParametersIF, Index: i32) -> HResult,
    NewEnum:   proc "system" (this: ^ParametersIF, Enum: ^rawptr) -> HResult,
}

parameters_add :: proc {
    parameters_add_,
    parameters_add_at_index,
}

@(private)
parameters_add_ :: proc(parameters: Parameters, parameter: Parameter) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameters == nil do return
    if parameter == nil do return

    hr := (^ParametersIF)(parameters)->Add(parameter)
    if failed(hr) do return

    return true
}

parameters_add_at_index :: proc(parameters: Parameters, parameter: Parameter, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameters == nil do return
    if parameter == nil do return
    
    hr := (^ParametersIF)(parameters)->AddBefore(parameter, index)
    if failed(hr) do return

    return true
}

parameters_external :: proc {
    parameters_external_by_name,
    parameters_external_by_index,
}

parameters_external_by_name :: proc(parameters: Parameters, name: string) -> (parameter: Parameter, ok: bool) {
    parameter = nil
    ok = false

    if !connected() do return
    if parameters == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^ParametersIF)(parameters)->Find(bstr_name, &parameter)
    if failed(hr) do return
    
    return parameter, true
}

parameters_external_by_index :: proc(parameters: Parameters, index: i32) -> (parameter: Parameter, ok: bool) {
    parameter = nil
    ok = false

    if !connected() do return
    if parameters == nil do return
    
    hr := (^ParametersIF)(parameters)->Item(index, &parameter)
    if failed(hr) do return
    
    return parameter, true
}

parameters_external_index :: proc(parameters: Parameters, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if parameters == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^ParametersIF)(parameters)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

parameters_count :: proc(parameters: Parameters) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if parameters == nil do return
    
    hr := (^ParametersIF)(parameters)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

parameters_remove :: proc {
    parameters_remove_by_name,
    parameters_remove_by_index,
}

parameters_remove_by_name :: proc(parameters: Parameters, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameters == nil do return

    index: i32
    index, ok = parameters_external_index(parameters, name)
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if failed(hr) do return
    
    return true
}

parameters_remove_by_index :: proc(parameters: Parameters, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameters == nil do return
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if failed(hr) do return
    
    return true
}

parameters_release :: proc(parameters: Parameters) {
    if parameters != nil {
        (^ParametersIF)(parameters)->Release()
    }
}
