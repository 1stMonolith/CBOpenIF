package cbopenif

CodeBlockType :: enum i32 {
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

CodeBlockUnion :: union {
    STCodeBlock,
    SFCCodeBlock,
    FBDCodeBlock,
    LDCodeBlock,
    ILCodeBlock,
    FDCodeBlock,
}

CodeBLock :: struct {
    kind: CodeBlockType,
    block: CodeBlockUnion,
}

IID_STCodeBlock  :: GUID{0x79C9A3E8, 0x451D, 0x4EE8, {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65}}
IID_SFCCodeBlock :: GUID{0x04E1622A, 0x175C, 0x4EBC, {0x9A, 0x3D, 0xEC, 0x9E, 0x81, 0x4F, 0xD0, 0x6A}}
IID_FBDCodeBlock :: GUID{0x97BB6A82, 0xC2E1, 0x401C, {0x9A, 0x72, 0x4A, 0xC7, 0xC0, 0xE6, 0x7B, 0x8D}}
IID_LDCodeBlock  :: GUID{0x76EEDE55, 0x5C23, 0x4461, {0x80, 0xDF, 0xA3, 0x75, 0x4B, 0x4B, 0xE9, 0xDD}}
IID_ILCodeBlock  :: GUID{0x5D6751B5, 0xA285, 0x4095, {0x9F, 0x08, 0x44, 0x1A, 0xF0, 0x03, 0x11, 0x57}}
IID_FDCodeBlock  :: GUID{0xF2927D61, 0x5DDD, 0x44A2, {0xAF, 0x02, 0x1B, 0x69, 0xCA, 0x89, 0xB1, 0x52}}

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

/*
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
*/

icodeblock_is_st :: proc(icodeblock: ICodeBlock) -> (is_st: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSTCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_as_st :: proc(icodeblock: ICodeBlock) -> (stcodeblock: STCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := IID_STCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&stcodeblock)
    if com_failed(hr) do return

    return stcodeblock, true
}

icodeblock_is_sfc :: proc(icodeblock: ICodeBlock) -> (is_sfc: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSFCCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_as_sfc :: proc(icodeblock: ICodeBlock) -> (sfccodeblock: SFCCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := IID_SFCCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&sfccodeblock)
    if com_failed(hr) do return

    return sfccodeblock, true
}

icodeblock_is_il :: proc(icodeblock: ICodeBlock) -> (is_il: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsILCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_as_il :: proc(icodeblock: ICodeBlock) -> (ilcodeblock: ILCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := IID_ILCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&ilcodeblock)
    if com_failed(hr) do return

    return ilcodeblock, true
}

icodeblock_is_fbd :: proc(icodeblock: ICodeBlock) -> (is_fbd: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFBDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_as_fbd :: proc(icodeblock: ICodeBlock) -> (fbdcodeblock: ILCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := IID_FBDCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&fbdcodeblock)
    if com_failed(hr) do return

    return fbdcodeblock, true
}

icodeblock_is_ld :: proc(icodeblock: ICodeBlock) -> (is_ld: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsLDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_as_ld :: proc(icodeblock: ICodeBlock) -> (ldcodeblock: ILCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := IID_LDCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&ldcodeblock)
    if com_failed(hr) do return

    return ldcodeblock, true
}

icodeblock_is_fd :: proc(icodeblock: ICodeBlock) -> (is_fd: bool, ok: bool) {
    if icodeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icodeblock_as_fd :: proc(icodeblock: ICodeBlock) -> (fdcodeblock: ILCodeBlock, ok: bool) {
    if icodeblock == nil do return

    IID := IID_FDCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&fdcodeblock)
    if com_failed(hr) do return

    return fdcodeblock, true
}

icodeblock_release :: proc(icodeblock: ICodeBlock) {
    if icodeblock != nil {
        (^ICodeBlockIF)(icodeblock)->Release()
    }
}

icodeblock_resolve :: proc(icodeblock: ICodeBlock) -> (codeblock: CodeBLock, ok: bool) {
    if icodeblock == nil do return

    if is, ok := icodeblock_is_st(icodeblock); ok && is {
        st, ok := icodeblock_as_st(icodeblock)
        if !ok do return
        codeblock.kind = CodeBlockType.ST
        codeblock.block = st
        return codeblock, true 
    }

    if is, ok := icodeblock_is_sfc(icodeblock); ok && is {
        sfc, ok := icodeblock_as_sfc(icodeblock)
        if !ok do return
        codeblock.kind = CodeBlockType.SFC
        codeblock.block = sfc
        return codeblock, true 
    }

    if is, ok := icodeblock_is_fbd(icodeblock); ok && is {
        fbd, ok := icodeblock_as_fbd(icodeblock)
        if !ok do return
        codeblock.kind = CodeBlockType.FBD
        codeblock.block = fbd
        return codeblock, true 
    }

    if is, ok := icodeblock_is_ld(icodeblock); ok && is {
        ld, ok := icodeblock_as_ld(icodeblock)
        if !ok do return
        codeblock.kind = CodeBlockType.LD
        codeblock.block = ld
        return codeblock, true 
    }

    if is, ok := icodeblock_is_il(icodeblock); ok && is {
        il, ok := icodeblock_as_il(icodeblock)
        if !ok do return
        codeblock.kind = CodeBlockType.IL
        codeblock.block = il
        return codeblock, true 
    }

    if is, ok := icodeblock_is_fd(icodeblock); ok && is {
        fd, ok := icodeblock_as_fd(icodeblock)
        if !ok do return
        codeblock.kind = CodeBlockType.FD
        codeblock.block = fd
        return codeblock, true 
    }

    return {}, false
}
