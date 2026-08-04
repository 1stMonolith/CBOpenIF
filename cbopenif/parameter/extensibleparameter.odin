package parameter

import "../com"
import "../controlbuilder"
import "../factory"
import "../type"

@(private="file") BStr          :: com.BStr
@(private="file") DirectionType :: type.DirectionType
@(private="file") HResult       :: com.HResult

ExtensibleParameter :: distinct rawptr

ExtensibleParameterIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ExtensibleParameterVTable,
}

ExtensibleParameterVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

extensibleparameter_new :: proc(
    name: string,
    type_name: string,
    attribute := "",
    direction := DirectionType.InOut,
    initial_value := "",
    description := "",
) -> (ep: ExtensibleParameter, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return

    bstr_name          := com.from_string(name)
    bstr_type_name     := com.from_string(type_name)
    bstr_attribute     := com.from_string(attribute)
    bstr_initial_value := com.from_string(initial_value)
    bstr_description   := com.from_string(description)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_type_name)
        com.bstr_free(bstr_attribute)
        com.bstr_free(bstr_initial_value)
        com.bstr_free(bstr_description)
    }

    hr := factory.factoryif->NewExtensibleParameter1(
        bstr_name, bstr_type_name, bstr_attribute,
        i32(direction), bstr_initial_value, bstr_description,
        cast(^rawptr)&ep,
    )
    if com.failed(hr) do return

    return ep, true
}

extensibleparameter_deserialize :: proc(ep: ^ExtensibleParameter, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeExtensibleParameter(&bs, cast(^rawptr)ep)
    if com.failed(hr) do return

    return true
}

extensibleparameter_serialize :: proc(ep: ExtensibleParameter) -> (xml: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->Serialize(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_name :: proc {
    extensibleparameter_name_get,
    extensibleparameter_name_set,
}

extensibleparameter_name_get :: proc(ep: ExtensibleParameter) -> (name: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_name_set :: proc(ep: ExtensibleParameter, name: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_type_name :: proc {
    extensibleparameter_type_name_get,
    extensibleparameter_type_name_set,
}

extensibleparameter_type_name_get :: proc(ep: ExtensibleParameter) -> (type_name: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->TypeNameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_type_name_set :: proc(ep: ExtensibleParameter, type_name: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(type_name)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->TypeNamePut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_attribute :: proc {
    extensibleparameter_attribute_get,
    extensibleparameter_attribute_set,
}

extensibleparameter_attribute_get :: proc(ep: ExtensibleParameter) -> (attribute: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->AttributeGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_attribute_set :: proc(ep: ExtensibleParameter, attribute: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(attribute)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->AttributePut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_direction :: proc {
    extensibleparameter_direction_get,
    extensibleparameter_direction_set,
}

extensibleparameter_direction_get :: proc(ep: ExtensibleParameter) -> (direction: DirectionType, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    d: i32
    hr := (^ExtensibleParameterIF)(ep)->DirectionGet(&d)
    if com.failed(hr) do return

    return DirectionType(d), true
}

extensibleparameter_direction_set :: proc(ep: ExtensibleParameter, direction: DirectionType) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^ExtensibleParameterIF)(ep)->DirectionPut(i32(direction))
    if com.failed(hr) do return

    return true
}

extensibleparameter_initial_value :: proc {
    extensibleparameter_initial_value_get,
    extensibleparameter_initial_value_set,
}

extensibleparameter_initial_value_get :: proc(ep: ExtensibleParameter) -> (initial_value: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->InitialValueGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_initial_value_set :: proc(ep: ExtensibleParameter, initial_value: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(initial_value)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->InitialValuePut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_description :: proc {
    extensibleparameter_description_get,
    extensibleparameter_description_set,
}

extensibleparameter_description_get :: proc(ep: ExtensibleParameter) -> (description: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_description_set :: proc(ep: ExtensibleParameter, description: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(description)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->DescriptionPut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_access_level :: proc {
    extensibleparameter_access_level_get,
    extensibleparameter_access_level_set,
}

extensibleparameter_access_level_get :: proc(ep: ExtensibleParameter) -> (access_level: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->AccessLevelGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_access_level_set :: proc(ep: ExtensibleParameter, access_level: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(access_level)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->AccessLevelPut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_safety_type :: proc {
    extensibleparameter_safety_type_get,
    extensibleparameter_safety_type_set,
}

extensibleparameter_safety_type_get :: proc(ep: ExtensibleParameter) -> (safety_type: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->SafetyTypeGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_safety_type_set :: proc(ep: ExtensibleParameter, safety_type: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(safety_type)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->SafetyTypePut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_type_guid_get :: proc(ep: ExtensibleParameter) -> (guid: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->TypeGuid(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_type_path_get :: proc(ep: ExtensibleParameter) -> (path: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->TypePath(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_fdport :: proc {
    extensibleparameter_fdport_get,
    extensibleparameter_fdport_set,
}

extensibleparameter_fdport_get :: proc(ep: ExtensibleParameter) -> (fdport: string, ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->FDPortGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extensibleparameter_fdport_set :: proc(ep: ExtensibleParameter, fdport: string) -> (ok: bool) {
    if ep == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(fdport)
    defer com.bstr_free(bs)
    hr := (^ExtensibleParameterIF)(ep)->FDPortPut(bs)
    if com.failed(hr) do return

    return true
}

extensibleparameter_release :: proc(ep: ExtensibleParameter) {
    if ep != nil {
        (^ExtensibleParameterIF)(ep)->Release()
    }
}
