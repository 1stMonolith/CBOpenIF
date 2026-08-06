package cbopenif

SFCCodeBlock :: distinct rawptr

SFCCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SFCCodeBlockVTable,
}

SFCCodeBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:            proc "system" (this: ^SFCCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:            proc "system" (this: ^SFCCodeBlockIF, Name: BStr) -> HResult,
    SeqControlGet:      proc "system" (this: ^SFCCodeBlockIF, SeqControl: ^VariantBool) -> HResult,
    SeqControlPut:      proc "system" (this: ^SFCCodeBlockIF, SeqControl: VariantBool) -> HResult,
    StepElapsedTimeGet: proc "system" (this: ^SFCCodeBlockIF, StepElapsedTime: ^VariantBool) -> HResult,
    StepElapsedTimePut: proc "system" (this: ^SFCCodeBlockIF, StepElapsedTime: VariantBool) -> HResult,
    SFCViewerAspectGet: proc "system" (this: ^SFCCodeBlockIF, SFCViewerAspect: ^VariantBool) -> HResult,
    SFCViewerAspectPut: proc "system" (this: ^SFCCodeBlockIF, SFCViewerAspect: VariantBool) -> HResult,
    SFCElementsGet:     proc "system" (this: ^SFCCodeBlockIF, SFCElements: ^rawptr) -> HResult,
    Missing16:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    SFCElementsPut:     proc "system" (this: ^SFCCodeBlockIF, SFCElements: rawptr) -> HResult,
    Missing18:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Missing19:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Missing20:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Serialize:          proc "system" (this: ^SFCCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

sfccodeblock_new :: proc(name: string, seq_control := false, step_elapsed_time := false) -> (sfccodeblock: SFCCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewSFCCodeBlock1(
        bstr_name,
        to_variantbool(seq_control),
        to_variantbool(step_elapsed_time),
        cast(^rawptr)&sfccodeblock,
    )
    if com_failed(hr) do return

    return sfccodeblock, true
}

sfccodeblock_name :: proc {
    sfccodeblock_name_get,
    sfccodeblock_name_set,
}

sfccodeblock_name_get :: proc(sfccodeblock: SFCCodeBlock) -> (name: string, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfccodeblock_name_set :: proc(sfccodeblock: SFCCodeBlock, name: string) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

sfccodeblock_seq_control :: proc {
    sfccodeblock_seq_control_get,
    sfccodeblock_seq_control_set,
}

sfccodeblock_seq_control_get :: proc(sfccodeblock: SFCCodeBlock) -> (seq_control: bool, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfccodeblock_seq_control_set :: proc(sfccodeblock: SFCCodeBlock, seq_control: bool) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlPut(to_variantbool(seq_control))
    if com_failed(hr) do return

    return true
}

sfccodeblock_step_elapsed_time :: proc {
    sfccodeblock_step_elapsed_time_get,
    sfccodeblock_step_elapsed_time_set,
}

sfccodeblock_step_elapsed_time_get :: proc(sfccodeblock: SFCCodeBlock) -> (step_elapsed_time: bool, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimeGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfccodeblock_step_elapsed_time_set :: proc(sfccodeblock: SFCCodeBlock, step_elapsed_time: bool) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimePut(to_variantbool(step_elapsed_time))
    if com_failed(hr) do return

    return true
}

sfccodeblock_viewer_aspect :: proc {
    sfccodeblock_viewer_aspect_get,
    sfccodeblock_viewer_aspect_set,
}

sfccodeblock_viewer_aspect_get :: proc(sfccodeblock: SFCCodeBlock) -> (viewer_aspect: bool, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

sfccodeblock_viewer_aspect_set :: proc(sfccodeblock: SFCCodeBlock, viewer_aspect: bool) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectPut(to_variantbool(viewer_aspect))
    if com_failed(hr) do return

    return true
}

sfccodeblock_elements :: proc {
    sfccodeblock_elements_get,
    sfccodeblock_elements_set,
}

sfccodeblock_elements_get :: proc(sfccodeblock: SFCCodeBlock) -> (sfcelements: SFCElements, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsGet(cast(^rawptr)&sfcelements)
    if com_failed(hr) do return

    return sfcelements, true
}

sfccodeblock_elements_set :: proc(sfccodeblock: SFCCodeBlock, sfcelements: SFCElements) -> (ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsPut(sfcelements)
    if com_failed(hr) do return

    return true
}

sfccodeblock_serialize :: proc(sfccodeblock: SFCCodeBlock) -> (xml: string, ok: bool) {
    if sfccodeblock == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

sfccodeblock_release :: proc(sfccodeblock: SFCCodeBlock) {
    if sfccodeblock != nil {
        (^SFCCodeBlockIF)(sfccodeblock)->Release()
    }
}
