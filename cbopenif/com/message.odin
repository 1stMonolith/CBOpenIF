package com

IMsg       :: distinct rawptr
MsgBucket  :: distinct rawptr
WarningMsg :: distinct rawptr
InfoMsg    :: distinct rawptr
FindMsg    :: distinct rawptr
ErrorMsg   :: distinct rawptr
ExtraInfo  :: distinct rawptr
PosInfo    :: distinct rawptr

Msg :: union {
    ErrorMsg,
    WarningMsg,
    InfoMsg,
    FindMsg,
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

from_imsg :: proc(imsg: IMsg) -> (msg: Msg, ok: bool) {
    if imsg == nil do return
    
    is: bool

    is, ok = imsg_is_error(imsg)
    if ok && is {
        e, okas := imsg_as_error(imsg)
        if !okas do return
        return e, true
    }

    is, ok = imsg_is_warning(imsg)
    if ok && is {
        w, okas := imsg_as_warning(imsg)
        if !okas do return
        return w, true
    }

    is, ok = imsg_is_info(imsg)
    if ok && is {
        i, okas := imsg_as_info(imsg)
        if !okas do return
        return i, true
    }

    is, ok = imsg_is_find(imsg)
    if ok && is {
        f, okas := imsg_as_find(imsg)
        if !okas do return
        return f, true
    }

    return {}, false
}

message_text_get :: proc(msg: Msg) -> (text: string, ok: bool) {
    switch m in msg {
        case ErrorMsg:   return errormsg_text_get(m)
        case WarningMsg: return warningmsg_text_get(m)
        case InfoMsg:    return infomsg_text_get(m)
        case FindMsg:    return findmsg_text_get(m)
    }
    return
}

message_text_set :: proc(msg: Msg, text: string) -> (ok: bool) {
    switch m in msg {
        case ErrorMsg:   return errormsg_text_set(m, text)
        case WarningMsg: return warningmsg_text_set(m, text)
        case InfoMsg:    return infomsg_text_set(m, text)
        case FindMsg:    return findmsg_text_set(m, text)
    }
    return
}

message_posinfo_get :: proc(msg: Msg) -> (posinfo: PosInfo, ok: bool) {
    switch m in msg {
        case ErrorMsg:   return errormsg_posinfo_get(m)
        case WarningMsg: return warningmsg_posinfo_get(m)
        case InfoMsg:    return infomsg_posinfo_get(m)
        case FindMsg:    return findmsg_posinfo_get(m)
    }
    return
}

message_release :: proc(msg: Msg) {
    switch m in msg {
        case ErrorMsg:   errormsg_release(m)
        case WarningMsg: warningmsg_release(m)
        case InfoMsg:    infomsg_release(m)
        case FindMsg:    findmsg_release(m)
    }
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

PosInfoIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PosInfoVTable,
}

PosInfoVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    RowGet:         proc "system" (this: ^PosInfoIF, Row: ^i32) -> HResult,
    RowPut:         proc "system" (this: ^PosInfoIF, Row: i32) -> HResult,
    ColGet:         proc "system" (this: ^PosInfoIF, Col: ^i32) -> HResult,
    ColPut:         proc "system" (this: ^PosInfoIF, Col: i32) -> HResult,
    StartPosGet:    proc "system" (this: ^PosInfoIF, StartPos: ^i32) -> HResult,
    StartPosPut:    proc "system" (this: ^PosInfoIF, StartPos: i32) -> HResult,
    EndPosGet:      proc "system" (this: ^PosInfoIF, EndPos: ^i32) -> HResult,
    EndPosPut:      proc "system" (this: ^PosInfoIF, EndPos: i32) -> HResult,
    ElementNameGet: proc "system" (this: ^PosInfoIF, ElementName: ^BStr) -> HResult,
    ElementNamePut: proc "system" (this: ^PosInfoIF, ElementName: BStr) -> HResult,
    FOUNameGet:     proc "system" (this: ^PosInfoIF, FOUName: ^BStr) -> HResult,
    FOUNamePut:     proc "system" (this: ^PosInfoIF, FOUName: BStr) -> HResult,
    POUNameGet:     proc "system" (this: ^PosInfoIF, POUName: ^BStr) -> HResult,
    POUNamePut:     proc "system" (this: ^PosInfoIF, POUName: BStr) -> HResult,
    TabNameGet:     proc "system" (this: ^PosInfoIF, TabName: ^BStr) -> HResult,
    TabNamePut:     proc "system" (this: ^PosInfoIF, TabName: BStr) -> HResult,
    MessageTypeGet: proc "system" (this: ^PosInfoIF, MessageType: ^i32) -> HResult,
    MessageTypePut: proc "system" (this: ^PosInfoIF, MessageType: i32) -> HResult,
    PageNoGet:      proc "system" (this: ^PosInfoIF, PageNo: ^i32) -> HResult,
    PageNoPut:      proc "system" (this: ^PosInfoIF, PageNo: i32) -> HResult,
    IdGet:          proc "system" (this: ^PosInfoIF, Id: ^BStr) -> HResult,
    IdPut:          proc "system" (this: ^PosInfoIF, Id: BStr) -> HResult,
}

posinfo_row_get :: proc(posinfo: PosInfo) -> (row: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->RowGet(&row)
    if com_failed(hr) do return

    return row, true
}

posinfo_row_set :: proc(posinfo: PosInfo, row: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->RowPut(row)
    if com_failed(hr) do return

    return true
}

posinfo_column_get :: proc(posinfo: PosInfo) -> (column: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->ColGet(&column)
    if com_failed(hr) do return

    return column, true
}

posinfo_column_set :: proc(posinfo: PosInfo, column: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->ColPut(column)
    if com_failed(hr) do return

    return true
}

posinfo_start_position_get :: proc(posinfo: PosInfo) -> (start_position: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->StartPosGet(&start_position)
    if com_failed(hr) do return

    return start_position, true
}

posinfo_start_position_set :: proc(posinfo: PosInfo, start_position: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->StartPosPut(start_position)
    if com_failed(hr) do return

    return true
}

posinfo_end_position_get :: proc(posinfo: PosInfo) -> (end_position: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->EndPosGet(&end_position)
    if com_failed(hr) do return

    return end_position, true
}

posinfo_end_position_set :: proc(posinfo: PosInfo, end_position: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->EndPosPut(end_position)
    if com_failed(hr) do return

    return true
}

posinfo_element_name_get :: proc(posinfo: PosInfo) -> (element_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->ElementNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_element_name_set :: proc(posinfo: PosInfo, element_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(element_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->ElementNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_fou_name_get :: proc(posinfo: PosInfo) -> (fou_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->FOUNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_fou_name_set :: proc(posinfo: PosInfo, fou_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(fou_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->FOUNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_pou_name_get :: proc(posinfo: PosInfo) -> (pou_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->POUNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_pou_name_set :: proc(posinfo: PosInfo, pou_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(pou_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->POUNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_tab_name_get :: proc(posinfo: PosInfo) -> (tab_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->TabNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_tab_name_set :: proc(posinfo: PosInfo, tab_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(tab_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->TabNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_message_type_get :: proc(posinfo: PosInfo) -> (message_type: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    mt: i32
    hr := (^PosInfoIF)(posinfo)->MessageTypeGet(&mt)
    if com_failed(hr) do return

    return mt, true
}

posinfo_message_type_set :: proc(posinfo: PosInfo, message_type: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->MessageTypePut(message_type)
    if com_failed(hr) do return

    return true
}

posinfo_page_number_get :: proc(posinfo: PosInfo) -> (page_number: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->PageNoGet(&page_number)
    if com_failed(hr) do return

    return page_number, true
}

posinfo_page_number_set :: proc(posinfo: PosInfo, page_number: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->PageNoPut(page_number)
    if com_failed(hr) do return

    return true
}

posinfo_id_get :: proc(posinfo: PosInfo) -> (id: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->IdGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_id_set :: proc(posinfo: PosInfo, id: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(id)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->IdPut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_release :: proc(posinfo: PosInfo) {
    if posinfo != nil {
        (^PosInfoIF)(posinfo)->Release()
    }
}
