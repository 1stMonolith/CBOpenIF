package cbopenif

ApplicationVariables :: distinct rawptr

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

applicationvariables_new :: proc(description := "") -> (application_variables: ApplicationVariables, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_description := to_bstr(description)
    bstr_free(bstr_description)
    hr := factoryif->NewApplicationVariables(bstr_description, cast(^rawptr)&application_variables)
    if com_failed(hr) do return

    return application_variables, true
}

applicationvariables_deserialize :: proc(application_variables: ^ApplicationVariables, xml: string) -> (ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeApplicationVariables(&bs, cast(^rawptr)application_variables)
    if com_failed(hr) do return
    
    return true
}

applicationvariables_serialize :: proc(application_variables: ApplicationVariables) -> (xml: string, ok: bool) {
    if application_variables == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

applicationvariables_description :: proc {
    applicationvariables_description_get,
    applicationvariables_description_set,
}

applicationvariables_description_get :: proc(application_variables: ApplicationVariables) -> (description: string, ok: bool) {
    if application_variables == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationvariables_description_set :: proc(application_variables: ApplicationVariables, description: string) -> (ok: bool) {
    if application_variables == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

applicationvariables_globals :: proc {
    applicationvariables_globals_get,
    applicationvariables_globals_set,
}

applicationvariables_globals_get :: proc(application_variables: ApplicationVariables) -> (global_variables: GlobalVariables, ok: bool) {
    if application_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesGet(cast(^rawptr)&global_variables)
    if com_failed(hr) do return

    return global_variables, true
}

applicationvariables_globals_set :: proc(application_variables: ApplicationVariables, global_variables: GlobalVariables) -> (ok: bool) {
    if application_variables == nil do return
    if global_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesPut(global_variables)
    if com_failed(hr) do return

    return true
}

applicationvariables_variables :: proc {
    applicationvariables_variables_get,
    applicationvariables_variables_set,
}

applicationvariables_variables_get :: proc(application_variables: ApplicationVariables) -> (variables: Variables, ok: bool) {
    if application_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesGet(cast(^rawptr)&variables)
    if com_failed(hr) do return

    return variables, true
}

applicationvariables_variables_set :: proc(application_variables: ApplicationVariables, variables: Variables) -> (ok: bool) {
    if application_variables == nil do return
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

applicationvariables_signals :: proc {
    applicationvariables_signals_get,
    applicationvariables_signals_set,
}

applicationvariables_signals_get :: proc(application_variables: ApplicationVariables) -> (signals: Signals, ok: bool) {
    if application_variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsGet(cast(^rawptr)&signals)
    if com_failed(hr) do return

    return signals, true
}

applicationvariables_signals_set :: proc(application_variables: ApplicationVariables, signals: Signals) -> (ok: bool) {
    if application_variables == nil do return
    if signals == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

applicationvariables_release :: proc(application_variables: ApplicationVariables) {
    if application_variables != nil {
        (^ApplicationVariablesIF)(application_variables)->Release()
    }
}

// TODO: procedures to interact with global vars, vars, and singals same as was done with compoents in DataType? Too much?
