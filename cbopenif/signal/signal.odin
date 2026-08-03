package signal

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult
@(private="file") Variant :: com.Variant

SignalType :: enum {
    Siganl = 0
}

Signal :: distinct rawptr

SignalIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SignalVTable,
}

SignalVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

/* use of Variant as an out required use of IDispatch->Invoke
signal_new :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: Signal, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := com.from_string(name)
    bstr_path := com.from_string(path)
    bstr_direction := com.from_string(direction)

    // NewSignal takes acknowledge group as a type Variant but signal takes it as type BStr for some reason.
    ag := com.to_variant(acknowledge_group)

    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_path)
        com.bstr_free(bstr_direction)
        //com.free(&ag)
    }

    hr := factory.factoryif->NewSignal(bstr_name, bstr_path, bstr_direction, ag, cast(^rawptr)&signal)
    if com.failed(hr) do return
    
    return signal, true
}
*/

signal_new :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: Signal, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return

    v_name := com.to_variant(name)
    v_path := com.to_variant(path)
    v_dir  := com.to_variant(direction)
    v_ag   := com.to_variant(acknowledge_group)
    defer {
        com.variant_free(&v_name)
        com.variant_free(&v_path)
        com.variant_free(&v_dir)
        com.variant_free(&v_ag)
    }

    // ars in NewSignal order (Name, Path, Direction, AcknowledgeGroup)
    args := []com.Variant{ v_name, v_path, v_dir, v_ag }

    result: com.Variant
    this := cast(^com.IUnknownIF)factory.factoryif

    hr, arg_err, ok2 := com.invoke_name(this, "NewSignal", args,  &result)
    defer com.variant_free(&result)
    //fmt.printf("NewSignal Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if com.failed(hr) do return

    // Retval is usually VT_DISPATCH or VT_UNKNOWN
    sig: rawptr
    switch result.vt {
        case com.VariantTypeDispatch:
            sig = result.pdispVal
            result.pdispVal = nil
            result.vt = com.VariantTypeEmpty
        /* 
        I think we only every use Dispatch so this case is probably not needed
        case com.VariantTypeUnknown:
            sig = result.punkVal
            result.punkVal = nil
            result.vt = com.VariantTypeEmpty
        */
        case:
            return
    }

    if sig == nil do return

    return Signal(sig), true
}

signal_deserialize :: proc(signal: ^Signal, xml: string) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeSignal(&bs, cast(^rawptr)signal)
    if com.failed(hr) do return
    
    return true
}

signal_serialize :: proc(signal: Signal) -> (xml: string, ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->Serialize(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

signal_name :: proc {
    signal_name_get,
    signal_name_set,
}

signal_name_get :: proc(signal: Signal) -> (name: string, ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

signal_name_set :: proc(signal: Signal, name: string) -> (ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

signal_description :: proc {
    signal_description_get,
    signal_description_set,
}

signal_description_get :: proc(signal: Signal) -> (description: string, ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

signal_description_set :: proc(signal: Signal, description: string) -> (ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(description)
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

signal_path :: proc {
    signal_path_get,
    signal_path_set,
}

signal_path_get :: proc(signal: Signal) -> (path: string, ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->PathGet(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

signal_path_set :: proc(signal: Signal, path: string) -> (ok: bool) {

    if signal == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(path)
    defer com.bstr_free(bs)
    hr := (^SignalIF)(signal)->PathPut(bs)
    if com.failed(hr) do return
    
    return true
}

signal_release :: proc(signal: Signal) {
    if signal != nil {
        (^SignalIF)(signal)->Release()
    }
}
