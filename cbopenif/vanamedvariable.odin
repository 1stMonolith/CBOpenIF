package cbopenif

VANamedVariable :: distinct rawptr

VANamedVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VANamedVariableVTable,
}

VANamedVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:        proc "system" (this: ^VANamedVariableIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^VANamedVariableIF, Name: BStr) -> HResult,
    PathGet:        proc "system" (this: ^VANamedVariableIF, Path: ^BStr) -> HResult,
    PathPut:        proc "system" (this: ^VANamedVariableIF, Path: BStr) -> HResult,
    VAAttributeGet: proc "system" (this: ^VANamedVariableIF, VAAttribute: ^BStr) -> HResult,
    VAAttributePut: proc "system" (this: ^VANamedVariableIF, VAAttribute: BStr) -> HResult,
    VATypeGet:      proc "system" (this: ^VANamedVariableIF, VAType: ^BStr) -> HResult,
    VATypePut:      proc "system" (this: ^VANamedVariableIF, VAType: BStr) -> HResult,
    RowGet:         proc "system" (this: ^VANamedVariableIF, Row: ^i32) -> HResult,
    RowPut:         proc "system" (this: ^VANamedVariableIF, Row: i32) -> HResult,
    VATypePathGet:  proc "system" (this: ^VANamedVariableIF, VATypePath: ^BStr) -> HResult,
}

vanamedvariable_new :: proc {
    vanamedvariable_new_,
    vanamedvariable_new1,
}

vanamedvariable_new_ :: proc(name, path: string) -> (vanv: VANamedVariable, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_path := to_bstr(path)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
    }
    hr := factoryif->NewVANamedVariable(bstr_name, bstr_path, cast(^rawptr)&vanv)
    if com_failed(hr) do return

    return vanv, true
}

vanamedvariable_new1 :: proc(name, path, va_attribute: string, row: i32) -> (vanv: VANamedVariable, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name        := to_bstr(name)
    bstr_path        := to_bstr(path)
    bstr_va_attribute := to_bstr(va_attribute)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
        bstr_free(bstr_va_attribute)
    }
    hr := factoryif->NewVANamedVariable1(bstr_name, bstr_path, bstr_va_attribute, row, cast(^rawptr)&vanv)
    if com_failed(hr) do return

    return vanv, true
}

vanamedvariable_name :: proc {
    vanamedvariable_name_get,
    vanamedvariable_name_set,
}

vanamedvariable_name_get :: proc(vanv: VANamedVariable) -> (name: string, ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_name_set :: proc(vanv: VANamedVariable, name: string) -> (ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_path :: proc {
    vanamedvariable_path_get,
    vanamedvariable_path_set,
}

vanamedvariable_path_get :: proc(vanv: VANamedVariable) -> (path: string, ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->PathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_path_set :: proc(vanv: VANamedVariable, path: string) -> (ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->PathPut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_va_attribute :: proc {
    vanamedvariable_va_attribute_get,
    vanamedvariable_va_attribute_set,
}

vanamedvariable_va_attribute_get :: proc(vanv: VANamedVariable) -> (va_attribute: string, ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VAAttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_va_attribute_set :: proc(vanv: VANamedVariable, va_attribute: string) -> (ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(va_attribute)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VAAttributePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_va_type :: proc {
    vanamedvariable_va_type_get,
    vanamedvariable_va_type_set,
}

vanamedvariable_va_type_get :: proc(vanv: VANamedVariable) -> (va_type: string, ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_va_type_set :: proc(vanv: VANamedVariable, va_type: string) -> (ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(va_type)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_row :: proc {
    vanamedvariable_row_get,
    vanamedvariable_row_set,
}

vanamedvariable_row_get :: proc(vanv: VANamedVariable) -> (row: i32, ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedVariableIF)(vanv)->RowGet(&row)
    if com_failed(hr) do return

    return row, true
}

vanamedvariable_row_set :: proc(vanv: VANamedVariable, row: i32) -> (ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedVariableIF)(vanv)->RowPut(row)
    if com_failed(hr) do return

    return true
}

vanamedvariable_va_type_path_get :: proc(vanv: VANamedVariable) -> (va_type_path: string, ok: bool) {
    if vanv == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypePathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_release :: proc(vanv: VANamedVariable) {
    if vanv != nil {
        (^VANamedVariableIF)(vanv)->Release()
    }
}
