package cbopenif

ILCodeBlock :: distinct rawptr

ILCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILCodeBlockVTable,
}

ILCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_free(bstr_name)
    hr := factoryif->NewILCodeBlock(bstr_name, cast(^rawptr)&ilcodeblock)
    if com_failed(hr) do return

    return ilcodeblock, true
}

ilcodeblock_serialize :: proc(ilcodeblock: ILCodeBlock) -> (xml: string, ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

ilcodeblock_name :: proc {
    ilcodeblock_name_get,
    ilcodeblock_name_set,
}

ilcodeblock_name_get :: proc(ilcodeblock: ILCodeBlock) -> (name: string, ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilcodeblock_name_set :: proc(ilcodeblock: ILCodeBlock, name: string) -> (ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

ilcodeblock_ilrows :: proc {
    ilcodeblock_ilrows_get,
    ilcodeblock_ilrows_set,
}

ilcodeblock_ilrows_get :: proc(ilcodeblock: ILCodeBlock) -> (ilrows: ILRows, ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsGet(&p)
    if com_failed(hr) do return

    return ILRows(p), true
}

ilcodeblock_ilrows_set :: proc(ilcodeblock: ILCodeBlock, ilrows: ILRows) -> (ok: bool) {
    if ilcodeblock == nil do return
    if ilrows == nil do return
    if !controlbuilder_connected() do return

    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsPut(ilrows)
    if com_failed(hr) do return

    return true
}

ilcodeblock_release :: proc(ilcodeblock: ILCodeBlock) {
    if ilcodeblock != nil {
        (^ILCodeBlockIF)(ilcodeblock)->Release()
    }
}
