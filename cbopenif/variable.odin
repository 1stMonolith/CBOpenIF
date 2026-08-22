package cbopenif

import "com"

VariableKind :: enum i32 {
    Variable              = 0,
    ExternalVariable      = 1,
    GlobalVariable        = 2,
    CommunicationVariable = 3,
}

Variable :: struct {
    kind:                 VariableKind,
    name:                 string,
    type_name:            string,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    batch_property:       string,
    graph_nodes:          [dynamic]GraphNode,
    type_guid:            string,
    type_path:            string,

    direction:            Direction,
    acknowledge_group:    string,
    expected_sil:         string,
    restricted_sil:       bool,
    interval_time:        string,
    priority:             string,
    ip_address:           string,
    unique_id:            i32,
    isp_value:            string,
}

variable_from_com :: proc(variable: Variable, allocator := context.allocator) -> (result: t.Variable, ok: bool) {
    if variable == nil do return

    context.allocator = allocator

    result.name, ok = name(variable)
    if !ok do return
    result.type_name, ok = type_name(variable)
    if !ok do return
    result.attribute, ok = attribute(variable)
    if !ok do return
    result.initial_value, ok = initial_value(variable)
    if !ok do return
    result.description, ok = description(variable)
    if !ok do return
    result.read_permission, ok = read_permission(variable)
    if !ok do return
    result.write_permission, ok = write_permission(variable)
    if !ok do return
    result.authentication_level, ok = authentication_level(variable)
    if !ok do return
    result.access_level, ok = access_level(variable)
    if !ok do return
    result.safety_type, ok = safety_type(variable)
    if !ok do return
    result.batch_property, ok = batch_property(variable)
    if !ok do return
    result.type_guid, ok = type_guid(variable)
    if !ok do return
    result.type_path, ok = type_path(variable)
    if !ok do return

    nodes: GraphNodes
    nodes, ok = graphnodes(variable)
    if !ok do return
    defer release(nodes)
    result.graph_nodes, ok = graphnodes_from_com(nodes)
    if !ok do return

    return result, true
}

variable_to_com :: proc(src: t.Variable) -> (result: Variable, ok: bool) {
    variable: Variable
    variable, ok = variable_new1(
        src.name,
        src.type_name,
        src.attribute,
        src.initial_value,
        src.read_permission,
        src.write_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(variable)

    ok = authentication_level(variable, src.authentication_level)
    if !ok do return
    ok = access_level(variable, src.access_level)
    if !ok do return
    ok = safety_type(variable, src.safety_type)
    if !ok do return
    ok = batch_property(variable, src.batch_property)
    if !ok do return

    // type_guid / type_path are read-only on the COM side

    nodes: GraphNodes
    nodes, ok = graphnodes(variable)
    if !ok do return
    defer release(nodes)
    ok = graphnodes_to_com(nodes, src.graph_nodes[:])
    if !ok do return

    return variable, true
}

variables_from_com :: proc(vars: Variables, allocator := context.allocator) -> (result: [dynamic]t.Variable, ok: bool) {
    if vars == nil do return
    context.allocator = allocator

    count: i32
    count, ok = variable_count(vars)
    if !ok do return

    result = make([dynamic]t.Variable, 0, int(count), allocator)
    for i in 0..<count {
        v: Variable
        v, ok = variable_by_index(vars, i)
        if !ok do return
        defer release(v)

        vs: t.Variable
        vs, ok = variable_from_com(v)
        if !ok do return
        append(&result, vs)
    }
    return result, true
}

variables_to_com :: proc(vars: Variables, src: []t.Variable) -> (ok: bool) {
    if vars == nil do return
    for item in src {
        v: Variable
        v, ok = variable_to_com(item)
        if !ok do return
        defer release(v)

        ok = variable_add(vars, v)
        if !ok do return
    }
    return true
}

externalvariable_from_com :: proc(external_variable: ExternalVariable, allocator := context.allocator) -> (result: t.Variable, ok: bool) {
    if external_variable == nil do return

    context.allocator = allocator

    result.name, ok = name(external_variable)
    if !ok do return
    result.type_name, ok = type_name(external_variable)
    if !ok do return
    result.attribute, ok = attribute(external_variable)
    if !ok do return
    result.description, ok = description(external_variable)
    if !ok do return
    result.read_permission, ok = read_permission(external_variable)
    if !ok do return
    result.write_permission, ok = write_permission(external_variable)
    if !ok do return
    result.authentication_level, ok = authentication_level(external_variable)
    if !ok do return
    result.access_level, ok = access_level(external_variable)
    if !ok do return
    result.safety_type, ok = safety_type(external_variable)
    if !ok do return
    result.type_guid, ok = type_guid(external_variable)
    if !ok do return
    result.type_path, ok = type_path(external_variable)
    if !ok do return

    nodes: GraphNodes
    nodes, ok = graphnodes(external_variable)
    if !ok do return
    defer release(nodes)
    result.graph_nodes, ok = graphnodes_from_com(nodes)
    if !ok do return

    return result, true
}

externalvariable_to_com :: proc(src: t.Variable) -> (result: ExternalVariable, ok: bool) {
    external_variable: ExternalVariable
    external_variable, ok = externalvariable_new1(
        src.name,
        src.type_name,
        src.attribute,
        src.read_permission,
        src.write_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(external_variable)

    ok = authentication_level(external_variable, src.authentication_level)
    if !ok do return
    ok = access_level(external_variable, src.access_level)
    if !ok do return
    ok = safety_type(external_variable, src.safety_type)
    if !ok do return

    // type_guid / type_path are read-only

    nodes: GraphNodes
    nodes, ok = graphnodes(external_variable)
    if !ok do return
    defer release(nodes)
    ok = graphnodes_to_com(nodes, src.graph_nodes[:])
    if !ok do return

    return external_variable, true
}

externalvariables_from_com :: proc(evars: ExternalVariables, allocator := context.allocator) -> (result: [dynamic]t.Variable, ok: bool) {
    if evars == nil do return
    context.allocator = allocator

    count: i32
    count, ok = externalvariable_count(evars)
    if !ok do return

    result = make([dynamic]t.ExternalVariable, 0, int(count), allocator)
    for i in 0..<count {
        ev: ExternalVariable
        ev, ok = externalvariable_by_index(evars, i)
        if !ok do return
        defer release(ev)

        evs: t.ExternalVariable
        evs, ok = externalvariable_from_com(ev)
        if !ok do return
        append(&result, evs)
    }
    return result, true
}

externalvariables_to_com :: proc(evars: ExternalVariables, src: []t.Variable) -> (ok: bool) {
    if evars == nil do return
    for item in src {
        ev: ExternalVariable
        ev, ok = externalvariable_to_com(item)
        if !ok do return
        defer release(ev)

        ok = externalvariable_add(evars, ev)
        if !ok do return
    }
    return true
}

globalvariable_from_com :: proc(global_variable: GlobalVariable, allocator := context.allocator) -> (result: t.Variable, ok: bool) {
    if global_variable == nil do return

    context.allocator = allocator

    result.name, ok = name(global_variable)
    if !ok do return
    result.type_name, ok = type_name(global_variable)
    if !ok do return
    result.attribute, ok = attribute(global_variable)
    if !ok do return
    result.initial_value, ok = initial_value(global_variable)
    if !ok do return
    result.description, ok = description(global_variable)
    if !ok do return
    result.read_permission, ok = read_permission(global_variable)
    if !ok do return
    result.write_permission, ok = write_permission(global_variable)
    if !ok do return
    result.authentication_level, ok = authentication_level(global_variable)
    if !ok do return
    result.access_level, ok = access_level(global_variable)
    if !ok do return
    result.safety_type, ok = safety_type(global_variable)
    if !ok do return
    result.type_guid, ok = type_guid(global_variable)
    if !ok do return
    result.type_path, ok = type_path(global_variable)
    if !ok do return

    nodes: GraphNodes
    nodes, ok = graphnodes(global_variable)
    if !ok do return
    defer release(nodes)
    result.graph_nodes, ok = graphnodes_from_com(nodes)
    if !ok do return

    return result, true
}

globalvariable_to_com :: proc(src: t.Variable) -> (result: GlobalVariable, ok: bool) {
    global_variable: GlobalVariable
    global_variable, ok = globalvariable_new1(
        src.name,
        src.type_name,
        src.attribute,
        src.initial_value,
        src.read_permission,
        src.write_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(global_variable)

    ok = authentication_level(global_variable, src.authentication_level)
    if !ok do return
    ok = access_level(global_variable, src.access_level)
    if !ok do return
    ok = safety_type(global_variable, src.safety_type)
    if !ok do return

    // type_guid / type_path are read-only

    nodes: GraphNodes
    nodes, ok = graphnodes(global_variable)
    if !ok do return
    defer release(nodes)
    ok = graphnodes_to_com(nodes, src.graph_nodes[:])
    if !ok do return

    return global_variable, true
}

globalvariables_from_com :: proc(gvars: GlobalVariables, allocator := context.allocator) -> (result: [dynamic]t.Variable, ok: bool) {
    if gvars == nil do return
    context.allocator = allocator

    count: i32
    count, ok = globalvariable_count(gvars)
    if !ok do return

    result = make([dynamic]t.GlobalVariable, 0, int(count), allocator)
    for i in 0..<count {
        g: GlobalVariable
        g, ok = globalvariable_by_index(gvars, i)
        if !ok do return
        defer release(g)

        gs: t.GlobalVariable
        gs, ok = globalvariable_from_com(g)
        if !ok do return
        append(&result, gs)
    }
    return result, true
}

globalvariables_to_com :: proc(gvars: GlobalVariables, src: []t.Variable) -> (ok: bool) {
    if gvars == nil do return
    for item in src {
        g: GlobalVariable
        g, ok = globalvariable_to_com(item)
        if !ok do return
        defer release(g)
        ok = globalvariable_add(gvars, g)
        if !ok do return
    }
    return true
}

commvariable_from_com :: proc(commvariable: CommVariable, allocator := context.allocator) -> (result: t.Variable, ok: bool) {
    if commvariable == nil do return

    context.allocator = allocator

    result.name, ok = name(commvariable)
    if !ok do return
    result.type_name, ok = type_name(commvariable)
    if !ok do return
    result.attribute, ok = attribute(commvariable)
    if !ok do return
    result.initial_value, ok = initial_value(commvariable)
    if !ok do return
    result.description, ok = description(commvariable)
    if !ok do return

    dir_str: string
    dir_str, ok = direction(commvariable)
    if !ok do return
    result.direction = t.direction_from_string(dir_str)

    result.ip_address, ok = ipaddress(commvariable)
    if !ok do return
    result.interval_time, ok = interval_time(commvariable)
    if !ok do return
    result.priority, ok = priority(commvariable)
    if !ok do return
    result.isp_value, ok = isp_value(commvariable)
    if !ok do return
    result.read_permission, ok = read_permission(commvariable)
    if !ok do return
    result.expected_sil, ok = expected_sil(commvariable)
    if !ok do return
    result.unique_id, ok = unique_id(commvariable)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(commvariable)
    if !ok do return
    result.acknowledge_group, ok = acknowledge_group(commvariable)
    if !ok do return
    result.type_guid, ok = type_guid(commvariable)
    if !ok do return
    result.type_path, ok = type_path(commvariable)
    if !ok do return

    return result, true
}

commvariable_to_com :: proc(src: t.Variable) -> (result: CommVariable, ok: bool) {
    commvariable: CommVariable
    commvariable, ok = commvariable_new1(
        src.name,
        src.type_name,
        t.direction_to_string(src.direction),
        src.attribute,
        src.initial_value,
        src.isp_value,
        src.priority,
        src.interval_time,
        src.read_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(commvariable)

    ok = ipaddress(commvariable, src.ip_address)
    if !ok do return
    ok = expected_sil(commvariable, src.expected_sil)
    if !ok do return
    ok = unique_id(commvariable, src.unique_id)
    if !ok do return
    ok = restricted_sil(commvariable, src.restricted_sil)
    if !ok do return
    ok = acknowledge_group(commvariable, src.acknowledge_group)
    if !ok do return

    // type_guid / type_path are read-only

    return commvariable, true
}

commvariables_from_com :: proc(cvs: CommVariables, allocator := context.allocator) -> (result: [dynamic]t.Variable, ok: bool) {
    if cvs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = commvariable_count(cvs)
    if !ok do return

    result = make([dynamic]t.CommVariable, 0, int(count), allocator)
    for i in 0..<count {
        cv: CommVariable
        cv, ok = commvariable_by_index(cvs, i)
        if !ok do return
        defer release(cv)

        cvs_: t.CommVariable
        cvs_, ok = commvariable_from_com(cv)
        if !ok do return
        append(&result, cvs_)
    }
    return result, true
}

commvariables_to_com :: proc(cvs: CommVariables, src: []t.Variable) -> (ok: bool) {
    if cvs == nil do return
    for item in src {
        cv: CommVariable
        cv, ok = commvariable_to_com(item)
        if !ok do return
        defer release(cv)
        ok = commvariable_add(cvs, cv)
        if !ok do return
    }
    return true
}
