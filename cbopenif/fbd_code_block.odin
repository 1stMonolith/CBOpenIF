package cbopenif

FBDCodeBlock :: distinct rawptr

FBDCodeBlockIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^FBDCodeBlockVTable,
}

FBDCodeBlockVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
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
    fbdcodeblock = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_stcode := string_to_bstr(stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
    }
    hr := factoryif->NewFBDCodeBlock1(bstr_name, &bstr_stcode, cast(^FBDCodeBlock)&fbdcodeblock)
    if failed(hr) do return

    return fbdcodeblock, true
}

fbdcodeblock_serialize :: proc(fbdcodeblock: FBDCodeBlock) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if fbdcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

fbdcodeblock_name :: proc {
    fbdcodeblock_name_,
    fbdcodeblock_name_set,
}

@(private)
fbdcodeblock_name_ :: proc(fbdcodeblock: FBDCodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if fbdcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
fbdcodeblock_name_set :: proc(fbdcodeblock: FBDCodeBlock, name: string) -> (ok: bool) {
    ok = false
    
    if fbdcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NamePut(bstr)
    if failed(hr) do return

    return true
}

fbdcodeblock_stcode :: proc {
    fbdcodeblock_stcode_,
    fbdcodeblock_stcode_set,
}

@(private)
fbdcodeblock_stcode_ :: proc(fbdcodeblock: FBDCodeBlock) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if fbdcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
fbdcodeblock_stcode_set :: proc(fbdcodeblock: FBDCodeBlock, stcode: string) -> (ok: bool) {
    ok = false
    
    if fbdcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodePut(bstr)
    if failed(hr) do return

    return true
}

fbdcodeblock_release :: proc(fbdcodeblock: FBDCodeBlock) {
    if fbdcodeblock != nil {
        (^FBDCodeBlockIF)(fbdcodeblock)->Release()
    }
}
