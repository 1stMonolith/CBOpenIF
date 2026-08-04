package point

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") HResult :: com.HResult

Point :: distinct rawptr

PointIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^PointVTable,
}

PointVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    XGet:    proc "system" (this: ^PointIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^PointIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^PointIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^PointIF, Y: f64) -> HResult,
}

point_new :: proc(x, y: f64) -> (point: Point, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    hr := factory.factoryif->NewPoint(x, y, cast(^rawptr)&point)
    if com.failed(hr) do return

    return point, true
}

point_x :: proc {
    point_x_get,
    point_x_set,
}

point_x_get :: proc(point: Point) -> (x: f64, ok: bool) {
    if point == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^PointIF)(point)->XGet(&x)
    if com.failed(hr) do return
    
    return x, true
}

point_x_set :: proc(point: Point, x: f64) -> (ok: bool) {
    if point == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^PointIF)(point)->XPut(x)
    if com.failed(hr) do return
    
    return true
}

point_y :: proc {
    point_y_get,
    point_y_set,
}

point_y_get :: proc(point: Point) -> (y: f64, ok: bool) {
    if point == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^PointIF)(point)->YGet(&y)
    if com.failed(hr) do return
    
    return y, true
}

point_y_set :: proc(point: Point, y: f64) -> (ok: bool) {
    if point == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^PointIF)(point)->YPut(y)
    if com.failed(hr) do return
    
    return true
}

point_release :: proc(point: Point) {
    if point != nil {
        (^PointIF)(point)->Release()
    }
}
