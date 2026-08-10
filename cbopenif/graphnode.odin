package cbopenif

GraphNode  :: distinct rawptr
GraphNodes :: distinct rawptr

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

graphnodes_graphnode_add :: proc {
    graphnodes_graphnode_add_,
    graphnodes_graphnode_add_at_index,
}

graphnodes_graphnode_add_ :: proc(graphnodes: GraphNodes, graphnode: GraphNode) -> (ok: bool) {
    if graphnodes == nil do return
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Add(graphnode)
    if com_failed(hr) do return
    
    return true
}

graphnodes_graphnode_add_at_index :: proc(graphnodes: GraphNodes, graphnode: GraphNode, index: i32) -> (ok: bool) {
    if graphnodes == nil do return
    if graphnode == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->AddBefore(graphnode, index)
    if com_failed(hr) do return
    
    return true
}

graphnodes_graphnode :: proc {
    graphnodes_graphnode_by_name,
    graphnodes_graphnode_by_index,
}

graphnodes_graphnode_by_name :: proc(graphnodes: GraphNodes, name: string) -> (graphnode: GraphNode, ok: bool) {
    if graphnodes == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->Find(bstr_name, cast(^rawptr)&graphnode)
    if com_failed(hr) do return
    
    return graphnode, true
}

graphnodes_graphnode_by_index :: proc(graphnodes: GraphNodes, index: i32) -> (graphnode: GraphNode, ok: bool) {
    if graphnodes == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Item(index + 1, cast(^rawptr)&graphnode)
    if com_failed(hr) do return
    
    return graphnode, true
}

graphnodes_graphnode_index :: proc(graphnodes: GraphNodes, name: string) -> (index: i32, ok: bool) {
    if graphnodes == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

graphnodes_graphnode_count :: proc(graphnodes: GraphNodes) -> (count: i32, ok: bool) {
    if graphnodes == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

graphnodes_graphnode_remove :: proc {
    graphnodes_graphnode_remove_by_name,
    graphnodes_graphnode_remove_by_index
}

graphnodes_graphnode_remove_by_name :: proc(graphnodes: GraphNodes, name: string) -> (ok: bool) {
    if graphnodes == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = graphnodes_graphnode_index(graphnodes, name)
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

graphnodes_graphnode_remove_by_index :: proc(graphnodes: GraphNodes, index: i32) -> (ok: bool) {
    if graphnodes == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

graphnodes_release :: proc(graphnodes: GraphNodes) {
    if graphnodes != nil {
        (^GraphNodesIF)(graphnodes)->Release()
    }
}
