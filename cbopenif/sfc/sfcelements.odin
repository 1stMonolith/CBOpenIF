package sfc

import "../com"
import "../controlbuilder"
import "../bstr"

SFCElementsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCElementsVTable,
}

SFCElementsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    AddStep:          proc "system" (this: ^SFCElementsIF, SFCStep: rawptr) -> HResult,
    AddStep1:         proc "system" (this: ^SFCElementsIF, Name: BStr, SFCStep: ^rawptr) -> HResult,
    AddStep2:         proc "system" (this: ^SFCElementsIF, Name: BStr, InitialStep: VariantBool, P1ActionSTCode, NActionSTCode, P0ActionSTCode: BStr, SFCStep: ^rawptr) -> HResult,
    AddTransition:    proc "system" (this: ^SFCElementsIF, SFCTransition: rawptr) -> HResult,
    AddTransition1:   proc "system" (this: ^SFCElementsIF, Name: BStr, SFCTransition: ^rawptr) -> HResult,
    AddTransition2:   proc "system" (this: ^SFCElementsIF, Name, STCode, Dest: BStr, SFCTransition: ^rawptr) -> HResult,
    AddSelection:     proc "system" (this: ^SFCElementsIF, SFCSelection: rawptr) -> HResult,
    AddSelection1:    proc "system" (this: ^SFCElementsIF, NrOfBranches: i32, SFCSelection: ^rawptr) -> HResult,
    AddSimultaneous:  proc "system" (this: ^SFCElementsIF, SFCSimultaneous: rawptr) -> HResult,
    AddSimultaneous1: proc "system" (this: ^SFCElementsIF, NrOfBranches: i32, SFCSimultaneous: ^rawptr) -> HResult,
    AddSubSequence:   proc "system" (this: ^SFCElementsIF, SFCSubSequence: rawptr) -> HResult,
    AddSubSequence1:  proc "system" (this: ^SFCElementsIF, Name: BStr, SFCSubSequence: ^rawptr) -> HResult,
    Add:              proc "system" (this: ^SFCElementsIF, ISFCElement: rawptr) -> HResult,
    AddBefore:        proc "system" (this: ^SFCElementsIF, ISFCElement: rawptr, Index: i32) -> HResult,
    Item:             proc "system" (this: ^SFCElementsIF, Index: i32, ISFCElement: ^rawptr) -> HResult,
    Count:            proc "system" (this: ^SFCElementsIF, Count: ^i32) -> HResult,
    Remove:           proc "system" (this: ^SFCElementsIF, Index: i32) -> HResult,
}

sfcelements_add_sfcstep :: proc(sfcelements: rawptr, sfcstep: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if sfcstep == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddStep(sfcstep)
    if com.failed(hr) do return

    return true
}

sfcelements_add_sfctransition :: proc(sfcelements: rawptr, sfctransition: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if sfctransition == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddTransition(sfctransition)
    if com.failed(hr) do return

    return true
}

sfcelements_add_sfcselection :: proc(sfcelements: rawptr, sfcselection: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if sfcselection == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddSelection(sfcselection)
    if com.failed(hr) do return

    return true
}

sfcelements_add_sfcsimultaneous :: proc(sfcelements: rawptr, sfcsimultaneous: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if sfcsimultaneous == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddSimultaneous(sfcsimultaneous)
    if com.failed(hr) do return

    return true
}

sfcelements_add_sfcsubsequence :: proc(sfcelements: rawptr, sfcsubsequence: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if sfcsubsequence == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddSubSequence(sfcsubsequence)
    if com.failed(hr) do return

    return true
}

sfcelements_add :: proc {
    sfcelements_add_,
    sfcelements_add_at_index,
}

@(private)
sfcelements_add_ :: proc(sfcelements: rawptr, isfcelement: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if isfcelement == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Add(isfcelement)
    if com.failed(hr) do return

    return true
}

@(private)
sfcelements_add_at_index :: proc(sfcelements: rawptr, isfcelement: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return
    if isfcelement == nil do return

    hr := (^SFCElementsIF)(sfcelements)->AddBefore(isfcelement, index)
    if com.failed(hr) do return

    return true
}

sfcelement_sfelement :: proc {
    sfcelements_sfcelement_by_index,
}

sfcelements_sfcelement_by_index :: proc(sfcelements: rawptr, index: i32) -> (isfcelement: rawptr, ok: bool) {
    isfcelement = nil
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Item(index, &isfcelement)
    if com.failed(hr) do return

    return isfcelement, true
}

sfcelements_count :: proc(sfcelements: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

sfcelements_remove :: proc(sfcelements: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if sfcelements == nil do return

    hr := (^SFCElementsIF)(sfcelements)->Remove(index)
    if com.failed(hr) do return

    return true
}

sfcelements_release :: proc(sfcelements: rawptr) {
    if sfcelements != nil {
        (^SFCElementsIF)(sfcelements)->Release()
    }
}