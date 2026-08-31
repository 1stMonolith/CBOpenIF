package cbopenif

import "com"

Parameter :: struct
{
    name:                string,
    type:                string,
    direction:           Direction,
    attribute:           string,
    initialvalue:        string,
    description:         string,
    readpermission:      string,
    writepermission:     string,
    authenticationlevel: string,
    accesslevel:         string,
    safetytype:          string,
    fdport:              string,
    typeguid:            string,
    typepath:            string,
    batchproperty:       string,

    // TODO: not importnat for now
    //autopoint:         AutoPoint,
    //graphnodes:        [dynamic]GraphNode,
}

ParameterSetting :: struct
{
    name:        string,
    description: string,
    value:       string,
}

ParametersFromCom :: proc(comparameters: com.Parameters, parameters: ^[dynamic]Parameter) -> (ok: bool)
{
    if comparameters == nil do return

    count: i32
    count, ok = com.ParameterCount(comparameters)
    if !ok do return

    for i in 0..<count {
        comparameter: com.Parameter
        comparameter, ok = com.GetParameter(comparameters, i)
        if !ok do return
        defer com.Release(comparameter)

        parameter: Parameter
        parameter, ok = ParameterFromCom(comparameter)
        if !ok do return
        append(parameters, parameter)
    }
    return true
}

ParameterFromCom :: proc(comparameter: com.Parameter) -> (parameter: Parameter, ok: bool)
{
    if comparameter == nil do return

    parameter.name, ok = com.Name(comparameter)
    if !ok do return

    parameter.type, ok = com.TypeName(comparameter)
    if !ok do return

    parameter.attribute, ok = com.Attribute(comparameter)
    if !ok do return

    direction: i32
    direction, ok = com.Direction(comparameter)
    if !ok do return
    parameter.direction = Direction(direction)

    parameter.initialvalue, ok = com.GetParameterInitialValue(comparameter)
    if !ok do return

    parameter.description, ok = com.Description(comparameter)
    if !ok do return

    parameter.readpermission, ok = com.ReadPermission(comparameter)
    if !ok do return

    parameter.writepermission, ok = com.WritePermission(comparameter)
    if !ok do return

    parameter.authenticationlevel, ok = com.AuthenticationLevel(comparameter)
    if !ok do return

    parameter.accesslevel, ok = com.AccessLevel(comparameter)
    if !ok do return

    parameter.safetytype, ok = com.SafetyType(comparameter)
    if !ok do return

    parameter.fdport, ok = com.FDPort(comparameter)
    if !ok do return

    parameter.typeguid, ok = com.TypeGuid(comparameter)
    if !ok do return

    parameter.typepath, ok = com.TypePath(comparameter)
    if !ok do return

    return parameter, true
}

ParametersToCom :: proc(comparameters: com.Parameters, parameters: []Parameter) -> (ok: bool)
{
    if comparameters == nil do return
    
    for parameter in parameters {
        comparameter: com.Parameter
        comparameter, ok = ParameterToCom(parameter)
        if !ok do return
        defer com.Release(comparameter)

        ok = com.AddParameter(comparameters, comparameter)
        if !ok do return
    }
    return true
}

ParameterToCom :: proc(parameter: Parameter) -> (comparameter: com.Parameter, ok: bool)
{
    comparameter, ok = com.NewParameterEx(
        parameter.name,
        parameter.type,
        parameter.attribute,
        i32(parameter.direction),
        parameter.initialvalue,
        parameter.readpermission,
        parameter.writepermission,
        parameter.description,
    )
    if !ok do return
    defer if !ok do com.Release(comparameter)

    if parameter.authenticationlevel != "" {
        ok = com.AuthenticationLevel(comparameter, parameter.authenticationlevel)
        if !ok do return
    }

    ok = com.AccessLevel(comparameter, parameter.accesslevel)
    if !ok do return

    ok = com.SafetyType(comparameter, parameter.safetytype)
    if !ok do return

    ok = com.FDPort(comparameter, parameter.fdport)
    if !ok do return

    // type_guid / type_path are read-only

    return comparameter, true
}

ParameterSettingsFromCom :: proc(comparametersettings: com.ParameterSettings, settings: ^[dynamic]ParameterSetting) -> (ok: bool)
{
    if comparametersettings == nil do return

    count: i32
    count, ok = com.ParameterSettingCount(comparametersettings)
    if !ok do return

    for i in 0..<count {
        comparametersetting: com.ParameterSetting
        comparametersetting, ok = com.GetParameterSetting(comparametersettings, i)
        if !ok do return
        defer com.Release(comparametersetting)

        parametersetting: ParameterSetting
        parametersetting, ok = ParameterSettingFromCom(comparametersetting)
        if !ok do return
        append(settings, parametersetting)
    }

    return true
}

ParameterSettingFromCom :: proc(comparametersetting: com.ParameterSetting) -> (parametersetting: ParameterSetting, ok: bool)
{
    if comparametersetting == nil do return

    parametersetting.name, ok = com.Name(comparametersetting)
    if !ok do return

    parametersetting.value, ok = com.Value(comparametersetting)
    if !ok do return

    parametersetting.description, ok = com.Description(comparametersetting)
    if !ok do return

    return parametersetting, true
}

ParameterSettingsToCom :: proc(comparametersettings: com.ParameterSettings, settings: []ParameterSetting) -> (ok: bool)
{
    if comparametersettings == nil do return
    
    for setting in settings {
        parametersetting: com.ParameterSetting
        parametersetting, ok = ParameterSettingToCom(setting)
        if !ok do return
        defer com.Release(parametersetting)

        ok = com.AddParameterSetting(comparametersettings, parametersetting)
        if !ok do return
    }
    return true
}

ParameterSettingToCom :: proc(parametersetting: ParameterSetting) -> (comparametersetting: com.ParameterSetting, ok: bool)
{
    return com.NewParameterSetting(parametersetting.name, parametersetting.value)
}

ExtensibleParametersFromCom :: proc(comextensibleparameters: com.ExtensibleParameters, parameters: ^[dynamic]Parameter) -> (ok: bool)
{
    if comextensibleparameters == nil do return

    count: i32
    count, ok = com.ExtensibleParameterCount(comextensibleparameters)
    if !ok do return

    for i in 0..<count {
        comextensibleparameter: com.ExtensibleParameter
        comextensibleparameter, ok = com.GetExtensibleParameter(comextensibleparameters, i)
        if !ok do return
        defer com.Release(comextensibleparameter)

        parameter: Parameter
        parameter, ok = ExtensibleParameterFromCom(comextensibleparameter)
        if !ok do return
        append(parameters, parameter)
    }
    return true
}

ExtensibleParameterFromCom :: proc(comextensibleparameter: com.ExtensibleParameter) -> (parameter: Parameter, ok: bool)
{
    if comextensibleparameter == nil do return

    parameter.name, ok = com.Name(comextensibleparameter)
    if !ok do return

    parameter.type, ok = com.TypeName(comextensibleparameter)
    if !ok do return

    parameter.attribute, ok = com.Attribute(comextensibleparameter)
    if !ok do return

    direction: i32
    direction, ok = com.Direction(comextensibleparameter)
    if !ok do return
    parameter.direction = Direction(direction)

    parameter.initialvalue, ok = com.GetExtensibleParameterInitialValue(comextensibleparameter)
    if !ok do return
    
    parameter.description, ok = com.Description(comextensibleparameter)
    if !ok do return

    parameter.accesslevel, ok = com.AccessLevel(comextensibleparameter)
    if !ok do return

    parameter.safetytype, ok = com.SafetyType(comextensibleparameter)
    if !ok do return

    parameter.fdport, ok = com.FDPort(comextensibleparameter)
    if !ok do return

    parameter.typeguid, ok = com.TypeGuid(comextensibleparameter)
    if !ok do return

    parameter.typepath, ok = com.TypePath(comextensibleparameter)
    if !ok do return

    return parameter, true
}

ExtensibleParametersToCom :: proc(comextensibleparameters: com.ExtensibleParameters, parameters: []Parameter) -> (ok: bool)
{
    if comextensibleparameters == nil do return
    
    for parameter in parameters {
        comextensibleparameter: com.ExtensibleParameter
        comextensibleparameter, ok = ExtensibleParameterToCom(parameter)
        if !ok do return
        defer com.Release(comextensibleparameter)

        ok = com.AddExtensibleParameter(comextensibleparameters, comextensibleparameter)
        if !ok do return
    }
    
    return true
}

ExtensibleParameterToCom :: proc(parameter: Parameter) -> (comextensibleparameter: com.ExtensibleParameter, ok: bool)
{
    comextensibleparameter, ok = com.NewExtensibleParameterEx(
        parameter.name,
        parameter.type,
        parameter.attribute,
        i32(parameter.direction),
        parameter.initialvalue,
        parameter.description,
    )
    if !ok do return
    defer if !ok do com.Release(comextensibleparameter)

    ok = com.AccessLevel(comextensibleparameter, parameter.accesslevel)
    if !ok do return

    ok = com.SafetyType(comextensibleparameter, parameter.safetytype)
    if !ok do return

    ok = com.FDPort(comextensibleparameter, parameter.fdport)
    if !ok do return

    // type_guid / type_path are read-only

    return comextensibleparameter, true
}

CMParametersFromCom :: proc(comcmparameters: com.CMParameters, parameters: ^[dynamic]Parameter) -> (ok: bool)
{
    if comcmparameters == nil do return

    count: i32
    count, ok = com.CMParameterCount(comcmparameters)
    if !ok do return

    for i in 0..<count {
        comcmparameter: com.CMParameter
        comcmparameter, ok = com.GetCMParameter(comcmparameters, i)
        if !ok do return
        defer com.Release(comcmparameter)

        parameter: Parameter
        parameter, ok = CMParameterFromCom(comcmparameter)
        if !ok do return
        append(parameters, parameter)
    }

    return true
}

CMParameterFromCom :: proc(comcmparameter: com.CMParameter) -> (parameter: Parameter, ok: bool)
{
    if comcmparameter == nil do return

    parameter.name, ok = com.Name(comcmparameter)
    if !ok do return

    parameter.type, ok = com.TypeName(comcmparameter)
    if !ok do return

    direction: string
    direction, ok = com.Direction(comcmparameter)
    if !ok do return
    parameter.direction = DirectionFromString(direction)
    
    parameter.initialvalue, ok = com.GetCMParameterInitialValue(comcmparameter)
    if !ok do return

    parameter.description, ok = com.Description(comcmparameter)
    if !ok do return

    parameter.readpermission, ok = com.ReadPermission(comcmparameter)
    if !ok do return

    parameter.writepermission, ok = com.WritePermission(comcmparameter)
    if !ok do return

    parameter.authenticationlevel, ok = com.AuthenticationLevel(comcmparameter)
    if !ok do return

    parameter.accesslevel, ok = com.AccessLevel(comcmparameter)
    if !ok do return

    parameter.safetytype, ok = com.SafetyType(comcmparameter)
    if !ok do return

    parameter.batchproperty, ok = com.BatchProperty(comcmparameter)
    if !ok do return

    parameter.fdport, ok = com.FDPort(comcmparameter)
    if !ok do return

    parameter.typeguid, ok = com.TypeGuid(comcmparameter)
    if !ok do return

    parameter.typepath, ok = com.TypePath(comcmparameter)
    if !ok do return

    // TODO: not importnat for now
    //comautopoint: com.AutoPoint
    //comautopoint, ok = com.autopoint(comcmparameter)
    //if !ok do return
    //defer com.Release(comautopoint)
    //parameter.autopoint, ok = AutoPointFromCom(comautopoint)
    //if !ok do return

    comgraphnodes: com.GraphNodes
    comgraphnodes, ok = com.GetGraphNodes(comcmparameter)
    if !ok do return
    defer com.Release(comgraphnodes)

    // TODO: not importnat for now
    //ok = GraphNodesFromCom(comgraphnodes, &parameter.graphnodes)
    //if !ok do return

    return parameter, true
}

CMParametersToCom :: proc(comcmparameters: com.CMParameters, parameters: []Parameter) -> (ok: bool)
{
    if comcmparameters == nil do return

    for parameter in parameters {
        comcmparameter: com.CMParameter
        comcmparameter, ok = CMParameterToCom(parameter)
        if !ok do return
        defer com.Release(comcmparameter)

        ok = com.AddCMParameter(comcmparameters, comcmparameter)
        if !ok do return
    }

    return true
}

CMParameterToCom :: proc(parameter: Parameter) -> (comcmparameter: com.CMParameter, ok: bool)
{
    // TODO: not importnat for now
    //comautopoint: com.AutoPoint
    //comautopoint, ok = AutoPointToCom(parameter.autopoint)
    //if !ok do return
    //defer com.Release(comautopoint)

    comcmparameter, ok = com.NewCMParameterEx(
        parameter.name,
        parameter.type,
        parameter.initialvalue,
        parameter.readpermission,
        parameter.writepermission,
        parameter.description,
        nil, //comautopoint,
    )
    if !ok do return
    defer if !ok do com.Release(comcmparameter)

    ok = com.Direction(comcmparameter, DirectionToString(parameter.direction))
    if !ok do return

    if parameter.authenticationlevel != "" {
        ok = com.AuthenticationLevel(comcmparameter, parameter.authenticationlevel)
        if !ok do return
    }

    ok = com.AccessLevel(comcmparameter, parameter.accesslevel)
    if !ok do return

    ok = com.SafetyType(comcmparameter, parameter.safetytype)
    if !ok do return

    ok = com.BatchProperty(comcmparameter, parameter.batchproperty)
    if !ok do return

    ok = com.FDPort(comcmparameter, parameter.fdport)
    if !ok do return

    // type_guid / type_path read-only

    // TODO: not importnat for now
    //comgraphnodes: com.GraphNodes
    //comgraphnodes, ok = com.graphnodes(comcmparameter)
    //if !ok do return
    //defer com.Release(comgraphnodes)
    //ok = GraphNodesToCom(comgraphnodes, parameter.graphnodes[:])
    //if !ok do return

    return comcmparameter, true
}
