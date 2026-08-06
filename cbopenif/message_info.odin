package cbopenif

InfoMsg :: distinct rawptr

InfoMsgIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^InfoMsgVTable,
}

InfoMsgVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    MessageGet:   proc "system" (this: ^InfoMsgIF, Message: ^BStr) -> HResult,
    MessagePut:   proc "system" (this: ^InfoMsgIF, Message: BStr) -> HResult,
    PosInfoGet:   proc "system" (this: ^InfoMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing10:    proc "system" (this: ^InfoMsgIF) -> HResult,
    PosInfoPut:   proc "system" (this: ^InfoMsgIF, PosInfo: rawptr) -> HResult,
    ExtraInfoGet: proc "system" (this: ^InfoMsgIF, ExtraInfo: ^rawptr) -> HResult,
    Missing13:    proc "system" (this: ^InfoMsgIF) -> HResult,
    ExtraInfoPut: proc "system" (this: ^InfoMsgIF, ExtraInfo: rawptr) -> HResult,
}

infomsg_message :: proc {
    infomsg_message_get,
    infomsg_message_set,
}

infomsg_message_get :: proc(infomsg: InfoMsg) -> (message: string, ok: bool) {
    if infomsg == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InfoMsgIF)(infomsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

infomsg_message_set :: proc(infomsg: InfoMsg, message: string) -> (ok: bool) {
    if infomsg == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^InfoMsgIF)(infomsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

infomsg_posinfo :: proc {
    infomsg_posinfo_get,
    infomsg_posinfo_set,
}

infomsg_posinfo_get :: proc(infomsg: InfoMsg) -> (posinfo: PosInfo, ok: bool) {
    if infomsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^InfoMsgIF)(infomsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

infomsg_posinfo_set :: proc(infomsg: InfoMsg, posinfo: PosInfo) -> (ok: bool) {
    if infomsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^InfoMsgIF)(infomsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

infomsg_extra_info :: proc {
    infomsg_extra_info_get,
    infomsg_extra_info_set,
}

infomsg_extra_info_get :: proc(infomsg: InfoMsg) -> (extra_info: ExtraInfo, ok: bool) {
    if infomsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoGet(cast(^rawptr)&extra_info)
    if com_failed(hr) do return

    return extra_info, true
}

infomsg_extra_info_set :: proc(infomsg: InfoMsg, extra_info: ExtraInfo) -> (ok: bool) {
    if infomsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoPut(extra_info)
    if com_failed(hr) do return

    return true
}

infomsg_release :: proc(infomsg: InfoMsg) {
    if infomsg != nil {
        (^InfoMsgIF)(infomsg)->Release()
    }
}
