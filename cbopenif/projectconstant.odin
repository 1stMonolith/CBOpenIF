package cbopenif

ProjectConstant :: distinct rawptr

ProjectConstantIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ProjectConstantVTable,
}

ProjectConstantVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^ProjectConstantIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^ProjectConstantIF, Name: BStr) -> HResult,
    PCTypeGet: proc "system" (this: ^ProjectConstantIF, PCType: ^BStr) -> HResult,
    PCTypePut: proc "system" (this: ^ProjectConstantIF, PCType: BStr) -> HResult,
    ValueGet:  proc "system" (this: ^ProjectConstantIF, Value: ^BStr) -> HResult,
    ValuePut:  proc "system" (this: ^ProjectConstantIF, Value: BStr) -> HResult,
}

projectconstant_new :: proc(name, projectconstant_type, value: string) -> (projectconstant: ProjectConstant, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name  := to_bstr(name)
    bstr_type  := to_bstr(projectconstant_type)
    bstr_value := to_bstr(value)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_value)
    }

    hr := factoryif->NewProjectConstant(bstr_name, bstr_type, bstr_value, cast(^rawptr)&projectconstant)
    if com_failed(hr) do return

    return projectconstant, true
}

projectconstant_name :: proc {
    projectconstant_name_get,
    projectconstant_name_set,
}

projectconstant_name_get :: proc(projectconstant: ProjectConstant) -> (name: string, ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstant_name_set :: proc(projectconstant: ProjectConstant, name: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

projectconstant_type :: proc {
    projectconstant_type_get,
    projectconstant_type_set,
}

projectconstant_type_get :: proc(projectconstant: ProjectConstant) -> (projectconstant_type: string, ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstant_type_set :: proc(projectconstant: ProjectConstant, projectconstant_type: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(projectconstant_type)
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypePut(bs)
    if com_failed(hr) do return

    return true
}

projectconstant_value :: proc {
    projectconstant_value_get,
    projectconstant_value_set,
}

projectconstant_value_get :: proc(projectconstant: ProjectConstant) -> (value: string, ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstant_value_set :: proc(projectconstant: ProjectConstant, value: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(value)
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValuePut(bs)
    if com_failed(hr) do return

    return true
}

projectconstant_release :: proc(projectconstant: ProjectConstant) {
    if projectconstant != nil {
        (^ProjectConstantIF)(projectconstant)->Release()
    }
}
