package cbopenif

SFCSimultaneous :: distinct rawptr

SFCSimultaneousIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSimultaneousVTable,
}

SFCSimultaneousVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^SFCSimultaneousIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: rawptr) -> HResult,
}

sfcsimultaneous_new :: proc(nr_of_branches: i32) -> (sfcsimultaneous: SFCSimultaneous, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewSFCSimultaneous(nr_of_branches, cast(^rawptr)&sfcsimultaneous)
    if com_failed(hr) do return

    return sfcsimultaneous, true
}

sfcsimultaneous_branches :: proc {
    sfcsimultaneous_branches_get,
    sfcsimultaneous_branches_set,
}

sfcsimultaneous_branches_get :: proc(sfcsimultaneous: SFCSimultaneous) -> (sfcbranches: SFCBranches, ok: bool) {
    if sfcsimultaneous == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if com_failed(hr) do return

    return sfcbranches, true
}

sfcsimultaneous_branches_set :: proc(sfcsimultaneous: SFCSimultaneous, sfcbranches: SFCBranches) -> (ok: bool) {
    if sfcsimultaneous == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesPut(sfcbranches)
    if com_failed(hr) do return

    return true
}

sfcsimultaneous_release :: proc(sfcsimultaneous: SFCSimultaneous) {
    if sfcsimultaneous != nil {
        (^SFCSimultaneousIF)(sfcsimultaneous)->Release()
    }
}
