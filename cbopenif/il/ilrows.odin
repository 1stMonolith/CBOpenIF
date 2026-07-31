package il

import "../com"
import "../controlbuilder"

ILRowsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ILRowsVTable,
}

ILRowsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:        proc "system" (this: ^ILRowsIF, ILRow: rawptr) -> HResult,
    AddBefore:  proc "system" (this: ^ILRowsIF, ILRow: rawptr, Index: i32) -> HResult,
    AddRow:     proc "system" (this: ^ILRowsIF, Label, Instruction, Operand, Description: BStr, ILRow: ^rawptr) -> HResult,
    AddComment: proc "system" (this: ^ILRowsIF, Comment: BStr, ILRow: ^rawptr) -> HResult,
    Item:       proc "system" (this: ^ILRowsIF, Index: i32, ILRow: ^rawptr) -> HResult,
    Count:      proc "system" (this: ^ILRowsIF, Count: ^i32) -> HResult,
    Remove:     proc "system" (this: ^ILRowsIF, Index: i32) -> HResult,
}

ilrows_add :: proc {
    ilrows_add_,
    ilrows_add_at_index,
}

@(private)
ilrows_add_ :: proc(ilrows: rawptr, ilrow: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if ilrows == nil do return
    if ilrow == nil do return

    hr := (^ILRowsIF)(ilrows)->Add(ilrow)
    if com.failed(hr) do return

    return true
}

ilrows_add_at_index :: proc(ilrows: rawptr, ilrow: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if ilrows == nil do return
    if ilrow == nil do return
    
    hr := (^ILRowsIF)(ilrows)->AddBefore(ilrow, index)
    if com.failed(hr) do return

    return true
}

ilrows_ilrow :: proc {
    ilrows_ilrow_by_index,
}

ilrows_ilrow_by_index :: proc(ilrows: rawptr, index: i32) -> (ilrow: rawptr, ok: bool) {
    ilrow = nil
    ok = false

    if !controlbuilder.connected() do return
    if ilrows == nil do return
    
    hr := (^ILRowsIF)(ilrows)->Item(index, &ilrow)
    if com.failed(hr) do return
    
    return ilrow, true
}

ilrows_count :: proc(ilrows: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if ilrows == nil do return
    
    hr := (^ILRowsIF)(ilrows)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

ilrows_remove :: proc(ilrows: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if ilrows == nil do return
    
    hr := (^ILRowsIF)(ilrows)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

ilrows_release :: proc(ilrows: rawptr) {
    if ilrows != nil {
        (^ILRowsIF)(ilrows)->Release()
    }
}
