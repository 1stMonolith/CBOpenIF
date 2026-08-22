package cbopenif

import "com"

FunctionBlockType :: struct {
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
    interaction_window:           string,
    instantiate_as_aspect_object: bool,
    simulation_mark:              bool,
    embedded_graphics_visible:    bool,
    parameters:                   [dynamic]Parameter,
    variables:                    [dynamic]Variable,
    code_blocks:                  [dynamic]CodeBlock,
    function_blocks:              [dynamic]FunctionBlock,
}

FunctionBlock :: struct {
    name:                        string,
    type_name:                   string,
    description:                 string,
    access_level:                string,
    safety_type:                 string,
    aspect_object:               bool,
    expose_properties_in_parent: bool,
    task_connection:             string,
    type_guid:                   string,
    type_path:                   string,
}

functionblock_from_com :: proc(fb: FunctionBlock, allocator := context.allocator) -> (result: t.FunctionBlock, ok: bool) {
    if fb == nil do return
    context.allocator = allocator

    result.name, ok = name(fb)
    if !ok do return
    result.type_name, ok = type_name(fb)
    if !ok do return
    result.description, ok = description(fb)
    if !ok do return
    result.access_level, ok = access_level(fb)
    if !ok do return
    result.safety_type, ok = safety_type(fb)
    if !ok do return
    result.aspect_object, ok = aspect_object(fb)
    if !ok do return
    result.expose_properties_in_parent, ok = expose_properties_in_parent(fb)
    if !ok do return
    result.task_connection, ok = task_connection(fb)
    if !ok do return
    result.type_guid, ok = type_guid(fb)
    if !ok do return
    result.type_path, ok = type_path(fb)
    if !ok do return

    return result, true
}

functionblock_to_com :: proc(src: t.FunctionBlock) -> (result: FunctionBlock, ok: bool) {
    fb: FunctionBlock
    fb, ok = functionblock_new1(src.name, src.type_name, src.task_connection, "", src.description)
    if !ok do return
    defer if !ok do release(fb)

    ok = access_level(fb, src.access_level)
    if !ok do return
    ok = safety_type(fb, src.safety_type)
    if !ok do return
    ok = aspect_object(fb, src.aspect_object)
    if !ok do return
    ok = expose_properties_in_parent(fb, src.expose_properties_in_parent)
    if !ok do return
    
    // type_guid / type_path read-only

    return fb, true
}

functionblocks_from_com :: proc(fbs: FunctionBlocks, allocator := context.allocator) -> (result: [dynamic]t.FunctionBlock, ok: bool) {
    if fbs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = functionblocks_functionblock_count(fbs)
    if !ok do return

    result = make([dynamic]t.FunctionBlock, 0, int(count), allocator)
    for i in 0..<count {
        fb: FunctionBlock
        fb, ok = functionblocks_functionblock_by_index(fbs, i)
        if !ok do return
        defer release(fb)

        fbs_: t.FunctionBlock
        fbs_, ok = functionblock_from_com(fb)
        if !ok do return
        append(&result, fbs_)
    }
    return result, true
}

functionblocks_to_com :: proc(fbs: FunctionBlocks, src: []t.FunctionBlock) -> (ok: bool) {
    if fbs == nil do return
    for item in src {
        fb: FunctionBlock
        fb, ok = functionblock_to_com(item)
        if !ok do return
        defer release(fb)

        ok = functionblocks_functionblock_add(fbs, fb)
        if !ok do return
    }
    return true
}

functionblocktype_from_com :: proc(fbt: FunctionBlockType, allocator := context.allocator) -> (result: t.FunctionBlockType, ok: bool) {
    if fbt == nil do return
    context.allocator = allocator

    result.name, ok = name(fbt)
    if !ok do return
    result.description, ok = description(fbt)
    if !ok do return
    result.protected, ok = protected(fbt)
    if !ok do return
    result.hidden, ok = hidden(fbt)
    if !ok do return
    result.scope, ok = scope(fbt)
    if !ok do return
    result.guid, ok = guid(fbt)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(fbt)
    if !ok do return
    result.sil_level, ok = sil_level(fbt)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(fbt)
    if !ok do return
    result.alarm_owner, ok = alarm_owner(fbt)
    if !ok do return
    result.interaction_window, ok = interaction_window(fbt)
    if !ok do return
    result.instantiate_as_aspect_object, ok = instantiate_as_aspect_object(fbt)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(fbt)
    if !ok do return
    // visibility_In_graphics group is misnamed; use concrete until renamed
    result.embedded_graphics_visible, ok = functionblocktype_embedded_graphiscs_visible_get(fbt)
    if !ok do return

    {
        c: Parameters
        c, ok = parameters(fbt)
        if !ok do return
        defer release(c)
        result.parameters, ok = parameters_from_com(c)
        if !ok do return
    }
    {
        c: ExtensibleParameters
        c, ok = extensibleparameters(fbt)
        if !ok do return
        defer release(c)
        result.extensible_parameters, ok = extensibleparameters_from_com(c)
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(fbt)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: ExternalVariables
        c, ok = externalvariables(fbt)
        if !ok do return
        defer release(c)
        result.external_variables, ok = externalvariables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(fbt)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(fbt)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }

    return result, true
}

functionblocktype_to_com :: proc(src: t.FunctionBlockType) -> (result: FunctionBlockType, ok: bool) {
    fbt: FunctionBlockType
    fbt, ok = functionblocktype_new1(
        src.name, src.description, src.protected, src.hidden, src.scope,
        src.interaction_window, src.alarm_owner, src.guid,
    )
    if !ok do return
    defer if !ok do release(fbt)

    ok = reserved_by_function(fbt, src.reserved_by_function)
    if !ok do return
    ok = sil_level(fbt, src.sil_level)
    if !ok do return
    ok = restricted_sil(fbt, src.restricted_sil)
    if !ok do return
    ok = instantiate_as_aspect_object(fbt, src.instantiate_as_aspect_object)
    if !ok do return
    ok = simulation_mark(fbt, src.simulation_mark)
    if !ok do return
    ok = functionblocktype_embedded_graphiscs_visible_set(fbt, src.embedded_graphics_visible)
    if !ok do return

    {
        c: Parameters
        c, ok = parameters(fbt)
        if !ok do return
        defer release(c)
        ok = parameters_to_com(c, src.parameters[:])
        if !ok do return
    }
    {
        c: ExtensibleParameters
        c, ok = extensibleparameters(fbt)
        if !ok do return
        defer release(c)
        ok = extensibleparameters_to_com(c, src.extensible_parameters[:])
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(fbt)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: ExternalVariables
        c, ok = externalvariables(fbt)
        if !ok do return
        defer release(c)
        ok = externalvariables_to_com(c, src.external_variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(fbt)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(fbt)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }

    return fbt, true
}
