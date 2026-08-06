package cbopenif

ErrorMsg :: distinct rawptr

ErrorMsgIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ErrorMsgVTable,
}

ErrorMsgVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    ErrorNoGet:   proc "system" (this: ^ErrorMsgIF, ErrorNo: ^i32) -> HResult,
    ErrorNoPut:   proc "system" (this: ^ErrorMsgIF, ErrorNo: i32) -> HResult,
    MessageGet:   proc "system" (this: ^ErrorMsgIF, Message: ^BStr) -> HResult,
    MessagePut:   proc "system" (this: ^ErrorMsgIF, Message: BStr) -> HResult,
    PosInfoGet:   proc "system" (this: ^ErrorMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing12:    proc "system" (this: ^ErrorMsgIF) -> HResult,
    PosInfoPut:   proc "system" (this: ^ErrorMsgIF, PosInfo: rawptr) -> HResult,
    ExtraInfoGet: proc "system" (this: ^ErrorMsgIF, ExtraInfo: ^rawptr) -> HResult,
    Missing15:    proc "system" (this: ^ErrorMsgIF) -> HResult,
    ExtraInfoPut: proc "system" (this: ^ErrorMsgIF, ExtraInfo: rawptr) -> HResult,
}

errormsg_error_number :: proc {
    errormsg_error_number_get,
    errormsg_error_number_set,
}

errormsg_error_number_get :: proc(errormsg: ErrorMsg) -> (error_no: i32, ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ErrorNoGet(&error_no)
    if com_failed(hr) do return

    return error_no, true
}

errormsg_error_number_set :: proc(errormsg: ErrorMsg, error_no: i32) -> (ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ErrorNoPut(error_no)
    if com_failed(hr) do return

    return true
}

errormsg_message :: proc {
    errormsg_message_get,
    errormsg_message_set,
}

errormsg_message_get :: proc(errormsg: ErrorMsg) -> (message: string, ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ErrorMsgIF)(errormsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

errormsg_message_set :: proc(errormsg: ErrorMsg, message: string) -> (ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^ErrorMsgIF)(errormsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

errormsg_posinfo :: proc {
    errormsg_posinfo_get,
    errormsg_posinfo_set,
}

errormsg_posinfo_get :: proc(errormsg: ErrorMsg) -> (posinfo: PosInfo, ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

errormsg_posinfo_set :: proc(errormsg: ErrorMsg, posinfo: PosInfo) -> (ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

errormsg_extra_info :: proc {
    errormsg_extra_info_get,
    errormsg_extra_info_set,
}

errormsg_extra_info_get :: proc(errormsg: ErrorMsg) -> (extra_info: ExtraInfo, ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoGet(cast(^rawptr)&extra_info)
    if com_failed(hr) do return

    return extra_info, true
}

errormsg_extra_info_set :: proc(errormsg: ErrorMsg, extra_info: ExtraInfo) -> (ok: bool) {
    if errormsg == nil do return
    if !controlbuilder_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoPut(extra_info)
    if com_failed(hr) do return

    return true
}

errormsg_release :: proc(errormsg: ErrorMsg) {
    if errormsg != nil {
        (^ErrorMsgIF)(errormsg)->Release()
    }
}
