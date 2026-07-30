package cbopenif

CMParameter :: distinct rawptr

CMParameterIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^CMParameterVTable,
}

CMParameterVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    NameGet:                proc "system" (this: ^CMParameterIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^CMParameterIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^CMParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^CMParameterIF, TypeName: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^CMParameterIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^CMParameterIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^CMParameterIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^CMParameterIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^CMParameterIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^CMParameterIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^CMParameterIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^CMParameterIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^CMParameterIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^CMParameterIF, AuthenticationLevel: BStr) -> HResult,
    BatchPropertyGet:       proc "system" (this: ^CMParameterIF, BatchProperty: ^BStr) -> HResult,
    BatchPropertyPut:       proc "system" (this: ^CMParameterIF, BatchProperty: BStr) -> HResult,
    AutoPointGet:           proc "system" (this: ^CMParameterIF, AutoPoint: ^AutoPoint) -> HResult,
    Missing24:              proc "system" (this: ^CMParameterIF) -> HResult,
    AutoPointPut:           proc "system" (this: ^CMParameterIF, AutoPoint: AutoPoint) -> HResult,
    GraphNodesGet:          proc "system" (this: ^CMParameterIF, GraphNodes: ^GraphNodes) -> HResult,
    Missing27:              proc "system" (this: ^CMParameterIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^CMParameterIF, GraphNodes: GraphNodes) -> HResult,
    TypeGuid:               proc "system" (this: ^CMParameterIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^CMParameterIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^CMParameterIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^CMParameterIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^CMParameterIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^CMParameterIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^CMParameterIF, SafetyType: BStr) -> HResult,
    DirectionGet:           proc "system" (this: ^CMParameterIF, Direction: ^BStr) -> HResult,
    DirectionPut:           proc "system" (this: ^CMParameterIF, Direction: BStr) -> HResult,
    FDPortGet:              proc "system" (this: ^CMParameterIF, FDPort: ^BStr) -> HResult,
    FDPortPut:              proc "system" (this: ^CMParameterIF, FDPort: BStr) -> HResult,
}

cmparameter_new :: proc(name: string, type_name: string, attribute := "", initial_value := "", read_permission := "", write_permission := "", description := "", autopoint : AutoPoint = nil) -> (cmparameter: CMParameter, ok: bool) {
    cmparameter = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_type_name := string_to_bstr(type_name)
    bstr_attribute := string_to_bstr(attribute)
    bstr_initial_value := string_to_bstr(initial_value)
    bstr_read_permission := string_to_bstr(read_permission)
    bstr_write_permission := string_to_bstr(write_permission)
    bstr_description := string_to_bstr(description)
    defer {
        SysFreeString(bstr_name)
        SysFreeString(bstr_type_name)
        SysFreeString(bstr_attribute)
        SysFreeString(bstr_initial_value)
        SysFreeString(bstr_read_permission)
        SysFreeString(bstr_write_permission)
        SysFreeString(bstr_description)
    }

    ap: AutoPoint
    if autopoint == nil {
        ap, ok = autopoint_new(.Top)
        if !ok do return
    }

    hr := factoryif->NewCMParameter1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, ap, cast(^CMParameter)&cmparameter)
    if failed(hr) do return
    
    return cmparameter, true
}

cmparameter_deserialize :: proc(cmparameter: ^CMParameter, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer SysFreeString(bstr)
    hr := factoryif->DeserializeCMParameter(&bstr, cast(^CMParameter)cmparameter)
    if failed(hr) do return
    
    return true
}

cmparameter_serialize :: proc(cmparameter: CMParameter) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

cmparameter_name :: proc {
    cmparameter_name_,
    cmparameter_name_set,
}

@(private)
cmparameter_name_ :: proc(cmparameter: CMParameter) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
cmparameter_name_set :: proc(cmparameter: CMParameter, name: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_type_name :: proc {
    cmparameter_type_name_,
    cmparameter_type_name_set,
}

@(private)
cmparameter_type_name_ :: proc(cmparameter: CMParameter) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->TypeNameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
cmparameter_type_name_set :: proc(cmparameter: CMParameter, type_name: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return

    bstr := string_to_bstr(type_name)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->TypeNamePut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_initial_value :: proc {
    cmparameter_initial_value_,
    cmparameter_initial_value_set,
}

@(private)
cmparameter_initial_value_ :: proc(cmparameter: CMParameter) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->InitialValueGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_initial_value_set :: proc(cmparameter: CMParameter, inital_value: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(inital_value)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->InitialValuePut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_description :: proc {
    cmparameter_description_,
    cmparameter_description_set,
}

@(private)
cmparameter_description_ :: proc(cmparameter: CMParameter) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->DescriptionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_description_set :: proc(cmparameter: CMParameter, description: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_read_permission :: proc {
    cmparameter_read_permission_,
    cmparameter_read_permission_set,
}

@(private)
cmparameter_read_permission_ :: proc(cmparameter: CMParameter) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_read_permission_set :: proc(cmparameter: CMParameter, read_permission: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(read_permission)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_write_permission :: proc {
    cmparameter_write_permission_,
    cmparameter_write_permission_set,
}

@(private)
cmparameter_write_permission_ :: proc(cmparameter: CMParameter) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_write_permission_set :: proc(cmparameter: CMParameter, write_permission: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(write_permission)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_authentication_level :: proc {
    cmparameter_authentication_level_,
    cmparameter_authentication_level_set,
}

@(private)
cmparameter_authentication_level_ :: proc(cmparameter: CMParameter) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_authentication_level_set :: proc(cmparameter: CMParameter, authentication_level: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(authentication_level)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_batch_property :: proc {
    cmparameter_batch_property_,
    cmparameter_batch_property_set,
}

@(private)
cmparameter_batch_property_ :: proc(cmparameter: CMParameter) -> (batch_property: string, ok: bool) {
    batch_property = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_batch_property_set :: proc(cmparameter: CMParameter, batch_property: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(batch_property)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_auto_point :: proc {
    cmparameter_auto_point_,
    cmparameter_auto_point_set,
}

@(private)
cmparameter_auto_point_ :: proc(cmparameter: CMParameter) -> (auto_point: AutoPoint, ok: bool) {
    auto_point = nil
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointGet(&auto_point)
    if failed(hr) do return
    
    return auto_point, true
}

@(private)
cmparameter_auto_point_set :: proc(cmparameter: CMParameter, auto_point: AutoPoint) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointPut(auto_point)
    if failed(hr) do return
    
    return true
}

cmparameter_graph_nodes :: proc {
    cmparameter_graph_nodes_,
    cmparameter_graph_nodes_set,
}

@(private)
cmparameter_graph_nodes_ :: proc(cmparameter: CMParameter) -> (graph_nodes: GraphNodes, ok: bool) {
    graph_nodes = nil
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesGet(&graph_nodes)
    if failed(hr) do return
    
    return graph_nodes, true
}

@(private)
cmparameter_graph_nodes_set :: proc(cmparameter: CMParameter, graph_nodes: GraphNodes) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesPut(graph_nodes)
    if failed(hr) do return
    
    return true
}

cmparameter_type_guid :: proc(cmparameter: CMParameter) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->TypeGuid(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

cmparameter_type_path :: proc(cmparameter: CMParameter) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->TypePath(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

cmparameter_access_level :: proc {
    cmparameter_access_level_,
    cmparameter_access_level_set,
}

@(private)
cmparameter_access_level_ :: proc(cmparameter: CMParameter) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_access_level_set :: proc(cmparameter: CMParameter, access_level: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(access_level)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_safety_type :: proc {
    cmparameter_safety_type_,
    cmparameter_safety_type_set,
}

@(private)
cmparameter_safety_type_ :: proc(cmparameter: CMParameter) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypeGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_safety_type_set :: proc(cmparameter: CMParameter, safety_type: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(safety_type)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypePut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_direction :: proc {
    cmparameter_direction_,
    cmparameter_direction_set,
}

@(private)
cmparameter_direction_ :: proc(cmparameter: CMParameter) -> (direction: string, ok: bool) {
    direction = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->DirectionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_direction_set :: proc(cmparameter: CMParameter, direction: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(direction)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->DirectionPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_fdport :: proc {
    cmparameter_fdport_,
    cmparameter_fdport_set,
}

@(private)
cmparameter_fdport_ :: proc(cmparameter: CMParameter) -> (fdport: string, ok: bool) {
    fdport = ""
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->FDPortGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
cmparameter_fdport_set :: proc(cmparameter: CMParameter, fdport: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(fdport)
    defer SysFreeString(bstr)
    hr := (^CMParameterIF)(cmparameter)->FDPortPut(bstr)
    if failed(hr) do return
    
    return true
}

cmparameter_release :: proc(cmparameter: CMParameter) {
    if cmparameter != nil {
        (^CMParameterIF)(cmparameter)->Release()
    }
}
