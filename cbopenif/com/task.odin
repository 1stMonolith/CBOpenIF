package com

import t "../types"

Task :: distinct rawptr

TaskIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^TaskVTable,
}

TaskVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^TaskIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^TaskIF, Name: BStr) -> HResult,
    IntervalTimeGet:       proc "system" (this: ^TaskIF, IntervalTime: ^i32) -> HResult,
    IntervalTimePut:       proc "system" (this: ^TaskIF, IntervalTime: i32) -> HResult,
    PriorityGet:           proc "system" (this: ^TaskIF, Priority: ^i32) -> HResult,
    PriorityPut:           proc "system" (this: ^TaskIF, Priority: i32) -> HResult,
    OffsetGet:             proc "system" (this: ^TaskIF, Offset: ^i32) -> HResult,
    OffsetPut:             proc "system" (this: ^TaskIF, Offset: i32) -> HResult,
    OutputUpdateGet:       proc "system" (this: ^TaskIF, OutputUpdate: ^i32) -> HResult,
    OutputUpdatePut:       proc "system" (this: ^TaskIF, OutputUpdate: i32) -> HResult,
    LatencySupervisionGet: proc "system" (this: ^TaskIF, LatencySupervision: ^VariantBool) -> HResult,
    LatencySupervisionPut: proc "system" (this: ^TaskIF, LatencySupervision: VariantBool) -> HResult,
    LatencyPercentageGet:  proc "system" (this: ^TaskIF, LatencyPercentage: ^i32) -> HResult,
    LatencyPercentagePut:  proc "system" (this: ^TaskIF, LatencyPercentage: i32) -> HResult,
    TaskSILLevelGet:       proc "system" (this: ^TaskIF, TaskSILLevel: ^i32) -> HResult,
    TaskSILLevelPut:       proc "system" (this: ^TaskIF, TaskSILLevel: i32) -> HResult,
    GuidGet:               proc "system" (this: ^TaskIF, Guid: ^BStr) -> HResult,
    GuidPut:               proc "system" (this: ^TaskIF, Guid: BStr) -> HResult,
    Serialize:             proc "system" (this: ^TaskIF, XML: ^BStr) -> HResult,
}

task_serialize :: proc(task: Task) -> (xml: string, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^TaskIF)(task)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

task_name_get :: proc(task: Task) -> (name: string, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^TaskIF)(task)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

task_name_set :: proc(task: Task, name: string) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^TaskIF)(task)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

task_interval_time_get :: proc(task: Task) -> (interval_time: i32, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->IntervalTimeGet(&interval_time)
    if com_failed(hr) do return

    return interval_time, true
}

task_interval_time_set :: proc(task: Task, interval_time: i32) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->IntervalTimePut(interval_time)
    if com_failed(hr) do return

    return true
}

task_priority_get :: proc(task: Task) -> (priority: t.TaskPriority, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    p: i32
    hr := (^TaskIF)(task)->PriorityGet(&p)
    if com_failed(hr) do return

    return t.TaskPriority(p), true
}

task_priority_set :: proc(task: Task, priority: t.TaskPriority) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->PriorityPut(i32(priority))
    if com_failed(hr) do return

    return true
}

task_offset_get :: proc(task: Task) -> (offset: i32, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->OffsetGet(&offset)
    if com_failed(hr) do return

    return offset, true
}

task_offset_set :: proc(task: Task, offset: i32) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->OffsetPut(offset)
    if com_failed(hr) do return

    return true
}

task_output_update_get :: proc(task: Task) -> (output_update: t.TaskOutputUpdate, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    ou: i32
    hr := (^TaskIF)(task)->OutputUpdateGet(&ou)
    if com_failed(hr) do return

    return t.TaskOutputUpdate(ou), true
}

task_output_update_set :: proc(task: Task, output_update: t.TaskOutputUpdate) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->OutputUpdatePut(i32(output_update))
    if com_failed(hr) do return

    return true
}

task_latency_supervision_get :: proc(task: Task) -> (enabled: bool, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^TaskIF)(task)->LatencySupervisionGet(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

task_latency_supervision_set :: proc(task: Task, enabled: bool) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    vb: VariantBool = VariantBoolFalse
    if enabled do vb = VariantBoolTrue
    hr := (^TaskIF)(task)->LatencySupervisionPut(vb)
    if com_failed(hr) do return

    return true
}

task_latency_percentage_get :: proc(task: Task) -> (percentage: i32, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->LatencyPercentageGet(&percentage)
    if com_failed(hr) do return

    return percentage, true
}

task_latency_percentage_set :: proc(task: Task, percentage: i32) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->LatencyPercentagePut(percentage)
    if com_failed(hr) do return

    return true
}

task_sil_level_get :: proc(task: Task) -> (sil_level: t.TaskSILLevel, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    s: i32
    hr := (^TaskIF)(task)->TaskSILLevelGet(&s)
    if com_failed(hr) do return

    return t.TaskSILLevel(s), true
}

task_sil_level_set :: proc(task: Task, sil_level: t.TaskSILLevel) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->TaskSILLevelPut(i32(sil_level))
    if com_failed(hr) do return

    return true
}

task_guid_get :: proc(task: Task) -> (guid: string, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^TaskIF)(task)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

task_guid_set :: proc(task: Task, guid: string) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^TaskIF)(task)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

task_release :: proc(task: Task) {
    if task != nil {
        (^TaskIF)(task)->Release()
    }
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
