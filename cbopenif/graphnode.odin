package cbopenif

GraphNode :: distinct rawptr

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

graphnode_new :: proc(name: string, x: f64, y: f64) -> (graphnode: GraphNode, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewGraphNode(bstr_name, x, y, cast(^rawptr)&graphnode)
    if com_failed(hr) do return
    
    return graphnode, true
}

graphnode_name :: proc {
    graphnode_name_get,
    graphnode_name_set,
}

graphnode_name_get :: proc(graphnode: GraphNode) -> (name: string, ok: bool) {
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GraphNodeIF)(graphnode)->NameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

graphnode_name_set :: proc(graphnode: GraphNode, name: string) -> (ok: bool) {
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^GraphNodeIF)(graphnode)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

graphnode_x :: proc {
    graphnode_x_get,
    graphnode_x_set,
}

graphnode_x_get :: proc(graphnode: GraphNode) -> (x: f64, ok: bool) {
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XGet(&x)
    if com_failed(hr) do return
    
    return x, true
}

graphnode_x_set :: proc(graphnode: GraphNode, x: f64) -> (ok: bool) {
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XPut(x)
    if com_failed(hr) do return
    
    return true
}

graphnode_y :: proc {
    graphnode_y_get,
    graphnode_y_set,
}

graphnode_y_get :: proc(graphnode: GraphNode) -> (y: f64, ok: bool) {
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YGet(&y)
    if com_failed(hr) do return
    
    return y, true
}

graphnode_y_set :: proc(graphnode: GraphNode, y: f64) -> (ok: bool) {
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YPut(y)
    if com_failed(hr) do return
    
    return true
}

graphnode_release :: proc(graphnode: GraphNode) {
    if graphnode != nil {
        (^GraphNodeIF)(graphnode)->Release()
    }
}
