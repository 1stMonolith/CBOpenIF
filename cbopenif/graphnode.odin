package cbopenif

GraphNode  :: distinct rawptr

GraphNodeIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^GraphNodeVTable,
}

GraphNodeVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    NameGet: proc "system" (this: ^GraphNodeIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^GraphNodeIF, Name: BStr) -> HResult,
    XGet:    proc "system" (this: ^GraphNodeIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^GraphNodeIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^GraphNodeIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^GraphNodeIF, Y: f64) -> HResult,
}

graphnode_new :: proc(name: string, x: f64, y: f64) -> (graphnode: GraphNode, ok: bool) {
    graphnode = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewGraphNode(bstr_name, x, y, cast(^GraphNode)&graphnode)
    if failed(hr) do return
    
    return graphnode, true
}

graphnode_name :: proc {
    graphnode_name_,
    graphnode_name_set,
}

@(private)
graphnode_name_ :: proc(graphnode: GraphNode) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if graphnode == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^GraphNodeIF)(graphnode)->NameGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
graphnode_name_set :: proc(graphnode: GraphNode, name: string) -> (ok: bool) {
    ok = false

    if graphnode == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^GraphNodeIF)(graphnode)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

graphnode_x :: proc {
    graphnode_x_,
    graphnode_x_set,
}

@(private)
graphnode_x_ :: proc(graphnode: GraphNode) -> (x: f64, ok: bool) {
    x = 0
    ok = false

    if graphnode == nil do return
    if !connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XGet(&x)
    if failed(hr) do return
    
    return x, true
}

@(private)
graphnode_x_set :: proc(graphnode: GraphNode, x: f64) -> (ok: bool) {
    ok = false

    if graphnode == nil do return
    if !connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XPut(x)
    if failed(hr) do return
    
    return true
}

graphnode_y :: proc {
    graphnode_y_,
    graphnode_y_set,
}

@(private)
graphnode_y_ :: proc(graphnode: GraphNode) -> (y: f64, ok: bool) {
    y = 0
    ok = false

    if graphnode == nil do return
    if !connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YGet(&y)
    if failed(hr) do return
    
    return y, true
}

@(private)
graphnode_y_set :: proc(graphnode: GraphNode, y: f64) -> (ok: bool) {
    ok = false

    if graphnode == nil do return
    if !connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YPut(y)
    if failed(hr) do return
    
    return true
}

graphnode_release :: proc(graphnode: GraphNode) {
    if graphnode != nil {
        (^GraphNodeIF)(graphnode)->Release()
    }
}