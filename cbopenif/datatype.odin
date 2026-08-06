package cbopenif

DataType :: distinct rawptr

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

datatype_components_add :: proc {
    datatype_components_add_,
    datatype_components_add_at_index,
}

datatype_components_add_ :: proc(datatype: DataType, component: Component) -> (ok: bool) {
    if datatype == nil do return
    if component == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_add_(comps, component)
    if !ok do return

    return true
}

datatype_components_add_at_index :: proc(datatype: DataType, component: Component, index: i32) -> (ok: bool) {
    if datatype == nil do return
    if component == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_add_at_index(comps, component, index)
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

    component, ok = components_component_by_index(comps, index)
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

    return index, true
}

datatype_components_count :: proc(datatype: DataType) -> (count: i32, ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    count, ok = components_count(comps)
    if !ok do return

    return count, true
}

datatype_componentsremove :: proc {
    datatype_components_remove_by_name,
    datatype_components_remove_by_index,
}

datatype_components_remove_by_name :: proc(datatype: DataType, name: string) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_remove_by_name(comps, name)
    if !ok do return

    return true
}

datatype_components_remove_by_index :: proc(datatype: DataType, index: i32) -> (ok: bool) {
    if datatype == nil do return
    if !controlbuilder_connected() do return

    comps: Components
    comps, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(comps)

    ok = components_remove_by_index(comps, index)
    if !ok do return

    return true
}
