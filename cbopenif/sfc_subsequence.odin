package cbopenif

SFCSubSequence :: distinct rawptr

SFCSubSequenceIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCSubSequenceVTable,
}

SFCSubSequenceVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:     proc "system" (this: ^SFCSubSequenceIF, Name: ^BStr) -> HResult,
    NamePut:     proc "system" (this: ^SFCSubSequenceIF, Name: BStr) -> HResult,
    ElementsGet: proc "system" (this: ^SFCSubSequenceIF, SFCElements: ^rawptr) -> HResult,
    Missing10:   proc "system" (this: ^SFCSubSequenceIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCSubSequenceIF, SFCElements: rawptr) -> HResult,
}

sfcsubsequence_new :: proc(name: string) -> (sfcsubsequence: SFCSubSequence, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewSFCSubSequence(bstr_name, cast(^rawptr)&sfcsubsequence)
    if com_failed(hr) do return

    return sfcsubsequence, true
}

sfcsubsequence_name :: proc {
    sfcsubsequence_name_get,
    sfcsubsequence_name_set,
}

sfcsubsequence_name_get :: proc(sfcsubsequence: SFCSubSequence) -> (name: string, ok: bool) {
    if sfcsubsequence == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfcsubsequence_name_set :: proc(sfcsubsequence: SFCSubSequence, name: string) -> (ok: bool) {
    if sfcsubsequence == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfcsubsequence_elements :: proc {
    sfcsubsequence_elements_get,
    sfcsubsequence_elements_set,
}

sfcsubsequence_elements_get :: proc(sfcsubsequence: SFCSubSequence) -> (sfcelements: SFCElements, ok: bool) {
    if sfcsubsequence == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsGet(cast(^rawptr)&sfcelements)
    if com_failed(hr) do return

    return sfcelements, true
}

sfcsubsequence_elements_set :: proc(sfcsubsequence: SFCSubSequence, sfcelements: SFCElements) -> (ok: bool) {
    if sfcsubsequence == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsPut(sfcelements)
    if com_failed(hr) do return

    return true
}

sfcsubsequence_release :: proc(sfcsubsequence: SFCSubSequence) {
    if sfcsubsequence != nil {
        (^SFCSubSequenceIF)(sfcsubsequence)->Release()
    }
}
