package com

import t "../types"

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

autopoint_autopos_get :: proc(autopoint: AutoPoint) -> (autopos: t.AutoPos, ok: bool) {
    if autopoint == nil do return
    if !com_connected() do return
    
    apt: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&apt)
    if com_failed(hr) do return

    if !ok do return
    
    return t.AutoPos(apt), true
}

autopoint_autopos_set :: proc(autopoint: AutoPoint, autopos: t.AutoPos) -> (ok: bool) {
    if autopoint == nil do return
    if !com_connected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(i32(autopos))
    if com_failed(hr) do return
    
    return true
}

autopoint_release :: proc(autopoint: AutoPoint) {
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}

autopoint_from_com :: proc(autopoint: AutoPoint, allocator := context.allocator) -> (result: t.AutoPoint, ok: bool) {
    if autopoint == nil do return

    context.allocator = allocator

    result.auto_pos, ok = autopos(autopoint)
    if !ok do return

    return result, true
}

autopoint_to_com :: proc(src: t.AutoPoint) -> (result: AutoPoint, ok: bool) {
    autopoint: AutoPoint
    autopoint, ok = autopoint_new(i32(src.auto_pos))
    if !ok do return

    return autopoint, true
}
