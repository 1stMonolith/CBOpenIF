package signal

SignalType :: enum {
    Siganl = 0
}

Signal :: distinct rawptr

SignalIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^SignalVTable,
}

SignalVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
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
    signal = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_path := string_to_bstr(path)
    bstr_direction := string_to_bstr(direction)

    // NewSignal takes acknowledge group as a type Variant but signal takes it as type BStr for some reason.
    variant_acknowledge_group := string_to_variant(acknowledge_group)
    
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
        bstr_free(bstr_direction)
        variant_free(&variant_acknowledge_group)
    }
    hr := factoryif->NewSignal(bstr_name, bstr_path, bstr_direction, variant_acknowledge_group, cast(^Signal)&signal)
    if failed(hr) do return
    
    return signal, true
}

signal_deserialize :: proc(signal: ^Signal, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeSignal(&bstr, cast(^Signal)signal)
    if failed(hr) do return
    
    return true
}

signal_serialize :: proc(signal: Signal) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

signal_name :: proc {
    signal_name_,
    signal_name_set,
}

@(private)
signal_name_ :: proc(signal: Signal) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
signal_name_set :: proc(signal: Signal, name: string) -> (ok: bool) {
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

signal_description :: proc {
    signal_description_,
    signal_description_set,
}

@(private)
signal_description_ :: proc(signal: Signal) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->DescriptionGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
signal_description_set :: proc(signal: Signal, description: string) -> (ok: bool) {
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

signal_path :: proc {
    signal_path_,
    signal_path_set,
}

@(private)
signal_path_ :: proc(signal: Signal) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->PathGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
signal_path_set :: proc(signal: Signal, path: string) -> (ok: bool) {
    ok = false

    if signal == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(path)
    defer bstr_free(bstr)
    hr := (^SignalIF)(signal)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

signal_release :: proc(signal: Signal) {
    if signal != nil {
        (^SignalIF)(signal)->Release()
    }
}
