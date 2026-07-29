package cbopenif

Variable   :: distinct rawptr

VariableIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^VariableVTable,
}

VariableVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
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
    GraphNodesGet:          proc "system" (this: ^VariableIF, GraphNodes: ^GraphNodes) -> HResult,
    Missing26:              proc "system" (this: ^VariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^VariableIF, GraphNodes: GraphNodes) -> HResult,
    TypeGuid:               proc "system" (this: ^VariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^VariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^VariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^VariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^VariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^VariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^VariableIF, SafetyType: BStr) -> HResult,
}

variable_new :: proc(name: string, type: string, attribute := "", initialvalue := "", readpermission := "", writepermission := "", description := "") -> (variable: Variable, ok: bool) {
    variable = nil
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
        SysFreeString(bstr_name)
        SysFreeString(bstr_type)
        SysFreeString(bstr_attribute)
        SysFreeString(bstr_initialvalue)
        SysFreeString(bstr_readpermission)
        SysFreeString(bstr_writepermission)
        SysFreeString(bstr_description)
    }
    hr := factoryif->NewVariable1(bstr_name, bstr_type, bstr_attribute, bstr_initialvalue, bstr_readpermission, bstr_writepermission, bstr_description, cast(^Variable)&variable)
    if failed(hr) do return
    
    return variable, true
}

variable_deserialize :: proc(variable: ^Variable, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    BStr := string_to_bstr(xml)
    defer SysFreeString(BStr)
    hr := factoryif->DeserializeVariable(&BStr, cast(^Variable)variable)
    if failed(hr) do return
    
    return true
}

variable_serialize :: proc(variable: Variable) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    BStr: BStr
    defer SysFreeString(BStr)
    hr := (^VariableIF)(variable)->Serialize(&BStr)
    if failed(hr) do return
    
    return bstr_to_string(BStr), true
}

variable_name :: proc {
    variable_name_,
    variable_name_set,
}

@(private)
variable_name_ :: proc(variable: Variable) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
variable_name_set :: proc(variable: Variable, name: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

variable_type_name :: proc {
    variable_type_name_,
    variable_type_name_set,
}

@(private)
variable_type_name_ :: proc(variable: Variable) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->TypeNameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
variable_type_name_set :: proc(variable: Variable, type_name: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return

    bstr := string_to_bstr(type_name)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->TypeNamePut(bstr)
    if failed(hr) do return
    
    return true
}

variable_attribute :: proc {
    variable_attribute_,
    variable_attribute_set,
}

@(private)
variable_attribute_ :: proc(variable: Variable) -> (attribute: string, ok: bool) {
    attribute = ""
    ok = false

    if variable == nil do return
    if !connected() do return

    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->AttributeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_attribute_set :: proc(variable: Variable, attribute: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return

    bstr := string_to_bstr(attribute)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->AttributePut(bstr)
    if failed(hr) do return
    
    return true
}

variable_initial_value :: proc {
    variable_initial_value_,
    variable_initial_value_set,
}

@(private)
variable_initial_value_ :: proc(variable: Variable) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->InitialValueGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_initial_value_set :: proc(variable: Variable, inital_value: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(inital_value)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->InitialValuePut(bstr)
    if failed(hr) do return
    
    return true
}

variable_description :: proc {
    variable_description_,
    variable_description_set,
}

@(private)
variable_description_ :: proc(variable: Variable) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->DescriptionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_description_set :: proc(variable: Variable, description: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

variable_read_permission :: proc {
    variable_read_permission_,
    variable_read_permission_set,
}

@(private)
variable_read_permission_ :: proc(variable: Variable) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->ReadPermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_read_permission_set :: proc(variable: Variable, read_permission: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(read_permission)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->ReadPermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

variable_write_permission :: proc {
    variable_write_permission_,
    variable_write_permission_set,
}

@(private)
variable_write_permission_ :: proc(variable: Variable) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->WritePermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_write_permission_set :: proc(variable: Variable, write_permission: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(write_permission)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->WritePermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

variable_authentication_level :: proc {
    variable_authentication_level_,
    variable_authentication_level_set,
}

@(private)
variable_authentication_level_ :: proc(variable: Variable) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_authentication_level_set :: proc(variable: Variable, authentication_level: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(authentication_level)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->AuthenticationLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

variable_batch_property :: proc {
    variable_batch_property_,
    variable_batch_property_set,
}

@(private)
variable_batch_property_ :: proc(variable: Variable) -> (batch_property: string, ok: bool) {
    batch_property = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->BatchPropertyGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_batch_property_set :: proc(variable: Variable, batch_property: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(batch_property)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->BatchPropertyPut(bstr)
    if failed(hr) do return
    
    return true
}

variable_graph_nodes :: proc {
    variable_graph_nodes_,
    variable_graph_nodes_set,
}

@(private)
variable_graph_nodes_ :: proc(variable: Variable) -> (graph_nodes: GraphNodes, ok: bool) {
    graph_nodes = nil
    ok = false

    if variable == nil do return
    if !connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesGet(&graph_nodes)
    if failed(hr) do return
    
    return graph_nodes, true
}

@(private)
variable_graph_nodes_set :: proc(variable: Variable, graph_nodes: GraphNodes) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesPut(graph_nodes)
    if failed(hr) do return
    
    return true
}

variable_type_guid :: proc(variable: Variable) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->TypeGuid(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

variable_type_path :: proc(variable: Variable) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->TypePath(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

variable_access_level :: proc {
    variable_access_level_,
    variable_access_level_set,
}

@(private)
variable_access_level_ :: proc(variable: Variable) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->AccessLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_access_level_set :: proc(variable: Variable, access_level: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(access_level)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->AccessLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

variable_safety_type :: proc {
    variable_safety_type_,
    variable_safety_type_set,
}

@(private)
variable_safety_type_ :: proc(variable: Variable) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
variable_safety_type_set :: proc(variable: Variable, safety_type: string) -> (ok: bool) {
    ok = false

    if variable == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(safety_type)
    defer SysFreeString(bstr)
    hr := (^VariableIF)(variable)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

variable_release :: proc(variable: Variable) {
    if variable != nil {
        (^VariableIF)(variable)->Release()
    }
}
