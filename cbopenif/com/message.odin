package com

import t "../types"

IMsg       :: distinct rawptr
MsgBucket  :: distinct rawptr
WarningMsg :: distinct rawptr
InfoMsg    :: distinct rawptr
FindMsg    :: distinct rawptr
ErrorMsg   :: distinct rawptr
ExtraInfo  :: distinct rawptr

MsgUnion :: union {
    ErrorMsg,
    WarningMsg,
    InfoMsg,
    FindMsg,
}

Msg :: struct {
    kind: t.MessageKind,
    msg:  MsgUnion,
}

IID_ErrorMsg   :: GUID{0xAA7D0C85, 0xEB7F, 0x4859, {0xAB, 0xE8, 0xE7, 0xE9, 0x45, 0x41, 0x93, 0x0B}}
IID_InfoMsg    :: GUID{0xE045A7B5, 0x1FE2, 0x49BD, {0xB2, 0x6F, 0x26, 0xCC, 0xEF, 0x82, 0x68, 0xC0}}
IID_WarningMsg :: GUID{0xD5246053, 0xFB82, 0x45FE, {0xAF, 0x12, 0x10, 0xE2, 0xFC, 0xAE, 0x91, 0xF0}}
IID_FindMsg    :: GUID{0xDBE93C58, 0xDE18, 0x4B71, {0xBF, 0x89, 0xA3, 0x1B, 0xBB, 0x7A, 0xD7, 0x38}}
IID_IMsg       :: GUID{0x24B4263B, 0xFD38, 0x4D67, {0x99, 0x03, 0x0A, 0x6D, 0x81, 0xA8, 0x76, 0x8C}}

IMsgIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IMsgVTable,
}

IMsgVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    TextGet:      proc "system" (this: ^IMsgIF, Text: ^BStr) -> HResult,
    TextPut:      proc "system" (this: ^IMsgIF, Text: BStr) -> HResult,
    IsErrorMsg:   proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
    IsWarningMsg: proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
    IsInfoMsg:    proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
    IsFindMsg:    proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
}

imsg_is_error :: proc(imsg: IMsg) -> (is_error: bool, ok: bool) {
    if imsg == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsErrorMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imsg_as_error :: proc(imsg: IMsg) -> (errormsg: ErrorMsg, ok: bool) {
    if imsg == nil do return
    
    IID := IID_ErrorMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&errormsg)
    if com_failed(hr) do return
    
    return errormsg, true
}

imsg_is_warning :: proc(imsg: IMsg) -> (is_warning: bool, ok: bool) {
    if imsg == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsWarningMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imsg_as_warning :: proc(imsg: IMsg) -> (warningmsg: WarningMsg, ok: bool) {
    if imsg == nil do return
    
    IID := IID_WarningMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&warningmsg)
    if com_failed(hr) do return
    
    return warningmsg, true
}

imsg_is_info :: proc(imsg: IMsg) -> (is_info: bool, ok: bool) {
    if imsg == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsInfoMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imsg_as_info :: proc(imsg: IMsg) -> (infomsg: InfoMsg, ok: bool) {
    if imsg == nil do return
    
    IID := IID_InfoMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&infomsg)
    if com_failed(hr) do return
    
    return infomsg, true
}

imsg_is_find :: proc(imsg: IMsg) -> (is_find: bool, ok: bool) {
    if imsg == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsFindMsg(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imsg_as_find :: proc(imsg: IMsg) -> (findmsg: FindMsg, ok: bool) {
    if imsg == nil do return
    
    IID := IID_FindMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&findmsg)
    if com_failed(hr) do return
    
    return findmsg, true
}

imsg_release :: proc(imsg: IMsg) {
    if imsg != nil {
        (^IMsgIF)(imsg)->Release()
    }
}

from_imsg :: proc(imsg: IMsg) -> (message: Msg, ok: bool) {
    if imsg == nil do return
    
    is: bool

    is, ok = imsg_is_error(imsg)
    if ok && is {
        e, okas := imsg_as_error(imsg)
        if !okas do return
        message.kind = .Error
        message.msg = e
        return message, true
    }

    is, ok = imsg_is_warning(imsg)
    if ok && is {
        w, okas := imsg_as_warning(imsg)
        if !okas do return
        message.kind = .Warning
        message.msg = w
        return message, true
    }

    is, ok = imsg_is_info(imsg)
    if ok && is {
        i, okas := imsg_as_info(imsg)
        if !okas do return
        message.kind = .Info
        message.msg = i
        return message, true
    }

    is, ok = imsg_is_find(imsg)
    if ok && is {
        f, okas := imsg_as_find(imsg)
        if !okas do return
        message.kind = .Find
        message.msg = f
        return message, true
    }

    return {}, false
}

message_text_get :: proc(message: Msg) -> (text: string, ok: bool) {
    switch m in message.msg {
        case ErrorMsg:   return errormsg_text_get(m)
        case WarningMsg: return warningmsg_text_get(m)
        case InfoMsg:    return infomsg_text_get(m)
        case FindMsg:    return findmsg_text_get(m)
    }
    return
}

message_text_set :: proc(message: Msg, text: string) -> (ok: bool) {
    switch m in message.msg {
        case ErrorMsg:   return errormsg_text_set(m, text)
        case WarningMsg: return warningmsg_text_set(m, text)
        case InfoMsg:    return infomsg_text_set(m, text)
        case FindMsg:    return findmsg_text_set(m, text)
    }
    return
}

message_posinfo_get :: proc(message: Msg) -> (posinfo: PosInfo, ok: bool) {
    switch m in message.msg {
        case ErrorMsg:   return errormsg_posinfo_get(m)
        case WarningMsg: return warningmsg_posinfo_get(m)
        case InfoMsg:    return infomsg_posinfo_get(m)
        case FindMsg:    return findmsg_posinfo_get(m)
    }
    return
}

message_release :: proc(message: Msg) {
    switch m in message.msg {
        case ErrorMsg:   errormsg_release(m)
        case WarningMsg: warningmsg_release(m)
        case InfoMsg:    infomsg_release(m)
        case FindMsg:    findmsg_release(m)
    }
}

message_from_com :: proc(message: Msg, allocator := context.allocator) -> (result: t.Message, ok: bool) {
    context.allocator = allocator
    result.kind = message.kind

    result.text, ok = message_text(message)
    if !ok do return

    pi: PosInfo
    pi, ok = posinfo(message)
    if !ok do return
    defer release(pi)
    result.pos_info, ok = posinfo_from_com(pi)
    if !ok do return

    switch m in message.msg {
    case ErrorMsg:
        result.error_number, ok = error_number(m)
        if !ok do return
        
        ei: ExtraInfo
        ei, ok = extrainfo(m)
        if !ok do return
        defer release(ei)
        
        result.extra_info, ok = extrainfo_from_com(ei)
        if !ok do return

    case WarningMsg:
        result.warning_number, ok = warning_number(m)
        if !ok do return
        
        ei: ExtraInfo
        ei, ok = extrainfo(m)
        if !ok do return
        defer release(ei)
        
        result.extra_info, ok = extrainfo_from_com(ei)
        if !ok do return

    case InfoMsg:
        ei: ExtraInfo
        ei, ok = extrainfo(m)
        if !ok do return
        defer release(ei)
        
        result.extra_info, ok = extrainfo_from_com(ei)
        if !ok do return

    case FindMsg:
        // nothing extra
    }

    return result, true
}

MsgBucketIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^MsgBucketVTable,
}

MsgBucketVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NoOfErrorsGet:   proc "system" (this: ^MsgBucketIF, NoOfErrors: ^i32) -> HResult,
    NoOfErrorsPut:   proc "system" (this: ^MsgBucketIF, NoOfErrors: i32) -> HResult,
    NoOfWarningsGet: proc "system" (this: ^MsgBucketIF, NoOfWarnings: ^i32) -> HResult,
    NoOfWarningsPut: proc "system" (this: ^MsgBucketIF, NoOfWarnings: i32) -> HResult,
    Serialize:       proc "system" (this: ^MsgBucketIF, XML: ^BStr) -> HResult,
    Add:             proc "system" (this: ^MsgBucketIF, Message: rawptr) -> HResult,
    Item:            proc "system" (this: ^MsgBucketIF, Index: i32, Message: ^rawptr) -> HResult,
    Count:           proc "system" (this: ^MsgBucketIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^MsgBucketIF, Index: i32) -> HResult,
}

msgbucket_serialize :: proc(bucket: MsgBucket) -> (xml: string, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^MsgBucketIF)(bucket)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

msgbucket_number_of_errors_get :: proc(bucket: MsgBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfErrorsGet(&count)
    if com_failed(hr) do return

    return count, true
}

msgbucket_number_of_errors_set :: proc(bucket: MsgBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfErrorsPut(count)
    if com_failed(hr) do return

    return true
}

msgbucket_number_of_warnings_get :: proc(bucket: MsgBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfWarningsGet(&count)
    if com_failed(hr) do return

    return count, true
}

msgbucket_number_of_warnings_set :: proc(bucket: MsgBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfWarningsPut(count)
    if com_failed(hr) do return

    return true
}

msgbucket_message_add :: proc(bucket: MsgBucket, imsg: IMsg) -> (ok: bool) {
    if bucket == nil do return
    if imsg == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->Add(imsg)
    if com_failed(hr) do return

    return true
}

msgbucket_message_by_index :: proc(bucket: MsgBucket, index: i32) -> (imsg: IMsg, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->Item(index + 1, cast(^rawptr)&imsg)
    if com_failed(hr) do return

    return imsg, true
}

msgbucket_message_count :: proc(bucket: MsgBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

msgbucket_message_remove_by_index :: proc(bucket: MsgBucket, index: i32) -> (ok: bool) {
    if bucket == nil do return
    if !com_connected() do return

    hr := (^MsgBucketIF)(bucket)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

msgbucket_release :: proc(bucket: MsgBucket) {
    if bucket != nil {
        (^MsgBucketIF)(bucket)->Release()
    }
}

msgbucket_from_com :: proc(bucket: MsgBucket, allocator := context.allocator) -> (result: t.MessageBucket, ok: bool) {
    if bucket == nil do return
    context.allocator = allocator

    count: i32
    count, ok = msgbucket_message_count(bucket)
    if !ok do return

    result.messages = make([dynamic]t.Message, 0, int(count), allocator)

    for i in 0..<count {
        imsg: IMsg
        imsg, ok = msgbucket_message_by_index(bucket, i)
        if !ok do return
        defer release(imsg)

        msg: Msg
        msg, ok = from_imsg(imsg)
        if !ok do return
        defer message_release(msg)

        msgs: t.Message
        msgs, ok = message_from_com(msg)
        if !ok do return
        append(&result.messages, msgs)
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
    TextGet:      proc "system" (this: ^WarningMsgIF, Text: ^BStr) -> HResult,
    TextPut:      proc "system" (this: ^WarningMsgIF, Text: BStr) -> HResult,
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

warningmsg_text_get :: proc(warningmsg: WarningMsg) -> (text: string, ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^WarningMsgIF)(warningmsg)->TextGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

warningmsg_text_set :: proc(warningmsg: WarningMsg, text: string) -> (ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    bs := to_bstr(text)
    defer bstr_free(bs)
    hr := (^WarningMsgIF)(warningmsg)->TextPut(bs)
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

warningmsg_extrainfo_get :: proc(warningmsg: WarningMsg) -> (extrainfo: ExtraInfo, ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoGet(cast(^rawptr)&extrainfo)
    if com_failed(hr) do return

    return extrainfo, true
}

warningmsg_extrainfo_set :: proc(warningmsg: WarningMsg, extrainfo: ExtraInfo) -> (ok: bool) {
    if warningmsg == nil do return
    if !com_connected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoPut(extrainfo)
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
    TextGet:      proc "system" (this: ^InfoMsgIF, Text: ^BStr) -> HResult,
    TextPut:      proc "system" (this: ^InfoMsgIF, Text: BStr) -> HResult,
    PosInfoGet:   proc "system" (this: ^InfoMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing10:    proc "system" (this: ^InfoMsgIF) -> HResult,
    PosInfoPut:   proc "system" (this: ^InfoMsgIF, PosInfo: rawptr) -> HResult,
    ExtraInfoGet: proc "system" (this: ^InfoMsgIF, ExtraInfo: ^rawptr) -> HResult,
    Missing13:    proc "system" (this: ^InfoMsgIF) -> HResult,
    ExtraInfoPut: proc "system" (this: ^InfoMsgIF, ExtraInfo: rawptr) -> HResult,
}

infomsg_text_get :: proc(infomsg: InfoMsg) -> (text: string, ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^InfoMsgIF)(infomsg)->TextGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

infomsg_text_set :: proc(infomsg: InfoMsg, text: string) -> (ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    bs := to_bstr(text)
    defer bstr_free(bs)
    hr := (^InfoMsgIF)(infomsg)->TextPut(bs)
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

infomsg_extrainfo_get :: proc(infomsg: InfoMsg) -> (extrainfo: ExtraInfo, ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoGet(cast(^rawptr)&extrainfo)
    if com_failed(hr) do return

    return extrainfo, true
}

infomsg_extrainfo_set :: proc(infomsg: InfoMsg, extrainfo: ExtraInfo) -> (ok: bool) {
    if infomsg == nil do return
    if !com_connected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoPut(extrainfo)
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
    TextGet:    proc "system" (this: ^FindMsgIF, Text: ^BStr) -> HResult,
    TextPut:    proc "system" (this: ^FindMsgIF, Text: BStr) -> HResult,
    PosInfoGet: proc "system" (this: ^FindMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing10:  proc "system" (this: ^FindMsgIF) -> HResult,
    PosInfoPut: proc "system" (this: ^FindMsgIF, PosInfo: rawptr) -> HResult,
}

findmsg_text_get :: proc(findmsg: FindMsg) -> (text: string, ok: bool) {
    if findmsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FindMsgIF)(findmsg)->TextGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

findmsg_text_set :: proc(findmsg: FindMsg, text: string) -> (ok: bool) {
    if findmsg == nil do return
    if !com_connected() do return

    bs := to_bstr(text)
    defer bstr_free(bs)
    hr := (^FindMsgIF)(findmsg)->TextPut(bs)
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
    TextGet:      proc "system" (this: ^ErrorMsgIF, Text: ^BStr) -> HResult,
    TextPut:      proc "system" (this: ^ErrorMsgIF, Text: BStr) -> HResult,
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

errormsg_text_get :: proc(errormsg: ErrorMsg) -> (text: string, ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ErrorMsgIF)(errormsg)->TextGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

errormsg_text_set :: proc(errormsg: ErrorMsg, text: string) -> (ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    bs := to_bstr(text)
    defer bstr_free(bs)
    hr := (^ErrorMsgIF)(errormsg)->TextPut(bs)
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

errormsg_extrainfo_get :: proc(errormsg: ErrorMsg) -> (extrainfo: ExtraInfo, ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoGet(cast(^rawptr)&extrainfo)
    if com_failed(hr) do return

    return extrainfo, true
}

errormsg_extrainfo_set :: proc(errormsg: ErrorMsg, extrainfo: ExtraInfo) -> (ok: bool) {
    if errormsg == nil do return
    if !com_connected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoPut(extrainfo)
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

    result.jump_destination, ok = jump_destination(extrainfo)
    if !ok do return
    result.var_name, ok = var_name(extrainfo)
    if !ok do return
    result.function_name, ok = function_name(extrainfo)
    if !ok do return
    result.expected_type, ok = expected_type(extrainfo)
    if !ok do return
    result.traverse_no, ok = traverse_number(extrainfo)
    if !ok do return

    return result, true
}
