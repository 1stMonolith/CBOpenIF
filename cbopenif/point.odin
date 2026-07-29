package cbopenif

Point  :: distinct rawptr

PointIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^PointVTable,
}

PointVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    XGet:    proc "system" (this: ^PointIF, X: ^i64) -> HResult,
    XPut:    proc "system" (this: ^PointIF, X: i64) -> HResult,
    YGet:    proc "system" (this: ^PointIF, Y: ^i64) -> HResult,
    YPut:    proc "system" (this: ^PointIF, Y: i64) -> HResult,
}

point_x :: proc {
    point_x_,
    point_x_set,
}

@(private)
point_x_ :: proc(point: Point) -> (x: i64, ok: bool) {
    x = 0
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->XGet(&x)
    if failed(hr) do return
    
    return x, true
}

@(private)
point_x_set :: proc(point: Point, x: i64) -> (ok: bool) {
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
point_y_ :: proc(point: Point) -> (y: i64, ok: bool) {
    y = 0
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->XGet(&y)
    if failed(hr) do return
    
    return y, true
}

@(private)
point_y_set :: proc(point: Point, y: i64) -> (ok: bool) {
    ok = false

    if point == nil do return
    if !connected() do return
    
    hr := (^PointIF)(point)->XPut(y)
    if failed(hr) do return
    
    return true
}

point_release :: proc(point: Point) {
    if point != nil {
        (^PointIF)(point)->Release()
    }
}