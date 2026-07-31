package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

CodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^CodeBlockVTable,
}

CodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:        proc "system" (this: ^CodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^CodeBlockIF, Name: BStr) -> HResult,
    IsSTCodeBlock:  proc "system" (this: ^CodeBlockIF, IsSTCodeBlock: ^VariantBool) -> HResult,
    IsSFCCodeBlock: proc "system" (this: ^CodeBlockIF, IsSFCCodeBlock: ^VariantBool) -> HResult,
    IsILCodeBlock:  proc "system" (this: ^CodeBlockIF, IsILCodeBlock: ^VariantBool) -> HResult,
    IsFBDCodeBlock: proc "system" (this: ^CodeBlockIF, IsFDBCodeBLock: ^VariantBool) -> HResult,
    IsLDCodeBlock:  proc "system" (this: ^CodeBlockIF, IsLDCodeBLock: ^VariantBool) -> HResult,
    IsFDCodeBlock:  proc "system" (this: ^CodeBlockIF, IsFDCodeBlock: ^VariantBool) -> HResult,
}

codeblock_deserialize :: proc(codeblock: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factoryif->DeserializeCodeBlock(&bstr, cast(^rawptr)codeblock)
    if com.failed(hr) do return
    
    return true
}

codeblock_name :: proc {
    codeblock_name_,
    codeblock_name_set,
}

@(private)
codeblock_name_ :: proc(codeblock: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^CodeBlockIF)(codeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
codeblock_name_set :: proc(codeblock: rawptr, name: string) -> (ok: bool) {
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^CodeBlockIF)(codeblock)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

codeblock_is_st :: proc(codeblock: rawptr) -> (is_st: bool, ok: bool) {
    is_st = false
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsSTCodeBlock(&vb)
    if com.failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_sfc :: proc(codeblock: rawptr) -> (is_sfc: bool, ok: bool) {
    is_sfc = false
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsSFCCodeBlock(&vb)
    if com.failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_il :: proc(codeblock: rawptr) -> (is_il: bool, ok: bool) {
    is_il = false
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsILCodeBlock(&vb)
    if com.failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_fbd :: proc(codeblock: rawptr) -> (is_fbd: bool, ok: bool) {
    is_fbd = false
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsFBDCodeBlock(&vb)
    if com.failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_ld :: proc(codeblock: rawptr) -> (is_ld: bool, ok: bool) {
    is_ld = false
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsLDCodeBlock(&vb)
    if com.failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_fd :: proc(codeblock: rawptr) -> (is_fd: bool, ok: bool) {
    is_fd = false
    ok = false

    if codeblock == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsFDCodeBlock(&vb)
    if com.failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_release :: proc(codeblock: rawptr) {
    if codeblock != nil {
        (^CodeBlockIF)(codeblock)->Release()
    }
}

codeblock_as_st :: proc(codeblock: rawptr) -> (stcodeblock: rawptr, ok: bool) {
    stcodeblock = nil
    ok = false

    if codeblock == nil do return

    IID := GUID{
        0x79C9A3E8,
        0x451D,
        0x4EE8,
        {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65},
    }

    hr := (^IUnknownIF)(codeblock)->QueryInterface(&IID, cast(^rawptr)&stcodeblock)
    if com.failed(hr) do return

    return stcodeblock, true
}
