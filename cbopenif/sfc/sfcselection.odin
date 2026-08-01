package sfc

import "../com"
import "../controlbuilder"
import "../factory"

SFCSelection :: distinct rawptr

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

sfcselection_new :: proc(nr_of_branches: i32) -> (sfcselection: SFCSelection, ok: bool) {
    sfcselection = nil
    ok = false

    if !controlbuilder.connected() do return

    hr := factory.factoryif->NewSFCSelection(nr_of_branches, cast(^rawptr)&sfcselection)
    if com.failed(hr) do return

    return sfcselection, true
}

sfcselection_branches :: proc {
    sfcselection_branches_get,
    sfcselection_branches_set,
}

sfcselection_branches_get :: proc(sfcselection: SFCSelection) -> (sfcbranches: SFCBranches, ok: bool) {
    sfcbranches = nil
    ok = false

    if sfcselection == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if com.failed(hr) do return

    return sfcbranches, true
}

sfcselection_branches_set :: proc(sfcselection: SFCSelection, sfcbranches: SFCBranches) -> (ok: bool) {
    ok = false

    if sfcselection == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesPut(sfcbranches)
    if com.failed(hr) do return

    return true
}

sfcselection_release :: proc(sfcselection: SFCSelection) {
    if sfcselection != nil {
        (^SFCSelectionIF)(sfcselection)->Release()
    }
}
