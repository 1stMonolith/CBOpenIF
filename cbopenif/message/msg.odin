package message

import "../com"
import "../controlbuilder"

@(private="file") BStr        :: com.BStr
@(private="file") HResult     :: com.HResult
@(private="file") VariantBool :: com.VariantBool

Msg :: distinct rawptr

MsgIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^MsgVTable,
}

MsgVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    MessageGet:    proc "system" (this: ^MsgIF, Message: ^BStr) -> HResult,
    MessagePut:    proc "system" (this: ^MsgIF, Message: BStr) -> HResult,
    IsErrorMsg:    proc "system" (this: ^MsgIF, IsErrorMsg: ^VariantBool) -> HResult,
    IsWarningMsg:  proc "system" (this: ^MsgIF, IsWarningMsg: ^VariantBool) -> HResult,
    IsInfoMsg:     proc "system" (this: ^MsgIF, IsInfoMsg: ^VariantBool) -> HResult,
    IsFindMsg:     proc "system" (this: ^MsgIF, IsFindMsg: ^VariantBool) -> HResult,
}

msg_message :: proc {
    msg_message_get,
    msg_message_set,
}

msg_message_get :: proc(msg: Msg) -> (message: string, ok: bool) {
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^MsgIF)(msg)->MessageGet(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

msg_message_set :: proc(msg: Msg, message: string) -> (ok: bool) {
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(message)
    defer com.bstr_free(bs)
    hr := (^MsgIF)(msg)->MessagePut(bs)
    if com.failed(hr) do return

    return true
}

msg_is_error :: proc(msg: Msg) -> (is_error: bool, ok: bool) {
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MsgIF)(msg)->IsErrorMsg(&vb)
    if com.failed(hr) do return

    return vb == com.VariantBoolTrue, true
}

msg_is_warning :: proc(msg: Msg) -> (is_warning: bool, ok: bool) {
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MsgIF)(msg)->IsWarningMsg(&vb)
    if com.failed(hr) do return

    return vb == com.VariantBoolTrue, true
}

msg_is_info :: proc(msg: Msg) -> (is_info: bool, ok: bool) {
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MsgIF)(msg)->IsInfoMsg(&vb)
    if com.failed(hr) do return

    return vb == com.VariantBoolTrue, true
}

msg_is_find :: proc(msg: Msg) -> (is_find: bool, ok: bool) {
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MsgIF)(msg)->IsFindMsg(&vb)
    if com.failed(hr) do return

    return vb == com.VariantBoolTrue, true
}

msg_release :: proc(msg: Msg) {
    if msg != nil {
        (^MsgIF)(msg)->Release()
    }
}
