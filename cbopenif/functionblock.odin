package cbopenif

import "com"

FunctionBlockType :: struct
{
    name:              string,
    description:       string,
    protected:         bool,
    hidden:            bool,
    scope:             Scope,
    guid:              string,
    reservedby:        string,
    sillevel:          string,
    silrestricted:     bool,
    alarmowner:        bool,
    interactionwindow: string,
    aspectobject:      bool,
    simulation:        bool,
    graphicsvisible:   bool,
    parameters:        [dynamic]Parameter,
    variables:         [dynamic]Variable,
    externalvariables: [dynamic]Variable,
    codeblocks:        [dynamic]CodeBlock,
    functionblocks:    [dynamic]FunctionBlock,
}

FunctionBlock :: struct
{
    name:             string,
    type:             string,
    description:      string,
    accesslevel:      string,
    safetytype:       string,
    aspectobject:     bool,
    exposeproperties: bool,
    task:             string,
    guid:             string,
    path:             string,
}

FunctionBlockTypeFromCom :: proc(comfunctionblocktype: com.FunctionBlockType) -> (functionblocktype: FunctionBlockType, ok: bool)
{
    if comfunctionblocktype == nil do return

    functionblocktype.name, ok = com.Name(comfunctionblocktype)
    if !ok do return

    functionblocktype.description, ok = com.Description(comfunctionblocktype)
    if !ok do return

    functionblocktype.protected, ok = com.Protected(comfunctionblocktype)
    if !ok do return

    functionblocktype.hidden, ok = com.Hidden(comfunctionblocktype)
    if !ok do return

    scope: i32
    scope, ok = com.Scope(comfunctionblocktype)
    if !ok do return
    functionblocktype.scope = Scope(scope)

    functionblocktype.guid, ok = com.Guid(comfunctionblocktype)
    if !ok do return

    functionblocktype.reservedby, ok = com.ReservedBy(comfunctionblocktype)
    if !ok do return

    functionblocktype.sillevel, ok = com.SILLevel(comfunctionblocktype)
    if !ok do return

    functionblocktype.silrestricted, ok = com.RestrictedSIL(comfunctionblocktype)
    if !ok do return

    functionblocktype.alarmowner, ok = com.AlarmOwner(comfunctionblocktype)
    if !ok do return

    functionblocktype.interactionwindow, ok = com.InteractionWindow(comfunctionblocktype)
    if !ok do return

    functionblocktype.aspectobject, ok = com.AspectObject(comfunctionblocktype)
    if !ok do return

    functionblocktype.simulation, ok = com.SimulationMark(comfunctionblocktype)
    if !ok do return

    functionblocktype.graphicsvisible, ok = com.GetFunctionBlockTypeGraphicsVisible(comfunctionblocktype)
    if !ok do return

    comparameters: com.Parameters
    comparameters, ok = com.GetParameters(comfunctionblocktype)
    if !ok do return
    defer com.Release(comparameters)
    ok = ParametersFromCom(comparameters, &functionblocktype.parameters)
    if !ok do return

    comextensibleparameters: com.ExtensibleParameters
    comextensibleparameters, ok = com.GetExtensibleParameters(comfunctionblocktype)
    if !ok do return
    defer com.Release(comextensibleparameters)
    ok = ExtensibleParametersFromCom(comextensibleparameters, &functionblocktype.parameters)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comfunctionblocktype)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesFromCom(comvariables, &functionblocktype.variables)
    if !ok do return

    comexternalvariables: com.ExternalVariables
    comexternalvariables, ok = com.GetExternalVariables(comfunctionblocktype)
    if !ok do return
    defer com.Release(comexternalvariables)
    ok = ExternalVariablesFromCom(comexternalvariables, &functionblocktype.externalvariables)
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comfunctionblocktype)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksFromCom(comcodeblocks, &functionblocktype.codeblocks)
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comfunctionblocktype)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksFromCom(comfunctionblocks, &functionblocktype.functionblocks)
    if !ok do return

    return functionblocktype, true
}

FunctionBlockTypeToCom :: proc(functionblocktype: FunctionBlockType) -> (comfunctionblocktype: com.FunctionBlockType, ok: bool)
{
    comfunctionblocktype, ok = com.NewFunctionBlockTypeEx(
        functionblocktype.name,
        functionblocktype.description,
        functionblocktype.protected,
        functionblocktype.hidden,
        i32(functionblocktype.scope),
        functionblocktype.interactionwindow,
        functionblocktype.alarmowner,
        functionblocktype.guid,
    )
    if !ok do return
    defer if !ok do com.Release(comfunctionblocktype)

    ok = com.ReservedBy(comfunctionblocktype, functionblocktype.reservedby)
    if !ok do return

    ok = com.SILLevel(comfunctionblocktype, functionblocktype.sillevel)
    if !ok do return

    ok = com.RestrictedSIL(comfunctionblocktype, functionblocktype.silrestricted)
    if !ok do return

    ok = com.AspectObject(comfunctionblocktype, functionblocktype.aspectobject)
    if !ok do return

    ok = com.SimulationMark(comfunctionblocktype, functionblocktype.simulation)
    if !ok do return

    ok = com.SetFunctionBlockTypeGraphicsVisible(comfunctionblocktype, functionblocktype.graphicsvisible)
    if !ok do return

    comparameters: com.Parameters
    comparameters, ok = com.GetParameters(comfunctionblocktype)
    if !ok do return
    defer com.Release(comparameters)
    ok = ParametersToCom(comparameters, functionblocktype.parameters[:])
    if !ok do return

    comextensibleparameters: com.ExtensibleParameters
    comextensibleparameters, ok = com.GetExtensibleParameters(comfunctionblocktype)
    if !ok do return
    defer com.Release(comextensibleparameters)
    ok = ExtensibleParametersToCom(comextensibleparameters, functionblocktype.parameters[:])
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comfunctionblocktype)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesToCom(comvariables, functionblocktype.variables[:])
    if !ok do return

    comexternalvariables: com.ExternalVariables
    comexternalvariables, ok = com.GetExternalVariables(comfunctionblocktype)
    if !ok do return
    defer com.Release(comexternalvariables)
    ok = ExternalVariablesToCom(comexternalvariables, functionblocktype.externalvariables[:])
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comfunctionblocktype)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksToCom(comcodeblocks, functionblocktype.codeblocks[:])
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comfunctionblocktype)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksToCom(comfunctionblocks, functionblocktype.functionblocks[:])
    if !ok do return

    return comfunctionblocktype, true
}

FunctionBlocksFromCom :: proc(comfunctionblocks: com.FunctionBlocks, functionblocks: ^[dynamic]FunctionBlock) -> (ok: bool)
{
    if comfunctionblocks == nil do return

    count: i32
    count, ok = com.FunctionBlockCount(comfunctionblocks)
    if !ok do return

    for i in 0..<count {
        comfunctionblock: com.FunctionBlock
        comfunctionblock, ok = com.GetFunctionBlockAtIndex(comfunctionblocks, i)
        if !ok do return
        defer com.Release(comfunctionblock)

        functionblock: FunctionBlock
        functionblock, ok = FunctionBlockFromCom(comfunctionblock)
        if !ok do return
        append(functionblocks, functionblock)
    }
    
    return true
}

FunctionBlockFromCom :: proc(comfunctionblock: com.FunctionBlock) -> (functionblock: FunctionBlock, ok: bool)
{
    if comfunctionblock == nil do return

    functionblock.name, ok = com.Name(comfunctionblock)
    if !ok do return

    functionblock.type, ok = com.TypeName(comfunctionblock)
    if !ok do return

    functionblock.description, ok = com.Description(comfunctionblock)
    if !ok do return

    functionblock.accesslevel, ok = com.AccessLevel(comfunctionblock)
    if !ok do return

    functionblock.safetytype, ok = com.SafetyType(comfunctionblock)
    if !ok do return

    functionblock.aspectobject, ok = com.AspectObject(comfunctionblock)
    if !ok do return

    functionblock.exposeproperties, ok = com.ExposeProperties(comfunctionblock)
    if !ok do return

    functionblock.task, ok = com.TaskConnection(comfunctionblock)
    if !ok do return

    functionblock.guid, ok = com.TypeGuid(comfunctionblock)
    if !ok do return

    functionblock.path, ok = com.TypePath(comfunctionblock)
    if !ok do return

    return functionblock, true
}

FunctionBlocksToCom :: proc(comfunctionblocks: com.FunctionBlocks, functionblocks: []FunctionBlock) -> (ok: bool)
{
    if comfunctionblocks == nil do return

    for functionblock in functionblocks {
        comfunctionblock: com.FunctionBlock
        comfunctionblock, ok = FunctionBlockToCom(functionblock)
        if !ok do return
        defer com.Release(comfunctionblock)

        ok = com.AddFunctionBlock(comfunctionblocks, comfunctionblock)
        if !ok do return
    }
    return true
}

FunctionBlockToCom :: proc(functionblock: FunctionBlock) -> (comfunctionblock: com.FunctionBlock, ok: bool)
{
    comfunctionblock, ok = com.NewFunctionBlockEx(functionblock.name, functionblock.type, functionblock.task, "", functionblock.description)
    if !ok do return
    defer if !ok do com.Release(comfunctionblock)

    ok = com.AccessLevel(comfunctionblock, functionblock.accesslevel)
    if !ok do return

    ok = com.SafetyType(comfunctionblock, functionblock.safetytype)
    if !ok do return

    ok = com.AspectObject(comfunctionblock, functionblock.aspectobject)
    if !ok do return

    ok = com.ExposeProperties(comfunctionblock, functionblock.exposeproperties)
    if !ok do return
    
    // type_guid / type_path read-only

    return comfunctionblock, true
}
