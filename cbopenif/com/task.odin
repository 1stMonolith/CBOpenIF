package com

Task :: distinct rawptr

TaskIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^TaskVTable,
}

TaskVTable :: struct
{
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

SerializeTask :: proc(task: Task) -> (xml: string, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^TaskIF)(task)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetTaskName :: proc(task: Task) -> (name: string, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^TaskIF)(task)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetTaskName :: proc(task: Task, name: string) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^TaskIF)(task)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetTaskIntervalTime :: proc(task: Task) -> (interval_time: i32, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->IntervalTimeGet(&interval_time)
    if ComFailed(hr) do return

    return interval_time, true
}

SetTaskIntervalTime :: proc(task: Task, interval_time: i32) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->IntervalTimePut(interval_time)
    if ComFailed(hr) do return

    return true
}

GetTaskPriority :: proc(task: Task) -> (priority: i32, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    p: i32
    hr := (^TaskIF)(task)->PriorityGet(&p)
    if ComFailed(hr) do return

    return p, true
}

SetTaskPriority :: proc(task: Task, priority: i32) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->PriorityPut(priority)
    if ComFailed(hr) do return

    return true
}

GetTaskOffset :: proc(task: Task) -> (offset: i32, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->OffsetGet(&offset)
    if ComFailed(hr) do return

    return offset, true
}

SetTaskOffset :: proc(task: Task, offset: i32) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->OffsetPut(offset)
    if ComFailed(hr) do return

    return true
}

GetTaskOutputUpdate :: proc(task: Task) -> (output_update: i32, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    ou: i32
    hr := (^TaskIF)(task)->OutputUpdateGet(&ou)
    if ComFailed(hr) do return

    return ou, true
}

SetTaskOutputUpdate :: proc(task: Task, output_update: i32) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->OutputUpdatePut(output_update)
    if ComFailed(hr) do return

    return true
}

GetTaskLatencySupervision :: proc(task: Task) -> (enabled: bool, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^TaskIF)(task)->LatencySupervisionGet(&vb)
    if ComFailed(hr) do return

    return vb == VariantBoolTrue, true
}

SetTaskLatencySupervision :: proc(task: Task, enabled: bool) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    vb: VariantBool = VariantBoolFalse
    if enabled do vb = VariantBoolTrue
    hr := (^TaskIF)(task)->LatencySupervisionPut(vb)
    if ComFailed(hr) do return

    return true
}

GetTaskLatencyPercentage :: proc(task: Task) -> (percentage: i32, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->LatencyPercentageGet(&percentage)
    if ComFailed(hr) do return

    return percentage, true
}

SetTaskLatencyPercentage :: proc(task: Task, percentage: i32) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->LatencyPercentagePut(percentage)
    if ComFailed(hr) do return

    return true
}

GetTaskSILLevel :: proc(task: Task) -> (sil_level: i32, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    s: i32
    hr := (^TaskIF)(task)->TaskSILLevelGet(&s)
    if ComFailed(hr) do return

    return s, true
}

SetTaskSILLevel :: proc(task: Task, sil_level: i32) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    hr := (^TaskIF)(task)->TaskSILLevelPut(sil_level)
    if ComFailed(hr) do return

    return true
}

GetTaskGuid :: proc(task: Task) -> (guid: string, ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^TaskIF)(task)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetTaskGuid :: proc(task: Task, guid: string) -> (ok: bool)
{
    if task == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^TaskIF)(task)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseTask :: proc(task: Task)
{
    if task != nil {
        (^TaskIF)(task)->Release()
    }
}
