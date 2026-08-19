package com

import t "../types"

ICodeBlock   :: distinct rawptr
CodeBlocks   :: distinct rawptr
STCodeBlock  :: distinct rawptr
SFCCodeBlock :: distinct rawptr
LDCodeBlock  :: distinct rawptr
ILCodeBlock  :: distinct rawptr
FDCodeBlock  :: distinct rawptr
FBDCodeBlock :: distinct rawptr

CodeBlockUnion :: union {
    STCodeBlock,
    SFCCodeBlock,
    FBDCodeBlock,
    LDCodeBlock,
    ILCodeBlock,
    FDCodeBlock,
}

CodeBlock :: struct {
    kind: t.CodeBlockKind,
    block: CodeBlockUnion,
}

IID_STCodeBlock  :: GUID{0x79C9A3E8, 0x451D, 0x4EE8, {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65}}
IID_SFCCodeBlock :: GUID{0x04E1622A, 0x175C, 0x4EBC, {0x9A, 0x3D, 0xEC, 0x9E, 0x81, 0x4F, 0xD0, 0x6A}}
IID_FBDCodeBlock :: GUID{0x97BB6A82, 0xC2E1, 0x401C, {0x9A, 0x72, 0x4A, 0xC7, 0xC0, 0xE6, 0x7B, 0x8D}}
IID_LDCodeBlock  :: GUID{0x76EEDE55, 0x5C23, 0x4461, {0x80, 0xDF, 0xA3, 0x75, 0x4B, 0x4B, 0xE9, 0xDD}}
IID_ILCodeBlock  :: GUID{0x5D6751B5, 0xA285, 0x4095, {0x9F, 0x08, 0x44, 0x1A, 0xF0, 0x03, 0x11, 0x57}}
IID_FDCodeBlock  :: GUID{0xF2927D61, 0x5DDD, 0x44A2, {0xAF, 0x02, 0x1B, 0x69, 0xCA, 0x89, 0xB1, 0x52}}

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

from_icodeblock :: proc(icodeblock: ICodeBlock) -> (codeblock: CodeBlock, ok: bool) {
    if icodeblock == nil do return

    if is, ok := icodeblock_is_st(icodeblock); ok && is {
        st, ok := icodeblock_as_st(icodeblock)
        if !ok do return
        codeblock.kind = t.CodeBlockKind.ST
        codeblock.block = st
        return codeblock, true 
    }

    if is, ok := icodeblock_is_sfc(icodeblock); ok && is {
        sfc, ok := icodeblock_as_sfc(icodeblock)
        if !ok do return
        codeblock.kind = t.CodeBlockKind.SFC
        codeblock.block = sfc
        return codeblock, true 
    }

    if is, ok := icodeblock_is_fbd(icodeblock); ok && is {
        fbd, ok := icodeblock_as_fbd(icodeblock)
        if !ok do return
        codeblock.kind = t.CodeBlockKind.FBD
        codeblock.block = fbd
        return codeblock, true 
    }

    if is, ok := icodeblock_is_ld(icodeblock); ok && is {
        ld, ok := icodeblock_as_ld(icodeblock)
        if !ok do return
        codeblock.kind = t.CodeBlockKind.LD
        codeblock.block = ld
        return codeblock, true 
    }

    if is, ok := icodeblock_is_il(icodeblock); ok && is {
        il, ok := icodeblock_as_il(icodeblock)
        if !ok do return
        codeblock.kind = t.CodeBlockKind.IL
        codeblock.block = il
        return codeblock, true 
    }

    if is, ok := icodeblock_is_fd(icodeblock); ok && is {
        fd, ok := icodeblock_as_fd(icodeblock)
        if !ok do return
        codeblock.kind = t.CodeBlockKind.FD
        codeblock.block = fd
        return codeblock, true 
    }

    return {}, false
}

codeblock_name_get :: proc(codeblock: CodeBlock) -> (name: string, ok: bool) {
    switch block in codeblock.block {
        case STCodeBlock:  return stcodeblock_name_get(block)
        case SFCCodeBlock: return sfccodeblock_name_get(block)
        case FBDCodeBlock: return fbdcodeblock_name_get(block)
        case LDCodeBlock:  return ldcodeblock_name_get(block)
        case ILCodeBlock:  return ilcodeblock_name_get(block)
        case FDCodeBlock:  return fdcodeblock_name_get(block)
    }
    return
}

codeblock_name_set :: proc(codeblock: CodeBlock, name: string) -> (ok: bool) {
    switch block in codeblock.block {
        case STCodeBlock:  return stcodeblock_name_set(block, name)
        case SFCCodeBlock: return sfccodeblock_name_set(block, name)
        case FBDCodeBlock: return fbdcodeblock_name_set(block, name)
        case LDCodeBlock:  return ldcodeblock_name_set(block, name)
        case ILCodeBlock:  return ilcodeblock_name_set(block, name)
        case FDCodeBlock:  return fdcodeblock_name_set(block, name)
    }
    return
}

codeblock_release :: proc(codeblock: CodeBlock) {
    switch block in codeblock.block {
        case STCodeBlock:  stcodeblock_release(block)
        case SFCCodeBlock: sfccodeblock_release(block)
        case FBDCodeBlock: fbdcodeblock_release(block)
        case LDCodeBlock:  ldcodeblock_release(block)
        case ILCodeBlock:  ilcodeblock_release(block)
        case FDCodeBlock:  fdcodeblock_release(block)
    }
}

codeblock_serialize :: proc(codeblock: CodeBlock) -> (xml: string, ok: bool) {
    switch block in codeblock.block {
        case STCodeBlock:  return stcodeblock_serialize(block)
        case SFCCodeBlock: return sfccodeblock_serialize(block)
        case FBDCodeBlock: return fbdcodeblock_serialize(block)
        case LDCodeBlock:  return ldcodeblock_serialize(block)
        case ILCodeBlock:  return ilcodeblock_serialize(block)
        case FDCodeBlock:  return fdcodeblock_serialize(block)
    }
    return
}

codeblock_stcode_get :: proc(codeblock: CodeBlock) -> (stcode: string, ok: bool) {
     #partial switch block in codeblock.block {
        case STCodeBlock:  return stcodeblock_stcode_get(block)
        case FBDCodeBlock: return fbdcodeblock_stcode_get(block)
        case LDCodeBlock:  return ldcodeblock_stcode_get(block)
    }
    return
}

codeblock_stcode_set :: proc(codeblock: CodeBlock, stcode: string) -> (ok: bool) {
    #partial switch block in codeblock.block {
        case STCodeBlock:  return stcodeblock_stcode_set(block, stcode)
        case FBDCodeBlock: return fbdcodeblock_stcode_set(block, stcode)
        case LDCodeBlock:  return ldcodeblock_stcode_set(block, stcode)
    }
    return
}

CodeBlocksIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CodeBlocksVTable,
}

CodeBlocksVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:              proc "system" (this: ^CodeBlocksIF, ICodeBlock: rawptr) -> HResult,
    AddBefore:        proc "system" (this: ^CodeBlocksIF, ICodeBlock: rawptr, BeforeIndex: i32) -> HResult,
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
    Find:             proc "system" (this: ^CodeBlocksIF, Name: BStr, ICodeBlock: ^rawptr) -> HResult,
    FindNr:           proc "system" (this: ^CodeBlocksIF, Name: BStr, Index: ^i32) -> HResult,
    Item:             proc "system" (this: ^CodeBlocksIF, Index: i32, ICodeBlock: ^rawptr) -> HResult,
    Count:            proc "system" (this: ^CodeBlocksIF, Count: ^i32) -> HResult,
    Remove:           proc "system" (this: ^CodeBlocksIF, Index: i32) -> HResult,
    AddFDCodeBlock:   proc "system" (this: ^CodeBlocksIF, FDCodeBlock: rawptr) -> HResult,
}

codeblocks_codeblock_add :: proc(codeblocks: CodeBlocks, codeblock: CodeBlockUnion) -> (ok: bool) {
    if codeblocks == nil do return
    if codeblock == nil do return
    if !controlbuilder_connected() do return

    hr: HResult
    switch block in codeblock {
        case STCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddSTCodeBlock(codeblock.(STCodeBlock))
        case LDCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddLDCodeBlock(codeblock.(LDCodeBlock))
        case FBDCodeBlock: hr = (^CodeBlocksIF)(codeblocks)->AddFBDCodeBlock(codeblock.(FBDCodeBlock))
        case ILCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddILCodeBlock(codeblock.(ILCodeBlock))
        case SFCCodeBlock: hr = (^CodeBlocksIF)(codeblocks)->AddSFCCodeBlock(codeblock.(SFCCodeBlock))
        case FDCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddFDCodeBlock(codeblock.(FDCodeBlock))
    }
    if com_failed(hr) do return

    return true
}

codeblocks_codeblock_by_name :: proc(codeblocks: CodeBlocks, name: string) -> (codeblock: CodeBlock, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    i: ICodeBlock
    hr := (^CodeBlocksIF)(codeblocks)->Find(bstr_name, cast(^rawptr)&i)
    if com_failed(hr) do return
    defer icodeblock_release(i)

    return from_icodeblock(i)
}

codeblocks_codeblock_by_index :: proc(codeblocks: CodeBlocks, index: i32) -> (codeblock: CodeBlock, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    i: ICodeBlock
    hr := (^CodeBlocksIF)(codeblocks)->Item(index + 1, cast(^rawptr)&i)
    if com_failed(hr) do return
    defer icodeblock_release(i)

    return from_icodeblock(i)
}

codeblocks_codeblock_index :: proc(codeblocks: CodeBlocks, name: string) -> (index: i32, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

codeblocks_codeblock_count :: proc(codeblocks: CodeBlocks) -> (count: i32, ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

codeblocks_codeblock_remove_by_name :: proc(codeblocks: CodeBlocks, name: string) -> (ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = codeblocks_codeblock_index(codeblocks, name)
    if !ok do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index)
    if com_failed(hr) do return

    return true
}

codeblocks_codeblock_remove_by_index :: proc(codeblocks: CodeBlocks, index: i32) -> (ok: bool) {
    if codeblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

codeblocks_release :: proc(codeblocks: CodeBlocks) {
    if codeblocks != nil {
        (^CodeBlocksIF)(codeblocks)->Release()
    }
}

STCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^STCodeBlockVTable,
}

STCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^STCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^STCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^STCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^STCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^STCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^STCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

stcodeblock_serialize :: proc(stcodeblock: STCodeBlock) -> (xml: string, ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

stcodeblock_name_get :: proc(stcodeblock: STCodeBlock) -> (name: string, ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

stcodeblock_name_set :: proc(stcodeblock: STCodeBlock, name: string) -> (ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

stcodeblock_stcode_get :: proc(stcodeblock: STCodeBlock) -> (stcode: string, ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

stcodeblock_stcode_set :: proc(stcodeblock: STCodeBlock, stcode: string) -> (ok: bool) {
    if stcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

stcodeblock_release :: proc(stcodeblock: STCodeBlock) {
    if stcodeblock != nil {
        (^STCodeBlockIF)(stcodeblock)->Release()
    }
}

SFCCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCCodeBlockVTable,
}

SFCCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:            proc "system" (this: ^SFCCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:            proc "system" (this: ^SFCCodeBlockIF, Name: BStr) -> HResult,
    SeqControlGet:      proc "system" (this: ^SFCCodeBlockIF, SeqControl: ^VariantBool) -> HResult,
    SeqControlPut:      proc "system" (this: ^SFCCodeBlockIF, SeqControl: VariantBool) -> HResult,
    StepElapsedTimeGet: proc "system" (this: ^SFCCodeBlockIF, StepElapsedTime: ^VariantBool) -> HResult,
    StepElapsedTimePut: proc "system" (this: ^SFCCodeBlockIF, StepElapsedTime: VariantBool) -> HResult,
    SFCViewerAspectGet: proc "system" (this: ^SFCCodeBlockIF, SFCViewerAspect: ^VariantBool) -> HResult,
    SFCViewerAspectPut: proc "system" (this: ^SFCCodeBlockIF, SFCViewerAspect: VariantBool) -> HResult,
    SFCElementsGet:     proc "system" (this: ^SFCCodeBlockIF, SFCElements: ^rawptr) -> HResult,
    Missing16:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    SFCElementsPut:     proc "system" (this: ^SFCCodeBlockIF, SFCElements: rawptr) -> HResult,
    Missing18:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Missing19:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Missing20:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Serialize:          proc "system" (this: ^SFCCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

sfccodeblock_name_get :: proc(sfccodeblock: SFCCodeBlock) -> (name: string, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfccodeblock_name_set :: proc(sfccodeblock: SFCCodeBlock, name: string) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfccodeblock_seq_control_get :: proc(sfccodeblock: SFCCodeBlock) -> (seq_control: bool, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfccodeblock_seq_control_set :: proc(sfccodeblock: SFCCodeBlock, seq_control: bool) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlPut(to_variantbool(seq_control))
    if com_failed(hr) do return

    return true
}

sfccodeblock_step_elapsed_time_get :: proc(sfccodeblock: SFCCodeBlock) -> (step_elapsed_time: bool, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimeGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfccodeblock_step_elapsed_time_set :: proc(sfccodeblock: SFCCodeBlock, step_elapsed_time: bool) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimePut(to_variantbool(step_elapsed_time))
    if com_failed(hr) do return

    return true
}

sfccodeblock_viewer_aspect_get :: proc(sfccodeblock: SFCCodeBlock) -> (viewer_aspect: bool, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfccodeblock_viewer_aspect_set :: proc(sfccodeblock: SFCCodeBlock, viewer_aspect: bool) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectPut(to_variantbool(viewer_aspect))
    if com_failed(hr) do return

    return true
}

sfccodeblock_elements_get :: proc(sfccodeblock: SFCCodeBlock) -> (sfcelements: SFCElements, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsGet(cast(^rawptr)&sfcelements)
    if com_failed(hr) do return

    return sfcelements, true
}

sfccodeblock_elements_set :: proc(sfccodeblock: SFCCodeBlock, sfcelements: SFCElements) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsPut(sfcelements)
    if com_failed(hr) do return

    return true
}

sfccodeblock_serialize :: proc(sfccodeblock: SFCCodeBlock) -> (xml: string, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfccodeblock_release :: proc(sfccodeblock: SFCCodeBlock) {
    if sfccodeblock != nil {
        (^SFCCodeBlockIF)(sfccodeblock)->Release()
    }
}

LDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^LDCodeBlockVTable,
}

LDCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^LDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^LDCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^LDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^LDCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^LDCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^LDCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^LDCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^LDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

ldcodeblock_serialize :: proc(ldcodeblock: LDCodeBlock) -> (xml: string, ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

ldcodeblock_name_get :: proc(ldcodeblock: LDCodeBlock) -> (name: string, ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ldcodeblock_name_set :: proc(ldcodeblock: LDCodeBlock, name: string) -> (ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

ldcodeblock_stcode_get :: proc(ldcodeblock: LDCodeBlock) -> (stcode: string, ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ldcodeblock_stcode_set :: proc(ldcodeblock: LDCodeBlock, stcode: string) -> (ok: bool) {
    if ldcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

ldcodeblock_release :: proc(ldcodeblock: LDCodeBlock) {
    if ldcodeblock != nil {
        (^LDCodeBlockIF)(ldcodeblock)->Release()
    }
}

ILCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILCodeBlockVTable,
}

ILCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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

ilcodeblock_serialize :: proc(ilcodeblock: ILCodeBlock) -> (xml: string, ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

ilcodeblock_name_get :: proc(ilcodeblock: ILCodeBlock) -> (name: string, ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilcodeblock_name_set :: proc(ilcodeblock: ILCodeBlock, name: string) -> (ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

ilcodeblock_ilrows_get :: proc(ilcodeblock: ILCodeBlock) -> (ilrows: ILRows, ok: bool) {
    if ilcodeblock == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsGet(&p)
    if com_failed(hr) do return

    return ILRows(p), true
}

ilcodeblock_ilrows_set :: proc(ilcodeblock: ILCodeBlock, ilrows: ILRows) -> (ok: bool) {
    if ilcodeblock == nil do return
    if ilrows == nil do return
    if !controlbuilder_connected() do return

    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsPut(ilrows)
    if com_failed(hr) do return

    return true
}

ilcodeblock_release :: proc(ilcodeblock: ILCodeBlock) {
    if ilcodeblock != nil {
        (^ILCodeBlockIF)(ilcodeblock)->Release()
    }
}

FDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FDCodeBlockVTable,
}

FDCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:    proc "system" (this: ^FDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:    proc "system" (this: ^FDCodeBlockIF, Name: BStr) -> HResult,
    Missing9:   proc "system" (this: ^FDCodeBlockIF) -> HResult,
    Missing10:  proc "system" (this: ^FDCodeBlockIF) -> HResult,
    Missing11:  proc "system" (this: ^FDCodeBlockIF) -> HResult,
    FDAsXMLGet: proc "system" (this: ^FDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    FDAsXMLPut: proc "system" (this: ^FDCodeBlockIF, XMLStr: BStr) -> HResult,
    Serialize:  proc "system" (this: ^FDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

fdcodeblock_serialize :: proc(fdcodeblock: FDCodeBlock) -> (xml: string, ok: bool) {
    if fdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

fdcodeblock_name_get :: proc(fdcodeblock: FDCodeBlock) -> (name: string, ok: bool) {
    if fdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

fdcodeblock_name_set :: proc(fdcodeblock: FDCodeBlock, name: string) -> (ok: bool) {
    if fdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs :=to_bstr(name)
    defer bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

fdcodeblock_xml_string_get :: proc(fdcodeblock: FDCodeBlock) -> (xml_string: string, ok: bool) {
    if fdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

fdcodeblock_xml_string_set :: proc(fdcodeblock: FDCodeBlock, xml_string: string) -> (ok: bool) {
    if fdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs :=to_bstr(xml_string)
    defer bstr_free(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLPut(bs)
    if com_failed(hr) do return

    return true
}

fdcodeblock_release :: proc(fdcodeblock: FDCodeBlock) {
    if fdcodeblock != nil {
        (^FDCodeBlockIF)(fdcodeblock)->Release()
    }
}

FBDCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FBDCodeBlockVTable,
}

FBDCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^FBDCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^FBDCodeBlockIF, Name: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^FBDCodeBlockIF, XMLStr: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^FBDCodeBlockIF, XMLStr: BStr) -> HResult,
    Missing11: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Missing12: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Missing13: proc "system" (this: ^FBDCodeBlockIF) -> HResult,
    Serialize: proc "system" (this: ^FBDCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

fbdcodeblock_serialize :: proc(fbdcodeblock: FBDCodeBlock) -> (xml: string, ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

fbdcodeblock_name_get :: proc(fbdcodeblock: FBDCodeBlock) -> (name: string, ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}


fbdcodeblock_name_set :: proc(fbdcodeblock: FBDCodeBlock, name: string) -> (ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

fbdcodeblock_stcode_get :: proc(fbdcodeblock: FBDCodeBlock) -> (stcode: string, ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

fbdcodeblock_stcode_set :: proc(fbdcodeblock: FBDCodeBlock, stcode: string) -> (ok: bool) {
    if fbdcodeblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

fbdcodeblock_release :: proc(fbdcodeblock: FBDCodeBlock) {
    if fbdcodeblock != nil {
        (^FBDCodeBlockIF)(fbdcodeblock)->Release()
    }
}
