package cbopenif

ILRow :: distinct rawptr

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

ilrow_new :: proc {
    ilrow_new_,
    ilrow_new_comment
}

ilrow_new_ :: proc(name, instruction, operand, description: string) -> (ilrow: ILRow, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_instruction := to_bstr(instruction)
    bstr_operand := to_bstr(operand)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_instruction)
        bstr_free(bstr_operand)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewILRow(bstr_name, bstr_instruction, bstr_operand, bstr_description, cast(^rawptr)&ilrow)
    if com_failed(hr) do return

    return ilrow, true
}

ilrow_new_comment :: proc(comment: string) -> (ilrow: ILRow, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_comment := to_bstr(comment)
    bstr_free(bstr_comment)
    hr := factoryif->NewILComment(bstr_comment, cast(^rawptr)&ilrow)
    if com_failed(hr) do return

    return ilrow, true
}

ilrow_label :: proc {
    ilrow_label_get,
    ilrow_label_set,
}

ilrow_label_get :: proc(ilrow: ILRow) -> (label: string, ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->LabelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_label_set :: proc(ilrow: ILRow, label: string) -> (ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(label)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->LabelPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_instruction :: proc {
    ilrow_instruction_get,
    ilrow_instruction_set,
}

ilrow_instruction_get :: proc(ilrow: ILRow) -> (instruction: string, ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_instruction_set :: proc(ilrow: ILRow, instruction: string) -> (ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(instruction)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_operand :: proc {
    ilrow_operand_get,
    ilrow_operand_set,
}

ilrow_operand_get :: proc(ilrow: ILRow) -> (operand: string, ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_operand_set :: proc(ilrow: ILRow, operand: string) -> (ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(operand)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->InstructionPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_description :: proc {
    ilrow_description_get,
    ilrow_description_set,
}

ilrow_description_get :: proc(ilrow: ILRow) -> (description: string, ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_description_set :: proc(ilrow: ILRow, description: string) -> (ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_comment :: proc {
    ilrow_row_comment_get,
    ilrow_row_comment_set,
}

ilrow_row_comment_get :: proc(ilrow: ILRow) -> (row_comment: string, ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ilrow_row_comment_set :: proc(ilrow: ILRow, row_comment: string) -> (ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(row_comment)
    defer bstr_free(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentPut(bs)
    if com_failed(hr) do return
    
    return true
}

ilrow_is_comment :: proc {
    ilrow_is_row_comment_get,
    ilrow_is_row_comment_set,
}

ilrow_is_row_comment_get :: proc(ilrow: ILRow) -> (is_row_comment: bool, ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ILRowIF)(ilrow)->IsRowCommentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

ilrow_is_row_comment_set :: proc(ilrow: ILRow, is_row_comment: bool) -> (ok: bool) {
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ILRowIF)(ilrow)->IsRowCommentPut(to_variantbool(is_row_comment))
    if com_failed(hr) do return

    return true
}

ilrow_release :: proc(ilrow: ILRow) {
    if ilrow != nil {
        (^ILRowIF)(ilrow)->Release()
    }
}
