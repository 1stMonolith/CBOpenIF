package cbopenif

STCodeBlock :: distinct rawptr

STCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^STCodeBlockVTable,
}

STCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^STCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^STCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^STCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^STCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^STCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

stcodeblock_new :: proc(name, stcode: string) -> (stcodeblock: STCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_stcode := to_bstr(stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
    }
    hr := factoryif->NewSTCodeBlock1(bstr_name, &bstr_stcode, cast(^rawptr)&stcodeblock)
    if com_failed(hr) do return

    return stcodeblock, true
}

stcodeblock_serialize :: proc(stcodeblock: STCodeBlock) -> (xml: string, ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

stcodeblock_name :: proc {
    stcodeblock_name_get,
    stcodeblock_name_set,
}

stcodeblock_name_get :: proc(stcodeblock: STCodeBlock) -> (name: string, ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

stcodeblock_name_set :: proc(stcodeblock: STCodeBlock, name: string) -> (ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

stcodeblock_stcode :: proc {
    stcodeblock_stcode_get,
    stcodeblock_stcode_set,
}

stcodeblock_stcode_get :: proc(stcodeblock: STCodeBlock) -> (stcode: string, ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

stcodeblock_stcode_set :: proc(stcodeblock: STCodeBlock, stcode: string) -> (ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

stcodeblock_release :: proc(stcodeblock: STCodeBlock) {
    if stcodeblock != nil {
        (^STCodeBlockIF)(stcodeblock)->Release()
    }
}
