package cbopenif

ILCodeBlock :: distinct rawptr

ILCodeBlockIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ILCodeBlockVTable,
}

ILCodeBlockVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    NameGet:   proc "system" (this: ^ILCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^ILCodeBlockIF, Name: BStr) -> HResult,
    ILRowsGet: proc "system" (this: ^ILCodeBlockIF, ILRows: ^ILRows) -> HResult,
    Missing10: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    ILRowsPut: proc "system" (this: ^ILCodeBlockIF, ILRows: ILRows) -> HResult,
    Missing12: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Missing14: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^ILCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

ilcodeblock_new :: proc(name: string) -> (ilcodeblock: ILCodeBlock, ok: bool) {
    ilcodeblock = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := factoryif->NewILCodeBlock(bstr_name, cast(^ILCodeBlock)&ilcodeblock)
    if failed(hr) do return

    return ilcodeblock, true
}

ilcodeblock_serialize :: proc(ilcodeblock: ILCodeBlock) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if ilcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ILCodeBlockIF)(ilcodeblock)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

ilcodeblock_name :: proc {
    ilcodeblock_name_,
    ilcodeblock_name_set,
}

@(private)
ilcodeblock_name_ :: proc(ilcodeblock: ILCodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if ilcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
ilcodeblock_name_set :: proc(ilcodeblock: ILCodeBlock, name: string) -> (ok: bool) {
    ok = false
    
    if ilcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NamePut(bstr)
    if failed(hr) do return

    return true
}

ilcodeblock_stcode :: proc {
    ilcodeblock_stcode_,
    ilcodeblock_stcode_set,
}

@(private)
ilcodeblock_stcode_ :: proc(ilcodeblock: ILCodeBlock) -> (ilrows: ILRows, ok: bool) {
    ilrows = nil
    ok = false

    if ilcodeblock == nil do return
    if !connected() do return
    
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsGet(&ilrows)
    if failed(hr) do return

    return ilrows, true
}

@(private)
ilcodeblock_stcode_set :: proc(ilcodeblock: ILCodeBlock, ilrows: ILRows) -> (ok: bool) {
    ok = false
    
    if ilcodeblock == nil do return
    if !connected() do return
    
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsPut(ilrows)
    if failed(hr) do return

    return true
}

ilcodeblock_release :: proc(ilcodeblock: ILCodeBlock) {
    if ilcodeblock != nil {
        (^ILCodeBlockIF)(ilcodeblock)->Release()
    }
}
