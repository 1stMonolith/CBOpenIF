package com

import t "../types"

ApplicationProperties :: distinct rawptr
ApplicationVariables  :: distinct rawptr

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

applicationproperties_from_com :: proc(ap: ApplicationProperties, allocator := context.allocator) -> (result: t.ApplicationProperties, ok: bool) {
    if ap == nil do return

    context.allocator = allocator

    result.sil_level, ok = sil_level(ap)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(ap)
    if !ok do return
    result.application_type, ok = application_type(ap)
    if !ok do return

    return result, true
}

applicationproperties_to_com :: proc(src: t.ApplicationProperties) -> (result: ApplicationProperties, ok: bool) {
    ap: ApplicationProperties
    ap, ok = applicationproperties_new(src.sil_level, src.simulation_mark)
    if !ok do return

    // application_type is get-only

    return ap, true
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

applicationvariables_from_com :: proc(av: ApplicationVariables, allocator := context.allocator) -> (result: t.ApplicationVariables, ok: bool) {
    if av == nil do return

    context.allocator = allocator

    result.description, ok = description(av)
    if !ok do return

    {
        gvars: GlobalVariables
        gvars, ok = globalvariables(av)
        if !ok do return
        defer release(gvars)
        result.globals, ok = globalvariables_from_com(gvars)
        if !ok do return
    }
    {
        vars: Variables
        vars, ok = variables(av)
        if !ok do return
        defer release(vars)
        result.variables, ok = variables_from_com(vars)
        if !ok do return
    }
    {
        sigs: Signals
        sigs, ok = signals(av)
        if !ok do return
        defer release(sigs)
        result.signals, ok = signals_from_com(sigs)
        if !ok do return
    }

    return result, true
}

applicationvariables_to_com :: proc(src: t.ApplicationVariables) -> (result: ApplicationVariables, ok: bool) {
    av: ApplicationVariables
    av, ok = applicationvariables_new(src.description)
    if !ok do return
    defer if !ok do release(av)

    {
        gvars: GlobalVariables
        gvars, ok = globalvariables(av)
        if !ok do return
        defer release(gvars)
        ok = globalvariables_to_com(gvars, src.globals[:])
        if !ok do return
    }
    {
        vars: Variables
        vars, ok = variables(av)
        if !ok do return
        defer release(vars)
        ok = variables_to_com(vars, src.variables[:])
        if !ok do return
    }
    {
        sigs: Signals
        sigs, ok = signals(av)
        if !ok do return
        defer release(sigs)
        ok = signals_to_com(sigs, src.signals[:])
        if !ok do return
    }

    return av, true
}
