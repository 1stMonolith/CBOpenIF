package variable

import "../com"
import "../controlbuilder"
import "../bstr"

ExternalVariableIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ExternalVariableVTable,
}

ExternalVariableVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:                proc "system" (this: ^ExternalVariableIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ExternalVariableIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^ExternalVariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^ExternalVariableIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ExternalVariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ExternalVariableIF, Attribute: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^ExternalVariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^ExternalVariableIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^ExternalVariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^ExternalVariableIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^ExternalVariableIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^ExternalVariableIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^ExternalVariableIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^ExternalVariableIF, AuthenticationLevel: BStr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^ExternalVariableIF, GraphNodes: ^rawptr) -> HResult,
    Missing22:              proc "system" (this: ^ExternalVariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^ExternalVariableIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^ExternalVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^ExternalVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^ExternalVariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ExternalVariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ExternalVariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ExternalVariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ExternalVariableIF, SafetyType: BStr) -> HResult,
}

externalvariable_new :: proc(name: string, type: string, attribute := "", readpermission := "", writepermission := "", description := "") -> (external_variable: rawptr, ok: bool) {
    external_variable = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_type := bstr.from_string(type)
    bstr_attribute := bstr.from_string(attribute)
    bstr_readpermission := bstr.from_string(readpermission)
    bstr_writepermission := bstr.from_string(writepermission)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_type)
        bstr.free(bstr_attribute)
        bstr.free(bstr_readpermission)
        bstr.free(bstr_writepermission)
        bstr.free(bstr_description)
    }
    hr := factoryif->NewExternalVariable1(bstr_name, bstr_type, bstr_attribute, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&external_variable)
    if com.failed(hr) do return
    
    return external_variable, true
}

externalvariable_deserialize :: proc(external_variable: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factoryif->DeserializeExternalVariable(&bstr, cast(^rawptr)external_variable)
    if com.failed(hr) do return
    
    return true
}

externalvariable_serialize :: proc(external_variable: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

externalvariable_name :: proc {
    externalvariable_name_,
    externalvariable_name_set,
}

@(private)
externalvariable_name_ :: proc(external_variable: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
externalvariable_name_set :: proc(external_variable: rawptr, name: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_type_name :: proc {
    externalvariable_type_name_,
    externalvariable_type_name_set,
}

@(private)
externalvariable_type_name_ :: proc(external_variable: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
externalvariable_type_name_set :: proc(external_variable: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_attribute :: proc {
    externalvariable_attribute_,
    externalvariable_attribute_set,
}

@(private)
externalvariable_attribute_ :: proc(external_variable: rawptr) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_attribute_set :: proc(external_variable: rawptr, attribute: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(attribute)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributePut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_description :: proc {
    externalvariable_description_,
    externalvariable_description_set,
}

@(private)
externalvariable_description_ :: proc(external_variable: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_description_set :: proc(external_variable: rawptr, description: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_read_permission :: proc {
    externalvariable_read_permission_,
    externalvariable_read_permission_set,
}

@(private)
externalvariable_read_permission_ :: proc(external_variable: rawptr) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_read_permission_set :: proc(external_variable: rawptr, read_permission: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_write_permission :: proc {
    externalvariable_write_permission_,
    externalvariable_write_permission_set,
}

@(private)
externalvariable_write_permission_ :: proc(external_variable: rawptr) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_write_permission_set :: proc(external_variable: rawptr, write_permission: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_authentication_level :: proc {
    externalvariable_authentication_level_,
    externalvariable_authentication_level_set,
}

@(private)
externalvariable_authentication_level_ :: proc(external_variable: rawptr) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_authentication_level_set :: proc(external_variable: rawptr, authentication_level: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_graph_nodes :: proc {
    externalvariable_graph_nodes_,
    externalvariable_graph_nodes_set,
}

@(private)
externalvariable_graph_nodes_ :: proc(external_variable: rawptr) -> (graph_nodes: rawptr, ok: bool) {
    graph_nodes = nil
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesGet(&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

@(private)
externalvariable_graph_nodes_set :: proc(external_variable: rawptr, graph_nodes: rawptr) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

externalvariable_type_guid :: proc(external_variable: rawptr) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

externalvariable_type_path :: proc(external_variable: rawptr) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

externalvariable_access_level :: proc {
    externalvariable_access_level_,
    externalvariable_access_level_set,
}

@(private)
externalvariable_access_level_ :: proc(external_variable: rawptr) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_access_level_set :: proc(external_variable: rawptr, access_level: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_safety_type :: proc {
    externalvariable_safety_type_,
    externalvariable_safety_type_set,
}

@(private)
externalvariable_safety_type_ :: proc(external_variable: rawptr) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

@(private)
externalvariable_safety_type_set :: proc(external_variable: rawptr, safety_type: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

externalvariable_release :: proc(external_variable: rawptr) {
    if external_variable != nil {
        (^ExternalVariableIF)(external_variable)->Release()
    }
}
