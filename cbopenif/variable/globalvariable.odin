package variable

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"
import "../graph"

@(private="file") BStr       :: bstr.BStr
@(private="file") GraphNodes :: graph.GraphNodes
@(private="file") HResult    :: com.HResult

GlobalVariable :: distinct rawptr

GlobalVariableIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^GlobalVariableVTable,
}

GlobalVariableVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:                proc "system" (this: ^GlobalVariableIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^GlobalVariableIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^GlobalVariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^GlobalVariableIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^GlobalVariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^GlobalVariableIF, Attribute: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^GlobalVariableIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^GlobalVariableIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^GlobalVariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^GlobalVariableIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^GlobalVariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^GlobalVariableIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^GlobalVariableIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^GlobalVariableIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^GlobalVariableIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^GlobalVariableIF, AuthenticationLevel: BStr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^GlobalVariableIF, GraphNodes: ^rawptr) -> HResult,
    Missing24:              proc "system" (this: ^GlobalVariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^GlobalVariableIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^GlobalVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^GlobalVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^GlobalVariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^GlobalVariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^GlobalVariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^GlobalVariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^GlobalVariableIF, SafetyType: BStr) -> HResult,
}

globalvariable_new :: proc(name: string, type: string, attribute := "", initial_value := "", readpermission := "", writepermission := "", description := "") -> (global_variable: GlobalVariable, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_type := bstr.from_string(type)
    bstr_attribute := bstr.from_string(attribute)
    bstr_initial_value := bstr.from_string(initial_value)
    bstr_readpermission := bstr.from_string(readpermission)
    bstr_writepermission := bstr.from_string(writepermission)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_type)
        bstr.free(bstr_attribute)
        bstr.free(bstr_initial_value)
        bstr.free(bstr_readpermission)
        bstr.free(bstr_writepermission)
        bstr.free(bstr_description)
    }
    hr := factory.factoryif->NewGlobalVariable1(bstr_name, bstr_type, bstr_attribute, bstr_initial_value, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&global_variable)
    if com.failed(hr) do return
    
    return global_variable, true
}

globalvariable_deserialize :: proc(global_variable: ^GlobalVariable, xml: string) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeGlobalVariable(&bs, cast(^rawptr)global_variable)
    if com.failed(hr) do return
    
    return true
}

globalvariable_serialize :: proc(global_variable: GlobalVariable) -> (xml: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_name :: proc {
    globalvariable_name_get,
    globalvariable_name_set,
}

globalvariable_name_get :: proc(global_variable: GlobalVariable) -> (name: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

globalvariable_name_set :: proc(global_variable: GlobalVariable, name: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_type_name :: proc {
    globalvariable_type_name_get,
    globalvariable_type_name_set,
}

globalvariable_type_name_get :: proc(global_variable: GlobalVariable) -> (type_name: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

globalvariable_type_name_set :: proc(global_variable: GlobalVariable, type_name: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_attribute :: proc {
    globalvariable_attribute_get,
    globalvariable_attribute_set,
}

globalvariable_attribute_get :: proc(global_variable: GlobalVariable) -> (attribute: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_attribute_set :: proc(global_variable: GlobalVariable, attribute: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_initial_value :: proc {
    globalvariable_initial_value_get,
    globalvariable_initial_value_set,
}

globalvariable_initial_value_get :: proc(global_variable: GlobalVariable) -> (inital_value: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_initial_value_set :: proc(global_variable: GlobalVariable, inital_value: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(inital_value)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_description :: proc {
    globalvariable_description_get,
    globalvariable_description_set,
}

globalvariable_description_get :: proc(global_variable: GlobalVariable) -> (description: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_description_set :: proc(global_variable: GlobalVariable, description: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_read_permission :: proc {
    globalvariable_read_permission_get,
    globalvariable_read_permission_set,
}

globalvariable_read_permission_get :: proc(global_variable: GlobalVariable) -> (read_permission: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_read_permission_set :: proc(global_variable: GlobalVariable, read_permission: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_write_permission :: proc {
    globalvariable_write_permission_get,
    globalvariable_write_permission_set,
}

globalvariable_write_permission_get :: proc(global_variable: GlobalVariable) -> (write_permission: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_write_permission_set :: proc(global_variable: GlobalVariable, write_permission: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_authentication_level :: proc {
    globalvariable_authentication_level_get,
    globalvariable_authentication_level_set,
}

globalvariable_authentication_level_get :: proc(global_variable: GlobalVariable) -> (authentication_level: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_authentication_level_set :: proc(global_variable: GlobalVariable, authentication_level: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_graph_nodes :: proc {
    globalvariable_graph_nodes_get,
    globalvariable_graph_nodes_set,
}

globalvariable_graph_nodes_get :: proc(global_variable: GlobalVariable) -> (graph_nodes: GraphNodes, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

globalvariable_graph_nodes_set :: proc(global_variable: GlobalVariable, graph_nodes: GraphNodes) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

globalvariable_type_guid_get :: proc(global_variable: GlobalVariable) -> (guid: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_type_path_get :: proc(global_variable: GlobalVariable) -> (path: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_access_level :: proc {
    globalvariable_access_level_get,
    globalvariable_access_level_set,
}

globalvariable_access_level_get :: proc(global_variable: GlobalVariable) -> (access_level: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_access_level_set :: proc(global_variable: GlobalVariable, access_level: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_safety_type :: proc {
    globalvariable_safety_type_get,
    globalvariable_safety_type_set,
}

globalvariable_safety_type_get :: proc(global_variable: GlobalVariable) -> (safety_type: string, ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_safety_type_set :: proc(global_variable: GlobalVariable, safety_type: string) -> (ok: bool) {

    if global_variable == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_release :: proc(global_variable: GlobalVariable) {
    if global_variable != nil {
        (^GlobalVariableIF)(global_variable)->Release()
    }
}
