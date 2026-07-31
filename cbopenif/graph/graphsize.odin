package graph

import "../com"
import "../controlbuilder"
import "../factory"

GraphSizeIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^GraphSizeVTable,
}

GraphSizeVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    LowerLeftGet:  proc "system" (this: ^GraphSizeIF, LowerLeft: ^rawptr) -> HResult,
    Missing8:      proc "system" (this: ^GraphSizeIF) -> HResult,
    LowerLeftPut:  proc "system" (this: ^GraphSizeIF, LowerLeft: rawptr) -> HResult,
    UpperRightGet: proc "system" (this: ^GraphSizeIF, UpperRight: ^rawptr) -> HResult,
    Missing11:     proc "system" (this: ^GraphSizeIF) -> HResult,
    UpperRightPut: proc "system" (this: ^GraphSizeIF, UpperRight: rawptr) -> HResult,
}

graphsize_new :: proc(lower_left, upper_right: rawptr) -> (graphsize: rawptr, ok: bool) {
    graphsize = nil
    ok = false

    if !controlbuilder.connected() do return
    
    hr := factory.factoryif->NewGraphSize(lower_left, upper_right, cast(^rawptr)&graphsize)
    if com.failed(hr) do return
    
    return graphsize, true
}

graphsize_lower_left :: proc {
    graphsize_lower_left_get,
    graphsize_lower_left_set,
}

graphsize_lower_left_get :: proc(graphsize: rawptr) -> (lower_left: rawptr, ok: bool) {
    lower_left = nil
    ok = false

    if graphsize == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftGet(&lower_left)
    if com.failed(hr) do return
    
    return lower_left, true
}

graphsize_lower_left_set :: proc(graphsize: rawptr, lower_left: rawptr) -> (ok: bool) {
    ok = false

    if graphsize == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->LowerLeftPut(lower_left)
    if com.failed(hr) do return
    
    return true
}

graphsize_upper_right :: proc {
    graphsize_upper_right_get,
    graphsize_upper_right_set,
}

graphsize_upper_right_get :: proc(graphsize: rawptr) -> (upper_right: rawptr, ok: bool) {
    upper_right = nil
    ok = false

    if graphsize == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightGet(&upper_right)
    if com.failed(hr) do return
    
    return upper_right, true
}

graphsize_upper_right_set :: proc(graphsize: rawptr, upper_right: rawptr) -> (ok: bool) {
    ok = false

    if graphsize == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphSizeIF)(graphsize)->UpperRightPut(upper_right)
    if com.failed(hr) do return
    
    return true
}

graphsize_release :: proc(graphsize: rawptr) {
    if graphsize != nil {
        (^GraphSizeIF)(graphsize)->Release()
    }
}
