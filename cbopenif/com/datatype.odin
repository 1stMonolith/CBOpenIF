package com

import t "../types"

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

datatype_serialize :: proc(datatype: DataType) -> (xml: string, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

datatype_name_get :: proc(datatype: DataType) -> (name: string, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_name_set :: proc(datatype: DataType, name: string) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

datatype_protected_get :: proc(datatype: DataType) -> (protected: bool, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

datatype_protected_set :: proc(datatype: DataType, protected: bool) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

datatype_hidden_get :: proc(datatype: DataType) -> (hidden: bool, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

datatype_hidden_set :: proc(datatype: DataType, hidden: bool) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

datatype_scope_get :: proc(datatype: DataType) -> (scope: t.Scope, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return

    s: i32
    hr := (^DataTypeIF)(datatype)->ScopeGet(&s)
    if com_failed(hr) do return

    return t.Scope(s), true
}

datatype_scope_set :: proc(datatype: DataType, scope: t.Scope) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    hr := (^DataTypeIF)(datatype)->ScopePut(i32(scope))
    if com_failed(hr) do return

    return true
}

datatype_description_get :: proc(datatype: DataType) -> (description: string, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_description_set :: proc(datatype: DataType, description: string) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

datatype_guid_get :: proc(datatype: DataType) -> (guid: string, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_guid_set :: proc(datatype: DataType, guid: string) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

datatype_reserved_by_function_get :: proc(datatype: DataType) -> (reserved_by_function: string, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

datatype_reserved_by_function_set :: proc(datatype: DataType, reserved_by_function: string) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

datatype_components_get :: proc(datatype: DataType) -> (components: Components, ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^DataTypeIF)(datatype)->ComponentsGet(&p)
    if com_failed(hr) do return

    return Components(p), true
}

datatype_components_set :: proc(datatype: DataType, components: Components) -> (ok: bool) {
    if datatype == nil do return
    if !com_connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsPut(components)
    if com_failed(hr) do return

    return true
}

datatype_release :: proc(datatype: DataType) {
    if datatype != nil {
        (^DataTypeIF)(datatype)->Release()
    }
}

datatype_from_com :: proc(datatype: DataType, allocator := context.allocator) -> (result: t.DataType, ok: bool) {
    if datatype == nil do return

    context.allocator = allocator

    result.name, ok = name(datatype)
    if !ok do return
    result.description, ok = description(datatype)
    if !ok do return
    result.protected, ok = protected(datatype)
    if !ok do return
    result.hidden, ok = hidden(datatype)
    if !ok do return
    result.scope, ok = scope(datatype)
    if !ok do return
    result.guid, ok = guid(datatype)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(datatype)
    if !ok do return

    comps: Components
    comps, ok = components(datatype)
    if !ok do return
    defer release(comps)

    count: i32
    count, ok = component_count(comps)
    if !ok do return

    result.components = make([dynamic]t.Component, 0, int(count), allocator)

    for i in 0..<count {
        comp: Component
        comp, ok = component_by_index(comps, i)
        if !ok do return
        defer release(comp)

        comp_s: t.Component
        comp_s, ok = component_from_com(comp)
        if !ok do return

        append(&result.components, comp_s)
    }

    return result, true
}

datatype_to_com :: proc(src: t.DataType) -> (result: DataType, ok: bool) {
    datatype: DataType
    datatype, ok = datatype_new1(
        src.name,
        src.description,
        src.protected,
        src.hidden,
        src.scope,
    )
    if !ok do return
    defer if !ok do release(datatype)

    ok = guid(datatype, src.guid)
    if !ok do return
    ok = reserved_by_function(datatype, src.reserved_by_function)
    if !ok do return

    comps: Components
    comps, ok = components(datatype)
    if !ok do return
    defer release(comps)

    for c in src.components {
        comp: Component
        comp, ok = component_to_com(c)
        if !ok do return
        defer release(comp)

        ok = component_add(comps, comp)
        if !ok do return
    }

    return datatype, true
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

component_name_get :: proc(component: Component) -> (name: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->NameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_name_set :: proc(component: Component, name: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_type_name_get :: proc(component: Component) -> (type_name: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypeNameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_type_name_set :: proc(component: Component, type_name: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_attribute_get :: proc(component: Component) -> (attribute: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_attribute_set :: proc(component: Component, attribute: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AttributePut(bs)
    if com_failed(hr) do return

    return true
}

component_initial_value_get :: proc(component: Component) -> (inital_value: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_initial_value_set :: proc(component: Component, inital_value: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_read_permission_get :: proc(component: Component) -> (read_permission: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ReadPermissionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_read_permission_set :: proc(component: Component, read_permission: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

component_write_permission_get :: proc(component: Component) -> (write_permission: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_write_permission_set :: proc(component: Component, write_permission: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->WritePermissionPut(bs)
    if com_failed(hr) do return

    return true
}

component_authentication_level_get :: proc(component: Component) -> (authentication_level: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_authentication_level_set :: proc(component: Component, authentication_level: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return

    return true
}

component_description_get :: proc(component: Component) -> (description: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

component_description_set :: proc(component: Component, description: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

component_type_guid_get :: proc(component: Component) -> (type_guid: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypeGuidGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_type_path_get :: proc(component: Component) -> (type_path: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->TypePathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_access_level_get :: proc(component: Component) -> (access_level: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_access_level_set :: proc(component: Component, access_level: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

component_safety_type_get :: proc(component: Component) -> (safety_type: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_safety_type_set :: proc(component: Component, safety_type: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

component_isp_value_get :: proc(component: Component) -> (isp_value: string, ok: bool) {
    if component == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ComponentIF)(component)->ISPValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

component_isp_value_set :: proc(component: Component, isp_value: string) -> (ok: bool) {
    if component == nil do return
    if !com_connected() do return

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

component_from_com :: proc(component: Component) -> (result: t.Component, ok: bool) {
    if component == nil do return

    result.name, ok = name(component)
    if !ok do return
    result.type_name, ok = type_name(component)
    if !ok do return
    result.attribute, ok = attribute(component)
    if !ok do return
    result.initial_value, ok = initial_value(component)
    if !ok do return
    result.description, ok = description(component)
    if !ok do return
    result.read_permission, ok = read_permission(component)
    if !ok do return
    result.write_permission, ok = write_permission(component)
    if !ok do return
    result.authentication_level, ok = authentication_level(component)
    if !ok do return
    result.access_level, ok = access_level(component)
    if !ok do return
    result.safety_type, ok = safety_type(component)
    if !ok do return
    result.isp_value, ok = isp_value(component)
    if !ok do return
    result.type_guid, ok = type_guid(component)
    if !ok do return
    result.type_path, ok = type_path(component)
    if !ok do return

    return result, true
}

component_to_com :: proc(src: t.Component) -> (result: Component, ok: bool) {
    component: Component
    component, ok = component_new1(
        src.name,
        src.type_name,
        src.attribute,
        src.initial_value,
        src.description,
    )
    if !ok do return
    defer if !ok do release(component)

    ok = read_permission(component, src.read_permission)
    if !ok do return
    ok = write_permission(component, src.write_permission)
    if !ok do return
    ok = authentication_level(component, src.authentication_level)
    if !ok do return
    ok = access_level(component, src.access_level)
    if !ok do return
    ok = safety_type(component, src.safety_type)
    if !ok do return
    ok = isp_value(component, src.isp_value)
    if !ok do return

    return component, true
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

components_component_add :: proc(components: Components, component: Component) -> (ok: bool) {
    if components == nil do return
    if component == nil do return
    if !com_connected() do return

    hr := (^ComponentsIF)(components)->Add(component)
    if com_failed(hr) do return

    return true
}

components_component_add_at_index :: proc(components: Components, component: Component, index: i32) -> (ok: bool) {
    if components == nil do return
    if component == nil do return
    if !com_connected() do return
    
    hr := (^ComponentsIF)(components)->AddBefore(component, index)
    if com_failed(hr) do return

    return true
}

components_component_by_name :: proc(components: Components, name: string) -> (component: Component, ok: bool) {
    if components == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    p: rawptr
    hr := (^ComponentsIF)(components)->Find(bstr_name, &p)
    defer bstr_free(bstr_name)
    if com_failed(hr) do return
    
    return Component(p), true
}

components_component_by_index :: proc(components: Components, index: i32) -> (component: Component, ok: bool) {
    if components == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ComponentsIF)(components)->Item(index + 1, &p)
    if com_failed(hr) do return
    
    return Component(p), true
}

components_component_index :: proc(components: Components, name: string) -> (index: i32, ok: bool) {
    if components == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ComponentsIF)(components)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

components_component_count :: proc(components: Components) -> (count: i32, ok: bool) {
    if components == nil do return
    if !com_connected() do return
    
    hr := (^ComponentsIF)(components)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

components_component_remove_by_name :: proc(components: Components, name: string) -> (ok: bool) {
    if components == nil do return
    if !com_connected() do return

    index: i32
    index, ok = components_component_index(components, name)
    if !ok do return

    hr := (^ComponentsIF)(components)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

components_component_remove_by_index :: proc(components: Components, index: i32) -> (ok: bool) {
    if components == nil do return
    if !com_connected() do return
    
    hr := (^ComponentsIF)(components)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

components_release :: proc(components: Components) {
    if components != nil {
        (^ComponentsIF)(components)->Release()
    }
}

components_from_com :: proc(comps: Components, allocator := context.allocator) -> (result: [dynamic]t.Component, ok: bool) {
    if comps == nil do return
    context.allocator = allocator

    count: i32
    count, ok = component_count(comps)
    if !ok do return

    result = make([dynamic]t.Component, 0, int(count), allocator)
    for i in 0..<count {
        c: Component
        c, ok = component_by_index(comps, i)
        if !ok do return
        defer release(c)

        cs: t.Component
        cs, ok = component_from_com(c)
        if !ok do return
        append(&result, cs)
    }
    return result, true
}

components_to_com :: proc(comps: Components, src: []t.Component) -> (ok: bool) {
    if comps == nil do return
    for item in src {
        c: Component
        c, ok = component_to_com(item)
        if !ok do return
        defer release(c)
        ok = component_add(comps, c)
        if !ok do return
    }
    return true
}
