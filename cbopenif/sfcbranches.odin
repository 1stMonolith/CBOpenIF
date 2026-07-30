package cbopenif

SFCBranches :: distinct rawptr

SFCBranchesIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^SFCBranchesVTable,
}

SFCBranchesVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:             proc "system" (this: ^SFCBranchesIF, SFCBranch: SFCBranch) -> HResult,
    AddBefore:       proc "system" (this: ^SFCBranchesIF, SFCBranch: SFCBranch, BeforeIndex: i32) -> HResult,
    AddBranch:       proc "system" (this: ^SFCBranchesIF, SFCBranch: ^SFCBranch) -> HResult,
    AddBranchBefore: proc "system" (this: ^SFCBranchesIF, Index: ^i32, SFCBranch: ^SFCBranch) -> HResult,
    AddBranchAfter:  proc "system" (this: ^SFCBranchesIF, Index: ^i32, SFCBranch: ^SFCBranch) -> HResult,
    Item:            proc "system" (this: ^SFCBranchesIF, Index: i32, SFCBranch: ^SFCBranch) -> HResult,
    Count:           proc "system" (this: ^SFCBranchesIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^SFCBranchesIF, Index: i32) -> HResult,
}

sfcbranches_add :: proc {
    sfcbranches_add_,
    sfcbranches_add_at_index,
}

@(private)
sfcbranches_add_ :: proc(sfcbranches: SFCBranches, branch: SFCBranch) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcbranches == nil do return
    if branch == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Add(branch)
    if failed(hr) do return

    return true
}

@(private)
sfcbranches_add_at_index :: proc(sfcbranches: SFCBranches, branch: SFCBranch, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcbranches == nil do return
    if branch == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBefore(branch, index)
    if failed(hr) do return

    return true
}

sfcbranches_add_branch :: proc {
    sfcbranches_add_branch_,
    sfcbranches_add_branch_before,
    // sfcbranches_add_branch_after, TODO
}

@(private)
sfcbranches_add_branch_ :: proc(sfcbranches: SFCBranches) -> (branch: SFCBranch, ok: bool) {
    branch = nil
    ok = false

    if !connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBranch(&branch)
    if failed(hr) do return

    return branch, true
}

@(private)
sfcbranches_add_branch_before :: proc(sfcbranches: SFCBranches, index: ^i32) -> (branch: SFCBranch, ok: bool) {
    branch = nil
    ok = false

    if !connected() do return
    if sfcbranches == nil do return
    if index == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBranchBefore(index, &branch)
    if failed(hr) do return

    return branch, true
}

/* TODO
@(private)
sfcbranches_add_branch_after :: proc(sfcbranches: SFCBranches, index: ^i32) -> (branch: SFCBranch, ok: bool) {
    branch = nil
    ok = false

    if !connected() do return
    if sfcbranches == nil do return
    if index == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBranchAfter(index, &branch)
    if failed(hr) do return

    return branch, true
}
*/

sfcbranches_branch :: proc(sfcbranches: SFCBranches, index: i32) -> (branch: SFCBranch, ok: bool) {
    branch = nil
    ok = false

    if !connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Item(index, &branch)
    if failed(hr) do return

    return branch, true
}

sfcbranches_count :: proc(sfcbranches: SFCBranches) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Count(&count)
    if failed(hr) do return

    return count, true
}

sfcbranches_remove :: proc(sfcbranches: SFCBranches, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcbranches == nil do return

    hr := (^SFCBranchesIF)(sfcbranches)->Remove(index)
    if failed(hr) do return

    return true
}

sfcbranches_release :: proc(sfcbranches: SFCBranches) {
    if sfcbranches != nil {
        (^SFCBranchesIF)(sfcbranches)->Release()
    }
}