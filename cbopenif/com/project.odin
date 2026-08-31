package com

ProjectConstants :: distinct rawptr
ProjectConstant  :: distinct rawptr

ProjectConstantsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ProjectConstantsVTable,
}

ProjectConstantsVTable :: struct
{
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

SerializeProjectConstants :: proc(projectconstants: ProjectConstants) -> (xml: string, ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProjectConstantsIF)(projectconstants)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

_AddProjectConstant :: proc(projectconstants: ProjectConstants, projectconstant: ProjectConstant) -> (ok: bool)
{
    if projectconstants == nil do return
    if projectconstant == nil do return
    if !ComConnected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Add(projectconstant)
    if ComFailed(hr) do return

    return true
}

_AddProjectConstantAtIndex :: proc(projectconstants: ProjectConstants, projectconstant: ProjectConstant, index: i32) -> (ok: bool)
{
    if projectconstants == nil do return
    if projectconstant == nil do return
    if !ComConnected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->AddBefore(projectconstant, index)
    if ComFailed(hr) do return

    return true
}

GetProjectConstantWithName :: proc(projectconstants: ProjectConstants, name: string) -> (projectconstant: ProjectConstant, ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ProjectConstantsIF)(projectconstants)->Find(bstr_name, cast(^rawptr)&projectconstant)
    if ComFailed(hr) do return

    return projectconstant, true
}

GetProjectConstantAtIndex :: proc(projectconstants: ProjectConstants, index: i32) -> (projectconstant: ProjectConstant, ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Item(index + 1, cast(^rawptr)&projectconstant)
    if ComFailed(hr) do return

    return projectconstant, true
}

ProjectConstantIndex :: proc(projectconstants: ProjectConstants, name: string) -> (index: i32, ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ProjectConstantsIF)(projectconstants)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ProjectConstantCount :: proc(projectconstants: ProjectConstants) -> (count: i32, ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveProjectConstant :: proc {
    _RemoveProjectConstantWithName,
    _RemoveProjectConstantAtIndex,
}

_RemoveProjectConstantWithName :: proc(projectconstants: ProjectConstants, name: string) -> (ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    index, found := ProjectConstantIndex(projectconstants, name)
    if !found do return

    hr := (^ProjectConstantsIF)(projectconstants)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveProjectConstantAtIndex :: proc(projectconstants: ProjectConstants, index: i32) -> (ok: bool)
{
    if projectconstants == nil do return
    if !ComConnected() do return

    hr := (^ProjectConstantsIF)(projectconstants)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseProjectConstants :: proc(projectconstants: ProjectConstants)
{
    if projectconstants != nil {
        (^ProjectConstantsIF)(projectconstants)->Release()
    }
}

ProjectConstantIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ProjectConstantVTable,
}

ProjectConstantVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^ProjectConstantIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^ProjectConstantIF, Name: BStr) -> HResult,
    PCTypeGet: proc "system" (this: ^ProjectConstantIF, PCType: ^BStr) -> HResult,
    PCTypePut: proc "system" (this: ^ProjectConstantIF, PCType: BStr) -> HResult,
    ValueGet:  proc "system" (this: ^ProjectConstantIF, Value: ^BStr) -> HResult,
    ValuePut:  proc "system" (this: ^ProjectConstantIF, Value: BStr) -> HResult,
}

GetProjectConstantName :: proc(projectconstant: ProjectConstant) -> (name: string, ok: bool)
{
    if projectconstant == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProjectConstantName :: proc(projectconstant: ProjectConstant, name: string) -> (ok: bool)
{
    if projectconstant == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ProjectConstantIF)(projectconstant)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetProjectConstantType :: proc(projectconstant: ProjectConstant) -> (projectconstant_type: string, ok: bool)
{
    if projectconstant == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProjectConstantType :: proc(projectconstant: ProjectConstant, projectconstant_type: string) -> (ok: bool)
{
    if projectconstant == nil do return
    if !ComConnected() do return

    bs := ToBstr(projectconstant_type)
    defer FreeBstr(bs)
    hr := (^ProjectConstantIF)(projectconstant)->PCTypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetProjectConstantValue :: proc(projectconstant: ProjectConstant) -> (value: string, ok: bool)
{
    if projectconstant == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValueGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProjectConstantValue :: proc(projectconstant: ProjectConstant, value: string) -> (ok: bool)
{
    if projectconstant == nil do return
    if !ComConnected() do return

    bs := ToBstr(value)
    defer FreeBstr(bs)
    hr := (^ProjectConstantIF)(projectconstant)->ValuePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseProjectConstant :: proc(projectconstant: ProjectConstant)
{
    if projectconstant != nil {
        (^ProjectConstantIF)(projectconstant)->Release()
    }
}
