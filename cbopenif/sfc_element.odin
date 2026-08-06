package cbopenif

SFCElementType :: enum i32 {
    Step         = 0,
    Transition   = 1,
    SubSequence  = 2,
    Selection    = 3,
    Simultaneous = 4,
}

SFCPriorityType :: enum i32 {
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5
}

SFCElement :: distinct rawptr

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
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCStepGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_transition :: proc(sfcelement: SFCElement) -> (is_transition: bool, ok: bool) {
    if sfcelement == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCTransitionGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_subsequence :: proc(sfcelement: SFCElement) -> (is_subsequence: bool, ok: bool) {
    if sfcelement == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSubSequenceGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_selection :: proc(sfcelement: SFCElement) -> (is_selection: bool, ok: bool) {
    if sfcelement == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCElementIF)(sfcelement)->IsSFCSelectionGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcelement_is_simultaneous :: proc(sfcelement: SFCElement) -> (is_simultaneous: bool, ok: bool) {
    if sfcelement == nil do return
    if !controlbuilder_connected() do return

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
