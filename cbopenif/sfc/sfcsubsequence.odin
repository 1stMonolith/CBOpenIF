package sfc

import "../com"
import "../controlbuilder"
import "../bstr"
import "../factory"

SFCSubSequenceIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCSubSequenceVTable,
}

SFCSubSequenceVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:     proc "system" (this: ^SFCSubSequenceIF, Name: ^BStr) -> HResult,
    NamePut:     proc "system" (this: ^SFCSubSequenceIF, Name: BStr) -> HResult,
    ElementsGet: proc "system" (this: ^SFCSubSequenceIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCSubSequenceIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCSubSequenceIF, SFCElements: rawptr) -> HResult,
}

sfcsubsequence_new :: proc(name: string) -> (sfcsubsequence: rawptr, ok: bool) {
    sfcsubsequence = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    defer bstr.free(bstr_name)
    hr := factory.factoryif->NewSFCSubSequence(bstr_name, cast(^rawptr)&sfcsubsequence)
    if com.failed(hr) do return

    return sfcsubsequence, true
}

sfcsubsequence_name :: proc {
    sfcsubsequence_name_get,
    sfcsubsequence_name_set,
}

sfcsubsequence_name_get :: proc(sfcsubsequence: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfcsubsequence == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfcsubsequence_name_set :: proc(sfcsubsequence: rawptr, name: string) -> (ok: bool) {
    ok = false

    if sfcsubsequence == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

sfcsubsequence_elements :: proc {
    sfcsubsequence_elements_get,
    sfcsubsequence_elements_set,
}

sfcsubsequence_elements_get :: proc(sfcsubsequence: rawptr) -> (sfcelements: rawptr, ok: bool) {
    sfcelements = nil
    ok = false

    if sfcsubsequence == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsGet(&sfcelements)
    if com.failed(hr) do return

    return sfcelements, true
}

sfcsubsequence_elements_set :: proc(sfcsubsequence: rawptr, sfcelements: rawptr) -> (ok: bool) {
    ok = false

    if sfcsubsequence == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsPut(sfcelements)
    if com.failed(hr) do return

    return true
}

sfcsubsequence_release :: proc(sfcsubsequence: rawptr) {
    if sfcsubsequence != nil {
        (^SFCSubSequenceIF)(sfcsubsequence)->Release()
    }
}
