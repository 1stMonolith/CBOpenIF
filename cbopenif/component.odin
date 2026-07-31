package cbopenif

Component  :: distinct rawptr

ComponentIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^ComponentVTable,
}

ComponentVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
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

component_new :: proc(name: string, type: string, attribute := "", initialvalue := "", description := "") -> (component: Component, ok: bool) {
    component = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_type := string_to_bstr(type)
    bstr_attribute := string_to_bstr(attribute)
    bstr_initialvalue := string_to_bstr(initialvalue)
    bstr_description := string_to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initialvalue)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewComponent1(bstr_name, bstr_type, bstr_attribute, bstr_initialvalue, bstr_description, cast(^Component)&component)
    if failed(hr) do return
    
    return component, true
}

component_name :: proc {
    component_name_,
    component_name_set,
}

@(private)
component_name_ :: proc(component: Component) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->NameGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_name_set :: proc(component: Component, name: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

component_type_name :: proc {
    component_type_name_,
    component_type_name_set,
}

@(private)
component_type_name_ :: proc(component: Component) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->TypeNameGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_type_name_set :: proc(component: Component, type_name: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(type_name)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->TypeNamePut(bstr)
    if failed(hr) do return
    
    return true
}

component_attribute :: proc {
    component_attribute_,
    component_attribute_set,
}

@(private)
component_attribute_ :: proc(component: Component) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->AttributeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
component_attribute_set :: proc(component: Component, attribute: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return

    bstr := string_to_bstr(attribute)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->AttributePut(bstr)
    if failed(hr) do return

    return true
}

component_initial_value :: proc {
    component_initial_value_,
    component_initial_value_set,
}

@(private)
component_initial_value_ :: proc(component: Component) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->InitialValueGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
component_initial_value_set :: proc(component: Component, inital_value: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(inital_value)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->InitialValuePut(bstr)
    if failed(hr) do return
    
    return true
}

component_read_permission :: proc {
    component_read_permission_,
    component_read_permission_set,
}

@(private)
component_read_permission_ :: proc(component: Component) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->ReadPermissionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
component_read_permission_set :: proc(component: Component, read_permission: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return

    bstr := string_to_bstr(read_permission)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->ReadPermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

component_write_permission :: proc {
    component_write_permission_,
    component_write_permission_set,
}

@(private)
component_write_permission_ :: proc(component: Component) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->WritePermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_write_permission_set :: proc(component: Component, write_permission: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(write_permission)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->WritePermissionPut(bstr)
    if failed(hr) do return

    return true
}

component_authentication_level :: proc {
    component_authentication_level_,
    component_authentication_level_set,
}

@(private)
component_authentication_level_ :: proc(component: Component) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_authentication_level_set :: proc(component: Component, authentication_level: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return

    bstr := string_to_bstr(authentication_level)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->AuthenticationLevelPut(bstr)
    if failed(hr) do return

    return true
}

component_description :: proc {
    component_description_,
    component_description_set,
}

@(private)
component_description_ :: proc(component: Component) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->DescriptionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
component_description_set :: proc(component: Component, description: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->DescriptionPut(bstr)
    if failed(hr) do return

    return true
}

component_type_guid :: proc(component: Component) -> (type_guid: string, ok: bool) {
    type_guid = ""
    ok = false

    if component == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->TypeGuidGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

component_type_path :: proc(component: Component) -> (type_path: string, ok: bool) {
    type_path = ""
    ok = false
    
    if component == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->TypePathGet(&bstr)
    if failed(hr) do return
    
    return "", true
}

component_access_level :: proc {
    component_access_level_,
    component_access_level_set,
}

@(private)
component_access_level_ :: proc(component: Component) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if component == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->AccessLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_access_level_set :: proc(component: Component, access_level: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return

    bstr := string_to_bstr(access_level)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->AccessLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

component_safety_type :: proc {
    component_safety_type_,
    component_safety_type_set,
}

@(private)
component_safety_type_ :: proc(component: Component) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if component == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_safety_type_set :: proc(component: Component, safety_type: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return

    bstr := string_to_bstr(safety_type)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

component_isp_value :: proc {
    component_isp_value_,
    component_isp_value_set,
}

@(private)
component_isp_value_ :: proc(component: Component) -> (isp_value: string, ok: bool) {
    isp_value = ""
    ok = false

    if component == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->ISPValueGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
component_isp_value_set :: proc(component: Component, isp_value: string) -> (ok: bool) {
    ok = false

    if component == nil do return
    if !connected() do return

    bstr := string_to_bstr(isp_value)
    defer bstr_free(bstr)
    hr := (^ComponentIF)(component)->ISPValuePut(bstr)
    if failed(hr) do return

    return true
}

component_release :: proc(component: Component) {
    if component != nil {
        (^ComponentIF)(component)->Release()
    }
}