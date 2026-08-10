package cbopenif

FunctionBlocks :: distinct rawptr

FunctionBlocksIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlocksVTable,
}

FunctionBlocksVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^FunctionBlocksIF, FunctionBlocks: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^FunctionBlocksIF, FunctionBlocks: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^FunctionBlocksIF, Name, TypeName: BStr, FunctionBlock: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^FunctionBlocksIF, Name, TypeName, TaskConnection, Guid, Description: BStr, FunctionBlock: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^FunctionBlocksIF, Name: BStr, FunctionBlock: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^FunctionBlocksIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^FunctionBlocksIF, Index: i32, FunctionBlock: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^FunctionBlocksIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^FunctionBlocksIF, Index: i32) -> HResult,
}

functionblocks_functionblock_add :: proc {
    functionblocks_functionblock_add_,
    functionblocks_functionblock_add_at_index,
}

functionblocks_functionblock_add_ :: proc(functionblocks: FunctionBlocks, functionblock: FunctionBlock) -> (ok: bool) {
    if functionblocks == nil do return
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Add(functionblock)
    if com_failed(hr) do return

    return true
}

functionblocks_functionblock_add_at_index :: proc(functionblocks: FunctionBlocks, functionblock: FunctionBlock, index: i32) -> (ok: bool) {
    if functionblocks == nil do return
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->AddBefore(functionblock, index)
    if com_failed(hr) do return

    return true
}

functionblocks_functionblock :: proc {
    functionblocks_functionblock_by_name,
    functionblocks_functionblock_by_index,
}

functionblocks_functionblock_by_name :: proc(functionblocks: FunctionBlocks, name: string) -> (functionblock: FunctionBlock, ok: bool) {
    if functionblocks == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^FunctionBlocksIF)(functionblocks)->Find(bstr_name, cast(^rawptr)&functionblock)
    if com_failed(hr) do return

    return functionblock, true
}

functionblocks_functionblock_by_index :: proc(functionblocks: FunctionBlocks, index: i32) -> (functionblock: FunctionBlock, ok: bool) {
    if functionblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Item(index + 1, cast(^rawptr)&functionblock)
    if com_failed(hr) do return

    return functionblock, true
}

functionblocks_functionblock_index :: proc(functionblocks: FunctionBlocks, name: string) -> (index: i32, ok: bool) {
    if functionblocks == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^FunctionBlocksIF)(functionblocks)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

functionblocks_functionblock_count :: proc(functionblocks: FunctionBlocks) -> (count: i32, ok: bool) {
    if functionblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

functionblocks_functionblock_remove :: proc {
    functionblocks_functionblock_remove_by_name,
    functionblocks_functionblock_remove_by_index,
}

functionblocks_functionblock_remove_by_name :: proc(functionblocks: FunctionBlocks, name: string) -> (ok: bool) {
    if functionblocks == nil do return
    if !controlbuilder_connected() do return

    index, found := functionblocks_functionblock_index(functionblocks, name)
    if !found do return

    hr := (^FunctionBlocksIF)(functionblocks)->Remove(index)
    if com_failed(hr) do return

    return true
}

functionblocks_functionblock_remove_by_index :: proc(functionblocks: FunctionBlocks, index: i32) -> (ok: bool) {
    if functionblocks == nil do return
    if !controlbuilder_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

functionblocks_release :: proc(functionblocks: FunctionBlocks) {
    if functionblocks != nil {
        (^FunctionBlocksIF)(functionblocks)->Release()
    }
}
