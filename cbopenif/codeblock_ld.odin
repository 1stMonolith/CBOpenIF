package cbopenif

LDCodeBlock :: distinct rawptr

LDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^LDCodeBlockVTable,
}

LDCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^LDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^LDCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^LDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^LDCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^LDCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^LDCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^LDCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^LDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

ldcodeblock_new :: proc(name, stcode: string) -> (ldcodeblock: LDCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_stcode := to_bstr(stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
    }
    hr := factoryif->NewLDCodeBlock1(bstr_name, &bstr_stcode, cast(^rawptr)&ldcodeblock)
    if com_failed(hr) do return

    return ldcodeblock, true
}

ldcodeblock_serialize :: proc(ldcodeblock: LDCodeBlock) -> (xml: string, ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

ldcodeblock_name :: proc {
    ldcodeblock_name_get,
    ldcodeblock_name_set,
}

ldcodeblock_name_get :: proc(ldcodeblock: LDCodeBlock) -> (name: string, ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ldcodeblock_name_set :: proc(ldcodeblock: LDCodeBlock, name: string) -> (ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

ldcodeblock_stcode :: proc {
    ldcodeblock_stcode_get,
    ldcodeblock_stcode_set,
}

ldcodeblock_stcode_get :: proc(ldcodeblock: LDCodeBlock) -> (stcode: string, ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ldcodeblock_stcode_set :: proc(ldcodeblock: LDCodeBlock, stcode: string) -> (ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

ldcodeblock_release :: proc(ldcodeblock: LDCodeBlock) {
    if ldcodeblock != nil {
        (^LDCodeBlockIF)(ldcodeblock)->Release()
    }
}
