package cbopenif

import "com"

GraphicsVisibility :: enum i32
{
    Default   = 0,
    Visible   = 1,
    Invisible = 2,
}

Point :: struct
{
    x: f64,
    y: f64,
}

AutoPoint :: enum i32
{
    Top    = 0,
    Bottom = 1,
    Left   = 2,
    Right  = 3,
}

GraphPos :: struct
{
    pos:      Point,
    scale:    Point,
    rotation: f64,
}

GraphSize :: struct
{
    lower_left:  Point,
    upper_right: Point,
}

GraphNode :: struct
{
    name: string,
    x:    f64,
    y:    f64,
}

GraphNodesFromCom :: proc(comgraphnodes: com.GraphNodes, graphnodes: ^[dynamic]GraphNode) -> (ok: bool)
{
    if comgraphnodes == nil do return

    count: i32
    count, ok = com.GraphNodeCount(comgraphnodes)
    if !ok do return

    for i in 0..<count {
        comgraphnode: com.GraphNode
        comgraphnode, ok = com.GetGraphNode(comgraphnodes, i)
        if !ok do return
        defer com.Release(comgraphnode)

        graphnode: GraphNode
        graphnode, ok = GraphNodeFromCom(comgraphnode)
        if !ok do return
        append(graphnodes, graphnode)
    }

    return true
}

GraphNodeFromCom :: proc(comgraphnode: com.GraphNode) -> (graphnode: GraphNode, ok: bool)
{
    if comgraphnode == nil do return

    graphnode.name, ok = com.Name(comgraphnode)
    if !ok do return

    graphnode.x, ok = com.X(comgraphnode)
    if !ok do return

    graphnode.y, ok = com.Y(comgraphnode)
    if !ok do return

    return graphnode, true
}

GraphNodesToCom :: proc(comgraphnodes: com.GraphNodes, graphnodes: []GraphNode) -> (ok: bool)
{
    if comgraphnodes == nil do return
    
    for graphnode in graphnodes {
        comgraphnode: com.GraphNode
        comgraphnode, ok = GraphNodeToCom(graphnode)
        if !ok do return
        defer com.Release(comgraphnode)

        ok = com.AddGraphNode(comgraphnodes, comgraphnode)
        if !ok do return
    }

    return true
}

GraphNodeToCom :: proc(graphnode: GraphNode) -> (comgraphnode: com.GraphNode, ok: bool)
{
    return com.NewGraphNode(graphnode.name, graphnode.x, graphnode.y)
}

GraphPosFromCom :: proc(comgraphpos: com.GraphPos) -> (graphpos: GraphPos, ok: bool)
{
    if comgraphpos == nil do return

    graphpos.pos.x, ok = com.X(comgraphpos)
    if !ok do return

    graphpos.pos.y, ok = com.Y(comgraphpos)
    if !ok do return

    graphpos.rotation, ok = com.Rotation(comgraphpos)
    if !ok do return

    graphpos.scale.x, ok = com.XScale(comgraphpos)
    if !ok do return

    graphpos.scale.y, ok = com.YScale(comgraphpos)
    if !ok do return

    return graphpos, true
}

GraphPosToCom :: proc(graphpos: GraphPos) -> (comgraphpos: com.GraphPos, ok: bool)
{
    return com.NewGraphPos(graphpos.pos.x, graphpos.pos.y, graphpos.rotation, graphpos.scale.x, graphpos.scale.y)
}

GraphSizeFromCom :: proc(comgraphsize: com.GraphSize) -> (graphsize: GraphSize, ok: bool)
{
    if comgraphsize == nil do return

    lowerleft: com.Point
    lowerleft, ok = com.LowerLeft(comgraphsize)
    if !ok do return
    defer com.Release(lowerleft)

    graphsize.lower_left, ok = PointFromCom(lowerleft)
    if !ok do return

    upperright: com.Point
    upperright, ok = com.UpperRight(comgraphsize)
    if !ok do return
    defer com.Release(upperright)

    graphsize.upper_right, ok = PointFromCom(upperright)
    if !ok do return

    return graphsize, true
}

GraphSizeToCom :: proc(gs: GraphSize) -> (comgraphsize: com.GraphSize, ok: bool)
{
    lowerleft: com.Point
    lowerleft, ok = PointToCom(gs.lower_left)
    if !ok do return
    defer com.Release(lowerleft)

    upperright: com.Point
    upperright, ok = PointToCom(gs.upper_right)
    if !ok do return
    defer com.Release(upperright)

    comgraphsize, ok = com.NewGraphSize(lowerleft, upperright)
    if !ok do return

    return comgraphsize, true
}

PointsFromCom :: proc(compoints: com.Points, points: ^[dynamic]Point) -> (ok: bool)
{
    if compoints == nil do return

    count: i32
    count, ok = com.PointCount(compoints)
    if !ok do return

    for i in 0..<count {
        compoint: com.Point
        compoint, ok = com.GetPoint(compoints, i)
        if !ok do return
        defer com.Release(compoint)

        point: Point
        point, ok = PointFromCom(compoint)
        if !ok do return
        append(points, point)
    }
    
    return true
}

PointFromCom :: proc(compoint: com.Point) -> (point: Point, ok: bool)
{
    if compoint == nil do return

    point.x, ok = com.X(compoint)
    if !ok do return

    point.y, ok = com.Y(compoint)
    if !ok do return

    return point, true
}

PointsToCom :: proc(compoints: com.Points, points: []Point) -> (ok: bool)
{
    if compoints == nil do return
    
    for point in points {
        compoint: com.Point
        compoint, ok = PointToCom(point)
        if !ok do return
        defer com.Release(compoint)

        ok = com.AddPoint(compoints, compoint)
        if !ok do return
    }
    return true
}

PointToCom :: proc(p: Point) -> (compoint: com.Point, ok: bool)
{
    return com.NewPoint(p.x, p.y)
}

AutoPointFromCom :: proc(comautopoint: com.AutoPoint) -> (autoposition: AutoPoint, ok: bool)
{
    if comautopoint == nil do return

    autopoint: i32
    autopoint, ok = com.GetAutoPointAutoPosition(comautopoint)
    if !ok do return

    return AutoPoint(autopoint), true
}

AutoPointToCom :: proc(autopoint: AutoPoint) -> (comautopoint: com.AutoPoint, ok: bool)
{
    return com.NewAutoPoint(i32(autopoint))
}
