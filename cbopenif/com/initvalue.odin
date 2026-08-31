package com

InitValues :: distinct rawptr
InitValue  :: distinct rawptr

InitValuesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^InitValuesVTable,
}

InitValuesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^InitValuesIF, InitValue: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^InitValuesIF, InitValue: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^InitValuesIF, POUPath, Name, Value: BStr, InitValue: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^InitValuesIF, POUPath, Name: BStr, InitValue: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^InitValuesIF, POUPath, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^InitValuesIF, Index: i32, InitValue: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^InitValuesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^InitValuesIF, Index: i32) -> HResult,
}

AddInitValue :: proc {
    _AddInitValue,
    _AddInitValueAtIndex,
}

_AddInitValue :: proc(initvalues: InitValues, initvalue: InitValue) -> (ok: bool)
{
    if initvalues == nil do return
    if initvalue == nil do return
    if !ComConnected() do return

    hr := (^InitValuesIF)(initvalues)->Add(initvalue)
    if ComFailed(hr) do return

    return true
}

_AddInitValueAtIndex :: proc(initvalues: InitValues, initvalue: InitValue, index: i32) -> (ok: bool)
{
    if initvalues == nil do return
    if initvalue == nil do return
    if !ComConnected() do return

    hr := (^InitValuesIF)(initvalues)->AddBefore(initvalue, index)
    if ComFailed(hr) do return

    return true
}

GetInitValue :: proc {
    _GetInitValueWithName,
    _GetInitValueAtIndex
}

_GetInitValueWithName :: proc(initvalues: InitValues, pou_path, name: string) -> (initvalue: InitValue, ok: bool)
{
    if initvalues == nil do return
    if !ComConnected() do return

    bstr_pou  := ToBstr(pou_path)
    bstr_name := ToBstr(name)
    defer {
        FreeBstr(bstr_pou)
        FreeBstr(bstr_name)
    }
    hr := (^InitValuesIF)(initvalues)->Find(bstr_pou, bstr_name, cast(^rawptr)&initvalue)
    if ComFailed(hr) do return

    return initvalue, true
}

_GetInitValueAtIndex :: proc(initvalues: InitValues, index: i32) -> (initvalue: InitValue, ok: bool)
{
    if initvalues == nil do return
    if !ComConnected() do return

    hr := (^InitValuesIF)(initvalues)->Item(index + 1, cast(^rawptr)&initvalue)
    if ComFailed(hr) do return

    return initvalue, true
}

InitValueIndex :: proc(initvalues: InitValues, pou_path, name: string) -> (index: i32, ok: bool)
{
    if initvalues == nil do return
    if !ComConnected() do return

    bstr_pou  := ToBstr(pou_path)
    bstr_name := ToBstr(name)
    defer {
        FreeBstr(bstr_pou)
        FreeBstr(bstr_name)
    }
    hr := (^InitValuesIF)(initvalues)->FindNr(bstr_pou, bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

InitValueCount :: proc(initvalues: InitValues) -> (count: i32, ok: bool)
{
    if initvalues == nil do return
    if !ComConnected() do return

    hr := (^InitValuesIF)(initvalues)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveInitValue :: proc {
    _RemoveInitValueWithName,
    _RemoveInitValueAtIndex,
}

_RemoveInitValueWithName :: proc(initvalues: InitValues, pou_path, name: string) -> (ok: bool)
{
    if initvalues == nil do return
    if !ComConnected() do return

    index, found := InitValueIndex(initvalues, pou_path, name)
    if !found do return

    hr := (^InitValuesIF)(initvalues)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveInitValueAtIndex :: proc(initvalues: InitValues, index: i32) -> (ok: bool)
{
    if initvalues == nil do return
    if !ComConnected() do return

    hr := (^InitValuesIF)(initvalues)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseInitValues :: proc(initvalues: InitValues)
{
    if initvalues != nil {
        (^InitValuesIF)(initvalues)->Release()
    }
}

InitValueIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^InitValueVTable,
}

InitValueVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    POUPathGet: proc "system" (this: ^InitValueIF, POUPath: ^BStr) -> HResult,
    POUPathPut: proc "system" (this: ^InitValueIF, POUPath: BStr) -> HResult,
    NameGet:    proc "system" (this: ^InitValueIF, Name: ^BStr) -> HResult,
    NamePut:    proc "system" (this: ^InitValueIF, Name: BStr) -> HResult,
    ValueGet:   proc "system" (this: ^InitValueIF, Value: ^BStr) -> HResult,
    ValuePut:   proc "system" (this: ^InitValueIF, Value: BStr) -> HResult,
    Serialize:  proc "system" (this: ^InitValueIF, XML: ^BStr) -> HResult,
}

SerializeInitValue :: proc(initvalue: InitValue) -> (xml: string, ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetInitValuePOUPath :: proc(initvalue: InitValue) -> (pou_path: string, ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->POUPathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetInitValuePOUPath :: proc(initvalue: InitValue, pou_path: string) -> (ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs := ToBstr(pou_path)
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->POUPathPut(bs)
    if ComFailed(hr) do return

    return true
}

GetInitValueName :: proc(initvalue: InitValue) -> (name: string, ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetInitValueName :: proc(initvalue: InitValue, name: string) -> (ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetInitValueValue :: proc(initvalue: InitValue) -> (value: string, ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->ValueGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetInitValueValue :: proc(initvalue: InitValue, value: string) -> (ok: bool)
{
    if initvalue == nil do return
    if !ComConnected() do return

    bs := ToBstr(value)
    defer FreeBstr(bs)
    hr := (^InitValueIF)(initvalue)->ValuePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseInitValue :: proc(initvalue: InitValue)
{
    if initvalue != nil {
        (^InitValueIF)(initvalue)->Release()
    }
}
