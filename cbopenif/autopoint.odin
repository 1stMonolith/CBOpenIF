package cbopenif

AutoPoint  :: distinct rawptr

AutoPointIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^AutoPointVTable,
}

AutoPointVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    AutoPosGet: proc "system" (this: ^AutoPointIF, AutoPos: ^i32) -> HResult,
    AutoPosPut: proc "system" (this: ^AutoPointIF, AutoPos: i32) -> HResult,
}

autopoint_new :: proc(autopos: AutoPos) -> (autopoint: AutoPoint, ok: bool) {
    autopoint = {}
    ok = false

    if !connected() do return

    hr := factoryif->NewAutoPoint(i32(autopos), cast(^AutoPoint)&autopoint)
    if failed(hr) do return

    return autopoint, true
}

autopoint_autopos :: proc {
    autopoint_autopos_,
    autopoint_autopos_set,
}

@(private)
autopoint_autopos_ :: proc(autopoint: AutoPoint) -> (autopos: AutoPos, ok: bool) {
    autopos = {}
    ok = false

    if autopoint == nil do return
    if !connected() do return
    
    i32_ap: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&i32_ap)
    if failed(hr) do return

    ap: AutoPos
    ap, ok = i32_to_autopos(i32_ap)
    if !ok do return
    
    return ap, true
}

@(private)
autopoint_autopos_set :: proc(autopoint: AutoPoint, autopos: AutoPos) -> (ok: bool) {
    ok = false

    if autopoint == nil do return
    if !connected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(i32(autopos))
    if failed(hr) do return
    
    return true
}

autopoint_release :: proc(autopoint: AutoPoint) {
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}