package il

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"
import "../variant"

@(private="file") BStr        :: bstr.BStr
@(private="file") HResult     :: com.HResult
@(private="file") VariantBool :: variant.VariantBool

ILRowIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ILRowVTable,
}

ILRowVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

ilrow_new_ :: proc(name, instruction, operand, description: string) -> (ilrow: rawptr, ok: bool) {

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr_instruction := bstr.from_string(instruction)
    bstr_operand := bstr.from_string(operand)
    bstr_description := bstr.from_string(description)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_instruction)
        bstr.free(bstr_operand)
        bstr.free(bstr_description)
    }
    hr := factory.factoryif->NewILRow(bstr_name, bstr_instruction, bstr_operand, bstr_description, cast(^rawptr)&ilrow)
    if com.failed(hr) do return

    return ilrow, true
}

ilrow_new_comment :: proc(comment: string) -> (ilrow: rawptr, ok: bool) {

    if !controlbuilder.connected() do return

    bstr_comment := bstr.from_string(comment)
    bstr.free(bstr_comment)
    hr := factory.factoryif->NewILComment(bstr_comment, cast(^rawptr)&ilrow)
    if com.failed(hr) do return

    return ilrow, true
}

ilrow_name :: proc {
    ilrow_name_get,
    ilrow_name_set,
}

ilrow_name_get :: proc(ilrow: rawptr) -> (name: string, ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ILRowIF)(ilrow)->LabelGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

ilrow_name_set :: proc(ilrow: rawptr, name: string) -> (ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ILRowIF)(ilrow)->LabelPut(bs)
    if com.failed(hr) do return
    
    return true
}

ilrow_description :: proc {
    ilrow_description_get,
    ilrow_description_set,
}

ilrow_description_get :: proc(ilrow: rawptr) -> (description: string, ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

ilrow_description_set :: proc(ilrow: rawptr, description: string) -> (ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^ILRowIF)(ilrow)->DescriptionPut(bs)
    if com.failed(hr) do return
    
    return true
}

ilrow_row_comment :: proc {
    ilrow_row_comment_get,
    ilrow_row_comment_set,
}

ilrow_row_comment_get :: proc(ilrow: rawptr) -> (row_comment: string, ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

ilrow_row_comment_set :: proc(ilrow: rawptr, row_comment: string) -> (ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(row_comment)
    defer bstr.free(bs)
    hr := (^ILRowIF)(ilrow)->RowCommentPut(bs)
    if com.failed(hr) do return
    
    return true
}

ilrow_is_row_comment :: proc {
    ilrow_is_row_comment_get,
    ilrow_is_row_comment_set,
}

ilrow_is_row_comment_get :: proc(ilrow: rawptr) -> (is_row_comment: bool, ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    vb: VariantBool
    hr := (^ILRowIF)(ilrow)->IsRowCommentGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

ilrow_is_row_comment_set :: proc(ilrow: rawptr, is_row_comment: bool) -> (ok: bool) {

    if ilrow == nil do return
    if !controlbuilder.connected() do return
    
    vb := variant.bool_to_variantbool(is_row_comment)
    hr := (^ILRowIF)(ilrow)->IsRowCommentPut(vb)
    if com.failed(hr) do return

    return true
}

ilrow_release :: proc(ilrow: rawptr) {
    if ilrow != nil {
        (^ILRowIF)(ilrow)->Release()
    }
}
