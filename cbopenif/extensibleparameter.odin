package cbopenif

ExtensibleParameter :: distinct rawptr

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

extensibleparameter_new :: proc(
    name: string,
    type_name: string,
    attribute := "",
    direction := DirectionType.InOut,
    initial_value := "",
    description := "",
) -> (extensibleparameter: ExtensibleParameter, ok: bool) {

    if !controlbuilder_connected() do return

    bstr_name          := to_bstr(name)
    bstr_type_name     := to_bstr(type_name)
    bstr_attribute     := to_bstr(attribute)
    bstr_initial_value := to_bstr(initial_value)
    bstr_description   := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_description)
    }

    hr := factoryif->NewExtensibleParameter1(
        bstr_name, bstr_type_name, bstr_attribute,
        i32(direction), bstr_initial_value, bstr_description,
        cast(^rawptr)&extensibleparameter,
    )
    if com_failed(hr) do return

    return extensibleparameter, true
}

extensibleparameter_deserialize :: proc(extensibleparameter: ^ExtensibleParameter, xml: string) -> (ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeExtensibleParameter(&bs, cast(^rawptr)extensibleparameter)
    if com_failed(hr) do return

    return true
}

extensibleparameter_serialize :: proc(extensibleparameter: ExtensibleParameter) -> (xml: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_name :: proc {
    extensibleparameter_name_get,
    extensibleparameter_name_set,
}

extensibleparameter_name_get :: proc(extensibleparameter: ExtensibleParameter) -> (name: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_name_set :: proc(extensibleparameter: ExtensibleParameter, name: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_type_name :: proc {
    extensibleparameter_type_name_get,
    extensibleparameter_type_name_set,
}

extensibleparameter_type_name_get :: proc(extensibleparameter: ExtensibleParameter) -> (type_name: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_type_name_set :: proc(extensibleparameter: ExtensibleParameter, type_name: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNamePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_attribute :: proc {
    extensibleparameter_attribute_get,
    extensibleparameter_attribute_set,
}

extensibleparameter_attribute_get :: proc(extensibleparameter: ExtensibleParameter) -> (attribute: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_attribute_set :: proc(extensibleparameter: ExtensibleParameter, attribute: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_direction :: proc {
    extensibleparameter_direction_get,
    extensibleparameter_direction_set,
}

extensibleparameter_direction_get :: proc(extensibleparameter: ExtensibleParameter) -> (direction: DirectionType, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    d: i32
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionGet(&d)
    if com_failed(hr) do return

    return DirectionType(d), true
}

extensibleparameter_direction_set :: proc(extensibleparameter: ExtensibleParameter, direction: DirectionType) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionPut(i32(direction))
    if com_failed(hr) do return

    return true
}

extensibleparameter_initial_value :: proc {
    extensibleparameter_initial_value_get,
    extensibleparameter_initial_value_set,
}

extensibleparameter_initial_value_get :: proc(extensibleparameter: ExtensibleParameter) -> (initial_value: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValueGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_initial_value_set :: proc(extensibleparameter: ExtensibleParameter, initial_value: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(initial_value)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValuePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_description :: proc {
    extensibleparameter_description_get,
    extensibleparameter_description_set,
}

extensibleparameter_description_get :: proc(extensibleparameter: ExtensibleParameter) -> (description: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_description_set :: proc(extensibleparameter: ExtensibleParameter, description: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_access_level :: proc {
    extensibleparameter_access_level_get,
    extensibleparameter_access_level_set,
}

extensibleparameter_access_level_get :: proc(extensibleparameter: ExtensibleParameter) -> (access_level: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_access_level_set :: proc(extensibleparameter: ExtensibleParameter, access_level: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_safety_type :: proc {
    extensibleparameter_safety_type_get,
    extensibleparameter_safety_type_set,
}

extensibleparameter_safety_type_get :: proc(extensibleparameter: ExtensibleParameter) -> (safety_type: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_safety_type_set :: proc(extensibleparameter: ExtensibleParameter, safety_type: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

extensibleparameter_type_guid_get :: proc(extensibleparameter: ExtensibleParameter) -> (guid: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeGuid(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_type_path_get :: proc(extensibleparameter: ExtensibleParameter) -> (path: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypePath(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_fdport :: proc {
    extensibleparameter_fdport_get,
    extensibleparameter_fdport_set,
}

extensibleparameter_fdport_get :: proc(extensibleparameter: ExtensibleParameter) -> (fdport: string, ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extensibleparameter_fdport_set :: proc(extensibleparameter: ExtensibleParameter, fdport: string) -> (ok: bool) {
    if extensibleparameter == nil do return
    if !controlbuilder_connected() do return

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
