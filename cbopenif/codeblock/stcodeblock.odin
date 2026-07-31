package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"

STCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^STCodeBlockVTable,
}

STCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:   proc "system" (this: ^STCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^STCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^STCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^STCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^STCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

stcodeblock_new :: proc(name, stcode: string) -> (stcodeblock: rawptr, ok: bool) {
    stcodeblock = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr_stcode := bstr.from_string(stcode)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_stcode)
    }
    hr := factory.factoryif->NewSTCodeBlock1(bstr_name, &bstr_stcode, cast(^rawptr)&stcodeblock)
    if com.failed(hr) do return

    return stcodeblock, true
}

stcodeblock_serialize :: proc(stcodeblock: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if stcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

stcodeblock_name :: proc {
    stcodeblock_name_get,
    stcodeblock_name_set,
}

stcodeblock_name_get :: proc(stcodeblock: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if stcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

stcodeblock_name_set :: proc(stcodeblock: rawptr, name: string) -> (ok: bool) {
    ok = false
    
    if stcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

stcodeblock_stcode :: proc {
    stcodeblock_stcode_get,
    stcodeblock_stcode_set,
}

stcodeblock_stcode_get :: proc(stcodeblock: rawptr) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if stcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

stcodeblock_stcode_set :: proc(stcodeblock: rawptr, stcode: string) -> (ok: bool) {
    ok = false
    
    if stcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodePut(bs)
    if com.failed(hr) do return

    return true
}

stcodeblock_release :: proc(stcodeblock: rawptr) {
    if stcodeblock != nil {
        (^STCodeBlockIF)(stcodeblock)->Release()
    }
}
