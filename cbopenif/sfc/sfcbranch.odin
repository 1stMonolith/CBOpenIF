package sfc

import "../com"
import "../controlbuilder"

SFCBranch :: distinct rawptr

SFCBranchIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCBranchVTable,
}

SFCBranchVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    PriorityGet: proc "system" (this: ^SFCBranchIF, SFCPriority: ^SFCPriorityType) -> HResult,
    PriorityPut: proc "system" (this: ^SFCBranchIF, SFCPriority: SFCPriorityType) -> HResult,
    ElementsGet: proc "system" (this: ^SFCBranchIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCBranchIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCBranchIF, SFCElements: rawptr) -> HResult,
}

sfcbranch_priority :: proc {
    sfcbranch_priority_get,
    sfcbranch_priority_set,
}

sfcbranch_priority_get :: proc(sfcbranch: SFCBranch) -> (priority: SFCPriorityType, ok: bool) {

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->PriorityGet(&priority)
    if com.failed(hr) do return

    return priority, true
}

sfcbranch_priority_set :: proc(sfcbranch: SFCBranch, priority: SFCPriorityType) -> (ok: bool) {

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->PriorityPut(priority)
    if com.failed(hr) do return

    return true
}

sfcbranch_elements :: proc {
    sfcbranch_elements_get,
    sfcbranch_elements_set,
}

sfcbranch_elements_get :: proc(sfcbranch: SFCBranch) -> (sfcelements: SFCElements, ok: bool) {

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsGet(cast(^rawptr)&sfcelements)
    if com.failed(hr) do return

    return sfcelements, true
}

sfcbranch_elements_set :: proc(sfcbranch: SFCBranch, sfcelements: SFCElements) -> (ok: bool) {

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsPut(sfcelements)
    if com.failed(hr) do return

    return true
}

sfcbranch_release :: proc(sfcbranch: SFCBranch) {
    if sfcbranch != nil {
        (^SFCBranchIF)(sfcbranch)->Release()
    }
}
