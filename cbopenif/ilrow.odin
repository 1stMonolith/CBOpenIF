package cbopenif

ILRow :: distinct rawptr

ILRowIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^ILRowVTable,
}

ILRowVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
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
    ilrow = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_instruction := string_to_bstr(instruction)
    bstr_operand := string_to_bstr(operand)
    bstr_description := string_to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_instruction)
        bstr_free(bstr_operand)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewILRow(bstr_name, bstr_instruction, bstr_operand, bstr_description, cast(^ILRow)&ilrow)
    if failed(hr) do return

    return ilrow, true
}

ilrow_new_comment :: proc(comment: string) -> (ilrow: ILRow, ok: bool) {
    ilrow = nil
    ok = false

    if !connected() do return

    bstr_comment := string_to_bstr(comment)
    bstr_free(bstr_comment)
    hr := factoryif->NewILComment(bstr_comment, cast(^ILRow)&ilrow)
    if failed(hr) do return

    return ilrow, true
}

ilrow_name :: proc {
    ilrow_name_,
    ilrow_name_set,
}

@(private)
ilrow_name_ :: proc(ilrow: ILRow) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ILRowIF)(ilrow)->LabelGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
ilrow_name_set :: proc(ilrow: ILRow, name: string) -> (ok: bool) {
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ILRowIF)(ilrow)->LabelPut(bstr)
    if failed(hr) do return
    
    return true
}

ilrow_description :: proc {
    ilrow_description_,
    ilrow_description_set,
}

@(private)
ilrow_description_ :: proc(ilrow: ILRow) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ILRowIF)(ilrow)->DescriptionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
ilrow_description_set :: proc(ilrow: ILRow, description: string) -> (ok: bool) {
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^ILRowIF)(ilrow)->DescriptionPut(bstr)
    if failed(hr) do return
    
    return true
}

ilrow_row_comment :: proc {
    ilrow_row_comment_,
    ilrow_row_comment_set,
}

@(private)
ilrow_row_comment_ :: proc(ilrow: ILRow) -> (row_comment: string, ok: bool) {
    row_comment = ""
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ILRowIF)(ilrow)->RowCommentGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
ilrow_row_comment_set :: proc(ilrow: ILRow, row_comment: string) -> (ok: bool) {
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(row_comment)
    defer bstr_free(bstr)
    hr := (^ILRowIF)(ilrow)->RowCommentPut(bstr)
    if failed(hr) do return
    
    return true
}

ilrow_is_row_comment :: proc {
    ilrow_is_row_comment_,
    ilrow_is_row_comment_set,
}

ilrow_is_row_comment_ :: proc(ilrow: ILRow) -> (is_row_comment: bool, ok: bool) {
    is_row_comment = false
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    vb: VariantBool
    hr := (^ILRowIF)(ilrow)->IsRowCommentGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

ilrow_is_row_comment_set :: proc(ilrow: ILRow, is_row_comment: bool) -> (ok: bool) {
    ok = false

    if ilrow == nil do return
    if !connected() do return
    
    vb := bool_to_variantbool(is_row_comment)
    hr := (^ILRowIF)(ilrow)->IsRowCommentPut(vb)
    if failed(hr) do return

    return true
}

ilrow_release :: proc(ilrow: ILRow) {
    if ilrow != nil {
        (^ILRowIF)(ilrow)->Release()
    }
}
