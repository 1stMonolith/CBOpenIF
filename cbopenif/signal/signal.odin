package signal

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"

 HResult     :: com.HResult
 BStr        :: bstr.BStr
 GUID        :: com.GUID
 Variant     :: variant.Variant
 VariantBool :: variant.VariantBool

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

signal_new :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: rawptr, ok: bool) {
    signal = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_path := bstr.from_string(path)
    bstr_direction := bstr.from_string(direction)

    // NewSignal takes acknowledge group as a type Variant but signal takes it as type BStr for some reason.
    variant_acknowledge_group := variant.string_to_variant(acknowledge_group)
    
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_path)
        bstr.free(bstr_direction)
        variant.free(&variant_acknowledge_group)
    }
    hr := factory.factoryif->NewSignal(bstr_name, bstr_path, bstr_direction, variant_acknowledge_group, cast(^rawptr)&signal)
    if com.failed(hr) do return
    
    return signal, true
}

signal_deserialize :: proc(signal: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factory.factoryif->DeserializeSignal(&bs, cast(^rawptr)signal)
    if com.failed(hr) do return
    
    return true
}

signal_serialize :: proc(signal: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

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

signal_name_get :: proc(signal: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

signal_name_set :: proc(signal: rawptr, name: string) -> (ok: bool) {
    ok = false

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

signal_description_get :: proc(signal: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->DescriptionGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

signal_description_set :: proc(signal: rawptr, description: string) -> (ok: bool) {
    ok = false

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

signal_path_get :: proc(signal: rawptr) -> (path: string, ok: bool) {
    path = ""
    ok = false

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->PathGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

signal_path_set :: proc(signal: rawptr, path: string) -> (ok: bool) {
    ok = false

    if signal == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(path)
    defer bstr.free(bs)
    hr := (^SignalIF)(signal)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

signal_release :: proc(signal: rawptr) {
    if signal != nil {
        (^SignalIF)(signal)->Release()
    }
}
