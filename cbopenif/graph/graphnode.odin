package graph

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"

GraphNodeIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^GraphNodeVTable,
}

GraphNodeVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet: proc "system" (this: ^GraphNodeIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^GraphNodeIF, Name: BStr) -> HResult,
    XGet:    proc "system" (this: ^GraphNodeIF, X: ^f64) -> HResult,
    XPut:    proc "system" (this: ^GraphNodeIF, X: f64) -> HResult,
    YGet:    proc "system" (this: ^GraphNodeIF, Y: ^f64) -> HResult,
    YPut:    proc "system" (this: ^GraphNodeIF, Y: f64) -> HResult,
}

graphnode_new :: proc(name: string, x: f64, y: f64) -> (graphnode: rawptr, ok: bool) {
    graphnode = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    defer bstr.free(bstr_name)
    hr := factory.factoryif->NewGraphNode(bstr_name, x, y, cast(^rawptr)&graphnode)
    if com.failed(hr) do return
    
    return graphnode, true
}

graphnode_name :: proc {
    graphnode_name_get,
    graphnode_name_set,
}

graphnode_name_get :: proc(graphnode: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if graphnode == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^GraphNodeIF)(graphnode)->NameGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

graphnode_name_set :: proc(graphnode: rawptr, name: string) -> (ok: bool) {
    ok = false

    if graphnode == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^GraphNodeIF)(graphnode)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

graphnode_x :: proc {
    graphnode_x_get,
    graphnode_x_set,
}

graphnode_x_get :: proc(graphnode: rawptr) -> (x: f64, ok: bool) {
    x = 0
    ok = false

    if graphnode == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XGet(&x)
    if com.failed(hr) do return
    
    return x, true
}

graphnode_x_set :: proc(graphnode: rawptr, x: f64) -> (ok: bool) {
    ok = false

    if graphnode == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->XPut(x)
    if com.failed(hr) do return
    
    return true
}

graphnode_y :: proc {
    graphnode_y_get,
    graphnode_y_set,
}

graphnode_y_get :: proc(graphnode: rawptr) -> (y: f64, ok: bool) {
    y = 0
    ok = false

    if graphnode == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YGet(&y)
    if com.failed(hr) do return
    
    return y, true
}

graphnode_y_set :: proc(graphnode: rawptr, y: f64) -> (ok: bool) {
    ok = false

    if graphnode == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphNodeIF)(graphnode)->YPut(y)
    if com.failed(hr) do return
    
    return true
}

graphnode_release :: proc(graphnode: rawptr) {
    if graphnode != nil {
        (^GraphNodeIF)(graphnode)->Release()
    }
}
