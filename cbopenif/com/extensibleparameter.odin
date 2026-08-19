package com

import t "../types"

ExtensibleParameter  :: distinct rawptr
ExtensibleParameters :: distinct rawptr

ExtensibleParameterIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParameterVTable,
}

ExtensibleParameterVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ExtensibleParameterIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ExtensibleParameterIF, Name: BStr) -> HResult,
    TypeNameGet:     proc "system" (this: ^ExtensibleParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:     proc "system" (this: ^ExtensibleParameterIF, TypeName: BStr) -> HResult,
    AttributeGet:    proc "system" (this: ^ExtensibleParameterIF, Attribute: ^BStr) -> HResult,
    AttributePut:    proc "system" (this: ^ExtensibleParameterIF, Attribute: BStr) -> HResult,
    DirectionGet:    proc "system" (this: ^ExtensibleParameterIF, Direction: ^i32) -> HResult,
    DirectionPut:    proc "system" (this: ^ExtensibleParameterIF, Direction: i32) -> HResult,
    InitialValueGet: proc "system" (this: ^ExtensibleParameterIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut: proc "system" (this: ^ExtensibleParameterIF, InitialValue: BStr) -> HResult,
    DescriptionGet:  proc "system" (this: ^ExtensibleParameterIF, Description: ^BStr) -> HResult,
    DescriptionPut:  proc "system" (this: ^ExtensibleParameterIF, Description: BStr) -> HResult,
    Serialize:       proc "system" (this: ^ExtensibleParameterIF, XML: ^BStr) -> HResult,
    AccessLevelGet:  proc "system" (this: ^ExtensibleParameterIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:  proc "system" (this: ^ExtensibleParameterIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:   proc "system" (this: ^ExtensibleParameterIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:   proc "system" (this: ^ExtensibleParameterIF, SafetyType: BStr) -> HResult,
    TypeGuid:        proc "system" (this: ^ExtensibleParameterIF, Guid: ^BStr) -> HResult,
    TypePath:        proc "system" (this: ^ExtensibleParameterIF, Path: ^BStr) -> HResult,
    FDPortGet:       proc "system" (this: ^ExtensibleParameterIF, FDPort: ^BStr) -> HResult,
    FDPortPut:       proc "system" (this: ^ExtensibleParameterIF, FDPort: BStr) -> HResult,
}

extensibleparameter_serialize :: proc(extensibleparameter: ExtensibleParameter) -> (xml: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_name_get :: proc(extensibleparameter: ExtensibleParameter) -> (name: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_name_set :: proc(extensibleparameter: ExtensibleParameter, name: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_type_name_get :: proc(extensibleparameter: ExtensibleParameter) -> (type_name: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_type_name_set :: proc(extensibleparameter: ExtensibleParameter, type_name: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNamePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_attribute_get :: proc(extensibleparameter: ExtensibleParameter) -> (attribute: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_attribute_set :: proc(extensibleparameter: ExtensibleParameter, attribute: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_direction_get :: proc(extensibleparameter: ExtensibleParameter) -> (direction: t.Direction, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    d: i32
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionGet(&d)
    if com_failed(hr) do return

    return t.Direction(d), true
}

extensibleparameter_direction_set :: proc(extensibleparameter: ExtensibleParameter, direction: t.Direction) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionPut(i32(direction))
    if com_failed(hr) do return

    return true
}

extensibleparameter_initial_value_get :: proc(extensibleparameter: ExtensibleParameter) -> (initial_value: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_initial_value_set :: proc(extensibleparameter: ExtensibleParameter, initial_value: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(initial_value)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValuePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_description_get :: proc(extensibleparameter: ExtensibleParameter) -> (description: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_description_set :: proc(extensibleparameter: ExtensibleParameter, description: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_access_level_get :: proc(extensibleparameter: ExtensibleParameter) -> (access_level: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_access_level_set :: proc(extensibleparameter: ExtensibleParameter, access_level: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_safety_type_get :: proc(extensibleparameter: ExtensibleParameter) -> (safety_type: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_safety_type_set :: proc(extensibleparameter: ExtensibleParameter, safety_type: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_type_guid_get :: proc(extensibleparameter: ExtensibleParameter) -> (guid: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeGuid(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_type_path_get :: proc(extensibleparameter: ExtensibleParameter) -> (path: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypePath(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_fdport_get :: proc(extensibleparameter: ExtensibleParameter) -> (fdport: string, ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_fdport_set :: proc(extensibleparameter: ExtensibleParameter, fdport: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(fdport)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_release :: proc(extensibleparameter: ExtensibleParameter) {
    if extensibleparameter != nil {
        (^ExtensibleParameterIF)(extensibleparameter)->Release()
    }
}

ExtensibleParametersIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParametersVTable,
}

ExtensibleParametersVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ExtensibleParametersIF, Parameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ExtensibleParametersIF, Parameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExtensibleParametersIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ExtensibleParametersIF, Name, TypeName, Attribute: BStr, Direction: i32, InitialValue, Description: BStr, Parameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ExtensibleParametersIF, Name: BStr, Parameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ExtensibleParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExtensibleParametersIF, Index: i32, Parameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ExtensibleParametersIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExtensibleParametersIF, Index: i32) -> HResult,
}

extensibleparameters_extensibleparameter_add :: proc(extensibleparameters: ExtensibleParameters, extensibleparameter: ExtensibleParameter) -> (ok: bool) {
    if extensibleparameters == nil do return
    if extensibleparameter == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Add(extensibleparameter)
    if com_failed(hr) do return

    return true
}

extensibleparameters_extensibleparameter_add_at_index :: proc(extensibleparameters: ExtensibleParameters, extensibleparameter: ExtensibleParameter, index: i32) -> (ok: bool) {
    if extensibleparameters == nil do return
    if extensibleparameter == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->AddBefore(extensibleparameter, index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_extensibleparameter_by_name :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->Find(bstr_name, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return

    return extensibleparameter, true
}

extensibleparameters_extensibleparameter_by_index :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Item(index + 1, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return

    return extensibleparameter, true
}

extensibleparameters_extensibleparameter_index :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (index: i32, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

extensibleparameters_extensibleparameter_count :: proc(extensibleparameters: ExtensibleParameters) -> (count: i32, ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

extensibleparameters_extensibleparameter_remove_by_name :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    index, found := extensibleparameters_extensibleparameter_index(extensibleparameters, name)
    if !found do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_extensibleparameter_remove_by_index :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (ok: bool) {
    if extensibleparameters == nil do return
    if !com_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

extensibleparameters_release :: proc(extensibleparameters: ExtensibleParameters) {
    if extensibleparameters != nil {
        (^ExtensibleParametersIF)(extensibleparameters)->Release()
    }
}
