package codeblock

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: bstr.BStr
@(private="file") HResult :: com.HResult

LDCodeBlock :: distinct rawptr

LDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^LDCodeBlockVTable,
}

LDCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

    if !controlbuilder.controlbuilder_connected() do return

    bstr_name := bstr.from_string(name)
    bstr_stcode := bstr.from_string(stcode)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_stcode)
    }
    hr := factory.factoryif->NewLDCodeBlock1(bstr_name, &bstr_stcode, cast(^rawptr)&ldcodeblock)
    if com.failed(hr) do return

    return ldcodeblock, true
}

ldcodeblock_serialize :: proc(ldcodeblock: LDCodeBlock) -> (xml: string, ok: bool) {

    if ldcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

ldcodeblock_name :: proc {
    ldcodeblock_name_get,
    ldcodeblock_name_set,
}

ldcodeblock_name_get :: proc(ldcodeblock: LDCodeBlock) -> (name: string, ok: bool) {

    if ldcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

ldcodeblock_name_set :: proc(ldcodeblock: LDCodeBlock, name: string) -> (ok: bool) {
    
    if ldcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

ldcodeblock_stcode :: proc {
    ldcodeblock_stcode_get,
    ldcodeblock_stcode_set,
}

ldcodeblock_stcode_get :: proc(ldcodeblock: LDCodeBlock) -> (stcode: string, ok: bool) {

    if ldcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

ldcodeblock_stcode_set :: proc(ldcodeblock: LDCodeBlock, stcode: string) -> (ok: bool) {
    
    if ldcodeblock == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodePut(bs)
    if com.failed(hr) do return

    return true
}

ldcodeblock_release :: proc(ldcodeblock: LDCodeBlock) {
    if ldcodeblock != nil {
        (^LDCodeBlockIF)(ldcodeblock)->Release()
    }
}
