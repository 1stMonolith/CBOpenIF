package cbopenif

InitValues :: distinct rawptr

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

initvalues_initvalue_add :: proc {
    initvalues_initvalue_add_,
    initvalues_initvalue_add_at_index,
}

initvalues_initvalue_add_ :: proc(initvalues: InitValues, initvalue: InitValue) -> (ok: bool) {
    if initvalues == nil do return
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Add(initvalue)
    if com_failed(hr) do return

    return true
}

initvalues_initvalue_add_at_index :: proc(initvalues: InitValues, initvalue: InitValue, index: i32) -> (ok: bool) {
    if initvalues == nil do return
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->AddBefore(initvalue, index)
    if com_failed(hr) do return

    return true
}

initvalues_initvalue :: proc {
    initvalues_initvalue_by_name,
    initvalues_initvalue_by_index,
}

initvalues_initvalue_by_name :: proc(initvalues: InitValues, pou_path, name: string) -> (initvalue: InitValue, ok: bool) {
    if initvalues == nil do return
    if !controlbuilder_connected() do return

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
    if !controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Item(index + 1, cast(^rawptr)&initvalue)
    if com_failed(hr) do return

    return initvalue, true
}

initvalues_initvalue_index :: proc(initvalues: InitValues, pou_path, name: string) -> (index: i32, ok: bool) {
    if initvalues == nil do return
    if !controlbuilder_connected() do return

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
    if !controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

initvalues_initvalue_remove :: proc {
    initvalues_initvalue_remove_by_name,
    initvalues_initvalue_remove_by_index,
}

initvalues_initvalue_remove_by_name :: proc(initvalues: InitValues, pou_path, name: string) -> (ok: bool) {
    if initvalues == nil do return
    if !controlbuilder_connected() do return

    index, found := initvalues_initvalue_index(initvalues, pou_path, name)
    if !found do return

    hr := (^InitValuesIF)(initvalues)->Remove(index)
    if com_failed(hr) do return

    return true
}

initvalues_initvalue_remove_by_index :: proc(initvalues: InitValues, index: i32) -> (ok: bool) {
    if initvalues == nil do return
    if !controlbuilder_connected() do return

    hr := (^InitValuesIF)(initvalues)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

initvalues_release :: proc(initvalues: InitValues) {
    if initvalues != nil {
        (^InitValuesIF)(initvalues)->Release()
    }
}
