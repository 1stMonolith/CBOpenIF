package com

GraphNodes :: distinct rawptr
GraphNode  :: distinct rawptr
GraphPos   :: distinct rawptr
GraphSize  :: distinct rawptr
Points     :: distinct rawptr
Point      :: distinct rawptr
AutoPoint  :: distinct rawptr

GraphNodesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphNodesVTable,
}

GraphNodesVTable :: struct
{
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

AddGraphNode :: proc {
    _AddGraphNode,
    _AddGraphNodeAtIndex,
}

_AddGraphNode :: proc(graphnodes: GraphNodes, graphnode: GraphNode) -> (ok: bool)
{
    if graphnodes == nil do return
    if graphnode == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Add(graphnode)
    if ComFailed(hr) do return
    
    return true
}

_AddGraphNodeAtIndex :: proc(graphnodes: GraphNodes, graphnode: GraphNode, index: i32) -> (ok: bool)
{
    if graphnodes == nil do return
    if graphnode == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->AddBefore(graphnode, index)
    if ComFailed(hr) do return
    
    return true
}

GetGraphNode :: proc {
    _GetGraphNodeWithName,
    _GetGraphNodeAtIndex,
}

_GetGraphNodeWithName :: proc(graphnodes: GraphNodes, name: string) -> (graphnode: GraphNode, ok: bool)
{
    if graphnodes == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->Find(bstr_name, cast(^rawptr)&graphnode)
    if ComFailed(hr) do return
    
    return graphnode, true
}

_GetGraphNodeAtIndex :: proc(graphnodes: GraphNodes, index: i32) -> (graphnode: GraphNode, ok: bool)
{
    if graphnodes == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Item(index + 1, cast(^rawptr)&graphnode)
    if ComFailed(hr) do return
    
    return graphnode, true
}

GraphNodeIndex :: proc(graphnodes: GraphNodes, name: string) -> (index: i32, ok: bool)
{
    if graphnodes == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

GraphNodeCount :: proc(graphnodes: GraphNodes) -> (count: i32, ok: bool)
{
    if graphnodes == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveGraphNode :: proc {
    _RemoveGraphNodeWithName,
    _RemoveGraphNodeAtIndex,
}

_RemoveGraphNodeWithName :: proc(graphnodes: GraphNodes, name: string) -> (ok: bool)
{
    if graphnodes == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = GraphNodeIndex(graphnodes, name)
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveGraphNodeAtIndex :: proc(graphnodes: GraphNodes, index: i32) -> (ok: bool)
{
    if graphnodes == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseGraphNodes :: proc(graphnodes: GraphNodes) {
    if graphnodes != nil {
        (^GraphNodesIF)(graphnodes)->Release()
    }
}

GraphNodeIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphNodeVTable,
}

GraphNodeVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet: proc "system" (this: ^GraphNodeIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^GraphNodeIF, Name: BStr) -> HResult,
    XGet:    proc "system" (this: ^GraphNodeIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^GraphNodeIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^GraphNodeIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^GraphNodeIF, Y: f64) -> HResult,
}

GetGraphNodeName :: proc(graphnode: GraphNode) -> (name: string, ok: bool)
{
    if graphnode == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GraphNodeIF)(graphnode)->NameGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGraphNodeName :: proc(graphnode: GraphNode, name: string) -> (ok: bool)
{
    if graphnode == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^GraphNodeIF)(graphnode)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGraphNodeX :: proc(graphnode: GraphNode) -> (x: f64, ok: bool)
{
    if graphnode == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XGet(&x)
    if ComFailed(hr) do return
    
    return x, true
}

SetGraphNodeX :: proc(graphnode: GraphNode, x: f64) -> (ok: bool)
{
    if graphnode == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XPut(x)
    if ComFailed(hr) do return
    
    return true
}

GetGraphNodeY :: proc(graphnode: GraphNode) -> (y: f64, ok: bool)
{
    if graphnode == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YGet(&y)
    if ComFailed(hr) do return
    
    return y, true
}

SetGraphNodeY :: proc(graphnode: GraphNode, y: f64) -> (ok: bool)
{
    if graphnode == nil do return
    if !ComConnected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YPut(y)
    if ComFailed(hr) do return
    
    return true
}

ReleaseGraphNode :: proc(graphnode: GraphNode)
{
    if graphnode != nil {
        (^GraphNodeIF)(graphnode)->Release()
    }
}

GraphPosIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphPosVTable,
}

GraphPosVTable :: struct
{
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

GetGraphPosX :: proc(graphpos: GraphPos) -> (x: f64, ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->XGet(&x)
    if ComFailed(hr) do return
    
    return x, true
}

SetGraphPosX :: proc(graphpos: GraphPos, x: f64) -> (ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->XPut(x)
    if ComFailed(hr) do return
    
    return true
}

GetGraphPosY :: proc(graphpos: GraphPos) -> (y: f64, ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->YGet(&y)
    if ComFailed(hr) do return
    
    return y, true
}

SetGraphPosY :: proc(graphpos: GraphPos, y: f64) -> (ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->YPut(y)
    if ComFailed(hr) do return
    
    return true
}

GetGraphPosRotation :: proc(graphpos: GraphPos) -> (rotation: f64, ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationGet(&rotation)
    if ComFailed(hr) do return
    
    return rotation, true
}

SetGraphPosRotation :: proc(graphpos: GraphPos, rotation: f64) -> (ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationPut(rotation)
    if ComFailed(hr) do return
    
    return true
}

GetGraphPosXScale :: proc(graphpos: GraphPos) -> (xscale: f64, ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScaleGet(&xscale)
    if ComFailed(hr) do return
    
    return xscale, true
}

SetGraphPosXScale :: proc(graphpos: GraphPos, xscale: f64) -> (ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScalePut(xscale)
    if ComFailed(hr) do return
    
    return true
}

GetGraphPosYScale :: proc(graphpos: GraphPos) -> (yscale: f64, ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScaleGet(&yscale)
    if ComFailed(hr) do return
    
    return yscale, true
}

SetGraphPosYScale :: proc(graphpos: GraphPos, yscale: f64) -> (ok: bool)
{
    if graphpos == nil do return
    if !ComConnected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScalePut(yscale)
    if ComFailed(hr) do return
    
    return true
}

ReleaseGraphPos :: proc(graphpos: GraphPos) {
    if graphpos != nil {
        (^GraphPosIF)(graphpos)->Release()
    }
}

GraphSizeIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GraphSizeVTable,
}

GraphSizeVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    LowerLeftGet:  proc "system" (this: ^GraphSizeIF, LowerLeft: ^rawptr) -> HResult,
    Missing8:      proc "system" (this: ^GraphSizeIF) -> HResult,
    LowerLeftPut:  proc "system" (this: ^GraphSizeIF, LowerLeft: rawptr) -> HResult,
    UpperRightGet: proc "system" (this: ^GraphSizeIF, UpperRight: ^rawptr) -> HResult,
    Missing11:     proc "system" (this: ^GraphSizeIF) -> HResult,
    UpperRightPut: proc "system" (this: ^GraphSizeIF, UpperRight: rawptr) -> HResult,
}

GetGraphSizeLowerLeft :: proc(graphsize: GraphSize) -> (lower_left: Point, ok: bool)
{
    if graphsize == nil do return
    if !ComConnected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftGet(cast(^rawptr)&lower_left)
    if ComFailed(hr) do return
    
    return lower_left, true
}

SetGraphSizeLowerLeft :: proc(graphsize: GraphSize, lower_left: Point) -> (ok: bool)
{
    if graphsize == nil do return
    if !ComConnected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftPut(lower_left)
    if ComFailed(hr) do return
    
    return true
}

GetGraphSizeUpperRight :: proc(graphsize: GraphSize) -> (upper_right: Point, ok: bool)
{
    if graphsize == nil do return
    if !ComConnected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightGet(cast(^rawptr)&upper_right)
    if ComFailed(hr) do return
    
    return upper_right, true
}

SetGraphSizeUpperRight :: proc(graphsize: GraphSize, upper_right: Point) -> (ok: bool)
{
    if graphsize == nil do return
    if !ComConnected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightPut(upper_right)
    if ComFailed(hr) do return
    
    return true
}

ReleaseGraphSize :: proc(graphsize: GraphSize)
{
    if graphsize != nil {
        (^GraphSizeIF)(graphsize)->Release()
    }
}

PointsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PointsVTable,
}

PointsVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^PointsIF, Point: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^PointsIF, Point: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^PointsIF, X, Y: f64, Point: ^rawptr) -> HResult,
    Item:      proc "system" (this: ^PointsIF, Index: i32, Point: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^PointsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^PointsIF, Index: i32) -> HResult,
}

AddPoint :: proc {
    _AddPoint,
    _AddPointAtIndex,
}

_AddPoint :: proc(points: Points, point: Point) -> (ok: bool)
{
    if points == nil do return
    if point == nil do return
    if !ComConnected() do return
    
    hr := (^PointsIF)(points)->Add(point)
    if ComFailed(hr) do return
    
    return true
}

_AddPointAtIndex :: proc(points: Points, point: Point, index: i32) -> (ok: bool)
{
    if points == nil do return
    if point == nil do return
    if !ComConnected() do return
    
    hr := (^PointsIF)(points)->AddBefore(point, index)
    if ComFailed(hr) do return
    
    return true
}

GetPointAtIndex :: proc(points: Points, index: i32) -> (point: Point, ok: bool)
{
    if points == nil do return
    if !ComConnected() do return
    
    hr := (^PointsIF)(points)->Item(index + 1, cast(^rawptr)&point)
    if ComFailed(hr) do return
    
    return point, true
}

PointCount :: proc(points: Points) -> (count: i32, ok: bool)
{
    if points == nil do return
    if !ComConnected() do return
    
    hr := (^PointsIF)(points)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemovePoint :: proc(points: Points, index: i32) -> (ok: bool)
{
    if points == nil do return
    if !ComConnected() do return
    
    hr := (^PointsIF)(points)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleasePoints :: proc(points: Points)
{
    if points != nil {
        (^PointsIF)(points)->Release()
    }
}

PointIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PointVTable,
}

PointVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    XGet:    proc "system" (this: ^PointIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^PointIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^PointIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^PointIF, Y: f64) -> HResult,
}

GetPointX :: proc(point: Point) -> (x: f64, ok: bool)
{
    if point == nil do return
    if !ComConnected() do return
    
    hr := (^PointIF)(point)->XGet(&x)
    if ComFailed(hr) do return
    
    return x, true
}

SetPointX :: proc(point: Point, x: f64) -> (ok: bool)
{
    if point == nil do return
    if !ComConnected() do return
    
    hr := (^PointIF)(point)->XPut(x)
    if ComFailed(hr) do return
    
    return true
}

GetPointY :: proc(point: Point) -> (y: f64, ok: bool)
{
    if point == nil do return
    if !ComConnected() do return
    
    hr := (^PointIF)(point)->YGet(&y)
    if ComFailed(hr) do return
    
    return y, true
}

SetPointY :: proc(point: Point, y: f64) -> (ok: bool)
{
    if point == nil do return
    if !ComConnected() do return
    
    hr := (^PointIF)(point)->YPut(y)
    if ComFailed(hr) do return
    
    return true
}

ReleasePoint :: proc(point: Point)
{
    if point != nil {
        (^PointIF)(point)->Release()
    }
}

AutoPointIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^AutoPointVTable,
}

AutoPointVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    AutoPosGet: proc "system" (this: ^AutoPointIF, AutoPos: ^i32) -> HResult,
    AutoPosPut: proc "system" (this: ^AutoPointIF, AutoPos: i32) -> HResult,
}

GetAutoPointAutoPosition :: proc(autopoint: AutoPoint) -> (position: i32, ok: bool)
{
    if autopoint == nil do return
    if !ComConnected() do return
    
    apt: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&apt)
    if ComFailed(hr) do return

    if !ok do return
    
    return apt, true
}

SetAutoPointAutoPosition :: proc(autopoint: AutoPoint, position: i32) -> (ok: bool)
{
    if autopoint == nil do return
    if !ComConnected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(position)
    if ComFailed(hr) do return
    
    return true
}

ReleaseAutoPoint :: proc(autopoint: AutoPoint)
{
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}
