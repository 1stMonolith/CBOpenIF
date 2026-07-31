package cbopenif

ISFCElement :: distinct rawptr

ISFCElementIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^ISFCElementVTable,
}

ISFCElementVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    IsSFCStepGet:         proc "system" (this: ^ISFCElementIF, IsSFCStep: ^VariantBool) -> HResult,
    IsSFCTransitionGet:   proc "system" (this: ^ISFCElementIF, IsSFCTransition: ^VariantBool) -> HResult,
    IsSFCSubSequenceGet:  proc "system" (this: ^ISFCElementIF, IsSFCSubSequence: ^VariantBool) -> HResult,
    IsSFCSelectionGet:    proc "system" (this: ^ISFCElementIF, IsSFCSelection: ^VariantBool) -> HResult,
    IsSFCSimultaneousGet: proc "system" (this: ^ISFCElementIF, IsSFCSimultaneous: ^VariantBool) -> HResult,
}

isfcelement_is_step :: proc(isfcelement: ISFCElement) -> (is_step: bool, ok: bool) {
    is_step = false
    ok = false

    if isfcelement == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^ISFCElementIF)(isfcelement)->IsSFCStepGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

isfcelement_is_transition :: proc(isfcelement: ISFCElement) -> (is_transition: bool, ok: bool) {
    is_transition = false
    ok = false

    if isfcelement == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^ISFCElementIF)(isfcelement)->IsSFCTransitionGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

isfcelement_is_subsequence :: proc(isfcelement: ISFCElement) -> (is_subsequence: bool, ok: bool) {
    is_subsequence = false
    ok = false

    if isfcelement == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^ISFCElementIF)(isfcelement)->IsSFCSubSequenceGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

isfcelement_is_selection :: proc(isfcelement: ISFCElement) -> (is_selection: bool, ok: bool) {
    is_selection = false
    ok = false

    if isfcelement == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^ISFCElementIF)(isfcelement)->IsSFCSelectionGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

isfcelement_is_simultaneous :: proc(isfcelement: ISFCElement) -> (is_simultaneous: bool, ok: bool) {
    is_simultaneous = false
    ok = false

    if isfcelement == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^ISFCElementIF)(isfcelement)->IsSFCSimultaneousGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

isfcelement_release :: proc(isfcelement: ISFCElement) {
    if isfcelement != nil {
        (^ISFCElementIF)(isfcelement)->Release()
    }
}