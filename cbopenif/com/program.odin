package com

import t "../types"

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

program_serialize :: proc(program: Program) -> (xml: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_name_get :: proc(program: Program) -> (name: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_name_set :: proc(program: Program, name: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

program_task_connection_get :: proc(program: Program) -> (task_connection: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_task_connection_set :: proc(program: Program, task_connection: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

program_type_guid_get :: proc(program: Program) -> (type_guid: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_type_guid_set :: proc(program: Program, type_guid: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

program_inst_guid_get :: proc(program: Program) -> (inst_guid: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->InstGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_inst_guid_set :: proc(program: Program, inst_guid: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(inst_guid)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->InstGuidPut(bs)
    if com_failed(hr) do return

    return true
}

program_description_get :: proc(program: Program) -> (description: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_description_set :: proc(program: Program, description: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

program_sil_level_get :: proc(program: Program) -> (sil_level: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_sil_level_set :: proc(program: Program, sil_level: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

program_simulation_mark_get :: proc(program: Program) -> (simulation_mark: bool, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^ProgramIF)(program)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

program_simulation_mark_set :: proc(program: Program, simulation_mark: bool) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

program_reserved_by_function_get :: proc(program: Program) -> (reserved_by_function: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_reserved_by_function_set :: proc(program: Program, reserved_by_function: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

program_variables_get :: proc(program: Program) -> (variables: Variables, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

program_variables_set :: proc(program: Program, variables: Variables) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

program_functionblocks_get :: proc(program: Program) -> (functionblocks: FunctionBlocks, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

program_functionblocks_set :: proc(program: Program, functionblocks: FunctionBlocks) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

program_codeblocks_get :: proc(program: Program) -> (codeblocks: CodeBlocks, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

program_codeblocks_set :: proc(program: Program, codeblocks: CodeBlocks) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

program_access_level_get :: proc(program: Program) -> (access_level: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_access_level_set :: proc(program: Program, access_level: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

program_safety_type_get :: proc(program: Program) -> (safety_type: string, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

program_safety_type_set :: proc(program: Program, safety_type: string) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ProgramIF)(program)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

program_commvariables_get :: proc(program: Program) -> (commvariables: CommVariables, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->CommVariablesGet(&p)
    if com_failed(hr) do return

    return CommVariables(p), true
}

program_commvariables_set :: proc(program: Program, commvariables: CommVariables) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->CommVariablesPut(commvariables)
    if com_failed(hr) do return

    return true
}

program_initvalues_get :: proc(program: Program) -> (initvalues: InitValues, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->InitValuesGet(&p)
    if com_failed(hr) do return

    return InitValues(p), true
}

program_initvalues_set :: proc(program: Program, initvalues: InitValues) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->InitValuesPut(initvalues)
    if com_failed(hr) do return

    return true
}

program_signals_get :: proc(program: Program) -> (signals: Signals, ok: bool) {
    if program == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->SignalsGet(&p)
    if com_failed(hr) do return

    return Signals(p), true
}

program_signals_set :: proc(program: Program, signals: Signals) -> (ok: bool) {
    if program == nil do return
    if !com_connected() do return

    hr := (^ProgramIF)(program)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

program_release :: proc(program: Program) {
    if program != nil {
        (^ProgramIF)(program)->Release()
    }
}

program_from_com :: proc(program: Program, allocator := context.allocator) -> (result: t.Program, ok: bool) {
    if program == nil do return
    context.allocator = allocator

    result.name, ok = name(program)
    if !ok do return
    result.description, ok = description(program)
    if !ok do return
    result.access_level, ok = access_level(program)
    if !ok do return
    result.safety_type, ok = safety_type(program)
    if !ok do return
    result.task_connection, ok = task_connection(program)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(program)
    if !ok do return
    result.sil_level, ok = sil_level(program)
    if !ok do return
    result.inst_guid, ok = inst_guid(program)
    if !ok do return
    result.type_guid, ok = type_guid(program)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(program)
    if !ok do return

    {
        c: Variables
        c, ok = variables(program)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(program)
        if !ok do return
        defer release(c)
        result.signals, ok = signals_from_com(c)
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(program)
        if !ok do return
        defer release(c)
        result.comm_variables, ok = commvariables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(program)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(program)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(program)
        if !ok do return
        defer release(c)
        result.init_values, ok = initvalues_from_com(c)
        if !ok do return
    }

    return result, true
}

program_to_com :: proc(src: t.Program) -> (result: Program, ok: bool) {
    program: Program
    program, ok = program_new1(
        src.name,
        src.description,
        src.task_connection,
        src.type_guid,
        src.inst_guid,
    )
    if !ok do return
    defer if !ok do release(program)

    ok = access_level(program, src.access_level)
    if !ok do return
    ok = safety_type(program, src.safety_type)
    if !ok do return
    ok = simulation_mark(program, src.simulation_mark)
    if !ok do return
    ok = sil_level(program, src.sil_level)
    if !ok do return
    ok = reserved_by_function(program, src.reserved_by_function)
    if !ok do return

    {
        c: Variables
        c, ok = variables(program)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(program)
        if !ok do return
        defer release(c)
        ok = signals_to_com(c, src.signals[:])
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(program)
        if !ok do return
        defer release(c)
        ok = commvariables_to_com(c, src.comm_variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(program)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(program)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(program)
        if !ok do return
        defer release(c)
        ok = initvalues_to_com(c, src.init_values[:])
        if !ok do return
    }

    return program, true
}
