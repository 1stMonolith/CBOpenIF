package cmconnection

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

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
    PointsGet:              proc "system" (this: ^CMConnectionIF, Point: ^rawptr) -> HResult,
    PointsPut:              proc "system" (this: ^CMConnectionIF, Point: rawptr) -> HResult,
    Missing14:              proc "system" (this: ^CMConnectionIF) -> HResult,
    Serialize:              proc "system" (this: ^CMConnectionIF, XML: ^BStr) -> HResult,
}

cmconnection_new :: proc(name: string, actual_parameter: string, graphical_connection: bool) -> (cmconnection: rawptr, ok: bool) {
    cmconnection = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_actual_parameter := bstr.from_string(actual_parameter)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_actual_parameter)
    }
    hr := factory.factoryif->NewCMConnection1(bstr_name, bstr_actual_parameter, variant.bool_to_variantbool(graphical_connection), cast(^rawptr)&cmconnection)
    if com.failed(hr) do return
    
    return cmconnection, true
}

cmconnection_deserialize :: proc(cmconnection: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeCMConnection(&bs, cast(^rawptr)cmconnection)
    if com.failed(hr) do return
    
    return true
}

cmconnection_serialize :: proc(cmconnection: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMConnectionIF)(cmconnection)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

cmconnection_name :: proc {
    cmconnection_name_,
    cmconnection_name_set,
}

@(private)
cmconnection_name_ :: proc(cmconnection: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
cmconnection_name_set :: proc(cmconnection: rawptr, name: string) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

cmconnection_actual_parameter :: proc {
    cmconnection_actual_parameter_,
    cmconnection_actual_parameter_set,
}

@(private)
cmconnection_actual_parameter_ :: proc(cmconnection: rawptr) -> (actual_parameter: string, ok: bool) {
    actual_parameter = ""
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
cmconnection_actual_parameter_set :: proc(cmconnection: rawptr, actual_parameter: string) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(actual_parameter)
    defer bstr.free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterPut(bs)
    if com.failed(hr) do return
    
    return true
}

cmconnection_graphical_connection :: proc {
    cmconnection_graphical_connection_,
    cmconnection_graphical_connection_set,
}

@(private)
cmconnection_graphical_connection_ :: proc(cmconnection: rawptr) -> (graphical_connection: bool, ok: bool) {
    graphical_connection = false
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

@(private)
cmconnection_graphical_connection_set :: proc(cmconnection: rawptr, graphical_connection: bool) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return

    vb := variant.bool_to_variantbool(graphical_connection)
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionPut(vb)
    if com.failed(hr) do return
    
    return true
}

cmconnection_points :: proc {
    cmconnection_points_,
    cmconnection_points_set,
}

@(private)
cmconnection_points_ :: proc(cmconnection: rawptr) -> (points: rawptr, ok: bool) {
    points = nil
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsGet(&points)
    if com.failed(hr) do return

    return points, true
}

@(private)
cmconnection_points_set :: proc(cmconnection: rawptr, points: rawptr) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !controlbuilder.connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsPut(points)
    if com.failed(hr) do return
    
    return true
}

cmconnection_release :: proc(cmconnection: rawptr) {
    if cmconnection != nil {
        (^CMConnectionIF)(cmconnection)->Release()
    }
}
