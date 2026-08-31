package cbopenif

import "com"

ExecutionOrder :: struct
{
    groups: [dynamic]ExecutionGroup,
}

ExecutionGroup :: struct
{
    task:  string,
    instances:  [dynamic]string,
}

ExecutionOrderFromCom :: proc(comexecutionorder: com.ExecutionOrder) -> (executionorder: ExecutionOrder, ok: bool)
{
    if comexecutionorder == nil do return

    count: i32
    count, ok = com.ExecutionOrderCount(comexecutionorder)
    if !ok do return

    for i in 0..<count {
        comexecutiongroup: com.ExecutionGroup
        comexecutiongroup, ok = com.GetExecutionOrder(comexecutionorder, i)
        if !ok do return
        defer com.Release(comexecutiongroup)

        executiongroup: ExecutionGroup
        executiongroup, ok = ExecutionGroupFromCom(comexecutiongroup)
        if !ok do return
        append(&executionorder.groups, executiongroup)
    }

    return executionorder, true
}

ExecutionOrderToCom :: proc(executionorder: ExecutionOrder) -> (comexecutionorder: com.ExecutionOrder, ok: bool)
{
    comexecutionorder, ok = com.NewExecutionOrder()
    if !ok do return
    defer if !ok do com.Release(comexecutionorder)

    for group in executionorder.groups {
        bstr_task := com.ToBstr(group.task)
        defer com.FreeBstr(bstr_task)

        comexecutiongroup: com.ExecutionGroup
        hr := (^com.ExecutionOrderIF)(comexecutionorder)->Add1(bstr_task, cast(^rawptr)&comexecutiongroup)
        if com.ComFailed(hr) do return
        defer com.Release(comexecutiongroup)

        for instance in group.instances {
            comexecutioninstance: com.ExecutionInstance
            comexecutioninstance, ok = ExecutionInstanceToCom(instance)
            if !ok do return
            defer com.Release(comexecutioninstance)

            ok = com.AddExecutionInstance(comexecutiongroup, comexecutioninstance)
            if !ok do return
        }
    }

    return comexecutionorder, true
}

ExecutionInstanceFromCom :: proc(comexecutioninstance: com.ExecutionInstance) -> (instance: string, ok: bool)
{
    if comexecutioninstance == nil do return

    instance, ok = com.Name(comexecutioninstance)
    if !ok do return
    
    return instance, true
}

ExecutionInstanceToCom :: proc(name: string) -> (comexecutioninstance: com.ExecutionInstance, ok: bool)
{
    return com.NewExecutionInstance(name)
}

ExecutionGroupFromCom :: proc(comexecutiongroup: com.ExecutionGroup) -> (executiongroup: ExecutionGroup, ok: bool)
{
    if comexecutiongroup == nil do return

    executiongroup.task, ok = com.Name(comexecutiongroup)
    if !ok do return

    count: i32
    count, ok = com.ExecutionInstanceCount(comexecutiongroup)
    if !ok do return

    for i in 0..<count {
        comexecutioninstance: com.ExecutionInstance
        comexecutioninstance, ok = com.GetExecutionInstance(comexecutiongroup, i)
        if !ok do return
        defer com.Release(comexecutioninstance)

        instance: string
        instance, ok = ExecutionInstanceFromCom(comexecutioninstance)
        if !ok do return
        append(&executiongroup.instances, instance)
    }

    return executiongroup, true
}
