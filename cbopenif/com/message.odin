package com

import t "../types"

IMessage      :: distinct rawptr
MessageBucket :: distinct rawptr
WarningMsg    :: distinct rawptr
InfoMsg       :: distinct rawptr
FindMsg       :: distinct rawptr
ErrorMsg      :: distinct rawptr
ExtraInfo     :: distinct rawptr

MessageUnion :: union {
    ErrorMsg,
    WarningMsg,
    InfoMsg,
    FindMsg,
}

Message :: struct {
    kind: t.MessageKind,
    msg:  MessageUnion,
}

IID_ErrorMsg   :: GUID{0xAA7D0C85, 0xEB7F, 0x4859, {0xAB, 0xE8, 0xE7, 0xE9, 0x45, 0x41, 0x93, 0x0B}}
IID_InfoMsg    :: GUID{0xE045A7B5, 0x1FE2, 0x49BD, {0xB2, 0x6F, 0x26, 0xCC, 0xEF, 0x82, 0x68, 0xC0}}
IID_WarningMsg :: GUID{0xD5246053, 0xFB82, 0x45FE, {0xAF, 0x12, 0x10, 0xE2, 0xFC, 0xAE, 0x91, 0xF0}}
IID_FindMsg    :: GUID{0xDBE93C58, 0xDE18, 0x4B71, {0xBF, 0x89, 0xA3, 0x1B, 0xBB, 0x7A, 0xD7, 0x38}}
IID_IMsg       :: GUID{0x24B4263B, 0xFD38, 0x4D67, {0x99, 0x03, 0x0A, 0x6D, 0x81, 0xA8, 0x76, 0x8C}}

IMessageIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IMessageVTable,
}

IMessageVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    MessageGet:    proc "system" (this: ^IMessageIF, Message: ^BStr) -> HResult,
    MessagePut:    proc "system" (this: ^IMessageIF, Message: BStr) -> HResult,
    IsErrorMsg:    proc "system" (this: ^IMessageIF, IsErrorMessage: ^VariantBool) -> HResult,
    IsWarningMsg:  proc "system" (this: ^IMessageIF, IsWarningMessage: ^VariantBool) -> HResult,
    IsInfoMsg:     proc "system" (this: ^IMessageIF, IsInfoMessage: ^VariantBool) -> HResult,
    IsFindMsg:     proc "system" (this: ^IMessageIF, IsFindMessage: ^VariantBool) -> HResult,
}

imessage_is_error :: proc(imessage: IMessage) -> (is_error: bool, ok: bool) {
    if imessage == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsErrorMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_as_error :: proc(imessage: IMessage) -> (errormsg: ErrorMsg, ok: bool) {
    if imessage == nil do return
    
    IID := IID_ErrorMsg
    hr := (^IUnknownIF)(imessage)->QueryInterface(&IID, cast(^rawptr)&errormsg)
    if com_failed(hr) do return
    
    return errormsg, true
}

imessage_is_warning :: proc(imessage: IMessage) -> (is_warning: bool, ok: bool) {
    if imessage == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsWarningMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_as_warning :: proc(imessage: IMessage) -> (warningmsg: WarningMsg, ok: bool) {
    if imessage == nil do return
    
    IID := IID_WarningMsg
    hr := (^IUnknownIF)(imessage)->QueryInterface(&IID, cast(^rawptr)&warningmsg)
    if com_failed(hr) do return
    
    return warningmsg, true
}

imessage_is_info :: proc(imessage: IMessage) -> (is_info: bool, ok: bool) {
    if imessage == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsInfoMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_as_info :: proc(imessage: IMessage) -> (infomsg: InfoMsg, ok: bool) {
    if imessage == nil do return
    
    IID := IID_InfoMsg
    hr := (^IUnknownIF)(imessage)->QueryInterface(&IID, cast(^rawptr)&infomsg)
    if com_failed(hr) do return
    
    return infomsg, true
}

imessage_is_find :: proc(imessage: IMessage) -> (is_find: bool, ok: bool) {
    if imessage == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsFindMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_as_find :: proc(imessage: IMessage) -> (findmsg: FindMsg, ok: bool) {
    if imessage == nil do return
    
    IID := IID_FindMsg
    hr := (^IUnknownIF)(imessage)->QueryInterface(&IID, cast(^rawptr)&findmsg)
    if com_failed(hr) do return
    
    return findmsg, true
}

imessage_release :: proc(imessage: IMessage) {
    if imessage != nil {
        (^IMessageIF)(imessage)->Release()
    }
}

from_imessage :: proc(imessage: IMessage) -> (message: Message, ok: bool) {
    if imessage == nil do return

    if is, ok := imessage_is_error(imessage); ok && is {
        e, ok := imessage_as_error(imessage)
        if !ok do return
        message.kind = .Error
        message.msg = e
        return message, true
    }

    if is, ok := imessage_is_warning(imessage); ok && is {
        w, ok := imessage_as_warning(imessage)
        if !ok do return
        message.kind = .Warning
        message.msg = w
        return message, true
    }

    if is, ok := imessage_is_info(imessage); ok && is {
        i, ok := imessage_as_info(imessage)
        if !ok do return
        message.kind = .Info
        message.msg = i
        return message, true
    }

    if is, ok := imessage_is_find(imessage); ok && is {
        f, ok := imessage_as_find(imessage)
        if !ok do return
        message.kind = .Find
        message.msg = f
        return message, true
    }

    return {}, false
}

message_message_get :: proc(message: Message) -> (text: string, ok: bool) {
    switch m in message.msg {
        case ErrorMsg:   return errormsg_message_get(m)
        case WarningMsg: return warningmsg_message_get(m)
        case InfoMsg:    return infomsg_message_get(m)
        case FindMsg:    return findmsg_message_get(m)
    }
    return
}

message_message_set :: proc(message: Message, text: string) -> (ok: bool) {
    switch m in message.msg {
        case ErrorMsg:   return errormsg_message_set(m, text)
        case WarningMsg: return warningmsg_message_set(m, text)
        case InfoMsg:    return infomsg_message_set(m, text)
        case FindMsg:    return findmsg_message_set(m, text)
    }
    return
}

message_posinfo_get :: proc(message: Message) -> (posinfo: PosInfo, ok: bool) {
    switch m in message.msg {
        case ErrorMsg:   return errormsg_posinfo_get(m)
        case WarningMsg: return warningmsg_posinfo_get(m)
        case InfoMsg:    return infomsg_posinfo_get(m)
        case FindMsg:    return findmsg_posinfo_get(m)
    }
    return
}

message_from_com :: proc(message: Message, allocator := context.allocator) -> (result: t.Msg, ok: bool) {
    context.allocator = allocator
    result.kind = message.kind

    result.message, ok = message(message)
    if !ok do return

    result.pos_info, ok = pos_info(message)
    if !ok do return

    if message.kind == .Error {
        result.error_number, ok = error_number(message)
        if !ok do return
    }

    if message.kind == .Warning {
        result.warning_number, ok = warning_number(message)
        if !ok do return
    }

    if message.kind == .Warning || message.kind == .Info || message.kind == .Error {
        ei: ExtraInfo
        ei, ok = extrainfo(ei)
        if !ok do return
        defer release(ei)

        eis: t.ExtraInfo
        result.extra_info, ok = extrainfo_from_com(ei)
        if !ok do return
    }

    return result, true
}

MessageBucketIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^MessageBucketVTable,
}

MessageBucketVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NoOfErrorsGet:   proc "system" (this: ^MessageBucketIF, NoOfErrors: ^i32) -> HResult,
    NoOfErrorsPut:   proc "system" (this: ^MessageBucketIF, NoOfErrors: i32) -> HResult,
    NoOfWarningsGet: proc "system" (this: ^MessageBucketIF, NoOfWarnings: ^i32) -> HResult,
    NoOfWarningsPut: proc "system" (this: ^MessageBucketIF, NoOfWarnings: i32) -> HResult,
    Serialize:       proc "system" (this: ^MessageBucketIF, XML: ^BStr) -> HResult,
    Add:             proc "system" (this: ^MessageBucketIF, Message: rawptr) -> HResult,
    Item:            proc "system" (this: ^MessageBucketIF, Index: i32, Message: ^rawptr) -> HResult,
    Count:           proc "system" (this: ^MessageBucketIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^MessageBucketIF, Index: i32) -> HResult,
}

messagebucket_serialize :: proc(bucket: MessageBucket) -> (xml: string, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^MessageBucketIF)(bucket)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

messagebucket_number_of_errors_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsGet(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_number_of_errors_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsPut(count)
    if com_failed(hr) do return

    return true
}

messagebucket_number_of_warnings_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsGet(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_number_of_warnings_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsPut(count)
    if com_failed(hr) do return

    return true
}

messagebucket_message_add :: proc(bucket: MessageBucket, imessage: IMessage) -> (ok: bool) {
    if bucket == nil do return
    if imessage == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->Add(imessage)
    if com_failed(hr) do return

    return true
}

messagebucket_message_by_index :: proc(bucket: MessageBucket, index: i32) -> (imessage: IMessage, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->Item(index + 1, cast(^rawptr)&imessage)
    if com_failed(hr) do return

    return imessage, true
}

messagebucket_message_count :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_message_remove_by_index :: proc(bucket: MessageBucket, index: i32) -> (ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MessageBucketIF)(bucket)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

messagebucket_release :: proc(bucket: MessageBucket) {
    if bucket != nil {
        (^MessageBucketIF)(bucket)->Release()
    }
}

messagebucket_from_com :: proc(bucket: MessageBucket, allocator := context.allocator) -> (result: t.MessageBucket, ok: bool) {
    if bucket == nil do return
    context.allocator = allocator

    count: i32
    count, ok = messagebucket_message_count(bucket)
    if !ok do return

    result.messages = make([dynamic]t.Msg, 0, int(count), allocator)

    for i in 0..<count {
        im: IMessage
        im, ok = messagebucket_message_by_index(bucket, i)
        if !ok do return
        defer release(im)

        msg: Message
        msg, ok = from_imessage(im)
        if !ok do return
        defer release(msg.msg)

        ms: t.Msg
        ms, ok = message_from_com(msg)
        if !ok do return
        append(&result.messages, ms)
    }

    return result, true
}

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

warningmsg_warning_number_get :: proc(warningmsg: WarningMsg) -> (warning_number: i32, ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->WarningNoGet(&warning_number)
    if com_failed(hr) do return

    return warning_number, true
}

warningmsg_warning_number_set :: proc(warningmsg: WarningMsg, warning_number: i32) -> (ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->WarningNoPut(warning_number)
    if com_failed(hr) do return

    return true
}

warningmsg_message_get :: proc(warningmsg: WarningMsg) -> (message: string, ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^WarningMsgIF)(warningmsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

warningmsg_message_set :: proc(warningmsg: WarningMsg, message: string) -> (ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^WarningMsgIF)(warningmsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

warningmsg_posinfo_get :: proc(warningmsg: WarningMsg) -> (posinfo: PosInfo, ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

warningmsg_posinfo_set :: proc(warningmsg: WarningMsg, posinfo: PosInfo) -> (ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

warningmsg_extra_info_get :: proc(warningmsg: WarningMsg) -> (extra_info: ExtraInfo, ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoGet(cast(^rawptr)&extra_info)
    if com_failed(hr) do return

    return extra_info, true
}

warningmsg_extra_info_set :: proc(warningmsg: WarningMsg, extra_info: ExtraInfo) -> (ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoPut(extra_info)
    if com_failed(hr) do return

    return true
}

warningmsg_release :: proc(warningmsg: WarningMsg) {
    if warningmsg != nil {
        (^WarningMsgIF)(warningmsg)->Release()
    }
}

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

infomsg_message_get :: proc(infomsg: InfoMsg) -> (message: string, ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InfoMsgIF)(infomsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

infomsg_message_set :: proc(infomsg: InfoMsg, message: string) -> (ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^InfoMsgIF)(infomsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

infomsg_posinfo_get :: proc(infomsg: InfoMsg) -> (posinfo: PosInfo, ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    hr := (^InfoMsgIF)(infomsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

infomsg_posinfo_set :: proc(infomsg: InfoMsg, posinfo: PosInfo) -> (ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    hr := (^InfoMsgIF)(infomsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

infomsg_extra_info_get :: proc(infomsg: InfoMsg) -> (extra_info: ExtraInfo, ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoGet(cast(^rawptr)&extra_info)
    if com_failed(hr) do return

    return extra_info, true
}

infomsg_extra_info_set :: proc(infomsg: InfoMsg, extra_info: ExtraInfo) -> (ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoPut(extra_info)
    if com_failed(hr) do return

    return true
}

infomsg_release :: proc(infomsg: InfoMsg) {
    if infomsg != nil {
        (^InfoMsgIF)(infomsg)->Release()
    }
}

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

findmsg_message_get :: proc(findmsg: FindMsg) -> (message: string, ok: bool) {
    if findmsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FindMsgIF)(findmsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

findmsg_message_set :: proc(findmsg: FindMsg, message: string) -> (ok: bool) {
    if findmsg == nil do return
    if !com_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^FindMsgIF)(findmsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

findmsg_posinfo_get :: proc(findmsg: FindMsg) -> (posinfo: PosInfo, ok: bool) {
    if findmsg == nil do return
    if !com_connected() do return

    hr := (^FindMsgIF)(findmsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

findmsg_posinfo_set :: proc(findmsg: FindMsg, posinfo: PosInfo) -> (ok: bool) {
    if findmsg == nil do return
    if !com_connected() do return

    hr := (^FindMsgIF)(findmsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

findmsg_release :: proc(findmsg: FindMsg) {
    if findmsg != nil {
        (^FindMsgIF)(findmsg)->Release()
    }
}

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

errormsg_error_number_get :: proc(errormsg: ErrorMsg) -> (error_no: i32, ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ErrorNoGet(&error_no)
    if com_failed(hr) do return

    return error_no, true
}

errormsg_error_number_set :: proc(errormsg: ErrorMsg, error_no: i32) -> (ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ErrorNoPut(error_no)
    if com_failed(hr) do return

    return true
}

errormsg_message_get :: proc(errormsg: ErrorMsg) -> (message: string, ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ErrorMsgIF)(errormsg)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

errormsg_message_set :: proc(errormsg: ErrorMsg, message: string) -> (ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    bs := to_bstr(message)
    defer bstr_free(bs)
    hr := (^ErrorMsgIF)(errormsg)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

errormsg_posinfo_get :: proc(errormsg: ErrorMsg) -> (posinfo: PosInfo, ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if com_failed(hr) do return

    return posinfo, true
}

errormsg_posinfo_set :: proc(errormsg: ErrorMsg, posinfo: PosInfo) -> (ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->PosInfoPut(posinfo)
    if com_failed(hr) do return

    return true
}

errormsg_extra_info_get :: proc(errormsg: ErrorMsg) -> (extra_info: ExtraInfo, ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoGet(cast(^rawptr)&extra_info)
    if com_failed(hr) do return

    return extra_info, true
}

errormsg_extra_info_set :: proc(errormsg: ErrorMsg, extra_info: ExtraInfo) -> (ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoPut(extra_info)
    if com_failed(hr) do return

    return true
}

errormsg_release :: proc(errormsg: ErrorMsg) {
    if errormsg != nil {
        (^ErrorMsgIF)(errormsg)->Release()
    }
}

ExtraInfoIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtraInfoVTable,
}

ExtraInfoVTable :: struct {
    using iunknownvtable: IUnknownVTable,
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

extrainfo_jump_destination_get :: proc(extrainfo: ExtraInfo) -> (jump_destination: string, ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_jump_destination_set :: proc(extrainfo: ExtraInfo, jump_destination: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs := to_bstr(jump_destination)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestPut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_var_name_get :: proc(extrainfo: ExtraInfo) -> (var_name: string, ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_var_name_set :: proc(extrainfo: ExtraInfo, var_name: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs := to_bstr(var_name)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNamePut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_function_name_get :: proc(extrainfo: ExtraInfo) -> (function_name: string, ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_function_name_set :: proc(extrainfo: ExtraInfo, function_name: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs := to_bstr(function_name)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNamePut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_expected_type_get :: proc(extrainfo: ExtraInfo) -> (expected_type: string, ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_expected_type_set :: proc(extrainfo: ExtraInfo, expected_type: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    bs := to_bstr(expected_type)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypePut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_traverse_number_get :: proc(extrainfo: ExtraInfo) -> (traverse_number: i32, ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoGet(&traverse_number)
    if com_failed(hr) do return

    return traverse_number, true
}

extrainfo_traverse_number_set :: proc(extrainfo: ExtraInfo, traverse_number: i32) -> (ok: bool) {
    if extrainfo == nil do return
    if !com_connected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoPut(traverse_number)
    if com_failed(hr) do return

    return true
}

extrainfo_release :: proc(extrainfo: ExtraInfo) {
    if extrainfo != nil {
        (^ExtraInfoIF)(extrainfo)->Release()
    }
}

extrainfo_from_com :: proc(extrainfo: ExtraInfo, allocator := context.allocator) -> (result: t.ExtraInfo, ok: bool) {
    if extrainfo == nil do return

    context.allocator = allocator

    result.jump_destination, ok = extrainfo_jump_destination_get(extrainfo)
    if !ok do return
    result.var_name, ok = extrainfo_var_name_get(extrainfo)
    if !ok do return
    result.function_name, ok = extrainfo_function_name_get(extrainfo)
    if !ok do return
    result.expected_type, ok = extrainfo_expected_type_get(extrainfo)
    if !ok do return
    result.traverse_no, ok = extrainfo_traverse_no_get(extrainfo)
    if !ok do return

    return result, true
}
