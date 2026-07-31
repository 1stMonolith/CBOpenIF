package type

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"


DataTypeIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^DataTypeVTable,
}

DataTypeVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:               proc "system" (this: ^DataTypeIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^DataTypeIF, Name: BStr) -> HResult,
    ProtectedGet:          proc "system" (this: ^DataTypeIF, Protected: ^VariantBool) -> HResult,
    ProtectedPut:          proc "system" (this: ^DataTypeIF, Protected: VariantBool) -> HResult,
    HiddenGet:             proc "system" (this: ^DataTypeIF, Hidden: ^VariantBool) -> HResult,
    HiddenPut:             proc "system" (this: ^DataTypeIF, Hidden: VariantBool) -> HResult,
    ScopeGet:              proc "system" (this: ^DataTypeIF, Scope: ^ScopeType) -> HResult,
    ScopePut:              proc "system" (this: ^DataTypeIF, Scope: ScopeType) -> HResult,
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

datatype_new :: proc(name: string, description := "", hidden := false, protected := false, scope := Scope.Public) -> (datatype: rawptr, ok: bool) {
    datatype = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_description)
    }
    hr := factoryif->NewDataType1(bstr_name, bstr_description, variant.bool_to_variantbool(protected), variant.bool_to_variantbool(hidden), scope, cast(^rawptr)&datatype)
    if com.failed(hr) do return

    return datatype, true
}

datatype_deserialize :: proc(datatype: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factoryif->DeserializeDataType(&bs, cast(^rawptr)datatype)
    if com.failed(hr) do return
    
    return true
}

datatype_serialize :: proc(datatype: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

datatype_name :: proc {
    datatype_name_,
    datatype_name_set,
}

@(private)
datatype_name_ :: proc(datatype: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
datatype_name_set :: proc(datatype: rawptr, name: string) -> (ok: bool) {
    ok = false
    
    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

datatype_protected :: proc {
    datatype_protected_,
    datatype_protected_set,
}

@(private)
datatype_protected_ :: proc(datatype: rawptr) -> (protected: bool, ok: bool) {
    protected = {}
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->ProtectedGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

@(private)
datatype_protected_set :: proc(datatype: rawptr, protected: bool) -> (ok: bool) {
    ok = false
    
    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedPut(variant.bool_to_variantbool(protected))
    if com.failed(hr) do return

    return true
}

datatype_hidden :: proc {
    datatype_hidden_,
    datatype_hidden_set,
}

@(private)
datatype_hidden_ :: proc(datatype: rawptr) -> (hidden: bool, ok: bool) {
    hidden = {}
    ok = false
    
    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->HiddenGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

@(private)
datatype_hidden_set :: proc(datatype: rawptr, hidden: bool) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenPut(variant.bool_to_variantbool(hidden))
    if com.failed(hr) do return

    return true
}

datatype_scope :: proc {
    datatype_scope_,
    datatype_scope_set,
}

@(private)
datatype_scope_ :: proc(datatype: rawptr) -> (scope: Scope, ok: bool) {
    scope = {}
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return

    hr := (^DataTypeIF)(datatype)->ScopeGet(&scope)
    if com.failed(hr) do return

    return scope, true
}

@(private)
datatype_scope_set :: proc(datatype: rawptr, scope: Scope) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ScopePut(scope)
    if com.failed(hr) do return

    return true
}

datatype_description :: proc {
    datatype_description_,
    datatype_description_set,
}

@(private)
datatype_description_ :: proc(datatype: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
datatype_description_set :: proc(datatype: rawptr, description: string) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->DescriptionPut(bs)
    if com.failed(hr) do return

    return true
}

datatype_guid :: proc {
    datatype_guid_,
    datatype_guid_set,
}

@(private)
datatype_guid_ :: proc(datatype: rawptr) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->GuidGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
datatype_guid_set :: proc(datatype: rawptr, guid: string) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(guid)
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->GuidPut(bs)
    if com.failed(hr) do return

    return true
}

datatype_reserved_by_function :: proc {
    datatype_reserved_by_function_,
    datatype_reserved_by_function_set,
}

@(private)
datatype_reserved_by_function_ :: proc(datatype: rawptr) -> (reserved_by_function: string, ok: bool) {
    reserved_by_function = ""
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
datatype_reserved_by_function_set :: proc(datatype: rawptr, reserved_by_function: string) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(reserved_by_function)
    defer bstr.free(bs)
    hr := (^DataTypeIF)(datatype)->ReservedByFunctionPut(bs)
    if com.failed(hr) do return

    return true
}

datatype_components :: proc {
    datatype_components_,
    datatype_components_set,
}

@(private)
datatype_components_ :: proc(datatype: rawptr) -> (components: rawptr, ok: bool) {
    components = nil
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsGet(&components)
    if com.failed(hr) do return

    return components, true
}

@(private)
datatype_components_set :: proc(datatype: rawptr, components: rawptr) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsPut(components)
    if com.failed(hr) do return

    return true
}

datatype_release :: proc(datatype: rawptr) {
    if datatype != nil {
        (^DataTypeIF)(datatype)->Release()
    }
}

datatype_component_count :: proc(datatype: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false
    
    if !controlbuilder.connected() do return
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
datatype_component_remove_by_name :: proc(datatype: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
datatype_component_remove_by_index :: proc(datatype: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
datatype_component_add_ :: proc(datatype: rawptr, component: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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

datatype_component_add_at_index :: proc(datatype: rawptr, component: rawptr, index: i32) -> (ok: bool) {
    ok = false
    
    if !controlbuilder.connected() do return
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
datatype_component_by_name :: proc(datatype: rawptr, name: string) -> (component: rawptr, ok: bool) {
    component = nil
    ok = false

    if !controlbuilder.connected() do return
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
datatype_component_by_index :: proc(datatype: rawptr, index: i32) -> (component: rawptr, ok: bool) {
    component = nil
    ok = false

    if !controlbuilder.connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    component, ok = components_component_by_index(components, index)
    if !ok do return
    
    return component, true
}

datatype_component_index :: proc(datatype: rawptr, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if datatype == nil do return

    components: Components
    components, ok = datatype_components(datatype)
    if !ok do return
    defer components_release(components)
    
    index, ok = components_component_index(components, name)
    if !ok do return
    
    return index, true
}
