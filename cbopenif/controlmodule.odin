package cbopenif

import "core:strings"
import "core:fmt"

import "com"

ControlModuleKind :: enum i32 {
    ControlModule       = 0,
    SingleControlModule = 1,
}

ControlModuleType :: struct {
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
    interaction_window:           string,
    instantiate_as_aspect_object: bool,
    simulation_mark:              bool,
    embedded_graphics_visible:    bool,
    cm_graphics:                  string,
    graph_size:                   GraphSize,
    cm_parameters:                [dynamic]Parameter,
    variables:                    [dynamic]Variable,
    code_blocks:                  [dynamic]CodeBlock,
    function_blocks:              [dynamic]FunctionBlock,
    control_modules:              [dynamic]ControlModule,
}

ControlModule :: struct {
    kind:                        ControlModuleKind,
    name:                        string,
    type_name:                   string,
    description:                 string,
    access_level:                string,
    safety_type:                 string,
    guid:                        string,
    inst_guid:                   string,
    aspect_object:               bool,
    expose_properties_in_parent: bool,
    task_connection:             string,
    instance_graphics:           string,
    visibility_in_graphics:      bool,
    graph_pos:                   GraphPos,
    type_guid:                   string,
    type_path:                   string,
    cm_connections:              [dynamic]CMConnection,
}

CMConnection :: struct {
    name:                 string,
    actual_parameter:     string,
    graphical_connection: bool,
    points:               [dynamic]Point,
}

controlmoduletype_new :: proc (library_name: string, controlmoduletype: ControlModuleType) {
    ok: bool
    ccmt: com.ControlModuleType
    xml, msg: string

    ccmt, ok = com.controlmoduletype_to_com(controlmoduletype)
    defer com.release(ccmt)
    xml, ok = com.controlmoduletype_serialize(ccmt)

    fmt.print(xml)

    msg, ok = com.controlmoduletype_new(controlmoduletype.name, library_name, xml)
}

controlmoduletype_get :: proc (library_name, controlmoduletype_name: string) -> (controlmoduletype: ControlModuleType) {
    ok: bool
    ccmt: com.ControlModuleType
    cmt: ControlModuleType
    xml: string

    path := strings.concatenate({library_name, ".", controlmoduletype_name})
    defer delete(path)

    xml, ok = com.controlmoduletype_get(path)
    fmt.print(xml)
    ccmt, ok = com.controlmoduletype_deserialize(xml)
    defer com.release(ccmt)
    cmt, ok = com.controlmoduletype_from_com(ccmt)

    return cmt
}

controlmoduletype_set :: proc () {
    
}

controlmoduletype_rename :: proc () {
    
}

controlmoduletype_insert :: proc () {
    
}

controlmoduletype_delete :: proc () {
    
}

controlmodule_from_com :: proc(cm: ControlModule, allocator := context.allocator) -> (result: t.ControlModule, ok: bool) {
    if cm == nil do return
    context.allocator = allocator

    result.name, ok = name(cm)
    if !ok do return
    result.type_name, ok = type_name(cm)
    if !ok do return
    result.description, ok = description(cm)
    if !ok do return
    result.access_level, ok = access_level(cm)
    if !ok do return
    result.safety_type, ok = safety_type(cm)
    if !ok do return
    result.aspect_object, ok = aspect_object(cm)
    if !ok do return
    result.expose_properties_in_parent, ok = expose_properties_in_parent(cm)
    if !ok do return
    result.task_connection, ok = task_connection(cm)
    if !ok do return
    result.instance_graphics, ok = instance_graphics(cm)
    if !ok do return
    result.visibility_in_graphics, ok = controlmodule_visibility_in_graphics_get(cm)
    if !ok do return
    result.type_guid, ok = type_guid(cm)
    if !ok do return
    result.type_path, ok = type_path(cm)
    if !ok do return

    {
        gp: GraphPos
        gp, ok = graphpos(cm)
        if !ok do return
        defer release(gp)
        result.graph_pos, ok = graphpos_from_com(gp)
        if !ok do return
    }
    {
        c: CMConnections
        c, ok = cmconnections(cm)
        if !ok do return
        defer release(c)
        result.cm_connections, ok = cmconnections_from_com(c)
        if !ok do return
    }

    return result, true
}

controlmodule_to_com :: proc(src: t.ControlModule) -> (result: ControlModule, ok: bool) {
    gp: GraphPos
    gp, ok = graphpos_to_com(src.graph_pos)
    if !ok do return
    defer release(gp)

    vis: i32 = 1 if src.visibility_in_graphics else 0  // after types → bool

    cm: ControlModule
    cm, ok = controlmodule_new1(
        src.name,
        src.type_name,
        src.task_connection,
        vis,
        src.guid,
        src.description,
        gp,
    )
    if !ok do return
    defer if !ok do release(cm)

    ok = access_level(cm, src.access_level)
    if !ok do return
    ok = safety_type(cm, src.safety_type)
    if !ok do return
    ok = aspect_object(cm, src.aspect_object)
    if !ok do return
    ok = expose_properties_in_parent(cm, src.expose_properties_in_parent)
    if !ok do return
    ok = instance_graphics(cm, src.instance_graphics)
    if !ok do return
    ok = controlmodule_visibility_in_graphics_set(cm, src.visibility_in_graphics)
    if !ok do return
    // type_guid / type_path read-only

    {
        c: CMConnections
        c, ok = cmconnections(cm)
        if !ok do return
        defer release(c)
        ok = cmconnections_to_com(c, src.cm_connections[:])
        if !ok do return
    }

    return cm, true
}

controlmodules_from_com :: proc(cms: ControlModules, allocator := context.allocator) -> (dcm: [dynamic]t.ControlModule, ok: bool) {
    if cms == nil do return
    context.allocator = allocator

    count: i32
    count, ok = controlmodule_count(cms)
    if !ok do return

    dcm = make([dynamic]t.ControlModule, 0, int(count), allocator)
    for i in 0..<count {
        im: IControlModule
        im, ok = controlmodules_icontrolmodule_by_index(cms, i)
        if !ok do return
        defer release(im)
        
        is_single: bool
        is_single, ok = icontrolmodule_is_singlecontrolmodule(im)
        if !ok do return

        cms: t.ControlModule
        if is_single {
            cm: ControlModule
            cm, ok = icontrolmodule_as_controlmodule(im)
            if !ok do return
            defer release(cm)

            cms, ok = controlmodule_from_com(cm)
            if !ok do return
            append(&dcm, cms)
        } else {
            scm: SingleControlModule
            scm, ok = icontrolmodule_as_singlecontrolmodule(im)
            if !ok do return
            defer release(scm)

            cms, ok = singlecontrolmodule_from_com(scm)
            if !ok do return
            append(&dcm, cms)
        }
    }

    return {}, false
}

controlmodules_to_com :: proc(cms: ControlModules, dcm: []t.ControlModule) -> (ok: bool) {
    if cms == nil do return

    for m in dcm {

        if m.kind == .ControlModule {
            cm: ControlModule
            cm, ok = controlmodule_to_com(m)
            if !ok do return
            defer release(cm)

            _, ok = controlmodules_controlmodule_add(cms, m.name, m.type_name)
            if !ok do return
        }

        if m.kind == .SingleControlModule {
            scm: SingleControlModule
            scm, ok = singlecontrolmodule_to_com(m)
            if !ok do return
            defer release(scm)

            _, ok = controlmodules_singlecontrolmodule_add(cms, m.name)
            if !ok do return
        }
    }

    return true
}

controlmoduletype_from_com :: proc(cmt: ControlModuleType, allocator := context.allocator) -> (result: t.ControlModuleType, ok: bool) {
    if cmt == nil do return
    context.allocator = allocator

    result.name, ok = name(cmt)
    if !ok do return
    result.description, ok = description(cmt)
    if !ok do return
    result.protected, ok = protected(cmt)
    if !ok do return
    result.hidden, ok = hidden(cmt)
    if !ok do return
    result.scope, ok = scope(cmt)
    if !ok do return
    result.guid, ok = guid(cmt)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(cmt)
    if !ok do return
    result.sil_level, ok = sil_level(cmt)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(cmt)
    if !ok do return
    result.alarm_owner, ok = alarm_owner(cmt)
    if !ok do return
    result.batch_object, ok = controlmoduletype_batch_object_get(cmt)
    if !ok do return
    result.interaction_window, ok = interaction_window(cmt)
    if !ok do return
    result.instantiate_as_aspect_object, ok = instantiate_as_aspect_object(cmt)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(cmt)
    if !ok do return
    result.embedded_graphics_visible, ok = controlmoduletype_embedded_graphiscs_visible_get(cmt)
    if !ok do return
    result.cm_graphics, ok = controlmoduletype_cmgraphics_get(cmt)
    if !ok do return

    {
        gs: GraphSize
        gs, ok = graphsize(cmt)
        if !ok do return
        defer release(gs)
        result.graph_size, ok = graphsize_from_com(gs)
        if !ok do return
    }
    {
        c: CMParameters
        c, ok = cmparameters(cmt)
        if !ok do return
        defer release(c)
        result.cm_parameters, ok = cmparameters_from_com(c)
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(cmt)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: ExternalVariables
        c, ok = externalvariables(cmt)
        if !ok do return
        defer release(c)
        result.external_variables, ok = externalvariables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(cmt)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(cmt)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(cmt)
        if !ok do return
        defer release(c)
        result.control_modules, ok = controlmodules_from_com(c)
        if !ok do return
    }

    return result, true
}

controlmoduletype_to_com :: proc(src: t.ControlModuleType) -> (result: ControlModuleType, ok: bool) {
    gs: GraphSize
    gs, ok = graphsize_to_com(src.graph_size)
    if !ok do return
    defer release(gs)

    cmt: ControlModuleType
    cmt, ok = controlmoduletype_new1(
        src.name,
        src.description,
        src.protected,
        src.hidden,
        src.scope,
        src.interaction_window,
        src.alarm_owner,
        src.guid,
        gs,
    )
    if !ok do return
    defer if !ok do release(cmt)

    ok = reserved_by_function(cmt, src.reserved_by_function)
    if !ok do return
    ok = sil_level(cmt, src.sil_level)
    if !ok do return
    ok = restricted_sil(cmt, src.restricted_sil)
    if !ok do return
    ok = controlmoduletype_batch_object_set(cmt, src.batch_object)
    if !ok do return
    ok = instantiate_as_aspect_object(cmt, src.instantiate_as_aspect_object)
    if !ok do return
    ok = simulation_mark(cmt, src.simulation_mark)
    if !ok do return
    ok = controlmoduletype_embedded_graphiscs_visible_set(cmt, src.embedded_graphics_visible)
    if !ok do return
    ok = controlmoduletype_cmgraphics_set(cmt, src.cm_graphics)
    if !ok do return

    {
        c: CMParameters
        c, ok = cmparameters(cmt)
        if !ok do return
        defer release(c)
        ok = cmparameters_to_com(c, src.cm_parameters[:])
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(cmt)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: ExternalVariables
        c, ok = externalvariables(cmt)
        if !ok do return
        defer release(c)
        ok = externalvariables_to_com(c, src.external_variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(cmt)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(cmt)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(cmt)
        if !ok do return
        defer release(c)
        ok = controlmodules_to_com(c, src.control_modules[:])
        if !ok do return
    }

    return cmt, true
}

singlecontrolmodule_from_com :: proc(inst: SingleControlModule, allocator := context.allocator) -> (result: t.ControlModule, ok: bool) {
    if inst == nil do return
    context.allocator = allocator

    result.name, ok = name(inst)
    if !ok do return
    result.description, ok = description(inst)
    if !ok do return
    result.access_level, ok = access_level(inst)
    if !ok do return
    result.safety_type, ok = safety_type(inst)
    if !ok do return
    result.task_connection, ok = task_connection(inst)
    if !ok do return
    result.instance_graphics, ok = instance_graphics(inst)
    if !ok do return
    result.visibility_in_graphics, ok = singlecontrolmodule_visibility_in_graphics_get(inst)
    if !ok do return
    result.inst_guid, ok = inst_guid(inst)
    if !ok do return
    result.type_guid, ok = type_guid(inst)
    if !ok do return

    {
        gp: GraphPos
        gp, ok = graphpos(inst)
        if !ok do return
        defer release(gp)
        result.graph_pos, ok = graphpos_from_com(gp)
        if !ok do return
    }
    {
        c: CMConnections
        c, ok = cmconnections(inst)
        if !ok do return
        defer release(c)
        result.cm_connections, ok = cmconnections_from_com(c)
        if !ok do return
    }

    return result, true
}

singlecontrolmodule_to_com :: proc(src: t.ControlModule) -> (result: SingleControlModule, ok: bool) {
    gp: GraphPos
    gp, ok = graphpos_to_com(src.graph_pos)
    if !ok do return
    defer release(gp)

    vis: i32 = 1 if src.visibility_in_graphics else 0

    inst: SingleControlModule
    inst, ok = singlecontrolmodule_new1(
        src.name,
        src.task_connection,
        vis,
        src.type_guid,
        src.inst_guid,
        gp,
    )
    if !ok do return
    defer if !ok do release(inst)

    ok = description(inst, src.description)
    if !ok do return
    ok = access_level(inst, src.access_level)
    if !ok do return
    ok = safety_type(inst, src.safety_type)
    if !ok do return
    ok = instance_graphics(inst, src.instance_graphics)
    if !ok do return
    ok = singlecontrolmodule_visibility_in_graphics_set(inst, src.visibility_in_graphics)
    if !ok do return

    {
        c: CMConnections
        c, ok = cmconnections(inst)
        if !ok do return
        defer release(c)
        ok = cmconnections_to_com(c, src.cm_connections[:])
        if !ok do return
    }

    return inst, true
}

cmconnection_from_com :: proc(c: CMConnection, allocator := context.allocator) -> (result: t.CMConnection, ok: bool) {
    if c == nil do return
    context.allocator = allocator

    result.name, ok = name(c)
    if !ok do return
    result.actual_parameter, ok = actual_parameter(c)
    if !ok do return
    result.graphical_connection, ok = graphical_connection(c)
    if !ok do return

    {
        pts: Points
        pts, ok = points(c)
        if !ok do return
        defer release(pts)
        result.points, ok = points_from_com(pts)
        if !ok do return
    }

    return result, true
}

cmconnection_to_com :: proc(src: t.CMConnection) -> (result: CMConnection, ok: bool) {
    c: CMConnection
    c, ok = cmconnection_new1(src.name, src.actual_parameter, src.graphical_connection)
    if !ok do return
    defer if !ok do release(c)

    {
        pts: Points
        pts, ok = points(c)
        if !ok do return
        defer release(pts)
        ok = points_to_com(pts, src.points[:])
        if !ok do return
    }

    return c, true
}

cmconnections_from_com :: proc(conns: CMConnections, allocator := context.allocator) -> (result: [dynamic]t.CMConnection, ok: bool) {
    if conns == nil do return
    context.allocator = allocator

    count: i32
    count, ok = cmconnection_count(conns)
    if !ok do return

    result = make([dynamic]t.CMConnection, 0, int(count), allocator)
    for i in 0..<count {
        c: CMConnection
        c, ok = cmconnection_by_index(conns, i)
        if !ok do return
        defer release(c)

        cs: t.CMConnection
        cs, ok = cmconnection_from_com(c)
        if !ok do return
        append(&result, cs)
    }
    return result, true
}

cmconnections_to_com :: proc(conns: CMConnections, src: []t.CMConnection) -> (ok: bool) {
    if conns == nil do return
    for item in src {
        c: CMConnection
        c, ok = cmconnection_to_com(item)
        if !ok do return
        defer release(c)

        ok = cmconnection_add(conns, c)
        if !ok do return
    }
    return true
}

cmparameter_from_com :: proc(p: CMParameter, allocator := context.allocator) -> (result: t.Parameter, ok: bool) {
    if p == nil do return
    context.allocator = allocator

    result.name, ok = name(p)
    if !ok do return
    result.type_name, ok = type_name(p)
    if !ok do return
    result.direction, ok = direction(p)
    if !ok do return
    result.initial_value, ok = initial_value(p)
    if !ok do return
    result.description, ok = description(p)
    if !ok do return
    result.read_permission, ok = read_permission(p)
    if !ok do return
    result.write_permission, ok = write_permission(p)
    if !ok do return
    result.authentication_level, ok = authentication_level(p)
    if !ok do return
    result.access_level, ok = access_level(p)
    if !ok do return
    result.safety_type, ok = safety_type(p)
    if !ok do return
    result.batch_property, ok = batch_property(p)
    if !ok do return
    result.fd_port, ok = fdport(p)
    if !ok do return
    result.type_guid, ok = type_guid(p)
    if !ok do return
    result.type_path, ok = type_path(p)
    if !ok do return

    {
        ap: AutoPoint
        ap, ok = autopoint(p)
        if !ok do return
        defer release(ap)
        result.auto_point, ok = autopoint_from_com(ap)
        if !ok do return
    }
    {
        nodes: GraphNodes
        nodes, ok = graphnodes(p)
        if !ok do return
        defer release(nodes)
        result.graph_nodes, ok = graphnodes_from_com(nodes)
        if !ok do return
    }

    return result, true
}

cmparameter_to_com :: proc(src: t.Parameter) -> (result: CMParameter, ok: bool) {
    ap: AutoPoint
    ap, ok = autopoint_to_com(src.auto_point)
    if !ok do return
    defer release(ap)

    p: CMParameter
    p, ok = cmparameter_new1(
        src.name,
        src.type_name,
        src.initial_value,
        src.read_permission,
        src.write_permission,
        src.description,
        ap,
    )
    if !ok do return
    defer if !ok do release(p)

    ok = direction(p, src.direction)
    if !ok do return
    ok = authentication_level(p, src.authentication_level)
    if !ok do return
    ok = access_level(p, src.access_level)
    if !ok do return
    ok = safety_type(p, src.safety_type)
    if !ok do return
    ok = batch_property(p, src.batch_property)
    if !ok do return
    ok = fdport(p, src.fd_port)
    if !ok do return
    // type_guid / type_path read-only

    {
        nodes: GraphNodes
        nodes, ok = graphnodes(p)
        if !ok do return
        defer release(nodes)
        ok = graphnodes_to_com(nodes, src.graph_nodes[:])
        if !ok do return
    }

    return p, true
}

cmparameters_from_com :: proc(params: CMParameters, allocator := context.allocator) -> (result: [dynamic]t.Parameter, ok: bool) {
    if params == nil do return
    context.allocator = allocator

    count: i32
    count, ok = cmparameter_count(params)
    if !ok do return

    result = make([dynamic]t.CMParameter, 0, int(count), allocator)
    for i in 0..<count {
        p: CMParameter
        p, ok = cmparameter_by_index(params, i)
        if !ok do return
        defer release(p)

        ps: t.CMParameter
        ps, ok = cmparameter_from_com(p)
        if !ok do return
        append(&result, ps)
    }
    return result, true
}

cmparameters_to_com :: proc(params: CMParameters, src: []t.Parameter) -> (ok: bool) {
    if params == nil do return
    for item in src {
        p: CMParameter
        p, ok = cmparameter_to_com(item)
        if !ok do return
        defer release(p)

        ok = cmparameter_add(params, p)
        if !ok do return
    }
    return true
}
