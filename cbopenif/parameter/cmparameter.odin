package parameter

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"
import "../autopoint"

CMParameterIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^CMParameterVTable,
}

CMParameterVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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
    AutoPointGet:           proc "system" (this: ^CMParameterIF, AutoPoint: ^rawptr) -> HResult,
    Missing24:              proc "system" (this: ^CMParameterIF) -> HResult,
    AutoPointPut:           proc "system" (this: ^CMParameterIF, AutoPoint: rawptr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^CMParameterIF, GraphNodes: ^rawptr) -> HResult,
    Missing27:              proc "system" (this: ^CMParameterIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^CMParameterIF, GraphNodes: rawptr) -> HResult,
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

cmparameter_new :: proc(name: string, type_name: string, attribute := "", initial_value := "", read_permission := "", write_permission := "", description := "", auto_point : rawptr = nil) -> (cmparameter: rawptr, ok: bool) {
    cmparameter = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_type_name := bstr.from_string(type_name)
    bstr_attribute := bstr.from_string(attribute)
    bstr_initial_value := bstr.from_string(initial_value)
    bstr_read_permission := bstr.from_string(read_permission)
    bstr_write_permission := bstr.from_string(write_permission)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_type_name)
        bstr.free(bstr_attribute)
        bstr.free(bstr_initial_value)
        bstr.free(bstr_read_permission)
        bstr.free(bstr_write_permission)
        bstr.free(bstr_description)
    }

    ap: rawptr
    if auto_point == nil {
        ap, ok = autopoint.autopoint_new(AutoPos.Top)
        if !ok do return
        defer autopoint.autopoint_release(ap)
    } else {
        ap = auto_point
    }

    hr := factory.factoryif->NewCMParameter1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, ap, cast(^rawptr)&cmparameter)
    if com.failed(hr) do return
    
    return cmparameter, true
}

cmparameter_deserialize :: proc(cmparameter: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeCMParameter(&bs, cast(^rawptr)cmparameter)
    if com.failed(hr) do return
    
    return true
}

cmparameter_serialize :: proc(cmparameter: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_name :: proc {
    cmparameter_name_get,
    cmparameter_name_set,
}

cmparameter_name_get :: proc(cmparameter: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

cmparameter_name_set :: proc(cmparameter: rawptr, name: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_type_name :: proc {
    cmparameter_type_name_get,
    cmparameter_type_name_set,
}

cmparameter_type_name_get :: proc(cmparameter: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

cmparameter_type_name_set :: proc(cmparameter: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_initial_value :: proc {
    cmparameter_initial_value_get,
    cmparameter_initial_value_set,
}

cmparameter_initial_value_get :: proc(cmparameter: rawptr) -> (inital_value: string, ok: bool) {
    inital_value = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_initial_value_set :: proc(cmparameter: rawptr, inital_value: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(inital_value)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_description :: proc {
    cmparameter_description_get,
    cmparameter_description_set,
}

cmparameter_description_get :: proc(cmparameter: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_description_set :: proc(cmparameter: rawptr, description: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_read_permission :: proc {
    cmparameter_read_permission_get,
    cmparameter_read_permission_set,
}

cmparameter_read_permission_get :: proc(cmparameter: rawptr) -> (read_permission: string, ok: bool) {
    read_permission = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_read_permission_set :: proc(cmparameter: rawptr, read_permission: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(read_permission)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_write_permission :: proc {
    cmparameter_write_permission_get,
    cmparameter_write_permission_set,
}

cmparameter_write_permission_get :: proc(cmparameter: rawptr) -> (write_permission: string, ok: bool) {
    write_permission = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_write_permission_set :: proc(cmparameter: rawptr, write_permission: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(write_permission)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_authentication_level :: proc {
    cmparameter_authentication_level_get,
    cmparameter_authentication_level_set,
}

cmparameter_authentication_level_get :: proc(cmparameter: rawptr) -> (authentication_level: string, ok: bool) {
    authentication_level = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_authentication_level_set :: proc(cmparameter: rawptr, authentication_level: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(authentication_level)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_batch_property :: proc {
    cmparameter_batch_property_get,
    cmparameter_batch_property_set,
}

cmparameter_batch_property_get :: proc(cmparameter: rawptr) -> (batch_property: string, ok: bool) {
    batch_property = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_batch_property_set :: proc(cmparameter: rawptr, batch_property: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(batch_property)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_auto_point :: proc {
    cmparameter_auto_point_get,
    cmparameter_auto_point_set,
}

cmparameter_auto_point_get :: proc(cmparameter: rawptr) -> (auto_point: rawptr, ok: bool) {
    auto_point = nil
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointGet(&auto_point)
    if com.failed(hr) do return
    
    return auto_point, true
}

cmparameter_auto_point_set :: proc(cmparameter: rawptr, auto_point: rawptr) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointPut(auto_point)
    if com.failed(hr) do return
    
    return true
}

cmparameter_graph_nodes :: proc {
    cmparameter_graph_nodes_get,
    cmparameter_graph_nodes_set,
}

cmparameter_graph_nodes_get :: proc(cmparameter: rawptr) -> (graph_nodes: rawptr, ok: bool) {
    graph_nodes = nil
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesGet(&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

cmparameter_graph_nodes_set :: proc(cmparameter: rawptr, graph_nodes: rawptr) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

cmparameter_type_guid_get :: proc(cmparameter: rawptr) -> (guid: string, ok: bool) {
    guid = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_type_path_get :: proc(cmparameter: rawptr) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypePath(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_access_level :: proc {
    cmparameter_access_level_get,
    cmparameter_access_level_set,
}

cmparameter_access_level_get :: proc(cmparameter: rawptr) -> (access_level: string, ok: bool) {
    access_level = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_access_level_set :: proc(cmparameter: rawptr, access_level: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(access_level)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_safety_type :: proc {
    cmparameter_safety_type_get,
    cmparameter_safety_type_set,
}

cmparameter_safety_type_get :: proc(cmparameter: rawptr) -> (safety_type: string, ok: bool) {
    safety_type = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_safety_type_set :: proc(cmparameter: rawptr, safety_type: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(safety_type)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_direction :: proc {
    cmparameter_direction_get,
    cmparameter_direction_set,
}

cmparameter_direction_get :: proc(cmparameter: rawptr) -> (direction: string, ok: bool) {
    direction = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_direction_set :: proc(cmparameter: rawptr, direction: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(direction)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_fdport :: proc {
    cmparameter_fdport_get,
    cmparameter_fdport_set,
}

cmparameter_fdport_get :: proc(cmparameter: rawptr) -> (fdport: string, ok: bool) {
    fdport = ""
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmparameter_fdport_set :: proc(cmparameter: rawptr, fdport: string) -> (ok: bool) {
    ok = false

    if cmparameter == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(fdport)
    defer bstr.free(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_release :: proc(cmparameter: rawptr) {
    if cmparameter != nil {
        (^CMParameterIF)(cmparameter)->Release()
    }
}
