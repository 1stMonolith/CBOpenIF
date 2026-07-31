package cbopenif

SFCSimultaneous :: distinct rawptr

SFCSimultaneousIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^SFCSimultaneousVTable,
}

SFCSimultaneousVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: ^SFCBranches) -> HResult,
    Missing8:       proc "system" (this: ^SFCSimultaneousIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: SFCBranches) -> HResult,
}

sfcsimultaneous_new :: proc(nr_of_branches: i32) -> (sfcsimultaneous: SFCSimultaneous, ok: bool) {
    sfcsimultaneous = nil
    ok = false

    if !connected() do return

    hr := factoryif->NewSFCSimultaneous(nr_of_branches, cast(^SFCSimultaneous)&sfcsimultaneous)
    if failed(hr) do return

    return sfcsimultaneous, true
}

sfcsimultaneous_branches :: proc {
    sfcsimultaneous_branches_,
    sfcsimultaneous_branches_set,
}

@(private)
sfcsimultaneous_branches_ :: proc(sfcsimultaneous: SFCSimultaneous) -> (branches: SFCBranches, ok: bool) {
    branches = nil
    ok = false

    if sfcsimultaneous == nil do return
    if !connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesGet(&branches)
    if failed(hr) do return

    return branches, true
}

@(private)
sfcsimultaneous_branches_set :: proc(sfcsimultaneous: SFCSimultaneous, branches: SFCBranches) -> (ok: bool) {
    ok = false

    if sfcsimultaneous == nil do return
    if !connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesPut(branches)
    if failed(hr) do return

    return true
}

sfcsimultaneous_release :: proc(sfcsimultaneous: SFCSimultaneous) {
    if sfcsimultaneous != nil {
        (^SFCSimultaneousIF)(sfcsimultaneous)->Release()
    }
}