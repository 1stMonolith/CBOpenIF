package il

ILRows  :: distinct rawptr

ILRowsIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^ILRowsVTable,
}

ILRowsVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:        proc "system" (this: ^ILRowsIF, ILRow: ILRow) -> HResult,
    AddBefore:  proc "system" (this: ^ILRowsIF, ILRow: ILRow, Index: i32) -> HResult,
    AddRow:     proc "system" (this: ^ILRowsIF, Label, Instruction, Operand, Description: BStr, ILRow: ^ILRow) -> HResult,
    AddComment: proc "system" (this: ^ILRowsIF, Comment: BStr, ILRow: ^ILRow) -> HResult,
    Item:       proc "system" (this: ^ILRowsIF, Index: i32, ILRow: ^ILRow) -> HResult,
    Count:      proc "system" (this: ^ILRowsIF, Count: ^i32) -> HResult,
    Remove:     proc "system" (this: ^ILRowsIF, Index: i32) -> HResult,
}

ilrows_add :: proc {
    ilrows_add_,
    ilrows_add_at_index,
}

@(private)
ilrows_add_ :: proc(ilrows: ILRows, ilrow: ILRow) -> (ok: bool) {
    ok = false

    if !connected() do return
    if ilrows == nil do return
    if ilrow == nil do return

    hr := (^ILRowsIF)(ilrows)->Add(ilrow)
    if failed(hr) do return

    return true
}

ilrows_add_at_index :: proc(ilrows: ILRows, ilrow: ILRow, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if ilrows == nil do return
    if ilrow == nil do return
    
    hr := (^ILRowsIF)(ilrows)->AddBefore(ilrow, index)
    if failed(hr) do return

    return true
}

ilrows_ilrow :: proc {
    ilrows_ilrow_by_index,
}

ilrows_ilrow_by_index :: proc(ilrows: ILRows, index: i32) -> (ilrow: ILRow, ok: bool) {
    ilrow = nil
    ok = false

    if !connected() do return
    if ilrows == nil do return
    
    hr := (^ILRowsIF)(ilrows)->Item(index, &ilrow)
    if failed(hr) do return
    
    return ilrow, true
}

ilrows_count :: proc(ilrows: ILRows) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if ilrows == nil do return
    
    hr := (^ILRowsIF)(ilrows)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

ilrows_remove :: proc(ilrows: ILRows, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if ilrows == nil do return
    
    hr := (^ILRowsIF)(ilrows)->Remove(index)
    if failed(hr) do return
    
    return true
}

ilrows_release :: proc(ilrows: ILRows) {
    if ilrows != nil {
        (^ILRowsIF)(ilrows)->Release()
    }
}
