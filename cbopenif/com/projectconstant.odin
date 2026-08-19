package com

ProjectConstant  :: distinct rawptr
ProjectConstants :: distinct rawptr

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

projectconstant_name_get :: proc(projectconstant: ProjectConstant) -> (name: string, ok: bool) {
    if projectconstant == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstant_name_set :: proc(projectconstant: ProjectConstant, name: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

projectconstant_type_get :: proc(projectconstant: ProjectConstant) -> (projectconstant_type: string, ok: bool) {
    if projectconstant == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstant_type_set :: proc(projectconstant: ProjectConstant, projectconstant_type: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !com_connected() do return

    bs := to_bstr(projectconstant_type)
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypePut(bs)
    if com_failed(hr) do return

    return true
}

projectconstant_value_get :: proc(projectconstant: ProjectConstant) -> (value: string, ok: bool) {
    if projectconstant == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstant_value_set :: proc(projectconstant: ProjectConstant, value: string) -> (ok: bool) {
    if projectconstant == nil do return
    if !com_connected() do return

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

ProjectConstantsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ProjectConstantsVTable,
}

ProjectConstantsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ProjectConstantsIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ProjectConstantsIF, ProjectConstant: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ProjectConstantsIF, ProjectConstant: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ProjectConstantsIF, Name, PCType, Value: BStr, ProjectConstant: ^rawptr) -> HResult,
    Item:      proc "system" (this: ^ProjectConstantsIF, Index: i32, ProjectConstant: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ProjectConstantsIF, Name: BStr, ProjectConstant: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ProjectConstantsIF, Name: BStr, Index: ^i32) -> HResult,
    Count:     proc "system" (this: ^ProjectConstantsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ProjectConstantsIF, Index: i32) -> HResult,
}

projectconstants_serialize :: proc(projectconstants: ProjectConstants) -> (xml: string, ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProjectConstantsIF)(projectconstants)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

projectconstants_projectconstant_add :: proc(projectconstants: ProjectConstants, projectconstant: ProjectConstant) -> (ok: bool) {
    if projectconstants == nil do return
    if projectconstant == nil do return
    if !com_connected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Add(projectconstant)
    if com_failed(hr) do return

    return true
}

projectconstants_projectconstant_add_at_index :: proc(projectconstants: ProjectConstants, projectconstant: ProjectConstant, index: i32) -> (ok: bool) {
    if projectconstants == nil do return
    if projectconstant == nil do return
    if !com_connected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->AddBefore(projectconstant, index)
    if com_failed(hr) do return

    return true
}

projectconstants_projectconstant_by_name :: proc(projectconstants: ProjectConstants, name: string) -> (projectconstant: ProjectConstant, ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ProjectConstantsIF)(projectconstants)->Find(bstr_name, cast(^rawptr)&projectconstant)
    if com_failed(hr) do return

    return projectconstant, true
}

projectconstants_projectconstant_by_index :: proc(projectconstants: ProjectConstants, index: i32) -> (projectconstant: ProjectConstant, ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Item(index + 1, cast(^rawptr)&projectconstant)
    if com_failed(hr) do return

    return projectconstant, true
}

projectconstants_projectconstant_index :: proc(projectconstants: ProjectConstants, name: string) -> (index: i32, ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ProjectConstantsIF)(projectconstants)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

projectconstants_projectconstant_count :: proc(projectconstants: ProjectConstants) -> (count: i32, ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

projectconstants_projectconstant_remove_by_name :: proc(projectconstants: ProjectConstants, name: string) -> (ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    index, found := projectconstants_projectconstant_index(projectconstants, name)
    if !found do return

    hr := (^ProjectConstantsIF)(projectconstants)->Remove(index)
    if com_failed(hr) do return

    return true
}

projectconstants_projectconstant_remove_by_index :: proc(projectconstants: ProjectConstants, index: i32) -> (ok: bool) {
    if projectconstants == nil do return
    if !com_connected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

projectconstants_release :: proc(projectconstants: ProjectConstants) {
    if projectconstants != nil {
        (^ProjectConstantsIF)(projectconstants)->Release()
    }
}
