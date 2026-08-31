package cbopenif

import "com"

DiagramType :: struct
{
    name:             string,
    description:      string,
    protected:        bool,
    hidden:           bool,
    scope:            Scope,
    guid:             string,
    reservedby:       string,
    sillevel:         string,
    silrestricted:    bool,
    alarmowner:       bool,
    batchobject:      string,
    aspectobject:     bool,
    simulation:       bool,
    graphicsvisible:  bool,
    parameters:       [dynamic]Parameter,
    variables:        [dynamic]Variable,
    commvariables:    [dynamic]Variable,
    codeblocks:       [dynamic]CodeBlock,
    functionblocks:   [dynamic]FunctionBlock,
    controlmodules:   [dynamic]ControlModule,
    diagraminstances: [dynamic]DiagramInstance,
}

Diagram :: struct
{
    name:               string,
    description:        string,
    accesslevel:        string,
    safetytype:         string,
    task:               string,
    simulation:         bool,
    sillevel:           string,
    silrestricted:      bool,
    batchobject:        string,
    instanceguid:       string,
    typeguid:           string,
    reservedby:         string,
    variables:          [dynamic]Variable,
    commvariables:      [dynamic]Variable,
    signals:            [dynamic]Signal,
    codeblocks:         [dynamic]CodeBlock,
    functionblocks:     [dynamic]FunctionBlock,
    controlmodules:     [dynamic]ControlModule,
    diagraminstances:   [dynamic]DiagramInstance,
    initvalues:         [dynamic]InitValue,
}

DiagramInstance :: struct
{
    name:             string,
    type:             string,
    description:      string,
    accesslevel:      string,
    safetytype:       string,
    aspectobject:     bool,
    exposeproperties: bool,
    guid:             string,
    typeguid:         string,
    typepath:         string,
}

DiagramTypeFromCom :: proc(comdiagramtype: com.DiagramType) -> (diagramtype: DiagramType, ok: bool)
{
    if comdiagramtype == nil do return

    diagramtype.name, ok = com.Name(comdiagramtype)
    if !ok do return

    diagramtype.description, ok = com.Description(comdiagramtype)
    if !ok do return

    diagramtype.protected, ok = com.Protected(comdiagramtype)
    if !ok do return

    diagramtype.hidden, ok = com.Hidden(comdiagramtype)
    if !ok do return

    scope: i32
    scope, ok = com.Scope(comdiagramtype)
    if !ok do return
    diagramtype.scope = Scope(scope)

    diagramtype.guid, ok = com.Guid(comdiagramtype)
    if !ok do return

    diagramtype.reservedby, ok = com.ReservedBy(comdiagramtype)
    if !ok do return

    diagramtype.sillevel, ok = com.SILLevel(comdiagramtype)
    if !ok do return

    diagramtype.silrestricted, ok = com.RestrictedSIL(comdiagramtype)
    if !ok do return

    diagramtype.alarmowner, ok = com.AlarmOwner(comdiagramtype)
    if !ok do return

    diagramtype.batchobject, ok = com.GetDiagramTypeBatchObject(comdiagramtype)
    if !ok do return

    diagramtype.aspectobject, ok = com.AspectObject(comdiagramtype)
    if !ok do return

    diagramtype.simulation, ok = com.SimulationMark(comdiagramtype)
    if !ok do return

    diagramtype.graphicsvisible, ok = com.GetDiagramTypeGraphicsVisible(comdiagramtype)
    if !ok do return

    comparameters: com.Parameters
    comparameters, ok = com.GetParameters(comdiagramtype)
    if !ok do return
    defer com.Release(comparameters)
    ok = ParametersFromCom(comparameters, &diagramtype.parameters)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comdiagramtype)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesFromCom(comvariables, &diagramtype.variables)
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comdiagramtype)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksFromCom(comcodeblocks, &diagramtype.codeblocks)
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comdiagramtype)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksFromCom(comfunctionblocks, &diagramtype.functionblocks)
    if !ok do return

    comcontrolmodules: com.ControlModules
    comcontrolmodules, ok = com.GetControlModules(comdiagramtype)
    if !ok do return
    defer com.Release(comcontrolmodules)
    ok = ControlModulesFromCom(comcontrolmodules, &diagramtype.controlmodules)
    if !ok do return

    comdiagraminstances: com.DiagramInstances
    comdiagraminstances, ok = com.GetDiagramInstances(comdiagramtype)
    if !ok do return
    defer com.Release(comdiagraminstances)
    ok = DiagramInstancesFromCom(comdiagraminstances, &diagramtype.diagraminstances)
    if !ok do return

    return diagramtype, true
}

DiagramTypeToCom :: proc(diagramtype: DiagramType) -> (comdiagramtype: com.DiagramType, ok: bool)
{
    comdiagramtype, ok = com.NewDiagramTypeEx(
        diagramtype.name,
        diagramtype.description,
        diagramtype.protected,
        diagramtype.hidden,
        i32(diagramtype.scope),
        diagramtype.alarmowner,
        diagramtype.guid,
    )
    if !ok do return
    defer if !ok do com.Release(comdiagramtype)

    ok = com.ReservedBy(comdiagramtype, diagramtype.reservedby)
    if !ok do return

    ok = com.SILLevel(comdiagramtype, diagramtype.sillevel)
    if !ok do return

    ok = com.RestrictedSIL(comdiagramtype, diagramtype.silrestricted)
    if !ok do return

    ok = com.SetDiagramTypeBatchObject(comdiagramtype, diagramtype.batchobject)
    if !ok do return

    ok = com.AspectObject(comdiagramtype, diagramtype.aspectobject)
    if !ok do return

    ok = com.SimulationMark(comdiagramtype, diagramtype.simulation)
    if !ok do return

    ok = com.SetDiagramTypeGraphicsVisible(comdiagramtype, diagramtype.graphicsvisible)
    if !ok do return

        comparameters: com.Parameters
        comparameters, ok = com.GetParameters(comdiagramtype)
        if !ok do return
        defer com.Release(comparameters)
        ok = ParametersToCom(comparameters, diagramtype.parameters[:])
        if !ok do return

        comvariables: com.Variables
        comvariables, ok = com.GetVariables(comdiagramtype)
        if !ok do return
        defer com.Release(comvariables)
        ok = VariablesToCom(comvariables, diagramtype.variables[:])
        if !ok do return

        cbs: com.CodeBlocks
        cbs, ok = com.GetCodeBlocks(comdiagramtype)
        if !ok do return
        defer com.Release(cbs)
        ok = CodeBlocksToCom(cbs, diagramtype.codeblocks[:])
        if !ok do return

        comfunctionblocks: com.FunctionBlocks
        comfunctionblocks, ok = com.GetFunctionBlocks(comdiagramtype)
        if !ok do return
        defer com.Release(comfunctionblocks)
        ok = FunctionBlocksToCom(comfunctionblocks, diagramtype.functionblocks[:])
        if !ok do return

        comcontrolmodules: com.ControlModules
        comcontrolmodules, ok = com.GetControlModules(comdiagramtype)
        if !ok do return
        defer com.Release(comcontrolmodules)
        ok = ControlModulesToCom(comcontrolmodules, diagramtype.controlmodules[:])
        if !ok do return

        comdiagraminstances: com.DiagramInstances
        comdiagraminstances, ok = com.GetDiagramInstances(comdiagramtype)
        if !ok do return
        defer com.Release(comdiagraminstances)
        ok = DiagramInstancesToCom(comdiagraminstances, diagramtype.diagraminstances[:])
        if !ok do return

    return comdiagramtype, true
}

DiagramFromCom :: proc(comdiagram: com.Diagram) -> (digram: Diagram, ok: bool)
{
    if comdiagram == nil do return

    digram.name, ok = com.Name(comdiagram)
    if !ok do return

    digram.description, ok = com.Description(comdiagram)
    if !ok do return

    digram.accesslevel, ok = com.AccessLevel(comdiagram)
    if !ok do return

    digram.safetytype, ok = com.SafetyType(comdiagram)
    if !ok do return

    digram.task, ok = com.TaskConnection(comdiagram)
    if !ok do return

    digram.simulation, ok = com.SimulationMark(comdiagram)
    if !ok do return

    digram.sillevel, ok = com.SILLevel(comdiagram)
    if !ok do return

    digram.silrestricted, ok = com.RestrictedSIL(comdiagram)
    if !ok do return

    digram.batchobject, ok = com.GetDiagramBatchObject(comdiagram)
    if !ok do return

    digram.instanceguid, ok = com.InstGuid(comdiagram)
    if !ok do return

    digram.typeguid, ok = com.TypeGuid(comdiagram)
    if !ok do return

    digram.reservedby, ok = com.ReservedBy(comdiagram)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comdiagram)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesFromCom(comvariables, &digram.variables)
    if !ok do return

    comcommvariables: com.CommVariables
    comcommvariables, ok = com.GetCommVariables(comdiagram)
    if !ok do return
    defer com.Release(comcommvariables)
    ok = CommVariablesFromCom(comcommvariables, &digram.commvariables)
    if !ok do return

    comsignals: com.Signals
    comsignals, ok = com.GetSignals(comdiagram)
    if !ok do return
    defer com.Release(comsignals)
    ok = SignalsFromCom(comsignals, &digram.signals)
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comdiagram)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksFromCom(comcodeblocks, &digram.codeblocks)
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comdiagram)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksFromCom(comfunctionblocks, &digram.functionblocks)
    if !ok do return

    comcontrolmodules: com.ControlModules
    comcontrolmodules, ok = com.GetControlModules(comdiagram)
    if !ok do return
    defer com.Release(comcontrolmodules)
    ok = ControlModulesFromCom(comcontrolmodules, &digram.controlmodules)
    if !ok do return

    comdiagraminstances: com.DiagramInstances
    comdiagraminstances, ok = com.GetDiagramInstances(comdiagram)
    if !ok do return
    defer com.Release(comdiagraminstances)
    ok = DiagramInstancesFromCom(comdiagraminstances, &digram.diagraminstances)
    if !ok do return

    cominitvalues: com.InitValues
    cominitvalues, ok = com.GetInitValues(comdiagram)
    if !ok do return
    defer com.Release(cominitvalues)
    ok = InitValuesFromCom(cominitvalues, &digram.initvalues)
    if !ok do return

    return digram, true
}

DiagramToCom :: proc(diagram: Diagram) -> (comdiagram: com.Diagram, ok: bool)
{
    comdiagram, ok = com.NewDiagramEx(
        diagram.name,
        diagram.description,
        diagram.task,
        diagram.typeguid,
        diagram.instanceguid,
    )
    if !ok do return
    defer if !ok do com.Release(comdiagram)

    ok = com.AccessLevel(comdiagram, diagram.accesslevel)
    if !ok do return

    ok = com.SafetyType(comdiagram, diagram.safetytype)
    if !ok do return

    ok = com.SimulationMark(comdiagram, diagram.simulation)
    if !ok do return

    ok = com.SILLevel(comdiagram, diagram.sillevel)
    if !ok do return

    ok = com.RestrictedSIL(comdiagram, diagram.silrestricted)
    if !ok do return

    ok = com.SetDiagramBatchObject(comdiagram, diagram.batchobject)
    if !ok do return

    ok = com.ReservedBy(comdiagram, diagram.reservedby)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comdiagram)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesToCom(comvariables, diagram.variables[:])
    if !ok do return

    comsignals: com.Signals
    comsignals, ok = com.GetSignals(comdiagram)
    if !ok do return
    defer com.Release(comsignals)
    ok = SignalsToCom(comsignals, diagram.signals[:])
    if !ok do return

    comcommvariables: com.CommVariables
    comcommvariables, ok = com.GetCommVariables(comdiagram)
    if !ok do return
    defer com.Release(comcommvariables)
    ok = CommVariablesToCom(comcommvariables, diagram.variables[:])
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comdiagram)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksToCom(comcodeblocks, diagram.codeblocks[:])
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comdiagram)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksToCom(comfunctionblocks, diagram.functionblocks[:])
    if !ok do return

    comcontrolmodules: com.ControlModules
    comcontrolmodules, ok = com.GetControlModules(comdiagram)
    if !ok do return
    defer com.Release(comcontrolmodules)
    ok = ControlModulesToCom(comcontrolmodules, diagram.controlmodules[:])
    if !ok do return

    comdiagraminstances: com.DiagramInstances
    comdiagraminstances, ok = com.GetDiagramInstances(comdiagram)
    if !ok do return
    defer com.Release(comdiagraminstances)
    ok = DiagramInstancesToCom(comdiagraminstances, diagram.diagraminstances[:])
    if !ok do return

    cominitvalues: com.InitValues
    cominitvalues, ok = com.GetInitValues(comdiagram)
    if !ok do return
    defer com.Release(cominitvalues)
    ok = InitValuesToCom(cominitvalues, diagram.initvalues[:])
    if !ok do return

    return comdiagram, true
}

DiagramInstancesFromCom :: proc(comdiagraminstances: com.DiagramInstances, instances: ^[dynamic]DiagramInstance) -> (ok: bool)
{
    if comdiagraminstances == nil do return

    count: i32
    count, ok = com.DiagramInstanceCount(comdiagraminstances)
    if !ok do return

    for i in 0..<count {
        comdiagraminstance: com.DiagramInstance
        comdiagraminstance, ok = com.GetDiagramInstance(comdiagraminstances, i)
        if !ok do return
        defer com.Release(comdiagraminstance)

        diagraminstance: DiagramInstance
        diagraminstance, ok = DiagramInstanceFromCom(comdiagraminstance)
        if !ok do return
        append(instances, diagraminstance)
    }

    return true
}

DiagramInstanceFromCom :: proc(comdiagraminstance: com.DiagramInstance) -> (digraminstance: DiagramInstance, ok: bool)
{
    if comdiagraminstance == nil do return

    digraminstance.name, ok = com.Name(comdiagraminstance)
    if !ok do return

    digraminstance.type, ok = com.TypeName(comdiagraminstance)
    if !ok do return

    digraminstance.description, ok = com.Description(comdiagraminstance)
    if !ok do return

    digraminstance.accesslevel, ok = com.AccessLevel(comdiagraminstance)
    if !ok do return

    digraminstance.safetytype, ok = com.SafetyType(comdiagraminstance)
    if !ok do return

    digraminstance.aspectobject, ok = com.AspectObject(comdiagraminstance)
    if !ok do return

    digraminstance.exposeproperties, ok = com.ExposeProperties(comdiagraminstance)
    if !ok do return

    digraminstance.guid, ok = com.Guid(comdiagraminstance)
    if !ok do return

    digraminstance.typeguid, ok = com.TypeGuid(comdiagraminstance)
    if !ok do return

    digraminstance.typepath, ok = com.TypePath(comdiagraminstance)
    if !ok do return

    return digraminstance, true
}

DiagramInstancesToCom :: proc(comdiagraminstances: com.DiagramInstances, instances: []DiagramInstance) -> (ok: bool)
{
    if comdiagraminstances == nil do return
    
    for instance in instances {
        comdiagraminstance: com.DiagramInstance
        comdiagraminstance, ok = DiagramInstanceToCom(instance)
        if !ok do return
        defer com.Release(comdiagraminstance)

        ok = com.AddDiagramInstance(comdiagraminstances, comdiagraminstance)
        if !ok do return
    }
    
    return true
}

DiagramInstanceToCom :: proc(di: DiagramInstance) -> (comdiagraminstance: com.DiagramInstance, ok: bool)
{
    comdiagraminstance, ok = com.NewDiagramInstanceEx(di.name, di.type, di.guid, di.description)
    if !ok do return
    defer if !ok do com.Release(comdiagraminstance)

    ok = com.AccessLevel(comdiagraminstance, di.accesslevel)
    if !ok do return

    ok = com.SafetyType(comdiagraminstance, di.safetytype)
    if !ok do return

    ok = com.AspectObject(comdiagraminstance, di.aspectobject)
    if !ok do return

    ok = com.ExposeProperties(comdiagraminstance, di.exposeproperties)
    if !ok do return

    // type_guid / type_path read-only

    return comdiagraminstance, true
}
