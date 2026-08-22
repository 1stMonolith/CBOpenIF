package cbopenif

import "com"

ParameterKind :: enum i32 {
    Parameter     = 0,
    Extensible    = 1,
    ControlModule = 2,
}

Parameter :: struct {
    kind:                 ParameterKind,
    name:                 string,
    type_name:            string,
    direction:            Direction,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    fd_port:              string,
    type_guid:            string,
    type_path:            string,

    batch_property:       string,
    auto_point:           AutoPosition,
    graph_nodes:          [dynamic]GraphNode,
}

ParameterSetting :: struct {
    name:            string,
    description:     string,
    parameter_value: string,
}

parameter_from_com :: proc(parameter: Parameter, allocator := context.allocator) -> (result: t.Parameter, ok: bool) {
    if parameter == nil do return

    context.allocator = allocator

    result.name, ok = name(parameter)
    if !ok do return
    result.type_name, ok = type_name(parameter)
    if !ok do return
    result.attribute, ok = attribute(parameter)
    if !ok do return
    result.direction, ok = direction(parameter)
    if !ok do return
    result.initial_value, ok = initial_value(parameter)
    if !ok do return
    result.description, ok = description(parameter)
    if !ok do return
    result.read_permission, ok = read_permission(parameter)
    if !ok do return
    result.write_permission, ok = write_permission(parameter)
    if !ok do return
    result.authentication_level, ok = authentication_level(parameter)
    if !ok do return
    result.access_level, ok = access_level(parameter)
    if !ok do return
    result.safety_type, ok = safety_type(parameter)
    if !ok do return
    result.fd_port, ok = fdport(parameter)
    if !ok do return
    result.type_guid, ok = type_guid(parameter)
    if !ok do return
    result.type_path, ok = type_path(parameter)
    if !ok do return

    return result, true
}

parameter_to_com :: proc(src: t.Parameter) -> (result: Parameter, ok: bool) {
    parameter: Parameter
    parameter, ok = parameter_new1(
        src.name,
        src.type_name,
        src.attribute,
        i32(src.direction),
        src.initial_value,
        src.read_permission,
        src.write_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(parameter)

    ok = authentication_level(parameter, src.authentication_level)
    if !ok do return
    ok = access_level(parameter, src.access_level)
    if !ok do return
    ok = safety_type(parameter, src.safety_type)
    if !ok do return
    ok = fdport(parameter, src.fd_port)
    if !ok do return

    // type_guid / type_path are read-only

    return parameter, true
}

parameters_from_com :: proc(params: Parameters, allocator := context.allocator) -> (result: [dynamic]t.Parameter, ok: bool) {
    if params == nil do return
    context.allocator = allocator

    count: i32
    count, ok = parameter_count(params)
    if !ok do return

    result = make([dynamic]t.Parameter, 0, int(count), allocator)
    for i in 0..<count {
        pr: Parameter
        pr, ok = parameter_by_index(params, i)
        if !ok do return
        p := Parameter(pr)
        defer release(p)

        ps: t.Parameter
        ps, ok = parameter_from_com(p)
        if !ok do return
        append(&result, ps)
    }
    return result, true
}

parameters_to_com :: proc(params: Parameters, src: []t.Parameter) -> (ok: bool) {
    if params == nil do return
    for item in src {
        p: Parameter
        p, ok = parameter_to_com(item)
        if !ok do return
        defer release(p)

        ok = parameter_add(params, p)
        if !ok do return
    }
    return true
}

parametersetting_from_com :: proc(parametersetting: ParameterSetting, allocator := context.allocator) -> (result: t.ParameterSetting, ok: bool) {
    if parametersetting == nil do return

    context.allocator = allocator

    result.name, ok = name(parametersetting)
    if !ok do return
    result.parameter_value, ok = parametersetting_value(parametersetting)
    if !ok do return
    result.description, ok = description(parametersetting)
    if !ok do return

    return result, true
}

parametersetting_to_com :: proc(src: t.ParameterSetting) -> (result: ParameterSetting, ok: bool) {
    parametersetting: ParameterSetting
    parametersetting, ok = parametersetting_new(src.name, src.parameter_value)
    if !ok do return

    // description is get-only on the COM side (no DescriptionPut)

    return parametersetting, true
}

parametersettings_from_com :: proc(pss: ParameterSettings, allocator := context.allocator) -> (result: [dynamic]t.ParameterSetting, ok: bool) {
    if pss == nil do return
    context.allocator = allocator

    count: i32
    count, ok = parametersetting_count(pss)
    if !ok do return

    result = make([dynamic]t.ParameterSetting, 0, int(count), allocator)
    for i in 0..<count {
        ps: ParameterSetting
        ps, ok = parametersetting_by_index(pss, i)
        if !ok do return
        defer release(ps)

        pss_: t.ParameterSetting
        pss_, ok = parametersetting_from_com(ps)
        if !ok do return
        append(&result, pss_)
    }
    return result, true
}

parametersettings_to_com :: proc(pss: ParameterSettings, src: []t.ParameterSetting) -> (ok: bool) {
    if pss == nil do return
    for item in src {
        ps: ParameterSetting
        ps, ok = parametersetting_to_com(item)
        if !ok do return
        defer release(ps)
        ok = parametersetting_add(pss, ps)
        if !ok do return
    }
    return true
}

extensibleparameter_from_com :: proc(extensibleparameter: ExtensibleParameter, allocator := context.allocator) -> (result: t.Parameter, ok: bool) {
    if extensibleparameter == nil do return

    context.allocator = allocator

    result.name, ok = name(extensibleparameter)
    if !ok do return
    result.type_name, ok = type_name(extensibleparameter)
    if !ok do return
    result.attribute, ok = attribute(extensibleparameter)
    if !ok do return
    result.direction, ok = direction(extensibleparameter)
    if !ok do return
    result.initial_value, ok = initial_value(extensibleparameter)
    if !ok do return
    result.description, ok = description(extensibleparameter)
    if !ok do return
    result.access_level, ok = access_level(extensibleparameter)
    if !ok do return
    result.safety_type, ok = safety_type(extensibleparameter)
    if !ok do return
    result.fd_port, ok = fdport(extensibleparameter)
    if !ok do return
    result.type_guid, ok = type_guid(extensibleparameter)
    if !ok do return
    result.type_path, ok = type_path(extensibleparameter)
    if !ok do return

    return result, true
}

extensibleparameter_to_com :: proc(src: t.Parameter) -> (result: ExtensibleParameter, ok: bool) {
    extensibleparameter: ExtensibleParameter
    extensibleparameter, ok = extensibleparameter_new1(
        src.name,
        src.type_name,
        src.attribute,
        i32(src.direction),
        src.initial_value,
        src.description,
    )
    if !ok do return
    defer if !ok do release(extensibleparameter)

    ok = access_level(extensibleparameter, src.access_level)
    if !ok do return
    ok = safety_type(extensibleparameter, src.safety_type)
    if !ok do return
    ok = fdport(extensibleparameter, src.fd_port)
    if !ok do return

    // type_guid / type_path are read-only

    return extensibleparameter, true
}

extensibleparameters_from_com :: proc(eparams: ExtensibleParameters, allocator := context.allocator) -> (result: [dynamic]t.Parameter, ok: bool) {
    if eparams == nil do return
    context.allocator = allocator

    count: i32
    count, ok = extensibleparameter_count(eparams)
    if !ok do return

    result = make([dynamic]t.ExtensibleParameter, 0, int(count), allocator)
    for i in 0..<count {
        ep: ExtensibleParameter
        ep, ok = extensibleparameter_by_index(eparams, i)
        if !ok do return
        defer release(ep)

        eps: t.ExtensibleParameter
        eps, ok = extensibleparameter_from_com(ep)
        if !ok do return
        append(&result, eps)
    }
    return result, true
}

extensibleparameters_to_com :: proc(eparams: ExtensibleParameters, src: []t.Parameter) -> (ok: bool) {
    if eparams == nil do return
    for item in src {
        ep: ExtensibleParameter
        ep, ok = extensibleparameter_to_com(item)
        if !ok do return
        defer release(ep)

        ok = extensibleparameter_add(eparams, ep)
        if !ok do return
    }
    return true
}
