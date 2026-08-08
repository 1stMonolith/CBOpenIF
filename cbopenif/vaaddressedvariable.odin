package cbopenif

VAAddressedVariable :: distinct rawptr

VAAddressedVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAAddressedVariableVTable,
}

VAAddressedVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:       proc "system" (this: ^VAAddressedVariableIF, Name: ^BStr) -> HResult,
    NamePut:       proc "system" (this: ^VAAddressedVariableIF, Name: BStr) -> HResult,
    PathGet:       proc "system" (this: ^VAAddressedVariableIF, Path: ^BStr) -> HResult,
    PathPut:       proc "system" (this: ^VAAddressedVariableIF, Path: BStr) -> HResult,
    VATypeGet:     proc "system" (this: ^VAAddressedVariableIF, VAType: ^BStr) -> HResult,
    VATypePut:     proc "system" (this: ^VAAddressedVariableIF, VAType: BStr) -> HResult,
    RowGet:        proc "system" (this: ^VAAddressedVariableIF, Row: ^i32) -> HResult,
    RowPut:        proc "system" (this: ^VAAddressedVariableIF, Row: i32) -> HResult,
    VATypePathGet: proc "system" (this: ^VAAddressedVariableIF, VATypePath: ^BStr) -> HResult,
}

vaaddressedvariable_new :: proc {
    vaaddressedvariable_new_,
    vaaddressedvariable_new1,
}

vaaddressedvariable_new_ :: proc(name, path: string) -> (vaav: VAAddressedVariable, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_path := to_bstr(path)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
    }
    hr := factoryif->NewVAAddressedVariable(bstr_name, bstr_path, cast(^rawptr)&vaav)
    if com_failed(hr) do return

    return vaav, true
}

vaaddressedvariable_new1 :: proc(name, path: string, row: i32) -> (vaav: VAAddressedVariable, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_path := to_bstr(path)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
    }
    hr := factoryif->NewVAAddressedVariable1(bstr_name, bstr_path, row, cast(^rawptr)&vaav)
    if com_failed(hr) do return

    return vaav, true
}

vaaddressedvariable_name :: proc {
    vaaddressedvariable_name_get,
    vaaddressedvariable_name_set,
}

vaaddressedvariable_name_get :: proc(vaav: VAAddressedVariable) -> (name: string, ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_name_set :: proc(vaav: VAAddressedVariable, name: string) -> (ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_path :: proc {
    vaaddressedvariable_path_get,
    vaaddressedvariable_path_set,
}

vaaddressedvariable_path_get :: proc(vaav: VAAddressedVariable) -> (path: string, ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->PathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_path_set :: proc(vaav: VAAddressedVariable, path: string) -> (ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->PathPut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_va_type :: proc {
    vaaddressedvariable_va_type_get,
    vaaddressedvariable_va_type_set,
}

vaaddressedvariable_va_type_get :: proc(vaav: VAAddressedVariable) -> (va_type: string, ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_va_type_set :: proc(vaav: VAAddressedVariable, va_type: string) -> (ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(va_type)
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypePut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_row :: proc {
    vaaddressedvariable_row_get,
    vaaddressedvariable_row_set,
}

vaaddressedvariable_row_get :: proc(vaav: VAAddressedVariable) -> (row: i32, ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedVariableIF)(vaav)->RowGet(&row)
    if com_failed(hr) do return

    return row, true
}

vaaddressedvariable_row_set :: proc(vaav: VAAddressedVariable, row: i32) -> (ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedVariableIF)(vaav)->RowPut(row)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_va_type_path_get :: proc(vaav: VAAddressedVariable) -> (va_type_path: string, ok: bool) {
    if vaav == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypePathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_release :: proc(vaav: VAAddressedVariable) {
    if vaav != nil {
        (^VAAddressedVariableIF)(vaav)->Release()
    }
}
