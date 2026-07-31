package sfc

import "../com"
import "../controlbuilder"
import "../variant"

SFCElementType :: enum i32 {
    Step         = 0,
    Transition   = 1,
    SubSequence  = 2,
    Selection    = 3,
    Simultaneous = 4,
}

SFCPriority :: enum i32 {
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5,
}

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

sfcelement_is_step :: proc(sfcelement: rawptr) -> (is_step: bool, ok: bool) {
    is_step = false
    ok = false

    if sfcelement == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCStepGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_transition :: proc(sfcelement: rawptr) -> (is_transition: bool, ok: bool) {
    is_transition = false
    ok = false

    if sfcelement == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCTransitionGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_subsequence :: proc(sfcelement: rawptr) -> (is_subsequence: bool, ok: bool) {
    is_subsequence = false
    ok = false

    if sfcelement == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSubSequenceGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_selection :: proc(sfcelement: rawptr) -> (is_selection: bool, ok: bool) {
    is_selection = false
    ok = false

    if sfcelement == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSelectionGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_is_simultaneous :: proc(sfcelement: rawptr) -> (is_simultaneous: bool, ok: bool) {
    is_simultaneous = false
    ok = false

    if sfcelement == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSimultaneousGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcelement_release :: proc(sfcelement: rawptr) {
    if sfcelement != nil {
        (^SFCElementIF)(sfcelement)->Release()
    }
}
