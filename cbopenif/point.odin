package cbopenif

Point  :: distinct rawptr

PointIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^PointVTable,
}

PointVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    XGet:    proc "system" (this: ^PointIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^PointIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^PointIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^PointIF, Y: f64) -> HResult,
}

point_new :: proc(x, y: f64) -> (point: Point, ok: bool) {
    point = nil
    ok = false

    if !connected() do return

    hr := factoryif->NewPoint(x, y, cast(^Point)&point)
    if failed(hr) do return

    return point, true
}

point_x :: proc {
    point_x_,
    point_x_set,
}

@(private)
point_x_ :: proc(point: Point) -> (x: f64, ok: bool) {
    x = 0
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->XGet(&x)
    if failed(hr) do return
    
    return x, true
}

@(private)
point_x_set :: proc(point: Point, x: f64) -> (ok: bool) {
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->XPut(x)
    if failed(hr) do return
    
    return true
}

point_y :: proc {
    point_y_,
    point_y_set,
}

@(private)
point_y_ :: proc(point: Point) -> (y: f64, ok: bool) {
    y = 0
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->YGet(&y)
    if failed(hr) do return
    
    return y, true
}

@(private)
point_y_set :: proc(point: Point, y: f64) -> (ok: bool) {
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->YPut(y)
    if failed(hr) do return
    
    return true
}

point_release :: proc(point: Point) {
    if point != nil {
        (^PointIF)(point)->Release()
    }
}