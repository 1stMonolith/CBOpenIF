package com

Program :: distinct rawptr

ProgramIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ProgramVTable,
}

ProgramVTable :: struct
{
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

SerializeProgram :: proc(program: Program) -> (xml: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetProgramName :: proc(program: Program) -> (name: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramName :: proc(program: Program, name: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramTaskConnection :: proc(program: Program) -> (task_connection: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->TaskConnectionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramTaskConnection :: proc(program: Program, task_connection: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(task_connection)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->TaskConnectionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramTypeGuid :: proc(program: Program) -> (type_guid: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->TypeGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramTypeGuid :: proc(program: Program, type_guid: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_guid)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->TypeGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramInstGuid :: proc(program: Program) -> (inst_guid: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->InstGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramInstGuid :: proc(program: Program, inst_guid: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(inst_guid)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->InstGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramDescription :: proc(program: Program) -> (description: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramDescription :: proc(program: Program, description: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramSILLevel :: proc(program: Program) -> (sil_level: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->SILLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramSILLevel :: proc(program: Program, sil_level: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(sil_level)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->SILLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramSimulationMark :: proc(program: Program) -> (simulation_mark: bool, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^ProgramIF)(program)->SimulationMarkGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetProgramSimulationMark :: proc(program: Program, simulation_mark: bool) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->SimulationMarkPut(ToVariantBool(simulation_mark))
    if ComFailed(hr) do return

    return true
}

GetProgramReservedBy :: proc(program: Program) -> (reserved_by_function: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramReservedBy :: proc(program: Program, reserved_by_function: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramVariables :: proc(program: Program) -> (variables: Variables, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->VariablesGet(&p)
    if ComFailed(hr) do return

    return Variables(p), true
}

SetProgramVariables :: proc(program: Program, variables: Variables) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->VariablesPut(variables)
    if ComFailed(hr) do return

    return true
}

GetProgramFunctionBlocks :: proc(program: Program) -> (functionblocks: FunctionBlocks, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->FunctionBlocksGet(&p)
    if ComFailed(hr) do return

    return FunctionBlocks(p), true
}

SetProgramFunctionBlocks :: proc(program: Program, functionblocks: FunctionBlocks) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->FunctionBlocksPut(functionblocks)
    if ComFailed(hr) do return

    return true
}

GetProgramCodeBlocks :: proc(program: Program) -> (codeblocks: CodeBlocks, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->CodeBlocksGet(&p)
    if ComFailed(hr) do return

    return CodeBlocks(p), true
}

SetProgramCodeBlocks :: proc(program: Program, codeblocks: CodeBlocks) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->CodeBlocksPut(codeblocks)
    if ComFailed(hr) do return

    return true
}

GetProgramAccessLevel :: proc(program: Program) -> (access_level: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->AccessLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramAccessLevel :: proc(program: Program, access_level: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->AccessLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramSafetyType :: proc(program: Program) -> (safety_type: string, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetProgramSafetyType :: proc(program: Program, safety_type: string) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^ProgramIF)(program)->SafetyTypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetProgramCommVariables :: proc(program: Program) -> (commvariables: CommVariables, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->CommVariablesGet(&p)
    if ComFailed(hr) do return

    return CommVariables(p), true
}

SetProgramCommVariables :: proc(program: Program, commvariables: CommVariables) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->CommVariablesPut(commvariables)
    if ComFailed(hr) do return

    return true
}

GetProgramInitValues :: proc(program: Program) -> (initvalues: InitValues, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->InitValuesGet(&p)
    if ComFailed(hr) do return

    return InitValues(p), true
}

SetProgramInitValues :: proc(program: Program, initvalues: InitValues) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->InitValuesPut(initvalues)
    if ComFailed(hr) do return

    return true
}

GetProgramSignals :: proc(program: Program) -> (signals: Signals, ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^ProgramIF)(program)->SignalsGet(&p)
    if ComFailed(hr) do return

    return Signals(p), true
}

SetProgramSignals :: proc(program: Program, signals: Signals) -> (ok: bool)
{
    if program == nil do return
    if !ComConnected() do return

    hr := (^ProgramIF)(program)->SignalsPut(signals)
    if ComFailed(hr) do return

    return true
}

ReleaseProgram :: proc(program: Program)
{
    if program != nil {
        (^ProgramIF)(program)->Release()
    }
}
