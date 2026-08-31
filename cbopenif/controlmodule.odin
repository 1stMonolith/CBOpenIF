package cbopenif

import "core:strings"
import "core:fmt"

import "com"

ControlModuleKind :: enum i32
{
    ControlModule       = 0,
    SingleControlModule = 1,
}

ControlModuleType :: struct
{
    name:               string,
    description:        string,
    protected:          bool,
    hidden:             bool,
    scope:              Scope,
    guid:               string,
    reservedby:         string,
    sillevel:           string,
    silrestricted:      bool,
    alarmowner:         bool,
    batchobject:        string,
    interactionwindow:  string,
    aspectobject:       bool,
    simulation:         bool,
    graphicsvisible:    bool,
    graphics:           string,
    graphsize:          GraphSize,
    parameters:         [dynamic]Parameter,
    variables:          [dynamic]Variable,
    externalvariables:  [dynamic]Variable,
    codeblocks:         [dynamic]CodeBlock,
    functionblocks:     [dynamic]FunctionBlock,
    controlmodules:     [dynamic]ControlModule,
}

ControlModule :: struct
{
    kind:               ControlModuleKind,
    name:               string,
    type:               string,
    description:        string,
    accesslevel:        string,
    safetytype:         string,
    guid:               string,
    instanceguid:       string,
    aspectobject:       bool,
    exposeproperties:   bool,
    task:               string,
    graphics:           string,
    graphicsvisibility: GraphicsVisibility,
    //graphpos:           GraphPos,
    typeguid:           string,
    typepath:           string,
    connections:        [dynamic]CMConnection,
}

CMConnection :: struct
{
    name:       string,
    parameter:  string,
    connection: bool,
    
    // TODO: not important for now
    //points:               [dynamic]Point,
}

NewControlModuleType :: proc (library_name: string, controlmoduletype: ControlModuleType) -> (ok: bool)
{
    comcontrolmoduletype: com.ControlModuleType
    comcontrolmoduletype, ok = ControlModuleTypeToCom(controlmoduletype)
    defer com.Release(comcontrolmoduletype)

    xml: string
    xml, ok = com.Serialize(comcontrolmoduletype)

    msg: string
    msg, ok = com.NewControlModuleTypeFromXML(controlmoduletype.name, library_name, xml)

    if len(controlmoduletype.controlmodules) > 0 {
        for controlmodule in controlmoduletype.controlmodules {
            if controlmodule.task != "" {
                _ = com.SetTaskConnection(
                    strings.concatenate({library_name, ".", controlmoduletype.name, ".", controlmodule.name}),
                    controlmodule.task,
                )
            }
        }
    }

    return true
}

GetControlModuleType :: proc (library_name, controlmoduletype_name: string) -> (controlmoduletype: ControlModuleType, ok: bool)
{
    path := strings.concatenate({library_name, ".", controlmoduletype_name})
    defer delete(path)

    xml: string
    xml, ok = com.GetControlModuleTypeAsXML(path)

    comcontrolmoduletype: com.ControlModuleType
    comcontrolmoduletype, ok = com.DeserializeControlModuleType(xml)
    defer com.Release(comcontrolmoduletype)

    controlmoduletype, ok = ControlModuleTypeFromCom(comcontrolmoduletype)

    return controlmoduletype, true
}

AddControlModuleType :: proc (application_name, controlmodule_name, controlmodule_type: string) -> (ok: bool)
{
    controlmodulesxml: string
    controlmodulesxml, ok = com.GetApplicationControlModulesAsXML(application_name)

    comcontrolmodules: com.ControlModules
    comcontrolmodules, ok = com.DeserializeControlModules(controlmodulesxml)
    defer com.Release(comcontrolmodules)

    comcontrolmodule: com.ControlModule
    comcontrolmodule, ok = com.AddControlModule(comcontrolmodules, controlmodule_name, controlmodule_type)
    defer com.Release(comcontrolmodule)

    controlmodulesxml, ok = com.Serialize(comcontrolmodules)

    msg: string
    msg, ok = com.SetApplicationControlModulesFromXML(application_name, controlmodulesxml)

    return true
}

ControlModulesFromCom :: proc(comcontrolmodules: com.ControlModules, controlmodules: ^[dynamic]ControlModule) -> (ok: bool)
{
    if comcontrolmodules == nil do return

    count: i32
    count, ok = com.ControlModuleCount(comcontrolmodules)
    if !ok do return

    for i in 0..<count {
        comicontrolmodule: com.IControlModule
        comicontrolmodule, ok = com.GetIControlModuleByIndex(comcontrolmodules, i)
        if !ok do return
        defer com.Release(comicontrolmodule)
        
        is_single: bool
        is_single, ok = com.IsSingleControlModule(comicontrolmodule)
        if !ok do return

        controlmodule: ControlModule
        if is_single {
            comsinglecontrolmodule: com.SingleControlModule
            comsinglecontrolmodule, ok = com.AsSingleControlModule(comicontrolmodule)
            if !ok do return
            defer com.Release(comsinglecontrolmodule)

            controlmodule, ok = SingleControlModuleFromCom(comsinglecontrolmodule)
            if !ok do return
            append(controlmodules, controlmodule)
        } else {
            comcontrolmodule: com.ControlModule
            comcontrolmodule, ok = com.AsControlModule(comicontrolmodule)
            if !ok do return
            defer com.Release(comcontrolmodule)

            controlmodule, ok = ControlModuleFromCom(comcontrolmodule)
            if !ok do return
            append(controlmodules, controlmodule)
        }
    }

    return false
}

ControlModuleFromCom :: proc(comcontrolmodule: com.ControlModule) -> (controlmodule: ControlModule, ok: bool)
{
    if comcontrolmodule == nil do return

    controlmodule.name, ok = com.Name(comcontrolmodule)
    if !ok do return

    controlmodule.type, ok = com.TypeName(comcontrolmodule)
    if !ok do return

    controlmodule.description, ok = com.Description(comcontrolmodule)
    if !ok do return

    controlmodule.accesslevel, ok = com.AccessLevel(comcontrolmodule)
    if !ok do return

    controlmodule.safetytype, ok = com.SafetyType(comcontrolmodule)
    if !ok do return

    controlmodule.aspectobject, ok = com.AspectObject(comcontrolmodule)
    if !ok do return

    controlmodule.exposeproperties, ok = com.ExposeProperties(comcontrolmodule)
    if !ok do return

    controlmodule.task, ok = com.TaskConnection(comcontrolmodule)
    if !ok do return

    controlmodule.graphics, ok = com.InstanceGraphics(comcontrolmodule)
    if !ok do return

    graphicsvisibility: i32
    graphicsvisibility, ok = com.GetControlModuleGraphicsVisibility(comcontrolmodule)
    if !ok do return
    controlmodule.graphicsvisibility = GraphicsVisibility(graphicsvisibility)

    controlmodule.typeguid, ok = com.TypeGuid(comcontrolmodule)
    if !ok do return

    controlmodule.typepath, ok = com.TypePath(comcontrolmodule)
    if !ok do return

    // TODO: not important for now
    //comgraphpos: com.GraphPos
    //comgraphpos, ok = com.graphpos(comcontrolmodule)
    //if !ok do return
    //defer com.Release(comgraphpos)
    //controlmodule.graphpos, ok = GraphPosFromCom(comgraphpos)
    //if !ok do return

    comcmconnections: com.CMConnections
    comcmconnections, ok = com.GetCMConnections(comcontrolmodule)
    if !ok do return
    defer com.Release(comcmconnections)
    ok = CMConnectionsFromCom(comcmconnections, &controlmodule.connections)
    if !ok do return

    return controlmodule, true
}

ControlModulesToCom :: proc(comcontrolmodules: com.ControlModules, controlmodules: []ControlModule) -> (ok: bool)
{
    if comcontrolmodules == nil do return

    for controlmodule in controlmodules {
        switch controlmodule.kind {
            case .ControlModule:
                comcontrolmodule: com.ControlModule
                comcontrolmodule, ok = com.AddControlModule(
                    comcontrolmodules,
                    controlmodule.name,
                    controlmodule.type,
                )
                if !ok do return
                defer com.Release(comcontrolmodule)

                ok = ControlModuleToCom(comcontrolmodule, controlmodule)
            
            case .SingleControlModule:
                comsinglecontrolmodule: com.SingleControlModule
                comsinglecontrolmodule, ok = com.AddSingleControlModule(
                    comcontrolmodules,
                    controlmodule.name,
                )
                if !ok do return
                defer com.Release(comsinglecontrolmodule)

                ok = SingleControlModuleToCom(comsinglecontrolmodule, controlmodule)
        }
    }

    return true
}

ControlModuleToCom :: proc(comcontrolmodule: com.ControlModule, controlmodule: ControlModule) -> (ok: bool)
{
    if comcontrolmodule == nil do return

    ok = com.TaskConnection(comcontrolmodule, controlmodule.task)
    if !ok do return

    ok = com.AccessLevel(comcontrolmodule, controlmodule.accesslevel)
    if !ok do return

    ok = com.SafetyType(comcontrolmodule, controlmodule.safetytype)
    if !ok do return

    ok = com.AspectObject(comcontrolmodule, controlmodule.aspectobject)
    if !ok do return

    ok = com.ExposeProperties(comcontrolmodule, controlmodule.exposeproperties)
    if !ok do return

    ok = com.InstanceGraphics(comcontrolmodule, controlmodule.graphics)
    if !ok do return

    ok = com.SetControlModuleGraphicsVisibility(comcontrolmodule, i32(controlmodule.graphicsvisibility))
    if !ok do return

    if controlmodule.description != "" {
        ok = com.Description(comcontrolmodule, controlmodule.description)
        if !ok do return
    }

    if controlmodule.guid != "" {
        ok = com.Guid(comcontrolmodule, controlmodule.guid)
        if !ok do return
    }

    comcmconnections: com.CMConnections
    comcmconnections, ok = com.GetCMConnections(comcontrolmodule)
    if !ok do return
    defer com.Release(comcmconnections)

    ok = CMConnectionsToCom(comcmconnections, controlmodule.connections[:])
    if !ok do return

    return true
}

ControlModuleTypeFromCom :: proc(comcontrolmoduletype: com.ControlModuleType) -> (controlmoduletype: ControlModuleType, ok: bool)
{
    if comcontrolmoduletype == nil do return

    controlmoduletype.name, ok = com.Name(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.description, ok = com.Description(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.protected, ok = com.Protected(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.hidden, ok = com.Hidden(comcontrolmoduletype)
    if !ok do return

    scope: i32
    scope, ok = com.Scope(comcontrolmoduletype)
    if !ok do return
    controlmoduletype.scope = Scope(scope)

    controlmoduletype.guid, ok = com.Guid(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.reservedby, ok = com.ReservedBy(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.sillevel, ok = com.SILLevel(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.silrestricted, ok = com.RestrictedSIL(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.alarmowner, ok = com.AlarmOwner(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.batchobject, ok = com.GetControlModuleTypeBatchObject(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.interactionwindow, ok = com.InteractionWindow(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.aspectobject, ok = com.AspectObject(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.simulation, ok = com.SimulationMark(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.graphicsvisible, ok = com.GraphicsVisible(comcontrolmoduletype)
    if !ok do return

    controlmoduletype.graphics, ok = com.GetControlModuleTypeCMGraphics(comcontrolmoduletype)
    if !ok do return

    // TODO: not important for now
    //comgraphsize: com.GraphSize
    //comgraphsize, ok = com.graphsize(comcontrolmoduletype)
    //if !ok do return
    //defer com.Release(comgraphsize)
    //controlmoduletype.graphsize, ok = GraphSizeFromCom(comgraphsize)
    //if !ok do return

    comcmparameters: com.CMParameters
    comcmparameters, ok = com.GetCMParameters(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comcmparameters)
    ok = CMParametersFromCom(comcmparameters, &controlmoduletype.parameters)
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesFromCom(comvariables, &controlmoduletype.variables)
    if !ok do return

    comexternalvariables: com.ExternalVariables
    comexternalvariables, ok = com.GetExternalVariables(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comexternalvariables)
    ok = ExternalVariablesFromCom(comexternalvariables, &controlmoduletype.externalvariables)
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksFromCom(comcodeblocks, &controlmoduletype.codeblocks)
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksFromCom(comfunctionblocks, &controlmoduletype.functionblocks)
    if !ok do return

    comcontrolmodules: com.ControlModules
    comcontrolmodules, ok = com.GetControlModules(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comcontrolmodules)
    ok = ControlModulesFromCom(comcontrolmodules, &controlmoduletype.controlmodules)
    if !ok do return

    return controlmoduletype, true
}

ControlModuleTypeToCom :: proc(controlmoduletype: ControlModuleType) -> (comcontrolmoduletype: com.ControlModuleType, ok: bool)
{
    comgraphsize: com.GraphSize
    comgraphsize, ok = GraphSizeToCom(controlmoduletype.graphsize)
    if !ok do return
    defer com.Release(comgraphsize)

    comcontrolmoduletype, ok = com.NewControlModuleTypeEx(
        controlmoduletype.name,
        controlmoduletype.description,
        controlmoduletype.protected,
        controlmoduletype.hidden,
        i32(controlmoduletype.scope),
        controlmoduletype.interactionwindow,
        controlmoduletype.alarmowner,
        controlmoduletype.guid,
        comgraphsize,
    )
    if !ok do return
    defer if !ok do com.Release(comcontrolmoduletype)

    ok = com.ReservedBy(comcontrolmoduletype, controlmoduletype.reservedby)
    if !ok do return

    if controlmoduletype.sillevel == "" {
        ok = com.SILLevel(comcontrolmoduletype, "NonSIL")
    } else {
        ok = com.SILLevel(comcontrolmoduletype, controlmoduletype.sillevel)
    }
    if !ok do return

    ok = com.RestrictedSIL(comcontrolmoduletype, controlmoduletype.silrestricted)
    if !ok do return

    ok = com.BatchObject(comcontrolmoduletype, controlmoduletype.batchobject)
    if !ok do return

    ok = com.AspectObject(comcontrolmoduletype, controlmoduletype.aspectobject)
    if !ok do return

    ok = com.SimulationMark(comcontrolmoduletype, controlmoduletype.simulation)
    if !ok do return

    ok = com.GraphicsVisible(comcontrolmoduletype, controlmoduletype.graphicsvisible)
    if !ok do return

    ok = com.SetControlModuleTypeCMGraphics(comcontrolmoduletype, controlmoduletype.graphics)
    if !ok do return

    comcmparameters: com.CMParameters
    comcmparameters, ok = com.GetCMParameters(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comcmparameters)
    ok = CMParametersToCom(comcmparameters, controlmoduletype.parameters[:])
    if !ok do return

    comvariables: com.Variables
    comvariables, ok = com.GetVariables(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comvariables)
    ok = VariablesToCom(comvariables, controlmoduletype.variables[:])
    if !ok do return

    comexternalvariables: com.ExternalVariables
    comexternalvariables, ok = com.GetExternalVariables(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comexternalvariables)
    ok = ExternalVariablesToCom(comexternalvariables, controlmoduletype.externalvariables[:])
    if !ok do return

    comcodeblocks: com.CodeBlocks
    comcodeblocks, ok = com.GetCodeBlocks(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comcodeblocks)
    ok = CodeBlocksToCom(comcodeblocks, controlmoduletype.codeblocks[:])
    if !ok do return

    comfunctionblocks: com.FunctionBlocks
    comfunctionblocks, ok = com.GetFunctionBlocks(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comfunctionblocks)
    ok = FunctionBlocksToCom(comfunctionblocks, controlmoduletype.functionblocks[:])
    if !ok do return

    comcontrolmodules: com.ControlModules
    comcontrolmodules, ok = com.GetControlModules(comcontrolmoduletype)
    if !ok do return
    defer com.Release(comcontrolmodules)
    ok = ControlModulesToCom(comcontrolmodules, controlmoduletype.controlmodules[:])
    if !ok do return

    return comcontrolmoduletype, true
}

SingleControlModuleFromCom :: proc(comsinglecontrolmodule: com.SingleControlModule) -> (controlmodule: ControlModule, ok: bool)
{
    if comsinglecontrolmodule == nil do return

    controlmodule.name, ok = com.Name(comsinglecontrolmodule)
    if !ok do return

    controlmodule.description, ok = com.Description(comsinglecontrolmodule)
    if !ok do return

    controlmodule.accesslevel, ok = com.AccessLevel(comsinglecontrolmodule)
    if !ok do return

    controlmodule.safetytype, ok = com.SafetyType(comsinglecontrolmodule)
    if !ok do return

    controlmodule.task, ok = com.TaskConnection(comsinglecontrolmodule)
    if !ok do return

    controlmodule.graphics, ok = com.InstanceGraphics(comsinglecontrolmodule)
    if !ok do return

    graphicsvisibility: i32
    graphicsvisibility, ok = com.GetSingleControlModuleGraphicsVisibility(comsinglecontrolmodule)
    if !ok do return
    controlmodule.graphicsvisibility = GraphicsVisibility(graphicsvisibility)

    controlmodule.instanceguid, ok = com.InstGuid(comsinglecontrolmodule)
    if !ok do return

    controlmodule.typeguid, ok = com.TypeGuid(comsinglecontrolmodule)
    if !ok do return

    // TODO: not important for now
    //comgraphpos: com.GraphPos
    //comgraphpos, ok = com.graphpos(comsinglecontrolmodule)
    //if !ok do return
    //defer com.Release(comgraphpos)
    //controlmodule.graphpos, ok = GraphPosFromCom(comgraphpos)
    //if !ok do return

    comcmconnections: com.CMConnections
    comcmconnections, ok = com.GetCMConnections(comsinglecontrolmodule)
    if !ok do return
    defer com.Release(comcmconnections)
    ok = CMConnectionsFromCom(comcmconnections, &controlmodule.connections)
    if !ok do return

    return controlmodule, true
}

SingleControlModuleToCom :: proc(comsingle: com.SingleControlModule, controlmodule: ControlModule) -> (ok: bool)
{
    if comsingle == nil do return

    ok = com.TaskConnection(comsingle, controlmodule.task)
    if !ok do return

    ok = com.Description(comsingle, controlmodule.description)
    if !ok do return

    ok = com.AccessLevel(comsingle, controlmodule.accesslevel)
    if !ok do return

    ok = com.SafetyType(comsingle, controlmodule.safetytype)
    if !ok do return

    ok = com.InstanceGraphics(comsingle, controlmodule.graphics)
    if !ok do return

    ok = com.SetSingleControlModuleGraphicsVisibility(comsingle, i32(controlmodule.graphicsvisibility))
    if !ok do return

    comcmconnections: com.CMConnections
    comcmconnections, ok = com.GetCMConnections(comsingle)
    if !ok do return
    defer com.Release(comcmconnections)

    ok = CMConnectionsToCom(comcmconnections, controlmodule.connections[:])
    if !ok do return

    return true
}

CMConnectionsFromCom :: proc(comcmconnections: com.CMConnections, connections: ^[dynamic]CMConnection) -> (ok: bool)
{
    if comcmconnections == nil do return

    count: i32
    count, ok = com.CMConnectionCount(comcmconnections)
    if !ok do return

    for i in 0..<count {
        comcmconnection: com.CMConnection
        comcmconnection, ok = com.GetCMConnection(comcmconnections, i)
        if !ok do return
        defer com.Release(comcmconnection)

        cmconnection: CMConnection
        cmconnection, ok = CMConnectionFromCom(comcmconnection)
        if !ok do return
        append(connections, cmconnection)
    }

    return true
}

CMConnectionFromCom :: proc(comcmconnection: com.CMConnection) -> (cmconnection: CMConnection, ok: bool)
{
    if comcmconnection == nil do return

    cmconnection.name, ok = com.Name(comcmconnection)
    if !ok do return
    
    cmconnection.parameter, ok = com.ActualParameter(comcmconnection)
    if !ok do return

    cmconnection.connection, ok = com.GraphicalConnection(comcmconnection)
    if !ok do return

    // TODO: not important for now
    //compoints: com.Points
    //compoints, ok = com.points(comcmconnection)
    //if !ok do return
    //defer com.Release(compoints)

    //ok = PointsFromCom(compoints, &cmconnection.points)
    //if !ok do return

    return cmconnection, true
}

CMConnectionsToCom :: proc(comcmconnections: com.CMConnections, cmconnections: []CMConnection) -> (ok: bool)
{
    if comcmconnections == nil do return

    for cmconnection in cmconnections {
        comcmconnection: com.CMConnection
        comcmconnection, ok = CMConnectionToCom(cmconnection)
        if !ok do return
        defer com.Release(comcmconnection)

        ok = com.AddCMConnection(comcmconnections, comcmconnection)
        if !ok do return
    }

    return true
}

CMConnectionToCom :: proc(cmconnection: CMConnection) -> (comcmconnection: com.CMConnection, ok: bool)
{
    comcmconnection, ok = com.NewCMConnectionEx(
        cmconnection.name,
        cmconnection.parameter,
        cmconnection.connection,
    )
    if !ok do return
    
    // TODO: not important for now
    //compoints: com.Points
    //compoints, ok = com.points(comcmconnection)
    //if !ok do return
    //defer com.Release(compoints)

    //ok = PointsToCom(compoints, comcmconnection.points[:])
    //if !ok do return

    return comcmconnection, true
}
