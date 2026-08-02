package sfc

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"
import "../variant"

@(private="file") BStr        :: bstr.BStr
@(private="file") HResult     :: com.HResult
@(private="file") VariantBool :: variant.VariantBool

SFCStep :: distinct rawptr

SFCStepIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCStepVTable,
}

SFCStepVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr_p1 := bstr.from_string(p1_action_stcode)
    bstr_n  := bstr.from_string(n_action_stcode)
    bstr_p0 := bstr.from_string(p0_action_stcode)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_p1)
        bstr.free(bstr_n)
        bstr.free(bstr_p0)
    }
    hr := factory.factoryif->NewSFCStep1(bstr_name, variant.bool_to_variantbool(initial_step), bstr_p1, bstr_n, bstr_p0, cast(^rawptr)&sfcstep)
    if com.failed(hr) do return

    return sfcstep, true
}

sfcstep_name :: proc {
    sfcstep_name_get,
    sfcstep_name_set,
}

sfcstep_name_get :: proc(sfcstep: SFCStep) -> (name: string, ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfcstep_name_set :: proc(sfcstep: SFCStep, name: string) -> (ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

sfcstep_initial_step :: proc {
    sfcstep_initial_step_get,
    sfcstep_initial_step_set,
}

sfcstep_initial_step_get :: proc(sfcstep: SFCStep) -> (initial_step: bool, ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCStepIF)(sfcstep)->InitialStepGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

sfcstep_initial_step_set :: proc(sfcstep: SFCStep, initial_step: bool) -> (ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCStepIF)(sfcstep)->InitialStepPut(variant.bool_to_variantbool(initial_step))
    if com.failed(hr) do return

    return true
}

sfcstep_p1_action_stcode :: proc {
    sfcstep_p1_action_stcode_get,
    sfcstep_p1_action_stcode_set,
}

sfcstep_p1_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfcstep_p1_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->P1ActionSTCodePut(bs)
    if com.failed(hr) do return

    return true
}

sfcstep_p0_action_stcode :: proc {
    sfcstep_p0_action_stcode_get,
    sfcstep_p0_action_stcode_set,
}

sfcstep_p0_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfcstep_p0_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->P0ActionSTCodePut(bs)
    if com.failed(hr) do return

    return true
}

sfcstep_n_action_stcode :: proc {
    sfcstep_n_action_stcode_get,
    sfcstep_n_action_stcode_set,
}

sfcstep_n_action_stcode_get :: proc(sfcstep: SFCStep) -> (stcode: string, ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfcstep_n_action_stcode_set :: proc(sfcstep: SFCStep, stcode: string) -> (ok: bool) {

    if sfcstep == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^SFCStepIF)(sfcstep)->NActionSTCodePut(bs)
    if com.failed(hr) do return

    return true
}

sfcstep_release :: proc(sfcstep: SFCStep) {
    if sfcstep != nil {
        (^SFCStepIF)(sfcstep)->Release()
    }
}
