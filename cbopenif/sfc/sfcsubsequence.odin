package sfc

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: bstr.BStr
@(private="file") HResult :: com.HResult

SFCSubSequence :: distinct rawptr

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

sfcsubsequence_new :: proc(name: string) -> (sfcsubsequence: SFCSubSequence, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return

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

sfcsubsequence_name_get :: proc(sfcsubsequence: SFCSubSequence) -> (name: string, ok: bool) {

    if sfcsubsequence == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfcsubsequence_name_set :: proc(sfcsubsequence: SFCSubSequence, name: string) -> (ok: bool) {

    if sfcsubsequence == nil do return
    if !controlbuilder.controlbuilder_connected() do return

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

sfcsubsequence_elements_get :: proc(sfcsubsequence: SFCSubSequence) -> (sfcelements: SFCElements, ok: bool) {

    if sfcsubsequence == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsGet(cast(^rawptr)&sfcelements)
    if com.failed(hr) do return

    return sfcelements, true
}

sfcsubsequence_elements_set :: proc(sfcsubsequence: SFCSubSequence, sfcelements: SFCElements) -> (ok: bool) {

    if sfcsubsequence == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsPut(sfcelements)
    if com.failed(hr) do return

    return true
}

sfcsubsequence_release :: proc(sfcsubsequence: SFCSubSequence) {
    if sfcsubsequence != nil {
        (^SFCSubSequenceIF)(sfcsubsequence)->Release()
    }
}
