package cbopenif

STCodeBlock :: distinct rawptr

STCodeBlockIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^STCodeBlockVTable,
}

STCodeBlockVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
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
    stcodeblock = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_stcode := string_to_bstr(stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
    }
    hr := factoryif->NewSTCodeBlock1(bstr_name, &bstr_stcode, cast(^STCodeBlock)&stcodeblock)
    if failed(hr) do return

    return stcodeblock, true
}

stcodeblock_serialize :: proc(stcodeblock: STCodeBlock) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if stcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^STCodeBlockIF)(stcodeblock)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

stcodeblock_name :: proc {
    stcodeblock_name_,
    stcodeblock_name_set,
}

@(private)
stcodeblock_name_ :: proc(stcodeblock: STCodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if stcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^STCodeBlockIF)(stcodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
stcodeblock_name_set :: proc(stcodeblock: STCodeBlock, name: string) -> (ok: bool) {
    ok = false
    
    if stcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^STCodeBlockIF)(stcodeblock)->NamePut(bstr)
    if failed(hr) do return

    return true
}

stcodeblock_stcode :: proc {
    stcodeblock_stcode_,
    stcodeblock_stcode_set,
}

@(private)
stcodeblock_stcode_ :: proc(stcodeblock: STCodeBlock) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if stcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
stcodeblock_stcode_set :: proc(stcodeblock: STCodeBlock, stcode: string) -> (ok: bool) {
    ok = false
    
    if stcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodePut(bstr)
    if failed(hr) do return

    return true
}

stcodeblock_release :: proc(stcodeblock: STCodeBlock) {
    if stcodeblock != nil {
        (^STCodeBlockIF)(stcodeblock)->Release()
    }
}
