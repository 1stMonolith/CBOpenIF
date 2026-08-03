package codeblock

import "../com"
import "../controlbuilder"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

FDCodeBlock :: distinct rawptr

FDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^FDCodeBlockVTable,
}

FDCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

    if fdcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return com.to_string(bs), true
}

fdcodeblock_name :: proc {
    fdcodeblock_name_get,
    fdcodeblock_name_set,
}

fdcodeblock_name_get :: proc(fdcodeblock: FDCodeBlock) -> (name: string, ok: bool) {

    if fdcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

fdcodeblock_name_set :: proc(fdcodeblock: FDCodeBlock, name: string) -> (ok: bool) {
    
    if fdcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs :=com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

fdcodeblock_xml_string :: proc {
    fdcodeblock_xml_string_get,
    fdcodeblock_xml_string_set,
}

fdcodeblock_xml_string_get :: proc(fdcodeblock: FDCodeBlock) -> (xml_string: string, ok: bool) {

    if fdcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer com.bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

fdcodeblock_xml_string_set :: proc(fdcodeblock: FDCodeBlock, xml_string: string) -> (ok: bool) {
    
    if fdcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs :=com.from_string(xml_string)
    defer com.bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLPut(bs)
    if com.failed(hr) do return

    return true
}

fdcodeblock_release :: proc(fdcodeblock: FDCodeBlock) {
    if fdcodeblock != nil {
        (^FDCodeBlockIF)(fdcodeblock)->Release()
    }
}
