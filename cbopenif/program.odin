package cbopenif

Program :: distinct rawptr

ProgramIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ProgramVTable,
}

ProgramVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^ProgramIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^ProgramIF, Name: BStr) -> HResult,
    TaskConnectionGet:     proc "system" (this: ^ProgramIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:     proc "system" (this: ^ProgramIF, TaskConnection: BStr) -> HResult,
    TypeGuidGet:           proc "system" (this: ^ProgramIF, TypeGuid: ^BStr) -> HResult,
    TypeGuidPut:           proc "system" (this: ^ProgramIF, TypeGuid: BStr) -> HResult,
    InstGuidGet:           proc "system" (this: ^ProgramIF, InstGuid: ^BStr) -> HResult,
    InstGuidPut:           proc "system" (this: ^ProgramIF, InstGuid: BStr) -> HResult,
    DescriptionGet:        proc "system" (this: ^ProgramIF, Description: ^BStr) -> HResult,
    DescriptionPut:        proc "system" (this: ^ProgramIF, Description: BStr) -> HResult,
    SILLevelGet:           proc "system" (this: ^ProgramIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:           proc "system" (this: ^ProgramIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet:     proc "system" (this: ^ProgramIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:     proc "system" (this: ^ProgramIF, SimulationMark: VariantBool) -> HResult,
    ReservedByFunctionGet: proc "system" (this: ^ProgramIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut: proc "system" (this: ^ProgramIF, ReservedByFunction: BStr) -> HResult,
    VariablesGet:          proc "system" (this: ^ProgramIF, Variables: ^rawptr) -> HResult,
    Missing24:             proc "system" (this: ^ProgramIF) -> HResult,
    VariablesPut:          proc "system" (this: ^ProgramIF, Variables: rawptr) -> HResult,
    FunctionBlocksGet:     proc "system" (this: ^ProgramIF, FunctionBlocks: ^rawptr) -> HResult,
    Missing27:             proc "system" (this: ^ProgramIF) -> HResult,
    FunctionBlocksPut:     proc "system" (this: ^ProgramIF, FunctionBlocks: rawptr) -> HResult,
    CodeBlocksGet:         proc "system" (this: ^ProgramIF, CodeBlocks: ^rawptr) -> HResult,
    Missing30:             proc "system" (this: ^ProgramIF) -> HResult,
    CodeBlocksPut:         proc "system" (this: ^ProgramIF, CodeBlocks: rawptr) -> HResult,
    Serialize:             proc "system" (this: ^ProgramIF, XML: ^BStr) -> HResult,
    AccessLevelGet:        proc "system" (this: ^ProgramIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:        proc "system" (this: ^ProgramIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:         proc "system" (this: ^ProgramIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:         proc "system" (this: ^ProgramIF, SafetyType: BStr) -> HResult,
    CommVariablesGet:      proc "system" (this: ^ProgramIF, CommVariables: ^rawptr) -> HResult,
    Missing38:             proc "system" (this: ^ProgramIF) -> HResult,
    CommVariablesPut:      proc "system" (this: ^ProgramIF, CommVariables: rawptr) -> HResult,
    InitValuesGet:         proc "system" (this: ^ProgramIF, InitValues: ^rawptr) -> HResult,
    Missing41:             proc "system" (this: ^ProgramIF) -> HResult,
    InitValuesPut:         proc "system" (this: ^ProgramIF, InitValues: rawptr) -> HResult,
    SignalsGet:            proc "system" (this: ^ProgramIF, Signals: ^rawptr) -> HResult,
    Missing44:             proc "system" (this: ^ProgramIF) -> HResult,
    SignalsPut:            proc "system" (this: ^ProgramIF, Signals: rawptr) -> HResult,
}

program_new :: proc(name: string, description := "") -> (program: Program, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewProgram(bstr_name, bstr_description, cast(^rawptr)&program)
    if com_failed(hr) do return

    return program, true
}

program_deserialize :: proc(xml: string) -> (program: Program, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeProgram(&bs, cast(^rawptr)&program)
    if com_failed(hr) do return

    return program, true
}

program_serialize :: proc(program: Program) -> (xml: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_name :: proc {
    program_name_get,
    program_name_set,
}

program_name_get :: proc(program: Program) -> (name: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_name_set :: proc(program: Program, name: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

program_task_connection :: proc {
    program_task_connection_get,
    program_task_connection_set,
}

program_task_connection_get :: proc(program: Program) -> (task_connection: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_task_connection_set :: proc(program: Program, task_connection: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

program_type_guid :: proc {
    program_type_guid_get,
    program_type_guid_set,
}

program_type_guid_get :: proc(program: Program) -> (type_guid: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_type_guid_set :: proc(program: Program, type_guid: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

program_inst_guid :: proc {
    program_inst_guid_get,
    program_inst_guid_set,
}

program_inst_guid_get :: proc(program: Program) -> (inst_guid: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->InstGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_inst_guid_set :: proc(program: Program, inst_guid: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(inst_guid)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->InstGuidPut(bs)
    if com_failed(hr) do return

    return true
}

program_description :: proc {
    program_description_get,
    program_description_set,
}

program_description_get :: proc(program: Program) -> (description: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_description_set :: proc(program: Program, description: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

program_sil_level :: proc {
    program_sil_level_get,
    program_sil_level_set,
}

program_sil_level_get :: proc(program: Program) -> (sil_level: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_sil_level_set :: proc(program: Program, sil_level: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

program_simulation_mark :: proc {
    program_simulation_mark_get,
    program_simulation_mark_set,
}

program_simulation_mark_get :: proc(program: Program) -> (simulation_mark: bool, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^ProgramIF)(program)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

program_simulation_mark_set :: proc(program: Program, simulation_mark: bool) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

program_reserved_by_function :: proc {
    program_reserved_by_function_get,
    program_reserved_by_function_set,
}

program_reserved_by_function_get :: proc(program: Program) -> (reserved_by_function: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_reserved_by_function_set :: proc(program: Program, reserved_by_function: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

program_variables :: proc {
    program_variables_get,
    program_variables_set,
}

program_variables_get :: proc(program: Program) -> (variables: Variables, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

program_variables_set :: proc(program: Program, variables: Variables) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

program_functionblocks :: proc {
    program_functionblocks_get,
    program_functionblocks_set,
}

program_functionblocks_get :: proc(program: Program) -> (functionblocks: FunctionBlocks, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

program_functionblocks_set :: proc(program: Program, functionblocks: FunctionBlocks) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

program_codeblocks :: proc {
    program_codeblocks_get,
    program_codeblocks_set,
}

program_codeblocks_get :: proc(program: Program) -> (codeblocks: CodeBlocks, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

program_codeblocks_set :: proc(program: Program, codeblocks: CodeBlocks) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

program_access_level :: proc {
    program_access_level_get,
    program_access_level_set,
}

program_access_level_get :: proc(program: Program) -> (access_level: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_access_level_set :: proc(program: Program, access_level: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

program_safety_type :: proc {
    program_safety_type_get,
    program_safety_type_set,
}

program_safety_type_get :: proc(program: Program) -> (safety_type: string, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_safety_type_set :: proc(program: Program, safety_type: string) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

program_commvariables :: proc {
    program_commvariables_get,
    program_commvariables_set,
}

program_commvariables_get :: proc(program: Program) -> (commvariables: CommVariables, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->CommVariablesGet(&p)
    if com_failed(hr) do return

    return CommVariables(p), true
}

program_commvariables_set :: proc(program: Program, commvariables: CommVariables) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->CommVariablesPut(commvariables)
    if com_failed(hr) do return

    return true
}

program_initvalues :: proc {
    program_initvalues_get,
    program_initvalues_set,
}

program_initvalues_get :: proc(program: Program) -> (initvalues: InitValues, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->InitValuesGet(&p)
    if com_failed(hr) do return

    return InitValues(p), true
}

program_initvalues_set :: proc(program: Program, initvalues: InitValues) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->InitValuesPut(initvalues)
    if com_failed(hr) do return

    return true
}

program_signals :: proc {
    program_signals_get,
    program_signals_set,
}

program_signals_get :: proc(program: Program) -> (signals: Signals, ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->SignalsGet(&p)
    if com_failed(hr) do return

    return Signals(p), true
}

program_signals_set :: proc(program: Program, signals: Signals) -> (ok: bool) {
    if program == nil do return
    if !controlbuilder_connected() do return

    hr := (^ProgramIF)(program)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

program_release :: proc(program: Program) {
    if program != nil {
        (^ProgramIF)(program)->Release()
    }
}
