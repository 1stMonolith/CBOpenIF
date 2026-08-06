package cbopenif

CodeBlocks :: distinct rawptr

CodeBlocksIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CodeBlocksVTable,
}

CodeBlocksVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:              proc "system" (this: ^CodeBlocksIF, CodeBlock: rawptr) -> HResult,
    AddBefore:        proc "system" (this: ^CodeBlocksIF, CodeBlock: rawptr, BeforeIndex: i32) -> HResult,
    AddSTCodeBlock:   proc "system" (this: ^CodeBlocksIF, STCodeBlock: rawptr) -> HResult,
    AddSTCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCodeBlock: ^rawptr) -> HResult,
    AddSTCodeBlock2:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, STCodeBlock: ^rawptr) -> HResult,
    AddLDCodeBlock:   proc "system" (this: ^CodeBlocksIF, LDCodeBlock: rawptr) -> HResult,
    AddLDCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, LDCodeBlock: ^rawptr) -> HResult,
    AddLDCodeBlock2:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, LDCodeBlock: ^rawptr) -> HResult,
    AddFBDCodeBlock:  proc "system" (this: ^CodeBlocksIF, FBDCodeBlock: rawptr) -> HResult,
    AddFBDCodeBlock1: proc "system" (this: ^CodeBlocksIF, Name: BStr, FBDCodeBlock: ^rawptr) -> HResult,
    AddFBDCodeBlock2: proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, FBDCodeBlock: ^rawptr) -> HResult,
    AddILCodeBlock:   proc "system" (this: ^CodeBlocksIF, ILCodeBlock: rawptr) -> HResult,
    AddILCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, ILCodeBlock: ^rawptr) -> HResult,
    AddSFCCodeBlock:  proc "system" (this: ^CodeBlocksIF, SFCCodeBlock: rawptr) -> HResult,
    AddSFCCodeBlock1: proc "system" (this: ^CodeBlocksIF, Name: BStr, SFCCodeBlock: ^rawptr) -> HResult,
    AddSFCCodeBlock2: proc "system" (this: ^CodeBlocksIF, Name: BStr, SeqControl, StepElapsedTime: VariantBool, SFCCodeBlock: ^rawptr) -> HResult,
    Find:             proc "system" (this: ^CodeBlocksIF, Name: BStr, CodeBlock: ^rawptr) -> HResult,
    FindNr:           proc "system" (this: ^CodeBlocksIF, Name: BStr, Index: ^i32) -> HResult,
    Item:             proc "system" (this: ^CodeBlocksIF, Index: i32, CodeBlock: ^rawptr) -> HResult,
    Count:            proc "system" (this: ^CodeBlocksIF, Count: ^i32) -> HResult,
    Remove:           proc "system" (this: ^CodeBlocksIF, Index: i32) -> HResult,
    AddFDCodeBlock:   proc "system" (this: ^CodeBlocksIF, FDCodeBlock: rawptr) -> HResult,
}

codeblocks_add :: proc {
    codeblocks_add_,
    codeblocks_add_at_index,
}

codeblocks_add_ :: proc(codeblocks: CodeBlocks, codeblock: CodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if codeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Add(codeblock)
    if com_failed(hr) do return

    return true
}


codeblocks_add_at_index :: proc(codeblocks: CodeBlocks, codeblock: CodeBlock, index: i32) -> (ok: bool) {
    if codeblocks == nil do return
    if codeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddBefore(codeblock, index)
    if com_failed(hr) do return

    return true
}

codeblocks_add_st :: proc(codeblocks: CodeBlocks, stcodeblock: STCodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddSTCodeBlock(stcodeblock)
    if com_failed(hr) do return

    return true
}

codeblocks_add_ld :: proc(codeblocks: CodeBlocks, ldcodeblock: LDCodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddLDCodeBlock(ldcodeblock)
    if com_failed(hr) do return

    return true
}

codeblocks_add_fbd :: proc(codeblocks: CodeBlocks, fbdcodeblock: FBDCodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddFBDCodeBlock(fbdcodeblock)
    if com_failed(hr) do return

    return true
}

codeblocks_add_il :: proc(codeblocks: CodeBlocks, ilcodeblock: ILCodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddILCodeBlock(ilcodeblock)
    if com_failed(hr) do return

    return true
}

codeblocks_add_sfc :: proc(codeblocks: CodeBlocks, sfccodeblock: SFCCodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddSFCCodeBlock(sfccodeblock)
    if com_failed(hr) do return

    return true
}

codeblocks_add_fd :: proc(codeblocks: CodeBlocks, fdcodeblock: FDCodeBlock) -> (ok: bool) {
    if codeblocks == nil do return
    if fdcodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->AddFDCodeBlock(fdcodeblock)
    if com_failed(hr) do return

    return true
}

codeblocks_codeblock :: proc {
    codeblocks_codeblock_by_name,
    codeblocks_codeblock_by_index,
}

codeblocks_codeblock_by_name :: proc(codeblocks: CodeBlocks, name: string) -> (codeblock: CodeBlock, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->Find(bstr_name, cast(^rawptr)&codeblock)
    if com_failed(hr) do return

    return codeblock, true
}

codeblocks_codeblock_by_index :: proc(codeblocks: CodeBlocks, index: i32) -> (codeblock: CodeBlock, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Item(index, cast(^rawptr)&codeblock)
    if com_failed(hr) do return

    return codeblock, true
}

codeblocks_codeblock_index :: proc(codeblocks: CodeBlocks, name: string) -> (index: i32, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

codeblocks_count :: proc(codeblocks: CodeBlocks) -> (count: i32, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

codeblocks_remove :: proc(codeblocks: CodeBlocks, index: i32) -> (ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index)
    if com_failed(hr) do return

    return true
}

codeblocks_release :: proc(codeblocks: CodeBlocks) {
    if codeblocks != nil {
        (^CodeBlocksIF)(codeblocks)->Release()
    }
}
