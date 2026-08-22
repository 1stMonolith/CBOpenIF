package com

InitValue  :: distinct rawptr
InitValues :: distinct rawptr

InitValueIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^InitValueVTable,
}

InitValueVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    POUPathGet: proc "system" (this: ^InitValueIF, POUPath: ^BStr) -> HResult,
    POUPathPut: proc "system" (this: ^InitValueIF, POUPath: BStr) -> HResult,
    NameGet:    proc "system" (this: ^InitValueIF, Name: ^BStr) -> HResult,
    NamePut:    proc "system" (this: ^InitValueIF, Name: BStr) -> HResult,
    ValueGet:   proc "system" (this: ^InitValueIF, Value: ^BStr) -> HResult,
    ValuePut:   proc "system" (this: ^InitValueIF, Value: BStr) -> HResult,
    Serialize:  proc "system" (this: ^InitValueIF, XML: ^BStr) -> HResult,
}

initvalue_serialize :: proc(initvalue: InitValue) -> (xml: string, ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_pou_path_get :: proc(initvalue: InitValue) -> (pou_path: string, ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->POUPathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_pou_path_set :: proc(initvalue: InitValue, pou_path: string) -> (ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs := to_bstr(pou_path)
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->POUPathPut(bs)
    if com_failed(hr) do return

    return true
}

initvalue_name_get :: proc(initvalue: InitValue) -> (name: string, ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_name_set :: proc(initvalue: InitValue, name: string) -> (ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

initvalue_value_get :: proc(initvalue: InitValue) -> (value: string, ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->ValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_value_set :: proc(initvalue: InitValue, value: string) -> (ok: bool) {
    if initvalue == nil do return
    if !com_connected() do return

    bs := to_bstr(value)
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->ValuePut(bs)
    if com_failed(hr) do return

    return true
}

initvalue_release :: proc(initvalue: InitValue) {
    if initvalue != nil {
        (^InitValueIF)(initvalue)->Release()
    }
}

InitValuesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^InitValuesVTable,
}

InitValuesVTable :: struct {
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

initvalues_initvalue_add :: proc(initvalues: InitValues, initvalue: InitValue) -> (ok: bool) {
    if initvalues == nil do return
    if initvalue == nil do return
    if !com_connected() do return

    hr := (^InitValuesIF)(initvalues)->Add(initvalue)
    if com_failed(hr) do return

    return true
}

initvalues_initvalue_add_at_index :: proc(initvalues: InitValues, initvalue: InitValue, index: i32) -> (ok: bool) {
    if initvalues == nil do return
    if initvalue == nil do return
    if !com_connected() do return

    hr := (^InitValuesIF)(initvalues)->AddBefore(initvalue, index)
    if com_failed(hr) do return

    return true
}

initvalues_initvalue_by_name :: proc(initvalues: InitValues, pou_path, name: string) -> (initvalue: InitValue, ok: bool) {
    if initvalues == nil do return
    if !com_connected() do return

    bstr_pou  := to_bstr(pou_path)
    bstr_name := to_bstr(name)
    defer {
        bstr_free(bstr_pou)
        bstr_free(bstr_name)
    }
    hr := (^InitValuesIF)(initvalues)->Find(bstr_pou, bstr_name, cast(^rawptr)&initvalue)
    if com_failed(hr) do return

    return initvalue, true
}

initvalues_initvalue_by_index :: proc(initvalues: InitValues, index: i32) -> (initvalue: InitValue, ok: bool) {
    if initvalues == nil do return
    if !com_connected() do return

    hr := (^InitValuesIF)(initvalues)->Item(index + 1, cast(^rawptr)&initvalue)
    if com_failed(hr) do return

    return initvalue, true
}

initvalues_initvalue_index :: proc(initvalues: InitValues, pou_path, name: string) -> (index: i32, ok: bool) {
    if initvalues == nil do return
    if !com_connected() do return

    bstr_pou  := to_bstr(pou_path)
    bstr_name := to_bstr(name)
    defer {
        bstr_free(bstr_pou)
        bstr_free(bstr_name)
    }
    hr := (^InitValuesIF)(initvalues)->FindNr(bstr_pou, bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

initvalues_initvalue_count :: proc(initvalues: InitValues) -> (count: i32, ok: bool) {
    if initvalues == nil do return
    if !com_connected() do return

    hr := (^InitValuesIF)(initvalues)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

initvalues_initvalue_remove_by_name :: proc(initvalues: InitValues, pou_path, name: string) -> (ok: bool) {
    if initvalues == nil do return
    if !com_connected() do return

    index, found := initvalues_initvalue_index(initvalues, pou_path, name)
    if !found do return

    hr := (^InitValuesIF)(initvalues)->Remove(index)
    if com_failed(hr) do return

    return true
}

initvalues_initvalue_remove_by_index :: proc(initvalues: InitValues, index: i32) -> (ok: bool) {
    if initvalues == nil do return
    if !com_connected() do return

    hr := (^InitValuesIF)(initvalues)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

initvalues_release :: proc(initvalues: InitValues) {
    if initvalues != nil {
        (^InitValuesIF)(initvalues)->Release()
    }
}
