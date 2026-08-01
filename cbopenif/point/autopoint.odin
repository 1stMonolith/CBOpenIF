package point

import "../com"
import "../controlbuilder"
import "../factory"
import "../type"

@(private) HResult :: com.HResult
@(private) AutoPosType :: type.AutoPosType

AutoPoint :: distinct rawptr

AutoPointIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^AutoPointVTable,
}

AutoPointVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    AutoPosGet: proc "system" (this: ^AutoPointIF, AutoPos: ^i32) -> HResult,
    AutoPosPut: proc "system" (this: ^AutoPointIF, AutoPos: i32) -> HResult,
}

autopoint_new :: proc(autopos: AutoPosType) -> (autopoint: AutoPoint, ok: bool) {
    autopoint = {}
    ok = false

    if !controlbuilder.connected() do return

    hr := factory.factoryif->NewAutoPoint(i32(autopos), cast(^rawptr)&autopoint)
    if com.failed(hr) do return

    return autopoint, true
}

autopoint_autopos :: proc {
    autopoint_autopos_get,
    autopoint_autopos_set,
}

autopoint_autopos_get :: proc(autopoint: AutoPoint) -> (autopos: AutoPosType, ok: bool) {
    autopos = {}
    ok = false

    if autopoint == nil do return
    if !controlbuilder.connected() do return
    
    apt: i32
    hr := (^AutoPointIF)(autopoint)->AutoPosGet(&apt)
    if com.failed(hr) do return

    if !ok do return
    
    return AutoPosType(apt), true
}

autopoint_autopos_set :: proc(autopoint: AutoPoint, autopos: AutoPosType) -> (ok: bool) {
    ok = false

    if autopoint == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^AutoPointIF)(autopoint)->AutoPosPut(i32(autopos))
    if com.failed(hr) do return
    
    return true
}

autopoint_release :: proc(autopoint: AutoPoint) {
    if autopoint != nil {
        (^AutoPointIF)(autopoint)->Release()
    }
}