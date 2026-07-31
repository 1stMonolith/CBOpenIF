package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"

FBDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^FBDCodeBlockVTable,
}

FBDCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:   proc "system" (this: ^FBDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^FBDCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^FBDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^FBDCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^FBDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

fbdcodeblock_new :: proc(name, stcode: string) -> (fbdcodeblock: rawptr, ok: bool) {
    fbdcodeblock = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr_stcode := bstr.from_string(stcode)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_stcode)
    }
    hr := factoryif->NewFBDCodeBlock1(bstr_name, &bstr_stcode, cast(^rawptr)&fbdcodeblock)
    if com.failed(hr) do return

    return fbdcodeblock, true
}

fbdcodeblock_serialize :: proc(fbdcodeblock: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if fbdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

fbdcodeblock_name :: proc {
    fbdcodeblock_name_,
    fbdcodeblock_name_set,
}

@(private)
fbdcodeblock_name_ :: proc(fbdcodeblock: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if fbdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
fbdcodeblock_name_set :: proc(fbdcodeblock: rawptr, name: string) -> (ok: bool) {
    ok = false
    
    if fbdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

fbdcodeblock_stcode :: proc {
    fbdcodeblock_stcode_,
    fbdcodeblock_stcode_set,
}

@(private)
fbdcodeblock_stcode_ :: proc(fbdcodeblock: rawptr) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if fbdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
fbdcodeblock_stcode_set :: proc(fbdcodeblock: rawptr, stcode: string) -> (ok: bool) {
    ok = false
    
    if fbdcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodePut(bs)
    if com.failed(hr) do return

    return true
}

fbdcodeblock_release :: proc(fbdcodeblock: rawptr) {
    if fbdcodeblock != nil {
        (^FBDCodeBlockIF)(fbdcodeblock)->Release()
    }
}
