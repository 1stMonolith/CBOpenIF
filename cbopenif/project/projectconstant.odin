package project

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

ProjectConstant :: distinct rawptr

ProjectConstantIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ProjectConstantVTable,
}

ProjectConstantVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:   proc "system" (this: ^ProjectConstantIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^ProjectConstantIF, Name: BStr) -> HResult,
    PCTypeGet: proc "system" (this: ^ProjectConstantIF, PCType: ^BStr) -> HResult,
    PCTypePut: proc "system" (this: ^ProjectConstantIF, PCType: BStr) -> HResult,
    ValueGet:  proc "system" (this: ^ProjectConstantIF, Value: ^BStr) -> HResult,
    ValuePut:  proc "system" (this: ^ProjectConstantIF, Value: BStr) -> HResult,
}

projectconstant_new :: proc(name, projectconstant_type, value: string) -> (projectconstant: ProjectConstant, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bstr_name  := com.from_string(name)
    bstr_type  := com.from_string(projectconstant_type)
    bstr_value := com.from_string(value)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_type)
        com.bstr_free(bstr_value)
    }

    hr := factory.factoryif->NewProjectConstant(bstr_name, bstr_type, bstr_value, cast(^rawptr)&projectconstant)
    if com.failed(hr) do return

    return projectconstant, true
}

projectconstant_name :: proc {
    projectconstant_name_get,
    projectconstant_name_set,
}

projectconstant_name_get :: proc(projectconstant: ProjectConstant) -> (name: string, ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

projectconstant_name_set :: proc(projectconstant: ProjectConstant, name: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

projectconstant_type :: proc {
    projectconstant_type_get,
    projectconstant_type_set,
}

projectconstant_type_get :: proc(projectconstant: ProjectConstant) -> (projectconstant_type: string, ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypeGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

projectconstant_type_set :: proc(projectconstant: ProjectConstant, projectconstant_type: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(projectconstant_type)
    defer com.bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypePut(bs)
    if com.failed(hr) do return

    return true
}

projectconstant_value :: proc {
    projectconstant_value_get,
    projectconstant_value_set,
}

projectconstant_value_get :: proc(projectconstant: ProjectConstant) -> (value: string, ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValueGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

projectconstant_value_set :: proc(projectconstant: ProjectConstant, value: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(value)
    defer com.bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValuePut(bs)
    if com.failed(hr) do return

    return true
}

projectconstant_release :: proc(projectconstant: ProjectConstant) {
    if projectconstant != nil {
        (^ProjectConstantIF)(projectconstant)->Release()
    }
}
