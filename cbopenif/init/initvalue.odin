package init

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

InitValue :: distinct rawptr

InitValueIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^InitValueVTable,
}

InitValueVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    POUPathGet: proc "system" (this: ^InitValueIF, POUPath: ^BStr) -> HResult,
    POUPathPut: proc "system" (this: ^InitValueIF, POUPath: BStr) -> HResult,
    NameGet:    proc "system" (this: ^InitValueIF, Name: ^BStr) -> HResult,
    NamePut:    proc "system" (this: ^InitValueIF, Name: BStr) -> HResult,
    ValueGet:   proc "system" (this: ^InitValueIF, Value: ^BStr) -> HResult,
    ValuePut:   proc "system" (this: ^InitValueIF, Value: BStr) -> HResult,
    Serialize:  proc "system" (this: ^InitValueIF, XML: ^BStr) -> HResult,
}

initvalue_new :: proc(pou_path, name, value: string) -> (initvalue: InitValue, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bstr_pou   := com.from_string(pou_path)
    bstr_name  := com.from_string(name)
    bstr_value := com.from_string(value)
    defer {
        com.bstr_free(bstr_pou)
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_value)
    }

    hr := factory.factoryif->NewInitValue(bstr_pou, bstr_name, bstr_value, cast(^rawptr)&initvalue)
    if com.failed(hr) do return

    return initvalue, true
}

initvalue_serialize :: proc(initvalue: InitValue) -> (xml: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->Serialize(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

initvalue_pou_path :: proc {
    initvalue_pou_path_get,
    initvalue_pou_path_set,
}

initvalue_pou_path_get :: proc(initvalue: InitValue) -> (pou_path: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->POUPathGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

initvalue_pou_path_set :: proc(initvalue: InitValue, pou_path: string) -> (ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(pou_path)
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->POUPathPut(bs)
    if com.failed(hr) do return

    return true
}

initvalue_name :: proc {
    initvalue_name_get,
    initvalue_name_set,
}

initvalue_name_get :: proc(initvalue: InitValue) -> (name: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

initvalue_name_set :: proc(initvalue: InitValue, name: string) -> (ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

initvalue_value :: proc {
    initvalue_value_get,
    initvalue_value_set,
}

initvalue_value_get :: proc(initvalue: InitValue) -> (value: string, ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->ValueGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

initvalue_value_set :: proc(initvalue: InitValue, value: string) -> (ok: bool) {
    if initvalue == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(value)
    defer com.bstr_free(bs)
    hr := (^InitValueIF)(initvalue)->ValuePut(bs)
    if com.failed(hr) do return

    return true
}

initvalue_release :: proc(initvalue: InitValue) {
    if initvalue != nil {
        (^InitValueIF)(initvalue)->Release()
    }
}
