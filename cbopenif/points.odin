package cbopenif

Points :: distinct rawptr

PointsIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^PointsVTable,
}

PointsVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    Add:       proc "system" (this: ^PointsIF, Point: Point) -> HResult,
    AddBefore: proc "system" (this: ^PointsIF, Point: Point, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^PointsIF, X, Y: f64, Point: ^Point) -> HResult,
    Item:      proc "system" (this: ^PointsIF, Index: i32, Point: ^Point) -> HResult,
    Count:     proc "system" (this: ^PointsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^PointsIF, Index: i32) -> HResult,
}

points_add :: proc {
    points_add_,
    points_add_at_index,
}

@(private)
points_add_ :: proc(points: Points, point: Point) -> (ok: bool) {
    ok = false

    if !connected() do return
    if points == nil do return
    if point == nil do return
    
    hr := (^PointsIF)(points)->Add(point)
    if failed(hr) do return
    
    return true
}

points_add_at_index :: proc(points: Points, point: Point, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if points == nil do return
    if point == nil do return
    
    hr := (^PointsIF)(points)->AddBefore(point, index)
    if failed(hr) do return
    
    return true
}

points_point_by_index :: proc(points: Points, index: i32) -> (point: Point, ok: bool) {
    point = nil
    ok = false

    if !connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Item(index, &point)
    if failed(hr) do return
    
    return point, true
}

points_count :: proc(points: Points) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

points_remove_by_index :: proc(points: Points, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if points == nil do return
    
    hr := (^PointsIF)(points)->Remove(index)
    if failed(hr) do return
    
    return true
}

points_release :: proc(points: Points) {
    if points != nil {
        (^PointsIF)(points)->Release()
    }
}