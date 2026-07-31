package graph

GraphSize  :: distinct rawptr

GraphSizeIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^GraphSizeVTable,
}

GraphSizeVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    LowerLeftGet:  proc "system" (this: ^GraphSizeIF, LowerLeft: ^Point) -> HResult,
    Missing8:      proc "system" (this: ^GraphSizeIF) -> HResult,
    LowerLeftPut:  proc "system" (this: ^GraphSizeIF, LowerLeft: Point) -> HResult,
    UpperRightGet: proc "system" (this: ^GraphSizeIF, UpperRight: ^Point) -> HResult,
    Missing11:     proc "system" (this: ^GraphSizeIF) -> HResult,
    UpperRightPut: proc "system" (this: ^GraphSizeIF, UpperRight: Point) -> HResult,
}

graphsize_new :: proc(lower_left, upper_right: Point) -> (graphsize: GraphSize, ok: bool) {
    graphsize = nil
    ok = false

    if !connected() do return
    
    hr := factoryif->NewGraphSize(lower_left, upper_right, cast(^GraphSize)&graphsize)
    if failed(hr) do return
    
    return graphsize, true
}

graphsize_lower_left :: proc {
    graphsize_lower_left_,
    graphsize_lower_left_set,
}

@(private)
graphsize_lower_left_ :: proc(graphsize: GraphSize) -> (lower_left: Point, ok: bool) {
    lower_left = nil
    ok = false

    if graphsize == nil do return
    if !connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftGet(&lower_left)
    if failed(hr) do return
    
    return lower_left, true
}

@(private)
graphsize_lower_left_set :: proc(graphsize: GraphSize, lower_left: Point) -> (ok: bool) {
    ok = false

    if graphsize == nil do return
    if !connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftPut(lower_left)
    if failed(hr) do return
    
    return true
}

graphsize_upper_right :: proc {
    graphsize_upper_right_,
    graphsize_upper_right_set,
}

@(private)
graphsize_upper_right_ :: proc(graphsize: GraphSize) -> (upper_right: Point, ok: bool) {
    upper_right = nil
    ok = false

    if graphsize == nil do return
    if !connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightGet(&upper_right)
    if failed(hr) do return
    
    return upper_right, true
}

@(private)
graphsize_upper_right_set :: proc(graphsize: GraphSize, upper_right: Point) -> (ok: bool) {
    ok = false

    if graphsize == nil do return
    if !connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightPut(upper_right)
    if failed(hr) do return
    
    return true
}

graphsize_release :: proc(graphsize: GraphSize) {
    if graphsize != nil {
        (^GraphSizeIF)(graphsize)->Release()
    }
}