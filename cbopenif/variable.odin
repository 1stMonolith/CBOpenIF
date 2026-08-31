package cbopenif

import "com"

Variable :: struct
{
    name:                 string,
    type:                 string,
    attribute:            string,
    initialvalue:         string,
    description:          string,
    readpermission:       string,
    writepermission:      string,
    authenticationlevel:  string,
    accesslevel:          string,
    safetytype:           string,
    batchproperty:        string,
    
    typeguid:             string,
    typepath:             string,

    // CommVariable only
    direction:            Direction,
    acknowledgegroup:     string,
    silexpected:          string,
    silrestricted:        bool,
    intervaltime:         string,
    priority:             string,
    ipaddress:            string,
    uniqueid:             i32,
    ispvalue:             string,

    // TODO: not important for now
    //graph_nodes:          [dynamic]GraphNode,
}

VariablesFromCom :: proc(comvariables: com.Variables, variables: ^[dynamic]Variable) -> (ok: bool)
{
    if comvariables == nil do return

    count: i32
    count, ok = com.VariableCount(comvariables)
    if !ok do return

    for i in 0..<count {
        comvariable: com.Variable
        comvariable, ok = com.GetVariable(comvariables, i)
        if !ok do return
        defer com.Release(comvariable)

        vs: Variable
        vs, ok = VariableFromCom(comvariable)
        if !ok do return
        append(variables, vs)
    }
    return true
}

VariableFromCom :: proc(comvariable: com.Variable) -> (variable: Variable, ok: bool)
{
    if comvariable == nil do return

    variable.name, ok = com.Name(comvariable)
    if !ok do return

    variable.type, ok = com.TypeName(comvariable)
    if !ok do return

    variable.attribute, ok = com.Attribute(comvariable)
    if !ok do return

    variable.initialvalue, ok = com.GetVariableInitialValue(comvariable)
    if !ok do return

    variable.description, ok = com.Description(comvariable)
    if !ok do return

    variable.readpermission, ok = com.ReadPermission(comvariable)
    if !ok do return

    variable.writepermission, ok = com.WritePermission(comvariable)
    if !ok do return

    variable.authenticationlevel, ok = com.AuthenticationLevel(comvariable)
    if !ok do return

    variable.accesslevel, ok = com.AccessLevel(comvariable)
    if !ok do return

    variable.safetytype, ok = com.SafetyType(comvariable)
    if !ok do return

    variable.batchproperty, ok = com.BatchProperty(comvariable)
    if !ok do return

    variable.typeguid, ok = com.TypeGuid(comvariable)
    if !ok do return

    variable.typepath, ok = com.TypePath(comvariable)
    if !ok do return

    // TODO: not important for now
    //comgraphnodes: com.GraphNodes
    //comgraphnodes, ok = com.graphnodes(comvariable)
    //if !ok do return
    //defer com.Release(comgraphnodes)
    //ok = GraphNodesFromCom(comgraphnodes, &variable.graph_nodes)
    //if !ok do return

    return variable, true
}

VariablesToCom :: proc(comvariables: com.Variables, variables: []Variable) -> (ok: bool)
{
    if comvariables == nil do return

    for variable in variables {
        comvariable: com.Variable
        comvariable, ok = VariableToCom(variable)
        if !ok do return
        defer com.Release(comvariable)

        ok = com.AddVariable(comvariables, comvariable)
        if !ok do return
    }
    return true
}

VariableToCom :: proc(variable: Variable) -> (comvariable: com.Variable, ok: bool)
{
    comvariable, ok = com.NewVariableEx(
        variable.name,
        variable.type,
        variable.attribute,
        variable.initialvalue,
        variable.readpermission,
        variable.writepermission,
        variable.description,
    )
    if !ok do return
    defer if !ok do com.Release(comvariable)

    if variable.authenticationlevel != "" {
        ok = com.AuthenticationLevel(comvariable, variable.authenticationlevel)
        if !ok do return
    }

    ok = com.AccessLevel(comvariable, variable.accesslevel)
    if !ok do return

    ok = com.SafetyType(comvariable, variable.safetytype)
    if !ok do return

    ok = com.BatchProperty(comvariable, variable.batchproperty)
    if !ok do return

    // type_guid / type_path are read-only on the COM side

    // TODO: not important for now
    //nodes: com.GraphNodes
    //nodes, ok = com.graphnodes(comvariable)
    //if !ok do return
    //defer com.Release(nodes)
    //ok = GraphNodesToCom(nodes, variable.graph_nodes[:])
    //if !ok do return

    return comvariable, true
}

ExternalVariablesFromCom :: proc(cevs: com.ExternalVariables, variables: ^[dynamic]Variable) -> (ok: bool)
{
    if cevs == nil do return

    count: i32
    count, ok = com.ExternalVariableCount(cevs)
    if !ok do return

    for i in 0..<count {
        cev: com.ExternalVariable
        cev, ok = com.GetExternalVariable(cevs, i)
        if !ok do return
        defer com.Release(cev)

        variable: Variable
        variable, ok = ExternalVariableFromCom(cev)
        if !ok do return
        append(variables, variable)
    }
    return true
}

ExternalVariableFromCom :: proc(cev: com.ExternalVariable) -> (variable: Variable, ok: bool)
{
    if cev == nil do return

    variable.name, ok = com.Name(cev)
    if !ok do return

    variable.type, ok = com.TypeName(cev)
    if !ok do return

    variable.attribute, ok = com.Attribute(cev)
    if !ok do return

    variable.description, ok = com.Description(cev)
    if !ok do return

    variable.readpermission, ok = com.ReadPermission(cev)
    if !ok do return

    variable.writepermission, ok = com.WritePermission(cev)
    if !ok do return

    variable.authenticationlevel, ok = com.AuthenticationLevel(cev)
    if !ok do return

    variable.accesslevel, ok = com.AccessLevel(cev)
    if !ok do return

    variable.safetytype, ok = com.SafetyType(cev)
    if !ok do return

    variable.typeguid, ok = com.TypeGuid(cev)
    if !ok do return

    variable.typepath, ok = com.TypePath(cev)
    if !ok do return

    // TODO: not important for now
    //comgraphnodes: com.GraphNodes
    //comgraphnodes, ok = com.graphnodes(cev)
    //if !ok do return
    //defer com.Release(comgraphnodes)
    //ok = GraphNodesFromCom(comgraphnodes, &variable.graph_nodes)
    //if !ok do return

    return variable, true
}

ExternalVariablesToCom :: proc(cevs: com.ExternalVariables, variables: []Variable) -> (ok: bool)
{
    if cevs == nil do return
    
    for variable in variables {
        cev: com.ExternalVariable
        cev, ok = ExternalVariableToCom(variable)
        if !ok do return
        defer com.Release(cev)

        ok = com.AddExternalVariable(cevs, cev)
        if !ok do return
    }
    return true
}

ExternalVariableToCom :: proc(variable: Variable) -> (comexternalvariable: com.ExternalVariable, ok: bool)
{
    cev: com.ExternalVariable
    cev, ok = com.NewExternalVariableEx(
        variable.name,
        variable.type,
        variable.attribute,
        variable.readpermission,
        variable.writepermission,
        variable.description,
    )
    if !ok do return
    defer if !ok do com.Release(cev)

    if variable.authenticationlevel != "" {
        ok = com.AuthenticationLevel(cev, variable.authenticationlevel)
        if !ok do return
    }

    ok = com.AccessLevel(cev, variable.accesslevel)
    if !ok do return

    ok = com.SafetyType(cev, variable.safetytype)
    if !ok do return

    // type_guid / type_path are read-only

    // TODO: not important for now
    //comgraphnodes: com.GraphNodes
    //comgraphnodes, ok = com.graphnodes(cev)
    //if !ok do return
    //defer com.Release(comgraphnodes)
    //ok = GraphNodesToCom(comgraphnodes, variable.graph_nodes[:])
    //if !ok do return

    return cev, true
}

GlobalVariablesFromCom :: proc(comvariables: com.GlobalVariables, variables: ^[dynamic]Variable) -> (ok: bool)
{
    if comvariables == nil do return

    count: i32
    count, ok = com.GlobalVariableCount(comvariables)
    if !ok do return

    for i in 0..<count {
        comglobalvariable: com.GlobalVariable
        comglobalvariable, ok = com.GetGlobalVariable(comvariables, i)
        if !ok do return
        defer com.Release(comglobalvariable)

        variable: Variable
        variable, ok = GlobalVariableFromCom(comglobalvariable)
        if !ok do return
        append(variables, variable)
    }
    return true
}

GlobalVariableFromCom :: proc(comglobalvariable: com.GlobalVariable) -> (variable: Variable, ok: bool)
{
    if comglobalvariable == nil do return

    variable.name, ok = com.Name(comglobalvariable)
    if !ok do return

    variable.type, ok = com.TypeName(comglobalvariable)
    if !ok do return

    variable.attribute, ok = com.Attribute(comglobalvariable)
    if !ok do return

    variable.initialvalue, ok = com.GetGlobalVariableInitialValue(comglobalvariable)
    if !ok do return

    variable.description, ok = com.Description(comglobalvariable)
    if !ok do return

    variable.readpermission, ok = com.ReadPermission(comglobalvariable)
    if !ok do return

    variable.writepermission, ok = com.WritePermission(comglobalvariable)
    if !ok do return

    variable.authenticationlevel, ok = com.AuthenticationLevel(comglobalvariable)
    if !ok do return

    variable.accesslevel, ok = com.AccessLevel(comglobalvariable)
    if !ok do return

    variable.safetytype, ok = com.SafetyType(comglobalvariable)
    if !ok do return

    variable.typeguid, ok = com.TypeGuid(comglobalvariable)
    if !ok do return

    variable.typepath, ok = com.TypePath(comglobalvariable)
    if !ok do return

    // TODO: not important for now
    //comgraphnodes: com.GraphNodes
    //comgraphnodes, ok = com.graphnodes(comglobalvariable)
    //if !ok do return
    //defer com.Release(comgraphnodes)
    //ok = GraphNodesFromCom(comgraphnodes, &variable.graph_nodes)
    //if !ok do return

    return variable, true
}

GlobalVariablesToCom :: proc(comvariables: com.GlobalVariables, variables: []Variable) -> (ok: bool)
{
    if comvariables == nil do return
    
    for variable in variables {
        comglobalvariable: com.GlobalVariable
        comglobalvariable, ok = GlobalVariableToCom(variable)
        if !ok do return
        defer com.Release(comglobalvariable)
        
        ok = com.AddGlobalVariable(comvariables, comglobalvariable)
        if !ok do return
    }

    return true
}

GlobalVariableToCom :: proc(variable: Variable) -> (comglobalvariable: com.GlobalVariable, ok: bool)
{
    comglobalvariable, ok = com.NewGlobalVariableEx(
        variable.name,
        variable.type,
        variable.attribute,
        variable.initialvalue,
        variable.readpermission,
        variable.writepermission,
        variable.description,
    )
    if !ok do return
    defer if !ok do com.Release(comglobalvariable)

    if variable.authenticationlevel != "" {
        ok = com.AuthenticationLevel(comglobalvariable, variable.authenticationlevel)
        if !ok do return
    }

    ok = com.AccessLevel(comglobalvariable, variable.accesslevel)
    if !ok do return

    ok = com.SafetyType(comglobalvariable, variable.safetytype)
    if !ok do return

    // type_guid / type_path are read-only

    // TODO: not important for now
    //nodes: com.GraphNodes
    //nodes, ok = com.graphnodes(comglobalvariable)
    //if !ok do return
    //defer com.Release(nodes)
    //ok = GraphNodesToCom(nodes, variable.graph_nodes[:])
    //if !ok do return

    return comglobalvariable, true
}

CommVariablesFromCom :: proc(comcommvariables: com.CommVariables, variables: ^[dynamic]Variable) -> (ok: bool)
{
    if comcommvariables == nil do return

    count: i32
    count, ok = com.CommVariableCount(comcommvariables)
    if !ok do return

    for i in 0..<count {
        comvariable: com.CommVariable
        comvariable, ok = com.GetCommVariable(comcommvariables, i)
        if !ok do return
        defer com.Release(comvariable)

        variable: Variable
        variable, ok = CommVariableFromCom(comvariable)
        if !ok do return
        append(variables, variable)
    }
    return true
}

CommVariableFromCom :: proc(comcommvariable: com.CommVariable) -> (variable: Variable, ok: bool)
{
    if comcommvariable == nil do return

    variable.name, ok = com.Name(comcommvariable)
    if !ok do return

    variable.type, ok = com.TypeName(comcommvariable)
    if !ok do return

    variable.attribute, ok = com.Attribute(comcommvariable)
    if !ok do return

    variable.initialvalue, ok = com.GetCommVariableInitialValue(comcommvariable)
    if !ok do return

    variable.description, ok = com.Description(comcommvariable)
    if !ok do return

    direction: string
    direction, ok = com.Direction(comcommvariable)
    if !ok do return
    variable.direction = DirectionFromString(direction)

    variable.ipaddress, ok = com.IpAddress(comcommvariable)
    if !ok do return

    variable.intervaltime, ok = com.IntervalTime(comcommvariable)
    if !ok do return

    variable.priority, ok = com.Priority(comcommvariable)
    if !ok do return

    variable.ispvalue, ok = com.ISPValue(comcommvariable)
    if !ok do return

    variable.readpermission, ok = com.ReadPermission(comcommvariable)
    if !ok do return

    variable.silexpected, ok = com.ExpectedSIL(comcommvariable)
    if !ok do return

    variable.uniqueid, ok = com.GetCommVariableUniqueID(comcommvariable)
    if !ok do return

    variable.silrestricted, ok = com.RestrictedSIL(comcommvariable)
    if !ok do return

    variable.acknowledgegroup, ok = com.AcknowledgeGroup(comcommvariable)
    if !ok do return

    variable.typeguid, ok = com.TypeGuid(comcommvariable)
    if !ok do return

    variable.typepath, ok = com.TypePath(comcommvariable)
    if !ok do return

    return variable, true
}

CommVariablesToCom :: proc(comcommvariables: com.CommVariables, variables: []Variable) -> (ok: bool)
{
    if comcommvariables == nil do return
    
    for variable in variables {
        comcommvariable: com.CommVariable
        comcommvariable, ok = CommVariableToCom(variable)
        if !ok do return
        defer com.Release(comcommvariable)
        
        ok = com.AddCommVariable(comcommvariables, comcommvariable)
        if !ok do return
    }
    return true
}

CommVariableToCom :: proc(variable: Variable) -> (comcommvariable: com.CommVariable, ok: bool)
{
    comcommvariable, ok = com.NewCommVariableEx(
        variable.name,
        variable.type,
        DirectionToString(variable.direction),
        variable.attribute,
        variable.initialvalue,
        variable.ispvalue,
        variable.priority,
        variable.intervaltime,
        variable.readpermission,
        variable.description,
    )
    if !ok do return
    defer if !ok do com.Release(comcommvariable)

    ok = com.IpAddress(comcommvariable, variable.ipaddress)
    if !ok do return

    ok = com.ExpectedSIL(comcommvariable, variable.silexpected)
    if !ok do return

    ok = com.SetCommVariableUniqueID(comcommvariable, variable.uniqueid)
    if !ok do return

    ok = com.RestrictedSIL(comcommvariable, variable.silrestricted)
    if !ok do return
    
    ok = com.AcknowledgeGroup(comcommvariable, variable.acknowledgegroup)
    if !ok do return

    // type_guid / type_path are read-only

    return comcommvariable, true
}
