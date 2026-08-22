package cbopenif

import "com"

GraphicsVisibilityKind :: enum i32 {
    Default   = 0,
    Visible   = 1,
    Invisible = 2,
}

Point :: struct {
    x: f64,
    y: f64,
}

AutoPosition :: enum i32 {
    Top    = 0,
    Bottom = 1,
    Left   = 2,
    Right  = 3,
}

GraphPos :: struct {
    pos:      Point,
    scale:    Point,
    rotation: f64,
}

GraphSize :: struct {
    lower_left:  Point,
    upper_right: Point,
}

GraphNode :: struct {
    name: string,
    x:    f64,
    y:    f64,
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

graphpos_from_com :: proc(graphpos: GraphPos, allocator := context.allocator) -> (result: t.GraphPos, ok: bool) {
    if graphpos == nil do return

    context.allocator = allocator

    result.pos.x, ok = x(graphpos)
    if !ok do return
    result.pos.y, ok = y(graphpos)
    if !ok do return
    result.rotation, ok = rotation(graphpos)
    if !ok do return
    result.scale.x, ok = xscale(graphpos)
    if !ok do return
    result.scale.y, ok = yscale(graphpos)
    if !ok do return

    return result, true
}

graphpos_to_com :: proc(src: t.GraphPos) -> (result: GraphPos, ok: bool) {
    graphpos: GraphPos
    graphpos, ok = graphpos_new(src.pos.x, src.pos.y, src.rotation, src.scale.x, src.scale.y)
    if !ok do return

    return graphpos, true
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

point_from_com :: proc(point: Point, allocator := context.allocator) -> (result: t.Point, ok: bool) {
    if point == nil do return

    context.allocator = allocator

    result.x, ok = x(point)
    if !ok do return
    result.y, ok = y(point)
    if !ok do return

    return result, true
}

point_to_com :: proc(src: t.Point) -> (result: Point, ok: bool) {
    point: Point
    point, ok = point_new(src.x, src.y)
    if !ok do return

    return point, true
}

points_from_com :: proc(pts: Points, allocator := context.allocator) -> (result: [dynamic]t.Point, ok: bool) {
    if pts == nil do return
    context.allocator = allocator

    count: i32
    count, ok = point_count(pts)
    if !ok do return

    result = make([dynamic]t.Point, 0, int(count), allocator)
    for i in 0..<count {
        p: Point
        p, ok = point(pts, i)
        if !ok do return
        defer release(p)

        ps: t.Point
        ps, ok = point_from_com(p)
        if !ok do return
        append(&result, ps)
    }
    return result, true
}

points_to_com :: proc(pts: Points, src: []t.Point) -> (ok: bool) {
    if pts == nil do return
    for item in src {
        p: Point
        p, ok = point_to_com(item)
        if !ok do return
        defer release(p)
        ok = point_add(pts, p)
        if !ok do return
    }
    return true
}

autopoint_from_com :: proc(autopoint: AutoPoint, allocator := context.allocator) -> (result: t.AutoPosition, ok: bool) {
    if autopoint == nil do return

    context.allocator = allocator

    result.auto_pos, ok = autopos(autopoint)
    if !ok do return

    return result, true
}

autopoint_to_com :: proc(src: t.AutoPosition) -> (result: AutoPoint, ok: bool) {
    autopoint: AutoPoint
    autopoint, ok = autopoint_new(i32(src.auto_pos))
    if !ok do return

    return autopoint, true
}
