package cbopenif

DiagramInstance :: distinct rawptr

DiagramInstanceIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramInstanceVTable,
}

DiagramInstanceVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                      proc "system" (this: ^DiagramInstanceIF, Name: ^BStr) -> HResult,
    NamePut:                      proc "system" (this: ^DiagramInstanceIF, Name: BStr) -> HResult,
    TypeNameGet:                  proc "system" (this: ^DiagramInstanceIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:                  proc "system" (this: ^DiagramInstanceIF, TypeName: BStr) -> HResult,
    GuidGet:                      proc "system" (this: ^DiagramInstanceIF, Guid: ^BStr) -> HResult,
    GuidPut:                      proc "system" (this: ^DiagramInstanceIF, Guid: BStr) -> HResult,
    DescriptionGet:               proc "system" (this: ^DiagramInstanceIF, Description: ^BStr) -> HResult,
    DescriptionPut:               proc "system" (this: ^DiagramInstanceIF, Description: BStr) -> HResult,
    AspectObjectGet:              proc "system" (this: ^DiagramInstanceIF, AspectObject: ^VariantBool) -> HResult,
    AspectObjectPut:              proc "system" (this: ^DiagramInstanceIF, AspectObject: VariantBool) -> HResult,
    ExposePropertiesInParentGet:  proc "system" (this: ^DiagramInstanceIF, ExposePropertiesInParent: ^VariantBool) -> HResult,
    ExposePropertiesInParentPut:  proc "system" (this: ^DiagramInstanceIF, ExposePropertiesInParent: VariantBool) -> HResult,
    AccessLevelGet:               proc "system" (this: ^DiagramInstanceIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:               proc "system" (this: ^DiagramInstanceIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:                proc "system" (this: ^DiagramInstanceIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:                proc "system" (this: ^DiagramInstanceIF, SafetyType: BStr) -> HResult,
    TypeGuidGet:                  proc "system" (this: ^DiagramInstanceIF, TypeGuid: ^BStr) -> HResult,
    TypePathGet:                  proc "system" (this: ^DiagramInstanceIF, TypePath: ^BStr) -> HResult,
    Serialize:                    proc "system" (this: ^DiagramInstanceIF, XML: ^BStr) -> HResult,
}

diagraminstance_new :: proc(name, type_name: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_type := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
    }
    hr := factoryif->NewDiagramInstance(bstr_name, bstr_type, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstance_deserialize :: proc(xml: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeDiagramInstance(&bs, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstance_serialize :: proc(diagraminstance: DiagramInstance) -> (xml: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_name :: proc {
    diagraminstance_name_get,
    diagraminstance_name_set,
}

diagraminstance_name_get :: proc(diagraminstance: DiagramInstance) -> (name: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_name_set :: proc(diagraminstance: DiagramInstance, name: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_type_name :: proc {
    diagraminstance_type_name_get,
    diagraminstance_type_name_set,
}

diagraminstance_type_name_get :: proc(diagraminstance: DiagramInstance) -> (type_name: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_type_name_set :: proc(diagraminstance: DiagramInstance, type_name: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNamePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_guid :: proc {
    diagraminstance_guid_get,
    diagraminstance_guid_set,
}

diagraminstance_guid_get :: proc(diagraminstance: DiagramInstance) -> (guid: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_guid_set :: proc(diagraminstance: DiagramInstance, guid: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_description :: proc {
    diagraminstance_description_get,
    diagraminstance_description_set,
}

diagraminstance_description_get :: proc(diagraminstance: DiagramInstance) -> (description: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_description_set :: proc(diagraminstance: DiagramInstance, description: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_aspect_object :: proc {
    diagraminstance_aspect_object_get,
    diagraminstance_aspect_object_set,
}

diagraminstance_aspect_object_get :: proc(diagraminstance: DiagramInstance) -> (aspect_object: bool, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagraminstance_aspect_object_set :: proc(diagraminstance: DiagramInstance, aspect_object: bool) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

diagraminstance_expose_properties_in_parent :: proc {
    diagraminstance_expose_properties_in_parent_get,
    diagraminstance_expose_properties_in_parent_set,
}

diagraminstance_expose_properties_in_parent_get :: proc(diagraminstance: DiagramInstance) -> (expose: bool, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagraminstance_expose_properties_in_parent_set :: proc(diagraminstance: DiagramInstance, expose: bool) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentPut(to_variantbool(expose))
    if com_failed(hr) do return

    return true
}

diagraminstance_access_level :: proc {
    diagraminstance_access_level_get,
    diagraminstance_access_level_set,
}

diagraminstance_access_level_get :: proc(diagraminstance: DiagramInstance) -> (access_level: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_access_level_set :: proc(diagraminstance: DiagramInstance, access_level: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_safety_type :: proc {
    diagraminstance_safety_type_get,
    diagraminstance_safety_type_set,
}

diagraminstance_safety_type_get :: proc(diagraminstance: DiagramInstance) -> (safety_type: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_safety_type_set :: proc(diagraminstance: DiagramInstance, safety_type: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_type_guid_get :: proc(diagraminstance: DiagramInstance) -> (type_guid: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_type_path_get :: proc(diagraminstance: DiagramInstance) -> (type_path: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypePathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_release :: proc(diagraminstance: DiagramInstance) {
    if diagraminstance != nil {
        (^DiagramInstanceIF)(diagraminstance)->Release()
    }
}
