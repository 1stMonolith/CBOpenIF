package sfc

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"

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

sfctransition_new :: proc(name: string, stcode := "", dest := "") -> (sfctransition: rawptr, ok: bool) {
    sfctransition = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    bstr_stcode := bstr.from_string(stcode)
    bstr_dest := bstr.from_string(dest)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_stcode)
        bstr.free(bstr_dest)
    }
    hr := factory.factoryif->NewSFCTransition1(bstr_name, bstr_stcode, bstr_dest, cast(^rawptr)&sfctransition)
    if com.failed(hr) do return

    return sfctransition, true
}

sfctransition_name :: proc {
    sfctransition_name_get,
    sfctransition_name_set,
}

sfctransition_name_get :: proc(sfctransition: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfctransition == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfctransition_name_set :: proc(sfctransition: rawptr, name: string) -> (ok: bool) {
    ok = false

    if sfctransition == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

sfctransition_dest :: proc {
    sfctransition_dest_get,
    sfctransition_dest_set,
}

sfctransition_dest_get :: proc(sfctransition: rawptr) -> (dest: string, ok: bool) {
    dest = ""
    ok = false

    if sfctransition == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfctransition_dest_set :: proc(sfctransition: rawptr, dest: string) -> (ok: bool) {
    ok = false

    if sfctransition == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(dest)
    defer bstr.free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestPut(bs)
    if com.failed(hr) do return

    return true
}

sfctransition_stcode :: proc {
    sfctransition_stcode_get,
    sfctransition_stcode_set,
}

sfctransition_stcode_get :: proc(sfctransition: rawptr) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if sfctransition == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodeGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfctransition_stcode_set :: proc(sfctransition: rawptr, stcode: string) -> (ok: bool) {
    ok = false

    if sfctransition == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(stcode)
    defer bstr.free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodePut(bs)
    if com.failed(hr) do return

    return true
}

sfctransition_release :: proc(sfctransition: rawptr) {
    if sfctransition != nil {
        (^SFCTransitionIF)(sfctransition)->Release()
    }
}
