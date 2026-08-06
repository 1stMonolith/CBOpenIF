package cbopenif

AutoPosType :: enum i32 {
    Top    = 0,
    Bottom = 1,
    Left   = 2,
    Right  = 3,
}

AutoPoint :: distinct rawptr

AutoPointIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^AutoPointVTable,
}

AutoPointVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    AutoPosGet: proc "system" (this: ^AutoPointIF, AutoPos: ^i32) -> HResult,
    AutoPosPut: proc "system" (this: ^AutoPointIF, AutoPos: i32) -> HResult,
}

autopoint_new :: proc(autopos: AutoPosType) -> (autopoint: AutoPoint, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewAutoPoint(i32(autopos), cast(^rawptr)&autopoint)
    if com_failed(hr) do return

    return autopoint, true
}

autopoint_autopos :: proc {
    autopoint_autopos_get,
    autopoint_autopos_set,
}

autopoint_autopos_get :: proc(autopoint: AutoPoint) -> (autopos: AutoPosType, ok: bool) {
    if autopoint == nil do return
    if !controlbuilder_connected() do return
    
    apt: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&apt)
    if com_failed(hr) do return

    if !ok do return
    
    return AutoPosType(apt), true
}

autopoint_autopos_set :: proc(autopoint: AutoPoint, autopos: AutoPosType) -> (ok: bool) {
    if autopoint == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(i32(autopos))
    if com_failed(hr) do return
    
    return true
}

autopoint_release :: proc(autopoint: AutoPoint) {
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}