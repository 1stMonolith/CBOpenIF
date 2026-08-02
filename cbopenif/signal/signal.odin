package signal

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"
import "../variant"

@(private="file") BStr    :: bstr.BStr
@(private="file") HResult :: com.HResult
@(private="file") Variant :: variant.Variant

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

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_path := bstr.from_string(path)
    bstr_direction := bstr.from_string(direction)

    // NewSignal takes acknowledge group as a type Variant but signal takes it as type BStr for some reason.
    ag := variant.to_variant(acknowledge_group)

    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_path)
        bstr.free(bstr_direction)
        //variant.free(&ag)
    }

    hr := factory.factoryif->NewSignal(bstr_name, bstr_path, bstr_direction, ag, cast(^rawptr)&signal)
    if com.failed(hr) do return
    
    return signal, true
}
*/

signal_new :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: Signal, ok: bool) {

    if !controlbuilder.connected() do return

    v_name := variant.to_variant(name)
    v_path := variant.to_variant(path)
    v_dir  := variant.to_variant(direction)
    v_ag   := variant.to_variant(acknowledge_group)
    defer {
        variant.free(&v_name)
        variant.free(&v_path)
        variant.free(&v_dir)
        variant.free(&v_ag)
    }

    // ars in NewSignal order (Name, Path, Direction, AcknowledgeGroup)
    args := []variant.Variant{ v_name, v_path, v_dir, v_ag }

    result: variant.Variant
    this := cast(^com.IUnknownIF)factory.factoryif

    hr, arg_err, ok2 := com.invoke_name(this, "NewSignal", args,  &result)
    defer variant.free(&result)
    //fmt.printf("NewSignal Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if com.failed(hr) do return

    // Retval is usually VT_DISPATCH or VT_UNKNOWN
    sig: rawptr
    switch result.vt {
        case variant.VariantTypeDispatch:
            sig = result.pdispVal
            result.pdispVal = nil
            result.vt = variant.VariantTypeEmpty
        /* 
        I think we only every use Dispatch so this case is probably not needed
        case variant.VariantTypeUnknown:
            sig = result.punkVal
            result.punkVal = nil
            result.vt = variant.VariantTypeEmpty
        */
        case:
            return
    }

    if sig == nil do return

    return Signal(sig), true
}

signal_deserialize :: proc(signal: ^Signal, xml: string) -> (ok: bool) {

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeSignal(&bs, cast(^rawptr)signal)
    if com.failed(hr) do return
    
    return true
}

signal_serialize :: proc(signal: Signal) -> (xml: string, ok: bool) {

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

signal_name :: proc {
    signal_name_get,
    signal_name_set,
}

signal_name_get :: proc(signal: Signal) -> (name: string, ok: bool) {

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

signal_name_set :: proc(signal: Signal, name: string) -> (ok: bool) {

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
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
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

signal_description_set :: proc(signal: Signal, description: string) -> (ok: bool) {

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
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
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->PathGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

signal_path_set :: proc(signal: Signal, path: string) -> (ok: bool) {

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(path)
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->PathPut(bs)
    if com.failed(hr) do return
    
    return true
}

signal_release :: proc(signal: Signal) {
    if signal != nil {
        (^SignalIF)(signal)->Release()
    }
}
