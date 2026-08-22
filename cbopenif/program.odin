package cbopenif

import "com"

Program :: struct {
    name:                 string,
    description:          string,
    access_level:         string,
    safety_type:          string,
    task_connection:      string,
    simulation_mark:      bool,
    sil_level:            string,
    inst_guid:            string,
    type_guid:            string,
    reserved_by_function: string,
    variables:            [dynamic]Variable,
    signals:              [dynamic]Signal,
    code_blocks:          [dynamic]CodeBlock,
    function_blocks:      [dynamic]FunctionBlock,
    init_values:          [dynamic]InitValue,
}

program_from_com :: proc(program: Program, allocator := context.allocator) -> (result: t.Program, ok: bool) {
    if program == nil do return
    context.allocator = allocator

    result.name, ok = name(program)
    if !ok do return
    result.description, ok = description(program)
    if !ok do return
    result.access_level, ok = access_level(program)
    if !ok do return
    result.safety_type, ok = safety_type(program)
    if !ok do return
    result.task_connection, ok = task_connection(program)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(program)
    if !ok do return
    result.sil_level, ok = sil_level(program)
    if !ok do return
    result.inst_guid, ok = inst_guid(program)
    if !ok do return
    result.type_guid, ok = type_guid(program)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(program)
    if !ok do return

    {
        c: Variables
        c, ok = variables(program)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(program)
        if !ok do return
        defer release(c)
        result.signals, ok = signals_from_com(c)
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(program)
        if !ok do return
        defer release(c)
        result.comm_variables, ok = commvariables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(program)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(program)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(program)
        if !ok do return
        defer release(c)
        result.init_values, ok = initvalues_from_com(c)
        if !ok do return
    }

    return result, true
}

program_to_com :: proc(src: t.Program) -> (result: Program, ok: bool) {
    program: Program
    program, ok = program_new1(
        src.name,
        src.description,
        src.task_connection,
        src.type_guid,
        src.inst_guid,
    )
    if !ok do return
    defer if !ok do release(program)

    ok = access_level(program, src.access_level)
    if !ok do return
    ok = safety_type(program, src.safety_type)
    if !ok do return
    ok = simulation_mark(program, src.simulation_mark)
    if !ok do return
    ok = sil_level(program, src.sil_level)
    if !ok do return
    ok = reserved_by_function(program, src.reserved_by_function)
    if !ok do return

    {
        c: Variables
        c, ok = variables(program)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(program)
        if !ok do return
        defer release(c)
        ok = signals_to_com(c, src.signals[:])
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(program)
        if !ok do return
        defer release(c)
        ok = commvariables_to_com(c, src.comm_variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(program)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(program)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(program)
        if !ok do return
        defer release(c)
        ok = initvalues_to_com(c, src.init_values[:])
        if !ok do return
    }

    return program, true
}