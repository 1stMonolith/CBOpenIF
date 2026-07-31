package parameter

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

ParameterIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ParameterVTable,
}

ParameterVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

parameter_new :: proc(name: string, type_name: string, attribute := "", direction := Direction.InOut, initial_value := "", readpermission := "", writepermission := "", description := "") -> (parameter: rawptr, ok: bool) {
    parameter = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_type_name := bstr.from_string(type_name)
    bstr_attribute := bstr.from_string(attribute)
    bstr_initial_value := bstr.from_string(initial_value)
    bstr_readpermission := bstr.from_string(readpermission)
    bstr_writepermission := bstr.from_string(writepermission)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_type_name)
        bstr.free(bstr_attribute)
        bstr.free(bstr_initial_value)
        bstr.free(bstr_readpermission)
        bstr.free(bstr_writepermission)
        bstr.free(bstr_description)
    }
    hr := factoryif->NewParameter1(bstr_name, bstr_type_name, bstr_attribute, i32(direction), bstr_initial_value, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&parameter)
    if com.failed(hr) do return
    
    return parameter, true
}

parameter_deserialize :: proc(parameter: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factoryif->DeserializeParameter(&bstr, cast(^rawptr)parameter)
    if com.failed(hr) do return
    
    return true
}

parameter_serialize :: proc(parameter: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_name :: proc {
    parameter_name_,
    parameter_name_set,
}

@(private)
parameter_name_ :: proc(parameter: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
parameter_name_set :: proc(parameter: rawptr, name: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_type_name :: proc {
    parameter_type_name_,
    parameter_type_name_set,
}

@(private)
parameter_type_name_ :: proc(parameter: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
parameter_type_name_set :: proc(parameter: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_attribute :: proc {
    parameter_attribute_,
    parameter_attribute_set,
}

@(private)
parameter_attribute_ :: proc(parameter: rawptr) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_attribute_set :: proc(parameter: rawptr, attribute: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_description :: proc {
    parameter_description_,
    parameter_description_set,
}

@(private)
parameter_description_ :: proc(parameter: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_description_set :: proc(parameter: rawptr, description: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_read_permission :: proc {
    parameter_read_permission_,
    parameter_read_permission_set,
}

@(private)
parameter_read_permission_ :: proc(parameter: rawptr) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_read_permission_set :: proc(parameter: rawptr, read_permission: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_write_permission :: proc {
    parameter_write_permission_,
    parameter_write_permission_set,
}

@(private)
parameter_write_permission_ :: proc(parameter: rawptr) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_write_permission_set :: proc(parameter: rawptr, write_permission: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_authentication_level :: proc {
    parameter_authentication_level_,
    parameter_authentication_level_set,
}

@(private)
parameter_authentication_level_ :: proc(parameter: rawptr) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_authentication_level_set :: proc(parameter: rawptr, authentication_level: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_type_guid :: proc(parameter: rawptr) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_type_path :: proc(parameter: rawptr) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_access_level :: proc {
    parameter_access_level_,
    parameter_access_level_set,
}

@(private)
parameter_access_level_ :: proc(parameter: rawptr) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_access_level_set :: proc(parameter: rawptr, access_level: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_safety_type :: proc {
    parameter_safety_type_,
    parameter_safety_type_set,
}

@(private)
parameter_safety_type_ :: proc(parameter: rawptr) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_safety_type_set :: proc(parameter: rawptr, safety_type: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_fdport :: proc {
    parameter_fdport_,
    parameter_fdport_set,
}

@(private)
parameter_fdport_ :: proc(parameter: rawptr) -> (fdport: string, ok: bool) {
    fdport = ""
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
parameter_fdport_set :: proc(parameter: rawptr, fdport: string) -> (ok: bool) {
    ok = false

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(fdport)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_release :: proc(parameter: rawptr) {
    if parameter != nil {
        (^ParameterIF)(parameter)->Release()
    }
}
