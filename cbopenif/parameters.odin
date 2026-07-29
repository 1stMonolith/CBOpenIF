package cbopenif

import "core:fmt"

Parameters  :: distinct rawptr
Parameter   :: distinct rawptr

ParametersIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ParametersVTable,
}

ParameterIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ParameterVTable,
}

ParametersVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:                    proc "system" (this: ^ParametersIF, parameter: Parameter) -> HResult,
    AddBefore:              proc "system" (this: ^ParametersIF, parameter: Parameter, index: i32) -> HResult,
    Add1:                   proc "system" (this: ^ParametersIF, name: BStr, type_name: BStr, parameter: ^Parameter) -> HResult,
    Add2:                   proc "system" (this: ^ParametersIF, name: BStr, type_name: BStr, attribute: BStr, direction: Direction, initial_value: BStr, read_permission: BStr, write_permission: BStr, description: BStr, parameter: ^Parameter) -> HResult,
    Find:                   proc "system" (this: ^ParametersIF, name: BStr, parameter: ^Parameter) -> HResult,
    FindNr:                 proc "system" (this: ^ParametersIF, name: BStr, index: ^i32) -> HResult,
    Item:                   proc "system" (this: ^ParametersIF, index: i32, parameter: ^Parameter) -> HResult,
    Count:                  proc "system" (this: ^ParametersIF, count: ^i32) -> HResult,
    Remove:                 proc "system" (this: ^ParametersIF, index: i32) -> HResult,
    NewEnum:                proc "system" (this: ^ParametersIF, Enum: ^rawptr) -> HResult,
}

ParameterVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    NameGet:                proc "system" (this: ^ParameterIF, name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ParameterIF, name: BStr) -> HResult,
    TypeGet:                proc "system" (this: ^ParameterIF, type: ^BStr) -> HResult,
    TypePut:                proc "system" (this: ^ParameterIF, type: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ParameterIF, attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ParameterIF, attribute: BStr) -> HResult,
    DirectionGet:           proc "system" (this: ^ParameterIF, direction: ^Direction) -> HResult,
    DirectionPut:           proc "system" (this: ^ParameterIF, direction: Direction) -> HResult,
    InitialValueGet:        proc "system" (this: ^ParameterIF, initial_value: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^ParameterIF, initial_value: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^ParameterIF, description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^ParameterIF, description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^ParameterIF, read_permission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^ParameterIF, read_permission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^ParameterIF, write_permission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^ParameterIF, write_permission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^ParameterIF, authentication_level: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^ParameterIF, authentication_level: BStr) -> HResult,
    TypeGuid:               proc "system" (this: ^ParameterIF, guid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^ParameterIF, path: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^ParameterIF, xml: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ParameterIF, access_level: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ParameterIF, access_level: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ParameterIF, safety_type: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ParameterIF, safety_type: BStr) -> HResult,
    FDPortGet:              proc "system" (this: ^ParameterIF, fdport: ^BStr) -> HResult,
    FDPortPut:              proc "system" (this: ^ParameterIF, fdport: BStr) -> HResult,
}

parameter_new :: proc(name: string, type: string, attribute := "", direction := Direction.InOut, initialvalue := "", readpermission := "", writepermission := "", description := "") -> (parameter: Parameter, ok: bool) {
    if !connected() do return nil, false
    bstr_name := string_to_bstr(name)
    bstr_type := string_to_bstr(type)
    bstr_attribute := string_to_bstr(attribute)
    bstr_initialvalue := string_to_bstr(initialvalue)
    bstr_readpermission := string_to_bstr(readpermission)
    bstr_writepermission := string_to_bstr(writepermission)
    bstr_description := string_to_bstr(description)
    defer {
        SysFreeString(bstr_name)
        SysFreeString(bstr_type)
        SysFreeString(bstr_attribute)
        SysFreeString(bstr_initialvalue)
        SysFreeString(bstr_readpermission)
        SysFreeString(bstr_writepermission)
        SysFreeString(bstr_description)
    }
    hr := factoryif->NewParameter1(bstr_name, bstr_type, bstr_attribute, direction, bstr_initialvalue, bstr_readpermission, bstr_writepermission, bstr_description, cast(^Parameter)&parameter)
    if failed(hr) do return nil, false
    return parameter, true
}

parameter_name :: proc(parameter: Parameter) -> (name: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->NameGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_name_set :: proc(parameter: Parameter, name: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(name)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->NamePut(bstr)
    if failed(hr) do return false
    return true
}

parameter_type :: proc(parameter: Parameter) -> (type: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->TypeGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_type_set :: proc(parameter: Parameter, type: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(type)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->TypePut(bstr)
    if failed(hr) do return false
    return true
}

parameter_attribute :: proc(parameter: Parameter) -> (attribute: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->AttributeGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_attribute_set :: proc(parameter: Parameter, attribute: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(attribute)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->AttributePut(bstr)
    if failed(hr) do return false
    return true
}

parameter_initalvalue :: proc(parameter: Parameter) -> (initalvalue: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->InitialValueGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_initalvalue_set :: proc(parameter: Parameter, initalvalue: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(initalvalue)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->InitialValuePut(bstr)
    if failed(hr) do return false
    return true
}

parameter_description :: proc(parameter: Parameter) -> (description: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_description_set :: proc(parameter: Parameter, description: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(description)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bstr)
    if failed(hr) do return false
    return true
}

parameter_readpermission :: proc(parameter: Parameter) -> (readpermission: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_readpermission_set :: proc(parameter: Parameter, readpermission: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(readpermission)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bstr)
    if failed(hr) do return false
    return true
}

parameter_writepermission :: proc(parameter: Parameter) -> (writepermission: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_writepermission_set :: proc(parameter: Parameter, writepermission: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(writepermission)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bstr)
    if failed(hr) do return false
    return true
}

parameter_authenticationlevel :: proc(parameter: Parameter) -> (authenticationlevel: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_authenticationlevel_set :: proc(parameter: Parameter, authenticationlevel: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(authenticationlevel)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bstr)
    if failed(hr) do return false
    return true
}

parameter_typeguid :: proc(parameter: Parameter) -> (guid: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->TypeGuid(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_typepath :: proc(parameter: Parameter) -> (path: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->TypePath(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_serialize :: proc(parameter: Parameter) -> (xml: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->Serialize(&bstr)
    if failed(hr) do return "", false
    fmt.printf(bstr_to_string(bstr))
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_deserialize :: proc(parameter: ^Parameter, xml: string) -> (ok: bool)
{
    if !connected() do return false
    bstr := string_to_bstr(xml)
    defer SysFreeString(bstr)
    hr := factoryif->DeserializeParameter(&bstr, cast(^Parameter)parameter)
    if failed(hr) do return false
    return true
}

parameter_accesslevel :: proc(parameter: Parameter) -> (accesslevel: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_accesslevel_set :: proc(parameter: Parameter, accesslevel: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(accesslevel)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bstr)
    if failed(hr) do return false
    return true
}

parameter_safetytype :: proc(parameter: Parameter) -> (safetytype: string, ok: bool) {
    if parameter == nil do return "", false
    if !connected() do return "", false
    bstr: BStr
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bstr)
    if failed(hr) do return "", false
    defer SysFreeString(bstr)
    return bstr_to_string(bstr), true
}

parameter_safetytype_set :: proc(parameter: Parameter, safetytype: string) -> (ok: bool) {
    if parameter == nil do return false
    if !connected() do return false
    bstr := string_to_bstr(safetytype)
    defer SysFreeString(bstr)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bstr)
    if failed(hr) do return false
    return true
}

parameter_release :: proc(parameter: Parameter) {
    if parameter != nil {
        (^ParameterIF)(parameter)->Release()
    }
}
