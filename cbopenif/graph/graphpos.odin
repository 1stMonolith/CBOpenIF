package graph

import "../com"
import "../controlbuilder"
import "../factory"

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

graphpos_new :: proc(x_pos, y_pos, rotation, x_scale, y_scale: f64) -> (graphpos: rawptr, ok: bool) {
    graphpos = nil
    ok = false

    if !controlbuilder.connected() do return
    
    hr := factory.factoryif->NewGraphPos(x_pos, y_pos, rotation, x_scale, y_scale, cast(^rawptr)&graphpos)
    if com.failed(hr) do return
    
    return graphpos, true
}

graphpos_x :: proc {
    graphpos_x_,
    graphpos_x_set,
}

@(private)
graphpos_x_ :: proc(graphpos: rawptr) -> (x: f64, ok: bool) {
    x = 0
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XGet(&x)
    if com.failed(hr) do return
    
    return x, true
}

@(private)
graphpos_x_set :: proc(graphpos: rawptr, x: f64) -> (ok: bool) {
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XPut(x)
    if com.failed(hr) do return
    
    return true
}

graphpos_y :: proc {
    graphpos_y_,
    graphpos_y_set,
}

@(private)
graphpos_y_ :: proc(graphpos: rawptr) -> (y: f64, ok: bool) {
    y = 0
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XGet(&y)
    if com.failed(hr) do return
    
    return y, true
}

@(private)
graphpos_y_set :: proc(graphpos: rawptr, y: f64) -> (ok: bool) {
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XPut(y)
    if com.failed(hr) do return
    
    return true
}

graphpos_rotation :: proc {
    graphpos_rotation_,
    graphpos_rotation_set,
}

@(private)
graphpos_rotation_ :: proc(graphpos: rawptr) -> (rotation: f64, ok: bool) {
    rotation = 0
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationGet(&rotation)
    if com.failed(hr) do return
    
    return rotation, true
}

@(private)
graphpos_rotation_set :: proc(graphpos: rawptr, rotation: f64) -> (ok: bool) {
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->RotationPut(rotation)
    if com.failed(hr) do return
    
    return true
}

graphpos_xscale :: proc {
    graphpos_xscale_,
    graphpos_xscale_set,
}

@(private)
graphpos_xscale_ :: proc(graphpos: rawptr) -> (xscale: f64, ok: bool) {
    xscale = 0
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScaleGet(&xscale)
    if com.failed(hr) do return
    
    return xscale, true
}

@(private)
graphpos_xscale_set :: proc(graphpos: rawptr, xscale: f64) -> (ok: bool) {
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->XScalePut(xscale)
    if com.failed(hr) do return
    
    return true
}

graphpos_yscale :: proc {
    graphpos_yscale_,
    graphpos_yscale_set,
}

@(private)
graphpos_yscale_ :: proc(graphpos: rawptr) -> (yscale: f64, ok: bool) {
    yscale = 0
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScaleGet(&yscale)
    if com.failed(hr) do return
    
    return yscale, true
}

@(private)
graphpos_yscale_set :: proc(graphpos: rawptr, yscale: f64) -> (ok: bool) {
    ok = false

    if graphpos == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^GraphPosIF)(graphpos)->YScalePut(yscale)
    if com.failed(hr) do return
    
    return true
}

graphpos_release :: proc(graphpos: rawptr) {
    if graphpos != nil {
        (^GraphPosIF)(graphpos)->Release()
    }
}