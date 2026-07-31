package cbopenif

DataType :: distinct rawptr

DataTypeIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^DataTypeVTable,
}

DataTypeVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    NameGet:               proc "system" (this: ^DataTypeIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^DataTypeIF, Name: BStr) -> HResult,
    ProtectedGet:          proc "system" (this: ^DataTypeIF, Protected: ^VariantBool) -> HResult,
    ProtectedPut:          proc "system" (this: ^DataTypeIF, Protected: VariantBool) -> HResult,
    HiddenGet:             proc "system" (this: ^DataTypeIF, Hidden: ^VariantBool) -> HResult,
    HiddenPut:             proc "system" (this: ^DataTypeIF, Hidden: VariantBool) -> HResult,
    ScopeGet:              proc "system" (this: ^DataTypeIF, Scope: ^Scope) -> HResult,
    ScopePut:              proc "system" (this: ^DataTypeIF, Scope: Scope) -> HResult,
    DescriptionGet:        proc "system" (this: ^DataTypeIF, Description: ^BStr) -> HResult,
    DescriptionPut:        proc "system" (this: ^DataTypeIF, Description: BStr) -> HResult,
    GuidGet:               proc "system" (this: ^DataTypeIF, Guid: ^BStr) -> HResult,
    GuidPut:               proc "system" (this: ^DataTypeIF, Guid: BStr) -> HResult,
    ReservedByFunctionGet: proc "system" (this: ^DataTypeIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut: proc "system" (this: ^DataTypeIF, ReservedByFunction: BStr) -> HResult,
    ComponentsGet:         proc "system" (this: ^DataTypeIF, Components: ^Components) -> HResult,
    Missing22:             proc "system" (this: ^DataTypeIF) -> HResult,
    ComponentsPut:         proc "system" (this: ^DataTypeIF, Components: Components) -> HResult,
    Serialize:             proc "system" (this: ^DataTypeIF, XMLStr: ^BStr) -> HResult,
}

datatype_new :: proc(name: string, description := "", hidden := VariantBoolFalse, protected := VariantBoolFalse, scope := Scope.Public) -> (datatype: DataType, ok: bool) {
    datatype = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_description := string_to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewDataType1(bstr_name, bstr_description, protected, hidden, scope, cast(^DataType)&datatype)
    if failed(hr) do return

    return datatype, true
}

datatype_deserialize :: proc(datatype: ^DataType, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeDataType(&bstr, cast(^DataType)datatype)
    if failed(hr) do return
    
    return true
}

datatype_serialize :: proc(datatype: DataType) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

datatype_name :: proc {
    datatype_name_,
    datatype_name_set,
}

@(private)
datatype_name_ :: proc(datatype: DataType) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
datatype_name_set :: proc(datatype: DataType, name: string) -> (ok: bool) {
    ok = false
    
    if datatype == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->NamePut(bstr)
    if failed(hr) do return

    return true
}

datatype_protected :: proc {
    datatype_protected_,
    datatype_protected_set,
}

@(private)
datatype_protected_ :: proc(datatype: DataType) -> (protected: VariantBool, ok: bool) {
    protected = {}
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedGet(&protected)
    if failed(hr) do return

    return protected, true
}

@(private)
datatype_protected_set :: proc(datatype: DataType, protected: VariantBool) -> (ok: bool) {
    ok = false
    
    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedPut(protected)
    if failed(hr) do return

    return true
}

datatype_hidden :: proc {
    datatype_hidden_,
    datatype_hidden_set,
}

@(private)
datatype_hidden_ :: proc(datatype: DataType) -> (hidden: VariantBool, ok: bool) {
    hidden = {}
    ok = false
    
    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenGet(&hidden)
    if failed(hr) do return

    return hidden, true
}

@(private)
datatype_hidden_set :: proc(datatype: DataType, hidden: VariantBool) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenPut(hidden)
    if failed(hr) do return

    return true
}

datatype_scope :: proc {
    datatype_scope_,
    datatype_scope_set,
}

@(private)
datatype_scope_ :: proc(datatype: DataType) -> (scope: Scope, ok: bool) {
    scope = {}
    ok = false

    if datatype == nil do return
    if !connected() do return

    hr := (^DataTypeIF)(datatype)->ScopeGet(&scope)
    if failed(hr) do return

    return scope, true
}

@(private)
datatype_scope_set :: proc(datatype: DataType, scope: Scope) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->ScopePut(scope)
    if failed(hr) do return

    return true
}

datatype_description :: proc {
    datatype_description_,
    datatype_description_set,
}

@(private)
datatype_description_ :: proc(datatype: DataType) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->DescriptionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
datatype_description_set :: proc(datatype: DataType, description: string) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->DescriptionPut(bstr)
    if failed(hr) do return

    return true
}

datatype_guid :: proc {
    datatype_guid_,
    datatype_guid_set,
}

@(private)
datatype_guid_ :: proc(datatype: DataType) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->GuidGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
datatype_guid_set :: proc(datatype: DataType, guid: string) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(guid)
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->GuidPut(bstr)
    if failed(hr) do return

    return true
}

datatype_reserved_by_function :: proc {
    datatype_reserved_by_function_,
    datatype_reserved_by_function_set,
}

@(private)
datatype_reserved_by_function_ :: proc(datatype: DataType) -> (reserved_by_function: string, ok: bool) {
    reserved_by_function = ""
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
datatype_reserved_by_function_set :: proc(datatype: DataType, reserved_by_function: string) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(reserved_by_function)
    defer bstr_free(bstr)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionPut(bstr)
    if failed(hr) do return

    return true
}

datatype_components :: proc {
    datatype_components_,
    datatype_components_set,
}

@(private)
datatype_components_ :: proc(datatype: DataType) -> (components: Components, ok: bool) {
    components = nil
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsGet(&components)
    if failed(hr) do return

    return components, true
}

@(private)
datatype_components_set :: proc(datatype: DataType, components: Components) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsPut(components)
    if failed(hr) do return

    return true
}

datatype_release :: proc(datatype: DataType) {
    if datatype != nil {
        (^DataTypeIF)(datatype)->Release()
    }
}

datatype_component_count :: proc(datatype: DataType) -> (count: i32, ok: bool) {
    count = 0
    ok = false
    
    if !connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)

    count, ok = components_count(components)
    if !ok do return

    return count, true
}

datatype_component_remove :: proc {
    datatype_component_remove_by_name,
    datatype_component_remove_by_index,
}

@(private)
datatype_component_remove_by_name :: proc(datatype: DataType, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    ok = components_remove(components, name)
    if !ok do return
    
    return true
}

@(private)
datatype_component_remove_by_index :: proc(datatype: DataType, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    ok = components_remove(components, index)
    if !ok do return
    
    return true
}

datatype_component_add :: proc {
    datatype_component_add_,
    datatype_component_add_at_index,
}

@(private)
datatype_component_add_ :: proc(datatype: DataType, component: Component) -> (ok: bool) {
    ok = false

    if !connected() do return
    if datatype == nil do return
    if component == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)

    ok = components_add(components, component)
    if !ok do return

    return true
}

datatype_component_add_at_index :: proc(datatype: DataType, component: Component, index: i32) -> (ok: bool) {
    ok = false
    
    if !connected() do return
    if datatype == nil do return
    if component == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)

    ok = components_add_at_index(components, component, index)
    if !ok do return
    
    return true
}

datatype_component :: proc {
    datatype_component_by_name,
    datatype_component_by_index,
}

@(private)
datatype_component_by_name :: proc(datatype: DataType, name: string) -> (component: Component, ok: bool) {
    component = nil
    ok = false

    if !connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    component, ok = components_component_by_name(components, name)
    if !ok do return
    
    return component, true
}

@(private)
datatype_component_by_index :: proc(datatype: DataType, index: i32) -> (component: Component, ok: bool) {
    component = nil
    ok = false

    if !connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    component, ok = components_component_by_index(components, index)
    if !ok do return
    
    return component, true
}

datatype_component_index :: proc(datatype: DataType, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    bstr_name := string_to_bstr(name)
    defer bstr_free(bstr_name)
    index, ok = components_component_index(components, name)
    if !ok do return
    
    return index, true
}
