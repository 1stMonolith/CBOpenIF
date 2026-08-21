package com

import t "../types"

GraphNode  :: distinct rawptr
GraphNodes :: distinct rawptr
GraphPos   :: distinct rawptr
GraphSize  :: distinct rawptr

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

graphnode_from_com :: proc(graphnode: GraphNode, allocator := context.allocator) -> (result: t.GraphNode, ok: bool) {
    if graphnode == nil do return

    context.allocator = allocator

    result.name, ok = name(graphnode)
    if !ok do return
    result.x, ok = x(graphnode)
    if !ok do return
    result.y, ok = y(graphnode)
    if !ok do return

    return result, true
}

graphnode_to_com :: proc(src: t.GraphNode) -> (result: GraphNode, ok: bool) {
    graphnode: GraphNode
    graphnode, ok = graphnode_new(src.name, src.x, src.y)
    if !ok do return

    return graphnode, true
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

graphnodes_from_com :: proc(nodes: GraphNodes, allocator := context.allocator) -> (result: [dynamic]t.GraphNode, ok: bool) {
    if nodes == nil do return
    context.allocator = allocator

    count: i32
    count, ok = graphnode_count(nodes)
    if !ok do return

    result = make([dynamic]t.GraphNode, 0, int(count), allocator)
    for i in 0..<count {
        n: GraphNode
        n, ok = graphnode_by_index(nodes, i)
        if !ok do return
        defer release(n)

        ns: t.GraphNode
        ns, ok = graphnode_from_com(n)
        if !ok do return
        append(&result, ns)
    }
    return result, true
}

graphnodes_to_com :: proc(nodes: GraphNodes, src: []t.GraphNode) -> (ok: bool) {
    if nodes == nil do return
    for item in src {
        n: GraphNode
        n, ok = graphnode_to_com(item)
        if !ok do return
        defer release(n)
        ok = graphnode_add(nodes, n)
        if !ok do return
    }
    return true
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

graphpos_from_com :: proc(graphpos: GraphPos, allocator := context.allocator) -> (result: t.GraphPos, ok: bool) {
    if graphpos == nil do return

    context.allocator = allocator

    result.x, ok = x(graphpos)
    if !ok do return
    result.y, ok = y(graphpos)
    if !ok do return
    result.rotation, ok = rotation(graphpos)
    if !ok do return
    result.xscale, ok = xscale(graphpos)
    if !ok do return
    result.yscale, ok = yscale(graphpos)
    if !ok do return

    return result, true
}

graphpos_to_com :: proc(src: t.GraphPos) -> (result: GraphPos, ok: bool) {
    graphpos: GraphPos
    graphpos, ok = graphpos_new(src.x, src.y, src.rotation, src.xscale, src.yscale)
    if !ok do return

    return graphpos, true
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

graphsize_from_com :: proc(graphsize: GraphSize, allocator := context.allocator) -> (result: t.GraphSize, ok: bool) {
    if graphsize == nil do return

    context.allocator = allocator

    ll: Point
    ll, ok = point_lower_left(graphsize)
    if !ok do return
    defer release(ll)

    result.lower_left, ok = point_from_com(ll)
    if !ok do return

    ur: Point
    ur, ok = point_upper_right(graphsize)
    if !ok do return
    defer release(ur)

    result.upper_right, ok = point_from_com(ur)
    if !ok do return

    return result, true
}

graphsize_to_com :: proc(src: t.GraphSize) -> (result: GraphSize, ok: bool) {
    ll: Point
    ll, ok = point_to_com(src.lower_left)
    if !ok do return
    defer release(ll)

    ur: Point
    ur, ok = point_to_com(src.upper_right)
    if !ok do return
    defer release(ur)

    graphsize: GraphSize
    graphsize, ok = graphsize_new(ll, ur)
    if !ok do return

    return graphsize, true
}
