package com

ExecutionOrder    :: distinct rawptr
ExecutionGroup    :: distinct rawptr
ExecutionInstance :: distinct rawptr

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

executionorder_serialize :: proc(executionorder: ExecutionOrder) -> (xml: string, ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionOrderIF)(executionorder)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executionorder_executiongroup_add :: proc(executionorder: ExecutionOrder, executiongroup: ExecutionGroup) -> (ok: bool) {
    if executionorder == nil do return
    if executiongroup == nil do return
    if !com_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Add(executiongroup)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup_add_at_index :: proc(executionorder: ExecutionOrder, executiongroup: ExecutionGroup, index: i32) -> (ok: bool) {
    if executionorder == nil do return
    if executiongroup == nil do return
    if !com_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->AddBefore(executiongroup, index)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup_by_task_name :: proc(executionorder: ExecutionOrder, task_name: string) -> (executiongroup: ExecutionGroup, ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    bstr_task_name := to_bstr(task_name)
    defer bstr_free(bstr_task_name)
    hr := (^ExecutionOrderIF)(executionorder)->Find(bstr_task_name, cast(^rawptr)&executiongroup)
    if com_failed(hr) do return

    return executiongroup, true
}

executionorder_executiongroup_by_index :: proc(executionorder: ExecutionOrder, index: i32) -> (executiongroup: ExecutionGroup, ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Item(index + 1, cast(^rawptr)&executiongroup)
    if com_failed(hr) do return

    return executiongroup, true
}

executionorder_executiongroup_index :: proc(executionorder: ExecutionOrder, task_name: string) -> (index: i32, ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    bstr_task_name := to_bstr(task_name)
    defer bstr_free(bstr_task_name)
    hr := (^ExecutionOrderIF)(executionorder)->FindNr(bstr_task_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

executionorder_executiongroup_count :: proc(executionorder: ExecutionOrder) -> (count: i32, ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

executionorder_executiongroup_remove_by_task_name :: proc(executionorder: ExecutionOrder, task_name: string) -> (ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    index: i32
    index, ok = executionorder_executiongroup_index(executionorder, task_name)
    if !ok do return

    hr := (^ExecutionOrderIF)(executionorder)->Remove(index)
    if com_failed(hr) do return

    return true
}

executionorder_executiongroup_remove_by_index :: proc(executionorder: ExecutionOrder, index: i32) -> (ok: bool) {
    if executionorder == nil do return
    if !com_connected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

executionorder_release :: proc(executionorder: ExecutionOrder) {
    if executionorder != nil {
        (^ExecutionOrderIF)(executionorder)->Release()
    }
}

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

executiongroup_task_name_get :: proc(executiongroup: ExecutionGroup) -> (task_name: string, ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionGroupIF)(executiongroup)->TaskNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executiongroup_task_name_set :: proc(executiongroup: ExecutionGroup, task_name: string) -> (ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    bs := to_bstr(task_name)
    defer bstr_free(bs)
    hr := (^ExecutionGroupIF)(executiongroup)->TaskNamePut(bs)
    if com_failed(hr) do return

    return true
}

executiongroup_serialize :: proc(executiongroup: ExecutionGroup) -> (xml: string, ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionGroupIF)(executiongroup)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executiongroup_executioninstance_add :: proc(executiongroup: ExecutionGroup, executioninstance: ExecutionInstance) -> (ok: bool) {
    if executiongroup == nil do return
    if executioninstance == nil do return
    if !com_connected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Add(executioninstance)
    if com_failed(hr) do return

    return true
}

executiongroup_executioninstance_add_at_index :: proc(executiongroup: ExecutionGroup, executioninstance: ExecutionInstance, index: i32) -> (ok: bool) {
    if executiongroup == nil do return
    if executioninstance == nil do return
    if !com_connected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->AddBefore(executioninstance, index)
    if com_failed(hr) do return

    return true
}

executiongroup_executioninstance_by_name :: proc(executiongroup: ExecutionGroup, name: string) -> (executioninstance: ExecutionInstance, ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExecutionGroupIF)(executiongroup)->Find(bstr_name, cast(^rawptr)&executioninstance)
    if com_failed(hr) do return

    return executioninstance, true
}

executiongroup_executioninstance_by_index :: proc(executiongroup: ExecutionGroup, index: i32) -> (executioninstance: ExecutionInstance, ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Item(index + 1, cast(^rawptr)&executioninstance)
    if com_failed(hr) do return

    return executioninstance, true
}

executiongroup_executioninstance_index :: proc(executiongroup: ExecutionGroup, name: string) -> (index: i32, ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExecutionGroupIF)(executiongroup)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

executiongroup_executioninstance_count :: proc(executiongroup: ExecutionGroup) -> (count: i32, ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

executiongroup_executioninstance_remove_by_name :: proc(executiongroup: ExecutionGroup, name: string) -> (ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    index: i32
    index, ok = executiongroup_executioninstance_index(executiongroup, name)
    if !ok do return

    hr := (^ExecutionGroupIF)(executiongroup)->Remove(index)
    if com_failed(hr) do return

    return true
}

executiongroup_executioninstance_remove_by_index :: proc(executiongroup: ExecutionGroup, index: i32) -> (ok: bool) {
    if executiongroup == nil do return
    if !com_connected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

executiongroup_release :: proc(executiongroup: ExecutionGroup) {
    if executiongroup != nil {
        (^ExecutionGroupIF)(executiongroup)->Release()
    }
}

ExecutionInstanceIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionInstanceVTable,
}

ExecutionInstanceVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet: proc "system" (this: ^ExecutionInstanceIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^ExecutionInstanceIF, Name: BStr) -> HResult,
}

executioninstance_name_get :: proc(ei: ExecutionInstance) -> (name: string, ok: bool) {
    if ei == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionInstanceIF)(ei)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executioninstance_name_set :: proc(ei: ExecutionInstance, name: string) -> (ok: bool) {
    if ei == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExecutionInstanceIF)(ei)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

executioninstance_release :: proc(ei: ExecutionInstance) {
    if ei != nil {
        (^ExecutionInstanceIF)(ei)->Release()
    }
}
