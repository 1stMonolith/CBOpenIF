package cbopenif

FBDCodeBlock :: distinct rawptr

FBDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FBDCodeBlockVTable,
}

FBDCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^FBDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^FBDCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^FBDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^FBDCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^FBDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

fbdcodeblock_new :: proc(name, stcode: string) -> (fbdcodeblock: FBDCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_stcode := to_bstr(stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
    }
    hr := factoryif->NewFBDCodeBlock1(bstr_name, &bstr_stcode, cast(^rawptr)&fbdcodeblock)
    if com_failed(hr) do return

    return fbdcodeblock, true
}

fbdcodeblock_serialize :: proc(fbdcodeblock: FBDCodeBlock) -> (xml: string, ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

fbdcodeblock_name :: proc {
    fbdcodeblock_name_get,
    fbdcodeblock_name_set,
}

fbdcodeblock_name_get :: proc(fbdcodeblock: FBDCodeBlock) -> (name: string, ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}


fbdcodeblock_name_set :: proc(fbdcodeblock: FBDCodeBlock, name: string) -> (ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

fbdcodeblock_stcode :: proc {
    fbdcodeblock_stcode_get,
    fbdcodeblock_stcode_set,
}

fbdcodeblock_stcode_get :: proc(fbdcodeblock: FBDCodeBlock) -> (stcode: string, ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

fbdcodeblock_stcode_set :: proc(fbdcodeblock: FBDCodeBlock, stcode: string) -> (ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

fbdcodeblock_release :: proc(fbdcodeblock: FBDCodeBlock) {
    if fbdcodeblock != nil {
        (^FBDCodeBlockIF)(fbdcodeblock)->Release()
    }
}
