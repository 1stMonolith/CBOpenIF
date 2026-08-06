package cbopenif

GraphSize :: distinct rawptr

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

graphsize_new :: proc(lower_left, upper_right: rawptr) -> (graphsize: GraphSize, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := factoryif->NewGraphSize(lower_left, upper_right, cast(^rawptr)&graphsize)
    if com_failed(hr) do return
    
    return graphsize, true
}

graphsize_lower_left :: proc {
    graphsize_lower_left_get,
    graphsize_lower_left_set,
}

graphsize_lower_left_get :: proc(graphsize: GraphSize) -> (lower_left: Point, ok: bool) {
    if graphsize == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftGet(cast(^rawptr)&lower_left)
    if com_failed(hr) do return
    
    return lower_left, true
}

graphsize_lower_left_set :: proc(graphsize: GraphSize, lower_left: Point) -> (ok: bool) {
    if graphsize == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftPut(lower_left)
    if com_failed(hr) do return
    
    return true
}

graphsize_upper_right :: proc {
    graphsize_upper_right_get,
    graphsize_upper_right_set,
}

graphsize_upper_right_get :: proc(graphsize: GraphSize) -> (upper_right: Point, ok: bool) {
    if graphsize == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightGet(cast(^rawptr)&upper_right)
    if com_failed(hr) do return
    
    return upper_right, true
}

graphsize_upper_right_set :: proc(graphsize: GraphSize, upper_right: Point) -> (ok: bool) {
    if graphsize == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightPut(upper_right)
    if com_failed(hr) do return
    
    return true
}

graphsize_release :: proc(graphsize: GraphSize) {
    if graphsize != nil {
        (^GraphSizeIF)(graphsize)->Release()
    }
}
