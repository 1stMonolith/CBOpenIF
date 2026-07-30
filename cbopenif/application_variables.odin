package cbopenif

ApplicationVariables :: distinct rawptr

ApplicationVariablesIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ApplicationVariablesVTable,
}

ApplicationVariablesVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    GlobalVariablesGet: proc "system" (this: ^ApplicationVariablesIF, GlobalVariables: ^GlobalVariables) -> HResult,
    Missing8:           proc "system" (this: ^ApplicationVariablesIF) -> HResult,
    GlobalVariablesPut: proc "system" (this: ^ApplicationVariablesIF, GlobalVariables: GlobalVariables) -> HResult,
    VariablesGet:       proc "system" (this: ^ApplicationVariablesIF, Variables: ^Variables) -> HResult,
    Missing11:          proc "system" (this: ^ApplicationVariablesIF) -> HResult,
    VariablesPut:       proc "system" (this: ^ApplicationVariablesIF, Variables: Variables) -> HResult,
    DescriptionGet:     proc "system" (this: ^ApplicationVariablesIF, Description: ^BStr) -> HResult,
    DescriptionPut:     proc "system" (this: ^ApplicationVariablesIF, Description: BStr) -> HResult,
    Serialize:          proc "system" (this: ^ApplicationVariablesIF, XMLStr: ^BStr) -> HResult,
    SignalsGet:         proc "system" (this: ^ApplicationVariablesIF, Signals: ^Signals) -> HResult,
    Missing17:          proc "system" (this: ^ApplicationVariablesIF) -> HResult,
    SignalsPut:         proc "system" (this: ^ApplicationVariablesIF, Signals: Signals) -> HResult,
}

applicationvariables_new :: proc(description := "") -> (application_variables: ApplicationVariables, ok: bool) {
    application_variables = nil
    ok = false

    if !connected() do return
    
    bstr_description := string_to_bstr(description)
    SysFreeString(bstr_description)
    hr := factoryif->NewApplicationVariables(bstr_description, cast(^ApplicationVariables)&application_variables)
    if failed(hr) do return

    return application_variables, true
}

applicationvariables_deserialize :: proc(application_variables: ^ApplicationVariables, xml: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    
    bstr := string_to_bstr(xml)
    defer bstr_free(bstr)
    hr := factoryif->DeserializeApplicationVariables(&bstr, cast(^ApplicationVariables)application_variables)
    if failed(hr) do return
    
    return true
}

applicationvariables_serialize :: proc(application_variables: ApplicationVariables) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if application_variables == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ApplicationVariablesIF)(application_variables)->Serialize(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

applicationvariables_description :: proc {
    applicationvariables_description_,
    applicationvariables_description_set,
}

@(private)
applicationvariables_description_ :: proc(application_variables: ApplicationVariables) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if application_variables == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
applicationvariables_description_set :: proc(application_variables: ApplicationVariables, description: string) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    
    bstr := string_to_bstr(description)
    defer bstr_free(bstr)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionPut(bstr)
    if failed(hr) do return

    return true
}

applicationvariables_globals :: proc {
    applicationvariables_globals_,
    applicationvariables_globals_set,
}

@(private)
applicationvariables_globals_ :: proc(application_variables: ApplicationVariables) -> (global_variables: GlobalVariables, ok: bool) {
    global_variables = nil
    ok = false

    if application_variables == nil do return
    if !connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesGet(&global_variables)
    if failed(hr) do return

    return global_variables, true
}

@(private)
applicationvariables_globals_set :: proc(application_variables: ApplicationVariables, global_variables: GlobalVariables) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    if global_variables == nil do return
    if !connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesPut(global_variables)
    if failed(hr) do return

    return true
}

applicationvariables_variables :: proc {
    applicationvariables_variables_,
    applicationvariables_variables_set,
}

@(private)
applicationvariables_variables_ :: proc(application_variables: ApplicationVariables) -> (variables: Variables, ok: bool) {
    variables = nil
    ok = false

    if application_variables == nil do return
    if !connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesGet(&variables)
    if failed(hr) do return

    return variables, true
}

@(private)
applicationvariables_variables_set :: proc(application_variables: ApplicationVariables, variables: Variables) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    if variables == nil do return
    if !connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesPut(variables)
    if failed(hr) do return

    return true
}

applicationvariables_signals :: proc {
    applicationvariables_signals_,
    applicationvariables_signals_set,
}

@(private)
applicationvariables_signals_ :: proc(application_variables: ApplicationVariables) -> (signals: Signals, ok: bool) {
    signals = nil
    ok = false

    if application_variables == nil do return
    if !connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsGet(&signals)
    if failed(hr) do return

    return signals, true
}

@(private)
applicationvariables_signals_set :: proc(application_variables: ApplicationVariables, signals: Signals) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    if signals == nil do return
    if !connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsPut(signals)
    if failed(hr) do return

    return true
}

// --- ADD -------------------------------------

applicationvariables_globals_add :: proc {
    applicationvariables_globals_add_,
    applicationvariables_globals_add_at_index,
}

@(private)
applicationvariables_globals_add_ :: proc(application_variables: ApplicationVariables, global_variable: GlobalVariable) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    if global_variable == nil do return

    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return

    ok = globalvariables_add(global_variables, global_variable)
    if !ok do return

    return true
}

@(private)
applicationvariables_globals_add_at_index :: proc(application_variables: ApplicationVariables, global_variable: GlobalVariable, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    if global_variable == nil do return

    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return

    ok = globalvariables_add_at_index(global_variables, global_variable, index)
    if !ok do return

    return true
}

applicationvariables_variables_add :: proc {
    applicationvariables_variables_add_,
    applicationvariables_variables_add_at_index,
}

@(private)
applicationvariables_variables_add_ :: proc(application_variables: ApplicationVariables, variable: Variable) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    if variable == nil do return

    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return

    ok = variables_add(variables, variable)
    if !ok do return

    return true
}

@(private)
applicationvariables_variables_add_at_index :: proc(application_variables: ApplicationVariables, variable: Variable, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    if variable == nil do return

    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return

    ok = variables_add(variables, variable, index)
    if !ok do return

    return true
}

applicationvariables_signals_add :: proc {
    applicationvariables_signals_add_,
    applicationvariables_signals_add_at_index,
}

@(private)
applicationvariables_signals_add_ :: proc(application_variables: ApplicationVariables, signal: Signal) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    if signal == nil do return

    signals: Signals
    signals, ok = applicationvariables_signals(application_variables)
    if !ok do return

    ok = signals_add(signals, signal)
    if !ok do return

    return true
}

@(private)
applicationvariables_signals_add_at_index :: proc(application_variables: ApplicationVariables, signal: Signal, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    if signal == nil do return

    signals: Signals
    signals, ok = applicationvariables_signals(application_variables)
    if !ok do return

    ok = signals_add(signals, signal, index)
    if !ok do return

    return true
}

// --- BY_XX -----------------------------------

applicationvariables_global :: proc {
    applicationvariables_global_by_name,
    applicationvariables_global_by_index,
}

@(private)
applicationvariables_global_by_name :: proc(application_variables: ApplicationVariables, name: string, _: _As_GlobalVariable) -> (global_variable: GlobalVariable, ok: bool) {
    global_variable = nil
    ok = false

    if !connected() do return
    if application_variables == nil do return

    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    global_variable, ok = by_name(global_variables, name)
    if !ok do return
    
    return global_variable, true
}

@(private)
applicationvariables_global_by_index :: proc(application_variables: ApplicationVariables, index: i32, _: _As_GlobalVariable) -> (global_variable: GlobalVariable, ok: bool) {
    global_variable = nil
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    global_variable, ok = by_index(global_variables, index)
    if !ok do return
    
    return global_variable, true
}

applicationvariables_variable :: proc {
    applicationvariables_variable_by_name,
    applicationvariables_variable_by_index,
}

@(private)
applicationvariables_variable_by_name :: proc(application_variables: ApplicationVariables, name: string, _: _As_Variable) -> (variable: Variable, ok: bool) {
    variable = nil
    ok = false

    if !connected() do return
    if application_variables == nil do return

    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    variable, ok = variables_variable(variables, name)
    if !ok do return
    
    return variable, true
}

@(private)
applicationvariables_variable_by_index :: proc(application_variables: ApplicationVariables, index: i32, _: _As_Variable) -> (variable: Variable, ok: bool) {
    variable = nil
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    variable, ok = variables_variable(variables, index)
    if !ok do return
    
    return variable, true
}

applicationvariables_signal :: proc {
    applicationvariables_signal_by_name,
    applicationvariables_signal_by_index,
}

@(private)
applicationvariables_signal_by_name :: proc(application_variables: ApplicationVariables, name: string, _: _As_Signal) -> (signal: Signal, ok: bool) {
    signal = nil
    ok = false

    if !connected() do return
    if application_variables == nil do return

    signals: Signals
    signals, ok = applicationvariables_signals(application_variables)
    if !ok do return
    
    signal, ok = signals_signal(signals, name)
    if !ok do return
    
    return signal, true
}

@(private)
applicationvariables_signal_by_index :: proc(application_variables: ApplicationVariables, index: i32, _: _As_Signal) -> (signal: Signal, ok: bool) {
    signal = nil
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    signals: Signals
    signals, ok = applicationvariables_signals(application_variables)
    if !ok do return
    
    signal, ok = signals_signal(signals, index)
    if !ok do return
    
    return signal, true
}

// --- INDEX -----------------------------------

applicationvariables_index :: proc {
    applicationvariables_global_index,
    applicationvariables_variable_index,
    applicationvariables_signal_index,
}

applicationvariables_global_index :: proc(application_variables: ApplicationVariables, name: string, _: _As_GlobalVariable) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    index, ok = globalvariables_global_index(global_variables, name)
    if !ok do return
    
    return index, true
}

applicationvariables_variable_index :: proc(application_variables: ApplicationVariables, name: string, _: _As_Variable) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    index, ok = variables_variable_index(variables, name)
    if !ok do return
    
    return index, true
}

applicationvariables_signal_index :: proc(application_variables: ApplicationVariables, name: string, _: _As_Signal) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    signals: Signals
    signals, ok =applicationvariables_signals(application_variables)
    if !ok do return
    
    index, ok = signals_signal_index(signals, name)
    if !ok do return
    
    return index, true
}

// --- COUNT -----------------------------------

applicationvariables_cound :: proc {
    applicationvariables_global_count,
    applicationvariables_variable_count,
    applicationvariables_signal_count,
}

applicationvariables_global_count :: proc(application_variables: ApplicationVariables, _: _As_GlobalVariable) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    count, ok = globalvariables_count(global_variables)
    if !ok do return
    
    return count, true
}

applicationvariables_variable_count :: proc(application_variables: ApplicationVariables, _: _As_Variable) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    count, ok = variables_count(variables)
    if !ok do return
    
    return count, true
}

applicationvariables_signal_count :: proc(application_variables: ApplicationVariables, _: _As_Signal) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    signals: Signals
    signals, ok =applicationvariables_signals(application_variables)
    if !ok do return
    
    count, ok = signals_count(signals)
    if !ok do return
    
    return count, true
}

// --- REMOVE ----------------------------------

applicationvariables_remove :: proc {
    applicationvariables_global_remove_by_name_,
    applicationvariables_global_remove_by_index_,
    applicationvariables_variable_remove_by_name_,
    applicationvariables_variable_remove_by_index_,
    applicationvariables_signal_remove_by_name_,
    applicationvariables_signal_remove_by_index_,
}


applicationvariables_global_remove :: proc {
    applicationvariables_global_remove_by_name,
    applicationvariables_global_remove_by_index,
}
applicationvariables_global_remove_by_name_ :: proc(application_variables: ApplicationVariables, name: string, _: _As_GlobalVariable) -> (ok: bool) {
    return applicationvariables_global_remove_by_name(application_variables, name)
}

applicationvariables_global_remove_by_index_ :: proc(application_variables: ApplicationVariables, index: i32, _: _As_GlobalVariable) -> (ok: bool) {
    return applicationvariables_global_remove_by_index(application_variables, index)
}

@(private)
applicationvariables_global_remove_by_name :: proc(application_variables: ApplicationVariables, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return

    index: i32
    index, ok = globalvariables_global_index(global_variables, name)
    if !ok do return
    
    ok = globalvariables_remove(global_variables, index)
    if !ok do return
    
    return true
}

@(private)
applicationvariables_global_remove_by_index :: proc(application_variables: ApplicationVariables, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    ok = globalvariables_remove(global_variables, index)
    if !ok do return
    
    return true
}

applicationvariables_variable_remove :: proc {
    applicationvariables_variable_remove_by_name,
    applicationvariables_variable_remove_by_index,
}

applicationvariables_variable_remove_by_name_ :: proc(application_variables: ApplicationVariables, name: string, _: _As_Variable) -> (ok: bool) {
    return applicationvariables_variable_remove_by_name(application_variables, name)
}

applicationvariables_variable_remove_by_index_ :: proc(application_variables: ApplicationVariables, index: i32, _: _As_Variable) -> (ok: bool) {
    return applicationvariables_variable_remove_by_index(application_variables, index)
}

@(private)
applicationvariables_variable_remove_by_name :: proc(application_variables: ApplicationVariables, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return

    index: i32
    index, ok = variables_variable_index(variables, name)
    if !ok do return
    
    ok = variables_remove(variables, index)
    if !ok do return
    
    return true
}

@(private)
applicationvariables_variable_remove_by_index :: proc(application_variables: ApplicationVariables, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    ok = variables_remove(variables, index)
    if !ok do return
    
    return true
}

applicationvariables_signal_remove :: proc {
    applicationvariables_signal_remove_by_name,
    applicationvariables_signal_remove_by_index,
}

applicationvariables_signal_remove_by_name_ :: proc(application_variables: ApplicationVariables, name: string, _: _As_Signal) -> (ok: bool) {
    return applicationvariables_signal_remove_by_name(application_variables, name)
}

applicationvariables_signal_remove_by_index_ :: proc(application_variables: ApplicationVariables, index: i32, _: _As_Signal) -> (ok: bool) {
    return applicationvariables_signal_remove_by_index(application_variables, index)
}

@(private)
applicationvariables_signal_remove_by_name :: proc(application_variables: ApplicationVariables, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    signals: Signals
    signals, ok =applicationvariables_signals(application_variables)
    if !ok do return

    index: i32
    index, ok = signals_signal_index(signals, name)
    if !ok do return
    
    ok = signals_remove(signals, index)
    if !ok do return
    
    return true
}

@(private)
applicationvariables_signal_remove_by_index :: proc(application_variables: ApplicationVariables, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if application_variables == nil do return
    
    signals: Signals
    signals, ok =applicationvariables_signals(application_variables)
    if !ok do return
    
    ok = signals_remove(signals, index)
    if !ok do return
    
    return true
}

applicationvariables_release :: proc(application_variables: ApplicationVariables) {
    if application_variables != nil {
        (^ApplicationVariablesIF)(application_variables)->Release()
    }
}