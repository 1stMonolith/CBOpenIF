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

