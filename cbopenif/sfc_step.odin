package cbopenif

SFCStep :: distinct rawptr

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

sfcstep_new :: proc(name: string, initial_step: bool, p1_action_stcode := "", n_action_stcode := "", p0_action_stcode := "") -> (sfcstep: SFCStep, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_p1 := to_bstr(p1_action_stcode)
    bstr_n  := to_bstr(n_action_stcode)
    bstr_p0 := to_bstr(p0_action_stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_p1)
        bstr_free(bstr_n)
        bstr_free(bstr_p0)
    }
    hr := factoryif->NewSFCStep1(bstr_name, to_variantbool(initial_step), bstr_p1, bstr_n, bstr_p0, cast(^rawptr)&sfcstep)
    if com_failed(hr) do return

    return sfcstep, true
}

sfcstep_name :: proc {
    sfcstep_name_get,
    sfcstep_name_set,
}

sfcstep_name_get :: proc(sfcstep: SFCStep) -> (name: string, ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_name_set :: proc(sfcstep: SFCStep, name: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_initial_step :: proc {
    sfcstep_initial_step_get,
    sfcstep_initial_step_set,
}

sfcstep_initial_step_get :: proc(sfcstep: SFCStep) -> (initial_step: bool, ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCStepIF)(sfcstep)->InitialStepGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfcstep_initial_step_set :: proc(sfcstep: SFCStep, initial_step: bool) -> (ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCStepIF)(sfcstep)->InitialStepPut(to_variantbool(initial_step))
    if com_failed(hr) do return

    return true
}

sfcstep_p1_action_stcode :: proc {
    sfcstep_p1_action_stcode_get,
    sfcstep_p1_action_stcode_set,
}

sfcstep_p1_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_p1_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_p0_action_stcode :: proc {
    sfcstep_p0_action_stcode_get,
    sfcstep_p0_action_stcode_set,
}

sfcstep_p0_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_p0_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfcstep_n_action_stcode :: proc {
    sfcstep_n_action_stcode_get,
    sfcstep_n_action_stcode_set,
}

sfcstep_n_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcstep_n_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    if sfcstep == nil do return
    if !controlbuilder_connected() do return

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
