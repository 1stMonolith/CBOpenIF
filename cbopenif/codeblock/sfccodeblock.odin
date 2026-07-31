package codeblock

import "../com"
import "../controlbuilder"
import "../bstr"

SFCCodeBlockIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^SFCCodeBlockVTable,
}

SFCCodeBlockVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

sfccodeblock_new :: proc(name: string, seq_control := false, step_elapsed_time := false) -> (sfccodeblock: rawptr, ok: bool) {
    sfccodeblock = nil
    ok = false

    if !controlbuilder.connected() do return

    bstr_name := bstr.from_string(name)
    defer bstr.free(bstr_name)
    hr := factoryif->NewSFCCodeBlock1(
        bstr_name,
        variant.bool_to_variantbool(seq_control),
        variant.bool_to_variantbool(step_elapsed_time),
        cast(^rawptr)&sfccodeblock,
    )
    if com.failed(hr) do return

    return sfccodeblock, true
}

sfccodeblock_name :: proc {
    sfccodeblock_name_,
    sfccodeblock_name_set,
}

@(private)
sfccodeblock_name_ :: proc(sfccodeblock: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NameGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

@(private)
sfccodeblock_name_set :: proc(sfccodeblock: rawptr, name: string) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->NamePut(bs)
    if com.failed(hr) do return

    return true
}

sfccodeblock_seq_control :: proc {
    sfccodeblock_seq_control_,
    sfccodeblock_seq_control_set,
}

@(private)
sfccodeblock_seq_control_ :: proc(sfccodeblock: rawptr) -> (seq_control: bool, ok: bool) {
    seq_control = false
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

@(private)
sfccodeblock_seq_control_set :: proc(sfccodeblock: rawptr, seq_control: bool) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SeqControlPut(variant.bool_to_variantbool(seq_control))
    if com.failed(hr) do return

    return true
}

sfccodeblock_step_elapsed_time :: proc {
    sfccodeblock_step_elapsed_time_,
    sfccodeblock_step_elapsed_time_set,
}

@(private)
sfccodeblock_step_elapsed_time_ :: proc(sfccodeblock: rawptr) -> (step_elapsed_time: bool, ok: bool) {
    step_elapsed_time = false
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimeGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

@(private)
sfccodeblock_step_elapsed_time_set :: proc(sfccodeblock: rawptr, step_elapsed_time: bool) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->StepElapsedTimePut(variant.bool_to_variantbool(step_elapsed_time))
    if com.failed(hr) do return

    return true
}

sfccodeblock_viewer_aspect :: proc {
    sfccodeblock_viewer_aspect_,
    sfccodeblock_viewer_aspect_set,
}

@(private)
sfccodeblock_viewer_aspect_ :: proc(sfccodeblock: rawptr) -> (viewer_aspect: bool, ok: bool) {
    viewer_aspect = false
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    vb: VariantBool
    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectGet(&vb)
    if com.failed(hr) do return

    return variant.variantbool_to_bool(vb), true
}

@(private)
sfccodeblock_viewer_aspect_set :: proc(sfccodeblock: rawptr, viewer_aspect: bool) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCViewerAspectPut(variant.bool_to_variantbool(viewer_aspect))
    if com.failed(hr) do return

    return true
}

sfccodeblock_elements :: proc {
    sfccodeblock_elements_,
    sfccodeblock_elements_set,
}

@(private)
sfccodeblock_elements_ :: proc(sfccodeblock: rawptr) -> (elements: rawptr, ok: bool) {
    elements = nil
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsGet(&elements)
    if com.failed(hr) do return

    return elements, true
}

@(private)
sfccodeblock_elements_set :: proc(sfccodeblock: rawptr, elements: rawptr) -> (ok: bool) {
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    hr := (^SFCCodeBlockIF)(sfccodeblock)->SFCElementsPut(elements)
    if com.failed(hr) do return

    return true
}

sfccodeblock_serialize :: proc(sfccodeblock: rawptr) -> (xml: string, ok: bool) {
    xml = ""
    ok = false

    if sfccodeblock == nil do return
    if !controlbuilder.connected() do return

    bs: BStr
    defer bstr.free(bs)
    hr := (^SFCCodeBlockIF)(sfccodeblock)->Serialize(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

sfccodeblock_release :: proc(sfccodeblock: rawptr) {
    if sfccodeblock != nil {
        (^SFCCodeBlockIF)(sfccodeblock)->Release()
    }
}