package com

ILRows :: distinct rawptr
ILRow  :: distinct rawptr

ILRowsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILRowsVTable,
}

ILRowsVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:        proc "system" (this: ^ILRowsIF, ILRow: rawptr) -> HResult,
    AddBefore:  proc "system" (this: ^ILRowsIF, ILRow: rawptr, Index: i32) -> HResult,
    AddRow:     proc "system" (this: ^ILRowsIF, Label, Instruction, Operand, Description: BStr, ILRow: ^rawptr) -> HResult,
    AddComment: proc "system" (this: ^ILRowsIF, Comment: BStr, ILRow: ^rawptr) -> HResult,
    Item:       proc "system" (this: ^ILRowsIF, Index: i32, ILRow: ^rawptr) -> HResult,
    Count:      proc "system" (this: ^ILRowsIF, Count: ^i32) -> HResult,
    Remove:     proc "system" (this: ^ILRowsIF, Index: i32) -> HResult,
}

AddILRow :: proc {
    _AddILRow,
    _AddILRowAtIndex,
}

_AddILRow :: proc(ilrows: ILRows, ilrow: ILRow) -> (ok: bool)
{
    if ilrows == nil do return
    if ilrow == nil do return
    if !ComConnected() do return

    hr := (^ILRowsIF)(ilrows)->Add(ilrow)
    if ComFailed(hr) do return

    return true
}

_AddILRowAtIndex :: proc(ilrows: ILRows, ilrow: ILRow, index: i32) -> (ok: bool)
{
    if ilrows == nil do return
    if ilrow == nil do return
    if !ComConnected() do return
    
    hr := (^ILRowsIF)(ilrows)->AddBefore(ilrow, index)
    if ComFailed(hr) do return

    return true
}

GetILRow :: proc(ilrows: ILRows, index: i32) -> (ilrow: ILRow, ok: bool)
{
    if ilrows == nil do return
    if !ComConnected() do return
    
    hr := (^ILRowsIF)(ilrows)->Item(index + 1, cast(^rawptr)&ilrow)
    if ComFailed(hr) do return
    
    return ilrow, true
}

ILRowCount :: proc(ilrows: ILRows) -> (count: i32, ok: bool)
{
    if ilrows == nil do return
    if !ComConnected() do return
    
    hr := (^ILRowsIF)(ilrows)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveILRow :: proc(ilrows: ILRows, index: i32) -> (ok: bool)
{
    if ilrows == nil do return
    if !ComConnected() do return
    
    hr := (^ILRowsIF)(ilrows)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseILRows :: proc(ilrows: ILRows)
{
    if ilrows != nil {
        (^ILRowsIF)(ilrows)->Release()
    }
}

ILRowIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ILRowVTable,
}

ILRowVTable :: struct
{
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

GetILRowLabel :: proc(ilrow: ILRow) -> (label: string, ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->LabelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetILRowLabel :: proc(ilrow: ILRow, label: string) -> (ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(label)
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->LabelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetILRowInstruction :: proc(ilrow: ILRow) -> (instruction: string, ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->InstructionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetILRowInstruction :: proc(ilrow: ILRow, instruction: string) -> (ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(instruction)
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->InstructionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetILRowOperand :: proc(ilrow: ILRow) -> (operand: string, ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->InstructionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetILRowOperand :: proc(ilrow: ILRow, operand: string) -> (ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(operand)
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->InstructionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetILRowDescription :: proc(ilrow: ILRow) -> (description: string, ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetILRowDescription :: proc(ilrow: ILRow, description: string) -> (ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetILRowComment :: proc(ilrow: ILRow) -> (row_comment: string, ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetILRowComment :: proc(ilrow: ILRow, row_comment: string) -> (ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(row_comment)
    defer FreeBstr(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetILRowIsComment :: proc(ilrow: ILRow) -> (is_row_comment: bool, ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ILRowIF)(ilrow)->IsRowCommentGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetILRowIsComment :: proc(ilrow: ILRow, is_row_comment: bool) -> (ok: bool)
{
    if ilrow == nil do return
    if !ComConnected() do return
    
    hr := (^ILRowIF)(ilrow)->IsRowCommentPut(ToVariantBool(is_row_comment))
    if ComFailed(hr) do return

    return true
}

ReleaseILRow :: proc(ilrow: ILRow)
{
    if ilrow != nil {
        (^ILRowIF)(ilrow)->Release()
    }
}
