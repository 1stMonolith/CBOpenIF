package variable

import "../com"
import "../controlbuilder"
import "../bstr"

ApplicationVariablesIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ApplicationVariablesVTable,
}

ApplicationVariablesVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

applicationvariables_new :: proc(description := "") -> (application_variables: rawptr, ok: bool) {
    application_variables = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_description := bstr.from_string(description)
    bstr.free(bstr_description)
    hr := factoryif->NewApplicationVariables(bstr_description, cast(^rawptr)&application_variables)
    if com.failed(hr) do return

    return application_variables, true
}

applicationvariables_deserialize :: proc(application_variables: ^rawptr, xml: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(xml)
    defer bstr.free(bs)
    hr := factoryif->DeserializeApplicationVariables(&bs, cast(^rawptr)application_variables)
    if com.failed(hr) do return
    
    return true
}

applicationvariables_serialize :: proc(application_variables: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if application_variables == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->Serialize(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

applicationvariables_description :: proc {
    applicationvariables_description_,
    applicationvariables_description_set,
}

@(private)
applicationvariables_description_ :: proc(application_variables: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if application_variables == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
applicationvariables_description_set :: proc(application_variables: rawptr, description: string) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    
    bs := bstr.from_string(description)
    defer bstr.free(bs)
    hr := (^ApplicationVariablesIF)(application_variables)->DescriptionPut(bs)
    if com.failed(hr) do return

    return true
}

applicationvariables_globals :: proc {
    applicationvariables_globals_,
    applicationvariables_globals_set,
}

@(private)
applicationvariables_globals_ :: proc(application_variables: rawptr) -> (global_variables: rawptr, ok: bool) {
    global_variables = nil
    ok = false

    if application_variables == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesGet(&global_variables)
    if com.failed(hr) do return

    return global_variables, true
}

@(private)
applicationvariables_globals_set :: proc(application_variables: rawptr, global_variables: rawptr) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    if global_variables == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->GlobalVariablesPut(global_variables)
    if com.failed(hr) do return

    return true
}

applicationvariables_variables :: proc {
    applicationvariables_variables_,
    applicationvariables_variables_set,
}

@(private)
applicationvariables_variables_ :: proc(application_variables: rawptr) -> (variables: rawptr, ok: bool) {
    variables = nil
    ok = false

    if application_variables == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesGet(&variables)
    if com.failed(hr) do return

    return variables, true
}

@(private)
applicationvariables_variables_set :: proc(application_variables: rawptr, variables: rawptr) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    if variables == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->VariablesPut(variables)
    if com.failed(hr) do return

    return true
}

applicationvariables_signals :: proc {
    applicationvariables_signals_,
    applicationvariables_signals_set,
}

@(private)
applicationvariables_signals_ :: proc(application_variables: rawptr) -> (signals: rawptr, ok: bool) {
    signals = nil
    ok = false

    if application_variables == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsGet(&signals)
    if com.failed(hr) do return

    return signals, true
}

@(private)
applicationvariables_signals_set :: proc(application_variables: rawptr, signals: rawptr) -> (ok: bool) {
    ok = false

    if application_variables == nil do return
    if signals == nil do return
    if !controlbuilder.connected() do return
    
    hr := (^ApplicationVariablesIF)(application_variables)->SignalsPut(signals)
    if com.failed(hr) do return

    return true
}

// --- ADD -------------------------------------

applicationvariables_globals_add :: proc {
    applicationvariables_globals_add_,
    applicationvariables_globals_add_at_index,
}

@(private)
applicationvariables_globals_add_ :: proc(application_variables: rawptr, global_variable: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_globals_add_at_index :: proc(application_variables: rawptr, global_variable: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_variables_add_ :: proc(application_variables: rawptr, variable: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_variables_add_at_index :: proc(application_variables: rawptr, variable: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_signals_add_ :: proc(application_variables: rawptr, signal: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_signals_add_at_index :: proc(application_variables: rawptr, signal: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_global_by_name :: proc(application_variables: rawptr, name: string, _: _As_GlobalVariable) -> (global_variable: rawptr, ok: bool) {
    global_variable = nil
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return

    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    global_variable, ok = by_name(global_variables, name)
    if !ok do return
    
    return global_variable, true
}

@(private)
applicationvariables_global_by_index :: proc(application_variables: rawptr, index: i32, _: _As_GlobalVariable) -> (global_variable: rawptr, ok: bool) {
    global_variable = nil
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_variable_by_name :: proc(application_variables: rawptr, name: string, _: _As_Variable) -> (variable: rawptr, ok: bool) {
    variable = nil
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return

    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    variable, ok = variables_variable(variables, name)
    if !ok do return
    
    return variable, true
}

@(private)
applicationvariables_variable_by_index :: proc(application_variables: rawptr, index: i32, _: _As_Variable) -> (variable: rawptr, ok: bool) {
    variable = nil
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_signal_by_name :: proc(application_variables: rawptr, name: string, _: _As_Signal) -> (signal: rawptr, ok: bool) {
    signal = nil
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return

    signals: Signals
    signals, ok = applicationvariables_signals(application_variables)
    if !ok do return
    
    signal, ok = signals_signal(signals, name)
    if !ok do return
    
    return signal, true
}

@(private)
applicationvariables_signal_by_index :: proc(application_variables: rawptr, index: i32, _: _As_Signal) -> (signal: rawptr, ok: bool) {
    signal = nil
    ok = false

    if !controlbuilder.connected() do return
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

applicationvariables_global_index :: proc(application_variables: rawptr, name: string, _: _As_GlobalVariable) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    index, ok = globalvariables_global_index(global_variables, name)
    if !ok do return
    
    return index, true
}

applicationvariables_variable_index :: proc(application_variables: rawptr, name: string, _: _As_Variable) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    index, ok = variables_variable_index(variables, name)
    if !ok do return
    
    return index, true
}

applicationvariables_signal_index :: proc(application_variables: rawptr, name: string, _: _As_Signal) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
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

applicationvariables_global_count :: proc(application_variables: rawptr, _: _As_GlobalVariable) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return
    
    global_variables: GlobalVariables
    global_variables, ok = applicationvariables_globals(application_variables)
    if !ok do return
    
    count, ok = globalvariables_count(global_variables)
    if !ok do return
    
    return count, true
}

applicationvariables_variable_count :: proc(application_variables: rawptr, _: _As_Variable) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return
    
    variables: Variables
    variables, ok = applicationvariables_variables(application_variables)
    if !ok do return
    
    count, ok = variables_count(variables)
    if !ok do return
    
    return count, true
}

applicationvariables_signal_count :: proc(application_variables: rawptr, _: _As_Signal) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_global_remove_by_name_ :: proc(application_variables: rawptr, name: string, _: _As_GlobalVariable) -> (ok: bool) {
    return applicationvariables_global_remove_by_name(application_variables, name)
}

applicationvariables_global_remove_by_index_ :: proc(application_variables: rawptr, index: i32, _: _As_GlobalVariable) -> (ok: bool) {
    return applicationvariables_global_remove_by_index(application_variables, index)
}

@(private)
applicationvariables_global_remove_by_name :: proc(application_variables: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_global_remove_by_index :: proc(application_variables: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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

applicationvariables_variable_remove_by_name_ :: proc(application_variables: rawptr, name: string, _: _As_Variable) -> (ok: bool) {
    return applicationvariables_variable_remove_by_name(application_variables, name)
}

applicationvariables_variable_remove_by_index_ :: proc(application_variables: rawptr, index: i32, _: _As_Variable) -> (ok: bool) {
    return applicationvariables_variable_remove_by_index(application_variables, index)
}

@(private)
applicationvariables_variable_remove_by_name :: proc(application_variables: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_variable_remove_by_index :: proc(application_variables: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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

applicationvariables_signal_remove_by_name_ :: proc(application_variables: rawptr, name: string, _: _As_Signal) -> (ok: bool) {
    return applicationvariables_signal_remove_by_name(application_variables, name)
}

applicationvariables_signal_remove_by_index_ :: proc(application_variables: rawptr, index: i32, _: _As_Signal) -> (ok: bool) {
    return applicationvariables_signal_remove_by_index(application_variables, index)
}

@(private)
applicationvariables_signal_remove_by_name :: proc(application_variables: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
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
applicationvariables_signal_remove_by_index :: proc(application_variables: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if application_variables == nil do return
    
    signals: Signals
    signals, ok =applicationvariables_signals(application_variables)
    if !ok do return
    
    ok = signals_remove(signals, index)
    if !ok do return
    
    return true
}

applicationvariables_release :: proc(application_variables: rawptr) {
    if application_variables != nil {
        (^ApplicationVariablesIF)(application_variables)->Release()
    }
}