package cbopenif

CodeBlockType :: enum i32 {
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

CodeBlock :: distinct rawptr

CodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CodeBlockVTable,
}

CodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:        proc "system" (this: ^CodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^CodeBlockIF, Name: BStr) -> HResult,
    IsSTCodeBlock:  proc "system" (this: ^CodeBlockIF, IsSTCodeBlock: ^VariantBool) -> HResult,
    IsSFCCodeBlock: proc "system" (this: ^CodeBlockIF, IsSFCCodeBlock: ^VariantBool) -> HResult,
    IsILCodeBlock:  proc "system" (this: ^CodeBlockIF, IsILCodeBlock: ^VariantBool) -> HResult,
    IsFBDCodeBlock: proc "system" (this: ^CodeBlockIF, IsFDBCodeBLock: ^VariantBool) -> HResult,
    IsLDCodeBlock:  proc "system" (this: ^CodeBlockIF, IsLDCodeBLock: ^VariantBool) -> HResult,
    IsFDCodeBlock:  proc "system" (this: ^CodeBlockIF, IsFDCodeBlock: ^VariantBool) -> HResult,
}

codeblock_deserialize :: proc(xml: string) -> (codeblock: CodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeCodeBlock(&bs, cast(^rawptr)codeblock)
    if com_failed(hr) do return
    
    return codeblock, true
}

codeblock_name :: proc {
    codeblock_name_get,
    codeblock_name_set,
}

codeblock_name_get :: proc(codeblock: CodeBlock) -> (name: string, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CodeBlockIF)(codeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

codeblock_name_set :: proc(codeblock: CodeBlock, name: string) -> (ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CodeBlockIF)(codeblock)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

codeblock_is_st :: proc(codeblock: CodeBlock) -> (is_st: bool, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsSTCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

codeblock_is_sfc :: proc(codeblock: CodeBlock) -> (is_sfc: bool, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsSFCCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

codeblock_is_il :: proc(codeblock: CodeBlock) -> (is_il: bool, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsILCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

codeblock_is_fbd :: proc(codeblock: CodeBlock) -> (is_fbd: bool, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsFBDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

codeblock_is_ld :: proc(codeblock: CodeBlock) -> (is_ld: bool, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsLDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

codeblock_is_fd :: proc(codeblock: CodeBlock) -> (is_fd: bool, ok: bool) {
    if codeblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsFDCodeBlock(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

codeblock_release :: proc(codeblock: CodeBlock) {
    if codeblock != nil {
        (^CodeBlockIF)(codeblock)->Release()
    }
}

codeblock_as_st :: proc(codeblock: CodeBlock) -> (stcodeblock: STCodeBlock, ok: bool) {
    if codeblock == nil do return

    IID := GUID{
        0x79C9A3E8,
        0x451D,
        0x4EE8,
        {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65},
    }

    hr := (^IUnknownIF)(codeblock)->QueryInterface(&IID, cast(^rawptr)&stcodeblock)
    if com_failed(hr) do return

    return stcodeblock, true
}
