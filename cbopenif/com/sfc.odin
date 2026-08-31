package com

SFCBranches     :: distinct rawptr
SFCBranch       :: distinct rawptr
SFCElements     :: distinct rawptr
SFCElement      :: distinct rawptr
SFCSelection    :: distinct rawptr
SFCSimultaneous :: distinct rawptr
SFCStep         :: distinct rawptr
SFCSubSequence  :: distinct rawptr
SFCTransition   :: distinct rawptr

SFCBranchesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCBranchesVTable,
}

SFCBranchesVTable :: struct
{
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

AddSFCBranch :: proc {
    _AddSFCBranch,
    _AddSFCBranchAtIndex,
}

_AddSFCBranch :: proc(sfcbranches: SFCBranches, sfcbranch: SFCBranch) -> (ok: bool)
{
    if sfcbranches == nil do return
    if sfcbranch == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Add(sfcbranch)
    if ComFailed(hr) do return

    return true
}

_AddSFCBranchAtIndex :: proc(sfcbranches: SFCBranches, sfcbranch: SFCBranch, index: i32) -> (ok: bool)
{
    if sfcbranches == nil do return
    if sfcbranch == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->AddBefore(sfcbranch, index)
    if ComFailed(hr) do return

    return true
}

GetSFCBranchAtIndex :: proc(sfcbranches: SFCBranches, index: i32) -> (sfcbranch: SFCBranch, ok: bool)
{
    if sfcbranches == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Item(index + 1, cast(^rawptr)&sfcbranch)
    if ComFailed(hr) do return

    return sfcbranch, true
}

SFCBranchCount :: proc(sfcbranches: SFCBranches) -> (count: i32, ok: bool)
{
    if sfcbranches == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveSFCBranch :: proc(sfcbranches: SFCBranches, index: i32) -> (ok: bool)
{
    if sfcbranches == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchesIF)(sfcbranches)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCBranches :: proc(sfcbranches: SFCBranches)
{
    if sfcbranches != nil {
        (^SFCBranchesIF)(sfcbranches)->Release()
    }
}

SFCBranchIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCBranchVTable,
}

SFCBranchVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    PriorityGet: proc "system" (this: ^SFCBranchIF, SFCPriority: ^i32) -> HResult,
    PriorityPut: proc "system" (this: ^SFCBranchIF, SFCPriority: i32) -> HResult,
    ElementsGet: proc "system" (this: ^SFCBranchIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCBranchIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCBranchIF, SFCElements: rawptr) -> HResult,
}

GetSFCBranchPriority :: proc(sfcbranch: SFCBranch) -> (priority: i32, ok: bool)
{
    if sfcbranch == nil do return
    if !ComConnected() do return

    p: i32
    hr := (^SFCBranchIF)(sfcbranch)->PriorityGet(&p)
    if ComFailed(hr) do return

    return priority, true
}

SetSFCBranchPriority :: proc(sfcbranch: SFCBranch, priority: i32) -> (ok: bool)
{
    if sfcbranch == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchIF)(sfcbranch)->PriorityPut(priority)
    if ComFailed(hr) do return

    return true
}

GetSFCBranchElements :: proc(sfcbranch: SFCBranch) -> (sfcelements: SFCElements, ok: bool)
{
    if sfcbranch == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsGet(cast(^rawptr)&sfcelements)
    if ComFailed(hr) do return

    return sfcelements, true
}

SetSFCBranchElements :: proc(sfcbranch: SFCBranch, sfcelements: SFCElements) -> (ok: bool)
{
    if sfcbranch == nil do return
    if !ComConnected() do return

    hr := (^SFCBranchIF)(sfcbranch)->ElementsPut(sfcelements)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCBranch :: proc(sfcbranch: SFCBranch)
{
    if sfcbranch != nil {
        (^SFCBranchIF)(sfcbranch)->Release()
    }
}

SFCElementsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCElementsVTable,
}

SFCElementsVTable :: struct
{
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

AddSFCStep :: proc(sfcelements: SFCElements, sfcstep: SFCStep) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfcstep == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddStep(sfcstep)
    if ComFailed(hr) do return

    return true
}

AddSFCTransition :: proc(sfcelements: SFCElements, sfctransition: SFCTransition) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfctransition == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddTransition(sfctransition)
    if ComFailed(hr) do return

    return true
}

AddSFCSelection :: proc(sfcelements: SFCElements, sfcselection: SFCSelection) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfcselection == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddSelection(sfcselection)
    if ComFailed(hr) do return

    return true
}

AddSFCSimultaeneous :: proc(sfcelements: SFCElements, sfcsimultaneous: SFCSimultaneous) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfcsimultaneous == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddSimultaneous(sfcsimultaneous)
    if ComFailed(hr) do return

    return true
}

AddSFCSubSequence :: proc(sfcelements: SFCElements, sfcsubsequence: SFCSubSequence) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfcsubsequence == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddSubSequence(sfcsubsequence)
    if ComFailed(hr) do return

    return true
}

AddSFCElement :: proc {
    _AddSFCElement,
    _AddSFCElementAtIndex,
}

_AddSFCElement :: proc(sfcelements: SFCElements, sfcelement: SFCElement) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfcelement == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->Add(sfcelement)
    if ComFailed(hr) do return

    return true
}


_AddSFCElementAtIndex :: proc(sfcelements: SFCElements, sfcelement: SFCElement, index: i32) -> (ok: bool)
{
    if sfcelements == nil do return
    if sfcelement == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->AddBefore(sfcelement, index)
    if ComFailed(hr) do return

    return true
}

GetSFCElementAtIndex :: proc(sfcelements: SFCElements, index: i32) -> (sfcelement: SFCElement, ok: bool)
{
    if sfcelements == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->Item(index + 1, cast(^rawptr)&sfcelement)
    if ComFailed(hr) do return

    return sfcelement, true
}

SFCElementCount :: proc(sfcelements: SFCElements) -> (count: i32, ok: bool)
{
    if sfcelements == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveSFCElement :: proc(sfcelements: SFCElements, index: i32) -> (ok: bool)
{
    if sfcelements == nil do return
    if !ComConnected() do return

    hr := (^SFCElementsIF)(sfcelements)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCElements :: proc(sfcelements: SFCElements)
{
    if sfcelements != nil {
        (^SFCElementsIF)(sfcelements)->Release()
    }
}

SFCElementIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCElementVTable,
}

SFCElementVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    IsSFCStepGet:         proc "system" (this: ^SFCElementIF, IsSFCStep: ^VariantBool) -> HResult,
    IsSFCTransitionGet:   proc "system" (this: ^SFCElementIF, IsSFCTransition: ^VariantBool) -> HResult,
    IsSFCSubSequenceGet:  proc "system" (this: ^SFCElementIF, IsSFCSubSequence: ^VariantBool) -> HResult,
    IsSFCSelectionGet:    proc "system" (this: ^SFCElementIF, IsSFCSelection: ^VariantBool) -> HResult,
    IsSFCSimultaneousGet: proc "system" (this: ^SFCElementIF, IsSFCSimultaneous: ^VariantBool) -> HResult,
}

IsStepSFCElement :: proc(sfcelement: SFCElement) -> (is_step: bool, ok: bool)
{
    if sfcelement == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCStepGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

IsTransitionSFCElement :: proc(sfcelement: SFCElement) -> (is_transition: bool, ok: bool)
{
    if sfcelement == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCTransitionGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

IsSubsequenceSFCElement :: proc(sfcelement: SFCElement) -> (is_subsequence: bool, ok: bool)
{
    if sfcelement == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSubSequenceGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

IsSelectionSFCElement :: proc(sfcelement: SFCElement) -> (is_selection: bool, ok: bool)
{
    if sfcelement == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSelectionGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

IsSimultaneousSFCElement :: proc(sfcelement: SFCElement) -> (is_simultaneous: bool, ok: bool)
{
    if sfcelement == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSimultaneousGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

ReleaseSFCElement :: proc(sfcelement: SFCElement)
{
    if sfcelement != nil {
        (^SFCElementIF)(sfcelement)->Release()
    }
}

SFCSelectionIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSelectionVTable,
}

SFCSelectionVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSelectionIF, SFCBranches: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^SFCSelectionIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSelectionIF, SFCBranches: rawptr) -> HResult,
}

GetSFCSelectionBranches :: proc(sfcselection: SFCSelection) -> (sfcbranches: SFCBranches, ok: bool)
{
    if sfcselection == nil do return
    if !ComConnected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if ComFailed(hr) do return

    return sfcbranches, true
}

SetSFCSelectionBranches :: proc(sfcselection: SFCSelection, sfcbranches: SFCBranches) -> (ok: bool)
{
    if sfcselection == nil do return
    if !ComConnected() do return

    hr := (^SFCSelectionIF)(sfcselection)->SFCBranchesPut(sfcbranches)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCSelection :: proc(sfcselection: SFCSelection)
{
    if sfcselection != nil {
        (^SFCSelectionIF)(sfcselection)->Release()
    }
}

SFCSimultaneousIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSimultaneousVTable,
}

SFCSimultaneousVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    SFCBranchesGet: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^SFCSimultaneousIF) -> HResult,
    SFCBranchesPut: proc "system" (this: ^SFCSimultaneousIF, SFCBranches: rawptr) -> HResult,
}

GetSFCSimultaneousBranches :: proc(sfcsimultaneous: SFCSimultaneous) -> (sfcbranches: SFCBranches, ok: bool)
{
    if sfcsimultaneous == nil do return
    if !ComConnected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesGet(cast(^rawptr)&sfcbranches)
    if ComFailed(hr) do return

    return sfcbranches, true
}

SetSFCSimultaneousBranches :: proc(sfcsimultaneous: SFCSimultaneous, sfcbranches: SFCBranches) -> (ok: bool)
{
    if sfcsimultaneous == nil do return
    if !ComConnected() do return

    hr := (^SFCSimultaneousIF)(sfcsimultaneous)->SFCBranchesPut(sfcbranches)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCSimultaneous :: proc(sfcsimultaneous: SFCSimultaneous)
{
    if sfcsimultaneous != nil {
        (^SFCSimultaneousIF)(sfcsimultaneous)->Release()
    }
}

SFCStepIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCStepVTable,
}

SFCStepVTable :: struct
{
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

GetSFCStepName :: proc(sfcstep: SFCStep) -> (name: string, ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCStepName :: proc(sfcstep: SFCStep, name: string) -> (ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCStepInitialStep :: proc(sfcstep: SFCStep) -> (initial_step: bool, ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^SFCStepIF)(sfcstep)->InitialStepGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetSFCStepInitialStep :: proc(sfcstep: SFCStep, initial_step: bool) -> (ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    hr := (^SFCStepIF)(sfcstep)->InitialStepPut(ToVariantBool(initial_step))
    if ComFailed(hr) do return

    return true
}

GetSFCStepP1ActionStCode :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCStepP1ActionStCode :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCStepP0ActionStCode :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCStepP0ActionStCode :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCStepNActionStCode :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCStepNActionStCode :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool)
{
    if sfcstep == nil do return
    if !ComConnected() do return

    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCStep :: proc(sfcstep: SFCStep)
{
    if sfcstep != nil {
        (^SFCStepIF)(sfcstep)->Release()
    }
}

SFCSubSequenceIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSubSequenceVTable,
}

SFCSubSequenceVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:     proc "system" (this: ^SFCSubSequenceIF, Name: ^BStr) -> HResult,
    NamePut:     proc "system" (this: ^SFCSubSequenceIF, Name: BStr) -> HResult,
    ElementsGet: proc "system" (this: ^SFCSubSequenceIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCSubSequenceIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCSubSequenceIF, SFCElements: rawptr) -> HResult,
}

GetSFCSubsequenceName :: proc(sfcsubsequence: SFCSubSequence) -> (name: string, ok: bool)
{
    if sfcsubsequence == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCSubsequenceName :: proc(sfcsubsequence: SFCSubSequence, name: string) -> (ok: bool)
{
    if sfcsubsequence == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCSubsequenceElements :: proc(sfcsubsequence: SFCSubSequence) -> (sfcelements: SFCElements, ok: bool)
{
    if sfcsubsequence == nil do return
    if !ComConnected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsGet(cast(^rawptr)&sfcelements)
    if ComFailed(hr) do return

    return sfcelements, true
}

SetSFCSubsequenceElements :: proc(sfcsubsequence: SFCSubSequence, sfcelements: SFCElements) -> (ok: bool)
{
    if sfcsubsequence == nil do return
    if !ComConnected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsPut(sfcelements)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCSubsequence :: proc(sfcsubsequence: SFCSubSequence)
{
    if sfcsubsequence != nil {
        (^SFCSubSequenceIF)(sfcsubsequence)->Release()
    }
}

SFCTransitionIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCTransitionVTable,
}

SFCTransitionVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^SFCTransitionIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^SFCTransitionIF, Name: BStr) -> HResult,
    DestGet:   proc "system" (this: ^SFCTransitionIF, Dest: ^BStr) -> HResult,
    DestPut:   proc "system" (this: ^SFCTransitionIF, Dest: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^SFCTransitionIF, STCode: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^SFCTransitionIF, STCode: BStr) -> HResult,
}

GetSFCTransitionName :: proc(sfctransition: SFCTransition) -> (name: string, ok: bool)
{
    if sfctransition == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCTransitionName :: proc(sfctransition: SFCTransition, name: string) -> (ok: bool)
{
    if sfctransition == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCTransitionDest :: proc(sfctransition: SFCTransition) -> (dest: string, ok: bool)
{
    if sfctransition == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCTransitionDest :: proc(sfctransition: SFCTransition, dest: string) -> (ok: bool)
{
    if sfctransition == nil do return
    if !ComConnected() do return

    bs := ToBstr(dest)
    defer FreeBstr(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestPut(bs)
    if ComFailed(hr) do return

    return true
}

GetSFCTransitionSTCode :: proc(sfctransition: SFCTransition) -> (stcode: string, ok: bool)
{
    if sfctransition == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSFCTransitionSTCode :: proc(sfctransition: SFCTransition, stcode: string) -> (ok: bool)
{
    if sfctransition == nil do return
    if !ComConnected() do return

    bs := ToBstr(stcode)
    defer FreeBstr(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseSFCTransition :: proc(sfctransition: SFCTransition)
{
    if sfctransition != nil {
        (^SFCTransitionIF)(sfctransition)->Release()
    }
}
