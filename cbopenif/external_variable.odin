package cbopenif

ExternalVariable :: distinct rawptr

ExternalVariableIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ExternalVariableVTable,
}

ExternalVariableVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
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
    GraphNodesGet:          proc "system" (this: ^ExternalVariableIF, GraphNodes: ^GraphNodes) -> HResult,
    Missing22:              proc "system" (this: ^ExternalVariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^ExternalVariableIF, GraphNodes: GraphNodes) -> HResult,
    TypeGuid:               proc "system" (this: ^ExternalVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^ExternalVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^ExternalVariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ExternalVariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ExternalVariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ExternalVariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ExternalVariableIF, SafetyType: BStr) -> HResult,
}

externalvariable_new :: proc(name: string, type: string, attribute := "", readpermission := "", writepermission := "", description := "") -> (external_variable: ExternalVariable, ok: bool) {
    external_variable = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_type := string_to_bstr(type)
    bstr_attribute := string_to_bstr(attribute)
    bstr_readpermission := string_to_bstr(readpermission)
    bstr_writepermission := string_to_bstr(writepermission)
    bstr_description := string_to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_attribute)
        bstr_free(bstr_readpermission)
        bstr_free(bstr_writepermission)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewExternalVariable1(bstr_name, bstr_type, bstr_attribute, bstr_readpermission, bstr_writepermission, bstr_description, cast(^ExternalVariable)&external_variable)
    if failed(hr) do return
    
    return external_variable, true
}

externalvariable_deserialize :: proc(external_variable: ^ExternalVariable, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeExternalVariable(&bstr, cast(^ExternalVariable)external_variable)
    if failed(hr) do return
    
    return true
}

externalvariable_serialize :: proc(external_variable: ExternalVariable) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

externalvariable_name :: proc {
    externalvariable_name_,
    externalvariable_name_set,
}

@(private)
externalvariable_name_ :: proc(external_variable: ExternalVariable) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
externalvariable_name_set :: proc(external_variable: ExternalVariable, name: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_type_name :: proc {
    externalvariable_type_name_,
    externalvariable_type_name_set,
}

@(private)
externalvariable_type_name_ :: proc(external_variable: ExternalVariable) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->TypeNameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
externalvariable_type_name_set :: proc(external_variable: ExternalVariable, type_name: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return

    bstr := string_to_bstr(type_name)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->TypeNamePut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_attribute :: proc {
    externalvariable_attribute_,
    externalvariable_attribute_set,
}

@(private)
externalvariable_attribute_ :: proc(external_variable: ExternalVariable) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->AttributeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_attribute_set :: proc(external_variable: ExternalVariable, attribute: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return

    bstr := string_to_bstr(attribute)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->AttributePut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_description :: proc {
    externalvariable_description_,
    externalvariable_description_set,
}

@(private)
externalvariable_description_ :: proc(external_variable: ExternalVariable) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_description_set :: proc(external_variable: ExternalVariable, description: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_read_permission :: proc {
    externalvariable_read_permission_,
    externalvariable_read_permission_set,
}

@(private)
externalvariable_read_permission_ :: proc(external_variable: ExternalVariable) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_read_permission_set :: proc(external_variable: ExternalVariable, read_permission: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(read_permission)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_write_permission :: proc {
    externalvariable_write_permission_,
    externalvariable_write_permission_set,
}

@(private)
externalvariable_write_permission_ :: proc(external_variable: ExternalVariable) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_write_permission_set :: proc(external_variable: ExternalVariable, write_permission: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(write_permission)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_authentication_level :: proc {
    externalvariable_authentication_level_,
    externalvariable_authentication_level_set,
}

@(private)
externalvariable_authentication_level_ :: proc(external_variable: ExternalVariable) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_authentication_level_set :: proc(external_variable: ExternalVariable, authentication_level: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(authentication_level)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_graph_nodes :: proc {
    externalvariable_graph_nodes_,
    externalvariable_graph_nodes_set,
}

@(private)
externalvariable_graph_nodes_ :: proc(external_variable: ExternalVariable) -> (graph_nodes: GraphNodes, ok: bool) {
    graph_nodes = nil
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesGet(&graph_nodes)
    if failed(hr) do return
    
    return graph_nodes, true
}

@(private)
externalvariable_graph_nodes_set :: proc(external_variable: ExternalVariable, graph_nodes: GraphNodes) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesPut(graph_nodes)
    if failed(hr) do return
    
    return true
}

externalvariable_type_guid :: proc(external_variable: ExternalVariable) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->TypeGuid(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

externalvariable_type_path :: proc(external_variable: ExternalVariable) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->TypePath(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

externalvariable_access_level :: proc {
    externalvariable_access_level_,
    externalvariable_access_level_set,
}

@(private)
externalvariable_access_level_ :: proc(external_variable: ExternalVariable) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_access_level_set :: proc(external_variable: ExternalVariable, access_level: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(access_level)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_safety_type :: proc {
    externalvariable_safety_type_,
    externalvariable_safety_type_set,
}

@(private)
externalvariable_safety_type_ :: proc(external_variable: ExternalVariable) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
externalvariable_safety_type_set :: proc(external_variable: ExternalVariable, safety_type: string) -> (ok: bool) {
    ok = false

    if external_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(safety_type)
    defer bstr_free(bstr)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

externalvariable_release :: proc(external_variable: ExternalVariable) {
    if external_variable != nil {
        (^ExternalVariableIF)(external_variable)->Release()
    }
}
