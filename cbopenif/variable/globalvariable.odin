package variable

GlobalVariable :: distinct rawptr

GlobalVariableIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^GlobalVariableVTable,
}

GlobalVariableVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
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
    GraphNodesGet:          proc "system" (this: ^GlobalVariableIF, GraphNodes: ^GraphNodes) -> HResult,
    Missing24:              proc "system" (this: ^GlobalVariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^GlobalVariableIF, GraphNodes: GraphNodes) -> HResult,
    TypeGuid:               proc "system" (this: ^GlobalVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^GlobalVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^GlobalVariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^GlobalVariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^GlobalVariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^GlobalVariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^GlobalVariableIF, SafetyType: BStr) -> HResult,
}

globalvariable_new :: proc(name: string, type: string, attribute := "", initialvalue := "", readpermission := "", writepermission := "", description := "") -> (global_variable: GlobalVariable, ok: bool) {
    global_variable = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_type := string_to_bstr(type)
    bstr_attribute := string_to_bstr(attribute)
    bstr_initialvalue := string_to_bstr(initialvalue)
    bstr_readpermission := string_to_bstr(readpermission)
    bstr_writepermission := string_to_bstr(writepermission)
    bstr_description := string_to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initialvalue)
        bstr_free(bstr_readpermission)
        bstr_free(bstr_writepermission)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewGlobalVariable1(bstr_name, bstr_type, bstr_attribute, bstr_initialvalue, bstr_readpermission, bstr_writepermission, bstr_description, cast(^GlobalVariable)&global_variable)
    if failed(hr) do return
    
    return global_variable, true
}

globalvariable_deserialize :: proc(global_variable: ^GlobalVariable, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeGlobalVariable(&bstr, cast(^GlobalVariable)global_variable)
    if failed(hr) do return
    
    return true
}

globalvariable_serialize :: proc(global_variable: GlobalVariable) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

globalvariable_name :: proc {
    globalvariable_name_,
    globalvariable_name_set,
}

@(private)
globalvariable_name_ :: proc(global_variable: GlobalVariable) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
globalvariable_name_set :: proc(global_variable: GlobalVariable, name: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_type_name :: proc {
    globalvariable_type_name_,
    globalvariable_type_name_set,
}

@(private)
globalvariable_type_name_ :: proc(global_variable: GlobalVariable) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->TypeNameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
globalvariable_type_name_set :: proc(global_variable: GlobalVariable, type_name: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return

    bstr := string_to_bstr(type_name)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->TypeNamePut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_attribute :: proc {
    globalvariable_attribute_,
    globalvariable_attribute_set,
}

@(private)
globalvariable_attribute_ :: proc(global_variable: GlobalVariable) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->AttributeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_attribute_set :: proc(global_variable: GlobalVariable, attribute: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return

    bstr := string_to_bstr(attribute)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->AttributePut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_initial_value :: proc {
    globalvariable_initial_value_,
    globalvariable_initial_value_set,
}

@(private)
globalvariable_initial_value_ :: proc(global_variable: GlobalVariable) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->InitialValueGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_initial_value_set :: proc(global_variable: GlobalVariable, inital_value: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(inital_value)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->InitialValuePut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_description :: proc {
    globalvariable_description_,
    globalvariable_description_set,
}

@(private)
globalvariable_description_ :: proc(global_variable: GlobalVariable) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_description_set :: proc(global_variable: GlobalVariable, description: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_read_permission :: proc {
    globalvariable_read_permission_,
    globalvariable_read_permission_set,
}

@(private)
globalvariable_read_permission_ :: proc(global_variable: GlobalVariable) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_read_permission_set :: proc(global_variable: GlobalVariable, read_permission: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(read_permission)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_write_permission :: proc {
    globalvariable_write_permission_,
    globalvariable_write_permission_set,
}

@(private)
globalvariable_write_permission_ :: proc(global_variable: GlobalVariable) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_write_permission_set :: proc(global_variable: GlobalVariable, write_permission: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(write_permission)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_authentication_level :: proc {
    globalvariable_authentication_level_,
    globalvariable_authentication_level_set,
}

@(private)
globalvariable_authentication_level_ :: proc(global_variable: GlobalVariable) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_authentication_level_set :: proc(global_variable: GlobalVariable, authentication_level: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(authentication_level)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_graph_nodes :: proc {
    globalvariable_graph_nodes_,
    globalvariable_graph_nodes_set,
}

@(private)
globalvariable_graph_nodes_ :: proc(global_variable: GlobalVariable) -> (graph_nodes: GraphNodes, ok: bool) {
    graph_nodes = nil
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesGet(&graph_nodes)
    if failed(hr) do return
    
    return graph_nodes, true
}

@(private)
globalvariable_graph_nodes_set :: proc(global_variable: GlobalVariable, graph_nodes: GraphNodes) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesPut(graph_nodes)
    if failed(hr) do return
    
    return true
}

globalvariable_type_guid :: proc(global_variable: GlobalVariable) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->TypeGuid(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

globalvariable_type_path :: proc(global_variable: GlobalVariable) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->TypePath(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

globalvariable_access_level :: proc {
    globalvariable_access_level_,
    globalvariable_access_level_set,
}

@(private)
globalvariable_access_level_ :: proc(global_variable: GlobalVariable) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_access_level_set :: proc(global_variable: GlobalVariable, access_level: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(access_level)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_safety_type :: proc {
    globalvariable_safety_type_,
    globalvariable_safety_type_set,
}

@(private)
globalvariable_safety_type_ :: proc(global_variable: GlobalVariable) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
globalvariable_safety_type_set :: proc(global_variable: GlobalVariable, safety_type: string) -> (ok: bool) {
    ok = false

    if global_variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(safety_type)
    defer bstr_free(bstr)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

globalvariable_release :: proc(global_variable: GlobalVariable) {
    if global_variable != nil {
        (^GlobalVariableIF)(global_variable)->Release()
    }
}
