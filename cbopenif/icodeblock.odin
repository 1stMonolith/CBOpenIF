package cbopenif

ICodeBlock :: distinct rawptr

ICodeBlockIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^ICodeBlockVTable,
}

ICodeBlockVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    NameGet:        proc "system" (this: ^ICodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^ICodeBlockIF, Name: BStr) -> HResult,
    IsSTCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsSTCodeBlock: ^VariantBool) -> HResult,
    IsSFCCodeBlock: proc "system" (this: ^ICodeBlockIF, IsSFCCodeBlock: ^VariantBool) -> HResult,
    IsILCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsILCodeBlock: ^VariantBool) -> HResult,
    IsFBDCodeBlock: proc "system" (this: ^ICodeBlockIF, IsFDBCodeBLock: ^VariantBool) -> HResult,
    IsLDCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsLDCodeBLock: ^VariantBool) -> HResult,
    IsFDCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsFDCodeBlock: ^VariantBool) -> HResult,
}

icodeblock_deserialize :: proc(icodeblock: ^ICodeBlock, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeICodeBlock(&bstr, cast(^ICodeBlock)icodeblock)
    if failed(hr) do return
    
    return true
}

icodeblock_name :: proc {
    icodeblock_name_,
    icodeblock_name_set,
}

@(private)
icodeblock_name_ :: proc(icodeblock: ICodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ICodeBlockIF)(icodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
icodeblock_name_set :: proc(icodeblock: ICodeBlock, name: string) -> (ok: bool) {
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ICodeBlockIF)(icodeblock)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

icodeblock_is_st :: proc(icodeblock: ICodeBlock) -> (is_st: bool, ok: bool) {
    is_st = false
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSTCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

icodeblock_is_sfc :: proc(icodeblock: ICodeBlock) -> (is_sfc: bool, ok: bool) {
    is_sfc = false
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSFCCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

icodeblock_is_il :: proc(icodeblock: ICodeBlock) -> (is_il: bool, ok: bool) {
    is_il = false
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsILCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

icodeblock_is_fbd :: proc(icodeblock: ICodeBlock) -> (is_fbd: bool, ok: bool) {
    is_fbd = false
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFBDCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

icodeblock_is_ld :: proc(icodeblock: ICodeBlock) -> (is_ld: bool, ok: bool) {
    is_ld = false
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsLDCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

icodeblock_is_fd :: proc(icodeblock: ICodeBlock) -> (is_fd: bool, ok: bool) {
    is_fd = false
    ok = false

    if icodeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFDCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

icodeblock_release :: proc(icodeblock: ICodeBlock) {
    if icodeblock != nil {
        (^ICodeBlockIF)(icodeblock)->Release()
    }
}

icodeblock_as_st :: proc(icodeblock: ICodeBlock) -> (stcodeblock: STCodeBlock, ok: bool) {
    stcodeblock = nil
    ok = false

    if icodeblock == nil do return

    IID := GUID{
        0x79C9A3E8,
        0x451D,
        0x4EE8,
        {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65},
    }

    hr := (^IUnknowIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&stcodeblock)
    if failed(hr) do return

    return stcodeblock, true
}
