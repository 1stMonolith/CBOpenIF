package cbopenif

CMConnection :: distinct rawptr

CMConnectionIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMConnectionVTable,
}

CMConnectionVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_actual_parameter := to_bstr(actual_parameter)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_actual_parameter)
    }
    hr := factoryif->NewCMConnection1(bstr_name, bstr_actual_parameter, to_variantbool(graphical_connection), cast(^rawptr)&cmconnection)
    if com_failed(hr) do return
    
    return cmconnection, true
}

cmconnection_deserialize :: proc(xml: string) -> (cmconnection: CMConnection, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeCMConnection(&bs, cast(^rawptr)cmconnection)
    if com_failed(hr) do return
    
    return cmconnection, true
}

cmconnection_serialize :: proc(cmconnection: CMConnection) -> (xml: string, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmconnection_name :: proc {
    cmconnection_name_get,
    cmconnection_name_set,
}

cmconnection_name_get :: proc(cmconnection: CMConnection) -> (name: string, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

cmconnection_name_set :: proc(cmconnection: CMConnection, name: string) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

cmconnection_actual_parameter :: proc {
    cmconnection_actual_parameter_get,
    cmconnection_actual_parameter_set,
}

cmconnection_actual_parameter_get :: proc(cmconnection: CMConnection) -> (actual_parameter: string, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

cmconnection_actual_parameter_set :: proc(cmconnection: CMConnection, actual_parameter: string) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(actual_parameter)
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmconnection_graphical_connection :: proc {
    cmconnection_graphical_connection_get,
    cmconnection_graphical_connection_set,
}

cmconnection_graphical_connection_get :: proc(cmconnection: CMConnection) -> (graphical_connection: bool, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

cmconnection_graphical_connection_set :: proc(cmconnection: CMConnection, graphical_connection: bool) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return

    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionPut(to_variantbool(graphical_connection))
    if com_failed(hr) do return
    
    return true
}

cmconnection_points :: proc {
    cmconnection_points_get,
    cmconnection_points_set,
}

cmconnection_points_get :: proc(cmconnection: CMConnection) -> (points: Points, ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^CMConnectionIF)(cmconnection)->PointsGet(&p)
    if com_failed(hr) do return

    return Points(p), true
}

cmconnection_points_set :: proc(cmconnection: CMConnection, points: Points) -> (ok: bool) {
    if cmconnection == nil do return
    if !controlbuilder_connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsPut(points)
    if com_failed(hr) do return
    
    return true
}

cmconnection_release :: proc(cmconnection: CMConnection) {
    if cmconnection != nil {
        (^CMConnectionIF)(cmconnection)->Release()
    }
}
