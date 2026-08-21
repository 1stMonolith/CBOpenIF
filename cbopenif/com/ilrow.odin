package com

import t "../types"

ILRow  :: distinct rawptr
ILRows :: distinct rawptr

ILRowIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILRowVTable,
}

ILRowVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    LabelGet:        proc "system" (this: ^ILRowIF, Label: ^BStr) -> HResult,
    LabelPut:        proc "system" (this: ^ILRowIF, Label: BStr) -> HResult,
    InstructionGet:  proc "system" (this: ^ILRowIF, Instruction: ^BStr) -> HResult,
    InstructionPut:  proc "system" (this: ^ILRowIF, Instruction: BStr) -> HResult,
    OperandGet:      proc "system" (this: ^ILRowIF, Operand: ^BStr) -> HResult,
    OperandPut:      proc "system" (this: ^ILRowIF, Operand: BStr) -> HResult,
    DescriptionGet:  proc "system" (this: ^ILRowIF, Description: ^BStr) -> HResult,
    DescriptionPut:  proc "system" (this: ^ILRowIF, Description: BStr) -> HResult,
    RowCommentGet:   proc "system" (this: ^ILRowIF, RowComment: ^BStr) -> HResult,
    RowCommentPut:   proc "system" (this: ^ILRowIF, RowComment: BStr) -> HResult,
    IsRowCommentPut: proc "system" (this: ^ILRowIF, IsFDILRow: VariantBool) -> HResult,
    IsRowCommentGet: proc "system" (this: ^ILRowIF, IsFDILRow: ^VariantBool) -> HResult,
}

ilrow_label_get :: proc(ilrow: ILRow) -> (label: string, ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->LabelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_label_set :: proc(ilrow: ILRow, label: string) -> (ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs := to_bstr(label)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->LabelPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_instruction_get :: proc(ilrow: ILRow) -> (instruction: string, ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_instruction_set :: proc(ilrow: ILRow, instruction: string) -> (ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs := to_bstr(instruction)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_operand_get :: proc(ilrow: ILRow) -> (operand: string, ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_operand_set :: proc(ilrow: ILRow, operand: string) -> (ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs := to_bstr(operand)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_description_get :: proc(ilrow: ILRow) -> (description: string, ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_description_set :: proc(ilrow: ILRow, description: string) -> (ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_row_comment_get :: proc(ilrow: ILRow) -> (row_comment: string, ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_row_comment_set :: proc(ilrow: ILRow, row_comment: string) -> (ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    bs := to_bstr(row_comment)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_is_row_comment_get :: proc(ilrow: ILRow) -> (is_row_comment: bool, ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ILRowIF)(ilrow)->IsRowCommentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

ilrow_is_row_comment_set :: proc(ilrow: ILRow, is_row_comment: bool) -> (ok: bool) {
    if ilrow == nil do return
    if !com_connected() do return
    
    hr := (^ILRowIF)(ilrow)->IsRowCommentPut(to_variantbool(is_row_comment))
    if com_failed(hr) do return

    return true
}

ilrow_release :: proc(ilrow: ILRow) {
    if ilrow != nil {
        (^ILRowIF)(ilrow)->Release()
    }
}

ilrow_from_com :: proc(ilrow: ILRow, allocator := context.allocator) -> (result: t.ILRow, ok: bool) {
    if ilrow == nil do return

    context.allocator = allocator

    result.label, ok = ilrow_label_get(ilrow)
    if !ok do return
    result.instruction, ok = ilrow_instruction_get(ilrow)
    if !ok do return
    result.operand, ok = ilrow_operand_get(ilrow)
    if !ok do return
    result.description, ok = description(ilrow)
    if !ok do return
    result.row_comment, ok = ilrow_row_comment_get(ilrow)
    if !ok do return
    result.is_row_comment, ok = ilrow_is_row_comment_get(ilrow)
    if !ok do return

    return result, true
}

ilrow_to_com :: proc(src: t.ILRow) -> (result: ILRow, ok: bool) {
    ilrow: ILRow
    if src.is_row_comment {
        ilrow, ok = ilrow_new1(src.row_comment)
        if !ok do return
        return ilrow, true
    }

    ilrow, ok = ilrow_new(src.label, src.instruction, src.operand, src.description)
    if !ok do return
    defer if !ok do release(ilrow)

    ok = ilrow_row_comment_set(ilrow, src.row_comment)
    if !ok do return

    return ilrow, true
}

ILRowsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILRowsVTable,
}

ILRowsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:        proc "system" (this: ^ILRowsIF, ILRow: rawptr) -> HResult,
    AddBefore:  proc "system" (this: ^ILRowsIF, ILRow: rawptr, Index: i32) -> HResult,
    AddRow:     proc "system" (this: ^ILRowsIF, Label, Instruction, Operand, Description: BStr, ILRow: ^rawptr) -> HResult,
    AddComment: proc "system" (this: ^ILRowsIF, Comment: BStr, ILRow: ^rawptr) -> HResult,
    Item:       proc "system" (this: ^ILRowsIF, Index: i32, ILRow: ^rawptr) -> HResult,
    Count:      proc "system" (this: ^ILRowsIF, Count: ^i32) -> HResult,
    Remove:     proc "system" (this: ^ILRowsIF, Index: i32) -> HResult,
}

ilrows_ilrow_add :: proc(ilrows: ILRows, ilrow: ILRow) -> (ok: bool) {
    if ilrows == nil do return
    if ilrow == nil do return
    if !com_connected() do return

    hr := (^ILRowsIF)(ilrows)->Add(ilrow)
    if com_failed(hr) do return

    return true
}

ilrows_ilrow_add_at_index :: proc(ilrows: ILRows, ilrow: ILRow, index: i32) -> (ok: bool) {
    if ilrows == nil do return
    if ilrow == nil do return
    if !com_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->AddBefore(ilrow, index)
    if com_failed(hr) do return

    return true
}

ilrows_ilrow_by_index :: proc(ilrows: ILRows, index: i32) -> (ilrow: ILRow, ok: bool) {
    if ilrows == nil do return
    if !com_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->Item(index + 1, cast(^rawptr)&ilrow)
    if com_failed(hr) do return
    
    return ilrow, true
}

ilrows_ilrow_count :: proc(ilrows: ILRows) -> (count: i32, ok: bool) {
    if ilrows == nil do return
    if !com_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

ilrows_ilrow_remove :: proc(ilrows: ILRows, index: i32) -> (ok: bool) {
    if ilrows == nil do return
    if !com_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

ilrows_release :: proc(ilrows: ILRows) {
    if ilrows != nil {
        (^ILRowsIF)(ilrows)->Release()
    }
}

ilrows_from_com :: proc(rows: ILRows, allocator := context.allocator) -> (result: [dynamic]t.ILRow, ok: bool) {
    if rows == nil do return
    context.allocator = allocator

    count: i32
    count, ok = ilrow_count(rows)
    if !ok do return

    result = make([dynamic]t.ILRow, 0, int(count), allocator)
    for i in 0..<count {
        r: ILRow
        r, ok = ilrow_by_index(rows, i)
        if !ok do return
        defer release(r)

        rs: t.ILRow
        rs, ok = ilrow_from_com(r)
        if !ok do return
        append(&result, rs)
    }
    return result, true
}

ilrows_to_com :: proc(rows: ILRows, src: []t.ILRow) -> (ok: bool) {
    if rows == nil do return
    for item in src {
        r: ILRow
        r, ok = ilrow_to_com(item)
        if !ok do return
        defer release(r)
        ok = ilrow_add(rows, r)
        if !ok do return
    }
    return true
}
