package variable

import "../com"
import "../controlbuilder"
import "../factory"
import "../graph"
import "../signal"

@(private="file") HResult     :: com.HResult
@(private="file") BStr        :: com.BStr
@(private="file") GUID        :: com.GUID
@(private="file") VariantBool :: com.VariantBool
@(private="file") GraphNodes  :: graph.GraphNodes
@(private="file") Signals     :: signal.Signals

VariableType :: enum i32 {
    Variable              = 0,
    ExternalVariable      = 1,
    GlobalVariable        = 2,
    CommunicationVariable = 3,
}

Variable :: distinct rawptr

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

variable_new :: proc(name: string, type: string, attribute := "", initial_value := "", readpermission := "", writepermission := "", description := "") -> (variable: Variable, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    bstr_type := com.from_string(type)
    bstr_attribute := com.from_string(attribute)
    bstr_initial_value := com.from_string(initial_value)
    bstr_readpermission := com.from_string(readpermission)
    bstr_writepermission := com.from_string(writepermission)
    bstr_description := com.from_string(description)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_type)
        com.bstr_free(bstr_attribute)
        com.bstr_free(bstr_initial_value)
        com.bstr_free(bstr_readpermission)
        com.bstr_free(bstr_writepermission)
        com.bstr_free(bstr_description)
    }
    hr := factory.factoryif->NewVariable1(bstr_name, bstr_type, bstr_attribute, bstr_initial_value, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&variable)
    if com.failed(hr) do return
    
    return variable, true
}

variable_deserialize :: proc(variable: ^Variable, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeVariable(&bs, cast(^rawptr)variable)
    if com.failed(hr) do return
    
    return true
}

variable_serialize :: proc(variable: Variable) -> (xml: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->Serialize(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_name :: proc {
    variable_name_get,
    variable_name_set,
}

variable_name_get :: proc(variable: Variable) -> (name: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

variable_name_set :: proc(variable: Variable, name: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_type_name :: proc {
    variable_type_name_get,
    variable_type_name_set,
}

variable_type_name_get :: proc(variable: Variable) -> (type_name: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

variable_type_name_set :: proc(variable: Variable, type_name: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(type_name)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_attribute :: proc {
    variable_attribute_get,
    variable_attribute_set,
}

variable_attribute_get :: proc(variable: Variable) -> (attribute: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_attribute_set :: proc(variable: Variable, attribute: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(attribute)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_initial_value :: proc {
    variable_initial_value_get,
    variable_initial_value_set,
}

variable_initial_value_get :: proc(variable: Variable) -> (inital_value: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->InitialValueGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_initial_value_set :: proc(variable: Variable, inital_value: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(inital_value)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_description :: proc {
    variable_description_get,
    variable_description_set,
}

variable_description_get :: proc(variable: Variable) -> (description: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_description_set :: proc(variable: Variable, description: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(description)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_read_permission :: proc {
    variable_read_permission_get,
    variable_read_permission_set,
}

variable_read_permission_get :: proc(variable: Variable) -> (read_permission: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_read_permission_set :: proc(variable: Variable, read_permission: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(read_permission)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_write_permission :: proc {
    variable_write_permission_get,
    variable_write_permission_set,
}

variable_write_permission_get :: proc(variable: Variable) -> (write_permission: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_write_permission_set :: proc(variable: Variable, write_permission: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(write_permission)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_authentication_level :: proc {
    variable_authentication_level_get,
    variable_authentication_level_set,
}

variable_authentication_level_get :: proc(variable: Variable) -> (authentication_level: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_authentication_level_set :: proc(variable: Variable, authentication_level: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(authentication_level)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_batch_property :: proc {
    variable_batch_property_get,
    variable_batch_property_set,
}

variable_batch_property_get :: proc(variable: Variable) -> (batch_property: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_batch_property_set :: proc(variable: Variable, batch_property: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(batch_property)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_graph_nodes :: proc {
    variable_graph_nodes_get,
    variable_graph_nodes_set,
}

variable_graph_nodes_get :: proc(variable: Variable) -> (graph_nodes: GraphNodes, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

variable_graph_nodes_set :: proc(variable: Variable, graph_nodes: GraphNodes) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

variable_type_guid_get :: proc(variable: Variable) -> (guid: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_type_path_get :: proc(variable: Variable) -> (path: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->TypePath(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_access_level :: proc {
    variable_access_level_get,
    variable_access_level_set,
}

variable_access_level_get :: proc(variable: Variable) -> (access_level: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_access_level_set :: proc(variable: Variable, access_level: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(access_level)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_safety_type :: proc {
    variable_safety_type_get,
    variable_safety_type_set,
}

variable_safety_type_get :: proc(variable: Variable) -> (safety_type: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

variable_safety_type_set :: proc(variable: Variable, safety_type: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(safety_type)
    defer com.bstr_free(bs)
    hr := (^VariableIF)(variable)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

variable_release :: proc(variable: Variable) {
    if variable != nil {
        (^VariableIF)(variable)->Release()
    }
}
