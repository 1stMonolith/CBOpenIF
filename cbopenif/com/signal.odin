package com

Signals :: distinct rawptr
Signal  :: distinct rawptr

SignalsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SignalsVTable,
}

SignalsVTable :: struct
{
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

AddSignal :: proc {
    _AddSignal,
    _AddSignalAtIndex,
}

_AddSignal :: proc(signals: Signals, signal: Signal) -> (ok: bool)
{
    if signals == nil do return
    if signal == nil do return
    if !ComConnected() do return

    hr := (^SignalsIF)(signals)->Add(signal)
    if ComFailed(hr) do return

    return true
}

_AddSignalAtIndex :: proc(signals: Signals, signal: Signal, index: i32) -> (ok: bool)
{
    if signals == nil do return
    if signal == nil do return
    if !ComConnected() do return
    
    hr := (^SignalsIF)(signals)->AddBefore(signal, index)
    if ComFailed(hr) do return

    return true
}

GetSignal :: proc {
    _GetSignalWithName,
    _GetSignalAtIndex,
}

_GetSignalWithName :: proc(signals: Signals, name: string) -> (signal: Signal, ok: bool)
{
    if signals == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^SignalsIF)(signals)->Find(bstr_name, cast(^rawptr)&signal)
    if ComFailed(hr) do return
    
    return signal, true
}

_GetSignalAtIndex :: proc(signals: Signals, index: i32) -> (signal: Signal, ok: bool)
{
    if signals == nil do return
    if !ComConnected() do return
    
    hr := (^SignalsIF)(signals)->Item(index + 1, cast(^rawptr)&signal)
    if ComFailed(hr) do return
    
    return signal, true
}

SignalIndex :: proc(signals: Signals, name: string) -> (index: i32, ok: bool)
{
    if signals == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^SignalsIF)(signals)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

SignalCount :: proc(signals: Signals) -> (count: i32, ok: bool)
{
    if signals == nil do return
    if !ComConnected() do return
    
    hr := (^SignalsIF)(signals)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveSignal :: proc {
    _RemoveSignalWithName,
    _RemoveSignalAtIndex,
}

_RemoveSignalWithName :: proc(signals: Signals, name: string) -> (ok: bool)
{
    if signals == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = SignalIndex(signals, name)
    
    hr := (^SignalsIF)(signals)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveSignalAtIndex :: proc(signals: Signals, index: i32) -> (ok: bool)
{
    if signals == nil do return
    if !ComConnected() do return
    
    hr := (^SignalsIF)(signals)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseSignals :: proc(signals: Signals)
{
    if signals != nil {
        (^SignalsIF)(signals)->Release()
    }
}

SignalIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SignalVTable,
}

SignalVTable :: struct
{
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

SerializeSignal :: proc(signal: Signal) -> (xml: string, ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetSignalName :: proc(signal: Signal) -> (name: string, ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSignalName :: proc(signal: Signal, name: string) -> (ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetSignalPath :: proc(signal: Signal) -> (path: string, ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->PathGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetSignalPath :: proc(signal: Signal, path: string) -> (ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(path)
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->PathPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetSignalDirection :: proc(signal: Signal) -> (direction: string, ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->DirectionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetSignalDirection :: proc(signal: Signal, direction: string) -> (ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(direction)
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->DirectionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetSignalAcknowledgeGroup :: proc(signal: Signal) -> (acknowledge_group: string, ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->AcknowledgeGroupGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetSignalAcknowledgeGroup :: proc(signal: Signal, acknowledge_group: string) -> (ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(acknowledge_group)
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->AcknowledgeGroupPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetSignalDescription :: proc(signal: Signal) -> (description: string, ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetSignalDescription :: proc(signal: Signal, description: string) -> (ok: bool)
{
    if signal == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^SignalIF)(signal)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseSignal :: proc(signal: Signal)
{
    if signal != nil {
        (^SignalIF)(signal)->Release()
    }
}
