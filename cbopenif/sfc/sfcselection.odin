package sfc

import "../com"
import "../controlbuilder"
import "../factory"

SFCSelectionIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCSelectionVTable,
}

SFCSelectionVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSelectionIF, SFCBranches: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^SFCSelectionIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSelectionIF, SFCBranches: rawptr) -> HResult,
}

sfcselection_new :: proc(nr_of_branches: i32) -> (sfcselection: rawptr, ok: bool) {
    sfcselection = nil
    ok = false

    if !controlbuilder.connected() do return

    hr := factory.factoryif->NewSFCSelection(nr_of_branches, cast(^rawptr)&sfcselection)
    if com.failed(hr) do return

    return sfcselection, true
}

sfcselection_branches :: proc {
    sfcselection_branches_,
    sfcselection_branches_set,
}

@(private)
sfcselection_branches_ :: proc(sfcselection: rawptr) -> (branches: rawptr, ok: bool) {
    branches = nil
    ok = false

    if sfcselection == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesGet(&branches)
    if com.failed(hr) do return

    return branches, true
}

@(private)
sfcselection_branches_set :: proc(sfcselection: rawptr, branches: rawptr) -> (ok: bool) {
    ok = false

    if sfcselection == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesPut(branches)
    if com.failed(hr) do return

    return true
}

sfcselection_release :: proc(sfcselection: rawptr) {
    if sfcselection != nil {
        (^SFCSelectionIF)(sfcselection)->Release()
    }
}