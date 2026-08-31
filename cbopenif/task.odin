package cbopenif

import "com"

Priority :: enum i32
{
    TimeCritical = 0,
    Highest      = 1,
    High         = 2,
    Normal       = 3,
    Low          = 4,
    Lowest       = 5,
}

Update :: enum i32
{
    First = 0,
    Last  = 1,
}

Task :: struct
{
    name:                string,
    interval:            i32,
    priority:            Priority,
    offset:              i32,
    update:              Update,
    latencysupervision:  bool,
    latencypercentage:   i32,
    sillevel:            SILLevel,
    guid:                string,
}

TaskFromCom :: proc(comtask: com.Task) -> (task: Task, ok: bool)
{
    if comtask == nil do return

    task.name, ok = com.Name(comtask)
    if !ok do return

    task.interval, ok = com.IntervalTime(comtask)
    if !ok do return

    priority: i32
    priority, ok = com.Priority(comtask)
    if !ok do return
    task.priority = Priority(priority)

    task.offset, ok = com.Offset(comtask)
    if !ok do return

    update: i32
    update, ok = com.OutputUpdate(comtask)
    if !ok do return
    task.update = Update(update)

    task.latencysupervision, ok = com.LatencySupervision(comtask)
    if !ok do return

    task.latencypercentage, ok = com.LatencyPercentage(comtask)
    if !ok do return

    sillevel: i32
    sillevel, ok = com.SILLevel(comtask)
    if !ok do return
    task.sillevel = SILLevel(sillevel)

    task.guid, ok = com.Guid(comtask)
    if !ok do return

    return task, true
}

TaskToCom :: proc(task: Task) -> (comtask: com.Task, ok: bool)
{
    comtask, ok = com.NewTaskEx(
        task.name,
        task.interval,
        i32(task.priority),
        task.offset,
        i32(task.update),
    )
    if !ok do return
    defer if !ok do com.Release(comtask)

    ok = com.LatencySupervision(comtask, task.latencysupervision)
    if !ok do return

    ok = com.LatencyPercentage(comtask, task.latencypercentage)
    if !ok do return

    ok = com.SILLevel(comtask, i32(task.sillevel))
    if !ok do return

    ok = com.Guid(comtask, task.guid)
    if !ok do return

    return comtask, true
}
