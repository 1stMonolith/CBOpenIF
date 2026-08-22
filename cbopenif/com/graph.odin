package com

GraphNode  :: distinct rawptr
GraphNodes :: distinct rawptr
GraphPos   :: distinct rawptr
GraphSize  :: distinct rawptr
Point      :: distinct rawptr
Points     :: distinct rawptr
AutoPoint  :: distinct rawptr

GraphNodeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphNodeVTable,
}

GraphNodeVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet: proc "system" (this: ^GraphNodeIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^GraphNodeIF, Name: BStr) -> HResult,
    XGet:    proc "system" (this: ^GraphNodeIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^GraphNodeIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^GraphNodeIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^GraphNodeIF, Y: f64) -> HResult,
}

graphnode_name_get :: proc(graphnode: GraphNode) -> (name: string, ok: bool) {
    if graphnode == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GraphNodeIF)(graphnode)->NameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

graphnode_name_set :: proc(graphnode: GraphNode, name: string) -> (ok: bool) {
    if graphnode == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^GraphNodeIF)(graphnode)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

graphnode_x_get :: proc(graphnode: GraphNode) -> (x: f64, ok: bool) {
    if graphnode == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XGet(&x)
    if com_failed(hr) do return
    
    return x, true
}

graphnode_x_set :: proc(graphnode: GraphNode, x: f64) -> (ok: bool) {
    if graphnode == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XPut(x)
    if com_failed(hr) do return
    
    return true
}

graphnode_y_get :: proc(graphnode: GraphNode) -> (y: f64, ok: bool) {
    if graphnode == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YGet(&y)
    if com_failed(hr) do return
    
    return y, true
}

graphnode_y_set :: proc(graphnode: GraphNode, y: f64) -> (ok: bool) {
    if graphnode == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YPut(y)
    if com_failed(hr) do return
    
    return true
}

graphnode_release :: proc(graphnode: GraphNode) {
    if graphnode != nil {
        (^GraphNodeIF)(graphnode)->Release()
    }
}

GraphNodesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphNodesVTable,
}

GraphNodesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^GraphNodesIF, GraphNode: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^GraphNodesIF, GraphNode: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^GraphNodesIF, Name: BStr, X, Y: f64, GraphNode: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^GraphNodesIF, Name: BStr, GraphNode: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^GraphNodesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^GraphNodesIF, Index: i32, GraphNode: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^GraphNodesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^GraphNodesIF, Index: i32) -> HResult,
}

graphnodes_graphnode_add :: proc(graphnodes: GraphNodes, graphnode: GraphNode) -> (ok: bool) {
    if graphnodes == nil do return
    if graphnode == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Add(graphnode)
    if com_failed(hr) do return
    
    return true
}

graphnodes_graphnode_add_at_index :: proc(graphnodes: GraphNodes, graphnode: GraphNode, index: i32) -> (ok: bool) {
    if graphnodes == nil do return
    if graphnode == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->AddBefore(graphnode, index)
    if com_failed(hr) do return
    
    return true
}

graphnodes_graphnode_by_name :: proc(graphnodes: GraphNodes, name: string) -> (graphnode: GraphNode, ok: bool) {
    if graphnodes == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->Find(bstr_name, cast(^rawptr)&graphnode)
    if com_failed(hr) do return
    
    return graphnode, true
}

graphnodes_graphnode_by_index :: proc(graphnodes: GraphNodes, index: i32) -> (graphnode: GraphNode, ok: bool) {
    if graphnodes == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Item(index + 1, cast(^rawptr)&graphnode)
    if com_failed(hr) do return
    
    return graphnode, true
}

graphnodes_graphnode_index :: proc(graphnodes: GraphNodes, name: string) -> (index: i32, ok: bool) {
    if graphnodes == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

graphnodes_graphnode_count :: proc(graphnodes: GraphNodes) -> (count: i32, ok: bool) {
    if graphnodes == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

graphnodes_graphnode_remove_by_name :: proc(graphnodes: GraphNodes, name: string) -> (ok: bool) {
    if graphnodes == nil do return
    if !com_connected() do return

    index: i32
    index, ok = graphnodes_graphnode_index(graphnodes, name)
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

graphnodes_graphnode_remove_by_index :: proc(graphnodes: GraphNodes, index: i32) -> (ok: bool) {
    if graphnodes == nil do return
    if !com_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

graphnodes_release :: proc(graphnodes: GraphNodes) {
    if graphnodes != nil {
        (^GraphNodesIF)(graphnodes)->Release()
    }
}

GraphPosIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphPosVTable,
}

GraphPosVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    XGet:        proc "system" (this: ^GraphPosIF, X: ^f64) -> HResult,
    XPut:        proc "system" (this: ^GraphPosIF, X: f64) -> HResult,
    YGet:        proc "system" (this: ^GraphPosIF, Y: ^f64) -> HResult,
    YPut:        proc "system" (this: ^GraphPosIF, Y: f64) -> HResult,
    RotationGet: proc "system" (this: ^GraphPosIF, Rotation: ^f64) -> HResult,
    RotationPut: proc "system" (this: ^GraphPosIF, Rotation: f64) -> HResult,
    XScaleGet:   proc "system" (this: ^GraphPosIF, XScale: ^f64) -> HResult,
    XScalePut:   proc "system" (this: ^GraphPosIF, XScale: f64) -> HResult,
    YScaleGet:   proc "system" (this: ^GraphPosIF, YScale: ^f64) -> HResult,
    YScalePut:   proc "system" (this: ^GraphPosIF, YScale: f64) -> HResult,
}

graphpos_x_get :: proc(graphpos: GraphPos) -> (x: f64, ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XGet(&x)
    if com_failed(hr) do return
    
    return x, true
}

graphpos_x_set :: proc(graphpos: GraphPos, x: f64) -> (ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XPut(x)
    if com_failed(hr) do return
    
    return true
}

graphpos_y_get :: proc(graphpos: GraphPos) -> (y: f64, ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YGet(&y)
    if com_failed(hr) do return
    
    return y, true
}

graphpos_y_set :: proc(graphpos: GraphPos, y: f64) -> (ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YPut(y)
    if com_failed(hr) do return
    
    return true
}

graphpos_rotation_get :: proc(graphpos: GraphPos) -> (rotation: f64, ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationGet(&rotation)
    if com_failed(hr) do return
    
    return rotation, true
}

graphpos_rotation_set :: proc(graphpos: GraphPos, rotation: f64) -> (ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationPut(rotation)
    if com_failed(hr) do return
    
    return true
}

graphpos_xscale_get :: proc(graphpos: GraphPos) -> (xscale: f64, ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScaleGet(&xscale)
    if com_failed(hr) do return
    
    return xscale, true
}

graphpos_xscale_set :: proc(graphpos: GraphPos, xscale: f64) -> (ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScalePut(xscale)
    if com_failed(hr) do return
    
    return true
}

graphpos_yscale_get :: proc(graphpos: GraphPos) -> (yscale: f64, ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScaleGet(&yscale)
    if com_failed(hr) do return
    
    return yscale, true
}

graphpos_yscale_set :: proc(graphpos: GraphPos, yscale: f64) -> (ok: bool) {
    if graphpos == nil do return
    if !com_connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScalePut(yscale)
    if com_failed(hr) do return
    
    return true
}

graphpos_release :: proc(graphpos: GraphPos) {
    if graphpos != nil {
        (^GraphPosIF)(graphpos)->Release()
    }
}

GraphSizeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphSizeVTable,
}

GraphSizeVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    LowerLeftGet:  proc "system" (this: ^GraphSizeIF, LowerLeft: ^rawptr) -> HResult,
    Missing8:      proc "system" (this: ^GraphSizeIF) -> HResult,
    LowerLeftPut:  proc "system" (this: ^GraphSizeIF, LowerLeft: rawptr) -> HResult,
    UpperRightGet: proc "system" (this: ^GraphSizeIF, UpperRight: ^rawptr) -> HResult,
    Missing11:     proc "system" (this: ^GraphSizeIF) -> HResult,
    UpperRightPut: proc "system" (this: ^GraphSizeIF, UpperRight: rawptr) -> HResult,
}

graphsize_lower_left_get :: proc(graphsize: GraphSize) -> (lower_left: Point, ok: bool) {
    if graphsize == nil do return
    if !com_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftGet(cast(^rawptr)&lower_left)
    if com_failed(hr) do return
    
    return lower_left, true
}

graphsize_lower_left_set :: proc(graphsize: GraphSize, lower_left: Point) -> (ok: bool) {
    if graphsize == nil do return
    if !com_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftPut(lower_left)
    if com_failed(hr) do return
    
    return true
}

graphsize_upper_right_get :: proc(graphsize: GraphSize) -> (upper_right: Point, ok: bool) {
    if graphsize == nil do return
    if !com_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightGet(cast(^rawptr)&upper_right)
    if com_failed(hr) do return
    
    return upper_right, true
}

graphsize_upper_right_set :: proc(graphsize: GraphSize, upper_right: Point) -> (ok: bool) {
    if graphsize == nil do return
    if !com_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightPut(upper_right)
    if com_failed(hr) do return
    
    return true
}

graphsize_release :: proc(graphsize: GraphSize) {
    if graphsize != nil {
        (^GraphSizeIF)(graphsize)->Release()
    }
}

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

AutoPointIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^AutoPointVTable,
}

AutoPointVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    AutoPosGet: proc "system" (this: ^AutoPointIF, AutoPos: ^i32) -> HResult,
    AutoPosPut: proc "system" (this: ^AutoPointIF, AutoPos: i32) -> HResult,
}

autopoint_autopos_get :: proc(autopoint: AutoPoint) -> (position: i32, ok: bool) {
    if autopoint == nil do return
    if !com_connected() do return
    
    apt: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&apt)
    if com_failed(hr) do return

    if !ok do return
    
    return apt, true
}

autopoint_autopos_set :: proc(autopoint: AutoPoint, position: i32) -> (ok: bool) {
    if autopoint == nil do return
    if !com_connected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(position)
    if com_failed(hr) do return
    
    return true
}

autopoint_release :: proc(autopoint: AutoPoint) {
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}
