package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"

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

fdcodeblock_serialize :: proc(fdcodeblock: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if fdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

fdcodeblock_name :: proc {
    fdcodeblock_name_,
    fdcodeblock_name_set,
}

@(private)
fdcodeblock_name_ :: proc(fdcodeblock: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if fdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
fdcodeblock_name_set :: proc(fdcodeblock: rawptr, name: string) -> (ok: bool) {
    ok = false
    
    if fdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs :=bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

fdcodeblock_xml_string :: proc {
    fdcodeblock_xml_string_,
    fdcodeblock_xml_string_set,
}

@(private)
fdcodeblock_xml_string_ :: proc(fdcodeblock: rawptr) -> (xml_string: string, ok: bool) {
    xml_string = ""
    ok = false

    if fdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
fdcodeblock_xml_string_set :: proc(fdcodeblock: rawptr, xml_string: string) -> (ok: bool) {
    ok = false
    
    if fdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs :=bstr.from_string(xml_string)
    defer bstr.free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLPut(bs)
    if com.failed(hr) do return

    return true
}

fdcodeblock_release :: proc(fdcodeblock: rawptr) {
    if fdcodeblock != nil {
        (^FDCodeBlockIF)(fdcodeblock)->Release()
    }
}
