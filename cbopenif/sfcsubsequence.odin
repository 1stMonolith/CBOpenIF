package cbopenif

SFCSubSequence :: distinct rawptr

SFCSubSequenceIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^SFCSubSequenceVTable,
}

SFCSubSequenceVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    NameGet:     proc "system" (this: ^SFCSubSequenceIF, Name: ^BStr) -> HResult,
    NamePut:     proc "system" (this: ^SFCSubSequenceIF, Name: BStr) -> HResult,
    ElementsGet: proc "system" (this: ^SFCSubSequenceIF, SFCElements: ^SFCElements) -> HResult,
    Missing10:   proc "system" (this: ^SFCSubSequenceIF) -> HResult,
    ElementsPut: proc "system" (this: ^SFCSubSequenceIF, SFCElements: SFCElements) -> HResult,
}

sfcsubsequence_new :: proc(name: string) -> (sfcsubsequence: SFCSubSequence, ok: bool) {
    sfcsubsequence = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewSFCSubSequence(bstr_name, cast(^SFCSubSequence)&sfcsubsequence)
    if failed(hr) do return

    return sfcsubsequence, true
}

sfcsubsequence_name :: proc {
    sfcsubsequence_name_,
    sfcsubsequence_name_set,
}

@(private)
sfcsubsequence_name_ :: proc(sfcsubsequence: SFCSubSequence) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfcsubsequence == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfcsubsequence_name_set :: proc(sfcsubsequence: SFCSubSequence, name: string) -> (ok: bool) {
    ok = false

    if sfcsubsequence == nil do return
    if !connected() do return

    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^SFCSubSequenceIF)(sfcsubsequence)->NamePut(bstr)
    if failed(hr) do return

    return true
}

sfcsubsequence_elements :: proc {
    sfcsubsequence_elements_,
    sfcsubsequence_elements_set,
}

@(private)
sfcsubsequence_elements_ :: proc(sfcsubsequence: SFCSubSequence) -> (sfcelements: SFCElements, ok: bool) {
    sfcelements = nil
    ok = false

    if sfcsubsequence == nil do return
    if !connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsGet(&sfcelements)
    if failed(hr) do return

    return sfcelements, true
}

@(private)
sfcsubsequence_elements_set :: proc(sfcsubsequence: SFCSubSequence, sfcelements: SFCElements) -> (ok: bool) {
    ok = false

    if sfcsubsequence == nil do return
    if !connected() do return

    hr := (^SFCSubSequenceIF)(sfcsubsequence)->ElementsPut(sfcelements)
    if failed(hr) do return

    return true
}

sfcsubsequence_release :: proc(sfcsubsequence: SFCSubSequence) {
    if sfcsubsequence != nil {
        (^SFCSubSequenceIF)(sfcsubsequence)->Release()
    }
}