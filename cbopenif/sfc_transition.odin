package cbopenif

SFCTransition :: distinct rawptr

SFCTransitionIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCTransitionVTable,
}

SFCTransitionVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^SFCTransitionIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^SFCTransitionIF, Name: BStr) -> HResult,
    DestGet:   proc "system" (this: ^SFCTransitionIF, Dest: ^BStr) -> HResult,
    DestPut:   proc "system" (this: ^SFCTransitionIF, Dest: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^SFCTransitionIF, STCode: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^SFCTransitionIF, STCode: BStr) -> HResult,
}

sfctransition_new :: proc(name: string, stcode := "", dest := "") -> (sfctransition: SFCTransition, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_stcode := to_bstr(stcode)
    bstr_dest := to_bstr(dest)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
        bstr_free(bstr_dest)
    }
    hr := factoryif->NewSFCTransition1(bstr_name, bstr_stcode, bstr_dest, cast(^rawptr)&sfctransition)
    if com_failed(hr) do return

    return sfctransition, true
}

sfctransition_name :: proc {
    sfctransition_name_get,
    sfctransition_name_set,
}

sfctransition_name_get :: proc(sfctransition: SFCTransition) -> (name: string, ok: bool) {
    if sfctransition == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfctransition_name_set :: proc(sfctransition: SFCTransition, name: string) -> (ok: bool) {
    if sfctransition == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfctransition_dest :: proc {
    sfctransition_dest_get,
    sfctransition_dest_set,
}

sfctransition_dest_get :: proc(sfctransition: SFCTransition) -> (dest: string, ok: bool) {
    if sfctransition == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfctransition_dest_set :: proc(sfctransition: SFCTransition, dest: string) -> (ok: bool) {
    if sfctransition == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(dest)
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->DestPut(bs)
    if com_failed(hr) do return

    return true
}

sfctransition_stcode :: proc {
    sfctransition_stcode_get,
    sfctransition_stcode_set,
}

sfctransition_stcode_get :: proc(sfctransition: SFCTransition) -> (stcode: string, ok: bool) {
    if sfctransition == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfctransition_stcode_set :: proc(sfctransition: SFCTransition, stcode: string) -> (ok: bool) {
    if sfctransition == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(stcode)
    defer bstr_free(bs)
    hr := (^SFCTransitionIF)(sfctransition)->STCodePut(bs)
    if com_failed(hr) do return

    return true
}

sfctransition_release :: proc(sfctransition: SFCTransition) {
    if sfctransition != nil {
        (^SFCTransitionIF)(sfctransition)->Release()
    }
}
