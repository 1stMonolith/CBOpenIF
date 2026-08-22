package com

ApplicationProperties :: distinct rawptr
ApplicationVariables  :: distinct rawptr
ConnectedApplication  :: distinct rawptr
ConnectedApplications :: distinct rawptr

ApplicationPropertiesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ApplicationPropertiesVTable,
}

ApplicationPropertiesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    SILLevelGet:        proc "system" (this: ^ApplicationPropertiesIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:        proc "system" (this: ^ApplicationPropertiesIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet:  proc "system" (this: ^ApplicationPropertiesIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:  proc "system" (this: ^ApplicationPropertiesIF, SimulationMark: VariantBool) -> HResult,
    Serialize:          proc "system" (this: ^ApplicationPropertiesIF, XML: ^BStr) -> HResult,
    ApplicationTypeGet: proc "system" (this: ^ApplicationPropertiesIF, ApplicationType: ^BStr) -> HResult,
}

applicationproperties_serialize :: proc(applicationproperties: ApplicationProperties) -> (xml: string, ok: bool) {
    if applicationproperties == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationproperties_sil_level_get :: proc(applicationproperties: ApplicationProperties) -> (sil_level: string, ok: bool) {
    if applicationproperties == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationproperties_sil_level_set :: proc(applicationproperties: ApplicationProperties, sil_level: string) -> (ok: bool) {
    if applicationproperties == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

applicationproperties_simulation_mark_get :: proc(applicationproperties: ApplicationProperties) -> (simulation_mark: bool, ok: bool) {
    if applicationproperties == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

applicationproperties_simulation_mark_set :: proc(applicationproperties: ApplicationProperties, simulation_mark: bool) -> (ok: bool) {
    if applicationproperties == nil do return
    if !com_connected() do return

    hr := (^ApplicationPropertiesIF)(applicationproperties)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

applicationproperties_application_type_get :: proc(applicationproperties: ApplicationProperties) -> (application_type: string, ok: bool) {
    if applicationproperties == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->ApplicationTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationproperties_release :: proc(applicationproperties: ApplicationProperties) {
    if applicationproperties != nil {
        (^ApplicationPropertiesIF)(applicationproperties)->Release()
    }
}

ApplicationVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ApplicationVariablesVTable,
}

ApplicationVariablesVTable :: struct {
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

applicationvariables_serialize :: proc(application_variables: ApplicationVariables) -> (xml: string, ok: bool) {
    if application_variables == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

applicationvariables_description_get :: proc(application_variables: ApplicationVariables) -> (description: string, ok: bool) {
    if application_variables == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationvariables_description_set :: proc(application_variables: ApplicationVariables, description: string) -> (ok: bool) {
    if application_variables == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

applicationvariables_globals_get :: proc(application_variables: ApplicationVariables) -> (global_variables: GlobalVariables, ok: bool) {
    if application_variables == nil do return
    if !com_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesGet(cast(^rawptr)&global_variables)
    if com_failed(hr) do return

    return global_variables, true
}

applicationvariables_globals_set :: proc(application_variables: ApplicationVariables, global_variables: GlobalVariables) -> (ok: bool) {
    if application_variables == nil do return
    if global_variables == nil do return
    if !com_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesPut(global_variables)
    if com_failed(hr) do return

    return true
}

applicationvariables_variables_get :: proc(application_variables: ApplicationVariables) -> (variables: Variables, ok: bool) {
    if application_variables == nil do return
    if !com_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesGet(cast(^rawptr)&variables)
    if com_failed(hr) do return

    return variables, true
}

applicationvariables_variables_set :: proc(application_variables: ApplicationVariables, variables: Variables) -> (ok: bool) {
    if application_variables == nil do return
    if variables == nil do return
    if !com_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

applicationvariables_signals_get :: proc(application_variables: ApplicationVariables) -> (signals: Signals, ok: bool) {
    if application_variables == nil do return
    if !com_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsGet(cast(^rawptr)&signals)
    if com_failed(hr) do return

    return signals, true
}

applicationvariables_signals_set :: proc(application_variables: ApplicationVariables, signals: Signals) -> (ok: bool) {
    if application_variables == nil do return
    if signals == nil do return
    if !com_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

applicationvariables_release :: proc(application_variables: ApplicationVariables) {
    if application_variables != nil {
        (^ApplicationVariablesIF)(application_variables)->Release()
    }
}

ConnectedApplicationIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationVTable,
}

ConnectedApplicationVTable :: struct {
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

connectedapplication_name_get :: proc(ca: ConnectedApplication) -> (name: string, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplication_name_set :: proc(ca: ConnectedApplication, name: string) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedapplication_major_version_get :: proc(ca: ConnectedApplication) -> (major_version: i32, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedapplication_major_version_set :: proc(ca: ConnectedApplication, major_version: i32) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}

connectedapplication_minor_version_get :: proc(ca: ConnectedApplication) -> (minor_version: i32, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedapplication_minor_version_set :: proc(ca: ConnectedApplication, minor_version: i32) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedapplication_revision_get :: proc(ca: ConnectedApplication) -> (revision: i32, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedapplication_revision_set :: proc(ca: ConnectedApplication, revision: i32) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedapplication_guid_get :: proc(ca: ConnectedApplication) -> (guid: string, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplication_release :: proc(ca: ConnectedApplication) {
    if ca != nil {
        (^ConnectedApplicationIF)(ca)->Release()
    }
}

ConnectedApplicationsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationsVTable,
}

ConnectedApplicationsVTable :: struct {
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

connectedapplications_serialize :: proc(connectedapplications: ConnectedApplications) -> (xml: string, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplications_connectedapplication_add :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication) -> (ok: bool) {
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Add(connectedapplication)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_add_at_index :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication, index: i32) -> (ok: bool) {
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->AddBefore(connectedapplication, index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_by_name :: proc(connectedapplications: ConnectedApplications, name: string) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Find(bstr_name, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return

    return connectedapplication, true
}

connectedapplications_connectedapplication_by_index :: proc(connectedapplications: ConnectedApplications, index: i32) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Item(index + 1, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return

    return connectedapplication, true
}

connectedapplications_connectedapplication_index :: proc(connectedapplications: ConnectedApplications, name: string) -> (index: i32, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedapplications_connectedapplication_count :: proc(connectedapplications: ConnectedApplications) -> (count: i32, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedapplications_connectedapplication_remove_by_name :: proc(connectedapplications: ConnectedApplications, name: string) -> (ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    index: i32
    index, ok = connectedapplications_connectedapplication_index(connectedapplications, name)
    if !ok do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_remove_by_index :: proc(connectedapplications: ConnectedApplications, index: i32) -> (ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedapplications_release :: proc(connectedapplications: ConnectedApplications) {
    if connectedapplications != nil {
        (^ConnectedApplicationsIF)(connectedapplications)->Release()
    }
}
