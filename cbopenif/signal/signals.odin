package signal

import "../com"
import "../controlbuilder"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult
@(private="file") Variant :: com.VariantBool

Signals :: distinct rawptr

SignalsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SignalsVTable,
}

SignalsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^SignalsIF, Signal: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^SignalsIF, Signal: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^SignalsIF, Name, Path, Direction: BStr, AcknowledgeGroup: Variant, Signal: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^SignalsIF, Name: BStr, Signal: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^SignalsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^SignalsIF, Index: i32, Signal: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^SignalsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^SignalsIF, Index: i32) -> HResult,
}

signals_add :: proc {
    signals_add_,
    signals_add_at_index,
}

signals_add_ :: proc(signals: Signals, signal: Signal) -> (ok: bool) {
    if signals == nil do return
    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^SignalsIF)(signals)->Add(signal)
    if com.failed(hr) do return

    return true
}

signals_add_at_index :: proc(signals: Signals, signal: Signal, index: i32) -> (ok: bool) {
    if signals == nil do return
    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->AddBefore(signal, index)
    if com.failed(hr) do return

    return true
}

signals_signal :: proc {
    signals_signal_by_name,
    signals_signal_by_index,
}

signals_signal_by_name :: proc(signals: Signals, name: string) -> (signal: Signal, ok: bool) {
    if signals == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := (^SignalsIF)(signals)->Find(bstr_name, cast(^rawptr)&signal)
    if com.failed(hr) do return
    
    return signal, true
}

signals_signal_by_index :: proc(signals: Signals, index: i32) -> (signal: Signals, ok: bool) {
    if signals == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->Item(index, cast(^rawptr)&signal)
    if com.failed(hr) do return
    
    return signal, true
}

signals_signal_index :: proc(signals: Signals, name: string) -> (index: i32, ok: bool) {
    if signals == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := (^SignalsIF)(signals)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

signals_count :: proc(signals: Signals) -> (count: i32, ok: bool) {
    if signals == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

signals_remove :: proc {
    signals_remove_by_name,
    signals_remove_by_index,
}

signals_remove_by_name :: proc(signals: Signals, name: string) -> (ok: bool) {
    if signals == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    index: i32
    index, ok = signals_signal_index(signals, name)
    
    hr := (^SignalsIF)(signals)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

signals_remove_by_index :: proc(signals: Signals, index: i32) -> (ok: bool) {
    if signals == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

signals_release :: proc(signals: Signals) {
    if signals != nil {
        (^SignalsIF)(signals)->Release()
    }
}
