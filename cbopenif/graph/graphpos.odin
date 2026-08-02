package graph

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: bstr.BStr
@(private="file") HResult :: com.HResult

GraphPos :: distinct rawptr

GraphPosIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^GraphPosVTable,
}

GraphPosVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    XGet:        proc "system" (this: ^GraphPosIF, X: ^f64) -> HResult,
    XPut:        proc "system" (this: ^GraphPosIF, X: f64) -> HResult,
    YGet:        proc "system" (this: ^GraphPosIF, Y: ^f64) -> HResult,
    YPut:        proc "system" (this: ^GraphPosIF, Y: f64) -> HResult,
    RotationGet: proc "system" (this: ^GraphPosIF, Rotation: ^f64) -> HResult,
    RotationPut: proc "system" (this: ^GraphPosIF, Rotation: f64) -> HResult,
    XScaleGet:   proc "system" (this: ^GraphPosIF, XScale: ^f64) -> HResult,
    XScalePut:   proc "system" (this: ^GraphPosIF, XScale: f64) -> HResult,
    YScaleGet:   proc "system" (this: ^GraphPosIF, YScale: ^f64) -> HResult,
    YScalePut:   proc "system" (this: ^GraphPosIF, YScale: f64) -> HResult,
}

graphpos_new :: proc(x_pos, y_pos, rotation, x_scale, y_scale: f64) -> (graphpos: GraphPos, ok: bool) {

    if !controlbuilder.connected() do return
    
    hr := factory.factoryif->NewGraphPos(x_pos, y_pos, rotation, x_scale, y_scale, cast(^rawptr)&graphpos)
    if com.failed(hr) do return
    
    return graphpos, true
}

graphpos_x :: proc {
    graphpos_x_get,
    graphpos_x_set,
}

graphpos_x_get :: proc(graphpos: GraphPos) -> (x: f64, ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XGet(&x)
    if com.failed(hr) do return
    
    return x, true
}

graphpos_x_set :: proc(graphpos: GraphPos, x: f64) -> (ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XPut(x)
    if com.failed(hr) do return
    
    return true
}

graphpos_y :: proc {
    graphpos_y_get,
    graphpos_y_set,
}

graphpos_y_get :: proc(graphpos: GraphPos) -> (y: f64, ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XGet(&y)
    if com.failed(hr) do return
    
    return y, true
}

graphpos_y_set :: proc(graphpos: GraphPos, y: f64) -> (ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XPut(y)
    if com.failed(hr) do return
    
    return true
}

graphpos_rotation :: proc {
    graphpos_rotation_get,
    graphpos_rotation_set,
}

graphpos_rotation_get :: proc(graphpos: GraphPos) -> (rotation: f64, ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationGet(&rotation)
    if com.failed(hr) do return
    
    return rotation, true
}

graphpos_rotation_set :: proc(graphpos: GraphPos, rotation: f64) -> (ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationPut(rotation)
    if com.failed(hr) do return
    
    return true
}

graphpos_xscale :: proc {
    graphpos_xscale_get,
    graphpos_xscale_set,
}

graphpos_xscale_get :: proc(graphpos: GraphPos) -> (xscale: f64, ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScaleGet(&xscale)
    if com.failed(hr) do return
    
    return xscale, true
}

graphpos_xscale_set :: proc(graphpos: GraphPos, xscale: f64) -> (ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScalePut(xscale)
    if com.failed(hr) do return
    
    return true
}

graphpos_yscale :: proc {
    graphpos_yscale_get,
    graphpos_yscale_set,
}

graphpos_yscale_get :: proc(graphpos: GraphPos) -> (yscale: f64, ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScaleGet(&yscale)
    if com.failed(hr) do return
    
    return yscale, true
}

graphpos_yscale_set :: proc(graphpos: GraphPos, yscale: f64) -> (ok: bool) {

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScalePut(yscale)
    if com.failed(hr) do return
    
    return true
}

graphpos_release :: proc(graphpos: GraphPos) {
    if graphpos != nil {
        (^GraphPosIF)(graphpos)->Release()
    }
}
