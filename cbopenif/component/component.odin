package component

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

ComponentIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ComponentVTable,
}

ComponentVTable :: struct {
    using iunknown_vtable: com.IUnknownVTable,
    NameGet:                proc "system" (this: ^ComponentIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ComponentIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^ComponentIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^ComponentIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ComponentIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ComponentIF, Attribute: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^ComponentIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^ComponentIF, InitialValue: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^ComponentIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^ComponentIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^ComponentIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^ComponentIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^ComponentIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^ComponentIF, AuthenticationLevel: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^ComponentIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^ComponentIF, Description: BStr) -> HResult,
    TypeGuidGet:            proc "system" (this: ^ComponentIF, TypeGuid: ^BStr) -> HResult,
    TypePathGet:            proc "system" (this: ^ComponentIF, TypePath: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ComponentIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ComponentIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ComponentIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ComponentIF, SafetyType: BStr) -> HResult,
    ISPValueGet:            proc "system" (this: ^ComponentIF, ISPValue: ^BStr) -> HResult,
    ISPValuePut:            proc "system" (this: ^ComponentIF, ISPValue: BStr) -> HResult,
}

component_new :: proc(name: string, type: string, attribute := "", initialvalue := "", description := "") -> (component: rawptr, ok: bool) {
    component = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_type := bstr.from_string(type)
    bstr_attribute := bstr.from_string(attribute)
    bstr_initialvalue := bstr.from_string(initialvalue)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_type)
        bstr.free(bstr_attribute)
        bstr.free(bstr_initialvalue)
        bstr.free(bstr_description)
    }
    hr := factory.factoryif->NewComponent1(bstr_name, bstr_type, bstr_attribute, bstr_initialvalue, bstr_description, cast(^rawptr)&component)
    if com.failed(hr) do return
    
    return component, true
}

component_name :: proc {
    component_name_get,
    component_name_set,
}

component_name_get :: proc(component: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->NameGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_name_set :: proc(component: rawptr, name: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

component_type_name :: proc {
    component_type_name_get,
    component_type_name_set,
}

component_type_name_get :: proc(component: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->TypeNameGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_type_name_set :: proc(component: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

component_attribute :: proc {
    component_attribute_get,
    component_attribute_set,
}

component_attribute_get :: proc(component: rawptr) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->AttributeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

component_attribute_set :: proc(component: rawptr, attribute: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->AttributePut(bs)
    if com.failed(hr) do return

    return true
}

component_initial_value :: proc {
    component_initial_value_get,
    component_initial_value_set,
}

component_initial_value_get :: proc(component: rawptr) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->InitialValueGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

component_initial_value_set :: proc(component: rawptr, inital_value: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(inital_value)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

component_read_permission :: proc {
    component_read_permission_get,
    component_read_permission_set,
}

component_read_permission_get :: proc(component: rawptr) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->ReadPermissionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

component_read_permission_set :: proc(component: rawptr, read_permission: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

component_write_permission :: proc {
    component_write_permission_get,
    component_write_permission_set,
}

component_write_permission_get :: proc(component: rawptr) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_write_permission_set :: proc(component: rawptr, write_permission: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->WritePermissionPut(bs)
    if com.failed(hr) do return

    return true
}

component_authentication_level :: proc {
    component_authentication_level_get,
    component_authentication_level_set,
}

component_authentication_level_get :: proc(component: rawptr) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_authentication_level_set :: proc(component: rawptr, authentication_level: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return

    return true
}

component_description :: proc {
    component_description_get,
    component_description_set,
}

component_description_get :: proc(component: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

component_description_set :: proc(component: rawptr, description: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->DescriptionPut(bs)
    if com.failed(hr) do return

    return true
}

component_type_guid_get :: proc(component: rawptr) -> (type_guid: string, ok: bool) {
    type_guid = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->TypeGuidGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_type_path_get :: proc(component: rawptr) -> (type_path: string, ok: bool) {
    type_path = ""
    ok = false
    
    if component == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->TypePathGet(&bs)
    if com.failed(hr) do return
    
    return "", true
}

component_access_level :: proc {
    component_access_level_get,
    component_access_level_set,
}

component_access_level_get :: proc(component: rawptr) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_access_level_set :: proc(component: rawptr, access_level: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

component_safety_type :: proc {
    component_safety_type_get,
    component_safety_type_set,
}

component_safety_type_get :: proc(component: rawptr) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_safety_type_set :: proc(component: rawptr, safety_type: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

component_isp_value :: proc {
    component_isp_value_get,
    component_isp_value_set,
}

component_isp_value_get :: proc(component: rawptr) -> (isp_value: string, ok: bool) {
    isp_value = ""
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->ISPValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

component_isp_value_set :: proc(component: rawptr, isp_value: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(isp_value)
    defer bstr.free(bs)
    hr := (^ComponentIF)(component)->ISPValuePut(bs)
    if com.failed(hr) do return

    return true
}

component_release :: proc(component: rawptr) {
    if component != nil {
        (^ComponentIF)(component)->Release()
    }
}
