package cbopenif

ILRows :: distinct rawptr

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

ilrows_ilrow_add :: proc {
    ilrows_ilrow_add_,
    ilrows_ilrow_add_at_index,
}

ilrows_ilrow_add_ :: proc(ilrows: ILRows, ilrow: ILRow) -> (ok: bool) {
    if ilrows == nil do return
    if ilrow == nil do return
    if !controlbuilder_connected() do return

    hr := (^ILRowsIF)(ilrows)->Add(ilrow)
    if com_failed(hr) do return

    return true
}

ilrows_ilrow_add_at_index :: proc(ilrows: ILRows, ilrow: ILRow, index: i32) -> (ok: bool) {
    if ilrows == nil do return
    if ilrow == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->AddBefore(ilrow, index)
    if com_failed(hr) do return

    return true
}

ilrows_ilrow_by_index :: proc(ilrows: ILRows, index: i32) -> (ilrow: ILRow, ok: bool) {
    if ilrows == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->Item(index, cast(^rawptr)&ilrow)
    if com_failed(hr) do return
    
    return ilrow, true
}

ilrows_ilrow_count :: proc(ilrows: ILRows) -> (count: i32, ok: bool) {
    if ilrows == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

ilrows_ilrow_remove :: proc(ilrows: ILRows, index: i32) -> (ok: bool) {
    if ilrows == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ILRowsIF)(ilrows)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

ilrows_release :: proc(ilrows: ILRows) {
    if ilrows != nil {
        (^ILRowsIF)(ilrows)->Release()
    }
}
