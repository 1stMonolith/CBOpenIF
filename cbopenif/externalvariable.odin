package cbopenif

ExternalVariable :: distinct rawptr

ExternalVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExternalVariableVTable,
}

ExternalVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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

externalvariable_new :: proc(name: string, type: string, attribute := "", readpermission := "", writepermission := "", description := "") -> (external_variable: ExternalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type := to_bstr(type)
    bstr_attribute := to_bstr(attribute)
    bstr_readpermission := to_bstr(readpermission)
    bstr_writepermission := to_bstr(writepermission)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_attribute)
        bstr_free(bstr_readpermission)
        bstr_free(bstr_writepermission)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewExternalVariable1(bstr_name, bstr_type, bstr_attribute, bstr_readpermission, bstr_writepermission, bstr_description, cast(^rawptr)&external_variable)
    if com_failed(hr) do return
    
    return external_variable, true
}

externalvariable_deserialize :: proc(xml: string) -> (external_variable: ExternalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeExternalVariable(&bs, cast(^rawptr)external_variable)
    if com_failed(hr) do return
    
    return external_variable, true
}

externalvariable_serialize :: proc(external_variable: ExternalVariable) -> (xml: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_name :: proc {
    externalvariable_name_get,
    externalvariable_name_set,
}

externalvariable_name_get :: proc(external_variable: ExternalVariable) -> (name: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

externalvariable_name_set :: proc(external_variable: ExternalVariable, name: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_type_name :: proc {
    externalvariable_type_name_get,
    externalvariable_type_name_set,
}

externalvariable_type_name_get :: proc(external_variable: ExternalVariable) -> (type_name: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

externalvariable_type_name_set :: proc(external_variable: ExternalVariable, type_name: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_attribute :: proc {
    externalvariable_attribute_get,
    externalvariable_attribute_set,
}

externalvariable_attribute_get :: proc(external_variable: ExternalVariable) -> (attribute: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_attribute_set :: proc(external_variable: ExternalVariable, attribute: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_description :: proc {
    externalvariable_description_get,
    externalvariable_description_set,
}

externalvariable_description_get :: proc(external_variable: ExternalVariable) -> (description: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_description_set :: proc(external_variable: ExternalVariable, description: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_read_permission :: proc {
    externalvariable_read_permission_get,
    externalvariable_read_permission_set,
}

externalvariable_read_permission_get :: proc(external_variable: ExternalVariable) -> (read_permission: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_read_permission_set :: proc(external_variable: ExternalVariable, read_permission: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_write_permission :: proc {
    externalvariable_write_permission_get,
    externalvariable_write_permission_set,
}

externalvariable_write_permission_get :: proc(external_variable: ExternalVariable) -> (write_permission: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_write_permission_set :: proc(external_variable: ExternalVariable, write_permission: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_authentication_level :: proc {
    externalvariable_authentication_level_get,
    externalvariable_authentication_level_set,
}

externalvariable_authentication_level_get :: proc(external_variable: ExternalVariable) -> (authentication_level: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_authentication_level_set :: proc(external_variable: ExternalVariable, authentication_level: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_graph_nodes :: proc {
    externalvariable_graph_nodes_get,
    externalvariable_graph_nodes_set,
}

externalvariable_graph_nodes_get :: proc(external_variable: ExternalVariable) -> (graph_nodes: GraphNodes, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

externalvariable_graph_nodes_set :: proc(external_variable: ExternalVariable, graph_nodes: GraphNodes) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

externalvariable_type_guid_get :: proc(external_variable: ExternalVariable) -> (guid: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_type_path_get :: proc(external_variable: ExternalVariable) -> (path: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_access_level :: proc {
    externalvariable_access_level_get,
    externalvariable_access_level_set,
}

externalvariable_access_level_get :: proc(external_variable: ExternalVariable) -> (access_level: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_access_level_set :: proc(external_variable: ExternalVariable, access_level: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_safety_type :: proc {
    externalvariable_safety_type_get,
    externalvariable_safety_type_set,
}

externalvariable_safety_type_get :: proc(external_variable: ExternalVariable) -> (safety_type: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_safety_type_set :: proc(external_variable: ExternalVariable, safety_type: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_release :: proc(external_variable: ExternalVariable) {
    if external_variable != nil {
        (^ExternalVariableIF)(external_variable)->Release()
    }
}
