package cbopenif

import "com"

Program :: struct
{
    name:           string,
    description:    string,
    accesslevel:    string,
    safetytype:     string,
    task:           string,
    simulation:     bool,
    sillevel:       string,
    instanceguid:   string,
    guid:           string,
    reservedby:     string,
    variables:      [dynamic]Variable,
    signals:        [dynamic]Signal,
    codeblocks:     [dynamic]CodeBlock,
    functionblocks: [dynamic]FunctionBlock,
    initvalues:     [dynamic]InitValue,
}

ProgramFromCom :: proc(comprogram: com.Program) -> (program: Program, ok: bool)
{
    if comprogram == nil do return

    program.name, ok = com.Name(comprogram)
    if !ok do return

    program.description, ok = com.Description(comprogram)
    if !ok do return

    program.accesslevel, ok = com.AccessLevel(comprogram)
    if !ok do return

    program.safetytype, ok = com.SafetyType(comprogram)
    if !ok do return

    program.task, ok = com.TaskConnection(comprogram)
    if !ok do return

    program.simulation, ok = com.SimulationMark(comprogram)
    if !ok do return

    program.sillevel, ok = com.SILLevel(comprogram)
    if !ok do return
    
    program.instanceguid, ok = com.InstGuid(comprogram)
    if !ok do return

    program.guid, ok = com.TypeGuid(comprogram)
    if !ok do return

    program.reservedby, ok = com.ReservedBy(comprogram)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comprogram)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesFromCom(comvariables, &program.variables)
    if !ok do return

    comcommvariables: com.CommVariables
    comcommvariables, ok = com.GetCommVariables(comprogram)
    if !ok do return
    defer com.Release(comcommvariables)
    ok = CommVariablesFromCom(comcommvariables, &program.variables)
    if !ok do return

    comsignals: com.Signals
    comsignals, ok = com.GetSignals(comprogram)
    if !ok do return
    defer com.Release(comsignals)
    ok = SignalsFromCom(comsignals, &program.signals)
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comprogram)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksFromCom(comcodeblocks, &program.codeblocks)
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comprogram)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksFromCom(comfunctionblocks, &program.functionblocks)
    if !ok do return

    cominitvalues: com.InitValues
    cominitvalues, ok = com.GetInitValues(comprogram)
    if !ok do return
    defer com.Release(cominitvalues)
    ok = InitValuesFromCom(cominitvalues, &program.initvalues)
    if !ok do return

    return program, true
}

ProgramToCom :: proc(program: Program) -> (comprogram: com.Program, ok: bool)
{
    comprogram, ok = com.NewProgramEx(
        program.name,
        program.description,
        program.task,
        program.guid,
        program.instanceguid,
    )
    if !ok do return
    defer if !ok do com.Release(comprogram)

    ok = com.AccessLevel(comprogram, program.accesslevel)
    if !ok do return

    ok = com.SafetyType(comprogram, program.safetytype)
    if !ok do return

    ok = com.SimulationMark(comprogram, program.simulation)
    if !ok do return

    ok = com.SILLevel(comprogram, program.sillevel)
    if !ok do return

    ok = com.ReservedBy(comprogram, program.reservedby)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comprogram)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesToCom(comvariables, program.variables[:])
    if !ok do return

    comsignals: com.Signals
    comsignals, ok = com.GetSignals(comprogram)
    if !ok do return
    defer com.Release(comsignals)
    ok = SignalsToCom(comsignals, program.signals[:])
    if !ok do return

    comcommvariables: com.CommVariables
    comcommvariables, ok = com.GetCommVariables(comprogram)
    if !ok do return
    defer com.Release(comcommvariables)
    ok = CommVariablesToCom(comcommvariables, program.variables[:])
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comprogram)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksToCom(comcodeblocks, program.codeblocks[:])
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comprogram)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksToCom(comfunctionblocks, program.functionblocks[:])
    if !ok do return

    cominitvalues: com.InitValues
    cominitvalues, ok = com.GetInitValues(comprogram)
    if !ok do return
    defer com.Release(cominitvalues)
    ok = InitValuesToCom(cominitvalues, program.initvalues[:])
    if !ok do return

    return comprogram, true
}
