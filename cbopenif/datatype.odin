package cbopenif

DataType   :: distinct rawptr
Component  :: distinct rawptr
Components :: distinct rawptr

DataTypeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DataTypeVTable,
}

DataTypeVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^DataTypeIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^DataTypeIF, Name: BStr) -> HResult,
    ProtectedGet:          proc "system" (this: ^DataTypeIF, Protected: ^VariantBool) -> HResult,
    ProtectedPut:          proc "system" (this: ^DataTypeIF, Protected: VariantBool) -> HResult,
    HiddenGet:             proc "system" (this: ^DataTypeIF, Hidden: ^VariantBool) -> HResult,
    HiddenPut:             proc "system" (this: ^DataTypeIF, Hidden: VariantBool) -> HResult,
    ScopeGet:              proc "system" (this: ^DataTypeIF, Scope: ^i32) -> HResult,
    ScopePut:              proc "system" (this: ^DataTypeIF, Scope: i32) -> HResult,
    DescriptionGet:        proc "system" (this: ^DataTypeIF, Description: ^BStr) -> HResult,
    DescriptionPut:        proc "system" (this: ^DataTypeIF, Description: BStr) -> HResult,
    GuidGet:               proc "system" (this: ^DataTypeIF, Guid: ^BStr) -> HResult,
    GuidPut:               proc "system" (this: ^DataTypeIF, Guid: BStr) -> HResult,
    ReservedByFunctionGet: proc "system" (this: ^DataTypeIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut: proc "system" (this: ^DataTypeIF, ReservedByFunction: BStr) -> HResult,
    ComponentsGet:         proc "system" (this: ^DataTypeIF, Components: ^rawptr) -> HResult,
    Missing22:             proc "system" (this: ^DataTypeIF) -> HResult,
    ComponentsPut:         proc "system" (this: ^DataTypeIF, Components: rawptr) -> HResult,
    Serialize:             proc "system" (this: ^DataTypeIF, XMLStr: ^BStr) -> HResult,
}

datatype_new :: proc(name: string, description := "", hidden := false, protected := false, scope := ScopeType.Public) -> (datatype: DataType, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewDataType1(bstr_name, bstr_description, to_variantbool(protected), to_variantbool(hidden), i32(scope), cast(^rawptr)&datatype)
    if com_failed(hr) do return

    return datatype, true
}

datatype_deserialize :: proc(xml: string) -> (datatype: DataType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeDataType(&bs, cast(^rawptr)datatype)
    if com_failed(hr) do return
    
    return datatype, true
}

datatype_serialize :: proc(datatype: DataType) -> (xml: string, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

datatype_name :: proc {
    datatype_name_get,
    datatype_name_set,
}

datatype_name_get :: proc(datatype: DataType) -> (name: string, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_name_set :: proc(datatype: DataType, name: string) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

datatype_protected :: proc {
    datatype_protected_get,
    datatype_protected_set,
}

datatype_protected_get :: proc(datatype: DataType) -> (protected: bool, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

datatype_protected_set :: proc(datatype: DataType, protected: bool) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

datatype_hidden :: proc {
    datatype_hidden_get,
    datatype_hidden_set,
}

datatype_hidden_get :: proc(datatype: DataType) -> (hidden: bool, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

datatype_hidden_set :: proc(datatype: DataType, hidden: bool) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

datatype_scope :: proc {
    datatype_scope_get,
    datatype_scope_set,
}

datatype_scope_get :: proc(datatype: DataType) -> (scope: ScopeType, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    s: i32
    hr := (^DataTypeIF)(datatype)->ScopeGet(&s)
    if com_failed(hr) do return

    return ScopeType(s), true
}

datatype_scope_set :: proc(datatype: DataType, scope: ScopeType) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^DataTypeIF)(datatype)->ScopePut(i32(scope))
    if com_failed(hr) do return

    return true
}

datatype_description :: proc {
    datatype_description_get,
    datatype_description_set,
}

datatype_description_get :: proc(datatype: DataType) -> (description: string, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_description_set :: proc(datatype: DataType, description: string) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

datatype_guid :: proc {
    datatype_guid_get,
    datatype_guid_set,
}

datatype_guid_get :: proc(datatype: DataType) -> (guid: string, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_guid_set :: proc(datatype: DataType, guid: string) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

datatype_reserved_by_function :: proc {
    datatype_reserved_by_function_get,
    datatype_reserved_by_function_set,
}

datatype_reserved_by_function_get :: proc(datatype: DataType) -> (reserved_by_function: string, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_reserved_by_function_set :: proc(datatype: DataType, reserved_by_function: string) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

datatype_components :: proc {
    datatype_components_get,
    datatype_components_set,
}

datatype_components_get :: proc(datatype: DataType) -> (components: Components, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^DataTypeIF)(datatype)->ComponentsGet(&p)
    if com_failed(hr) do return

    return Components(p), true
}

datatype_components_set :: proc(datatype: DataType, components: Components) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsPut(components)
    if com_failed(hr) do return

    return true
}

datatype_release :: proc(datatype: DataType) {
    if datatype != nil {
        (^DataTypeIF)(datatype)->Release()
    }
}

// Components Procedures

datatype_component_add :: proc {
    datatype_component_add_,
    datatype_component_add_at_index,
}

datatype_component_add_ :: proc(datatype: DataType, component: Component) -> (ok: bool) {
    if datatype == nil do return
    if component == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_component_add_(comps, component)
    if !ok do return

    return true
}

datatype_component_add_at_index :: proc(datatype: DataType, component: Component, index: i32) -> (ok: bool) {
    if datatype == nil do return
    if component == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_component_add_at_index(comps, component, index)
    if !ok do return

    return true
}

datatype_component :: proc {
    datatype_component_by_name,
    datatype_component_by_index,
}

datatype_component_by_name :: proc(datatype: DataType, name: string) -> (component: Component, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    component, ok = components_component_by_name(comps, name)
    if !ok do return

    return component, true
}

datatype_component_by_index :: proc(datatype: DataType, index: i32) -> (component: Component, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    component, ok = components_component_by_index(comps, index + 1)
    if !ok do return

    return component, true
}

datatype_component_index :: proc(datatype: DataType, name: string) -> (index: i32, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    index, ok = components_component_index(comps, name)
    if !ok do return

    return index - 1, true
}

datatype_component_count :: proc(datatype: DataType) -> (count: i32, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    count, ok = components_component_count(comps)
    if !ok do return

    return count, true
}

datatype_component_remove :: proc {
    datatype_component_remove_by_name,
    datatype_component_remove_by_index,
}

datatype_component_remove_by_name :: proc(datatype: DataType, name: string) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_component_remove_by_name(comps, name)
    if !ok do return

    return true
}

datatype_component_remove_by_index :: proc(datatype: DataType, index: i32) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_component_remove_by_index(comps, index)
    if !ok do return

    return true
}

ComponentIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
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

component_new :: proc(name: string, type: string, attribute := "", initial_value := "", description := "") -> (component: Component, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type := to_bstr(type)
    bstr_attribute := to_bstr(attribute)
    bstr_initial_value := to_bstr(initial_value)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewComponent1(bstr_name, bstr_type, bstr_attribute, bstr_initial_value, bstr_description, cast(^rawptr)&component)
    if com_failed(hr) do return
    
    return component, true
}

component_name :: proc {
    component_name_get,
    component_name_set,
}

component_name_get :: proc(component: Component) -> (name: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->NameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_name_set :: proc(component: Component, name: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_type_name :: proc {
    component_type_name_get,
    component_type_name_set,
}

component_type_name_get :: proc(component: Component) -> (type_name: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypeNameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_type_name_set :: proc(component: Component, type_name: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_attribute :: proc {
    component_attribute_get,
    component_attribute_set,
}

component_attribute_get :: proc(component: Component) -> (attribute: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_attribute_set :: proc(component: Component, attribute: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AttributePut(bs)
    if com_failed(hr) do return

    return true
}

component_initial_value :: proc {
    component_initial_value_get,
    component_initial_value_set,
}

component_initial_value_get :: proc(component: Component) -> (inital_value: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_initial_value_set :: proc(component: Component, inital_value: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_read_permission :: proc {
    component_read_permission_get,
    component_read_permission_set,
}

component_read_permission_get :: proc(component: Component) -> (read_permission: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ReadPermissionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_read_permission_set :: proc(component: Component, read_permission: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

component_write_permission :: proc {
    component_write_permission_get,
    component_write_permission_set,
}

component_write_permission_get :: proc(component: Component) -> (write_permission: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_write_permission_set :: proc(component: Component, write_permission: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->WritePermissionPut(bs)
    if com_failed(hr) do return

    return true
}

component_authentication_level :: proc {
    component_authentication_level_get,
    component_authentication_level_set,
}

component_authentication_level_get :: proc(component: Component) -> (authentication_level: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_authentication_level_set :: proc(component: Component, authentication_level: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return

    return true
}

component_description :: proc {
    component_description_get,
    component_description_set,
}

component_description_get :: proc(component: Component) -> (description: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_description_set :: proc(component: Component, description: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

component_type_guid_get :: proc(component: Component) -> (type_guid: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypeGuidGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_type_path_get :: proc(component: Component) -> (type_path: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypePathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_access_level :: proc {
    component_access_level_get,
    component_access_level_set,
}

component_access_level_get :: proc(component: Component) -> (access_level: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_access_level_set :: proc(component: Component, access_level: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

component_safety_type :: proc {
    component_safety_type_get,
    component_safety_type_set,
}

component_safety_type_get :: proc(component: Component) -> (safety_type: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_safety_type_set :: proc(component: Component, safety_type: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_isp_value :: proc {
    component_isp_value_get,
    component_isp_value_set,
}

component_isp_value_get :: proc(component: Component) -> (isp_value: string, ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ISPValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_isp_value_set :: proc(component: Component, isp_value: string) -> (ok: bool) {
    if component == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(isp_value)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ISPValuePut(bs)
    if com_failed(hr) do return

    return true
}

component_release :: proc(component: Component) {
    if component != nil {
        (^ComponentIF)(component)->Release()
    }
}

ComponentsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ComponentsVTable,
}

ComponentsVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:       proc "system" (this: ^ComponentsIF, Component: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ComponentsIF, Component: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ComponentsIF, Name, TypeName: BStr, Component: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ComponentsIF, Name, TypeName, Attribute, InitialValue, Description: BStr, Component: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ComponentsIF, Name: BStr, Component: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ComponentsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ComponentsIF, Index: i32, Component: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ComponentsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ComponentsIF, Index: i32) -> HResult,
}

components_component_add :: proc {
    components_component_add_,
    components_component_add_at_index,
}

components_component_add_ :: proc(components: Components, component: Component) -> (ok: bool) {
    if components == nil do return
    if component == nil do return
    if !controlbuilder_connected() do return

    hr := (^ComponentsIF)(components)->Add(component)
    if com_failed(hr) do return

    return true
}

components_component_add_at_index :: proc(components: Components, component: Component, index: i32) -> (ok: bool) {
    if components == nil do return
    if component == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ComponentsIF)(components)->AddBefore(component, index)
    if com_failed(hr) do return

    return true
}

components_component :: proc {
    components_component_by_name,
    components_component_by_index,
}

components_component_by_name :: proc(components: Components, name: string) -> (component: Component, ok: bool) {
    if components == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    p: rawptr
    hr := (^ComponentsIF)(components)->Find(bstr_name, &p)
    defer bstr_free(bstr_name)
    if com_failed(hr) do return
    
    return Component(p), true
}

components_component_by_index :: proc(components: Components, index: i32) -> (component: Component, ok: bool) {
    if components == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ComponentsIF)(components)->Item(index + 1, &p)
    if com_failed(hr) do return
    
    return Component(p), true
}

components_component_index :: proc(components: Components, name: string) -> (index: i32, ok: bool) {
    if components == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ComponentsIF)(components)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

components_component_count :: proc(components: Components) -> (count: i32, ok: bool) {
    if components == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ComponentsIF)(components)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

components_component_remove :: proc {
    components_component_remove_by_name,
    components_component_remove_by_index,
}

components_component_remove_by_name :: proc(components: Components, name: string) -> (ok: bool) {
    if components == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = components_component_index(components, name)
    if !ok do return

    hr := (^ComponentsIF)(components)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

components_component_remove_by_index :: proc(components: Components, index: i32) -> (ok: bool) {
    if components == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ComponentsIF)(components)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

components_release :: proc(components: Components) {
    if components != nil {
        (^ComponentsIF)(components)->Release()
    }
}
