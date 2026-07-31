package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"

ILCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ILCodeBlockVTable,
}

ILCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:   proc "system" (this: ^ILCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^ILCodeBlockIF, Name: BStr) -> HResult,
    ILRowsGet: proc "system" (this: ^ILCodeBlockIF, ILRows: ^rawptr) -> HResult,
    Missing10: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    ILRowsPut: proc "system" (this: ^ILCodeBlockIF, ILRows: rawptr) -> HResult,
    Missing12: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Missing14: proc "system" (this: ^ILCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^ILCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

ilcodeblock_new :: proc(name: string) -> (ilcodeblock: rawptr, ok: bool) {
    ilcodeblock = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := factory.factoryif->NewILCodeBlock(bstr_name, cast(^rawptr)&ilcodeblock)
    if com.failed(hr) do return

    return ilcodeblock, true
}

ilcodeblock_serialize :: proc(ilcodeblock: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if ilcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

ilcodeblock_name :: proc {
    ilcodeblock_name_,
    ilcodeblock_name_set,
}

@(private)
ilcodeblock_name_ :: proc(ilcodeblock: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if ilcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
ilcodeblock_name_set :: proc(ilcodeblock: rawptr, name: string) -> (ok: bool) {
    ok = false
    
    if ilcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

ilcodeblock_stcode :: proc {
    ilcodeblock_stcode_,
    ilcodeblock_stcode_set,
}

@(private)
ilcodeblock_stcode_ :: proc(ilcodeblock: rawptr) -> (ilrows: rawptr, ok: bool) {
    ilrows = nil
    ok = false

    if ilcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsGet(&ilrows)
    if com.failed(hr) do return

    return ilrows, true
}

@(private)
ilcodeblock_stcode_set :: proc(ilcodeblock: rawptr, ilrows: rawptr) -> (ok: bool) {
    ok = false
    
    if ilcodeblock == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsPut(ilrows)
    if com.failed(hr) do return

    return true
}

ilcodeblock_release :: proc(ilcodeblock: rawptr) {
    if ilcodeblock != nil {
        (^ILCodeBlockIF)(ilcodeblock)->Release()
    }
}
