package codeblock

LDCodeBlock :: distinct rawptr

LDCodeBlockIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^LDCodeBlockVTable,
}

LDCodeBlockVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
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
    ldcodeblock = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_stcode := string_to_bstr(stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
    }
    hr := factoryif->NewLDCodeBlock1(bstr_name, &bstr_stcode, cast(^LDCodeBlock)&ldcodeblock)
    if failed(hr) do return

    return ldcodeblock, true
}

ldcodeblock_serialize :: proc(ldcodeblock: LDCodeBlock) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if ldcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^LDCodeBlockIF)(ldcodeblock)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

ldcodeblock_name :: proc {
    ldcodeblock_name_,
    ldcodeblock_name_set,
}

@(private)
ldcodeblock_name_ :: proc(ldcodeblock: LDCodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if ldcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
ldcodeblock_name_set :: proc(ldcodeblock: LDCodeBlock, name: string) -> (ok: bool) {
    ok = false
    
    if ldcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NamePut(bstr)
    if failed(hr) do return

    return true
}

ldcodeblock_stcode :: proc {
    ldcodeblock_stcode_,
    ldcodeblock_stcode_set,
}

@(private)
ldcodeblock_stcode_ :: proc(ldcodeblock: LDCodeBlock) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if ldcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
ldcodeblock_stcode_set :: proc(ldcodeblock: LDCodeBlock, stcode: string) -> (ok: bool) {
    ok = false
    
    if ldcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodePut(bstr)
    if failed(hr) do return

    return true
}

ldcodeblock_release :: proc(ldcodeblock: LDCodeBlock) {
    if ldcodeblock != nil {
        (^LDCodeBlockIF)(ldcodeblock)->Release()
    }
}
