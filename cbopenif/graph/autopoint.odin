package graph

import "../com"
import "../controlbuilder"
import "../factory"
import "../enumtypes"

@(private) AutoPos :: enumtypes.AutoPos

AutoPointIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^AutoPointVTable,
}

AutoPointVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    AutoPosGet: proc "system" (this: ^AutoPointIF, AutoPos: ^i32) -> HResult,
    AutoPosPut: proc "system" (this: ^AutoPointIF, AutoPos: i32) -> HResult,
}

autopoint_new :: proc(autopos: i32) -> (autopoint: rawptr, ok: bool) {
    autopoint = {}
    ok = false

    if !controlbuilder.connected() do return

    hr := factory.factoryif->NewAutoPoint(i32(autopos), cast(^rawptr)&autopoint)
    if com.failed(hr) do return

    return autopoint, true
}

autopoint_autopos :: proc {
    autopoint_autopos_,
    autopoint_autopos_set,
}

@(private)
autopoint_autopos_ :: proc(autopoint: rawptr) -> (autopos: AutoPos, ok: bool) {
    autopos = {}
    ok = false

    if autopoint == nil do return
    if !controlbuilder.connected() do return
    
    i32_ap: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&i32_ap)
    if com.failed(hr) do return

    ap: AutoPos
    ap, ok = enumtypes.i32_to_autopos(i32_ap)
    if !ok do return
    
    return ap, true
}

@(private)
autopoint_autopos_set :: proc(autopoint: rawptr, autopos: AutoPos) -> (ok: bool) {
    ok = false

    if autopoint == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(i32(autopos))
    if com.failed(hr) do return
    
    return true
}

autopoint_release :: proc(autopoint: rawptr) {
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}