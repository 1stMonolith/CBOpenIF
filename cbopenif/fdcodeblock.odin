package cbopenif

FDCodeBlock :: distinct rawptr

FDCodeBlockIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^FDCodeBlockVTable,
}

FDCodeBlockVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    NameGet:    proc "system" (this: ^FDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:    proc "system" (this: ^FDCodeBlockIF, Name: BStr) -> HResult,
    Missing9:   proc "system" (this: ^FDCodeBlockIF) -> HResult,
    Missing10:  proc "system" (this: ^FDCodeBlockIF) -> HResult,
    Missing11:  proc "system" (this: ^FDCodeBlockIF) -> HResult,
    FDAsXMLGet: proc "system" (this: ^FDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    FDAsXMLPut: proc "system" (this: ^FDCodeBlockIF, XMLStr: BStr) -> HResult,
    Serialize:  proc "system" (this: ^FDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

fdcodeblock_serialize :: proc(fdcodeblock: FDCodeBlock) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if fdcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^FDCodeBlockIF)(fdcodeblock)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

fdcodeblock_name :: proc {
    fdcodeblock_name_,
    fdcodeblock_name_set,
}

@(private)
fdcodeblock_name_ :: proc(fdcodeblock: FDCodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if fdcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
fdcodeblock_name_set :: proc(fdcodeblock: FDCodeBlock, name: string) -> (ok: bool) {
    ok = false
    
    if fdcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NamePut(bstr)
    if failed(hr) do return

    return true
}

fdcodeblock_xml_string :: proc {
    fdcodeblock_xml_string_,
    fdcodeblock_xml_string_set,
}

@(private)
fdcodeblock_xml_string_ :: proc(fdcodeblock: FDCodeBlock) -> (xml_string: string, ok: bool) {
    xml_string = ""
    ok = false

    if fdcodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
fdcodeblock_xml_string_set :: proc(fdcodeblock: FDCodeBlock, xml_string: string) -> (ok: bool) {
    ok = false
    
    if fdcodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(xml_string)
    defer bstr_free(bstr)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLPut(bstr)
    if failed(hr) do return

    return true
}

fdcodeblock_release :: proc(fdcodeblock: FDCodeBlock) {
    if fdcodeblock != nil {
        (^FDCodeBlockIF)(fdcodeblock)->Release()
    }
}
