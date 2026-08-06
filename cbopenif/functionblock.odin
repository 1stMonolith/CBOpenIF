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
