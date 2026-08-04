package task

import "../com"
import "../controlbuilder"
import "../factory"
import "../type"

@(private="file") BStr              :: com.BStr
@(private="file") HResult           :: com.HResult
@(private="file") VariantBool       :: com.VariantBool

TaskOutputUpdateType :: enum i32 {
    First = 0,
    Last  = 1,
}

TaskPriorityType :: enum i32 {
    Priority0 = 0,
    Priority1 = 1,
    Priority2 = 2,
    Priority3 = 3,
    Priority4 = 4,
    Priority5 = 5,
}

TaskSILLevelType :: enum i32 {
    SIL0 = 0,
    SIL2 = 1,
    SIL3 = 2,
}

Task :: distinct rawptr

TaskIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^TaskVTable,
}

TaskVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

task_new :: proc(
    name: string,
    interval_time: i32,
    priority: TaskPriorityType,
    offset: i32 = 0,
    output_update: TaskOutputUpdateType = .First,
) -> (task: Task, ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bstr_name := com.from_string(name)
    defer com.bstr_free(bstr_name)

    hr := factory.factoryif->NewTask1(
        bstr_name,
        interval_time,
        i32(priority),
        offset,
        i32(output_update),
        cast(^rawptr)&task,
    )
    if com.failed(hr) do return

    return task, true
}

task_deserialize :: proc(task: ^Task, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeTask(&bs, cast(^rawptr)task)
    if com.failed(hr) do return

    return true
}

task_serialize :: proc(task: Task) -> (xml: string, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^TaskIF)(task)->Serialize(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

task_name :: proc {
    task_name_get,
    task_name_set,
}

task_name_get :: proc(task: Task) -> (name: string, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^TaskIF)(task)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

task_name_set :: proc(task: Task, name: string) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^TaskIF)(task)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

task_interval_time :: proc {
    task_interval_time_get,
    task_interval_time_set,
}

task_interval_time_get :: proc(task: Task) -> (interval_time: i32, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->IntervalTimeGet(&interval_time)
    if com.failed(hr) do return

    return interval_time, true
}

task_interval_time_set :: proc(task: Task, interval_time: i32) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->IntervalTimePut(interval_time)
    if com.failed(hr) do return

    return true
}

task_priority :: proc {
    task_priority_get,
    task_priority_set,
}

task_priority_get :: proc(task: Task) -> (priority: TaskPriorityType, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    p: i32
    hr := (^TaskIF)(task)->PriorityGet(&p)
    if com.failed(hr) do return

    return TaskPriorityType(p), true
}

task_priority_set :: proc(task: Task, priority: TaskPriorityType) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->PriorityPut(i32(priority))
    if com.failed(hr) do return

    return true
}

task_offset :: proc {
    task_offset_get,
    task_offset_set,
}

task_offset_get :: proc(task: Task) -> (offset: i32, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->OffsetGet(&offset)
    if com.failed(hr) do return

    return offset, true
}

task_offset_set :: proc(task: Task, offset: i32) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->OffsetPut(offset)
    if com.failed(hr) do return

    return true
}

task_output_update :: proc {
    task_output_update_get,
    task_output_update_set,
}

task_output_update_get :: proc(task: Task) -> (output_update: TaskOutputUpdateType, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    t: i32
    hr := (^TaskIF)(task)->OutputUpdateGet(&t)
    if com.failed(hr) do return

    return TaskOutputUpdateType(t), true
}

task_output_update_set :: proc(task: Task, output_update: TaskOutputUpdateType) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->OutputUpdatePut(i32(output_update))
    if com.failed(hr) do return

    return true
}

task_latency_supervision :: proc {
    task_latency_supervision_get,
    task_latency_supervision_set,
}

task_latency_supervision_get :: proc(task: Task) -> (enabled: bool, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^TaskIF)(task)->LatencySupervisionGet(&vb)
    if com.failed(hr) do return

    return vb == com.VariantBoolTrue, true
}

task_latency_supervision_set :: proc(task: Task, enabled: bool) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool = com.VariantBoolFalse
    if enabled do vb = com.VariantBoolTrue
    hr := (^TaskIF)(task)->LatencySupervisionPut(vb)
    if com.failed(hr) do return

    return true
}

task_latency_percentage :: proc {
    task_latency_percentage_get,
    task_latency_percentage_set,
}

task_latency_percentage_get :: proc(task: Task) -> (percentage: i32, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->LatencyPercentageGet(&percentage)
    if com.failed(hr) do return

    return percentage, true
}

task_latency_percentage_set :: proc(task: Task, percentage: i32) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->LatencyPercentagePut(percentage)
    if com.failed(hr) do return

    return true
}

task_sil_level :: proc {
    task_sil_level_get,
    task_sil_level_set,
}

task_sil_level_get :: proc(task: Task) -> (sil_level: TaskSILLevelType, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    s: i32
    hr := (^TaskIF)(task)->TaskSILLevelGet(&s)
    if com.failed(hr) do return

    return TaskSILLevelType(s), true
}

task_sil_level_set :: proc(task: Task, sil_level: TaskSILLevelType) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^TaskIF)(task)->TaskSILLevelPut(i32(sil_level))
    if com.failed(hr) do return

    return true
}

task_guid :: proc {
    task_guid_get,
    task_guid_set,
}

task_guid_get :: proc(task: Task) -> (guid: string, ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^TaskIF)(task)->GuidGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

task_guid_set :: proc(task: Task, guid: string) -> (ok: bool) {
    if task == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(guid)
    defer com.bstr_free(bs)
    hr := (^TaskIF)(task)->GuidPut(bs)
    if com.failed(hr) do return

    return true
}

task_release :: proc(task: Task) {
    if task != nil {
        (^TaskIF)(task)->Release()
    }
}
