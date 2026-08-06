package cbopenif

FindMsg :: distinct rawptr

FindMsgIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FindMsgVTable,
}

FindMsgVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    MessageGet: proc "system" (this: ^FindMsgIF, Message: ^BStr) -> HResult,
    MessagePut: proc "system" (this: ^FindMsgIF, Message: BStr) -> HResult,
    PosInfoGet: proc "system" (this: ^FindMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing10:  proc "system" (this: ^FindMsgIF) -> HResult,
    PosInfoPut: proc "system" (this: ^FindMsgIF, PosInfo: rawptr) -> HResult,
}

findmsg_message :: proc {
    findmsg_message_get,
    findmsg_message_set,
}

findmsg_message_get :: proc(findmsg: FindMsg) -> (message: string, ok: bool) {
    if findmsg == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FindMsgIF)(findmsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

findmsg_message_set :: proc(findmsg: FindMsg, message: string) -> (ok: bool) {
    if findmsg == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^FindMsgIF)(findmsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

findmsg_posinfo :: proc {
    findmsg_posinfo_get,
    findmsg_posinfo_set,
}

findmsg_posinfo_get :: proc(findmsg: FindMsg) -> (posinfo: PosInfo, ok: bool) {
    if findmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^FindMsgIF)(findmsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

findmsg_posinfo_set :: proc(findmsg: FindMsg, posinfo: PosInfo) -> (ok: bool) {
    if findmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^FindMsgIF)(findmsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

findmsg_release :: proc(findmsg: FindMsg) {
    if findmsg != nil {
        (^FindMsgIF)(findmsg)->Release()
    }
}
