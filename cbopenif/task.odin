package cbopenif

import "com"

TaskPriorityKind :: enum i32 {
    Priority0 = 0,
    Priority1 = 1,
    Priority2 = 2,
    Priority3 = 3,
    Priority4 = 4,
    Priority5 = 5,
}

TaskOutputUpdateKind :: enum i32 {
    First = 0,
    Last  = 1,
}

TaskSILLevelKind :: enum i32 {
    SIL0 = 0,
    SIL2 = 1,
    SIL3 = 2,
}

Task :: struct {
    name:                string,
    interval_time:       i32,
    priority:            TaskPriorityKind,
    offset:              i32,
    output_update:       TaskOutputUpdateKind,
    latency_supervision: bool,
    latency_percentage:  i32,
    sil_level:           TaskSILLevelKind,
    guid:                string,
}

task_from_com :: proc(task: Task, allocator := context.allocator) -> (result: t.Task, ok: bool) {
    if task == nil do return

    context.allocator = allocator

    result.name, ok = name(task)
    if !ok do return
    result.interval_time, ok = interval_time(task)
    if !ok do return
    result.priority, ok = priority(task)
    if !ok do return
    result.offset, ok = offset(task)
    if !ok do return
    result.output_update, ok = output_update(task)
    if !ok do return
    result.latency_supervision, ok = latency_supervision(task)
    if !ok do return
    result.latency_percentage, ok = latency_percentage(task)
    if !ok do return
    result.sil_level, ok = sil_level(task)
    if !ok do return
    result.guid, ok = guid(task)
    if !ok do return

    return result, true
}

task_to_com :: proc(src: t.Task) -> (result: Task, ok: bool) {
    task: Task
    task, ok = task_new1(
        src.name,
        src.interval_time,
        src.priority,
        src.offset,
        src.output_update,
    )
    if !ok do return
    defer if !ok do release(task)

    ok = latency_supervision(task, src.latency_supervision)
    if !ok do return
    ok = latency_percentage(task, src.latency_percentage)
    if !ok do return
    ok = sil_level(task, src.sil_level)
    if !ok do return
    ok = guid(task, src.guid)
    if !ok do return

    return task, true
}
