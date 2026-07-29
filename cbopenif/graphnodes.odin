package cbopenif

GraphNodes :: distinct rawptr

GraphNodesIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^GraphNodesVTable,
}

GraphNodesVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:       proc "system" (this: ^GraphNodesIF, GraphNode: GraphNode) -> HResult,
    AddBefore: proc "system" (this: ^GraphNodesIF, GraphNode: GraphNode, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^GraphNodesIF, Name: BStr, X, Y: i64, GraphNode: ^GraphNode) -> HResult,
    Find:      proc "system" (this: ^GraphNodesIF, Name: BStr, GraphNode: ^GraphNode) -> HResult,
    FindNr:    proc "system" (this: ^GraphNodesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^GraphNodesIF, Index: i32, GraphNode: ^GraphNode) -> HResult,
    Count:     proc "system" (this: ^GraphNodesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^GraphNodesIF, Index: i32) -> HResult,
}

graphnode_add :: proc {
    graphnode_add_,
    graphnodes_add_at_index,
}

@(private)
graphnode_add_ :: proc(graphnodes: GraphNodes, graphnode: GraphNode) -> (ok: bool) {
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    if graphnode == nil do return
    
    hr := (^GraphNodesIF)(graphnodes)->Add(graphnode)
    if failed(hr) do return
    
    return true
}

graphnodes_add_at_index :: proc(graphnodes: GraphNodes, graphnode: GraphNode, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    if graphnode == nil do return
    
    hr := (^GraphNodesIF)(graphnodes)->AddBefore(graphnode, index)
    if failed(hr) do return
    
    return true
}

graphnodes_graphnode :: proc {
    graphnodes_graphnode_by_name,
    graphnodes_graphnode_by_index,
}

graphnodes_graphnode_by_name :: proc(graphnodes: GraphNodes, name: string) -> (graphnode: GraphNode, ok: bool) {
    graphnode = nil
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    
    bstr_name := string_to_bstr(name)
    SysFreeString(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->Find(bstr_name, &graphnode)
    if failed(hr) do return
    
    return graphnode, true
}

graphnodes_graphnode_by_index :: proc(graphnodes: GraphNodes, index: i32) -> (graphnode: GraphNode, ok: bool) {
    graphnode = nil
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    
    hr := (^GraphNodesIF)(graphnodes)->Item(index, &graphnode)
    if failed(hr) do return
    
    return graphnode, true
}

graphnodes_graphnode_index :: proc(graphnodes: GraphNodes, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    
    bstr_name := string_to_bstr(name)
    SysFreeString(bstr_name)
    hr := (^GraphNodesIF)(graphnodes)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

graphnodes_count :: proc(graphnodes: GraphNodes) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    
    hr := (^GraphNodesIF)(graphnodes)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

graphnodes_remove :: proc {
    graphnodes_remove_by_name,
    graphnodes_remove_by_index
}

graphnodes_remove_by_name :: proc(graphnodes: GraphNodes, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if graphnodes == nil do return

    index: i32
    index, ok = graphnodes_graphnode_index(graphnodes, name)
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index)
    if failed(hr) do return
    
    return true
}

graphnodes_remove_by_index :: proc(graphnodes: GraphNodes, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if graphnodes == nil do return
    
    hr := (^GraphNodesIF)(graphnodes)->Remove(index)
    if failed(hr) do return
    
    return true
}

graphnodes_release :: proc(graphnodes: GraphNodes) {
    if graphnodes != nil {
        (^GraphNodesIF)(graphnodes)->Release()
    }
}