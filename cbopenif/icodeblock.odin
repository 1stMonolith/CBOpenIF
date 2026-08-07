package cbopenif

CodeBlockType :: enum i32 {
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

ICodeBlock :: distinct rawptr

ICodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ICodeBlockVTable,
}

ICodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:        proc "system" (this: ^ICodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^ICodeBlockIF, Name: BStr) -> HResult,
    IsSTCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsSTCodeBlock: ^VariantBool) -> HResult,
    IsSFCCodeBlock: proc "system" (this: ^ICodeBlockIF, IsSFCCodeBlock: ^VariantBool) -> HResult,
    IsILCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsILCodeBlock: ^VariantBool) -> HResult,
    IsFBDCodeBlock: proc "system" (this: ^ICodeBlockIF, IsFDBCodeBLock: ^VariantBool) -> HResult,
    IsLDCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsLDCodeBLock: ^VariantBool) -> HResult,
    IsFDCodeBlock:  proc "system" (this: ^ICodeBlockIF, IsFDCodeBlock: ^VariantBool) -> HResult,
}

icodeblock_deserialize :: proc(xml: string) -> (icodeblock: ICodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeCodeBlock(&bs, cast(^rawptr)icodeblock)
    if com_failed(hr) do return
    
    return icodeblock, true
}

icodeblock_name :: proc {
    icodeblock_name_get,
    icodeblock_name_set,
}

icodeblock_name_get :: proc(icodeblock: ICodeBlock) -> (name: string, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ICodeBlockIF)(icodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

icodeblock_name_set :: proc(icodeblock: ICodeBlock, name: string) -> (ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ICodeBlockIF)(icodeblock)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

icodeblock_is_st :: proc(icodeblock: ICodeBlock) -> (is_st: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSTCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_is_sfc :: proc(icodeblock: ICodeBlock) -> (is_sfc: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSFCCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_is_il :: proc(icodeblock: ICodeBlock) -> (is_il: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsILCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_is_fbd :: proc(icodeblock: ICodeBlock) -> (is_fbd: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFBDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_is_ld :: proc(icodeblock: ICodeBlock) -> (is_ld: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsLDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_is_fd :: proc(icodeblock: ICodeBlock) -> (is_fd: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_release :: proc(icodeblock: ICodeBlock) {
    if icodeblock != nil {
        (^ICodeBlockIF)(icodeblock)->Release()
    }
}

icodeblock_as_st :: proc(icodeblock: ICodeBlock) -> (stcodeblock: STCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := GUID{
        0x79C9A3E8,
        0x451D,
        0x4EE8,
        {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65},
    }

    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&stcodeblock)
    if com_failed(hr) do return

    return stcodeblock, true
}
