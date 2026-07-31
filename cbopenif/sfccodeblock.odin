package cbopenif

SFCCodeBlock :: distinct rawptr

SFCCodeBlockIF :: struct #raw_union {
    #subtype iunknown: IUnknowIF,
    using vtable: ^SFCCodeBlockVTable,
}

SFCCodeBlockVTable :: struct {
    using iunknown_vtable: IUnknowVTable,
    NameGet:            proc "system" (this: ^SFCCodeBlockIF, Name: ^BStr) -> HResult,
    NamePut:            proc "system" (this: ^SFCCodeBlockIF, Name: BStr) -> HResult,
    SeqControlGet:      proc "system" (this: ^SFCCodeBlockIF, SeqControl: ^VariantBool) -> HResult,
    SeqControlPut:      proc "system" (this: ^SFCCodeBlockIF, SeqControl: VariantBool) -> HResult,
    StepElapsedTimeGet: proc "system" (this: ^SFCCodeBlockIF, StepElapsedTime: ^VariantBool) -> HResult,
    StepElapsedTimePut: proc "system" (this: ^SFCCodeBlockIF, StepElapsedTime: VariantBool) -> HResult,
    SFCViewerAspectGet: proc "system" (this: ^SFCCodeBlockIF, SFCViewerAspect: ^VariantBool) -> HResult,
    SFCViewerAspectPut: proc "system" (this: ^SFCCodeBlockIF, SFCViewerAspect: VariantBool) -> HResult,
    SFCElementsGet:     proc "system" (this: ^SFCCodeBlockIF, SFCElements: ^SFCElements) -> HResult,
    Missing16:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    SFCElementsPut:     proc "system" (this: ^SFCCodeBlockIF, SFCElements: SFCElements) -> HResult,
    Missing18:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Missing19:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Missing20:          proc "system" (this: ^SFCCodeBlockIF) -> HResult,
    Serialize:          proc "system" (this: ^SFCCodeBlockIF, XMLStr: ^BStr) -> HResult,
}

sfccodeblock_new :: proc(name: string, seq_control := false, step_elapsed_time := false) -> (sfccodeblock: SFCCodeBlock, ok: bool) {
    sfccodeblock = nil
    ok = false

    if !connected() do return

    bstr_name := string_to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewSFCCodeBlock1(
        bstr_name,
        bool_to_variantbool(seq_control),
        bool_to_variantbool(step_elapsed_time),
        cast(^SFCCodeBlock)&sfccodeblock,
    )
    if failed(hr) do return

    return sfccodeblock, true
}

sfccodeblock_name :: proc {
    sfccodeblock_name_,
    sfccodeblock_name_set,
}

@(private)
sfccodeblock_name_ :: proc(sfccodeblock: SFCCodeBlock) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NameGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

@(private)
sfccodeblock_name_set :: proc(sfccodeblock: SFCCodeBlock, name: string) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NamePut(bstr)
    if failed(hr) do return

    return true
}

sfccodeblock_seq_control :: proc {
    sfccodeblock_seq_control_,
    sfccodeblock_seq_control_set,
}

@(private)
sfccodeblock_seq_control_ :: proc(sfccodeblock: SFCCodeBlock) -> (seq_control: bool, ok: bool) {
    seq_control = false
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

@(private)
sfccodeblock_seq_control_set :: proc(sfccodeblock: SFCCodeBlock, seq_control: bool) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlPut(bool_to_variantbool(seq_control))
    if failed(hr) do return

    return true
}

sfccodeblock_step_elapsed_time :: proc {
    sfccodeblock_step_elapsed_time_,
    sfccodeblock_step_elapsed_time_set,
}

@(private)
sfccodeblock_step_elapsed_time_ :: proc(sfccodeblock: SFCCodeBlock) -> (step_elapsed_time: bool, ok: bool) {
    step_elapsed_time = false
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimeGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

@(private)
sfccodeblock_step_elapsed_time_set :: proc(sfccodeblock: SFCCodeBlock, step_elapsed_time: bool) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimePut(bool_to_variantbool(step_elapsed_time))
    if failed(hr) do return

    return true
}

sfccodeblock_viewer_aspect :: proc {
    sfccodeblock_viewer_aspect_,
    sfccodeblock_viewer_aspect_set,
}

@(private)
sfccodeblock_viewer_aspect_ :: proc(sfccodeblock: SFCCodeBlock) -> (viewer_aspect: bool, ok: bool) {
    viewer_aspect = false
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectGet(&vb)
    if failed(hr) do return

    return variantbool_to_bool(vb), true
}

@(private)
sfccodeblock_viewer_aspect_set :: proc(sfccodeblock: SFCCodeBlock, viewer_aspect: bool) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectPut(bool_to_variantbool(viewer_aspect))
    if failed(hr) do return

    return true
}

sfccodeblock_elements :: proc {
    sfccodeblock_elements_,
    sfccodeblock_elements_set,
}

@(private)
sfccodeblock_elements_ :: proc(sfccodeblock: SFCCodeBlock) -> (elements: SFCElements, ok: bool) {
    elements = nil
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsGet(&elements)
    if failed(hr) do return

    return elements, true
}

@(private)
sfccodeblock_elements_set :: proc(sfccodeblock: SFCCodeBlock, elements: SFCElements) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsPut(elements)
    if failed(hr) do return

    return true
}

sfccodeblock_serialize :: proc(sfccodeblock: SFCCodeBlock) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if sfccodeblock == nil do return
    if !connected() do return

    bstr: BStr
    defer bstr_free(bstr)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->Serialize(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}

sfccodeblock_release :: proc(sfccodeblock: SFCCodeBlock) {
    if sfccodeblock != nil {
        (^SFCCodeBlockIF)(sfccodeblock)->Release()
    }
}