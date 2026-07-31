package sfc

SFCStep :: distinct rawptr

SFCStepIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^SFCStepVTable,
}

SFCStepVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
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
    sfcstep = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_p1 := string_to_bstr(p1_action_stcode)
    bstr_n  := string_to_bstr(n_action_stcode)
    bstr_p0 := string_to_bstr(p0_action_stcode)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_p1)
        bstr_free(bstr_n)
        bstr_free(bstr_p0)
    }
    hr := factoryif->NewSFCStep1(bstr_name, bool_to_variantbool(initial_step), bstr_p1, bstr_n, bstr_p0, cast(^SFCStep)&sfcstep)
    if failed(hr) do return

    return sfcstep, true
}

sfcstep_name :: proc {
    sfcstep_name_,
    sfcstep_name_set,
}

@(private)
sfcstep_name_ :: proc(sfcstep: SFCStep) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfcstep_name_set :: proc(sfcstep: SFCStep, name: string) -> (ok: bool) {
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->NamePut(bstr)
    if failed(hr) do return

    return true
}

sfcstep_initial_step :: proc {
    sfcstep_initial_step_,
    sfcstep_initial_step_set,
}

@(private)
sfcstep_initial_step_ :: proc(sfcstep: SFCStep) -> (initial_step: bool, ok: bool) {
    initial_step = false
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^SFCStepIF)(sfcstep)->InitialStepGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

@(private)
sfcstep_initial_step_set :: proc(sfcstep: SFCStep, initial_step: bool) -> (ok: bool) {
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    hr := (^SFCStepIF)(sfcstep)->InitialStepPut(bool_to_variantbool(initial_step))
    if failed(hr) do return

    return true
}

sfcstep_p1_action_stcode :: proc {
    sfcstep_p1_action_stcode_,
    sfcstep_p1_action_stcode_set,
}

@(private)
sfcstep_p1_action_stcode_ :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfcstep_p1_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodePut(bstr)
    if failed(hr) do return

    return true
}

sfcstep_p0_action_stcode :: proc {
    sfcstep_p0_action_stcode_,
    sfcstep_p0_action_stcode_set,
}

@(private)
sfcstep_p0_action_stcode_ :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfcstep_p0_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodePut(bstr)
    if failed(hr) do return

    return true
}

sfcstep_n_action_stcode :: proc {
    sfcstep_n_action_stcode_,
    sfcstep_n_action_stcode_set,
}

@(private)
sfcstep_n_action_stcode_ :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfcstep_n_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {
    ok = false

    if sfcstep == nil do return
    if !connected() do return

    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodePut(bstr)
    if failed(hr) do return

    return true
}

sfcstep_release :: proc(sfcstep: SFCStep) {
    if sfcstep != nil {
        (^SFCStepIF)(sfcstep)->Release()
    }
}