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

IMsgIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IMsgVTable,
}

IMsgVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    TextGet:      proc "system" (this: ^IMsgIF, Text: ^BStr) -> HResult,
    TextPut:      proc "system" (this: ^IMsgIF, Text: BStr) -> HResult,
    IsErrorMsg:   proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
    IsWarningMsg: proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
    IsInfoMsg:    proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
    IsFindMsg:    proc "system" (this: ^IMsgIF, Is: ^VariantBool) -> HResult,
}

IsErrorMsg :: proc(imsg: IMsg) -> (is_error: bool, ok: bool)
{
    if imsg == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsErrorMsg(&vb)
    if ComFailed(hr) do return

    return vb == VariantBoolTrue, true
}

AsErrorMsg :: proc(imsg: IMsg) -> (errormsg: ErrorMsg, ok: bool)
{
    if imsg == nil do return
    
    IID := IID_ErrorMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&errormsg)
    if ComFailed(hr) do return
    
    return errormsg, true
}

IsWarningMsg :: proc(imsg: IMsg) -> (is_warning: bool, ok: bool)
{
    if imsg == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsWarningMsg(&vb)
    if ComFailed(hr) do return

    return vb == VariantBoolTrue, true
}

AsWarningMsg :: proc(imsg: IMsg) -> (warningmsg: WarningMsg, ok: bool)
{
    if imsg == nil do return
    
    IID := IID_WarningMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&warningmsg)
    if ComFailed(hr) do return
    
    return warningmsg, true
}

IsInfoMsg :: proc(imsg: IMsg) -> (is_info: bool, ok: bool)
{
    if imsg == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsInfoMsg(&vb)
    if ComFailed(hr) do return

    return vb == VariantBoolTrue, true
}

AsInfoMsg :: proc(imsg: IMsg) -> (infomsg: InfoMsg, ok: bool)
{
    if imsg == nil do return
    
    IID := IID_InfoMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&infomsg)
    if ComFailed(hr) do return
    
    return infomsg, true
}

IsFindMsg :: proc(imsg: IMsg) -> (is_find: bool, ok: bool)
{
    if imsg == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^IMsgIF)(imsg)->IsFindMsg(&vb)
    if ComFailed(hr) do return

    return vb == VariantBoolTrue, true
}

AsFindMsg :: proc(imsg: IMsg) -> (findmsg: FindMsg, ok: bool)
{
    if imsg == nil do return
    
    IID := IID_FindMsg
    hr := (^IUnknownIF)(imsg)->QueryInterface(&IID, cast(^rawptr)&findmsg)
    if ComFailed(hr) do return
    
    return findmsg, true
}

ReleaseIMsg :: proc(imsg: IMsg) {
    if imsg != nil {
        (^IMsgIF)(imsg)->Release()
    }
}

FromIMsg :: proc(imsg: IMsg) -> (msg: Msg, ok: bool)
{
    if imsg == nil do return
    
    is: bool

    is, ok = IsErrorMsg(imsg)
    if ok && is {
        e, okas := AsErrorMsg(imsg)
        if !okas do return
        return e, true
    }

    is, ok = IsWarningMsg(imsg)
    if ok && is {
        w, okas := AsWarningMsg(imsg)
        if !okas do return
        return w, true
    }

    is, ok = IsInfoMsg(imsg)
    if ok && is {
        i, okas := AsInfoMsg(imsg)
        if !okas do return
        return i, true
    }

    is, ok = IsFindMsg(imsg)
    if ok && is {
        f, okas := AsFindMsg(imsg)
        if !okas do return
        return f, true
    }

    return {}, false
}

GetMsgText :: proc(msg: Msg) -> (text: string, ok: bool)
{
    switch m in msg {
        case ErrorMsg:   return GetErrorMsgText(m)
        case WarningMsg: return GetWarningMsgText(m)
        case InfoMsg:    return GetInfoMsgText(m)
        case FindMsg:    return GetFindMsgText(m)
    }
    return
}

SetMsgText :: proc(msg: Msg, text: string) -> (ok: bool)
{
    switch m in msg {
        case ErrorMsg:   return SetErrorMsgText(m, text)
        case WarningMsg: return SetWarningMsgText(m, text)
        case InfoMsg:    return SetInfoMsgText(m, text)
        case FindMsg:    return SetFindMsgText(m, text)
    }
    return
}

GetMsgPosInfo :: proc(msg: Msg) -> (posinfo: PosInfo, ok: bool)
{
    switch m in msg {
        case ErrorMsg:   return GetErrorMsgPosInfo(m)
        case WarningMsg: return GetWarningMsgPosInfo(m)
        case InfoMsg:    return GetInfoMsgPosInfo(m)
        case FindMsg:    return GetFindMsgPosInfo(m)
    }
    return
}

ReleaseMsg :: proc(msg: Msg) {
    switch m in msg {
        case ErrorMsg:   ReleaseErrorMsg(m)
        case WarningMsg: ReleaseWarningMsg(m)
        case InfoMsg:    ReleaseInfoMsg(m)
        case FindMsg:    ReleaseFindMsg(m)
    }
}

MsgBucketIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^MsgBucketVTable,
}

MsgBucketVTable :: struct
{
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

SerializeMsgBucket :: proc(bucket: MsgBucket) -> (xml: string, ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^MsgBucketIF)(bucket)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetMsgBucketNumberOfErrors :: proc(bucket: MsgBucket) -> (count: i32, ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfErrorsGet(&count)
    if ComFailed(hr) do return

    return count, true
}

SetMsgBucketNumberOfErrors :: proc(bucket: MsgBucket, count: i32) -> (ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfErrorsPut(count)
    if ComFailed(hr) do return

    return true
}

GetMsgBucketNumberOfWarnings :: proc(bucket: MsgBucket) -> (count: i32, ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfWarningsGet(&count)
    if ComFailed(hr) do return

    return count, true
}

SetMsgBucketNumberOfWarnings :: proc(bucket: MsgBucket, count: i32) -> (ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->NoOfWarningsPut(count)
    if ComFailed(hr) do return

    return true
}

AddMsg :: proc(bucket: MsgBucket, imsg: IMsg) -> (ok: bool)
{
    if bucket == nil do return
    if imsg == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->Add(imsg)
    if ComFailed(hr) do return

    return true
}

GetMsgAtIndex :: proc(bucket: MsgBucket, index: i32) -> (imsg: IMsg, ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->Item(index + 1, cast(^rawptr)&imsg)
    if ComFailed(hr) do return

    return imsg, true
}

MsgCount :: proc(bucket: MsgBucket) -> (count: i32, ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveMsg :: proc(bucket: MsgBucket, index: i32) -> (ok: bool)
{
    if bucket == nil do return
    if !ComConnected() do return

    hr := (^MsgBucketIF)(bucket)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseMsgBucket :: proc(bucket: MsgBucket) {
    if bucket != nil {
        (^MsgBucketIF)(bucket)->Release()
    }
}

WarningMsgIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^WarningMsgVTable,
}

WarningMsgVTable :: struct
{
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

GetWarningMsgNumber :: proc(warningmsg: WarningMsg) -> (warning_number: i32, ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    hr := (^WarningMsgIF)(warningmsg)->WarningNoGet(&warning_number)
    if ComFailed(hr) do return

    return warning_number, true
}

SetWarningMsgNumber :: proc(warningmsg: WarningMsg, warning_number: i32) -> (ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    hr := (^WarningMsgIF)(warningmsg)->WarningNoPut(warning_number)
    if ComFailed(hr) do return

    return true
}

GetWarningMsgText :: proc(warningmsg: WarningMsg) -> (text: string, ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^WarningMsgIF)(warningmsg)->TextGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetWarningMsgText :: proc(warningmsg: WarningMsg, text: string) -> (ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    bs := ToBstr(text)
    defer FreeBstr(bs)
    hr := (^WarningMsgIF)(warningmsg)->TextPut(bs)
    if ComFailed(hr) do return

    return true
}

GetWarningMsgPosInfo :: proc(warningmsg: WarningMsg) -> (posinfo: PosInfo, ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    hr := (^WarningMsgIF)(warningmsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if ComFailed(hr) do return

    return posinfo, true
}

SetWarningMsgPosInfo :: proc(warningmsg: WarningMsg, posinfo: PosInfo) -> (ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    hr := (^WarningMsgIF)(warningmsg)->PosInfoPut(posinfo)
    if ComFailed(hr) do return

    return true
}

GetWarningMsgExtraInfo :: proc(warningmsg: WarningMsg) -> (extrainfo: ExtraInfo, ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoGet(cast(^rawptr)&extrainfo)
    if ComFailed(hr) do return

    return extrainfo, true
}

SetWarningMsgExtraInfo :: proc(warningmsg: WarningMsg, extrainfo: ExtraInfo) -> (ok: bool)
{
    if warningmsg == nil do return
    if !ComConnected() do return

    hr := (^WarningMsgIF)(warningmsg)->ExtraInfoPut(extrainfo)
    if ComFailed(hr) do return

    return true
}

ReleaseWarningMsg :: proc(warningmsg: WarningMsg) {
    if warningmsg != nil {
        (^WarningMsgIF)(warningmsg)->Release()
    }
}

InfoMsgIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^InfoMsgVTable,
}

InfoMsgVTable :: struct
{
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

GetInfoMsgText :: proc(infomsg: InfoMsg) -> (text: string, ok: bool)
{
    if infomsg == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^InfoMsgIF)(infomsg)->TextGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetInfoMsgText :: proc(infomsg: InfoMsg, text: string) -> (ok: bool)
{
    if infomsg == nil do return
    if !ComConnected() do return

    bs := ToBstr(text)
    defer FreeBstr(bs)
    hr := (^InfoMsgIF)(infomsg)->TextPut(bs)
    if ComFailed(hr) do return

    return true
}

GetInfoMsgPosInfo :: proc(infomsg: InfoMsg) -> (posinfo: PosInfo, ok: bool)
{
    if infomsg == nil do return
    if !ComConnected() do return

    hr := (^InfoMsgIF)(infomsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if ComFailed(hr) do return

    return posinfo, true
}

SetInfoMsgPosInfo :: proc(infomsg: InfoMsg, posinfo: PosInfo) -> (ok: bool)
{
    if infomsg == nil do return
    if !ComConnected() do return

    hr := (^InfoMsgIF)(infomsg)->PosInfoPut(posinfo)
    if ComFailed(hr) do return

    return true
}

GetInfoMsgExtraInfo :: proc(infomsg: InfoMsg) -> (extrainfo: ExtraInfo, ok: bool)
{
    if infomsg == nil do return
    if !ComConnected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoGet(cast(^rawptr)&extrainfo)
    if ComFailed(hr) do return

    return extrainfo, true
}

SetInfoMsgExtraInfo :: proc(infomsg: InfoMsg, extrainfo: ExtraInfo) -> (ok: bool)
{
    if infomsg == nil do return
    if !ComConnected() do return

    hr := (^InfoMsgIF)(infomsg)->ExtraInfoPut(extrainfo)
    if ComFailed(hr) do return

    return true
}

ReleaseInfoMsg :: proc(infomsg: InfoMsg) {
    if infomsg != nil {
        (^InfoMsgIF)(infomsg)->Release()
    }
}

FindMsgIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FindMsgVTable,
}

FindMsgVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    TextGet:    proc "system" (this: ^FindMsgIF, Text: ^BStr) -> HResult,
    TextPut:    proc "system" (this: ^FindMsgIF, Text: BStr) -> HResult,
    PosInfoGet: proc "system" (this: ^FindMsgIF, PosInfo: ^rawptr) -> HResult,
    Missing10:  proc "system" (this: ^FindMsgIF) -> HResult,
    PosInfoPut: proc "system" (this: ^FindMsgIF, PosInfo: rawptr) -> HResult,
}

GetFindMsgText :: proc(findmsg: FindMsg) -> (text: string, ok: bool)
{
    if findmsg == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FindMsgIF)(findmsg)->TextGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFindMsgText :: proc(findmsg: FindMsg, text: string) -> (ok: bool)
{
    if findmsg == nil do return
    if !ComConnected() do return

    bs := ToBstr(text)
    defer FreeBstr(bs)
    hr := (^FindMsgIF)(findmsg)->TextPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFindMsgPosInfo :: proc(findmsg: FindMsg) -> (posinfo: PosInfo, ok: bool)
{
    if findmsg == nil do return
    if !ComConnected() do return

    hr := (^FindMsgIF)(findmsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if ComFailed(hr) do return

    return posinfo, true
}

SetFindMsgPosInfo :: proc(findmsg: FindMsg, posinfo: PosInfo) -> (ok: bool)
{
    if findmsg == nil do return
    if !ComConnected() do return

    hr := (^FindMsgIF)(findmsg)->PosInfoPut(posinfo)
    if ComFailed(hr) do return

    return true
}

ReleaseFindMsg :: proc(findmsg: FindMsg) {
    if findmsg != nil {
        (^FindMsgIF)(findmsg)->Release()
    }
}

ErrorMsgIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ErrorMsgVTable,
}

ErrorMsgVTable :: struct
{
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

GetErrorMsgNumber :: proc(errormsg: ErrorMsg) -> (error_no: i32, ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    hr := (^ErrorMsgIF)(errormsg)->ErrorNoGet(&error_no)
    if ComFailed(hr) do return

    return error_no, true
}

SetErrorMsgNumber :: proc(errormsg: ErrorMsg, error_no: i32) -> (ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    hr := (^ErrorMsgIF)(errormsg)->ErrorNoPut(error_no)
    if ComFailed(hr) do return

    return true
}

GetErrorMsgText :: proc(errormsg: ErrorMsg) -> (text: string, ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ErrorMsgIF)(errormsg)->TextGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetErrorMsgText :: proc(errormsg: ErrorMsg, text: string) -> (ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    bs := ToBstr(text)
    defer FreeBstr(bs)
    hr := (^ErrorMsgIF)(errormsg)->TextPut(bs)
    if ComFailed(hr) do return

    return true
}

GetErrorMsgPosInfo :: proc(errormsg: ErrorMsg) -> (posinfo: PosInfo, ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    hr := (^ErrorMsgIF)(errormsg)->PosInfoGet(cast(^rawptr)&posinfo)
    if ComFailed(hr) do return

    return posinfo, true
}

SetErrorMsgPosInfo :: proc(errormsg: ErrorMsg, posinfo: PosInfo) -> (ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    hr := (^ErrorMsgIF)(errormsg)->PosInfoPut(posinfo)
    if ComFailed(hr) do return

    return true
}

GetErrorMsgExtraInfo :: proc(errormsg: ErrorMsg) -> (extrainfo: ExtraInfo, ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoGet(cast(^rawptr)&extrainfo)
    if ComFailed(hr) do return

    return extrainfo, true
}

SetErrorMsgExtraInfo :: proc(errormsg: ErrorMsg, extrainfo: ExtraInfo) -> (ok: bool)
{
    if errormsg == nil do return
    if !ComConnected() do return

    hr := (^ErrorMsgIF)(errormsg)->ExtraInfoPut(extrainfo)
    if ComFailed(hr) do return

    return true
}

ReleaseErrorMsg :: proc(errormsg: ErrorMsg) {
    if errormsg != nil {
        (^ErrorMsgIF)(errormsg)->Release()
    }
}

ExtraInfoIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtraInfoVTable,
}

ExtraInfoVTable :: struct
{
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

GetExtraInfoJumpDestination :: proc(extrainfo: ExtraInfo) -> (jump_destination: string, ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtraInfoJumpDestination :: proc(extrainfo: ExtraInfo, jump_destination: string) -> (ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(jump_destination)
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestPut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtraInfoVarName :: proc(extrainfo: ExtraInfo) -> (var_name: string, ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtraInfoVarName :: proc(extrainfo: ExtraInfo, var_name: string) -> (ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(var_name)
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtraInfoFunctionName :: proc(extrainfo: ExtraInfo) -> (function_name: string, ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtraInfoFunctionName :: proc(extrainfo: ExtraInfo, function_name: string) -> (ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(function_name)
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtraInfoExpectedType :: proc(extrainfo: ExtraInfo) -> (expected_type: string, ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExtraInfoExpectedType :: proc(extrainfo: ExtraInfo, expected_type: string) -> (ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(expected_type)
    defer FreeBstr(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetExtraInfoTraverseNumber :: proc(extrainfo: ExtraInfo) -> (traverse_number: i32, ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoGet(&traverse_number)
    if ComFailed(hr) do return

    return traverse_number, true
}

SetExtraInfoTraverseNumber :: proc(extrainfo: ExtraInfo, traverse_number: i32) -> (ok: bool)
{
    if extrainfo == nil do return
    if !ComConnected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoPut(traverse_number)
    if ComFailed(hr) do return

    return true
}

ReleaseExtraInfo :: proc(extrainfo: ExtraInfo) {
    if extrainfo != nil {
        (^ExtraInfoIF)(extrainfo)->Release()
    }
}

PosInfoIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PosInfoVTable,
}

PosInfoVTable :: struct
{
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

GetPosInfoRow :: proc(posinfo: PosInfo) -> (row: i32, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->RowGet(&row)
    if ComFailed(hr) do return

    return row, true
}

SetPosInfoRow :: proc(posinfo: PosInfo, row: i32) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->RowPut(row)
    if ComFailed(hr) do return

    return true
}

GetPosInfoColumn :: proc(posinfo: PosInfo) -> (column: i32, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->ColGet(&column)
    if ComFailed(hr) do return

    return column, true
}

SetPosInfoColumn :: proc(posinfo: PosInfo, column: i32) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->ColPut(column)
    if ComFailed(hr) do return

    return true
}

GetPosInfoStartPosition :: proc(posinfo: PosInfo) -> (start_position: i32, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->StartPosGet(&start_position)
    if ComFailed(hr) do return

    return start_position, true
}

SetPosInfoStartPosition :: proc(posinfo: PosInfo, start_position: i32) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->StartPosPut(start_position)
    if ComFailed(hr) do return

    return true
}

GetPosInfoEndPosition :: proc(posinfo: PosInfo) -> (end_position: i32, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->EndPosGet(&end_position)
    if ComFailed(hr) do return

    return end_position, true
}

SetPosInfoEndPosition :: proc(posinfo: PosInfo, end_position: i32) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->EndPosPut(end_position)
    if ComFailed(hr) do return

    return true
}

GetPosInfoElementName :: proc(posinfo: PosInfo) -> (element_name: string, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->ElementNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetPosInfoElementName :: proc(posinfo: PosInfo, element_name: string) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(element_name)
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->ElementNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetPosInfoFOUName :: proc(posinfo: PosInfo) -> (fou_name: string, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->FOUNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetPosInfoFOUName :: proc(posinfo: PosInfo, fou_name: string) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(fou_name)
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->FOUNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetPosInfoPOUName :: proc(posinfo: PosInfo) -> (pou_name: string, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->POUNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetPosInfoPOUName :: proc(posinfo: PosInfo, pou_name: string) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(pou_name)
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->POUNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetPosInfoTabName :: proc(posinfo: PosInfo) -> (tab_name: string, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->TabNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetPosInfoTabName :: proc(posinfo: PosInfo, tab_name: string) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(tab_name)
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->TabNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetPosInfoMsgType :: proc(posinfo: PosInfo) -> (message_type: i32, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    mt: i32
    hr := (^PosInfoIF)(posinfo)->MessageTypeGet(&mt)
    if ComFailed(hr) do return

    return mt, true
}

SetPosInfoMsgType :: proc(posinfo: PosInfo, message_type: i32) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->MessageTypePut(message_type)
    if ComFailed(hr) do return

    return true
}

GetPosInfoPageNumber :: proc(posinfo: PosInfo) -> (page_number: i32, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->PageNoGet(&page_number)
    if ComFailed(hr) do return

    return page_number, true
}

SetPosInfoPageNumber :: proc(posinfo: PosInfo, page_number: i32) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    hr := (^PosInfoIF)(posinfo)->PageNoPut(page_number)
    if ComFailed(hr) do return

    return true
}

GetPosInfoID :: proc(posinfo: PosInfo) -> (id: string, ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->IdGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetPosInfoID :: proc(posinfo: PosInfo, id: string) -> (ok: bool)
{
    if posinfo == nil do return
    if !ComConnected() do return

    bs := ToBstr(id)
    defer FreeBstr(bs)
    hr := (^PosInfoIF)(posinfo)->IdPut(bs)
    if ComFailed(hr) do return

    return true
}

ReleasePosInfo :: proc(posinfo: PosInfo) {
    if posinfo != nil {
        (^PosInfoIF)(posinfo)->Release()
    }
}
