package signal

Signals :: distinct rawptr

SignalsIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^SignalsVTable,
}

SignalsVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:       proc "system" (this: ^SignalsIF, Signal: Signal) -> HResult,
    AddBefore: proc "system" (this: ^SignalsIF, Signal: Signal, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^SignalsIF, Name, Path, Direction: BStr, AcknowledgeGroup: Variant, Signal: ^Signal) -> HResult,
    Find:      proc "system" (this: ^SignalsIF, Name: BStr, Signal: ^Signal) -> HResult,
    FindNr:    proc "system" (this: ^SignalsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^SignalsIF, Index: i32, Signal: ^Signal) -> HResult,
    Count:     proc "system" (this: ^SignalsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^SignalsIF, Index: i32) -> HResult,
}

signals_add :: proc {
    signals_add_,
    signals_add_at_index,
}

@(private)
signals_add_ :: proc(signals: Signals, signal: Signal) -> (ok: bool) {
    ok = false

    if !connected() do return
    if signals == nil do return
    if signal == nil do return

    hr := (^SignalsIF)(signals)->Add(signal)
    if failed(hr) do return

    return true
}

signals_add_at_index :: proc(signals: Signals, signal: Signal, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if signals == nil do return
    if signal == nil do return
    
    hr := (^SignalsIF)(signals)->AddBefore(signal, index)
    if failed(hr) do return

    return true
}

signals_signal :: proc {
    signals_signal_by_name,
    signals_signal_by_index,
}

signals_signal_by_name :: proc(signals: Signals, name: string) -> (signal: Signal, ok: bool) {
    signal = nil
    ok = false

    if !connected() do return
    if signals == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^SignalsIF)(signals)->Find(bstr_name, &signal)
    if failed(hr) do return
    
    return signal, true
}

signals_signal_by_index :: proc(signals: Signals, index: i32) -> (signal: Signal, ok: bool) {
    signal = nil
    ok = false

    if !connected() do return
    if signals == nil do return
    
    hr := (^SignalsIF)(signals)->Item(index, &signal)
    if failed(hr) do return
    
    return signal, true
}

signals_signal_index :: proc(signals: Signals, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if signals == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^SignalsIF)(signals)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

signals_count :: proc(signals: Signals) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if signals == nil do return
    
    hr := (^SignalsIF)(signals)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

signals_remove :: proc {
    signals_remove_by_name,
    signals_remove_by_index,
}

signals_remove_by_name :: proc(signals: Signals, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if signals == nil do return

    index: i32
    index, ok = signals_signal_index(signals, name)
    
    hr := (^SignalsIF)(signals)->Remove(index)
    if failed(hr) do return
    
    return true
}

signals_remove_by_index :: proc(signals: Signals, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if signals == nil do return
    
    hr := (^SignalsIF)(signals)->Remove(index)
    if failed(hr) do return
    
    return true
}

signals_release :: proc(signals: Signals) {
    if signals != nil {
        (^SignalsIF)(signals)->Release()
    }
}