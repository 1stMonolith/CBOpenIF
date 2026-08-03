package message

import "../com"
import "../controlbuilder"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

ExtraInfo :: distinct rawptr

ExtraInfoIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ExtraInfoVTable,
}

ExtraInfoVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    JumpDestGet:     proc "system" (this: ^ExtraInfoIF, JumpDest: ^BStr) -> HResult,
    JumpDestPut:     proc "system" (this: ^ExtraInfoIF, JumpDest: BStr) -> HResult,
    VarNameGet:      proc "system" (this: ^ExtraInfoIF, VarName: ^BStr) -> HResult,
    VarNamePut:      proc "system" (this: ^ExtraInfoIF, VarName: BStr) -> HResult,
    FunctionNameGet: proc "system" (this: ^ExtraInfoIF, FunctionName: ^BStr) -> HResult,
    FunctionNamePut: proc "system" (this: ^ExtraInfoIF, FunctionName: BStr) -> HResult,
    ExpectedTypeGet: proc "system" (this: ^ExtraInfoIF, ExpectedType: ^BStr) -> HResult,
    ExpectedTypePut: proc "system" (this: ^ExtraInfoIF, ExpectedType: BStr) -> HResult,
    TraverseNoGet:   proc "system" (this: ^ExtraInfoIF, TraverseNo: ^i32) -> HResult,
    TraverseNoPut:   proc "system" (this: ^ExtraInfoIF, TraverseNo: i32) -> HResult,
}

extrainfo_jump_destination :: proc {
    extrainfo_jump_destination_get,
    extrainfo_jump_destination_set,
}

extrainfo_jump_destination_get :: proc(extrainfo: ExtraInfo) -> (jump_destination: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extrainfo_jump_destination_set :: proc(extrainfo: ExtraInfo, jump_destination: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(jump_destination)
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestPut(bs)
    if com.failed(hr) do return

    return true
}

extrainfo_var_name :: proc {
    extrainfo_var_name_get,
    extrainfo_var_name_set,
}

extrainfo_var_name_get :: proc(extrainfo: ExtraInfo) -> (var_name: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extrainfo_var_name_set :: proc(extrainfo: ExtraInfo, var_name: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(var_name)
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNamePut(bs)
    if com.failed(hr) do return

    return true
}

extrainfo_function_name :: proc {
    extrainfo_function_name_get,
    extrainfo_function_name_set,
}

extrainfo_function_name_get :: proc(extrainfo: ExtraInfo) -> (function_name: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNameGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extrainfo_function_name_set :: proc(extrainfo: ExtraInfo, function_name: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(function_name)
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNamePut(bs)
    if com.failed(hr) do return

    return true
}

extrainfo_expected_type :: proc {
    extrainfo_expected_type_get,
    extrainfo_expected_type_set,
}

extrainfo_expected_type_get :: proc(extrainfo: ExtraInfo) -> (expected_type: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypeGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

extrainfo_expected_type_set :: proc(extrainfo: ExtraInfo, expected_type: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(expected_type)
    defer com.bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypePut(bs)
    if com.failed(hr) do return

    return true
}

extrainfo_traverse_number :: proc {
    extrainfo_traverse_number_get,
    extrainfo_traverse_number_set,
}

extrainfo_traverse_number_get :: proc(extrainfo: ExtraInfo) -> (traverse_number: i32, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoGet(&traverse_number)
    if com.failed(hr) do return

    return traverse_number, true
}

extrainfo_traverse_number_set :: proc(extrainfo: ExtraInfo, traverse_number: i32) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoPut(traverse_number)
    if com.failed(hr) do return

    return true
}

extrainfo_release :: proc(extrainfo: ExtraInfo) {
    if extrainfo != nil {
        (^ExtraInfoIF)(extrainfo)->Release()
    }
}
