package cbopenif

SignalType :: enum {
    Siganl = 0
}

Signal  :: distinct rawptr
Signals :: distinct rawptr

SignalIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SignalVTable,
}

SignalVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:             proc "system" (this: ^SignalIF, Name: ^BStr) -> HResult,
    NamePut:             proc "system" (this: ^SignalIF, Name: BStr) -> HResult,
    PathGet:             proc "system" (this: ^SignalIF, Path: ^BStr) -> HResult,
    PathPut:             proc "system" (this: ^SignalIF, Path: BStr) -> HResult,
    DirectionGet:        proc "system" (this: ^SignalIF, Attribute: ^BStr) -> HResult,
    DirectionPut:        proc "system" (this: ^SignalIF, Attribute: BStr) -> HResult,
    AcknowledgeGroupGet: proc "system" (this: ^SignalIF, InitialValue: ^BStr) -> HResult,
    AcknowledgeGroupPut: proc "system" (this: ^SignalIF, InitialValue: BStr) -> HResult,
    DescriptionGet:      proc "system" (this: ^SignalIF, Description: ^BStr) -> HResult,
    DescriptionPut:      proc "system" (this: ^SignalIF, Description: BStr) -> HResult,
    Serialize:           proc "system" (this: ^SignalIF, XML: ^BStr) -> HResult,
}

signal_new :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: Signal, ok: bool) {
    if !controlbuilder_connected() do return

    v_name := to_variant(name)
    v_path := to_variant(path)
    v_dir  := to_variant(direction)
    v_ag   := to_variant(acknowledge_group)
    defer {
        variant_free(&v_name)
        variant_free(&v_path)
        variant_free(&v_dir)
        variant_free(&v_ag)
    }

    // ars in NewSignal order (Name, Path, Direction, AcknowledgeGroup)
    args := []Variant{ v_name, v_path, v_dir, v_ag }

    result: Variant
    this := cast(^IUnknownIF)factoryif

    hr, arg_err, ok2 := com_invoke_name(this, "NewSignal", args,  &result)
    defer variant_free(&result)
    //fmt.printf("NewSignal Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if com_failed(hr) do return

    // Retval is usually VT_DISPATCH or VT_UNKNOWN
    sig: rawptr
    switch result.vt {
        case VariantTypeDispatch:
            sig = result.pdispVal
            result.pdispVal = nil
            result.vt = VariantTypeEmpty
        // I think we only every use Dispatch so this case is probably not needed
        case VariantTypeUnknown:
            sig = result.punkVal
            result.punkVal = nil
            result.vt = VariantTypeEmpty
        case:
            return
    }

    if sig == nil do return

    return Signal(sig), true
}

signal_deserialize :: proc(xml: string) -> (signal: Signal, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeSignal(&bs, cast(^rawptr)signal)
    if com_failed(hr) do return
    
    return signal, true
}

signal_serialize :: proc(signal: Signal) -> (xml: string, ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

signal_name :: proc {
    signal_name_get,
    signal_name_set,
}

signal_name_get :: proc(signal: Signal) -> (name: string, ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

signal_name_set :: proc(signal: Signal, name: string) -> (ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

signal_path :: proc {
    signal_path_get,
    signal_path_set,
}

signal_path_get :: proc(signal: Signal) -> (path: string, ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->PathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

signal_path_set :: proc(signal: Signal, path: string) -> (ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->PathPut(bs)
    if com_failed(hr) do return
    
    return true
}

signal_direction :: proc {
    signal_direction_get,
    signal_direction_set,
}

signal_direction_get :: proc(signal: Signal) -> (direction: string, ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->DirectionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

signal_direction_set :: proc(signal: Signal, direction: string) -> (ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(direction)
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->DirectionPut(bs)
    if com_failed(hr) do return
    
    return true
}

signal_acknowledge_group :: proc {
    signal_acknowledge_group_get,
    signal_acknowledge_group_set,
}

signal_acknowledge_group_get :: proc(signal: Signal) -> (acknowledge_group: string, ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->AcknowledgeGroupGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

signal_acknowledge_group_set :: proc(signal: Signal, acknowledge_group: string) -> (ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(acknowledge_group)
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->AcknowledgeGroupPut(bs)
    if com_failed(hr) do return
    
    return true
}

signal_description :: proc {
    signal_description_get,
    signal_description_set,
}

signal_description_get :: proc(signal: Signal) -> (description: string, ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

signal_description_set :: proc(signal: Signal, description: string) -> (ok: bool) {
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^SignalIF)(signal)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

signal_release :: proc(signal: Signal) {
    if signal != nil {
        (^SignalIF)(signal)->Release()
    }
}

SignalsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SignalsVTable,
}

SignalsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^SignalsIF, Signal: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^SignalsIF, Signal: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^SignalsIF, Name, Path, Direction: BStr, AcknowledgeGroup: Variant, Signal: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^SignalsIF, Name: BStr, Signal: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^SignalsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^SignalsIF, Index: i32, Signal: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^SignalsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^SignalsIF, Index: i32) -> HResult,
}

signals_signal_add :: proc {
    signals_signal_add_,
    signals_signal_add_at_index,
}

signals_signal_add_ :: proc(signals: Signals, signal: Signal) -> (ok: bool) {
    if signals == nil do return
    if signal == nil do return
    if !controlbuilder_connected() do return

    hr := (^SignalsIF)(signals)->Add(signal)
    if com_failed(hr) do return

    return true
}

signals_signal_add_at_index :: proc(signals: Signals, signal: Signal, index: i32) -> (ok: bool) {
    if signals == nil do return
    if signal == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->AddBefore(signal, index)
    if com_failed(hr) do return

    return true
}

signals_signal :: proc {
    signals_signal_by_name,
    signals_signal_by_index,
}

signals_signal_by_name :: proc(signals: Signals, name: string) -> (signal: Signal, ok: bool) {
    if signals == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^SignalsIF)(signals)->Find(bstr_name, cast(^rawptr)&signal)
    if com_failed(hr) do return
    
    return signal, true
}

signals_signal_by_index :: proc(signals: Signals, index: i32) -> (signal: Signals, ok: bool) {
    if signals == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->Item(index + 1, cast(^rawptr)&signal)
    if com_failed(hr) do return
    
    return signal, true
}

signals_signal_index :: proc(signals: Signals, name: string) -> (index: i32, ok: bool) {
    if signals == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^SignalsIF)(signals)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

signals_signal_count :: proc(signals: Signals) -> (count: i32, ok: bool) {
    if signals == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

signals_signal_remove :: proc {
    signals_signal_remove_by_name,
    signals_signal_remove_by_index,
}

signals_signal_remove_by_name :: proc(signals: Signals, name: string) -> (ok: bool) {
    if signals == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = signals_signal_index(signals, name)
    
    hr := (^SignalsIF)(signals)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

signals_signal_remove_by_index :: proc(signals: Signals, index: i32) -> (ok: bool) {
    if signals == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SignalsIF)(signals)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

signals_release :: proc(signals: Signals) {
    if signals != nil {
        (^SignalsIF)(signals)->Release()
    }
}
