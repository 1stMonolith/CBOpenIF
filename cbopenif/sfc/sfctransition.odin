package sfc

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

SFCTransition :: distinct rawptr

SFCTransitionIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCTransitionVTable,
}

SFCTransitionVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:   proc "system" (this: ^SFCTransitionIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^SFCTransitionIF, Name: BStr) -> HResult,
    DestGet:   proc "system" (this: ^SFCTransitionIF, Dest: ^BStr) -> HResult,
    DestPut:   proc "system" (this: ^SFCTransitionIF, Dest: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^SFCTransitionIF, STCode: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^SFCTransitionIF, STCode: BStr) -> HResult,
}

sfctransition_new :: proc(name: string, stcode := "", dest := "") -> (sfctransition: SFCTransition, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return

    bstr_name := com.from_string(name)
    bstr_stcode := com.from_string(stcode)
    bstr_dest := com.from_string(dest)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_stcode)
        com.bstr_free(bstr_dest)
    }
    hr := factory.factoryif->NewSFCTransition1(bstr_name, bstr_stcode, bstr_dest, cast(^rawptr)&sfctransition)
    if com.failed(hr) do return

    return sfctransition, true
}

sfctransition_name :: proc {
    sfctransition_name_get,
    sfctransition_name_set,
}

sfctransition_name_get :: proc(sfctransition: SFCTransition) -> (name: string, ok: bool) {

    if sfctransition == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

sfctransition_name_set :: proc(sfctransition: SFCTransition, name: string) -> (ok: bool) {

    if sfctransition == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(name)
    defer com.bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

sfctransition_dest :: proc {
    sfctransition_dest_get,
    sfctransition_dest_set,
}

sfctransition_dest_get :: proc(sfctransition: SFCTransition) -> (dest: string, ok: bool) {

    if sfctransition == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

sfctransition_dest_set :: proc(sfctransition: SFCTransition, dest: string) -> (ok: bool) {

    if sfctransition == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(dest)
    defer com.bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestPut(bs)
    if com.failed(hr) do return

    return true
}

sfctransition_stcode :: proc {
    sfctransition_stcode_get,
    sfctransition_stcode_set,
}

sfctransition_stcode_get :: proc(sfctransition: SFCTransition) -> (stcode: string, ok: bool) {

    if sfctransition == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodeGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

sfctransition_stcode_set :: proc(sfctransition: SFCTransition, stcode: string) -> (ok: bool) {

    if sfctransition == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(stcode)
    defer com.bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodePut(bs)
    if com.failed(hr) do return

    return true
}

sfctransition_release :: proc(sfctransition: SFCTransition) {
    if sfctransition != nil {
        (^SFCTransitionIF)(sfctransition)->Release()
    }
}
