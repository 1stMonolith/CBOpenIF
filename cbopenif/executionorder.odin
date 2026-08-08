package cbopenif

ExecutionOrder :: distinct rawptr

ExecutionOrderIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionOrderVTable,
}

ExecutionOrderVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ExecutionOrderIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ExecutionOrderIF, ExecutionGroup: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ExecutionOrderIF, ExecutionGroup: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExecutionOrderIF, TaskName: BStr, ExecutionGroup: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ExecutionOrderIF, TaskName: BStr, ExecutionGroup: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ExecutionOrderIF, TaskName: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExecutionOrderIF, Index: i32, ExecutionGroup: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ExecutionOrderIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExecutionOrderIF, Index: i32) -> HResult,
}

executionorder_new :: proc() -> (executionorder: ExecutionOrder, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewExecutionOrder(cast(^rawptr)&executionorder)
    if com_failed(hr) do return

    return executionorder, true
}

executionorder_deserialize :: proc(xml: string) -> (executionorder: ExecutionOrder, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeExecutionOrder(&bs, cast(^rawptr)&executionorder)
    if com_failed(hr) do return

    return executionorder, true
}

executionorder_serialize :: proc(executionorder: ExecutionOrder) -> (xml: string, ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionOrderIF)(executionorder)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executionorder_executiongroup_add :: proc {
    executionorder_executiongroup_add_,
    executionorder_executiongroup_add_at_index,
}

executionorder_executiongroup_add_ :: proc(executionorder: ExecutionOrder, executiongroup: ExecutionGroup) -> (ok: bool) {
    if executionorder == nil do return
    if executiongroup == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Add(executiongroup)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup_add_at_index :: proc(executionorder: ExecutionOrder, executiongroup: ExecutionGroup, index: i32) -> (ok: bool) {
    if executionorder == nil do return
    if executiongroup == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->AddBefore(executiongroup, index)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup :: proc {
    executionorder_executiongroup_by_task_name,
    executionorder_executiongroup_by_index,
}

executionorder_executiongroup_by_task_name :: proc(executionorder: ExecutionOrder, task_name: string) -> (executiongroup: ExecutionGroup, ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    bstr_task_name := to_bstr(task_name)
    defer bstr_free(bstr_task_name)
    hr := (^ExecutionOrderIF)(executionorder)->Find(bstr_task_name, cast(^rawptr)&executiongroup)
    if com_failed(hr) do return

    return executiongroup, true
}

executionorder_executiongroup_by_index :: proc(executionorder: ExecutionOrder, index: i32) -> (executiongroup: ExecutionGroup, ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Item(index, cast(^rawptr)&executiongroup)
    if com_failed(hr) do return

    return executiongroup, true
}

executionorder_executiongroup_index :: proc(executionorder: ExecutionOrder, task_name: string) -> (index: i32, ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    bstr_task_name := to_bstr(task_name)
    defer bstr_free(bstr_task_name)
    hr := (^ExecutionOrderIF)(executionorder)->FindNr(bstr_task_name, &index)
    if com_failed(hr) do return

    return index, true
}

executionorder_executiongroup_count :: proc(executionorder: ExecutionOrder) -> (count: i32, ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

executionorder_executiongroup_remove :: proc {
    executionorder_executiongroup_remove_by_task_name,
    executionorder_executiongroup_remove_by_index,
}

executionorder_executiongroup_remove_by_task_name :: proc(executionorder: ExecutionOrder, task_name: string) -> (ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = executionorder_executiongroup_index(executionorder, task_name)
    if !ok do return

    hr := (^ExecutionOrderIF)(executionorder)->Remove(index)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup_remove_by_index :: proc(executionorder: ExecutionOrder, index: i32) -> (ok: bool) {
    if executionorder == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Remove(index)
    if com_failed(hr) do return

    return true
}

executionorder_release :: proc(executionorder: ExecutionOrder) {
    if executionorder != nil {
        (^ExecutionOrderIF)(executionorder)->Release()
    }
}
