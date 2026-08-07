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

executionorder_new :: proc() -> (eo: ExecutionOrder, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewExecutionOrder(cast(^rawptr)&eo)
    if com_failed(hr) do return

    return eo, true
}

executionorder_deserialize :: proc(xml: string) -> (eo: ExecutionOrder, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeExecutionOrder(&bs, cast(^rawptr)&eo)
    if com_failed(hr) do return

    return eo, true
}

executionorder_serialize :: proc(eo: ExecutionOrder) -> (xml: string, ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionOrderIF)(eo)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executionorder_add :: proc {
    executionorder_add_,
    executionorder_add_at_index,
}

executionorder_add_ :: proc(eo: ExecutionOrder, eg: ExecutionGroup) -> (ok: bool) {
    if eo == nil do return
    if eg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(eo)->Add(eg)
    if com_failed(hr) do return

    return true
}

executionorder_add_at_index :: proc(eo: ExecutionOrder, eg: ExecutionGroup, index: i32) -> (ok: bool) {
    if eo == nil do return
    if eg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(eo)->AddBefore(eg, index)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup :: proc {
    executionorder_executiongroup_by_task_name,
    executionorder_executiongroup_by_index,
}

executionorder_executiongroup_by_task_name :: proc(eo: ExecutionOrder, task_name: string) -> (eg: ExecutionGroup, ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    bstr_task_name := to_bstr(task_name)
    defer bstr_free(bstr_task_name)
    hr := (^ExecutionOrderIF)(eo)->Find(bstr_task_name, cast(^rawptr)&eg)
    if com_failed(hr) do return

    return eg, true
}

executionorder_executiongroup_by_index :: proc(eo: ExecutionOrder, index: i32) -> (eg: ExecutionGroup, ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(eo)->Item(index, cast(^rawptr)&eg)
    if com_failed(hr) do return

    return eg, true
}

executionorder_executiongroup_index :: proc(eo: ExecutionOrder, task_name: string) -> (index: i32, ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    bstr_task_name := to_bstr(task_name)
    defer bstr_free(bstr_task_name)
    hr := (^ExecutionOrderIF)(eo)->FindNr(bstr_task_name, &index)
    if com_failed(hr) do return

    return index, true
}

executionorder_executiongroup_count :: proc(eo: ExecutionOrder) -> (count: i32, ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(eo)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

executionorder_executiongroup_remove :: proc {
    executionorder_executiongroup_remove_by_task_name,
    executionorder_executiongroup_remove_by_index,
}

executionorder_executiongroup_remove_by_task_name :: proc(eo: ExecutionOrder, task_name: string) -> (ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = executionorder_executiongroup_index(eo, task_name)
    if !ok do return

    hr := (^ExecutionOrderIF)(eo)->Remove(index)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup_remove_by_index :: proc(eo: ExecutionOrder, index: i32) -> (ok: bool) {
    if eo == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionOrderIF)(eo)->Remove(index)
    if com_failed(hr) do return

    return true
}

executionorder_release :: proc(eo: ExecutionOrder) {
    if eo != nil {
        (^ExecutionOrderIF)(eo)->Release()
    }
}
