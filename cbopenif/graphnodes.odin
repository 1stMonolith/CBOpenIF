package cbopenif

GraphNodes :: distinct rawptr

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
