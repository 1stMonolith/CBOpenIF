package cbopenif

Parameter   :: distinct rawptr

ParameterIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^ParameterVTable,
}

ParameterVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^ParameterIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ParameterIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^ParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^ParameterIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ParameterIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ParameterIF, Attribute: BStr) -> HResult,
    DirectionGet:           proc "system" (this: ^ParameterIF, Direction: ^Direction) -> HResult,
    DirectionPut:           proc "system" (this: ^ParameterIF, Direction: Direction) -> HResult,
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

parameter_new :: proc(name: string, type_name: string, attribute := "", direction := Direction.InOut, initial_value := "", readpermission := "", writepermission := "", description := "") -> (parameter: Parameter, ok: bool) {
    parameter = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_type_name := string_to_bstr(type_name)
    bstr_attribute := string_to_bstr(attribute)
    bstr_initial_value := string_to_bstr(initial_value)
    bstr_readpermission := string_to_bstr(readpermission)
    bstr_writepermission := string_to_bstr(writepermission)
    bstr_description := string_to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_readpermission)
        bstr_free(bstr_writepermission)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewParameter1(bstr_name, bstr_type_name, bstr_attribute, i32(direction), bstr_initial_value, bstr_readpermission, bstr_writepermission, bstr_description, cast(^Parameter)&parameter)
    if failed(hr) do return
    
    return parameter, true
}

parameter_deserialize :: proc(parameter: ^Parameter, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeParameter(&bstr, cast(^Parameter)parameter)
    if failed(hr) do return
    
    return true
}

parameter_serialize :: proc(parameter: Parameter) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

parameter_name :: proc {
    parameter_name_,
    parameter_name_set,
}

@(private)
parameter_name_ :: proc(parameter: Parameter) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
parameter_name_set :: proc(parameter: Parameter, name: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_type_name :: proc {
    parameter_type_name_,
    parameter_type_name_set,
}

@(private)
parameter_type_name_ :: proc(parameter: Parameter) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->TypeNameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
parameter_type_name_set :: proc(parameter: Parameter, type_name: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return

    bstr := string_to_bstr(type_name)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->TypeNamePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_attribute :: proc {
    parameter_attribute_,
    parameter_attribute_set,
}

@(private)
parameter_attribute_ :: proc(parameter: Parameter) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if parameter == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->AttributeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_attribute_set :: proc(parameter: Parameter, attribute: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return

    bstr := string_to_bstr(attribute)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->AttributePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_description :: proc {
    parameter_description_,
    parameter_description_set,
}

@(private)
parameter_description_ :: proc(parameter: Parameter) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_description_set :: proc(parameter: Parameter, description: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_read_permission :: proc {
    parameter_read_permission_,
    parameter_read_permission_set,
}

@(private)
parameter_read_permission_ :: proc(parameter: Parameter) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_read_permission_set :: proc(parameter: Parameter, read_permission: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(read_permission)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_write_permission :: proc {
    parameter_write_permission_,
    parameter_write_permission_set,
}

@(private)
parameter_write_permission_ :: proc(parameter: Parameter) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_write_permission_set :: proc(parameter: Parameter, write_permission: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(write_permission)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_authentication_level :: proc {
    parameter_authentication_level_,
    parameter_authentication_level_set,
}

@(private)
parameter_authentication_level_ :: proc(parameter: Parameter) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_authentication_level_set :: proc(parameter: Parameter, authentication_level: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(authentication_level)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_type_guid :: proc(parameter: Parameter) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->TypeGuid(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

parameter_type_path :: proc(parameter: Parameter) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->TypePath(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

parameter_access_level :: proc {
    parameter_access_level_,
    parameter_access_level_set,
}

@(private)
parameter_access_level_ :: proc(parameter: Parameter) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_access_level_set :: proc(parameter: Parameter, access_level: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(access_level)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_safety_type :: proc {
    parameter_safety_type_,
    parameter_safety_type_set,
}

@(private)
parameter_safety_type_ :: proc(parameter: Parameter) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_safety_type_set :: proc(parameter: Parameter, safety_type: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(safety_type)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_fdport :: proc {
    parameter_fdport_,
    parameter_fdport_set,
}

@(private)
parameter_fdport_ :: proc(parameter: Parameter) -> (fdport: string, ok: bool) {
    fdport = ""
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_fdport_set :: proc(parameter: Parameter, fdport: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(fdport)
    defer bstr_free(bstr)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_release :: proc(parameter: Parameter) {
    if parameter != nil {
        (^ParameterIF)(parameter)->Release()
    }
}
