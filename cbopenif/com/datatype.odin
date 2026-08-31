package com

DataType   :: distinct rawptr
Components :: distinct rawptr
Component  :: distinct rawptr

DataTypeIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DataTypeVTable,
}

DataTypeVTable :: struct
{
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

SerializeDataType :: proc(datatype: DataType) -> (xml: string, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetDataTypeName :: proc(datatype: DataType) -> (name: string, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDataTypeName :: proc(datatype: DataType, name: string) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDataTypeProtected :: proc(datatype: DataType) -> (protected: bool, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->ProtectedGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDataTypeProtected :: proc(datatype: DataType, protected: bool) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedPut(ToVariantBool(protected))
    if ComFailed(hr) do return

    return true
}

GetDataTypeHidden :: proc(datatype: DataType) -> (hidden: bool, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->HiddenGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDataTypeHidden :: proc(datatype: DataType, hidden: bool) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenPut(ToVariantBool(hidden))
    if ComFailed(hr) do return

    return true
}

GetDataTypeScope :: proc(datatype: DataType) -> (scope: i32, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return

    s: i32
    hr := (^DataTypeIF)(datatype)->ScopeGet(&s)
    if ComFailed(hr) do return

    return s, true
}

SetDataTypeScope :: proc(datatype: DataType, scope: i32) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    hr := (^DataTypeIF)(datatype)->ScopePut(scope)
    if ComFailed(hr) do return

    return true
}

GetDataTypeDescription :: proc(datatype: DataType) -> (description: string, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDataTypeDescription :: proc(datatype: DataType, description: string) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDataTypeGuid :: proc(datatype: DataType) -> (guid: string, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDataTypeGuid :: proc(datatype: DataType, guid: string) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDataTypeReservedBy :: proc(datatype: DataType) -> (reserved_by_function: string, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDataTypeReservedBy :: proc(datatype: DataType, reserved_by_function: string) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDataTypeComponents :: proc(datatype: DataType) -> (components: Components, ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^DataTypeIF)(datatype)->ComponentsGet(&p)
    if ComFailed(hr) do return

    return Components(p), true
}

SetDataTypeComponents :: proc(datatype: DataType, components: Components) -> (ok: bool)
{
    if datatype == nil do return
    if !ComConnected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsPut(components)
    if ComFailed(hr) do return

    return true
}

ReleaseDataType :: proc(datatype: DataType) {
    if datatype != nil {
        (^DataTypeIF)(datatype)->Release()
    }
}

ComponentsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ComponentsVTable,
}

ComponentsVTable :: struct
{
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

AddComponent :: proc {
    _AddComponent,
    _AddComponentAtIndex,
}

_AddComponent :: proc(components: Components, component: Component) -> (ok: bool)
{
    if components == nil do return
    if component == nil do return
    if !ComConnected() do return

    hr := (^ComponentsIF)(components)->Add(component)
    if ComFailed(hr) do return

    return true
}

_AddComponentAtIndex :: proc(components: Components, component: Component, index: i32) -> (ok: bool)
{
    if components == nil do return
    if component == nil do return
    if !ComConnected() do return
    
    hr := (^ComponentsIF)(components)->AddBefore(component, index)
    if ComFailed(hr) do return

    return true
}

GetComponentWithName :: proc(components: Components, name: string) -> (component: Component, ok: bool)
{
    if components == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    p: rawptr
    hr := (^ComponentsIF)(components)->Find(bstr_name, &p)
    defer FreeBstr(bstr_name)
    if ComFailed(hr) do return
    
    return Component(p), true
}

GetComponentAtIndex :: proc(components: Components, index: i32) -> (component: Component, ok: bool)
{
    if components == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ComponentsIF)(components)->Item(index + 1, &p)
    if ComFailed(hr) do return
    
    return Component(p), true
}

ComponentIndex :: proc(components: Components, name: string) -> (index: i32, ok: bool)
{
    if components == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ComponentsIF)(components)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

ComponentCount :: proc(components: Components) -> (count: i32, ok: bool)
{
    if components == nil do return
    if !ComConnected() do return
    
    hr := (^ComponentsIF)(components)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveComponent :: proc {
    _RemoveComponentWithName,
    _RemoveComponentAtIndex,
}

_RemoveComponentWithName :: proc(components: Components, name: string) -> (ok: bool)
{
    if components == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ComponentIndex(components, name)
    if !ok do return

    hr := (^ComponentsIF)(components)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveComponentAtIndex :: proc(components: Components, index: i32) -> (ok: bool)
{
    if components == nil do return
    if !ComConnected() do return
    
    hr := (^ComponentsIF)(components)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseComponents :: proc(components: Components) {
    if components != nil {
        (^ComponentsIF)(components)->Release()
    }
}

ComponentIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ComponentVTable,
}

ComponentVTable :: struct
{
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

GetComponentName :: proc(component: Component) -> (name: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->NameGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentName :: proc(component: Component, name: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetComponentTypeName :: proc(component: Component) -> (type_name: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->TypeNameGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentTypeName :: proc(component: Component, type_name: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetComponentAttribute :: proc(component: Component) -> (attribute: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->AttributeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetComponentAttribute :: proc(component: Component, attribute: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->AttributePut(bs)
    if ComFailed(hr) do return

    return true
}

GetComponentInitialValue :: proc(component: Component) -> (inital_value: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->InitialValueGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetComponentInitialValue :: proc(component: Component, inital_value: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(inital_value)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->InitialValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetComponentReadPermission :: proc(component: Component) -> (read_permission: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetComponentReadPermission :: proc(component: Component, read_permission: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetComponentWritePermission :: proc(component: Component) -> (write_permission: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->WritePermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentWritePermission :: proc(component: Component, write_permission: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(write_permission)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->WritePermissionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetComponentAuthenticationLevel :: proc(component: Component) -> (authentication_level: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentAuthenticationLevel :: proc(component: Component, authentication_level: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs := ToBstr(authentication_level)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->AuthenticationLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetComponentDescription :: proc(component: Component) -> (description: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetComponentDescription :: proc(component: Component, description: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetComponentTypeGuid :: proc(component: Component) -> (type_guid: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->TypeGuidGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetComponentTypePath :: proc(component: Component) -> (type_path: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->TypePathGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetComponentAccessLevel :: proc(component: Component) -> (access_level: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentAccessLevel :: proc(component: Component, access_level: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetComponentSafetyType :: proc(component: Component) -> (safety_type: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentSafetyType :: proc(component: Component, safety_type: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetComponentISPValue :: proc(component: Component) -> (isp_value: string, ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->ISPValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetComponentISPValue :: proc(component: Component, isp_value: string) -> (ok: bool)
{
    if component == nil do return
    if !ComConnected() do return

    bs := ToBstr(isp_value)
    defer FreeBstr(bs)
    hr := (^ComponentIF)(component)->ISPValuePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseComponent :: proc(component: Component) {
    if component != nil {
        (^ComponentIF)(component)->Release()
    }
}
