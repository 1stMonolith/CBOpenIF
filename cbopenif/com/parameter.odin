package com

import t "../types"

Parameter  :: distinct rawptr
Parameters :: distinct rawptr
ExtensibleParameter  :: distinct rawptr
ExtensibleParameters :: distinct rawptr

ParameterIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParameterVTable,
}

ParameterVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^ParameterIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ParameterIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^ParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^ParameterIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ParameterIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ParameterIF, Attribute: BStr) -> HResult,
    DirectionGet:           proc "system" (this: ^ParameterIF, Direction: ^i32) -> HResult,
    DirectionPut:           proc "system" (this: ^ParameterIF, Direction: i32) -> HResult,
    InitialValueGet:        proc "system" (this: ^ParameterIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^ParameterIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^ParameterIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^ParameterIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^ParameterIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^ParameterIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^ParameterIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^ParameterIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^ParameterIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^ParameterIF, AuthenticationLevel: BStr) -> HResult,
    TypeGuid:               proc "system" (this: ^ParameterIF, Guid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^ParameterIF, Path: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^ParameterIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ParameterIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ParameterIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ParameterIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ParameterIF, SafetyType: BStr) -> HResult,
    FDPortGet:              proc "system" (this: ^ParameterIF, FDPort: ^BStr) -> HResult,
    FDPortPut:              proc "system" (this: ^ParameterIF, FDPort: BStr) -> HResult,
}

parameter_serialize :: proc(parameter: Parameter) -> (xml: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_name_get :: proc(parameter: Parameter) -> (name: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parameter_name_set :: proc(parameter: Parameter, name: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_type_name_get :: proc(parameter: Parameter) -> (type_name: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parameter_type_name_set :: proc(parameter: Parameter, type_name: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_attribute_get :: proc(parameter: Parameter) -> (attribute: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_attribute_set :: proc(parameter: Parameter, attribute: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_direction_get :: proc(parameter: Parameter) -> (direction: t.Direction, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return

    d: i32
    hr := (^ParameterIF)(parameter)->DirectionGet(&d)
    if com_failed(hr) do return
    
    return t.Direction(d), true
}

parameter_direction_set :: proc(parameter: Parameter, direction: t.Direction) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return

    hr := (^ParameterIF)(parameter)->DirectionPut(i32(direction))
    if com_failed(hr) do return
    
    return true
}

parameter_initial_value_get :: proc(parameter: Parameter) -> (inital_value: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parameter_initial_value_set :: proc(parameter: Parameter, inital_value: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_description_get :: proc(parameter: Parameter) -> (description: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_description_set :: proc(parameter: Parameter, description: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_read_permission_get :: proc(parameter: Parameter) -> (read_permission: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_read_permission_set :: proc(parameter: Parameter, read_permission: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_write_permission_get :: proc(parameter: Parameter) -> (write_permission: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_write_permission_set :: proc(parameter: Parameter, write_permission: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_authentication_level_get :: proc(parameter: Parameter) -> (authentication_level: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_authentication_level_set :: proc(parameter: Parameter, authentication_level: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_type_guid_get :: proc(parameter: Parameter) -> (guid: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_type_path_get :: proc(parameter: Parameter) -> (path: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_access_level_get :: proc(parameter: Parameter) -> (access_level: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_access_level_set :: proc(parameter: Parameter, access_level: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_safety_type_get :: proc(parameter: Parameter) -> (safety_type: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_safety_type_set :: proc(parameter: Parameter, safety_type: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_fdport_get :: proc(parameter: Parameter) -> (fdport: string, ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->FDPortGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_fdport_set :: proc(parameter: Parameter, fdport: string) -> (ok: bool) {
    if parameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(fdport)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->FDPortPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_release :: proc(parameter: Parameter) {
    if parameter != nil {
        (^ParameterIF)(parameter)->Release()
    }
}

parameter_from_com :: proc(parameter: Parameter, allocator := context.allocator) -> (result: t.Parameter, ok: bool) {
    if parameter == nil do return

    context.allocator = allocator

    result.name, ok = name(parameter)
    if !ok do return
    result.type_name, ok = type_name(parameter)
    if !ok do return
    result.attribute, ok = attribute(parameter)
    if !ok do return
    result.direction, ok = direction(parameter)
    if !ok do return
    result.initial_value, ok = initial_value(parameter)
    if !ok do return
    result.description, ok = description(parameter)
    if !ok do return
    result.read_permission, ok = read_permission(parameter)
    if !ok do return
    result.write_permission, ok = write_permission(parameter)
    if !ok do return
    result.authentication_level, ok = authentication_level(parameter)
    if !ok do return
    result.access_level, ok = access_level(parameter)
    if !ok do return
    result.safety_type, ok = safety_type(parameter)
    if !ok do return
    result.fd_port, ok = fdport(parameter)
    if !ok do return
    result.type_guid, ok = type_guid(parameter)
    if !ok do return
    result.type_path, ok = type_path(parameter)
    if !ok do return

    return result, true
}

parameter_to_com :: proc(src: t.Parameter) -> (result: Parameter, ok: bool) {
    parameter: Parameter
    parameter, ok = parameter_new1(
        src.name,
        src.type_name,
        src.attribute,
        i32(src.direction),
        src.initial_value,
        src.read_permission,
        src.write_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(parameter)

    ok = authentication_level(parameter, src.authentication_level)
    if !ok do return
    ok = access_level(parameter, src.access_level)
    if !ok do return
    ok = safety_type(parameter, src.safety_type)
    if !ok do return
    ok = fdport(parameter, src.fd_port)
    if !ok do return

    // type_guid / type_path are read-only

    return parameter, true
}

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

parameters_parameter_add :: proc(parameters: Parameters, parameter: Parameter) -> (ok: bool) {
    if parameters == nil do return
    if parameter == nil do return
    if !com_connected() do return

    hr := (^ParametersIF)(parameters)->Add(parameter)
    if com_failed(hr) do return

    return true
}

parameters_parameter_add_at_index :: proc(parameters: Parameters, parameter: Parameter, index: i32) -> (ok: bool) {
    if parameters == nil do return
    if parameter == nil do return
    if !com_connected() do return
    
    hr := (^ParametersIF)(parameters)->AddBefore(parameter, index)
    if com_failed(hr) do return

    return true
}

parameters_parameter_by_name :: proc(parameters: Parameters, name: string) -> (parameter: Parameter, ok: bool) {
    if parameters == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParametersIF)(parameters)->Find(bstr_name, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

parameters_parameter_by_index :: proc(parameters: rawptr, index: i32) -> (parameter: Parameter, ok: bool) {
    if parameters == nil do return
    if !com_connected() do return
    
    hr := (^ParametersIF)(parameters)->Item(index + 1, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

parameters_parameter_index :: proc(parameters: Parameters, name: string) -> (index: i32, ok: bool) {
    if parameters == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParametersIF)(parameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

parameters_parameter_count :: proc(parameters: Parameters) -> (count: i32, ok: bool) {
    if parameters == nil do return
    if !com_connected() do return
    
    hr := (^ParametersIF)(parameters)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

parameters_parameter_remove_by_name :: proc(parameters: Parameters, name: string) -> (ok: bool) {
    if parameters == nil do return
    if !com_connected() do return

    index: i32
    index, ok = parameters_parameter_index(parameters, name)
    
    hr := (^ParametersIF)(parameters)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

parameters_parameter_remove_by_index :: proc(parameters: Parameters, index: i32) -> (ok: bool) {
    if parameters == nil do return
    if !com_connected() do return
    
    hr := (^ParametersIF)(parameters)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

parameters_release :: proc(parameters: Parameters) {
    if parameters != nil {
        (^ParametersIF)(parameters)->Release()
    }
}

parameters_from_com :: proc(params: Parameters, allocator := context.allocator) -> (result: [dynamic]t.Parameter, ok: bool) {
    if params == nil do return
    context.allocator = allocator

    count: i32
    count, ok = parameter_count(params)
    if !ok do return

    result = make([dynamic]t.Parameter, 0, int(count), allocator)
    for i in 0..<count {
        pr: Parameter
        pr, ok = parameter_by_index(params, i)
        if !ok do return
        p := Parameter(pr)
        defer release(p)

        ps: t.Parameter
        ps, ok = parameter_from_com(p)
        if !ok do return
        append(&result, ps)
    }
    return result, true
}

parameters_to_com :: proc(params: Parameters, src: []t.Parameter) -> (ok: bool) {
    if params == nil do return
    for item in src {
        p: Parameter
        p, ok = parameter_to_com(item)
        if !ok do return
        defer release(p)

        ok = parameter_add(params, p)
        if !ok do return
    }
    return true
}

ExtensibleParameterIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParameterVTable,
}

ExtensibleParameterVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ExtensibleParameterIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ExtensibleParameterIF, Name: BStr) -> HResult,
    TypeNameGet:     proc "system" (this: ^ExtensibleParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:     proc "system" (this: ^ExtensibleParameterIF, TypeName: BStr) -> HResult,
    AttributeGet:    proc "system" (this: ^ExtensibleParameterIF, Attribute: ^BStr) -> HResult,
    AttributePut:    proc "system" (this: ^ExtensibleParameterIF, Attribute: BStr) -> HResult,
    DirectionGet:    proc "system" (this: ^ExtensibleParameterIF, Direction: ^i32) -> HResult,
    DirectionPut:    proc "system" (this: ^ExtensibleParameterIF, Direction: i32) -> HResult,
    InitialValueGet: proc "system" (this: ^ExtensibleParameterIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut: proc "system" (this: ^ExtensibleParameterIF, InitialValue: BStr) -> HResult,
    DescriptionGet:  proc "system" (this: ^ExtensibleParameterIF, Description: ^BStr) -> HResult,
    DescriptionPut:  proc "system" (this: ^ExtensibleParameterIF, Description: BStr) -> HResult,
    Serialize:       proc "system" (this: ^ExtensibleParameterIF, XML: ^BStr) -> HResult,
    AccessLevelGet:  proc "system" (this: ^ExtensibleParameterIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:  proc "system" (this: ^ExtensibleParameterIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:   proc "system" (this: ^ExtensibleParameterIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:   proc "system" (this: ^ExtensibleParameterIF, SafetyType: BStr) -> HResult,
    TypeGuid:        proc "system" (this: ^ExtensibleParameterIF, Guid: ^BStr) -> HResult,
    TypePath:        proc "system" (this: ^ExtensibleParameterIF, Path: ^BStr) -> HResult,
    FDPortGet:       proc "system" (this: ^ExtensibleParameterIF, FDPort: ^BStr) -> HResult,
    FDPortPut:       proc "system" (this: ^ExtensibleParameterIF, FDPort: BStr) -> HResult,
}

extensibleparameter_serialize :: proc(extensibleparameter: ExtensibleParameter) -> (xml: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_name_get :: proc(extensibleparameter: ExtensibleParameter) -> (name: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_name_set :: proc(extensibleparameter: ExtensibleParameter, name: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_type_name_get :: proc(extensibleparameter: ExtensibleParameter) -> (type_name: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_type_name_set :: proc(extensibleparameter: ExtensibleParameter, type_name: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNamePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_attribute_get :: proc(extensibleparameter: ExtensibleParameter) -> (attribute: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_attribute_set :: proc(extensibleparameter: ExtensibleParameter, attribute: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_direction_get :: proc(extensibleparameter: ExtensibleParameter) -> (direction: t.Direction, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    d: i32
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionGet(&d)
    if com_failed(hr) do return

    return t.Direction(d), true
}

extensibleparameter_direction_set :: proc(extensibleparameter: ExtensibleParameter, direction: t.Direction) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionPut(i32(direction))
    if com_failed(hr) do return

    return true
}

extensibleparameter_initial_value_get :: proc(extensibleparameter: ExtensibleParameter) -> (initial_value: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_initial_value_set :: proc(extensibleparameter: ExtensibleParameter, initial_value: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(initial_value)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValuePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_description_get :: proc(extensibleparameter: ExtensibleParameter) -> (description: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_description_set :: proc(extensibleparameter: ExtensibleParameter, description: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_access_level_get :: proc(extensibleparameter: ExtensibleParameter) -> (access_level: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_access_level_set :: proc(extensibleparameter: ExtensibleParameter, access_level: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_safety_type_get :: proc(extensibleparameter: ExtensibleParameter) -> (safety_type: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_safety_type_set :: proc(extensibleparameter: ExtensibleParameter, safety_type: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_type_guid_get :: proc(extensibleparameter: ExtensibleParameter) -> (guid: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeGuid(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_type_path_get :: proc(extensibleparameter: ExtensibleParameter) -> (path: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypePath(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_fdport_get :: proc(extensibleparameter: ExtensibleParameter) -> (fdport: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_fdport_set :: proc(extensibleparameter: ExtensibleParameter, fdport: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(fdport)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_release :: proc(extensibleparameter: ExtensibleParameter) {
    if extensibleparameter != nil {
        (^ExtensibleParameterIF)(extensibleparameter)->Release()
    }
}

extensibleparameter_from_com :: proc(extensibleparameter: ExtensibleParameter, allocator := context.allocator) -> (result: t.ExtensibleParameter, ok: bool) {
    if extensibleparameter == nil do return

    context.allocator = allocator

    result.name, ok = name(extensibleparameter)
    if !ok do return
    result.type_name, ok = type_name(extensibleparameter)
    if !ok do return
    result.attribute, ok = attribute(extensibleparameter)
    if !ok do return
    result.direction, ok = direction(extensibleparameter)
    if !ok do return
    result.initial_value, ok = initial_value(extensibleparameter)
    if !ok do return
    result.description, ok = description(extensibleparameter)
    if !ok do return
    result.access_level, ok = access_level(extensibleparameter)
    if !ok do return
    result.safety_type, ok = safety_type(extensibleparameter)
    if !ok do return
    result.fd_port, ok = fdport(extensibleparameter)
    if !ok do return
    result.type_guid, ok = type_guid(extensibleparameter)
    if !ok do return
    result.type_path, ok = type_path(extensibleparameter)
    if !ok do return

    return result, true
}

extensibleparameter_to_com :: proc(src: t.ExtensibleParameter) -> (result: ExtensibleParameter, ok: bool) {
    extensibleparameter: ExtensibleParameter
    extensibleparameter, ok = extensibleparameter_new1(
        src.name,
        src.type_name,
        src.attribute,
        i32(src.direction),
        src.initial_value,
        src.description,
    )
    if !ok do return
    defer if !ok do release(extensibleparameter)

    ok = access_level(extensibleparameter, src.access_level)
    if !ok do return
    ok = safety_type(extensibleparameter, src.safety_type)
    if !ok do return
    ok = fdport(extensibleparameter, src.fd_port)
    if !ok do return

    // type_guid / type_path are read-only

    return extensibleparameter, true
}

ExtensibleParametersIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParametersVTable,
}

ExtensibleParametersVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ExtensibleParametersIF, Parameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ExtensibleParametersIF, Parameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExtensibleParametersIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ExtensibleParametersIF, Name, TypeName, Attribute: BStr, Direction: i32, InitialValue, Description: BStr, Parameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ExtensibleParametersIF, Name: BStr, Parameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ExtensibleParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExtensibleParametersIF, Index: i32, Parameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ExtensibleParametersIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExtensibleParametersIF, Index: i32) -> HResult,
}

extensibleparameters_extensibleparameter_add :: proc(extensibleparameters: ExtensibleParameters, extensibleparameter: ExtensibleParameter) -> (ok: bool) {
    if extensibleparameters == nil do return
    if extensibleparameter == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Add(extensibleparameter)
    if com_failed(hr) do return

    return true
}

extensibleparameters_extensibleparameter_add_at_index :: proc(extensibleparameters: ExtensibleParameters, extensibleparameter: ExtensibleParameter, index: i32) -> (ok: bool) {
    if extensibleparameters == nil do return
    if extensibleparameter == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->AddBefore(extensibleparameter, index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_extensibleparameter_by_name :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->Find(bstr_name, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return

    return extensibleparameter, true
}

extensibleparameters_extensibleparameter_by_index :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Item(index + 1, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return

    return extensibleparameter, true
}

extensibleparameters_extensibleparameter_index :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (index: i32, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

extensibleparameters_extensibleparameter_count :: proc(extensibleparameters: ExtensibleParameters) -> (count: i32, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

extensibleparameters_extensibleparameter_remove_by_name :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    index, found := extensibleparameters_extensibleparameter_index(extensibleparameters, name)
    if !found do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_extensibleparameter_remove_by_index :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

extensibleparameters_release :: proc(extensibleparameters: ExtensibleParameters) {
    if extensibleparameters != nil {
        (^ExtensibleParametersIF)(extensibleparameters)->Release()
    }
}

extensibleparameters_from_com :: proc(eparams: ExtensibleParameters, allocator := context.allocator) -> (result: [dynamic]t.ExtensibleParameter, ok: bool) {
    if eparams == nil do return
    context.allocator = allocator

    count: i32
    count, ok = extensibleparameter_count(eparams)
    if !ok do return

    result = make([dynamic]t.ExtensibleParameter, 0, int(count), allocator)
    for i in 0..<count {
        ep: ExtensibleParameter
        ep, ok = extensibleparameter_by_index(eparams, i)
        if !ok do return
        defer release(ep)

        eps: t.ExtensibleParameter
        eps, ok = extensibleparameter_from_com(ep)
        if !ok do return
        append(&result, eps)
    }
    return result, true
}

extensibleparameters_to_com :: proc(eparams: ExtensibleParameters, src: []t.ExtensibleParameter) -> (ok: bool) {
    if eparams == nil do return
    for item in src {
        ep: ExtensibleParameter
        ep, ok = extensibleparameter_to_com(item)
        if !ok do return
        defer release(ep)

        ok = extensibleparameter_add(eparams, ep)
        if !ok do return
    }
    return true
}
