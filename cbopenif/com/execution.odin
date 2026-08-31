package com

ExecutionOrder    :: distinct rawptr
ExecutionGroup    :: distinct rawptr
ExecutionInstance :: distinct rawptr

ExecutionOrderIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionOrderVTable,
}

ExecutionOrderVTable :: struct
{
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

SerializeExecutionOrder :: proc(executionorder: ExecutionOrder) -> (xml: string, ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExecutionOrderIF)(executionorder)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

AddExecutionOrder :: proc {
    _AddExecutionOrder,
    _AddExecutionOrderAtIndex,
}

_AddExecutionOrder :: proc(executionorder: ExecutionOrder, executiongroup: ExecutionGroup) -> (ok: bool)
{
    if executionorder == nil do return
    if executiongroup == nil do return
    if !ComConnected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Add(executiongroup)
    if ComFailed(hr) do return

    return true
}

_AddExecutionOrderAtIndex :: proc(executionorder: ExecutionOrder, executiongroup: ExecutionGroup, index: i32) -> (ok: bool)
{
    if executionorder == nil do return
    if executiongroup == nil do return
    if !ComConnected() do return

    hr := (^ExecutionOrderIF)(executionorder)->AddBefore(executiongroup, index)
    if ComFailed(hr) do return

    return true
}

GetExecutionOrder :: proc {
    _GetExecutionOrderWithName,
    _GetExecutionOrderAtIndex,
}

_GetExecutionOrderWithName :: proc(executionorder: ExecutionOrder, task_name: string) -> (executiongroup: ExecutionGroup, ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    bstr_task_name := ToBstr(task_name)
    defer FreeBstr(bstr_task_name)
    hr := (^ExecutionOrderIF)(executionorder)->Find(bstr_task_name, cast(^rawptr)&executiongroup)
    if ComFailed(hr) do return

    return executiongroup, true
}

_GetExecutionOrderAtIndex :: proc(executionorder: ExecutionOrder, index: i32) -> (executiongroup: ExecutionGroup, ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Item(index + 1, cast(^rawptr)&executiongroup)
    if ComFailed(hr) do return

    return executiongroup, true
}

ExecutionOrderIndex :: proc(executionorder: ExecutionOrder, task_name: string) -> (index: i32, ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    bstr_task_name := ToBstr(task_name)
    defer FreeBstr(bstr_task_name)
    hr := (^ExecutionOrderIF)(executionorder)->FindNr(bstr_task_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ExecutionOrderCount :: proc(executionorder: ExecutionOrder) -> (count: i32, ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveExecutionOrder :: proc {
    _RemoveExecutionOrderWithName,
    _RemoveExecutionOrderAtIndex,
}

_RemoveExecutionOrderWithName :: proc(executionorder: ExecutionOrder, task_name: string) -> (ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ExecutionOrderIndex(executionorder, task_name)
    if !ok do return

    hr := (^ExecutionOrderIF)(executionorder)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveExecutionOrderAtIndex :: proc(executionorder: ExecutionOrder, index: i32) -> (ok: bool)
{
    if executionorder == nil do return
    if !ComConnected() do return

    hr := (^ExecutionOrderIF)(executionorder)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseExecutionOrder :: proc(executionorder: ExecutionOrder) {
    if executionorder != nil {
        (^ExecutionOrderIF)(executionorder)->Release()
    }
}

ExecutionGroupIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionGroupVTable,
}

ExecutionGroupVTable :: struct
{
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

GetExecutionGroupName :: proc(executiongroup: ExecutionGroup) -> (task_name: string, ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExecutionGroupIF)(executiongroup)->TaskNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExecutionGroupName :: proc(executiongroup: ExecutionGroup, task_name: string) -> (ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    bs := ToBstr(task_name)
    defer FreeBstr(bs)
    hr := (^ExecutionGroupIF)(executiongroup)->TaskNamePut(bs)
    if ComFailed(hr) do return

    return true
}

SerializeExecutionGroup :: proc(executiongroup: ExecutionGroup) -> (xml: string, ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExecutionGroupIF)(executiongroup)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

AddExecutionInstance :: proc {
    _AddExecutionInstance,
    _AddExecutionInstanceAtIndex,
}

_AddExecutionInstance :: proc(executiongroup: ExecutionGroup, executioninstance: ExecutionInstance) -> (ok: bool)
{
    if executiongroup == nil do return
    if executioninstance == nil do return
    if !ComConnected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Add(executioninstance)
    if ComFailed(hr) do return

    return true
}

_AddExecutionInstanceAtIndex :: proc(executiongroup: ExecutionGroup, executioninstance: ExecutionInstance, index: i32) -> (ok: bool)
{
    if executiongroup == nil do return
    if executioninstance == nil do return
    if !ComConnected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->AddBefore(executioninstance, index)
    if ComFailed(hr) do return

    return true
}

GetExecutionInstance :: proc {
    _GetExecutionInstanceWithName,
    _GetExecutionInstanceAtIndex,
}

_GetExecutionInstanceWithName :: proc(executiongroup: ExecutionGroup, name: string) -> (executioninstance: ExecutionInstance, ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ExecutionGroupIF)(executiongroup)->Find(bstr_name, cast(^rawptr)&executioninstance)
    if ComFailed(hr) do return

    return executioninstance, true
}

_GetExecutionInstanceAtIndex :: proc(executiongroup: ExecutionGroup, index: i32) -> (executioninstance: ExecutionInstance, ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Item(index + 1, cast(^rawptr)&executioninstance)
    if ComFailed(hr) do return

    return executioninstance, true
}

ExecutionInstanceIndex :: proc(executiongroup: ExecutionGroup, name: string) -> (index: i32, ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ExecutionGroupIF)(executiongroup)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ExecutionInstanceCount :: proc(executiongroup: ExecutionGroup) -> (count: i32, ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveExecutionInstance :: proc {
    _RemoveExecutionInstanceWithName,
    _RemoveExecutionInstanceAtIndex,
}

_RemoveExecutionInstanceWithName :: proc(executiongroup: ExecutionGroup, name: string) -> (ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ExecutionInstanceIndex(executiongroup, name)
    if !ok do return

    hr := (^ExecutionGroupIF)(executiongroup)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveExecutionInstanceAtIndex :: proc(executiongroup: ExecutionGroup, index: i32) -> (ok: bool)
{
    if executiongroup == nil do return
    if !ComConnected() do return

    hr := (^ExecutionGroupIF)(executiongroup)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseExecutionGroup :: proc(executiongroup: ExecutionGroup) {
    if executiongroup != nil {
        (^ExecutionGroupIF)(executiongroup)->Release()
    }
}

ExecutionInstanceIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionInstanceVTable,
}

ExecutionInstanceVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet: proc "system" (this: ^ExecutionInstanceIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^ExecutionInstanceIF, Name: BStr) -> HResult,
}

GetExecutionInstanceName :: proc(ei: ExecutionInstance) -> (name: string, ok: bool)
{
    if ei == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExecutionInstanceIF)(ei)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExecutionInstanceName :: proc(ei: ExecutionInstance, name: string) -> (ok: bool)
{
    if ei == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ExecutionInstanceIF)(ei)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseExecutionInstance :: proc(ei: ExecutionInstance) {
    if ei != nil {
        (^ExecutionInstanceIF)(ei)->Release()
    }
}
