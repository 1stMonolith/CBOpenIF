package com

ApplicationProperties :: distinct rawptr
ApplicationVariables  :: distinct rawptr
ConnectedApplications :: distinct rawptr
ConnectedApplication  :: distinct rawptr

ApplicationPropertiesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ApplicationPropertiesVTable,
}

ApplicationPropertiesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    SILLevelGet:        proc "system" (this: ^ApplicationPropertiesIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:        proc "system" (this: ^ApplicationPropertiesIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet:  proc "system" (this: ^ApplicationPropertiesIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:  proc "system" (this: ^ApplicationPropertiesIF, SimulationMark: VariantBool) -> HResult,
    Serialize:          proc "system" (this: ^ApplicationPropertiesIF, XML: ^BStr) -> HResult,
    ApplicationTypeGet: proc "system" (this: ^ApplicationPropertiesIF, ApplicationType: ^BStr) -> HResult,
}

SerializeApplicationProperties :: proc(applicationproperties: ApplicationProperties) -> (xml: string, ok: bool)
{
    if applicationproperties == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetApplicationPropertiesSILLevel :: proc(applicationproperties: ApplicationProperties) -> (sil_level: string, ok: bool)
{
    if applicationproperties == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SILLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetApplicationPropertiesSILLevel :: proc(applicationproperties: ApplicationProperties, sil_level: string) -> (ok: bool)
{
    if applicationproperties == nil do return
    if !ComConnected() do return

    bs := ToBstr(sil_level)
    defer FreeBstr(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SILLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetApplicationPropertiesSimulationMark :: proc(applicationproperties: ApplicationProperties) -> (simulation_mark: bool, ok: bool)
{
    if applicationproperties == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SimulationMarkGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetApplicationPropertiesSimulationMark :: proc(applicationproperties: ApplicationProperties, simulation_mark: bool) -> (ok: bool)
{
    if applicationproperties == nil do return
    if !ComConnected() do return

    hr := (^ApplicationPropertiesIF)(applicationproperties)->SimulationMarkPut(ToVariantBool(simulation_mark))
    if ComFailed(hr) do return

    return true
}

ApplicationType :: proc(applicationproperties: ApplicationProperties) -> (application_type: string, ok: bool)
{
    if applicationproperties == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->ApplicationTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseApplicationProperties :: proc(applicationproperties: ApplicationProperties)
{
    if applicationproperties != nil {
        (^ApplicationPropertiesIF)(applicationproperties)->Release()
    }
}

ApplicationVariablesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ApplicationVariablesVTable,
}

ApplicationVariablesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    GlobalVariablesGet: proc "system" (this: ^ApplicationVariablesIF, GlobalVariables: ^rawptr) -> HResult,
    Missing8:           proc "system" (this: ^ApplicationVariablesIF) -> HResult,
    GlobalVariablesPut: proc "system" (this: ^ApplicationVariablesIF, GlobalVariables: rawptr) -> HResult,
    VariablesGet:       proc "system" (this: ^ApplicationVariablesIF, Variables: ^rawptr) -> HResult,
    Missing11:          proc "system" (this: ^ApplicationVariablesIF) -> HResult,
    VariablesPut:       proc "system" (this: ^ApplicationVariablesIF, Variables: rawptr) -> HResult,
    DescriptionGet:     proc "system" (this: ^ApplicationVariablesIF, Description: ^BStr) -> HResult,
    DescriptionPut:     proc "system" (this: ^ApplicationVariablesIF, Description: BStr) -> HResult,
    Serialize:          proc "system" (this: ^ApplicationVariablesIF, XMLStr: ^BStr) -> HResult,
    SignalsGet:         proc "system" (this: ^ApplicationVariablesIF, Signals: ^rawptr) -> HResult,
    Missing17:          proc "system" (this: ^ApplicationVariablesIF) -> HResult,
    SignalsPut:         proc "system" (this: ^ApplicationVariablesIF, Signals: rawptr) -> HResult,
}

SerializeApplicationVariables :: proc(application_variables: ApplicationVariables) -> (xml: string, ok: bool)
{
    if application_variables == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetApplicationVariablesDescription :: proc(application_variables: ApplicationVariables) -> (description: string, ok: bool)
{
    if application_variables == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetApplicationVariablesDescription :: proc(application_variables: ApplicationVariables, description: string) -> (ok: bool)
{
    if application_variables == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetApplicationVariablesGlobalVariables :: proc(application_variables: ApplicationVariables) -> (global_variables: GlobalVariables, ok: bool)
{
    if application_variables == nil do return
    if !ComConnected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesGet(cast(^rawptr)&global_variables)
    if ComFailed(hr) do return

    return global_variables, true
}

SetApplicationVariablesGlobalVariables :: proc(application_variables: ApplicationVariables, global_variables: GlobalVariables) -> (ok: bool)
{
    if application_variables == nil do return
    if global_variables == nil do return
    if !ComConnected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesPut(global_variables)
    if ComFailed(hr) do return

    return true
}

GetApplicationVariablesVariables :: proc(application_variables: ApplicationVariables) -> (variables: Variables, ok: bool)
{
    if application_variables == nil do return
    if !ComConnected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesGet(cast(^rawptr)&variables)
    if ComFailed(hr) do return

    return variables, true
}

SetApplicationVariablesVariables :: proc(application_variables: ApplicationVariables, variables: Variables) -> (ok: bool)
{
    if application_variables == nil do return
    if variables == nil do return
    if !ComConnected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesPut(variables)
    if ComFailed(hr) do return

    return true
}

GetApplicationVariablesSignals :: proc(application_variables: ApplicationVariables) -> (signals: Signals, ok: bool)
{
    if application_variables == nil do return
    if !ComConnected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsGet(cast(^rawptr)&signals)
    if ComFailed(hr) do return

    return signals, true
}

SetApplicationVariablesSignals :: proc(application_variables: ApplicationVariables, signals: Signals) -> (ok: bool)
{
    if application_variables == nil do return
    if signals == nil do return
    if !ComConnected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsPut(signals)
    if ComFailed(hr) do return

    return true
}

ReleaseApplicationVariables :: proc(application_variables: ApplicationVariables)
{
    if application_variables != nil {
        (^ApplicationVariablesIF)(application_variables)->Release()
    }
}

ConnectedApplicationsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationsVTable,
}

ConnectedApplicationsVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedApplicationsIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedApplicationsIF, ConnectedApplication: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedApplicationsIF, ConnectedApplication: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedApplication: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedApplicationsIF, Index: i32, ConnectedApplication: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedApplicationsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedApplicationsIF, Index: i32) -> HResult,
}

SerializeConnectedApplications :: proc(connectedapplications: ConnectedApplications) -> (xml: string, ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

AddConnectedApplication :: proc {
    _AddConnectedApplication,
    _AddConnectedApplicationAtIndex,
}

_AddConnectedApplication :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication) -> (ok: bool)
{
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Add(connectedapplication)
    if ComFailed(hr) do return

    return true
}

_AddConnectedApplicationAtIndex :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication, index: i32) -> (ok: bool)
{
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->AddBefore(connectedapplication, index)
    if ComFailed(hr) do return

    return true
}

GetConnectedApplication :: proc {
    _GetConnectedApplicationWithName,
    _GetConnectedApplicationWithIndex,
}

_GetConnectedApplicationWithName :: proc(connectedapplications: ConnectedApplications, name: string) -> (connectedapplication: ConnectedApplication, ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Find(bstr_name, cast(^rawptr)&connectedapplication)
    if ComFailed(hr) do return

    return connectedapplication, true
}

_GetConnectedApplicationWithIndex :: proc(connectedapplications: ConnectedApplications, index: i32) -> (connectedapplication: ConnectedApplication, ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Item(index + 1, cast(^rawptr)&connectedapplication)
    if ComFailed(hr) do return

    return connectedapplication, true
}

ConnectedApplicationIndex :: proc(connectedapplications: ConnectedApplications, name: string) -> (index: i32, ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ConnectedApplicationCount :: proc(connectedapplications: ConnectedApplications) -> (count: i32, ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveConnectedApplication :: proc {
    _RemoveConnectedApplicationWithName,
    _RemoveConnectedApplicationAtIndex,
}

_RemoveConnectedApplicationWithName :: proc(connectedapplications: ConnectedApplications, name: string) -> (ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ConnectedApplicationIndex(connectedapplications, name)
    if !ok do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveConnectedApplicationAtIndex :: proc(connectedapplications: ConnectedApplications, index: i32) -> (ok: bool)
{
    if connectedapplications == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseConnectedApplications :: proc(connectedapplications: ConnectedApplications)
{
    if connectedapplications != nil {
        (^ConnectedApplicationsIF)(connectedapplications)->Release()
    }
}

ConnectedApplicationIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationVTable,
}

ConnectedApplicationVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedApplicationIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedApplicationIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedApplicationIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedApplicationIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedApplicationIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedApplicationIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedApplicationIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedApplicationIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedApplicationIF, Guid: ^BStr) -> HResult,
}

GetConnectedApplicationName :: proc(ca: ConnectedApplication) -> (name: string, ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedApplicationIF)(ca)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetConnectedApplicationName :: proc(ca: ConnectedApplication, name: string) -> (ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ConnectedApplicationIF)(ca)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetConnectedApplicationMajorVersion :: proc(ca: ConnectedApplication) -> (major_version: i32, ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionGet(&major_version)
    if ComFailed(hr) do return

    return major_version, true
}

SetConnectedApplicationMajorVersion :: proc(ca: ConnectedApplication, major_version: i32) -> (ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionPut(major_version)
    if ComFailed(hr) do return

    return true
}

GetConnectedApplicationMinorVersion :: proc(ca: ConnectedApplication) -> (minor_version: i32, ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionGet(&minor_version)
    if ComFailed(hr) do return

    return minor_version, true
}

SetConnectedApplicationMinorVersion :: proc(ca: ConnectedApplication, minor_version: i32) -> (ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionPut(minor_version)
    if ComFailed(hr) do return

    return true
}

GetConnectedApplicationRevision :: proc(ca: ConnectedApplication) -> (revision: i32, ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionGet(&revision)
    if ComFailed(hr) do return

    return revision, true
}

SetConnectedApplicationRevision :: proc(ca: ConnectedApplication, revision: i32) -> (ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionPut(revision)
    if ComFailed(hr) do return

    return true
}

GetConnectedApplicationGuid :: proc(ca: ConnectedApplication) -> (guid: string, ok: bool)
{
    if ca == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedApplicationIF)(ca)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseConnectedApplication :: proc(ca: ConnectedApplication)
{
    if ca != nil {
        (^ConnectedApplicationIF)(ca)->Release()
    }
}
