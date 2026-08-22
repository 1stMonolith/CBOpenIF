package com

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

task_priority_get :: proc(task: Task) -> (priority: i32, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    p: i32
    hr := (^TaskIF)(task)->PriorityGet(&p)
    if com_failed(hr) do return

    return p, true
}

task_priority_set :: proc(task: Task, priority: i32) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->PriorityPut(priority)
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

task_output_update_get :: proc(task: Task) -> (output_update: i32, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    ou: i32
    hr := (^TaskIF)(task)->OutputUpdateGet(&ou)
    if com_failed(hr) do return

    return ou, true
}

task_output_update_set :: proc(task: Task, output_update: i32) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->OutputUpdatePut(output_update)
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

task_sil_level_get :: proc(task: Task) -> (sil_level: i32, ok: bool) {
    if task == nil do return
    if !com_connected() do return

    s: i32
    hr := (^TaskIF)(task)->TaskSILLevelGet(&s)
    if com_failed(hr) do return

    return s, true
}

task_sil_level_set :: proc(task: Task, sil_level: i32) -> (ok: bool) {
    if task == nil do return
    if !com_connected() do return

    hr := (^TaskIF)(task)->TaskSILLevelPut(sil_level)
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
