package com

import t "../types"

SFCBranch       :: distinct rawptr
SFCBranches     :: distinct rawptr
SFCElement      :: distinct rawptr
SFCElements     :: distinct rawptr
SFCSelection    :: distinct rawptr
SFCSimultaneous :: distinct rawptr
SFCStep         :: distinct rawptr
SFCSubSequence  :: distinct rawptr
SFCTransition   :: distinct rawptr

SFCBranchIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCBranchVTable,
}

SFCBranchVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    PriorityGet: proc "system" (this: ^SFCBranchIF, SFCPriority: ^i32) -> HResult,
    PriorityPut: proc "system" (this: ^SFCBranchIF, SFCPriority: i32) -> HResult,
    ElementsGet: proc "system" (this: ^SFCBranchIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCBranchIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCBranchIF, SFCElements: rawptr) -> HResult,
}

sfcbranch_priority_get :: proc(sfcbranch: SFCBranch) -> (priority: t.SFCPriority, ok: bool) {
    if sfcbranch == nil do return
    if !com_connected() do return

    p: i32
    hr := (^SFCBranchIF)(sfcbranch)->PriorityGet(&p)
    if com_failed(hr) do return

    return t.SFCPriority(priority), true
}

sfcbranch_priority_set :: proc(sfcbranch: SFCBranch, priority: t.SFCPriority) -> (ok: bool) {
    if sfcbranch == nil do return
    if !com_connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->PriorityPut(i32(priority))
    if com_failed(hr) do return

    return true
}

sfcbranch_elements_get :: proc(sfcbranch: SFCBranch) -> (sfcelements: SFCElements, ok: bool) {
    if sfcbranch == nil do return
    if !com_connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsGet(cast(^rawptr)&sfcelements)
    if com_failed(hr) do return

    return sfcelements, true
}

sfcbranch_elements_set :: proc(sfcbranch: SFCBranch, sfcelements: SFCElements) -> (ok: bool) {
    if sfcbranch == nil do return
    if !com_connected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsPut(sfcelements)
    if com_failed(hr) do return

    return true
}

sfcbranch_release :: proc(sfcbranch: SFCBranch) {
    if sfcbranch != nil {
        (^SFCBranchIF)(sfcbranch)->Release()
    }
}

SFCBranchesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCBranchesVTable,
}

SFCBranchesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:             proc "system" (this: ^SFCBranchesIF, SFCBranch: rawptr) -> HResult,
    AddBefore:       proc "system" (this: ^SFCBranchesIF, SFCBranch: rawptr, BeforeIndex: i32) -> HResult,
    AddBranch:       proc "system" (this: ^SFCBranchesIF, SFCBranch: ^rawptr) -> HResult,
    AddBranchBefore: proc "system" (this: ^SFCBranchesIF, Index: ^i32, SFCBranch: ^rawptr) -> HResult,
    AddBranchAfter:  proc "system" (this: ^SFCBranchesIF, Index: ^i32, SFCBranch: ^rawptr) -> HResult,
    Item:            proc "system" (this: ^SFCBranchesIF, Index: i32, SFCBranch: ^rawptr) -> HResult,
    Count:           proc "system" (this: ^SFCBranchesIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^SFCBranchesIF, Index: i32) -> HResult,
}

sfcbranches_sfcbranch_add :: proc(sfcbranches: SFCBranches, sfcbranch: SFCBranch) -> (ok: bool) {
    if sfcbranches == nil do return
    if sfcbranch == nil do return
    if !com_connected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Add(sfcbranch)
    if com_failed(hr) do return

    return true
}

sfcbranches_sfcbranch_add_at_index :: proc(sfcbranches: SFCBranches, sfcbranch: SFCBranch, index: i32) -> (ok: bool) {
    if sfcbranches == nil do return
    if sfcbranch == nil do return
    if !com_connected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBefore(sfcbranch, index)
    if com_failed(hr) do return

    return true
}

sfcbranches_sfcbranch_by_index :: proc(sfcbranches: SFCBranches, index: i32) -> (sfcbranch: SFCBranch, ok: bool) {
    if sfcbranches == nil do return
    if !com_connected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Item(index + 1, cast(^rawptr)&sfcbranch)
    if com_failed(hr) do return

    return sfcbranch, true
}

sfcbranches_sfcbranch_count :: proc(sfcbranches: SFCBranches) -> (count: i32, ok: bool) {
    if sfcbranches == nil do return
    if !com_connected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

sfcbranches_sfcbranch_remove_by_index :: proc(sfcbranches: SFCBranches, index: i32) -> (ok: bool) {
    if sfcbranches == nil do return
    if !com_connected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

sfcbranches_release :: proc(sfcbranches: SFCBranches) {
    if sfcbranches != nil {
        (^SFCBranchesIF)(sfcbranches)->Release()
    }
}

SFCElementIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCElementVTable,
}

SFCElementVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    IsSFCStepGet:         proc "system" (this: ^SFCElementIF, IsSFCStep: ^VariantBool) -> HResult,
    IsSFCTransitionGet:   proc "system" (this: ^SFCElementIF, IsSFCTransition: ^VariantBool) -> HResult,
    IsSFCSubSequenceGet:  proc "system" (this: ^SFCElementIF, IsSFCSubSequence: ^VariantBool) -> HResult,
    IsSFCSelectionGet:    proc "system" (this: ^SFCElementIF, IsSFCSelection: ^VariantBool) -> HResult,
    IsSFCSimultaneousGet: proc "system" (this: ^SFCElementIF, IsSFCSimultaneous: ^VariantBool) -> HResult,
}

sfcelement_is_step :: proc(sfcelement: SFCElement) -> (is_step: bool, ok: bool) {
    if sfcelement == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCStepGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_transition :: proc(sfcelement: SFCElement) -> (is_transition: bool, ok: bool) {
    if sfcelement == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCTransitionGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_subsequence :: proc(sfcelement: SFCElement) -> (is_subsequence: bool, ok: bool) {
    if sfcelement == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSubSequenceGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_selection :: proc(sfcelement: SFCElement) -> (is_selection: bool, ok: bool) {
    if sfcelement == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSelectionGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_simultaneous :: proc(sfcelement: SFCElement) -> (is_simultaneous: bool, ok: bool) {
    if sfcelement == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSimultaneousGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_release :: proc(sfcelement: SFCElement) {
    if sfcelement != nil {
        (^SFCElementIF)(sfcelement)->Release()
    }
}

SFCElementsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCElementsVTable,
}

SFCElementsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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

sfcelements_sfcstep_add :: proc(sfcelements: SFCElements, sfcstep: SFCStep) -> (ok: bool) {
    if sfcelements == nil do return
    if sfcstep == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddStep(sfcstep)
    if com_failed(hr) do return

    return true
}

sfcelements_sfctransition_add :: proc(sfcelements: SFCElements, sfctransition: SFCTransition) -> (ok: bool) {
    if sfcelements == nil do return
    if sfctransition == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddTransition(sfctransition)
    if com_failed(hr) do return

    return true
}

sfcelements_sfcselection_add :: proc(sfcelements: SFCElements, sfcselection: SFCSelection) -> (ok: bool) {
    if sfcelements == nil do return
    if sfcselection == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddSelection(sfcselection)
    if com_failed(hr) do return

    return true
}

sfcelements_sfcsimultaneous_add :: proc(sfcelements: SFCElements, sfcsimultaneous: SFCSimultaneous) -> (ok: bool) {
    if sfcelements == nil do return
    if sfcsimultaneous == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddSimultaneous(sfcsimultaneous)
    if com_failed(hr) do return

    return true
}

sfcelements_sfcsubsequence_add :: proc(sfcelements: SFCElements, sfcsubsequence: SFCSubSequence) -> (ok: bool) {
    if sfcelements == nil do return
    if sfcsubsequence == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddSubSequence(sfcsubsequence)
    if com_failed(hr) do return

    return true
}

sfcelements_sfcelement_add :: proc(sfcelements: SFCElements, sfcelement: SFCElement) -> (ok: bool) {
    if sfcelements == nil do return
    if sfcelement == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->Add(sfcelement)
    if com_failed(hr) do return

    return true
}


sfcelements_sfcelement_add_at_index :: proc(sfcelements: SFCElements, sfcelement: SFCElement, index: i32) -> (ok: bool) {
    if sfcelements == nil do return
    if sfcelement == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddBefore(sfcelement, index)
    if com_failed(hr) do return

    return true
}

sfcelements_sfcelement_by_index :: proc(sfcelements: SFCElements, index: i32) -> (sfcelement: SFCElement, ok: bool) {
    if sfcelements == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->Item(index + 1, cast(^rawptr)&sfcelement)
    if com_failed(hr) do return

    return sfcelement, true
}

sfcelements_sfcelement_count :: proc(sfcelements: SFCElements) -> (count: i32, ok: bool) {
    if sfcelements == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

sfcelements_sfcelement_remove_by_index :: proc(sfcelements: SFCElements, index: i32) -> (ok: bool) {
    if sfcelements == nil do return
    if !com_connected() do return

    hr := (^SFCElementsIF)(sfcelements)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

sfcelements_release :: proc(sfcelements: SFCElements) {
    if sfcelements != nil {
        (^SFCElementsIF)(sfcelements)->Release()
    }
}

SFCSelectionIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSelectionVTable,
}

SFCSelectionVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSelectionIF, SFCBranches: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^SFCSelectionIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSelectionIF, SFCBranches: rawptr) -> HResult,
}

sfcselection_branches_get :: proc(sfcselection: SFCSelection) -> (sfcbranches: SFCBranches, ok: bool) {
    if sfcselection == nil do return
    if !com_connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if com_failed(hr) do return

    return sfcbranches, true
}

sfcselection_branches_set :: proc(sfcselection: SFCSelection, sfcbranches: SFCBranches) -> (ok: bool) {
    if sfcselection == nil do return
    if !com_connected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesPut(sfcbranches)
    if com_failed(hr) do return

    return true
}

sfcselection_release :: proc(sfcselection: SFCSelection) {
    if sfcselection != nil {
        (^SFCSelectionIF)(sfcselection)->Release()
    }
}

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

sfcsimultaneous_branches_get :: proc(sfcsimultaneous: SFCSimultaneous) -> (sfcbranches: SFCBranches, ok: bool) {
    if sfcsimultaneous == nil do return
    if !com_connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if com_failed(hr) do return

    return sfcbranches, true
}

sfcsimultaneous_branches_set :: proc(sfcsimultaneous: SFCSimultaneous, sfcbranches: SFCBranches) -> (ok: bool) {
    if sfcsimultaneous == nil do return
    if !com_connected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesPut(sfcbranches)
    if com_failed(hr) do return

    return true
}

sfcsimultaneous_release :: proc(sfcsimultaneous: SFCSimultaneous) {
    if sfcsimultaneous != nil {
        (^SFCSimultaneousIF)(sfcsimultaneous)->Release()
    }
}

SFCStepIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCStepVTable,
}

SFCStepVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:           proc "system" (this: ^SFCStepIF, Name: ^BStr) -> HResult,
    NamePut:           proc "system" (this: ^SFCStepIF, Name: BStr) -> HResult,
    InitialStepGet:    proc "system" (this: ^SFCStepIF, InitialStep: ^VariantBool) -> HResult,
    InitialStepPut:    proc "system" (this: ^SFCStepIF, InitialStep: VariantBool) -> HResult,
    P1ActionSTCodeGet: proc "system" (this: ^SFCStepIF, P1ActionSTCode: ^BStr) -> HResult,
    P1ActionSTCodePut: proc "system" (this: ^SFCStepIF, P1ActionSTCode: BStr) -> HResult,
    P0ActionSTCodeGet: proc "system" (this: ^SFCStepIF, P0ActionSTCode: ^BStr) -> HResult,
    P0ActionSTCodePut: proc "system" (this: ^SFCStepIF, P0ActionSTCode: BStr) -> HResult,
    NActionSTCodeGet:  proc "system" (this: ^SFCStepIF, NActionSTCode: ^BStr) -> HResult,
    NActionSTCodePut:  proc "system" (this: ^SFCStepIF, NActionSTCode: BStr) -> HResult,
}

sfcstep_name_get :: proc(sfcstep: SFCStep) -> (name: string, ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_name_set :: proc(sfcstep: SFCStep, name: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_initial_step_get :: proc(sfcstep: SFCStep) -> (initial_step: bool, ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^SFCStepIF)(sfcstep)->InitialStepGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcstep_initial_step_set :: proc(sfcstep: SFCStep, initial_step: bool) -> (ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    hr := (^SFCStepIF)(sfcstep)->InitialStepPut(to_variantbool(initial_step))
    if com_failed(hr) do return

    return true
}

sfcstep_p1_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_p1_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_p0_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_p0_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_n_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_n_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !com_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_release :: proc(sfcstep: SFCStep) {
    if sfcstep != nil {
        (^SFCStepIF)(sfcstep)->Release()
    }
}

SFCSubSequenceIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSubSequenceVTable,
}

SFCSubSequenceVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:     proc "system" (this: ^SFCSubSequenceIF, Name: ^BStr) -> HResult,
    NamePut:     proc "system" (this: ^SFCSubSequenceIF, Name: BStr) -> HResult,
    ElementsGet: proc "system" (this: ^SFCSubSequenceIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCSubSequenceIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCSubSequenceIF, SFCElements: rawptr) -> HResult,
}

sfcsubsequence_name_get :: proc(sfcsubsequence: SFCSubSequence) -> (name: string, ok: bool) {
    if sfcsubsequence == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcsubsequence_name_set :: proc(sfcsubsequence: SFCSubSequence, name: string) -> (ok: bool) {
    if sfcsubsequence == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfcsubsequence_elements_get :: proc(sfcsubsequence: SFCSubSequence) -> (sfcelements: SFCElements, ok: bool) {
    if sfcsubsequence == nil do return
    if !com_connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsGet(cast(^rawptr)&sfcelements)
    if com_failed(hr) do return

    return sfcelements, true
}

sfcsubsequence_elements_set :: proc(sfcsubsequence: SFCSubSequence, sfcelements: SFCElements) -> (ok: bool) {
    if sfcsubsequence == nil do return
    if !com_connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsPut(sfcelements)
    if com_failed(hr) do return

    return true
}

sfcsubsequence_release :: proc(sfcsubsequence: SFCSubSequence) {
    if sfcsubsequence != nil {
        (^SFCSubSequenceIF)(sfcsubsequence)->Release()
    }
}

SFCTransitionIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCTransitionVTable,
}

SFCTransitionVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^SFCTransitionIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^SFCTransitionIF, Name: BStr) -> HResult,
    DestGet:   proc "system" (this: ^SFCTransitionIF, Dest: ^BStr) -> HResult,
    DestPut:   proc "system" (this: ^SFCTransitionIF, Dest: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^SFCTransitionIF, STCode: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^SFCTransitionIF, STCode: BStr) -> HResult,
}

sfctransition_name_get :: proc(sfctransition: SFCTransition) -> (name: string, ok: bool) {
    if sfctransition == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfctransition_name_set :: proc(sfctransition: SFCTransition, name: string) -> (ok: bool) {
    if sfctransition == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfctransition_dest_get :: proc(sfctransition: SFCTransition) -> (dest: string, ok: bool) {
    if sfctransition == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfctransition_dest_set :: proc(sfctransition: SFCTransition, dest: string) -> (ok: bool) {
    if sfctransition == nil do return
    if !com_connected() do return

    bs := to_bstr(dest)
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestPut(bs)
    if com_failed(hr) do return

    return true
}

sfctransition_stcode_get :: proc(sfctransition: SFCTransition) -> (stcode: string, ok: bool) {
    if sfctransition == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfctransition_stcode_set :: proc(sfctransition: SFCTransition, stcode: string) -> (ok: bool) {
    if sfctransition == nil do return
    if !com_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfctransition_release :: proc(sfctransition: SFCTransition) {
    if sfctransition != nil {
        (^SFCTransitionIF)(sfctransition)->Release()
    }
}
