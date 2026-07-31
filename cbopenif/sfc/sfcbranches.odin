package sfc

import "../com"
import "../controlbuilder"

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

sfcbranches_add_ :: proc(sfcbranches: rawptr, branch: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return
    if branch == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Add(branch)
    if com.failed(hr) do return

    return true
}

sfcbranches_add_at_index :: proc(sfcbranches: rawptr, branch: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return
    if branch == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBefore(branch, index)
    if com.failed(hr) do return

    return true
}

sfcbranches_add_branch :: proc {
    sfcbranches_add_branch_,
    sfcbranches_add_branch_before,
    // sfcbranches_add_branch_after,   TODO!
}

sfcbranches_add_branch_ :: proc(sfcbranches: rawptr) -> (branch: rawptr, ok: bool) {
    branch = nil
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBranch(&branch)
    if com.failed(hr) do return

    return branch, true
}

sfcbranches_add_branch_before :: proc(sfcbranches: rawptr, index: ^i32) -> (branch: rawptr, ok: bool) {
    branch = nil
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return
    if index == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBranchBefore(index, &branch)
    if com.failed(hr) do return

    return branch, true
}

sfcbranches_add_branch_after :: proc(sfcbranches: rawptr, index: ^i32) -> (branch: rawptr, ok: bool) {
    branch = nil
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return
    if index == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBranchAfter(index, &branch)
    if com.failed(hr) do return

    return branch, true
}

sfcbranches_branch :: proc(sfcbranches: rawptr, index: i32) -> (branch: rawptr, ok: bool) {
    branch = nil
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Item(index, &branch)
    if com.failed(hr) do return

    return branch, true
}

sfcbranches_count :: proc(sfcbranches: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

sfcbranches_remove :: proc(sfcbranches: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Remove(index)
    if com.failed(hr) do return

    return true
}

sfcbranches_release :: proc(sfcbranches: rawptr) {
    if sfcbranches != nil {
        (^SFCBranchesIF)(sfcbranches)->Release()
    }
}
