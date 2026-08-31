package com

Parameters           :: distinct rawptr
Parameter            :: distinct rawptr
ParameterSettings    :: distinct rawptr
ParameterSetting     :: distinct rawptr
ExtensibleParameters :: distinct rawptr
ExtensibleParameter  :: distinct rawptr

ParametersIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParametersVTable,
}

ParametersVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ParametersIF, Parameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ParametersIF, Parameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParametersIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ParametersIF, Name, TypeName, Attribute, Direction, InitialValue, ReadPermission, WritePermission, Description: BStr, Parameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ParametersIF, Name: BStr, Parameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParametersIF, Index: i32, Parameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ParametersIF, count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParametersIF, Index: i32) -> HResult,
}

AddParameter :: proc {
    _AddParameter,
    _AddParameterAtIndex,
}

_AddParameter :: proc(parameters: Parameters, parameter: Parameter) -> (ok: bool)
{
    if parameters == nil do return
    if parameter == nil do return
    if !ComConnected() do return

    hr := (^ParametersIF)(parameters)->Add(parameter)
    if ComFailed(hr) do return

    return true
}

_AddParameterAtIndex :: proc(parameters: Parameters, parameter: Parameter, index: i32) -> (ok: bool)
{
    if parameters == nil do return
    if parameter == nil do return
    if !ComConnected() do return
    
    hr := (^ParametersIF)(parameters)->AddBefore(parameter, index)
    if ComFailed(hr) do return

    return true
}

GetParameter :: proc {
    _GetParameterWithName,
    _GetParameterAtIndex,
}

_GetParameterWithName :: proc(parameters: Parameters, name: string) -> (parameter: Parameter, ok: bool)
{
    if parameters == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ParametersIF)(parameters)->Find(bstr_name, cast(^rawptr)&parameter)
    if ComFailed(hr) do return
    
    return parameter, true
}

_GetParameterAtIndex :: proc(parameters: rawptr, index: i32) -> (parameter: Parameter, ok: bool)
{
    if parameters == nil do return
    if !ComConnected() do return
    
    hr := (^ParametersIF)(parameters)->Item(index + 1, cast(^rawptr)&parameter)
    if ComFailed(hr) do return
    
    return parameter, true
}

ParameterIndex :: proc(parameters: Parameters, name: string) -> (index: i32, ok: bool)
{
    if parameters == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ParametersIF)(parameters)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

ParameterCount :: proc(parameters: Parameters) -> (count: i32, ok: bool)
{
    if parameters == nil do return
    if !ComConnected() do return
    
    hr := (^ParametersIF)(parameters)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveParameter :: proc {
    _RemoveParameterWithName,
    _RemoveParameterAtIndex,
}

_RemoveParameterWithName :: proc(parameters: Parameters, name: string) -> (ok: bool)
{
    if parameters == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ParameterIndex(parameters, name)
    
    hr := (^ParametersIF)(parameters)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveParameterAtIndex :: proc(parameters: Parameters, index: i32) -> (ok: bool)
{
    if parameters == nil do return
    if !ComConnected() do return
    
    hr := (^ParametersIF)(parameters)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseParameters :: proc(parameters: Parameters)
{
    if parameters != nil {
        (^ParametersIF)(parameters)->Release()
    }
}

ParameterIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParameterVTable,
}

ParameterVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^ParameterIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ParameterIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^ParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^ParameterIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ParameterIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ParameterIF, Attribute: BStr) -> HResult,
    DirectionGet:           proc "system" (this: ^ParameterIF, Direction: ^i32) -> HResult,
    DirectionPut:           proc "system" (this: ^ParameterIF, Direction: i32) -> HResult,
    InitialValueGet:        proc "system" (this: ^ParameterIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^ParameterIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^ParameterIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^ParameterIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^ParameterIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^ParameterIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^ParameterIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^ParameterIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^ParameterIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^ParameterIF, AuthenticationLevel: BStr) -> HResult,
    TypeGuid:               proc "system" (this: ^ParameterIF, Guid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^ParameterIF, Path: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^ParameterIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ParameterIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ParameterIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ParameterIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ParameterIF, SafetyType: BStr) -> HResult,
    FDPortGet:              proc "system" (this: ^ParameterIF, FDPort: ^BStr) -> HResult,
    FDPortPut:              proc "system" (this: ^ParameterIF, FDPort: BStr) -> HResult,
}

SerializeParameter :: proc(parameter: Parameter) -> (xml: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetParameterName :: proc(parameter: Parameter) -> (name: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetParameterName :: proc(parameter: Parameter, name: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterTypeName :: proc(parameter: Parameter) -> (type_name: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetParameterTypeName :: proc(parameter: Parameter, type_name: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterAttribute :: proc(parameter: Parameter) -> (attribute: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->AttributeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterAttribute :: proc(parameter: Parameter, attribute: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->AttributePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterDirection :: proc(parameter: Parameter) -> (direction: i32, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return

    d: i32
    hr := (^ParameterIF)(parameter)->DirectionGet(&d)
    if ComFailed(hr) do return
    
    return d, true
}

SetParameterDirection :: proc(parameter: Parameter, direction: i32) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return

    hr := (^ParameterIF)(parameter)->DirectionPut(direction)
    if ComFailed(hr) do return
    
    return true
}

GetParameterInitialValue :: proc(parameter: Parameter) -> (inital_value: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->InitialValueGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetParameterInitialValue :: proc(parameter: Parameter, inital_value: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(inital_value)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->InitialValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterDescription :: proc(parameter: Parameter) -> (description: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterDescription :: proc(parameter: Parameter, description: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterReadPermission :: proc(parameter: Parameter) -> (read_permission: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterReadPermission :: proc(parameter: Parameter, read_permission: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterWritePermission :: proc(parameter: Parameter) -> (write_permission: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterWritePermission :: proc(parameter: Parameter, write_permission: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(write_permission)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->WritePermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterAuthenticationLevel :: proc(parameter: Parameter) -> (authentication_level: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterAuthenticationLevel :: proc(parameter: Parameter, authentication_level: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(authentication_level)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->AuthenticationLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterTypeGuid :: proc(parameter: Parameter) -> (guid: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->TypeGuid(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetParameterTypePath :: proc(parameter: Parameter) -> (path: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->TypePath(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetParameterAccessLevel :: proc(parameter: Parameter) -> (access_level: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterAccessLevel :: proc(parameter: Parameter, access_level: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterSafetyType :: proc(parameter: Parameter) -> (safety_type: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterSafetyType :: proc(parameter: Parameter, safety_type: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterFDPort :: proc(parameter: Parameter) -> (fdport: string, ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->FDPortGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterFDPort :: proc(parameter: Parameter, fdport: string) -> (ok: bool)
{
    if parameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(fdport)
    defer FreeBstr(bs)
    hr := (^ParameterIF)(parameter)->FDPortPut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseParameter :: proc(parameter: Parameter)
{
    if parameter != nil {
        (^ParameterIF)(parameter)->Release()
    }
}

ParameterSettingsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParameterSettingsVTable,
}

ParameterSettingsVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ParameterSettingsIF, ParameterSetting: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ParameterSettingsIF, ParameterSetting: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParameterSettingsIF, Name, ParameterValue: BStr, ParameterSetting: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ParameterSettingsIF, Name: BStr, ParameterSetting: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ParameterSettingsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParameterSettingsIF, Index: i32, ParameterSetting: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ParameterSettingsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParameterSettingsIF, Index: i32) -> HResult,
}

AddParameterSetting :: proc {
    _AddParameterSetting,
    _AddParameterSettingAtIndex,
}

_AddParameterSetting :: proc(parametersettings: ParameterSettings, parametersetting: ParameterSetting) -> (ok: bool)
{
    if parametersettings == nil do return
    if parametersetting == nil do return
    if !ComConnected() do return

    hr := (^ParameterSettingsIF)(parametersettings)->Add(parametersetting)
    if ComFailed(hr) do return

    return true
}

_AddParameterSettingAtIndex :: proc(parametersettings: ParameterSettings, parametersetting: ParameterSetting, index: i32) -> (ok: bool)
{
    if parametersettings == nil do return
    if parametersetting == nil do return
    if !ComConnected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->AddBefore(parametersetting, index)
    if ComFailed(hr) do return

    return true
}

GetParameterSetting :: proc {
    _GetParameterSettingWithName,
    _GetParameterSettingAtIndex,
}

_GetParameterSettingWithName :: proc(parametersettings: ParameterSettings, name: string) -> (parametersetting: ParameterSetting, ok: bool)
{
    if parametersettings == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ParameterSettingsIF)(parametersettings)->Find(bstr_name, cast(^rawptr)&parametersetting)
    if ComFailed(hr) do return
    
    return parametersetting, true
}

_GetParameterSettingAtIndex :: proc(parametersettings: ParameterSettings, index: i32) -> (parametersetting: ParameterSetting, ok: bool)
{
    if parametersettings == nil do return
    if !ComConnected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Item(index + 1, cast(^rawptr)&parametersetting)
    if ComFailed(hr) do return
    
    return parametersetting, true
}

ParameterSettingIndex :: proc(parametersettings: ParameterSettings, name: string) -> (index: i32, ok: bool)
{
    if parametersettings == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ParameterSettingsIF)(parametersettings)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

ParameterSettingCount :: proc(parametersettings: ParameterSettings) -> (count: i32, ok: bool)
{
    if parametersettings == nil do return
    if !ComConnected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveParameterSetting :: proc {
    _RemoveParameterSettingWithName,
    _RemoveParameterSettingAtIndex,
}

_RemoveParameterSettingWithName :: proc(parametersettings: ParameterSettings, name: string) -> (ok: bool)
{
    if parametersettings == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ParameterSettingIndex(parametersettings, name)
    
    hr := (^ParameterSettingsIF)(parametersettings)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveParameterSettingAtIndex :: proc(parametersettings: ParameterSettings, index: i32) -> (ok: bool)
{
    if parametersettings == nil do return
    if !ComConnected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseParameterSettings :: proc(parametersettings: ParameterSettings)
{
    if parametersettings != nil {
        (^ParameterSettingsIF)(parametersettings)->Release()
    }
}

ParameterSettingIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParameterSettingVTable,
}

ParameterSettingVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:           proc "system" (this: ^ParameterSettingIF, Name: ^BStr) -> HResult,
    NamePut:           proc "system" (this: ^ParameterSettingIF, Name: BStr) -> HResult,
    ParameterValueGet: proc "system" (this: ^ParameterSettingIF, ParameterValue: ^BStr) -> HResult,
    ParameterValuePut: proc "system" (this: ^ParameterSettingIF, ParameterValue: BStr) -> HResult,
    DescriptionGet:    proc "system" (this: ^ParameterSettingIF, Description: ^BStr) -> HResult,
}

GetParameterSettingName :: proc(parametersetting: ParameterSetting) -> (name: string, ok: bool)
{
    if parametersetting == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterSettingIF)(parametersetting)->NameGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterSettingName :: proc(parametersetting: ParameterSetting, name: string) -> (ok: bool)
{
    if parametersetting == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ParameterSettingIF)(parametersetting)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterSettingValue :: proc(parametersetting: ParameterSetting) -> (value: string, ok: bool)
{
    if parametersetting == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterSettingIF)(parametersetting)->ParameterValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetParameterSettingValue :: proc(parametersetting: ParameterSetting, value: string) -> (ok: bool)
{
    if parametersetting == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(value)
    defer FreeBstr(bs)
    hr := (^ParameterSettingIF)(parametersetting)->ParameterValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetParameterSettingDescription :: proc(parametersetting: ParameterSetting) -> (description: string, ok: bool)
{
    if parametersetting == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ParameterSettingIF)(parametersetting)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseParameterSetting :: proc(parametersetting: ParameterSetting) {
    if parametersetting != nil {
        (^ParameterSettingIF)(parametersetting)->Release()
    }
}

ExtensibleParametersIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParametersVTable,
}

ExtensibleParametersVTable :: struct
{
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

AddExtensibleParameter :: proc {
    _AddExtensibleParameter,
    _AddExtensibleParameterAtIndex,
}

_AddExtensibleParameter :: proc(extensibleparameters: ExtensibleParameters, extensibleparameter: ExtensibleParameter) -> (ok: bool)
{
    if extensibleparameters == nil do return
    if extensibleparameter == nil do return
    if !ComConnected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Add(extensibleparameter)
    if ComFailed(hr) do return

    return true
}

_AddExtensibleParameterAtIndex :: proc(extensibleparameters: ExtensibleParameters, extensibleparameter: ExtensibleParameter, index: i32) -> (ok: bool)
{
    if extensibleparameters == nil do return
    if extensibleparameter == nil do return
    if !ComConnected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->AddBefore(extensibleparameter, index)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameter :: proc {
    _GetExtensibleParameterWithName,
    _GetExtensibleParameterAtIndex,
}

_GetExtensibleParameterWithName :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (extensibleparameter: ExtensibleParameter, ok: bool)
{
    if extensibleparameters == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->Find(bstr_name, cast(^rawptr)&extensibleparameter)
    if ComFailed(hr) do return

    return extensibleparameter, true
}

_GetExtensibleParameterAtIndex :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (extensibleparameter: ExtensibleParameter, ok: bool)
{
    if extensibleparameters == nil do return
    if !ComConnected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Item(index + 1, cast(^rawptr)&extensibleparameter)
    if ComFailed(hr) do return

    return extensibleparameter, true
}

ExtensibleParameterIndex :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (index: i32, ok: bool)
{
    if extensibleparameters == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ExtensibleParameterCount :: proc(extensibleparameters: ExtensibleParameters) -> (count: i32, ok: bool)
{
    if extensibleparameters == nil do return
    if !ComConnected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveExtensibleParameter :: proc {
    _RemoveExtensibleParameterWithName,
    _RemoveExtensibleParameterAtIndex,
}

_RemoveExtensibleParameterWithName :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (ok: bool)
{
    if extensibleparameters == nil do return
    if !ComConnected() do return

    index, found := ExtensibleParameterIndex(extensibleparameters, name)
    if !found do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveExtensibleParameterAtIndex :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (ok: bool)
{
    if extensibleparameters == nil do return
    if !ComConnected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseExtensibleParameters :: proc(extensibleparameters: ExtensibleParameters)
{
    if extensibleparameters != nil {
        (^ExtensibleParametersIF)(extensibleparameters)->Release()
    }
}

ExtensibleParameterIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParameterVTable,
}

ExtensibleParameterVTable :: struct
{
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

SerializeExtensibleParameter :: proc(extensibleparameter: ExtensibleParameter) -> (xml: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetExtensibleParameterName :: proc(extensibleparameter: ExtensibleParameter) -> (name: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterName :: proc(extensibleparameter: ExtensibleParameter, name: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterTypeName :: proc(extensibleparameter: ExtensibleParameter) -> (type_name: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterTypeName :: proc(extensibleparameter: ExtensibleParameter, type_name: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterAttribute :: proc(extensibleparameter: ExtensibleParameter) -> (attribute: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterAttribute :: proc(extensibleparameter: ExtensibleParameter, attribute: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AttributePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterDirection :: proc(extensibleparameter: ExtensibleParameter) -> (direction: i32, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    d: i32
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionGet(&d)
    if ComFailed(hr) do return

    return d, true
}

SetExtensibleParameterDirection :: proc(extensibleparameter: ExtensibleParameter, direction: i32) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    hr := (^ExtensibleParameterIF)(extensibleparameter)->DirectionPut(direction)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterInitialValue :: proc(extensibleparameter: ExtensibleParameter) -> (initial_value: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValueGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterInitialValue :: proc(extensibleparameter: ExtensibleParameter, initial_value: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(initial_value)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->InitialValuePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterDescription :: proc(extensibleparameter: ExtensibleParameter) -> (description: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterDescription :: proc(extensibleparameter: ExtensibleParameter, description: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterAccessLevel :: proc(extensibleparameter: ExtensibleParameter) -> (access_level: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterAccessLevel :: proc(extensibleparameter: ExtensibleParameter, access_level: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->AccessLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterSafetyType :: proc(extensibleparameter: ExtensibleParameter) -> (safety_type: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterSafetyType :: proc(extensibleparameter: ExtensibleParameter, safety_type: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->SafetyTypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtensibleParameterTypeGuid :: proc(extensibleparameter: ExtensibleParameter) -> (guid: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypeGuid(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetExtensibleParameterTypePath :: proc(extensibleparameter: ExtensibleParameter) -> (path: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->TypePath(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetExtensibleParameterFDPort :: proc(extensibleparameter: ExtensibleParameter) -> (fdport: string, ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtensibleParameterFDPort :: proc(extensibleparameter: ExtensibleParameter, fdport: string) -> (ok: bool)
{
    if extensibleparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(fdport)
    defer FreeBstr(bs)
    hr := (^ExtensibleParameterIF)(extensibleparameter)->FDPortPut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseExtensibleParameter :: proc(extensibleparameter: ExtensibleParameter)
{
    if extensibleparameter != nil {
        (^ExtensibleParameterIF)(extensibleparameter)->Release()
    }
}
