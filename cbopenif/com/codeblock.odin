package com

CodeBlocks   :: distinct rawptr
ICodeBlock   :: distinct rawptr
STCodeBlock  :: distinct rawptr
SFCCodeBlock :: distinct rawptr
LDCodeBlock  :: distinct rawptr
ILCodeBlock  :: distinct rawptr
FDCodeBlock  :: distinct rawptr
FBDCodeBlock :: distinct rawptr

CodeBlock :: union {
    STCodeBlock,
    SFCCodeBlock,
    FBDCodeBlock,
    LDCodeBlock,
    ILCodeBlock,
    FDCodeBlock,
}

IID_STCodeBlock  :: GUID{0x79C9A3E8, 0x451D, 0x4EE8, {0xB9, 0xFF, 0xA4, 0x1A, 0xA9, 0x02, 0x4B, 0x65}}
IID_SFCCodeBlock :: GUID{0x04E1622A, 0x175C, 0x4EBC, {0x9A, 0x3D, 0xEC, 0x9E, 0x81, 0x4F, 0xD0, 0x6A}}
IID_FBDCodeBlock :: GUID{0x97BB6A82, 0xC2E1, 0x401C, {0x9A, 0x72, 0x4A, 0xC7, 0xC0, 0xE6, 0x7B, 0x8D}}
IID_LDCodeBlock  :: GUID{0x76EEDE55, 0x5C23, 0x4461, {0x80, 0xDF, 0xA3, 0x75, 0x4B, 0x4B, 0xE9, 0xDD}}
IID_ILCodeBlock  :: GUID{0x5D6751B5, 0xA285, 0x4095, {0x9F, 0x08, 0x44, 0x1A, 0xF0, 0x03, 0x11, 0x57}}
IID_FDCodeBlock  :: GUID{0xF2927D61, 0x5DDD, 0x44A2, {0xAF, 0x02, 0x1B, 0x69, 0xCA, 0x89, 0xB1, 0x52}}

CodeBlocksIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CodeBlocksVTable,
}

CodeBlocksVTable :: struct
{
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

AddCodeBlock :: proc(codeblocks: CodeBlocks, codeblock: CodeBlock) -> (ok: bool)
{
    if codeblocks == nil do return
    if codeblock == nil do return
    if !ComConnected() do return

    hr: HResult
    switch block in codeblock {
        case STCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddSTCodeBlock(codeblock.(STCodeBlock))
        case LDCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddLDCodeBlock(codeblock.(LDCodeBlock))
        case FBDCodeBlock: hr = (^CodeBlocksIF)(codeblocks)->AddFBDCodeBlock(codeblock.(FBDCodeBlock))
        case ILCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddILCodeBlock(codeblock.(ILCodeBlock))
        case SFCCodeBlock: hr = (^CodeBlocksIF)(codeblocks)->AddSFCCodeBlock(codeblock.(SFCCodeBlock))
        case FDCodeBlock:  hr = (^CodeBlocksIF)(codeblocks)->AddFDCodeBlock(codeblock.(FDCodeBlock))
    }
    if ComFailed(hr) do return

    return true
}

GetCodeBlockWithName :: proc(codeblocks: CodeBlocks, name: string) -> (codeblock: CodeBlock, ok: bool)
{
    if codeblocks == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    i: ICodeBlock
    hr := (^CodeBlocksIF)(codeblocks)->Find(bstr_name, cast(^rawptr)&i)
    if ComFailed(hr) do return
    defer ReleaseICodeBlock(i)

    return FromICodeBlock(i)
}

GetCodeBlockAtIndex :: proc(codeblocks: CodeBlocks, index: i32) -> (codeblock: CodeBlock, ok: bool)
{
    if codeblocks == nil do return
    if !ComConnected() do return

    i: ICodeBlock
    hr := (^CodeBlocksIF)(codeblocks)->Item(index + 1, cast(^rawptr)&i)
    if ComFailed(hr) do return
    defer ReleaseICodeBlock(i)

    return FromICodeBlock(i)
}

CodeBlockIndex :: proc(codeblocks: CodeBlocks, name: string) -> (index: i32, ok: bool)
{
    if codeblocks == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

CodeBlockCount :: proc(codeblocks: CodeBlocks) -> (count: i32, ok: bool)
{
    if codeblocks == nil do return
    if !ComConnected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveCodeBlock :: proc {
    _RemoveCodeBlockWithName,
    _RemoveCodeBlockAtIndex,
}

_RemoveCodeBlockWithName :: proc(codeblocks: CodeBlocks, name: string) -> (ok: bool)
{
    if codeblocks == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = CodeBlockIndex(codeblocks, name)
    if !ok do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveCodeBlockAtIndex :: proc(codeblocks: CodeBlocks, index: i32) -> (ok: bool)
{
    if codeblocks == nil do return
    if !ComConnected() do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseCodeBlocks :: proc(codeblocks: CodeBlocks) {
    if codeblocks != nil {
        (^CodeBlocksIF)(codeblocks)->Release()
    }
}

ICodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ICodeBlockVTable,
}

ICodeBlockVTable :: struct
{
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

IsSTCodeBlock :: proc(icodeblock: ICodeBlock) -> (is_st: bool, ok: bool)
{
    if icodeblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSTCodeBlock(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsSTCodeBlock :: proc(icodeblock: ICodeBlock) -> (stcodeblock: STCodeBlock, ok: bool)
{
    if icodeblock == nil do return

    IID := IID_STCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&stcodeblock)
    if ComFailed(hr) do return

    return stcodeblock, true
}

IsSFCCodeBlock :: proc(icodeblock: ICodeBlock) -> (is_sfc: bool, ok: bool)
{
    if icodeblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsSFCCodeBlock(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsSFCCodeBlock :: proc(icodeblock: ICodeBlock) -> (sfccodeblock: SFCCodeBlock, ok: bool)
{
    if icodeblock == nil do return

    IID := IID_SFCCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&sfccodeblock)
    if ComFailed(hr) do return

    return sfccodeblock, true
}

IsILCodeBlock :: proc(icodeblock: ICodeBlock) -> (is_il: bool, ok: bool)
{
    if icodeblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsILCodeBlock(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsILCodeBlock :: proc(icodeblock: ICodeBlock) -> (ilcodeblock: ILCodeBlock, ok: bool)
{
    if icodeblock == nil do return

    IID := IID_ILCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&ilcodeblock)
    if ComFailed(hr) do return

    return ilcodeblock, true
}

IsFBDCodeBlock :: proc(icodeblock: ICodeBlock) -> (is_fbd: bool, ok: bool)
{
    if icodeblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFBDCodeBlock(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsFBDCodeBlock :: proc(icodeblock: ICodeBlock) -> (fbdcodeblock: ILCodeBlock, ok: bool)
{
    if icodeblock == nil do return

    IID := IID_FBDCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&fbdcodeblock)
    if ComFailed(hr) do return

    return fbdcodeblock, true
}

IsLDCodeBlock :: proc(icodeblock: ICodeBlock) -> (is_ld: bool, ok: bool)
{
    if icodeblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsLDCodeBlock(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsLDCodeBlock :: proc(icodeblock: ICodeBlock) -> (ldcodeblock: ILCodeBlock, ok: bool)
{
    if icodeblock == nil do return

    IID := IID_LDCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&ldcodeblock)
    if ComFailed(hr) do return

    return ldcodeblock, true
}

IsFDCodeBlock :: proc(icodeblock: ICodeBlock) -> (is_fd: bool, ok: bool)
{
    if icodeblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ICodeBlockIF)(icodeblock)->IsFDCodeBlock(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsFDCodeBlock :: proc(icodeblock: ICodeBlock) -> (fdcodeblock: ILCodeBlock, ok: bool)
{
    if icodeblock == nil do return

    IID := IID_FDCodeBlock
    hr := (^IUnknownIF)(icodeblock)->QueryInterface(&IID, cast(^rawptr)&fdcodeblock)
    if ComFailed(hr) do return

    return fdcodeblock, true
}

ReleaseICodeBlock :: proc(icodeblock: ICodeBlock) {
    if icodeblock != nil {
        (^ICodeBlockIF)(icodeblock)->Release()
    }
}

FromICodeBlock :: proc(icodeblock: ICodeBlock) -> (codeblock: CodeBlock, ok: bool)
{
    if icodeblock == nil do return

    is: bool

    is, ok = IsSTCodeBlock(icodeblock);
    if ok && is {
        st, okas := AsSTCodeBlock(icodeblock)
        if !okas do return
        return st, true 
    }

    is, ok = IsSFCCodeBlock(icodeblock)
    if ok && is {
        sfc, okas := AsSFCCodeBlock(icodeblock)
        if !okas do return
        return sfc, true 
    }

    is, ok = IsFBDCodeBlock(icodeblock)
    if ok && is {
        fbd, okas := AsFBDCodeBlock(icodeblock)
        if !okas do return
        return fbd, true 
    }

    is, ok = IsLDCodeBlock(icodeblock)
    if ok && is {
        ld, okas := AsLDCodeBlock(icodeblock)
        if !okas do return
        return ld, true 
    }

    is, ok = IsILCodeBlock(icodeblock)
    if ok && is {
        il, okas := AsILCodeBlock(icodeblock)
        if !okas do return
        return il, true 
    }

    is, ok = IsFDCodeBlock(icodeblock)
    if ok && is {
        fd, okas := AsFDCodeBlock(icodeblock)
        if !okas do return
        return fd, true 
    }

    return {}, false
}

GetCodeBlockName :: proc(codeblock: CodeBlock) -> (name: string, ok: bool)
{
    switch cb in codeblock {
        case STCodeBlock:  return GetSTCodeBlockName(cb)
        case SFCCodeBlock: return GetSFCCodeBlockName(cb)
        case FBDCodeBlock: return GetFBDCodeBlockName(cb)
        case LDCodeBlock:  return GetLDCodeBlockName(cb)
        case ILCodeBlock:  return GetILCodeBlockName(cb)
        case FDCodeBlock:  return GetFDCodeBlockName(cb)
    }
    return
}

SetCodeBlockName :: proc(codeblock: CodeBlock, name: string) -> (ok: bool)
{
    switch cb in codeblock {
        case STCodeBlock:  return SetSTCodeBlockName(cb, name)
        case SFCCodeBlock: return SetSFCCodeBlockName(cb, name)
        case FBDCodeBlock: return SetFBDCodeBlockName(cb, name)
        case LDCodeBlock:  return SetLDCodeBlockName(cb, name)
        case ILCodeBlock:  return SetILCodeBlockName(cb, name)
        case FDCodeBlock:  return SetFDCodeBlockName(cb, name)
    }
    return
}

ReleaseCodeBlock :: proc(codeblock: CodeBlock) {
    switch cb in codeblock {
        case STCodeBlock:  ReleaseSTCodeBlock(cb)
        case SFCCodeBlock: ReleaseSFCCodeBlock(cb)
        case FBDCodeBlock: ReleaseFBDCodeBlock(cb)
        case LDCodeBlock:  ReleaseLDCodeBlock(cb)
        case ILCodeBlock:  ReleaseILCodeBlock(cb)
        case FDCodeBlock:  ReleaseFDCodeBlock(cb)
    }
}

SerializeCodeBlock :: proc(codeblock: CodeBlock) -> (xml: string, ok: bool)
{
    switch cb in codeblock {
        case STCodeBlock:  return SerializeSTCodeBlock(cb)
        case SFCCodeBlock: return SerializeSFCCodeBlock(cb)
        case FBDCodeBlock: return SerializeFBDCodeBlock(cb)
        case LDCodeBlock:  return SerializeLDCodeBlock(cb)
        case ILCodeBlock:  return SerializeILCodeBlock(cb)
        case FDCodeBlock:  return SerializeFDCodeBlock(cb)
    }
    return
}

GetCodeBlockStCode :: proc(codeblock: CodeBlock) -> (stcode: string, ok: bool)
{
    #partial switch cb in codeblock {
        case STCodeBlock:  return GetSTCodeBlockStCode(cb)
        case FBDCodeBlock: return GetFBDCodeBlockSTCode(cb)
        case LDCodeBlock:  return GetLDCodeBlockStCode(cb)
    }
    return
}

SetCodeBlockStCode :: proc(codeblock: CodeBlock, stcode: string) -> (ok: bool)
{
    #partial switch cb in codeblock {
        case STCodeBlock:  return SetSTCodeBlockStCode(cb, stcode)
        case FBDCodeBlock: return SetFBDCodeBlockSTCode(cb, stcode)
        case LDCodeBlock:  return SetLDCodeBlockStCode(cb, stcode)
    }
    return
}

STCodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^STCodeBlockVTable,
}

STCodeBlockVTable :: struct
{
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

SerializeSTCodeBlock :: proc(stcodeblock: STCodeBlock) -> (xml: string, ok: bool)
{
    if stcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetSTCodeBlockName :: proc(stcodeblock: STCodeBlock) -> (name: string, ok: bool)
{
    if stcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSTCodeBlockName :: proc(stcodeblock: STCodeBlock, name: string) -> (ok: bool)
{
    if stcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSTCodeBlockStCode :: proc(stcodeblock: STCodeBlock) -> (stcode: string, ok: bool)
{
    if stcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSTCodeBlockStCode :: proc(stcodeblock: STCodeBlock, stcode: string) -> (ok: bool)
{
    if stcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^STCodeBlockIF)(stcodeblock)->STCodePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseSTCodeBlock :: proc(stcodeblock: STCodeBlock) {
    if stcodeblock != nil {
        (^STCodeBlockIF)(stcodeblock)->Release()
    }
}

SFCCodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCCodeBlockVTable,
}

SFCCodeBlockVTable :: struct
{
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

GetSFCCodeBlockName :: proc(sfccodeblock: SFCCodeBlock) -> (name: string, ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCCodeBlockName :: proc(sfccodeblock: SFCCodeBlock, name: string) -> (ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCCodeBlockSeqControl :: proc(sfccodeblock: SFCCodeBlock) -> (seq_control: bool, ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetSFCCodeBlockSeqControl :: proc(sfccodeblock: SFCCodeBlock, seq_control: bool) -> (ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlPut(ToVariantBool(seq_control))
    if ComFailed(hr) do return

    return true
}

GetSFCCodeBlockStepElapsedTime :: proc(sfccodeblock: SFCCodeBlock) -> (step_elapsed_time: bool, ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimeGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetSFCCodeBlockStepElapsedTime :: proc(sfccodeblock: SFCCodeBlock, step_elapsed_time: bool) -> (ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimePut(ToVariantBool(step_elapsed_time))
    if ComFailed(hr) do return

    return true
}

GetSFCCodeBlockViewerAspect :: proc(sfccodeblock: SFCCodeBlock) -> (viewer_aspect: bool, ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetSFCCodeBlockViewerAspect :: proc(sfccodeblock: SFCCodeBlock, viewer_aspect: bool) -> (ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectPut(ToVariantBool(viewer_aspect))
    if ComFailed(hr) do return

    return true
}

GetSFCCodeBlockElements :: proc(sfccodeblock: SFCCodeBlock) -> (sfcelements: SFCElements, ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsGet(cast(^rawptr)&sfcelements)
    if ComFailed(hr) do return

    return sfcelements, true
}

SetSFCCodeBlockElements :: proc(sfccodeblock: SFCCodeBlock, sfcelements: SFCElements) -> (ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsPut(sfcelements)
    if ComFailed(hr) do return

    return true
}

SerializeSFCCodeBlock :: proc(sfccodeblock: SFCCodeBlock) -> (xml: string, ok: bool)
{
    if sfccodeblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseSFCCodeBlock :: proc(sfccodeblock: SFCCodeBlock) {
    if sfccodeblock != nil {
        (^SFCCodeBlockIF)(sfccodeblock)->Release()
    }
}

LDCodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^LDCodeBlockVTable,
}

LDCodeBlockVTable :: struct
{
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

SerializeLDCodeBlock :: proc(ldcodeblock: LDCodeBlock) -> (xml: string, ok: bool)
{
    if ldcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetLDCodeBlockName :: proc(ldcodeblock: LDCodeBlock) -> (name: string, ok: bool)
{
    if ldcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetLDCodeBlockName :: proc(ldcodeblock: LDCodeBlock, name: string) -> (ok: bool)
{
    if ldcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetLDCodeBlockStCode :: proc(ldcodeblock: LDCodeBlock) -> (stcode: string, ok: bool)
{
    if ldcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetLDCodeBlockStCode :: proc(ldcodeblock: LDCodeBlock, stcode: string) -> (ok: bool)
{
    if ldcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^LDCodeBlockIF)(ldcodeblock)->STCodePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseLDCodeBlock :: proc(ldcodeblock: LDCodeBlock) {
    if ldcodeblock != nil {
        (^LDCodeBlockIF)(ldcodeblock)->Release()
    }
}

ILCodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILCodeBlockVTable,
}

ILCodeBlockVTable :: struct
{
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

SerializeILCodeBlock :: proc(ilcodeblock: ILCodeBlock) -> (xml: string, ok: bool)
{
    if ilcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetILCodeBlockName :: proc(ilcodeblock: ILCodeBlock) -> (name: string, ok: bool)
{
    if ilcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetILCodeBlockName :: proc(ilcodeblock: ILCodeBlock, name: string) -> (ok: bool)
{
    if ilcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ILCodeBlockIF)(ilcodeblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetILCodeBlockILRows :: proc(ilcodeblock: ILCodeBlock) -> (ilrows: ILRows, ok: bool)
{
    if ilcodeblock == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsGet(&p)
    if ComFailed(hr) do return

    return ILRows(p), true
}

SetILCodeBlockILRows :: proc(ilcodeblock: ILCodeBlock, ilrows: ILRows) -> (ok: bool)
{
    if ilcodeblock == nil do return
    if ilrows == nil do return
    if !ComConnected() do return

    hr := (^ILCodeBlockIF)(ilcodeblock)->ILRowsPut(ilrows)
    if ComFailed(hr) do return

    return true
}

ReleaseILCodeBlock :: proc(ilcodeblock: ILCodeBlock) {
    if ilcodeblock != nil {
        (^ILCodeBlockIF)(ilcodeblock)->Release()
    }
}

FDCodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FDCodeBlockVTable,
}

FDCodeBlockVTable :: struct
{
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

SerializeFDCodeBlock :: proc(fdcodeblock: FDCodeBlock) -> (xml: string, ok: bool)
{
    if fdcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetFDCodeBlockName :: proc(fdcodeblock: FDCodeBlock) -> (name: string, ok: bool)
{
    if fdcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFDCodeBlockName :: proc(fdcodeblock: FDCodeBlock, name: string) -> (ok: bool)
{
    if fdcodeblock == nil do return
    if !ComConnected() do return
    
    bs :=ToBstr(name)
    defer FreeBstr(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetFDCodeBlockAsXML :: proc(fdcodeblock: FDCodeBlock) -> (xml_string: string, ok: bool)
{
    if fdcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFDCodeBlockFromXML :: proc(fdcodeblock: FDCodeBlock, xml_string: string) -> (ok: bool)
{
    if fdcodeblock == nil do return
    if !ComConnected() do return
    
    bs :=ToBstr(xml_string)
    defer FreeBstr(bs)
    hr := (^FDCodeBlockIF)(fdcodeblock)->FDAsXMLPut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseFDCodeBlock :: proc(fdcodeblock: FDCodeBlock) {
    if fdcodeblock != nil {
        (^FDCodeBlockIF)(fdcodeblock)->Release()
    }
}

FBDCodeBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FBDCodeBlockVTable,
}

FBDCodeBlockVTable :: struct
{
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

SerializeFBDCodeBlock :: proc(fbdcodeblock: FBDCodeBlock) -> (xml: string, ok: bool)
{
    if fbdcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetFBDCodeBlockName :: proc(fbdcodeblock: FBDCodeBlock) -> (name: string, ok: bool)
{
    if fbdcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}


SetFBDCodeBlockName :: proc(fbdcodeblock: FBDCodeBlock, name: string) -> (ok: bool)
{
    if fbdcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetFBDCodeBlockSTCode :: proc(fbdcodeblock: FBDCodeBlock) -> (stcode: string, ok: bool)
{
    if fbdcodeblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFBDCodeBlockSTCode :: proc(fbdcodeblock: FBDCodeBlock, stcode: string) -> (ok: bool)
{
    if fbdcodeblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^FBDCodeBlockIF)(fbdcodeblock)->STCodePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseFBDCodeBlock :: proc(fbdcodeblock: FBDCodeBlock) {
    if fbdcodeblock != nil {
        (^FBDCodeBlockIF)(fbdcodeblock)->Release()
    }
}
