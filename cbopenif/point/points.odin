package point

import "../com"
import "../controlbuilder"

Points :: distinct rawptr

PointsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^PointsVTable,
}

PointsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^PointsIF, Point: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^PointsIF, Point: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^PointsIF, X, Y: f64, Point: ^rawptr) -> HResult,
    Item:      proc "system" (this: ^PointsIF, Index: i32, Point: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^PointsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^PointsIF, Index: i32) -> HResult,
}

points_add :: proc {
    points_add_,
    points_add_at_index,
}

points_add_ :: proc(points: Points, point: Point) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if points == nil do return
    if point == nil do return
    
    hr := (^PointsIF)(points)->Add(point)
    if com.failed(hr) do return
    
    return true
}

points_add_at_index :: proc(points: Points, point: Point, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if points == nil do return
    if point == nil do return
    
    hr := (^PointsIF)(points)->AddBefore(point, index)
    if com.failed(hr) do return
    
    return true
}

points_point_by_index :: proc(points: Points, index: i32) -> (point: Point, ok: bool) {

    if !controlbuilder.connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Item(index, cast(^rawptr)&point)
    if com.failed(hr) do return
    
    return point, true
}

points_count :: proc(points: Points) -> (count: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

points_remove_by_index :: proc(points: Points, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

points_release :: proc(points: Points) {
    if points != nil {
        (^PointsIF)(points)->Release()
    }
}
