package sfc

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") HResult :: com.HResult

SFCSimultaneous :: distinct rawptr

SFCSimultaneousIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCSimultaneousVTable,
}

SFCSimultaneousVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^SFCSimultaneousIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: rawptr) -> HResult,
}

sfcsimultaneous_new :: proc(nr_of_branches: i32) -> (sfcsimultaneous: SFCSimultaneous, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return

    hr := factory.factoryif->NewSFCSimultaneous(nr_of_branches, cast(^rawptr)&sfcsimultaneous)
    if com.failed(hr) do return

    return sfcsimultaneous, true
}

sfcsimultaneous_branches :: proc {
    sfcsimultaneous_branches_get,
    sfcsimultaneous_branches_set,
}

sfcsimultaneous_branches_get :: proc(sfcsimultaneous: SFCSimultaneous) -> (sfcbranches: SFCBranches, ok: bool) {

    if sfcsimultaneous == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if com.failed(hr) do return

    return sfcbranches, true
}

sfcsimultaneous_branches_set :: proc(sfcsimultaneous: SFCSimultaneous, sfcbranches: SFCBranches) -> (ok: bool) {
    if sfcsimultaneous == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesPut(sfcbranches)
    if com.failed(hr) do return

    return true
}

sfcsimultaneous_release :: proc(sfcsimultaneous: SFCSimultaneous) {
    if sfcsimultaneous != nil {
        (^SFCSimultaneousIF)(sfcsimultaneous)->Release()
    }
}
