package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"

CodeBlocksIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^CodeBlocksVTable,
}

CodeBlocksVTable :: struct {
    using iunknown_vtable: com.IUnknownVTable,
    Add:              proc "system" (this: ^CodeBlocksIF, CodeBlock: rawptr) -> HResult,
    AddBefore:        proc "system" (this: ^CodeBlocksIF, CodeBlock: rawptr, BeforeIndex: i32) -> HResult,
    AddSTCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: rawptr) -> HResult,
    AddSTCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^rawptr) -> HResult,
    AddSTCodeBlock2:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, Code: ^rawptr) -> HResult,
    AddLDCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: rawptr) -> HResult,
    AddLDCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^rawptr) -> HResult,
    AddLDCodeBlock2:  proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, Code: ^rawptr) -> HResult,
    AddFBDCodeBlock:  proc "system" (this: ^CodeBlocksIF, Code: rawptr) -> HResult,
    AddFBDCodeBlock1: proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^rawptr) -> HResult,
    AddFBDCodeBlock2: proc "system" (this: ^CodeBlocksIF, Name: BStr, STCode: ^BStr, Code: ^rawptr) -> HResult,
    AddILCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: rawptr) -> HResult,
    AddILCodeBlock1:  proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^rawptr) -> HResult,
    AddSFCCodeBlock:  proc "system" (this: ^CodeBlocksIF, Code: rawptr) -> HResult,
    AddSFCCodeBlock1: proc "system" (this: ^CodeBlocksIF, Name: BStr, Code: ^rawptr) -> HResult,
    AddSFCCodeBlock2: proc "system" (this: ^CodeBlocksIF, Name: BStr, SeqControl, StepElapsedTime: VariantBool, Code: ^rawptr) -> HResult,
    Find:             proc "system" (this: ^CodeBlocksIF, Name: BStr, CodeBlock: ^rawptr) -> HResult,
    FindNr:           proc "system" (this: ^CodeBlocksIF, Name: BStr, Index: ^i32) -> HResult,
    Item:             proc "system" (this: ^CodeBlocksIF, Index: i32, CodeBlock: ^rawptr) -> HResult,
    Count:            proc "system" (this: ^CodeBlocksIF, Count: ^i32) -> HResult,
    Remove:           proc "system" (this: ^CodeBlocksIF, Index: i32) -> HResult,
    AddFDCodeBlock:   proc "system" (this: ^CodeBlocksIF, Code: rawptr) -> HResult,
}

codeblocks_add :: proc {
    codeblocks_add_,
    codeblocks_add_at_index,
}

codeblocks_add_ :: proc(codeblocks: rawptr, codeblock: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if codeblock == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Add(codeblock)
    if com.failed(hr) do return

    return true
}


codeblocks_add_at_index :: proc(codeblocks: rawptr, codeblock: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if codeblock == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddBefore(codeblock, index)
    if com.failed(hr) do return

    return true
}

codeblocks_add_st :: proc(codeblocks: rawptr, code: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddSTCodeBlock(code)
    if com.failed(hr) do return

    return true
}

codeblocks_add_ld :: proc(codeblocks: rawptr, code: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddLDCodeBlock(code)
    if com.failed(hr) do return

    return true
}

codeblocks_add_fbd :: proc(codeblocks: rawptr, code: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddFBDCodeBlock(code)
    if com.failed(hr) do return

    return true
}

codeblocks_add_il :: proc(codeblocks: rawptr, code: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddILCodeBlock(code)
    if com.failed(hr) do return

    return true
}

codeblocks_add_sfc :: proc(codeblocks: rawptr, code: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddSFCCodeBlock(code)
    if com.failed(hr) do return

    return true
}

codeblocks_add_fd :: proc(codeblocks: rawptr, code: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return
    if code == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->AddFDCodeBlock(code)
    if com.failed(hr) do return

    return true
}

codeblocks_codeblock :: proc {
    codeblocks_codeblock_by_name,
    codeblocks_codeblock_by_index,
}

codeblocks_codeblock_by_name :: proc(codeblocks: rawptr, name: string) -> (codeblock: rawptr, ok: bool) {
    codeblock = nil
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return

    bstr_name := bstr.from_string(name)
    defer bstr.free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->Find(bstr_name, &codeblock)
    if com.failed(hr) do return

    return codeblock, true
}

codeblocks_codeblock_by_index :: proc(codeblocks: rawptr, index: i32) -> (codeblock: rawptr, ok: bool) {
    codeblock = nil
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Item(index, &codeblock)
    if com.failed(hr) do return

    return codeblock, true
}

codeblocks_codeblock_index :: proc(codeblocks: rawptr, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return

    bstr_name := bstr.from_string(name)
    defer bstr.free(bstr_name)
    hr := (^CodeBlocksIF)(codeblocks)->FindNr(bstr_name, &index)
    if com.failed(hr) do return

    return index, true
}

codeblocks_count :: proc(codeblocks: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

codeblocks_remove :: proc(codeblocks: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if codeblocks == nil do return

    hr := (^CodeBlocksIF)(codeblocks)->Remove(index)
    if com.failed(hr) do return

    return true
}

codeblocks_release :: proc(codeblocks: rawptr) {
    if codeblocks != nil {
        (^CodeBlocksIF)(codeblocks)->Release()
    }
}
