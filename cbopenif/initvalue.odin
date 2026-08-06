package cbopenif

InitValue :: distinct rawptr

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

initvalue_new :: proc(pou_path, name, value: string) -> (initvalue: InitValue, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_pou   := to_bstr(pou_path)
    bstr_name  := to_bstr(name)
    bstr_value := to_bstr(value)
    defer {
        bstr_free(bstr_pou)
        bstr_free(bstr_name)
        bstr_free(bstr_value)
    }

    hr := factoryif->NewInitValue(bstr_pou, bstr_name, bstr_value, cast(^rawptr)&initvalue)
    if com_failed(hr) do return

    return initvalue, true
}

initvalue_serialize :: proc(initvalue: InitValue) -> (xml: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_pou_path :: proc {
    initvalue_pou_path_get,
    initvalue_pou_path_set,
}

initvalue_pou_path_get :: proc(initvalue: InitValue) -> (pou_path: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->POUPathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_pou_path_set :: proc(initvalue: InitValue, pou_path: string) -> (ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(pou_path)
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->POUPathPut(bs)
    if com_failed(hr) do return

    return true
}

initvalue_name :: proc {
    initvalue_name_get,
    initvalue_name_set,
}

initvalue_name_get :: proc(initvalue: InitValue) -> (name: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_name_set :: proc(initvalue: InitValue, name: string) -> (ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

initvalue_value :: proc {
    initvalue_value_get,
    initvalue_value_set,
}

initvalue_value_get :: proc(initvalue: InitValue) -> (value: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->ValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

initvalue_value_set :: proc(initvalue: InitValue, value: string) -> (ok: bool) {
    if initvalue == nil do return
    if !controlbuilder_connected() do return

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
