package sfc

import "../com"
import "../controlbuilder"
import "../bstr"

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

sfcsimultaneous_new :: proc(nr_of_branches: i32) -> (sfcsimultaneous: rawptr, ok: bool) {
    sfcsimultaneous = nil
    ok = false

    if !controlbuilder.connected() do return

    hr := factoryif->NewSFCSimultaneous(nr_of_branches, cast(^rawptr)&sfcsimultaneous)
    if com.failed(hr) do return

    return sfcsimultaneous, true
}

sfcsimultaneous_branches :: proc {
    sfcsimultaneous_branches_,
    sfcsimultaneous_branches_set,
}

@(private)
sfcsimultaneous_branches_ :: proc(sfcsimultaneous: rawptr) -> (branches: rawptr, ok: bool) {
    branches = nil
    ok = false

    if sfcsimultaneous == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesGet(&branches)
    if com.failed(hr) do return

    return branches, true
}

@(private)
sfcsimultaneous_branches_set :: proc(sfcsimultaneous: rawptr, branches: rawptr) -> (ok: bool) {
    ok = false

    if sfcsimultaneous == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesPut(branches)
    if com.failed(hr) do return

    return true
}

sfcsimultaneous_release :: proc(sfcsimultaneous: rawptr) {
    if sfcsimultaneous != nil {
        (^SFCSimultaneousIF)(sfcsimultaneous)->Release()
    }
}