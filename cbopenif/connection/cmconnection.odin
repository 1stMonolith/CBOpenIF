package connection

import "../com"
import "../controlbuilder"
import "../factory"
import "../point"

@(private="file") BStr        :: com.BStr
@(private="file") HResult     :: com.HResult
@(private="file") Points      :: point.Points
@(private="file") VariantBool :: com.VariantBool

CMConnection :: distinct rawptr

CMConnectionIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^CMConnectionVTable,
}

CMConnectionVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:                proc "system" (this: ^CMConnectionIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^CMConnectionIF, Name: BStr) -> HResult,
    ActualParameterGet:     proc "system" (this: ^CMConnectionIF, ActualParameter: ^BStr) -> HResult,
    ActualParameterPut:     proc "system" (this: ^CMConnectionIF, ActualParameter: BStr) -> HResult,
    GraphicalConnectionGet: proc "system" (this: ^CMConnectionIF, GraphicalConnection: ^VariantBool) -> HResult,
    GraphicalConnectionPut: proc "system" (this: ^CMConnectionIF, GraphicalConnection: VariantBool) -> HResult,
    PointsGet:              proc "system" (this: ^CMConnectionIF, Points: ^rawptr) -> HResult,
    PointsPut:              proc "system" (this: ^CMConnectionIF, Points: rawptr) -> HResult,
    Missing14:              proc "system" (this: ^CMConnectionIF) -> HResult,
    Serialize:              proc "system" (this: ^CMConnectionIF, XML: ^BStr) -> HResult,
}

cmconnection_new :: proc(name: string, actual_parameter: string, graphical_connection: bool) -> (cmconnection: CMConnection, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    bstr_actual_parameter := com.from_string(actual_parameter)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_actual_parameter)
    }
    hr := factory.factoryif->NewCMConnection1(bstr_name, bstr_actual_parameter, com.bool_to_variantbool(graphical_connection), cast(^rawptr)&cmconnection)
    if com.failed(hr) do return
    
    return cmconnection, true
}

cmconnection_deserialize :: proc(cmconnection: ^CMConnection, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeCMConnection(&bs, cast(^rawptr)cmconnection)
    if com.failed(hr) do return
    
    return true
}

cmconnection_serialize :: proc(cmconnection: CMConnection) -> (xml: string, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->Serialize(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

cmconnection_name :: proc {
    cmconnection_name_get,
    cmconnection_name_set,
}

cmconnection_name_get :: proc(cmconnection: CMConnection) -> (name: string, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

cmconnection_name_set :: proc(cmconnection: CMConnection, name: string) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmconnection_actual_parameter :: proc {
    cmconnection_actual_parameter_get,
    cmconnection_actual_parameter_set,
}

cmconnection_actual_parameter_get :: proc(cmconnection: CMConnection) -> (actual_parameter: string, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

cmconnection_actual_parameter_set :: proc(cmconnection: CMConnection, actual_parameter: string) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(actual_parameter)
    defer com.bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmconnection_graphical_connection :: proc {
    cmconnection_graphical_connection_get,
    cmconnection_graphical_connection_set,
}

cmconnection_graphical_connection_get :: proc(cmconnection: CMConnection) -> (graphical_connection: bool, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionGet(&vb)
    if com.failed(hr) do return

    return com.variantbool_to_bool(vb), true
}

cmconnection_graphical_connection_set :: proc(cmconnection: CMConnection, graphical_connection: bool) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb := com.bool_to_variantbool(graphical_connection)
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionPut(vb)
    if com.failed(hr) do return
    
    return true
}

cmconnection_points :: proc {
    cmconnection_points_get,
    cmconnection_points_set,
}

cmconnection_points_get :: proc(cmconnection: CMConnection) -> (points: Points, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    p: rawptr
    hr := (^CMConnectionIF)(cmconnection)->PointsGet(&p)
    if com.failed(hr) do return

    return Points(p), true
}

cmconnection_points_set :: proc(cmconnection: CMConnection, points: Points) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsPut(points)
    if com.failed(hr) do return
    
    return true
}

cmconnection_release :: proc(cmconnection: CMConnection) {
    if cmconnection != nil {
        (^CMConnectionIF)(cmconnection)->Release()
    }
}
