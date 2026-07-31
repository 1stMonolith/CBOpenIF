package cbopenif

SFCSelection :: distinct rawptr

SFCSelectionIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^SFCSelectionVTable,
}

SFCSelectionVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSelectionIF, SFCBranches: ^SFCBranches) -> HResult,
    Missing8:       proc "system" (this: ^SFCSelectionIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSelectionIF, SFCBranches: SFCBranches) -> HResult,
}

sfcselection_new :: proc(nr_of_branches: i32) -> (sfcselection: SFCSelection, ok: bool) {
    sfcselection = nil
    ok = false

    if !connected() do return

    hr := factoryif->NewSFCSelection(nr_of_branches, cast(^SFCSelection)&sfcselection)
    if failed(hr) do return

    return sfcselection, true
}

sfcselection_branches :: proc {
    sfcselection_branches_,
    sfcselection_branches_set,
}

@(private)
sfcselection_branches_ :: proc(sfcselection: SFCSelection) -> (branches: SFCBranches, ok: bool) {
    branches = nil
    ok = false

    if sfcselection == nil do return
    if !connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesGet(&branches)
    if failed(hr) do return

    return branches, true
}

@(private)
sfcselection_branches_set :: proc(sfcselection: SFCSelection, branches: SFCBranches) -> (ok: bool) {
    ok = false

    if sfcselection == nil do return
    if !connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesPut(branches)
    if failed(hr) do return

    return true
}

sfcselection_release :: proc(sfcselection: SFCSelection) {
    if sfcselection != nil {
        (^SFCSelectionIF)(sfcselection)->Release()
    }
}