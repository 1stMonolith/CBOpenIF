package project

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

ProjectConstants :: distinct rawptr

ProjectConstantsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ProjectConstantsVTable,
}

ProjectConstantsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

projectconstants_new :: proc() -> (projectconstants: ProjectConstants, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    hr := factory.factoryif->NewProjectConstants(cast(^rawptr)&projectconstants)
    if com.failed(hr) do return

    return projectconstants, true
}

projectconstants_deserialize :: proc(projectconstants: ^ProjectConstants, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeProjectConstants(&bs, cast(^rawptr)projectconstants)
    if com.failed(hr) do return

    return true
}

projectconstants_serialize :: proc(projectconstants: ProjectConstants) -> (xml: string, ok: bool) {
    if projectconstants == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ProjectConstantsIF)(projectconstants)->Serialize(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

projectconstants_add :: proc {
    projectconstants_add_,
    projectconstants_add_at_index,
}

projectconstants_add_ :: proc(projectconstants: ProjectConstants, projectconstant: ProjectConstant) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return
    if projectconstant == nil do return

    hr := (^ProjectConstantsIF)(projectconstants)->Add(projectconstant)
    if com.failed(hr) do return

    return true
}

projectconstants_add_at_index :: proc(projectconstants: ProjectConstants, projectconstant: ProjectConstant, index: i32) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return
    if projectconstant == nil do return

    hr := (^ProjectConstantsIF)(projectconstants)->AddBefore(projectconstant, index)
    if com.failed(hr) do return

    return true
}

projectconstants_constant :: proc {
    projectconstants_constant_by_name,
    projectconstants_constant_by_index,
}

projectconstants_constant_by_name :: proc(projectconstants: ProjectConstants, name: string) -> (projectconstant: ProjectConstant, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return

    bstr_name := com.from_string(name)
    defer com.bstr_free(bstr_name)
    hr := (^ProjectConstantsIF)(projectconstants)->Find(bstr_name, cast(^rawptr)&projectconstant)
    if com.failed(hr) do return

    return projectconstant, true
}

projectconstants_constant_by_index :: proc(projectconstants: ProjectConstants, index: i32) -> (projectconstant: ProjectConstant, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return

    hr := (^ProjectConstantsIF)(projectconstants)->Item(index, cast(^rawptr)&projectconstant)
    if com.failed(hr) do return

    return projectconstant, true
}

projectconstants_constant_index :: proc(projectconstants: ProjectConstants, name: string) -> (index: i32, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return

    bstr_name := com.from_string(name)
    defer com.bstr_free(bstr_name)
    hr := (^ProjectConstantsIF)(projectconstants)->FindNr(bstr_name, &index)
    if com.failed(hr) do return

    return index, true
}

projectconstants_count :: proc(projectconstants: ProjectConstants) -> (count: i32, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return

    hr := (^ProjectConstantsIF)(projectconstants)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

projectconstants_remove :: proc {
    projectconstants_remove_by_name,
    projectconstants_remove_by_index,
}

projectconstants_remove_by_name :: proc(projectconstants: ProjectConstants, name: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return

    index, found := projectconstants_constant_index(projectconstants, name)
    if !found do return

    hr := (^ProjectConstantsIF)(projectconstants)->Remove(index)
    if com.failed(hr) do return

    return true
}

projectconstants_remove_by_index :: proc(projectconstants: ProjectConstants, index: i32) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return
    if projectconstants == nil do return

    hr := (^ProjectConstantsIF)(projectconstants)->Remove(index)
    if com.failed(hr) do return

    return true
}

projectconstants_release :: proc(projectconstants: ProjectConstants) {
    if projectconstants != nil {
        (^ProjectConstantsIF)(projectconstants)->Release()
    }
}
