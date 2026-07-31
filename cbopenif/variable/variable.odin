package variable

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

VariableIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^VariableVTable,
}

VariableVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:                proc "system" (this: ^VariableIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^VariableIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^VariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^VariableIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^VariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^VariableIF, Attribute: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^VariableIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^VariableIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^VariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^VariableIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^VariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^VariableIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^VariableIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^VariableIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^VariableIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^VariableIF, AuthenticationLevel: BStr) -> HResult,
    BatchPropertyGet:       proc "system" (this: ^VariableIF, BatchProperty: ^BStr) -> HResult,
    BatchPropertyPut:       proc "system" (this: ^VariableIF, BatchProperty: BStr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^VariableIF, GraphNodes: ^rawptr) -> HResult,
    Missing26:              proc "system" (this: ^VariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^VariableIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^VariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^VariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^VariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^VariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^VariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^VariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^VariableIF, SafetyType: BStr) -> HResult,
}

variable_new :: proc(name: string, type: string, attribute := "", initialvalue := "", readpermission := "", writepermission := "", description := "") -> (variable: rawptr, ok: bool) {
    variable = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_type := bstr.from_string(type)
    bstr_attribute := bstr.from_string(attribute)
    bstr_initialvalue := bstr.from_string(initialvalue)
    bstr_readpermission := bstr.from_string(readpermission)
    bstr_writepermission := bstr.from_string(writepermission)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_type)
        bstr.free(bstr_attribute)
        bstr.free(bstr_initialvalue)
        bstr.free(bstr_readpermission)
        bstr.free(bstr_writepermission)
        bstr.free(bstr_description)
    }
    hr := factory.factoryif->NewVariable1(bstr_name, bstr_type, bstr_attribute, bstr_initialvalue, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&variable)
    if com.failed(hr) do return
    
    return variable, true
}

variable_deserialize :: proc(variable: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeVariable(&bs, cast(^rawptr)variable)
    if com.failed(hr) do return
    
    return true
}

variable_serialize :: proc(variable: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_name :: proc {
    variable_name_get,
    variable_name_set,
}

variable_name_get :: proc(variable: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

variable_name_set :: proc(variable: rawptr, name: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_type_name :: proc {
    variable_type_name_get,
    variable_type_name_set,
}

variable_type_name_get :: proc(variable: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

variable_type_name_set :: proc(variable: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_attribute :: proc {
    variable_attribute_get,
    variable_attribute_set,
}

variable_attribute_get :: proc(variable: rawptr) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_attribute_set :: proc(variable: rawptr, attribute: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_initial_value :: proc {
    variable_initial_value_get,
    variable_initial_value_set,
}

variable_initial_value_get :: proc(variable: rawptr) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->InitialValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_initial_value_set :: proc(variable: rawptr, inital_value: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(inital_value)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_description :: proc {
    variable_description_get,
    variable_description_set,
}

variable_description_get :: proc(variable: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_description_set :: proc(variable: rawptr, description: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_read_permission :: proc {
    variable_read_permission_get,
    variable_read_permission_set,
}

variable_read_permission_get :: proc(variable: rawptr) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_read_permission_set :: proc(variable: rawptr, read_permission: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_write_permission :: proc {
    variable_write_permission_get,
    variable_write_permission_set,
}

variable_write_permission_get :: proc(variable: rawptr) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_write_permission_set :: proc(variable: rawptr, write_permission: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_authentication_level :: proc {
    variable_authentication_level_get,
    variable_authentication_level_set,
}

variable_authentication_level_get :: proc(variable: rawptr) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_authentication_level_set :: proc(variable: rawptr, authentication_level: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_batch_property :: proc {
    variable_batch_property_get,
    variable_batch_property_set,
}

variable_batch_property_get :: proc(variable: rawptr) -> (batch_property: string, ok: bool) {
    batch_property = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_batch_property_set :: proc(variable: rawptr, batch_property: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(batch_property)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_graph_nodes :: proc {
    variable_graph_nodes_get,
    variable_graph_nodes_set,
}

variable_graph_nodes_get :: proc(variable: rawptr) -> (graph_nodes: rawptr, ok: bool) {
    graph_nodes = nil
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesGet(&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

variable_graph_nodes_set :: proc(variable: rawptr, graph_nodes: rawptr) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

variable_type_guid_get :: proc(variable: rawptr) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_type_path_get :: proc(variable: rawptr) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_access_level :: proc {
    variable_access_level_get,
    variable_access_level_set,
}

variable_access_level_get :: proc(variable: rawptr) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_access_level_set :: proc(variable: rawptr, access_level: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_safety_type :: proc {
    variable_safety_type_get,
    variable_safety_type_set,
}

variable_safety_type_get :: proc(variable: rawptr) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

variable_safety_type_set :: proc(variable: rawptr, safety_type: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^VariableIF)(variable)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_release :: proc(variable: rawptr) {
    if variable != nil {
        (^VariableIF)(variable)->Release()
    }
}
