package cbopenif

import "com"

ConnectedApplication :: struct {
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

ApplicationProperties :: struct {
    application_type: string,
    sil_level:        string,
    simulation_mark:  bool,
    // add more fields as they surface from the COM interface
}

ApplicationVariables :: struct {
    description: string,
    variables:   [dynamic]Variable,
    signals:     [dynamic]Signal,
}

applicationproperties_from_com :: proc(ap: ApplicationProperties, allocator := context.allocator) -> (result: t.ApplicationProperties, ok: bool) {
    if ap == nil do return

    context.allocator = allocator

    result.sil_level, ok = sil_level(ap)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(ap)
    if !ok do return
    result.application_type, ok = application_type(ap)
    if !ok do return

    return result, true
}

applicationproperties_to_com :: proc(src: t.ApplicationProperties) -> (result: ApplicationProperties, ok: bool) {
    ap: ApplicationProperties
    ap, ok = applicationproperties_new(src.sil_level, src.simulation_mark)
    if !ok do return

    // application_type is get-only

    return ap, true
}

applicationvariables_from_com :: proc(av: ApplicationVariables, allocator := context.allocator) -> (result: t.ApplicationVariables, ok: bool) {
    if av == nil do return

    context.allocator = allocator

    result.description, ok = description(av)
    if !ok do return

    {
        gvars: GlobalVariables
        gvars, ok = globalvariables(av)
        if !ok do return
        defer release(gvars)
        result.variables, ok = globalvariables_from_com(gvars)
        if !ok do return
    }
    {
        vars: Variables
        vars, ok = variables(av)
        if !ok do return
        defer release(vars)
        result.variables, ok = variables_from_com(vars)
        if !ok do return
    }
    {
        sigs: Signals
        sigs, ok = signals(av)
        if !ok do return
        defer release(sigs)
        result.signals, ok = signals_from_com(sigs)
        if !ok do return
    }

    return result, true
}

applicationvariables_to_com :: proc(src: t.ApplicationVariables) -> (result: ApplicationVariables, ok: bool) {
    av: ApplicationVariables
    av, ok = applicationvariables_new(src.description)
    if !ok do return
    defer if !ok do release(av)

    {
        gvars: GlobalVariables
        gvars, ok = globalvariables(av)
        if !ok do return
        defer release(gvars)
        ok = globalvariables_to_com(gvars, src.globals[:])
        if !ok do return
    }
    {
        vars: Variables
        vars, ok = variables(av)
        if !ok do return
        defer release(vars)
        ok = variables_to_com(vars, src.variables[:])
        if !ok do return
    }
    {
        sigs: Signals
        sigs, ok = signals(av)
        if !ok do return
        defer release(sigs)
        ok = signals_to_com(sigs, src.signals[:])
        if !ok do return
    }

    return av, true
}

connectedapplication_from_com :: proc(ca: ConnectedApplication, allocator := context.allocator) -> (result: t.ConnectedApplication, ok: bool) {
    if ca == nil do return

    context.allocator = allocator

    result.name, ok = name(ca)
    if !ok do return
    result.major_version, ok = major_version(ca)
    if !ok do return
    result.minor_version, ok = minor_version(ca)
    if !ok do return
    result.revision, ok = revision(ca)
    if !ok do return

    return result, true
}

connectedapplication_to_com :: proc(src: t.ConnectedApplication) -> (result: ConnectedApplication, ok: bool) {
    ca: ConnectedApplication
    ca, ok = connectedapplication_new1(src.name, src.major_version, src.minor_version, src.revision)
    if !ok do return

    return ca, true
}

connectedapplications_from_com :: proc(cas: ConnectedApplications, allocator := context.allocator) -> (result: [dynamic]t.ConnectedApplication, ok: bool) {
    if cas == nil do return
    context.allocator = allocator

    count: i32
    count, ok = connectedapplication_count(cas)
    if !ok do return

    result = make([dynamic]t.ConnectedApplication, 0, int(count), allocator)
    for i in 0..<count {
        ca: ConnectedApplication
        ca, ok = connectedapplication_by_index(cas, i)
        if !ok do return
        defer release(ca)

        cas_: t.ConnectedApplication
        cas_, ok = connectedapplication_from_com(ca)
        if !ok do return
        append(&result, cas_)
    }
    return result, true
}

connectedapplications_to_com :: proc(cas: ConnectedApplications, src: []t.ConnectedApplication) -> (ok: bool) {
    if cas == nil do return
    for item in src {
        ca: ConnectedApplication
        ca, ok = connectedapplication_to_com(item)
        if !ok do return
        defer release(ca)
        ok = connectedapplication_add(cas, ca)
        if !ok do return
    }
    return true
}
