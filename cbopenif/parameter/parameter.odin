package parameter

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"
import "../type"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool
@(private) Direction   :: type.DirectionType
@(private) AutoPos     :: type.AutoPos

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

parameter_new :: proc(name: string, type_name: string, attribute := "", direction := Direction.InOut, initial_value := "", readpermission := "", writepermission := "", description := "") -> (parameter: rawptr, ok: bool) {

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
    hr := factory.factoryif->NewParameter1(bstr_name, bstr_type_name, bstr_attribute, i32(direction), bstr_initial_value, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&parameter)
    if com.failed(hr) do return
    
    return parameter, true
}

parameter_deserialize :: proc(parameter: ^rawptr, xml: string) -> (ok: bool) {

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeParameter(&bs, cast(^rawptr)parameter)
    if com.failed(hr) do return
    
    return true
}

parameter_serialize :: proc(parameter: rawptr) -> (xml: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_name :: proc {
    parameter_name_get,
    parameter_name_set,
}

parameter_name_get :: proc(parameter: rawptr) -> (name: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

parameter_name_set :: proc(parameter: rawptr, name: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_type_name :: proc {
    parameter_type_name_get,
    parameter_type_name_set,
}

parameter_type_name_get :: proc(parameter: rawptr) -> (type_name: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

parameter_type_name_set :: proc(parameter: rawptr, type_name: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_attribute :: proc {
    parameter_attribute_get,
    parameter_attribute_set,
}

parameter_attribute_get :: proc(parameter: rawptr) -> (attribute: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_attribute_set :: proc(parameter: rawptr, attribute: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_description :: proc {
    parameter_description_get,
    parameter_description_set,
}

parameter_description_get :: proc(parameter: rawptr) -> (description: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_description_set :: proc(parameter: rawptr, description: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_read_permission :: proc {
    parameter_read_permission_get,
    parameter_read_permission_set,
}

parameter_read_permission_get :: proc(parameter: rawptr) -> (read_permission: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_read_permission_set :: proc(parameter: rawptr, read_permission: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_write_permission :: proc {
    parameter_write_permission_get,
    parameter_write_permission_set,
}

parameter_write_permission_get :: proc(parameter: rawptr) -> (write_permission: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_write_permission_set :: proc(parameter: rawptr, write_permission: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_authentication_level :: proc {
    parameter_authentication_level_get,
    parameter_authentication_level_set,
}

parameter_authentication_level_get :: proc(parameter: rawptr) -> (authentication_level: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_authentication_level_set :: proc(parameter: rawptr, authentication_level: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_type_guid_get :: proc(parameter: rawptr) -> (guid: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_type_path_get :: proc(parameter: rawptr) -> (path: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_access_level :: proc {
    parameter_access_level_get,
    parameter_access_level_set,
}

parameter_access_level_get :: proc(parameter: rawptr) -> (access_level: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_access_level_set :: proc(parameter: rawptr, access_level: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_safety_type :: proc {
    parameter_safety_type_get,
    parameter_safety_type_set,
}

parameter_safety_type_get :: proc(parameter: rawptr) -> (safety_type: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_safety_type_set :: proc(parameter: rawptr, safety_type: string) -> (ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_fdport :: proc {
    parameter_fdport_get,
    parameter_fdport_set,
}

parameter_fdport_get :: proc(parameter: rawptr) -> (fdport: string, ok: bool) {

    if parameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_fdport_set :: proc(parameter: rawptr, fdport: string) -> (ok: bool) {

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
