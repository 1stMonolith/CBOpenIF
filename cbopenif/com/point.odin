package com

Point  :: distinct rawptr
Points :: distinct rawptr

PointIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PointVTable,
}

PointVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    XGet:    proc "system" (this: ^PointIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^PointIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^PointIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^PointIF, Y: f64) -> HResult,
}

point_x_get :: proc(point: Point) -> (x: f64, ok: bool) {
    if point == nil do return
    if !com_connected() do return
    
    hr := (^PointIF)(point)->XGet(&x)
    if com_failed(hr) do return
    
    return x, true
}

point_x_set :: proc(point: Point, x: f64) -> (ok: bool) {
    if point == nil do return
    if !com_connected() do return
    
    hr := (^PointIF)(point)->XPut(x)
    if com_failed(hr) do return
    
    return true
}

point_y_get :: proc(point: Point) -> (y: f64, ok: bool) {
    if point == nil do return
    if !com_connected() do return
    
    hr := (^PointIF)(point)->YGet(&y)
    if com_failed(hr) do return
    
    return y, true
}

point_y_set :: proc(point: Point, y: f64) -> (ok: bool) {
    if point == nil do return
    if !com_connected() do return
    
    hr := (^PointIF)(point)->YPut(y)
    if com_failed(hr) do return
    
    return true
}

point_release :: proc(point: Point) {
    if point != nil {
        (^PointIF)(point)->Release()
    }
}

PointsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PointsVTable,
}

PointsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^PointsIF, Point: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^PointsIF, Point: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^PointsIF, X, Y: f64, Point: ^rawptr) -> HResult,
    Item:      proc "system" (this: ^PointsIF, Index: i32, Point: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^PointsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^PointsIF, Index: i32) -> HResult,
}

points_point_add :: proc(points: Points, point: Point) -> (ok: bool) {
    if points == nil do return
    if point == nil do return
    if !com_connected() do return
    
    hr := (^PointsIF)(points)->Add(point)
    if com_failed(hr) do return
    
    return true
}

points_point_add_at_index :: proc(points: Points, point: Point, index: i32) -> (ok: bool) {
    if points == nil do return
    if point == nil do return
    if !com_connected() do return
    
    hr := (^PointsIF)(points)->AddBefore(point, index)
    if com_failed(hr) do return
    
    return true
}

points_point_by_index :: proc(points: Points, index: i32) -> (point: Point, ok: bool) {
    if points == nil do return
    if !com_connected() do return
    
    hr := (^PointsIF)(points)->Item(index + 1, cast(^rawptr)&point)
    if com_failed(hr) do return
    
    return point, true
}

points_point_count :: proc(points: Points) -> (count: i32, ok: bool) {
    if points == nil do return
    if !com_connected() do return
    
    hr := (^PointsIF)(points)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

points_point_remove_by_index :: proc(points: Points, index: i32) -> (ok: bool) {
    if points == nil do return
    if !com_connected() do return
    
    hr := (^PointsIF)(points)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

points_release :: proc(points: Points) {
    if points != nil {
        (^PointsIF)(points)->Release()
    }
}
