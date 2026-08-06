package cbopenif

WarningMsg :: distinct rawptr

WarningMsgIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^WarningMsgVTable,
}

WarningMsgVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    WarningNoGet: proc "system" (this: ^WarningMsgIF, WarningNo: ^i32) -> HResult,
    WarningNoPut: proc "system" (this: ^WarningMsgIF, WarningNo: i32) -> HResult,
    MessageGet:   proc "system" (this: ^WarningMsgIF, Message: ^BStr) -> HResult,
    MessagePut:   proc "system" (this: ^WarningMsgIF, Message: BStr) -> HResult,
    PosInfoGet:   proc "system" (this: ^WarningMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing12:    proc "system" (this: ^WarningMsgIF) -> HResult,
    PosInfoPut:   proc "system" (this: ^WarningMsgIF, PosInfo: rawptr) -> HResult,
    ExtraInfoGet: proc "system" (this: ^WarningMsgIF, ExtraInfo: ^rawptr) -> HResult,
    Missing15:    proc "system" (this: ^WarningMsgIF) -> HResult,
    ExtraInfoPut: proc "system" (this: ^WarningMsgIF, ExtraInfo: rawptr) -> HResult,
}

warningmsg_warning_number :: proc {
    warningmsg_warning_number_get,
    warningmsg_warning_number_set,
}

warningmsg_warning_number_get :: proc(warningmsg: WarningMsg) -> (warning_number: i32, ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->WarningNoGet(&warning_number)
    if com_failed(hr) do return

    return warning_number, true
}

warningmsg_warning_number_set :: proc(warningmsg: WarningMsg, warning_number: i32) -> (ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->WarningNoPut(warning_number)
    if com_failed(hr) do return

    return true
}

warningmsg_message :: proc {
    warningmsg_message_get,
    warningmsg_message_set,
}

warningmsg_message_get :: proc(warningmsg: WarningMsg) -> (message: string, ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^WarningMsgIF)(warningmsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

warningmsg_message_set :: proc(warningmsg: WarningMsg, message: string) -> (ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^WarningMsgIF)(warningmsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

warningmsg_posinfo :: proc {
    warningmsg_posinfo_get,
    warningmsg_posinfo_set,
}

warningmsg_posinfo_get :: proc(warningmsg: WarningMsg) -> (posinfo: PosInfo, ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

warningmsg_posinfo_set :: proc(warningmsg: WarningMsg, posinfo: PosInfo) -> (ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

warningmsg_extra_info :: proc {
    warningmsg_extra_info_get,
    warningmsg_extra_info_set,
}

warningmsg_extra_info_get :: proc(warningmsg: WarningMsg) -> (extra_info: ExtraInfo, ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoGet(cast(^rawptr)&extra_info)
    if com_failed(hr) do return

    return extra_info, true
}

warningmsg_extra_info_set :: proc(warningmsg: WarningMsg, extra_info: ExtraInfo) -> (ok: bool) {
    if warningmsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoPut(extra_info)
    if com_failed(hr) do return

    return true
}

warningmsg_release :: proc(warningmsg: WarningMsg) {
    if warningmsg != nil {
        (^WarningMsgIF)(warningmsg)->Release()
    }
}
