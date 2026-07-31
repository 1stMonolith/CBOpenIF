package cbopenif

SFCTransition :: distinct rawptr

SFCTransitionIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^SFCTransitionVTable,
}

SFCTransitionVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^SFCTransitionIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^SFCTransitionIF, Name: BStr) -> HResult,
    DestGet:   proc "system" (this: ^SFCTransitionIF, Dest: ^BStr) -> HResult,
    DestPut:   proc "system" (this: ^SFCTransitionIF, Dest: BStr) -> HResult,
    STCodeGet: proc "system" (this: ^SFCTransitionIF, STCode: ^BStr) -> HResult,
    STCodePut: proc "system" (this: ^SFCTransitionIF, STCode: BStr) -> HResult,
}

sfctransition_new :: proc(name: string, stcode := "", dest := "") -> (sfctransition: SFCTransition, ok: bool) {
    sfctransition = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    bstr_stcode := string_to_bstr(stcode)
    bstr_dest := string_to_bstr(dest)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_stcode)
        bstr_free(bstr_dest)
    }
    hr := factoryif->NewSFCTransition1(bstr_name, bstr_stcode, bstr_dest, cast(^SFCTransition)&sfctransition)
    if failed(hr) do return

    return sfctransition, true
}

sfctransition_name :: proc {
    sfctransition_name_,
    sfctransition_name_set,
}

@(private)
sfctransition_name_ :: proc(sfctransition: SFCTransition) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfctransition == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCTransitionIF)(sfctransition)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfctransition_name_set :: proc(sfctransition: SFCTransition, name: string) -> (ok: bool) {
    ok = false

    if sfctransition == nil do return
    if !connected() do return

    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^SFCTransitionIF)(sfctransition)->NamePut(bstr)
    if failed(hr) do return

    return true
}

sfctransition_dest :: proc {
    sfctransition_dest_,
    sfctransition_dest_set,
}

@(private)
sfctransition_dest_ :: proc(sfctransition: SFCTransition) -> (dest: string, ok: bool) {
    dest = ""
    ok = false

    if sfctransition == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCTransitionIF)(sfctransition)->DestGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfctransition_dest_set :: proc(sfctransition: SFCTransition, dest: string) -> (ok: bool) {
    ok = false

    if sfctransition == nil do return
    if !connected() do return

    bstr := string_to_bstr(dest)
    defer bstr_free(bstr)
    hr := (^SFCTransitionIF)(sfctransition)->DestPut(bstr)
    if failed(hr) do return

    return true
}

sfcstcode :: proc {
    sfcstcode_,
    sfcstcode_set,
}

@(private)
sfcstcode_ :: proc(sfctransition: SFCTransition) -> (stcode: string, ok: bool) {
    stcode = ""
    ok = false

    if sfctransition == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCTransitionIF)(sfctransition)->STCodeGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfcstcode_set :: proc(sfctransition: SFCTransition, stcode: string) -> (ok: bool) {
    ok = false

    if sfctransition == nil do return
    if !connected() do return

    bstr := string_to_bstr(stcode)
    defer bstr_free(bstr)
    hr := (^SFCTransitionIF)(sfctransition)->STCodePut(bstr)
    if failed(hr) do return

    return true
}

sfctransition_release :: proc(sfctransition: SFCTransition) {
    if sfctransition != nil {
        (^SFCTransitionIF)(sfctransition)->Release()
    }
}