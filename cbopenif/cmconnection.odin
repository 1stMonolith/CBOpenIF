package cbopenif

CMConnection :: distinct rawptr

CMConnectionIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^CMConnectionVTable,
}

CMConnectionVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    NameGet:                proc "system" (this: ^CMConnectionIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^CMConnectionIF, Name: BStr) -> HResult,
    ActualParameterGet:     proc "system" (this: ^CMConnectionIF, ActualParameter: ^BStr) -> HResult,
    ActualParameterPut:     proc "system" (this: ^CMConnectionIF, ActualParameter: BStr) -> HResult,
    GraphicalConnectionGet: proc "system" (this: ^CMConnectionIF, GraphicalConnection: ^VariantBool) -> HResult,
    GraphicalConnectionSet: proc "system" (this: ^CMConnectionIF, GraphicalConnection: VariantBool) -> HResult,
    PointsGet:              proc "system" (this: ^CMConnectionIF, Point: ^Points) -> HResult,
    PointsPut:              proc "system" (this: ^CMConnectionIF, Point: Points) -> HResult,
    Missing14:              proc "system" (this: ^CMConnectionIF) -> HResult,
    Serialize:              proc "system" (this: ^CMConnectionIF, XML: ^BStr) -> HResult,
}

cmconnection_new :: proc(name: string, actual_parameter: string, graphical_connection: bool) -> (cmconnection: CMConnection, ok: bool) {
    cmconnection = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_actual_parameter := string_to_bstr(actual_parameter)
    defer {
        SysFreeString(bstr_name)
        SysFreeString(bstr_actual_parameter)
    }
    hr := factoryif->NewCMConnection1(bstr_name, bstr_actual_parameter, bool_to_variantbool(graphical_connection), cast(^CMConnection)&cmconnection)
    if failed(hr) do return
    
    return cmconnection, true
}

cmconnection_deserialize :: proc(cmconnection: ^CMConnection, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    BStr := string_to_bstr(xml)
    defer SysFreeString(BStr)
    hr := factoryif->DeserializeCMConnection(&BStr, cast(^CMConnection)cmconnection)
    if failed(hr) do return
    
    return true
}

cmconnection_serialize :: proc(cmconnection: CMConnection) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if cmconnection == nil do return
    if !connected() do return
    
    BStr: BStr
    defer SysFreeString(BStr)
    hr := (^CMConnectionIF)(cmconnection)->Serialize(&BStr)
    if failed(hr) do return
    
    return bstr_to_string(BStr), true
}

cmconnection_name :: proc {
    cmconnection_name_,
    cmconnection_name_set,
}

@(private)
cmconnection_name_ :: proc(cmconnection: CMConnection) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if cmconnection == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMConnectionIF)(cmconnection)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
cmconnection_name_set :: proc(cmconnection: CMConnection, name: string) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer SysFreeString(bstr)
    hr := (^CMConnectionIF)(cmconnection)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

cmconnection_actual_parameter :: proc {
    cmconnection_actual_parameter_,
    cmconnection_actual_parameter_set,
}

@(private)
cmconnection_actual_parameter_ :: proc(cmconnection: CMConnection) -> (actual_parameter: string, ok: bool) {
    actual_parameter = ""
    ok = false

    if cmconnection == nil do return
    if !connected() do return
    
    bstr: BStr
    defer SysFreeString(bstr)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
cmconnection_actual_parameter_set :: proc(cmconnection: CMConnection, actual_parameter: string) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !connected() do return

    bstr := string_to_bstr(actual_parameter)
    defer SysFreeString(bstr)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterPut(bstr)
    if failed(hr) do return
    
    return true
}

cmconnection_graphical_connection :: proc {
    cmconnection_graphical_connection_,
    cmconnection_graphical_connection_set,
}

@(private)
cmconnection_graphical_connection_ :: proc(cmconnection: CMConnection) -> (graphical_connection: bool, ok: bool) {
    graphical_connection = false
    ok = false

    if cmconnection == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

@(private)
cmconnection_graphical_connection_set :: proc(cmconnection: CMConnection, graphical_connection: bool) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !connected() do return

    vb := bool_to_variantbool(graphical_connection)
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionSet(vb)
    if failed(hr) do return
    
    return true
}

cmconnection_points :: proc {
    cmconnection_points_,
    cmconnection_points_set,
}

@(private)
cmconnection_points_ :: proc(cmconnection: CMConnection) -> (points: Points, ok: bool) {
    points = nil
    ok = false

    if cmconnection == nil do return
    if !connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsGet(&points)
    if failed(hr) do return

    return points, true
}

@(private)
cmconnection_points_set :: proc(cmconnection: CMConnection, points: Points) -> (ok: bool) {
    ok = false

    if cmconnection == nil do return
    if !connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsPut(points)
    if failed(hr) do return
    
    return true
}

cmconnection_release :: proc(cmconnection: CMConnection) {
    if cmconnection != nil {
        (^CMConnectionIF)(cmconnection)->Release()
    }
}
