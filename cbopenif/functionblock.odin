package cbopenif

FunctionBlock :: distinct rawptr

FunctionBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlockVTable,
}

FunctionBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                     proc "system" (this: ^FunctionBlockIF, name: ^BStr) -> HResult,
    NamePut:                     proc "system" (this: ^FunctionBlockIF, name: BStr) -> HResult,
    TypeNameGet:                 proc "system" (this: ^FunctionBlockIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:                 proc "system" (this: ^FunctionBlockIF, TypeName: BStr) -> HResult,
    TaskConnectionGet:           proc "system" (this: ^FunctionBlockIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:           proc "system" (this: ^FunctionBlockIF, TaskConnection: BStr) -> HResult,
    GuidGet:                     proc "system" (this: ^FunctionBlockIF, Guid: ^BStr) -> HResult,
    GuidPut:                     proc "system" (this: ^FunctionBlockIF, Guid: BStr) -> HResult,
    DescriptionGet:              proc "system" (this: ^FunctionBlockIF, Description: ^BStr) -> HResult,
    DescriptionPut:              proc "system" (this: ^FunctionBlockIF, Description: BStr) -> HResult,
    TypeGuidGet:                 proc "system" (this: ^FunctionBlockIF, TypeGuid: ^BStr) -> HResult,
    TypePathGet:                 proc "system" (this: ^FunctionBlockIF, TypePath: ^BStr) -> HResult,
    Serialize:                   proc "system" (this: ^FunctionBlockIF, XML: ^BStr) -> HResult,
    AspectObjectGet:             proc "system" (this: ^FunctionBlockIF, AspectObject: ^VariantBool) -> HResult,
    AspectObjectPut:             proc "system" (this: ^FunctionBlockIF, AspectObject: VariantBool) -> HResult,
    AccessLevelGet:              proc "system" (this: ^FunctionBlockIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:              proc "system" (this: ^FunctionBlockIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:               proc "system" (this: ^FunctionBlockIF, X: ^BStr) -> HResult,
    SafetyTypePut:               proc "system" (this: ^FunctionBlockIF, X: BStr) -> HResult,
    ExposePropertiesInParentGet: proc "system" (this: ^FunctionBlockIF, Expose: ^VariantBool) -> HResult,
    ExposePropertiesInParentPut: proc "system" (this: ^FunctionBlockIF, Expose: VariantBool) -> HResult,
}

functionblock_new :: proc (name, type_name: string) -> (functionblock: FunctionBlock, ok: bool) {
    if !controlbuilder_connect() do return

    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := factoryif->NewFunctionBlock(bstr_name, bstr_type_name, cast(^rawptr)functionblock)
    if com_failed(hr) do return

    return functionblock, true
}

functionblock_deserialize :: proc(xml: string) -> (functionblock: FunctionBlock, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeFunctionBlock(&bs, cast(^rawptr)functionblock)
    if com_failed(hr) do return

    return functionblock, true
}

functionblock_serialize :: proc(functionblock: FunctionBlock) -> (xml: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_name :: proc {
    functionblock_name_get,
    functionblock_name_set,
}

functionblock_name_get :: proc(functionblock: FunctionBlock) -> (name: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_name_set :: proc(functionblock: FunctionBlock, name: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_type_name :: proc {
    functionblock_type_name_get,
    functionblock_type_name_set,
}

functionblock_type_name_get :: proc(functionblock: FunctionBlock) -> (type_name: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeNameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_type_name_set :: proc(functionblock: FunctionBlock, type_name: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

functionblock_task_connection :: proc {
    functionblock_task_connection_get,
    functionblock_task_connection_set,
}

functionblock_task_connection_get :: proc(functionblock: FunctionBlock) -> (task_connection: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_task_connection_set :: proc(functionblock: FunctionBlock, task_connection: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_guid :: proc {
    functionblock_guid_get,
    functionblock_guid_set,
}

functionblock_guid_get :: proc(functionblock: FunctionBlock) -> (guid: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_guid_set :: proc(functionblock: FunctionBlock, guid: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_description :: proc {
    functionblock_description_get,
    functionblock_description_set,
}

functionblock_description_get :: proc(functionblock: FunctionBlock) -> (description: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_description_set :: proc(functionblock: FunctionBlock, description: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_type_guid_get :: proc(functionblock: FunctionBlock) -> (type_guid: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeGuidGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_type_path_get :: proc(functionblock: FunctionBlock) -> (type_path: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypePathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_aspect_object :: proc {
    functionblock_aspect_object_get,
    functionblock_aspect_object_set,
}

functionblock_aspect_object_get :: proc(functionblock: FunctionBlock) -> (aspect_object: bool, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockIF)(functionblock)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblock_aspect_object_set :: proc(functionblock: FunctionBlock, aspect_object: bool) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockIF)(functionblock)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

functionblock_access_level :: proc {
    functionblock_access_level_get,
    functionblock_access_level_set,
}

functionblock_access_level_get :: proc(functionblock: FunctionBlock) -> (access_level: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_access_level_set :: proc(functionblock: FunctionBlock, access_level: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

functionblock_safety_type :: proc {
    functionblock_safety_type_get,
    functionblock_safety_type_set,
}

functionblock_safety_type_get :: proc(functionblock: FunctionBlock) -> (safety_type: string, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_safety_type_set :: proc(functionblock: FunctionBlock, safety_type: string) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

functionblock_expose_properties_in_parent :: proc {
    functionblock_expose_properties_in_parent_get,
    functionblock_expose_properties_in_parent_set,
}

functionblock_expose_properties_in_parent_get :: proc(functionblock: FunctionBlock) -> (expose_properties_in_parent: bool, ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockIF)(functionblock)->ExposePropertiesInParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblock_expose_properties_in_parent_set :: proc(functionblock: FunctionBlock, expose_properties_in_parent: bool) -> (ok: bool) {
    if functionblock == nil do return
    if !controlbuilder_connected() do return
    
    vb := to_variantbool(expose_properties_in_parent)
    hr := (^FunctionBlockIF)(functionblock)->ExposePropertiesInParentPut(vb)
    if com_failed(hr) do return

    return true
}
