package parameter

import "../com"
import "../controlbuilder"
import "../factory"
import "../graph"
import "../point"
import "../type"

@(private="file") AutoPoint   :: point.AutoPoint
@(private="file") AutoPosType :: type.AutoPosType
@(private="file") BStr        :: com.BStr
@(private="file") GraphNodes  :: graph.GraphNodes
@(private="file") HResult     :: com.HResult

CMParameter :: distinct rawptr

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

cmparameter_new :: proc(name: string, type_name: string, attribute := "", initial_value := "", read_permission := "", write_permission := "", description := "", auto_point : AutoPoint = nil) -> (cmparameter: CMParameter, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    bstr_type_name := com.from_string(type_name)
    bstr_attribute := com.from_string(attribute)
    bstr_initial_value := com.from_string(initial_value)
    bstr_read_permission := com.from_string(read_permission)
    bstr_write_permission := com.from_string(write_permission)
    bstr_description := com.from_string(description)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_type_name)
        com.bstr_free(bstr_attribute)
        com.bstr_free(bstr_initial_value)
        com.bstr_free(bstr_read_permission)
        com.bstr_free(bstr_write_permission)
        com.bstr_free(bstr_description)
    }

    ap: AutoPoint
    if auto_point == nil {
        ap, ok = point.autopoint_new(AutoPosType.Top)
        if !ok do return
        defer point.autopoint_release(ap)
    } else {
        ap = auto_point
    }

    hr := factory.factoryif->NewCMParameter1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, ap, cast(^rawptr)&cmparameter)
    if com.failed(hr) do return
    
    return cmparameter, true
}

cmparameter_deserialize :: proc(cmparameter: ^CMParameter, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeCMParameter(&bs, cast(^rawptr)cmparameter)
    if com.failed(hr) do return
    
    return true
}

cmparameter_serialize :: proc(cmparameter: CMParameter) -> (xml: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->Serialize(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_name :: proc {
    cmparameter_name_get,
    cmparameter_name_set,
}

cmparameter_name_get :: proc(cmparameter: CMParameter) -> (name: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

cmparameter_name_set :: proc(cmparameter: CMParameter, name: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_type_name :: proc {
    cmparameter_type_name_get,
    cmparameter_type_name_set,
}

cmparameter_type_name_get :: proc(cmparameter: CMParameter) -> (type_name: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

cmparameter_type_name_set :: proc(cmparameter: CMParameter, type_name: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(type_name)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNamePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_initial_value :: proc {
    cmparameter_initial_value_get,
    cmparameter_initial_value_set,
}

cmparameter_initial_value_get :: proc(cmparameter: CMParameter) -> (inital_value: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValueGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_initial_value_set :: proc(cmparameter: CMParameter, inital_value: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(inital_value)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_description :: proc {
    cmparameter_description_get,
    cmparameter_description_set,
}

cmparameter_description_get :: proc(cmparameter: CMParameter) -> (description: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_description_set :: proc(cmparameter: CMParameter, description: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(description)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_read_permission :: proc {
    cmparameter_read_permission_get,
    cmparameter_read_permission_set,
}

cmparameter_read_permission_get :: proc(cmparameter: CMParameter) -> (read_permission: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_read_permission_set :: proc(cmparameter: CMParameter, read_permission: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(read_permission)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_write_permission :: proc {
    cmparameter_write_permission_get,
    cmparameter_write_permission_set,
}

cmparameter_write_permission_get :: proc(cmparameter: CMParameter) -> (write_permission: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_write_permission_set :: proc(cmparameter: CMParameter, write_permission: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(write_permission)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_authentication_level :: proc {
    cmparameter_authentication_level_get,
    cmparameter_authentication_level_set,
}

cmparameter_authentication_level_get :: proc(cmparameter: CMParameter) -> (authentication_level: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_authentication_level_set :: proc(cmparameter: CMParameter, authentication_level: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(authentication_level)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_batch_property :: proc {
    cmparameter_batch_property_get,
    cmparameter_batch_property_set,
}

cmparameter_batch_property_get :: proc(cmparameter: CMParameter) -> (batch_property: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->BatchPropertyGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_batch_property_set :: proc(cmparameter: CMParameter, batch_property: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(batch_property)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->BatchPropertyPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_auto_point :: proc {
    cmparameter_auto_point_get,
    cmparameter_auto_point_set,
}

cmparameter_auto_point_get :: proc(cmparameter: CMParameter) -> (auto_point: AutoPoint, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointGet(cast(^rawptr)&auto_point)
    if com.failed(hr) do return
    
    return auto_point, true
}

cmparameter_auto_point_set :: proc(cmparameter: CMParameter, auto_point: AutoPoint) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointPut(auto_point)
    if com.failed(hr) do return
    
    return true
}

cmparameter_graph_nodes :: proc {
    cmparameter_graph_nodes_get,
    cmparameter_graph_nodes_set,
}

cmparameter_graph_nodes_get :: proc(cmparameter: CMParameter) -> (graph_nodes: GraphNodes, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com.failed(hr) do return
    
    return graph_nodes, true
}

cmparameter_graph_nodes_set :: proc(cmparameter: CMParameter, graph_nodes: GraphNodes) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesPut(graph_nodes)
    if com.failed(hr) do return
    
    return true
}

cmparameter_type_guid_get :: proc(cmparameter: CMParameter) -> (guid: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeGuid(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_type_path_get :: proc(cmparameter: CMParameter) -> (path: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypePath(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_access_level :: proc {
    cmparameter_access_level_get,
    cmparameter_access_level_set,
}

cmparameter_access_level_get :: proc(cmparameter: CMParameter) -> (access_level: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_access_level_set :: proc(cmparameter: CMParameter, access_level: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(access_level)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_safety_type :: proc {
    cmparameter_safety_type_get,
    cmparameter_safety_type_set,
}

cmparameter_safety_type_get :: proc(cmparameter: CMParameter) -> (safety_type: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypeGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_safety_type_set :: proc(cmparameter: CMParameter, safety_type: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(safety_type)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_direction :: proc {
    cmparameter_direction_get,
    cmparameter_direction_set,
}

cmparameter_direction_get :: proc(cmparameter: CMParameter) -> (direction: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_direction_set :: proc(cmparameter: CMParameter, direction: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(direction)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_fdport :: proc {
    cmparameter_fdport_get,
    cmparameter_fdport_set,
}

cmparameter_fdport_get :: proc(cmparameter: CMParameter) -> (fdport: string, ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmparameter_fdport_set :: proc(cmparameter: CMParameter, fdport: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(fdport)
    defer com.bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmparameter_release :: proc(cmparameter: CMParameter) {
    if cmparameter != nil {
        (^CMParameterIF)(cmparameter)->Release()
    }
}
