package cbopenif

CodeBlocks :: distinct rawptr

CodeBlocksIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^CodeBlocksVTable,
}

CodeBlocksVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:              proc "system" (this: ^CodeBlocksIF, ICodeBlock: ICodeBlock) -> HResult,
    AddBefore:        proc "system" (this: ^CodeBlocksIF, ICodeBlock: ICodeBlock, BeforeIndex: i32) -> HResult,
    AddSTCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: STCodeBlock) -> HResult,
    AddSTCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^STCodeBlock) -> HResult,
    AddSTCodeBlock2:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, Code: ^STCodeBlock) -> HResult,
    AddLDCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: LDCodeBlock) -> HResult,
    AddLDCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^LDCodeBlock) -> HResult,
    AddLDCodeBlock2:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, Code: ^LDCodeBlock) -> HResult,
    AddFBDCodeBlock:  proc "system" (this: ^CodeBlocksIF, Code: FBDCodeBlock) -> HResult,
    AddFBDCodeBlock1: proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^FBDCodeBlock) -> HResult,
    AddFBDCodeBlock2: proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, Code: ^FBDCodeBlock) -> HResult,
    AddILCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: ILCodeBlock) -> HResult,
    AddILCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^ILCodeBlock) -> HResult,
    AddSFCCodeBlock:  proc "system" (this: ^CodeBlocksIF, Code: SFCCodeBlock) -> HResult,
    AddSFCCodeBlock1: proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^SFCCodeBlock) -> HResult,
    AddSFCCodeBlock2: proc "system" (this: ^CodeBlocksIF, Name: BStr, SeqControl, StepElapsedTime: VariantBool, Code: ^SFCCodeBlock) -> HResult,
    Find:             proc "system" (this: ^CodeBlocksIF, Name: BStr, ICodeBlock: ^ICodeBlock) -> HResult,
    FindNr:           proc "system" (this: ^CodeBlocksIF, Name: BStr, Index: ^i32) -> HResult,
    Item:             proc "system" (this: ^CodeBlocksIF, Index: i32, ICodeBlock: ^ICodeBlock) -> HResult,
    Count:            proc "system" (this: ^CodeBlocksIF, Count: ^i32) -> HResult,
    Remove:           proc "system" (this: ^CodeBlocksIF, Index: i32) -> HResult,
    AddFDCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: FDCodeBlock) -> HResult,
}

codeblocks_add :: proc {
    codeblocks_add_,
    codeblocks_add_at_index,
    codeblocks_add_st,
    codeblocks_add_ld,
    codeblocks_add_fbd,
    codeblocks_add_il,
    codeblocks_add_sfc,
    codeblocks_add_fd,
}

@(private)
codeblocks_add_ :: proc(codeblocks: CodeBlocks, codeblock: ICodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if codeblock == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Add(codeblock)
    if failed(hr) do return

    return true
}

@(private)
codeblocks_add_at_index :: proc(codeblocks: CodeBlocks, codeblock: ICodeBlock, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if codeblock == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddBefore(codeblock, index)
    if failed(hr) do return

    return true
}

codeblocks_add_st :: proc(codeblocks: CodeBlocks, code: STCodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddSTCodeBlock(code)
    if failed(hr) do return

    return true
}

codeblocks_add_ld :: proc(codeblocks: CodeBlocks, code: LDCodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddLDCodeBlock(code)
    if failed(hr) do return

    return true
}

codeblocks_add_fbd :: proc(codeblocks: CodeBlocks, code: FBDCodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddFBDCodeBlock(code)
    if failed(hr) do return

    return true
}

codeblocks_add_il :: proc(codeblocks: CodeBlocks, code: ILCodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddILCodeBlock(code)
    if failed(hr) do return

    return true
}

codeblocks_add_sfc :: proc(codeblocks: CodeBlocks, code: SFCCodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddSFCCodeBlock(code)
    if failed(hr) do return

    return true
}

codeblocks_add_fd :: proc(codeblocks: CodeBlocks, code: FDCodeBlock) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddFDCodeBlock(code)
    if failed(hr) do return

    return true
}

codeblocks_codeblock :: proc {
    codeblocks_codeblock_by_name,
    codeblocks_codeblock_by_index,
}

@(private)
codeblocks_codeblock_by_name :: proc(codeblocks: CodeBlocks, name: string) -> (codeblock: ICodeBlock, ok: bool) {
    codeblock = nil
    ok = false

    if !connected() do return
    if codeblocks == nil do return

    bstr_name := string_to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->Find(bstr_name, &codeblock)
    if failed(hr) do return

    return codeblock, true
}

@(private)
codeblocks_codeblock_by_index :: proc(codeblocks: CodeBlocks, index: i32) -> (codeblock: ICodeBlock, ok: bool) {
    codeblock = nil
    ok = false

    if !connected() do return
    if codeblocks == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Item(index, &codeblock)
    if failed(hr) do return

    return codeblock, true
}

codeblocks_codeblock_index :: proc(codeblocks: CodeBlocks, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if codeblocks == nil do return

    bstr_name := string_to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->FindNr(bstr_name, &index)
    if failed(hr) do return

    return index, true
}

codeblocks_count :: proc(codeblocks: CodeBlocks) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if codeblocks == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Count(&count)
    if failed(hr) do return

    return count, true
}

codeblocks_remove :: proc(codeblocks: CodeBlocks, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if codeblocks == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index)
    if failed(hr) do return

    return true
}

codeblocks_release :: proc(codeblocks: CodeBlocks) {
    if codeblocks != nil {
        (^CodeBlocksIF)(codeblocks)->Release()
    }
}