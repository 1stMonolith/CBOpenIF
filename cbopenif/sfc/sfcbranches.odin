package sfc

import "../com"
import "../controlbuilder"

@(private="file") HResult :: com.HResult

SFCBranches :: distinct rawptr

SFCBranchesIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCBranchesVTable,
}

SFCBranchesVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:             proc "system" (this: ^SFCBranchesIF, SFCBranch: rawptr) -> HResult,
    AddBefore:       proc "system" (this: ^SFCBranchesIF, SFCBranch: rawptr, BeforeIndex: i32) -> HResult,
    AddBranch:       proc "system" (this: ^SFCBranchesIF, SFCBranch: ^rawptr) -> HResult,
    AddBranchBefore: proc "system" (this: ^SFCBranchesIF, Index: ^i32, SFCBranch: ^rawptr) -> HResult,
    AddBranchAfter:  proc "system" (this: ^SFCBranchesIF, Index: ^i32, SFCBranch: ^rawptr) -> HResult,
    Item:            proc "system" (this: ^SFCBranchesIF, Index: i32, SFCBranch: ^rawptr) -> HResult,
    Count:           proc "system" (this: ^SFCBranchesIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^SFCBranchesIF, Index: i32) -> HResult,
}

sfcbranches_add :: proc {
    sfcbranches_add_,
    sfcbranches_add_at_index,
}

sfcbranches_add_ :: proc(sfcbranches: SFCBranches, sfcbranch: SFCBranch) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if sfcbranches == nil do return
    if sfcbranch == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Add(sfcbranch)
    if com.failed(hr) do return

    return true
}

sfcbranches_add_at_index :: proc(sfcbranches: SFCBranches, sfcbranch: SFCBranch, index: i32) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if sfcbranches == nil do return
    if sfcbranch == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBefore(sfcbranch, index)
    if com.failed(hr) do return

    return true
}

sfcbrachs_brach :: proc {
    sfcbranches_branch_by_index,
}

sfcbranches_branch_by_index :: proc(sfcbranches: SFCBranches, index: i32) -> (sfcbranch: SFCBranch, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Item(index, cast(^rawptr)&sfcbranch)
    if com.failed(hr) do return

    return sfcbranch, true
}

sfcbranches_count :: proc(sfcbranches: SFCBranches) -> (count: i32, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

sfcbrachs_remove :: proc {
    sfcbranches_remove_by_index,
}

sfcbranches_remove_by_index :: proc(sfcbranches: SFCBranches, index: i32) -> (ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Remove(index)
    if com.failed(hr) do return

    return true
}

sfcbranches_release :: proc(sfcbranches: SFCBranches) {
    if sfcbranches != nil {
        (^SFCBranchesIF)(sfcbranches)->Release()
    }
}
