package codeblock

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

ILCodeBlock :: distinct rawptr

ILCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ILCodeBlockVTable,
}

ILCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:   proc "system" (this: ^ILCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^ILCodeBlockIF, Name: BStr) -> HResult,
    ILRowsGet: proc "system" (this: ^ILCodeBlockIF, ILRows: ^rawptr) -> HResult,
    Missing10: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    ILRowsPut: proc "system" (this: ^ILCodeBlockIF, ILRows: rawptr) -> HResult,
    Missing12: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Missing14: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^ILCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

ilcodeblock_new :: proc(name: string) -> (ilcodeblock: ILCodeBlock, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return

    bstr_name := com.from_string(name)
    com.bstr_free(bstr_name)
    hr := factory.factoryif->NewILCodeBlock(bstr_name, cast(^rawptr)&ilcodeblock)
    if com.failed(hr) do return

    return ilcodeblock, true
}

ilcodeblock_serialize :: proc(ilcodeblock: ILCodeBlock) -> (xml: string, ok: bool) {

    if ilcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

ilcodeblock_name :: proc {
    ilcodeblock_name_get,
    ilcodeblock_name_set,
}

ilcodeblock_name_get :: proc(ilcodeblock: ILCodeBlock) -> (name: string, ok: bool) {

    if ilcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

ilcodeblock_name_set :: proc(ilcodeblock: ILCodeBlock, name: string) -> (ok: bool) {
    
    if ilcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

ilcodeblock_stcode :: proc {
    ilcodeblock_stcode_get,
    ilcodeblock_stcode_set,
}

ilcodeblock_stcode_get :: proc(ilcodeblock: ILCodeBlock) -> (ilrows: rawptr, ok: bool) {

    if ilcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsGet(&ilrows)
    if com.failed(hr) do return

    return ilrows, true
}

ilcodeblock_stcode_set :: proc(ilcodeblock: ILCodeBlock, ilrows: rawptr) -> (ok: bool) {
    
    if ilcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsPut(ilrows)
    if com.failed(hr) do return

    return true
}

ilcodeblock_release :: proc(ilcodeblock: ILCodeBlock) {
    if ilcodeblock != nil {
        (^ILCodeBlockIF)(ilcodeblock)->Release()
    }
}
