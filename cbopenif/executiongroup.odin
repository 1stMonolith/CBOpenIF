package cbopenif

ExecutionGroup :: distinct rawptr

ExecutionGroupIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionGroupVTable,
}

ExecutionGroupVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    TaskNameGet: proc "system" (this: ^ExecutionGroupIF, TaskName: ^BStr) -> HResult,
    TaskNamePut: proc "system" (this: ^ExecutionGroupIF, TaskName: BStr) -> HResult,
    Serialize:   proc "system" (this: ^ExecutionGroupIF, XML: ^BStr) -> HResult,
    Add:         proc "system" (this: ^ExecutionGroupIF, ExecutionInstance: rawptr) -> HResult,
    AddBefore:   proc "system" (this: ^ExecutionGroupIF, ExecutionInstance: rawptr, Index: i32) -> HResult,
    Add1:        proc "system" (this: ^ExecutionGroupIF, Name: BStr, ExecutionInstance: ^rawptr) -> HResult,
    Find:        proc "system" (this: ^ExecutionGroupIF, Name: BStr, ExecutionInstance: ^rawptr) -> HResult,
    FindNr:      proc "system" (this: ^ExecutionGroupIF, Name: BStr, Index: ^i32) -> HResult,
    Item:        proc "system" (this: ^ExecutionGroupIF, Index: i32, ExecutionInstance: ^rawptr) -> HResult,
    Count:       proc "system" (this: ^ExecutionGroupIF, Count: ^i32) -> HResult,
    Remove:      proc "system" (this: ^ExecutionGroupIF, Index: i32) -> HResult,
}

executiongroup_task_name :: proc {
    executiongroup_task_name_get,
    executiongroup_task_name_set,
}

executiongroup_task_name_get :: proc(eg: ExecutionGroup) -> (task_name: string, ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionGroupIF)(eg)->TaskNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executiongroup_task_name_set :: proc(eg: ExecutionGroup, task_name: string) -> (ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(task_name)
    defer bstr_free(bs)
    hr := (^ExecutionGroupIF)(eg)->TaskNamePut(bs)
    if com_failed(hr) do return

    return true
}

executiongroup_serialize :: proc(eg: ExecutionGroup) -> (xml: string, ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionGroupIF)(eg)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executiongroup_add_ :: proc(eg: ExecutionGroup, ei: ExecutionInstance) -> (ok: bool) {
    if eg == nil do return
    if ei == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionGroupIF)(eg)->Add(ei)
    if com_failed(hr) do return

    return true
}

executiongroup_add_at_index :: proc(eg: ExecutionGroup, ei: ExecutionInstance, index: i32) -> (ok: bool) {
    if eg == nil do return
    if ei == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionGroupIF)(eg)->AddBefore(ei, index)
    if com_failed(hr) do return

    return true
}

executiongroup_executioninstance :: proc {
    executiongroup_executioninstance_by_name,
    executiongroup_executioninstance_by_index,
}

executiongroup_executioninstance_by_name :: proc(eg: ExecutionGroup, name: string) -> (ei: ExecutionInstance, ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExecutionGroupIF)(eg)->Find(bstr_name, cast(^rawptr)&ei)
    if com_failed(hr) do return

    return ei, true
}

executiongroup_executioninstance_by_index :: proc(eg: ExecutionGroup, index: i32) -> (ei: ExecutionInstance, ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionGroupIF)(eg)->Item(index, cast(^rawptr)&ei)
    if com_failed(hr) do return

    return ei, true
}

executiongroup_executioninstance_index :: proc(eg: ExecutionGroup, name: string) -> (index: i32, ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExecutionGroupIF)(eg)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

executiongroup_executioninstance_count :: proc(eg: ExecutionGroup) -> (count: i32, ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionGroupIF)(eg)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

executiongroup_executioninstance_remove :: proc {
    executiongroup_executioninstance_remove_by_name,
    executiongroup_executioninstance_remove_by_index,
}

executiongroup_executioninstance_remove_by_name :: proc(eg: ExecutionGroup, name: string) -> (ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = executiongroup_executioninstance_index(eg, name)
    if !ok do return

    hr := (^ExecutionGroupIF)(eg)->Remove(index)
    if com_failed(hr) do return

    return true
}

executiongroup_executioninstance_remove_by_index :: proc(eg: ExecutionGroup, index: i32) -> (ok: bool) {
    if eg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExecutionGroupIF)(eg)->Remove(index)
    if com_failed(hr) do return

    return true
}

executiongroup_release :: proc(eg: ExecutionGroup) {
    if eg != nil {
        (^ExecutionGroupIF)(eg)->Release()
    }
}
