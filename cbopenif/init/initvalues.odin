package init

import "../com"
import "../controlbuilder"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

InitValues :: distinct rawptr

InitValuesIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^InitValuesVTable,
}

InitValuesVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^InitValuesIF, InitValue: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^InitValuesIF, InitValue: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^InitValuesIF, POUPath, Name, Value: BStr, InitValue: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^InitValuesIF, POUPath, Name: BStr, InitValue: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^InitValuesIF, POUPath, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^InitValuesIF, Index: i32, InitValue: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^InitValuesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^InitValuesIF, Index: i32) -> HResult,
}

initvalues_add :: proc {
    initvalues_add_,
    initvalues_add_at_index,
}

initvalues_add_ :: proc(initvalues: InitValues, initvalue: InitValue) -> (ok: bool) {
    if initvalues == nil do return
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Add(initvalue)
    if com.failed(hr) do return

    return true
}

initvalues_add_at_index :: proc(initvalues: InitValues, initvalue: InitValue, index: i32) -> (ok: bool) {
    if initvalues == nil do return
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->AddBefore(initvalue, index)
    if com.failed(hr) do return

    return true
}

initvalues_value :: proc {
    initvalues_value_by_name,
    initvalues_value_by_index,
}

initvalues_value_by_name :: proc(initvalues: InitValues, pou_path, name: string) -> (initvalue: InitValue, ok: bool) {
    if initvalues == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bstr_pou  := com.from_string(pou_path)
    bstr_name := com.from_string(name)
    defer {
        com.bstr_free(bstr_pou)
        com.bstr_free(bstr_name)
    }
    hr := (^InitValuesIF)(initvalues)->Find(bstr_pou, bstr_name, cast(^rawptr)&initvalue)
    if com.failed(hr) do return

    return initvalue, true
}

initvalues_value_by_index :: proc(initvalues: InitValues, index: i32) -> (initvalue: InitValue, ok: bool) {
    if initvalues == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Item(index, cast(^rawptr)&initvalue)
    if com.failed(hr) do return

    return initvalue, true
}

initvalues_value_index :: proc(initvalues: InitValues, pou_path, name: string) -> (index: i32, ok: bool) {
    if initvalues == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bstr_pou  := com.from_string(pou_path)
    bstr_name := com.from_string(name)
    defer {
        com.bstr_free(bstr_pou)
        com.bstr_free(bstr_name)
    }
    hr := (^InitValuesIF)(initvalues)->FindNr(bstr_pou, bstr_name, &index)
    if com.failed(hr) do return

    return index, true
}

initvalues_count :: proc(initvalues: InitValues) -> (count: i32, ok: bool) {
    if initvalues == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

initvalues_remove :: proc {
    initvalues_remove_by_name,
    initvalues_remove_by_index,
}

initvalues_remove_by_name :: proc(initvalues: InitValues, pou_path, name: string) -> (ok: bool) {
    if initvalues == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    index, found := initvalues_value_index(initvalues, pou_path, name)
    if !found do return

    hr := (^InitValuesIF)(initvalues)->Remove(index)
    if com.failed(hr) do return

    return true
}

initvalues_remove_by_index :: proc(initvalues: InitValues, index: i32) -> (ok: bool) {
    if initvalues == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Remove(index)
    if com.failed(hr) do return

    return true
}

initvalues_release :: proc(initvalues: InitValues) {
    if initvalues != nil {
        (^InitValuesIF)(initvalues)->Release()
    }
}
