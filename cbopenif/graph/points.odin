package graph

import "../com"
import "../controlbuilder"

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

@(private)
points_add_ :: proc(points: rawptr, point: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if points == nil do return
    if point == nil do return
    
    hr := (^PointsIF)(points)->Add(point)
    if com.failed(hr) do return
    
    return true
}

points_add_at_index :: proc(points: rawptr, point: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if points == nil do return
    if point == nil do return
    
    hr := (^PointsIF)(points)->AddBefore(point, index)
    if com.failed(hr) do return
    
    return true
}

points_point_by_index :: proc(points: rawptr, index: i32) -> (point: rawptr, ok: bool) {
    point = nil
    ok = false

    if !controlbuilder.connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Item(index, &point)
    if com.failed(hr) do return
    
    return point, true
}

points_count :: proc(points: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

points_remove_by_index :: proc(points: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

points_release :: proc(points: rawptr) {
    if points != nil {
        (^PointsIF)(points)->Release()
    }
}