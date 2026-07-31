package variable

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"

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

globalvariable_new :: proc(name: string, type: string, attribute := "", initialvalue := "", readpermission := "", writepermission := "", description := "") -> (global_variable: rawptr, ok: bool) {
    global_variable = nil
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
    hr := factory.factoryif->NewGlobalVariable1(bstr_name, bstr_type, bstr_attribute, bstr_initialvalue, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&global_variable)
    if com.failed(hr) do return
    
    return global_variable, true
}

globalvariable_deserialize :: proc(global_variable: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeGlobalVariable(&bs, cast(^rawptr)global_variable)
    if com.failed(hr) do return
    
    return true
}

globalvariable_serialize :: proc(global_variable: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_name :: proc {
    globalvariable_name_,
    globalvariable_name_set,
}

@(private)
globalvariable_name_ :: proc(global_variable: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
globalvariable_name_set :: proc(global_variable: rawptr, name: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_type_name :: proc {
    globalvariable_type_name_,
    globalvariable_type_name_set,
}

@(private)
globalvariable_type_name_ :: proc(global_variable: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
globalvariable_type_name_set :: proc(global_variable: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_attribute :: proc {
    globalvariable_attribute_,
    globalvariable_attribute_set,
}

@(private)
globalvariable_attribute_ :: proc(global_variable: rawptr) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_attribute_set :: proc(global_variable: rawptr, attribute: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_initial_value :: proc {
    globalvariable_initial_value_,
    globalvariable_initial_value_set,
}

@(private)
globalvariable_initial_value_ :: proc(global_variable: rawptr) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_initial_value_set :: proc(global_variable: rawptr, inital_value: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(inital_value)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_description :: proc {
    globalvariable_description_,
    globalvariable_description_set,
}

@(private)
globalvariable_description_ :: proc(global_variable: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_description_set :: proc(global_variable: rawptr, description: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_read_permission :: proc {
    globalvariable_read_permission_,
    globalvariable_read_permission_set,
}

@(private)
globalvariable_read_permission_ :: proc(global_variable: rawptr) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_read_permission_set :: proc(global_variable: rawptr, read_permission: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_write_permission :: proc {
    globalvariable_write_permission_,
    globalvariable_write_permission_set,
}

@(private)
globalvariable_write_permission_ :: proc(global_variable: rawptr) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_write_permission_set :: proc(global_variable: rawptr, write_permission: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_authentication_level :: proc {
    globalvariable_authentication_level_,
    globalvariable_authentication_level_set,
}

@(private)
globalvariable_authentication_level_ :: proc(global_variable: rawptr) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_authentication_level_set :: proc(global_variable: rawptr, authentication_level: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_graph_nodes :: proc {
    globalvariable_graph_nodes_,
    globalvariable_graph_nodes_set,
}

@(private)
globalvariable_graph_nodes_ :: proc(global_variable: rawptr) -> (graph_nodes: rawptr, ok: bool) {
    graph_nodes = nil
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesGet(&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

@(private)
globalvariable_graph_nodes_set :: proc(global_variable: rawptr, graph_nodes: rawptr) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

globalvariable_type_guid :: proc(global_variable: rawptr) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_type_path :: proc(global_variable: rawptr) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

globalvariable_access_level :: proc {
    globalvariable_access_level_,
    globalvariable_access_level_set,
}

@(private)
globalvariable_access_level_ :: proc(global_variable: rawptr) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_access_level_set :: proc(global_variable: rawptr, access_level: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_safety_type :: proc {
    globalvariable_safety_type_,
    globalvariable_safety_type_set,
}

@(private)
globalvariable_safety_type_ :: proc(global_variable: rawptr) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
globalvariable_safety_type_set :: proc(global_variable: rawptr, safety_type: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

globalvariable_release :: proc(global_variable: rawptr) {
    if global_variable != nil {
        (^GlobalVariableIF)(global_variable)->Release()
    }
}
