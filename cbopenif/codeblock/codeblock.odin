package codeblock

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
    #subtype iunknown: IUnknownIF,
    using vtable: ^CodeBlockVTable,
}

CodeBlockVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    NameGet:        proc "system" (this: ^CodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^CodeBlockIF, Name: BStr) -> HResult,
    IsSTCodeBlock:  proc "system" (this: ^CodeBlockIF, IsSTCodeBlock: ^VariantBool) -> HResult,
    IsSFCCodeBlock: proc "system" (this: ^CodeBlockIF, IsSFCCodeBlock: ^VariantBool) -> HResult,
    IsILCodeBlock:  proc "system" (this: ^CodeBlockIF, IsILCodeBlock: ^VariantBool) -> HResult,
    IsFBDCodeBlock: proc "system" (this: ^CodeBlockIF, IsFDBCodeBLock: ^VariantBool) -> HResult,
    IsLDCodeBlock:  proc "system" (this: ^CodeBlockIF, IsLDCodeBLock: ^VariantBool) -> HResult,
    IsFDCodeBlock:  proc "system" (this: ^CodeBlockIF, IsFDCodeBlock: ^VariantBool) -> HResult,
}

codeblock_deserialize :: proc(codeblock: ^CodeBlock, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeCodeBlock(&bstr, cast(^CodeBlock)codeblock)
    if failed(hr) do return
    
    return true
}

codeblock_name :: proc {
    codeblock_name_,
    codeblock_name_set,
}

@(private)
codeblock_name_ :: proc(codeblock: CodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^CodeBlockIF)(codeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
codeblock_name_set :: proc(codeblock: CodeBlock, name: string) -> (ok: bool) {
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^CodeBlockIF)(codeblock)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

codeblock_is_st :: proc(codeblock: CodeBlock) -> (is_st: bool, ok: bool) {
    is_st = false
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsSTCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_sfc :: proc(codeblock: CodeBlock) -> (is_sfc: bool, ok: bool) {
    is_sfc = false
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsSFCCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_il :: proc(codeblock: CodeBlock) -> (is_il: bool, ok: bool) {
    is_il = false
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsILCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_fbd :: proc(codeblock: CodeBlock) -> (is_fbd: bool, ok: bool) {
    is_fbd = false
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsFBDCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_ld :: proc(codeblock: CodeBlock) -> (is_ld: bool, ok: bool) {
    is_ld = false
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsLDCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_is_fd :: proc(codeblock: CodeBlock) -> (is_fd: bool, ok: bool) {
    is_fd = false
    ok = false

    if codeblock == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^CodeBlockIF)(codeblock)->IsFDCodeBlock(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

codeblock_release :: proc(codeblock: CodeBlock) {
    if codeblock != nil {
        (^CodeBlockIF)(codeblock)->Release()
    }
}

codeblock_as_st :: proc(codeblock: CodeBlock) -> (stcodeblock: STCodeBlock, ok: bool) {
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
    if failed(hr) do return

    return stcodeblock, true
}
