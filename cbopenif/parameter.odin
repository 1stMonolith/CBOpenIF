package cbopenif

ParameterType :: enum i32 {
    Parameter     = 0,
    Extensible    = 1,
    ControlModule = 2,
}

Parameter :: distinct rawptr

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

parameter_new :: proc(name: string, type_name: string, attribute := "", direction := DirectionType.InOut, initial_value := "", readpermission := "", writepermission := "", description := "") -> (parameter: Parameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    bstr_attribute := to_bstr(attribute)
    bstr_initial_value := to_bstr(initial_value)
    bstr_readpermission := to_bstr(readpermission)
    bstr_writepermission := to_bstr(writepermission)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_readpermission)
        bstr_free(bstr_writepermission)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewParameter1(bstr_name, bstr_type_name, bstr_attribute, i32(direction), bstr_initial_value, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

parameter_deserialize :: proc(parameter: ^Parameter, xml: string) -> (ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeParameter(&bs, cast(^rawptr)parameter)
    if com_failed(hr) do return
    
    return true
}

parameter_serialize :: proc(parameter: Parameter) -> (xml: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_name :: proc {
    parameter_name_get,
    parameter_name_set,
}

parameter_name_get :: proc(parameter: Parameter) -> (name: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parameter_name_set :: proc(parameter: Parameter, name: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_type_name :: proc {
    parameter_type_name_get,
    parameter_type_name_set,
}

parameter_type_name_get :: proc(parameter: Parameter) -> (type_name: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parameter_type_name_set :: proc(parameter: Parameter, type_name: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_attribute :: proc {
    parameter_attribute_get,
    parameter_attribute_set,
}

parameter_attribute_get :: proc(parameter: Parameter) -> (attribute: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_attribute_set :: proc(parameter: Parameter, attribute: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_direction :: proc {
    parameter_direction_get,
    parameter_direction_set,
}

parameter_direction_get :: proc(parameter: Parameter) -> (direction: DirectionType, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return

    d: i32
    hr := (^ParameterIF)(parameter)->DirectionGet(&d)
    if com_failed(hr) do return
    
    return DirectionType(d), true
}

parameter_direction_set :: proc(parameter: Parameter, direction: DirectionType) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return

    hr := (^ParameterIF)(parameter)->DirectionPut(i32(direction))
    if com_failed(hr) do return
    
    return true
}

parameter_initial_value :: proc {
    parameter_initial_value_get,
    parameter_initial_value_set,
}

parameter_initial_value_get :: proc(parameter: Parameter) -> (inital_value: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parameter_initial_value_set :: proc(parameter: Parameter, inital_value: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_description :: proc {
    parameter_description_get,
    parameter_description_set,
}

parameter_description_get :: proc(parameter: Parameter) -> (description: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_description_set :: proc(parameter: Parameter, description: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_read_permission :: proc {
    parameter_read_permission_get,
    parameter_read_permission_set,
}

parameter_read_permission_get :: proc(parameter: Parameter) -> (read_permission: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_read_permission_set :: proc(parameter: Parameter, read_permission: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_write_permission :: proc {
    parameter_write_permission_get,
    parameter_write_permission_set,
}

parameter_write_permission_get :: proc(parameter: Parameter) -> (write_permission: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_write_permission_set :: proc(parameter: Parameter, write_permission: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_authentication_level :: proc {
    parameter_authentication_level_get,
    parameter_authentication_level_set,
}

parameter_authentication_level_get :: proc(parameter: Parameter) -> (authentication_level: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_authentication_level_set :: proc(parameter: Parameter, authentication_level: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_type_guid_get :: proc(parameter: Parameter) -> (guid: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_type_path_get :: proc(parameter: Parameter) -> (path: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_access_level :: proc {
    parameter_access_level_get,
    parameter_access_level_set,
}

parameter_access_level_get :: proc(parameter: Parameter) -> (access_level: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_access_level_set :: proc(parameter: Parameter, access_level: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_safety_type :: proc {
    parameter_safety_type_get,
    parameter_safety_type_set,
}

parameter_safety_type_get :: proc(parameter: Parameter) -> (safety_type: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_safety_type_set :: proc(parameter: Parameter, safety_type: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_fdport :: proc {
    parameter_fdport_get,
    parameter_fdport_set,
}

parameter_fdport_get :: proc(parameter: Parameter) -> (fdport: string, ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parameter_fdport_set :: proc(parameter: Parameter, fdport: string) -> (ok: bool) {
    if parameter == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(fdport)
    defer bstr_free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

parameter_release :: proc(parameter: Parameter) {
    if parameter != nil {
        (^ParameterIF)(parameter)->Release()
    }
}
