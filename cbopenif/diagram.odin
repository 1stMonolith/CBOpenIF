package cbopenif

import "com"

DiagramType :: struct {
    name:                         string,
    description:                  string,
    protected:                    bool,
    hidden:                       bool,
    scope:                        Scope,
    guid:                         string,
    reserved_by_function:         string,
    sil_level:                    string,
    restricted_sil:               bool,
    alarm_owner:                  bool,
    batch_object:                 string,
    instantiate_as_aspect_object: bool,
    simulation_mark:              bool,
    embedded_graphics_visible:    bool,
    parameters:                   [dynamic]Parameter,
    variables:                    [dynamic]Variable,
    code_blocks:                  [dynamic]CodeBlock,
    function_blocks:              [dynamic]FunctionBlock,
    control_modules:              [dynamic]ControlModule,
    diagram_instances:            [dynamic]DiagramInstance,
}

Diagram :: struct {
    name:                   string,
    description:            string,
    access_level:           string,
    safety_type:            string,
    task_connection:        string,
    simulation_mark:        bool,
    sil_level:              string,
    restricted_sil:         bool,
    batch_object:           string,
    inst_guid:              string,
    type_guid:              string,
    reserved_by_function:   string,
    variables:              [dynamic]Variable,
    signals:                [dynamic]Signal,
    code_blocks:            [dynamic]CodeBlock,
    function_blocks:        [dynamic]FunctionBlock,
    control_modules:        [dynamic]ControlModule,
    diagram_instances:      [dynamic]DiagramInstance,
    init_values:            [dynamic]InitValue,
}

DiagramInstance :: struct {
    name:                        string,
    type_name:                   string,
    description:                 string,
    access_level:                string,
    safety_type:                 string,
    aspect_object:               bool,
    expose_properties_in_parent: bool,
    guid:                       string,
    type_guid:                  string,
    type_path:                  string,
}

diagram_from_com :: proc(diagram: Diagram, allocator := context.allocator) -> (result: t.Diagram, ok: bool) {
    if diagram == nil do return
    context.allocator = allocator

    result.name, ok = name(diagram)
    if !ok do return
    result.description, ok = description(diagram)
    if !ok do return
    result.access_level, ok = access_level(diagram)
    if !ok do return
    result.safety_type, ok = safety_type(diagram)
    if !ok do return
    result.task_connection, ok = task_connection(diagram)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(diagram)
    if !ok do return
    result.sil_level, ok = sil_level(diagram)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(diagram)
    if !ok do return
    // needs types: batch_object: string
    result.batch_object, ok = diagram_batch_object_get(diagram)
    if !ok do return
    result.inst_guid, ok = inst_guid(diagram)
    if !ok do return
    result.type_guid, ok = type_guid(diagram)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(diagram)
    if !ok do return

    {
        c: Variables
        c, ok = variables(diagram)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(diagram)
        if !ok do return
        defer release(c)
        result.signals, ok = signals_from_com(c)
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(diagram)
        if !ok do return
        defer release(c)
        result.comm_variables, ok = commvariables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(diagram)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(diagram)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(diagram)
        if !ok do return
        defer release(c)
        result.control_modules, ok = controlmodules_from_com(c)
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(diagram)
        if !ok do return
        defer release(c)
        result.diagram_instances, ok = diagraminstances_from_com(c)
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(diagram)
        if !ok do return
        defer release(c)
        result.init_values, ok = initvalues_from_com(c)
        if !ok do return
    }

    return result, true
}

diagram_to_com :: proc(src: t.Diagram) -> (result: Diagram, ok: bool) {
    diagram: Diagram
    diagram, ok = diagram_new1(
        src.name,
        src.description,
        src.task_connection,
        src.type_guid,
        src.inst_guid,
    )
    if !ok do return
    defer if !ok do release(diagram)

    ok = access_level(diagram, src.access_level)
    if !ok do return
    ok = safety_type(diagram, src.safety_type)
    if !ok do return
    ok = simulation_mark(diagram, src.simulation_mark)
    if !ok do return
    ok = sil_level(diagram, src.sil_level)
    if !ok do return
    ok = restricted_sil(diagram, src.restricted_sil)
    if !ok do return
    ok = diagram_batch_object_set(diagram, src.batch_object)
    if !ok do return
    ok = reserved_by_function(diagram, src.reserved_by_function)
    if !ok do return

    {
        c: Variables
        c, ok = variables(diagram)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(diagram)
        if !ok do return
        defer release(c)
        ok = signals_to_com(c, src.signals[:])
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(diagram)
        if !ok do return
        defer release(c)
        ok = commvariables_to_com(c, src.comm_variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(diagram)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(diagram)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(diagram)
        if !ok do return
        defer release(c)
        ok = controlmodules_to_com(c, src.control_modules[:])
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(diagram)
        if !ok do return
        defer release(c)
        ok = diagraminstances_to_com(c, src.diagram_instances[:])
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(diagram)
        if !ok do return
        defer release(c)
        ok = initvalues_to_com(c, src.init_values[:])
        if !ok do return
    }

    return diagram, true
}

diagraminstance_from_com :: proc(di: DiagramInstance, allocator := context.allocator) -> (result: t.DiagramInstance, ok: bool) {
    if di == nil do return
    context.allocator = allocator

    result.name, ok = name(di)
    if !ok do return
    result.type_name, ok = type_name(di)
    if !ok do return
    result.description, ok = description(di)
    if !ok do return
    result.access_level, ok = access_level(di)
    if !ok do return
    result.safety_type, ok = safety_type(di)
    if !ok do return
    result.aspect_object, ok = aspect_object(di)
    if !ok do return
    result.expose_properties_in_parent, ok = expose_properties_in_parent(di)
    if !ok do return
    result.guid, ok = guid(di)
    if !ok do return
    result.type_guid, ok = type_guid(di)
    if !ok do return
    result.type_path, ok = type_path(di)
    if !ok do return

    return result, true
}

diagraminstance_to_com :: proc(src: t.DiagramInstance) -> (result: DiagramInstance, ok: bool) {
    di: DiagramInstance
    di, ok = diagraminstance_new1(src.name, src.type_name, src.guid, src.description)
    if !ok do return
    defer if !ok do release(di)

    ok = access_level(di, src.access_level)
    if !ok do return
    ok = safety_type(di, src.safety_type)
    if !ok do return
    ok = aspect_object(di, src.aspect_object)
    if !ok do return
    ok = expose_properties_in_parent(di, src.expose_properties_in_parent)
    if !ok do return
    // type_guid / type_path read-only

    return di, true
}

diagraminstances_from_com :: proc(dis: DiagramInstances, allocator := context.allocator) -> (result: [dynamic]t.DiagramInstance, ok: bool) {
    if dis == nil do return
    context.allocator = allocator

    count: i32
    count, ok = diagraminstance_count(dis)
    if !ok do return

    result = make([dynamic]t.DiagramInstance, 0, int(count), allocator)
    for i in 0..<count {
        di: DiagramInstance
        di, ok = diagraminstance_by_index(dis, i)
        if !ok do return
        defer release(di)

        dis_: t.DiagramInstance
        dis_, ok = diagraminstance_from_com(di)
        if !ok do return
        append(&result, dis_)
    }
    return result, true
}

diagraminstances_to_com :: proc(dis: DiagramInstances, src: []t.DiagramInstance) -> (ok: bool) {
    if dis == nil do return
    for item in src {
        di: DiagramInstance
        di, ok = diagraminstance_to_com(item)
        if !ok do return
        defer release(di)

        ok = diagraminstance_add(dis, di)
        if !ok do return
    }
    return true
}

diagramtype_from_com :: proc(dt: DiagramType, allocator := context.allocator) -> (result: t.DiagramType, ok: bool) {
    if dt == nil do return
    context.allocator = allocator

    result.name, ok = name(dt)
    if !ok do return
    result.description, ok = description(dt)
    if !ok do return
    result.protected, ok = protected(dt)
    if !ok do return
    result.hidden, ok = hidden(dt)
    if !ok do return
    result.scope, ok = scope(dt)
    if !ok do return
    result.guid, ok = guid(dt)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(dt)
    if !ok do return
    result.sil_level, ok = sil_level(dt)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(dt)
    if !ok do return
    result.alarm_owner, ok = alarm_owner(dt)
    if !ok do return
    // needs types: batch_object: string
    result.batch_object, ok = diagramtype_batch_object_get(dt)
    if !ok do return
    result.instantiate_as_aspect_object, ok = instantiate_as_aspect_object(dt)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(dt)
    if !ok do return
    result.embedded_graphics_visible, ok = diagramtype_embedded_graphics_visible_get(dt)
    if !ok do return

    {
        c: Parameters
        c, ok = parameters(dt)
        if !ok do return
        defer release(c)
        result.parameters, ok = parameters_from_com(c)
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(dt)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(dt)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(dt)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(dt)
        if !ok do return
        defer release(c)
        result.control_modules, ok = controlmodules_from_com(c)
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(dt)
        if !ok do return
        defer release(c)
        result.diagram_instances, ok = diagraminstances_from_com(c)
        if !ok do return
    }

    return result, true
}

diagramtype_to_com :: proc(src: t.DiagramType) -> (result: DiagramType, ok: bool) {
    dt: DiagramType
    dt, ok = diagramtype_new1(
        src.name,
        src.description,
        src.protected,
        src.hidden,
        src.scope,
        src.alarm_owner,
        src.guid,
    )
    if !ok do return
    defer if !ok do release(dt)

    ok = reserved_by_function(dt, src.reserved_by_function)
    if !ok do return
    ok = sil_level(dt, src.sil_level)
    if !ok do return
    ok = restricted_sil(dt, src.restricted_sil)
    if !ok do return
    ok = diagramtype_batch_object_set(dt, src.batch_object)
    if !ok do return
    ok = instantiate_as_aspect_object(dt, src.instantiate_as_aspect_object)
    if !ok do return
    ok = simulation_mark(dt, src.simulation_mark)
    if !ok do return
    ok = diagramtype_embedded_graphics_visible_set(dt, src.embedded_graphics_visible)
    if !ok do return

    {
        c: Parameters
        c, ok = parameters(dt)
        if !ok do return
        defer release(c)
        ok = parameters_to_com(c, src.parameters[:])
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(dt)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(dt)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(dt)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(dt)
        if !ok do return
        defer release(c)
        ok = controlmodules_to_com(c, src.control_modules[:])
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(dt)
        if !ok do return
        defer release(c)
        ok = diagraminstances_to_com(c, src.diagram_instances[:])
        if !ok do return
    }

    return dt, true
}
