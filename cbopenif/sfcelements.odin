package cbopenif

SFCElements :: distinct rawptr

SFCElementsIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^SFCElementsVTable,
}

SFCElementsVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    AddStep:          proc "system" (this: ^SFCElementsIF, SFCStep: SFCStep) -> HResult,
    AddStep1:         proc "system" (this: ^SFCElementsIF, Name: BStr, SFCStep: ^SFCStep) -> HResult,
    AddStep2:         proc "system" (this: ^SFCElementsIF, Name: BStr, InitialStep: VariantBool, P1ActionSTCode, NActionSTCode, P0ActionSTCode: BStr, SFCStep: ^SFCStep) -> HResult,
    AddTransition:    proc "system" (this: ^SFCElementsIF, SFCTransition: SFCTransition) -> HResult,
    AddTransition1:   proc "system" (this: ^SFCElementsIF, Name: BStr, SFCTransition: ^SFCTransition) -> HResult,
    AddTransition2:   proc "system" (this: ^SFCElementsIF, Name, STCode, Dest: BStr, SFCTransition: ^SFCTransition) -> HResult,
    AddSelection:     proc "system" (this: ^SFCElementsIF, SFCSelection: SFCSelection) -> HResult,
    AddSelection1:    proc "system" (this: ^SFCElementsIF, NrOfBranches: i32, SFCSelection: ^SFCSelection) -> HResult,
    AddSimultaneous:  proc "system" (this: ^SFCElementsIF, SFCSimultaneous: SFCSimultaneous) -> HResult,
    AddSimultaneous1: proc "system" (this: ^SFCElementsIF, NrOfBranches: i32, SFCSimultaneous: ^SFCSimultaneous) -> HResult,
    AddSubSequence:   proc "system" (this: ^SFCElementsIF, SFCSubSequence: SFCSubSequence) -> HResult,
    AddSubSequence1:  proc "system" (this: ^SFCElementsIF, Name: BStr, SFCSubSequence: ^SFCSubSequence) -> HResult,
    Add:              proc "system" (this: ^SFCElementsIF, ISFCElement: ISFCElement) -> HResult,
    AddBefore:        proc "system" (this: ^SFCElementsIF, ISFCElement: ISFCElement, Index: i32) -> HResult,
    Item:             proc "system" (this: ^SFCElementsIF, Index: i32, ISFCElement: ^ISFCElement) -> HResult,
    Count:            proc "system" (this: ^SFCElementsIF, Count: ^i32) -> HResult,
    Remove:           proc "system" (this: ^SFCElementsIF, Index: i32) -> HResult,
}

sfcelements_add_step :: proc(sfcelements: SFCElements, sfcstep: SFCStep) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if sfcstep == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddStep(sfcstep)
    if failed(hr) do return

    return true
}

sfcelements_add_transition :: proc(sfcelements: SFCElements, sfctransition: SFCTransition) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if sfctransition == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddTransition(sfctransition)
    if failed(hr) do return

    return true
}

sfcelements_add_sfcselectionection :: proc(sfcelements: SFCElements, sfcselection: SFCSelection) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if sfcselection == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddSelection(sfcselection)
    if failed(hr) do return

    return true
}

sfcelements_add_sfcsimultaneousultaneous :: proc(sfcelements: SFCElements, sfcsimultaneous: SFCSimultaneous) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if sfcsimultaneous == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddSimultaneous(sfcsimultaneous)
    if failed(hr) do return

    return true
}

sfcelements_add_sfcsubsequenceuence :: proc(sfcelements: SFCElements, sfcsubsequence: SFCSubSequence) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if sfcsubsequence == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddSubSequence(sfcsubsequence)
    if failed(hr) do return

    return true
}

sfcelements_add :: proc {
    sfcelements_add_,
    sfcelements_add_at_index,
}

@(private)
sfcelements_add_ :: proc(sfcelements: SFCElements, isfcelement: ISFCElement) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if isfcelement == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Add(isfcelement)
    if failed(hr) do return

    return true
}

@(private)
sfcelements_add_at_index :: proc(sfcelements: SFCElements, isfcelement: ISFCElement, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return
    if isfcelement == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddBefore(isfcelement, index)
    if failed(hr) do return

    return true
}

sfcelements_element :: proc(sfcelements: SFCElements, index: i32) -> (isfcelement: ISFCElement, ok: bool) {
    isfcelement = nil
    ok = false

    if !connected() do return
    if sfcelements == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Item(index, &isfcelement)
    if failed(hr) do return

    return isfcelement, true
}

sfcelements_count :: proc(sfcelements: SFCElements) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if sfcelements == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Count(&count)
    if failed(hr) do return

    return count, true
}

sfcelements_remove :: proc(sfcelements: SFCElements, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if sfcelements == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Remove(index)
    if failed(hr) do return

    return true
}

sfcelements_release :: proc(sfcelements: SFCElements) {
    if sfcelements != nil {
        (^SFCElementsIF)(sfcelements)->Release()
    }
}