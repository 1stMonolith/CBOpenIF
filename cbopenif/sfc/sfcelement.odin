package sfc

import "../com"
import "../controlbuilder"
import "../variant"

@(private="file") HResult     :: com.HResult
@(private="file") VariantBool :: variant.VariantBool

SFCElement :: distinct rawptr

SFCElementIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCElementVTable,
}

SFCElementVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    IsSFCStepGet:         proc "system" (this: ^SFCElementIF, IsSFCStep: ^VariantBool) -> HResult,
    IsSFCTransitionGet:   proc "system" (this: ^SFCElementIF, IsSFCTransition: ^VariantBool) -> HResult,
    IsSFCSubSequenceGet:  proc "system" (this: ^SFCElementIF, IsSFCSubSequence: ^VariantBool) -> HResult,
    IsSFCSelectionGet:    proc "system" (this: ^SFCElementIF, IsSFCSelection: ^VariantBool) -> HResult,
    IsSFCSimultaneousGet: proc "system" (this: ^SFCElementIF, IsSFCSimultaneous: ^VariantBool) -> HResult,
}

sfcelement_is_step :: proc(sfcelement: SFCElement) -> (is_step: bool, ok: bool) {

    if sfcelement == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCStepGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_transition :: proc(sfcelement: SFCElement) -> (is_transition: bool, ok: bool) {

    if sfcelement == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCTransitionGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_subsequence :: proc(sfcelement: SFCElement) -> (is_subsequence: bool, ok: bool) {

    if sfcelement == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSubSequenceGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_selection :: proc(sfcelement: SFCElement) -> (is_selection: bool, ok: bool) {

    if sfcelement == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSelectionGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_simultaneous :: proc(sfcelement: SFCElement) -> (is_simultaneous: bool, ok: bool) {

    if sfcelement == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSimultaneousGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_release :: proc(sfcelement: SFCElement) {
    if sfcelement != nil {
        (^SFCElementIF)(sfcelement)->Release()
    }
}
