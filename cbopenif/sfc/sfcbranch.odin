package sfc

import "../com"
import "../controlbuilder"
import "../enumtypes"

@(private) SFCPriorityValue :: enumtypes.SFCPriorityValue

SFCBranchIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCBranchVTable,
}

SFCBranchVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    PriorityGet: proc "system" (this: ^SFCBranchIF, SFCPriority: ^SFCPriorityValue) -> HResult,
    PriorityPut: proc "system" (this: ^SFCBranchIF, SFCPriority: SFCPriorityValue) -> HResult,
    ElementsGet: proc "system" (this: ^SFCBranchIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCBranchIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCBranchIF, SFCElements: rawptr) -> HResult,
}

sfcbranch_priority :: proc {
    sfcbranch_priority_,
    sfcbranch_priority_set,
}

@(private)
sfcbranch_priority_ :: proc(sfcbranch: rawptr) -> (priority: SFCPriorityValue, ok: bool) {
    priority = .Default
    ok = false

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->PriorityGet(&priority)
    if com.failed(hr) do return

    return priority, true
}

@(private)
sfcbranch_priority_set :: proc(sfcbranch: rawptr, priority: SFCPriorityValue) -> (ok: bool) {
    ok = false

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->PriorityPut(priority)
    if com.failed(hr) do return

    return true
}

sfcbranch_elements :: proc {
    sfcbranch_elements_,
    sfcbranch_elements_set,
}

@(private)
sfcbranch_elements_ :: proc(sfcbranch: rawptr) -> (elements: rawptr, ok: bool) {
    elements = nil
    ok = false

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsGet(&elements)
    if com.failed(hr) do return

    return elements, true
}

@(private)
sfcbranch_elements_set :: proc(sfcbranch: rawptr, elements: rawptr) -> (ok: bool) {
    ok = false

    if sfcbranch == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsPut(elements)
    if com.failed(hr) do return

    return true
}

sfcbranch_release :: proc(sfcbranch: rawptr) {
    if sfcbranch != nil {
        (^SFCBranchIF)(sfcbranch)->Release()
    }
}