package type

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"


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
    hr := factory.factoryif->NewDataType1(bstr_name, bstr_description, variant.bool_to_variantbool(protected), variant.bool_to_variantbool(hidden), i32(scope), cast(^rawptr)&datatype)
    if com.failed(hr) do return

    return datatype, true
}

datatype_deserialize :: proc(datatype: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeDataType(&bs, cast(^rawptr)datatype)
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
    datatype_name_get,
    datatype_name_set,
}

datatype_name_get :: proc(datatype: rawptr) -> (name: string, ok: bool) {
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
    datatype_protected_get,
    datatype_protected_set,
}

datatype_protected_get :: proc(datatype: rawptr) -> (protected: bool, ok: bool) {
    protected = {}
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->ProtectedGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

datatype_protected_set :: proc(datatype: rawptr, protected: bool) -> (ok: bool) {
    ok = false
    
    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ProtectedPut(variant.bool_to_variantbool(protected))
    if com.failed(hr) do return

    return true
}

datatype_hidden :: proc {
    datatype_hidden_get,
    datatype_hidden_set,
}

datatype_hidden_get :: proc(datatype: rawptr) -> (hidden: bool, ok: bool) {
    hidden = {}
    ok = false
    
    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^DataTypeIF)(datatype)->HiddenGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

datatype_hidden_set :: proc(datatype: rawptr, hidden: bool) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->HiddenPut(variant.bool_to_variantbool(hidden))
    if com.failed(hr) do return

    return true
}

datatype_scope :: proc {
    datatype_scope_get,
    datatype_scope_set,
}

datatype_scope_get :: proc(datatype: rawptr) -> (scope: Scope, ok: bool) {
    scope = {}
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return

    s := i32(scope)
    hr := (^DataTypeIF)(datatype)->ScopeGet(&s)
    if com.failed(hr) do return

    return scope, true
}

datatype_scope_set :: proc(datatype: rawptr, scope: Scope) -> (ok: bool) {
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ScopePut(i32(scope))
    if com.failed(hr) do return

    return true
}

datatype_description :: proc {
    datatype_description_get,
    datatype_description_set,
}

datatype_description_get :: proc(datatype: rawptr) -> (description: string, ok: bool) {
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
    datatype_guid_get,
    datatype_guid_set,
}

datatype_guid_get :: proc(datatype: rawptr) -> (guid: string, ok: bool) {
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
    datatype_reserved_by_function_get,
    datatype_reserved_by_function_set,
}

datatype_reserved_by_function_get :: proc(datatype: rawptr) -> (reserved_by_function: string, ok: bool) {
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
    datatype_components_get,
    datatype_components_set,
}

datatype_components_get :: proc(datatype: rawptr) -> (components: rawptr, ok: bool) {
    components = nil
    ok = false

    if datatype == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^DataTypeIF)(datatype)->ComponentsGet(&components)
    if com.failed(hr) do return

    return components, true
}

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
