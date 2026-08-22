package cbopenif

import "com"

ExecutionOrder :: struct {
    groups: [dynamic]ExecutionGroup,
}

ExecutionGroup :: struct {
    task_name:  string,
    instances:  [dynamic]string,
}

executionorder_from_com :: proc(eo: ExecutionOrder, allocator := context.allocator) -> (result: t.ExecutionOrder, ok: bool) {
    if eo == nil do return
    context.allocator = allocator

    count: i32
    count, ok = executiongroup_count(eo)
    if !ok do return

    result.groups = make([dynamic]t.ExecutionGroup, 0, int(count), allocator)
    for i in 0..<count {
        eg: ExecutionGroup
        eg, ok = executiongroup_by_index(eo, i)
        if !ok do return
        defer release(eg)

        egs: t.ExecutionGroup
        egs, ok = executiongroup_from_com(eg)
        if !ok do return
        append(&result.groups, egs)
    }

    return result, true
}

executionorder_to_com :: proc(src: t.ExecutionOrder) -> (result: ExecutionOrder, ok: bool) {
    eo: ExecutionOrder
    eo, ok = executionorder_new()
    if !ok do return
    defer if !ok do release(eo)

    for g in src.groups {
        bstr_task := to_bstr(g.task_name)
        defer bstr_free(bstr_task)

        eg: ExecutionGroup
        hr := (^ExecutionOrderIF)(eo)->Add1(bstr_task, cast(^rawptr)&eg)
        if com_failed(hr) do return
        defer release(eg)

        for inst in g.instances {
            ei: ExecutionInstance
            ei, ok = executioninstance_to_com(inst)
            if !ok do return
            defer release(ei)

            ok = executioninstance_add(eg, ei)
            if !ok do return
        }
    }

    return eo, true
}

executioninstance_from_com :: proc(ei: ExecutionInstance, allocator := context.allocator) -> (result: t.ExecutionInstance, ok: bool) {
    if ei == nil do return
    
    context.allocator = allocator

    result.name, ok = name(ei)
    if !ok do return
    
    return result, true
}

executioninstance_to_com :: proc(src: t.ExecutionInstance) -> (result: ExecutionInstance, ok: bool) {
    return executioninstance_new(src.name)
}

executiongroup_from_com :: proc(eg: ExecutionGroup, allocator := context.allocator) -> (result: t.ExecutionGroup, ok: bool) {
    if eg == nil do return
    context.allocator = allocator

    result.task_name, ok = name(eg)
    if !ok do return

    count: i32
    count, ok = executioninstance_count(eg)
    if !ok do return

    result.instances = make([dynamic]t.ExecutionInstance, 0, int(count), allocator)
    for i in 0..<count {
        ei: ExecutionInstance
        ei, ok = executioninstance_by_index(eg, i)
        if !ok do return
        defer release(ei)

        eis: t.ExecutionInstance
        eis, ok = executioninstance_from_com(ei)
        if !ok do return
        append(&result.instances, eis)
    }

    return result, true
}
