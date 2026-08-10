package cbopenif

MessageType :: enum i32 {
    UndefPOU      = 0,
    DataType      = 1,
    Function      = 2,
    FunctionBlock = 3,
    ModuleType    = 4,
    SingleModule  = 5,
    RootModule    = 6,
    ProgramType   = 7,
    SingleProgram = 8,
    HW            = 9,
    VarAccess     = 10,
    General       = 11,
    SingleDiagram = 12,
    DiagramType   = 13,
    Other         = 14,
}

IMessage :: distinct rawptr
MessageBucket :: distinct rawptr
WarningMsg :: distinct rawptr
InfoMsg :: distinct rawptr
FindMsg :: distinct rawptr
ErrorMsg :: distinct rawptr
ExtraInfo :: distinct rawptr

IMessageIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IMessageVTable,
}

IMessageVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    MessageGet:       proc "system" (this: ^IMessageIF, Message: ^BStr) -> HResult,
    MessagePut:       proc "system" (this: ^IMessageIF, Message: BStr) -> HResult,
    IsErrorMessage:   proc "system" (this: ^IMessageIF, IsErrorMessage: ^VariantBool) -> HResult,
    IsWarningMessage: proc "system" (this: ^IMessageIF, IsWarningMessage: ^VariantBool) -> HResult,
    IsInfoMessage:    proc "system" (this: ^IMessageIF, IsInfoMessage: ^VariantBool) -> HResult,
    IsFindMessage:    proc "system" (this: ^IMessageIF, IsFindMessage: ^VariantBool) -> HResult,
}

imessage_message :: proc {
    imessage_get,
    imessage_set,
}

imessage_get :: proc(imessage: IMessage) -> (msg: string, ok: bool) {
    if imessage == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^IMessageIF)(imessage)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

imessage_set :: proc(imessage: IMessage, msg: string) -> (ok: bool) {
    if imessage == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(msg)
    defer bstr_free(bs)
    hr := (^IMessageIF)(imessage)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

imessage_is_error :: proc(imessage: IMessage) -> (is_error: bool, ok: bool) {
    if imessage == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsErrorMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_is_warning :: proc(imessage: IMessage) -> (is_warning: bool, ok: bool) {
    if imessage == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsWarningMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_is_info :: proc(imessage: IMessage) -> (is_info: bool, ok: bool) {
    if imessage == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsInfoMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_is_find :: proc(imessage: IMessage) -> (is_find: bool, ok: bool) {
    if imessage == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^IMessageIF)(imessage)->IsFindMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

imessage_release :: proc(imessage: IMessage) {
    if imessage != nil {
        (^IMessageIF)(imessage)->Release()
    }
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

messagebucket_deserialize :: proc(xml: string) -> (bucket: MessageBucket, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeMessageBucket(&bs, cast(^rawptr)bucket)
    if com_failed(hr) do return

    return bucket, true
}

messagebucket_serialize :: proc(bucket: MessageBucket) -> (xml: string, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^MessageBucketIF)(bucket)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

messagebucket_number_of_errors :: proc {
    messagebucket_number_of_errors_get,
    messagebucket_number_of_errors_set,
}

messagebucket_number_of_errors_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsGet(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_number_of_errors_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsPut(count)
    if com_failed(hr) do return

    return true
}

messagebucket_number_of_warnings :: proc {
    messagebucket_number_of_warnings_get,
    messagebucket_number_of_warnings_set,
}

messagebucket_number_of_warnings_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsGet(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_number_of_warnings_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsPut(count)
    if com_failed(hr) do return

    return true
}

messagebucket_message_add :: proc(bucket: MessageBucket, imessage: IMessage) -> (ok: bool) {
    if bucket == nil do return
    if imessage == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Add(imessage)
    if com_failed(hr) do return

    return true
}

messagebucket_message_by_index :: proc(bucket: MessageBucket, index: i32) -> (imessage: IMessage, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Item(index + 1, cast(^rawptr)&imessage)
    if com_failed(hr) do return

    return imessage, true
}

messagebucket_message_count :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_message_remove_by_index :: proc(bucket: MessageBucket, index: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

messagebucket_release :: proc(bucket: MessageBucket) {
    if bucket != nil {
        (^MessageBucketIF)(bucket)->Release()
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

extrainfo_jump_destination :: proc {
    extrainfo_jump_destination_get,
    extrainfo_jump_destination_set,
}

extrainfo_jump_destination_get :: proc(extrainfo: ExtraInfo) -> (jump_destination: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_jump_destination_set :: proc(extrainfo: ExtraInfo, jump_destination: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(jump_destination)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->JumpDestPut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_var_name :: proc {
    extrainfo_var_name_get,
    extrainfo_var_name_set,
}

extrainfo_var_name_get :: proc(extrainfo: ExtraInfo) -> (var_name: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_var_name_set :: proc(extrainfo: ExtraInfo, var_name: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(var_name)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->VarNamePut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_function_name :: proc {
    extrainfo_function_name_get,
    extrainfo_function_name_set,
}

extrainfo_function_name_get :: proc(extrainfo: ExtraInfo) -> (function_name: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_function_name_set :: proc(extrainfo: ExtraInfo, function_name: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(function_name)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->FunctionNamePut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_expected_type :: proc {
    extrainfo_expected_type_get,
    extrainfo_expected_type_set,
}

extrainfo_expected_type_get :: proc(extrainfo: ExtraInfo) -> (expected_type: string, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

extrainfo_expected_type_set :: proc(extrainfo: ExtraInfo, expected_type: string) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(expected_type)
    defer bstr_free(bs)
    hr := (^ExtraInfoIF)(extrainfo)->ExpectedTypePut(bs)
    if com_failed(hr) do return

    return true
}

extrainfo_traverse_number :: proc {
    extrainfo_traverse_number_get,
    extrainfo_traverse_number_set,
}

extrainfo_traverse_number_get :: proc(extrainfo: ExtraInfo) -> (traverse_number: i32, ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoGet(&traverse_number)
    if com_failed(hr) do return

    return traverse_number, true
}

extrainfo_traverse_number_set :: proc(extrainfo: ExtraInfo, traverse_number: i32) -> (ok: bool) {
    if extrainfo == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtraInfoIF)(extrainfo)->TraverseNoPut(traverse_number)
    if com_failed(hr) do return

    return true
}

extrainfo_release :: proc(extrainfo: ExtraInfo) {
    if extrainfo != nil {
        (^ExtraInfoIF)(extrainfo)->Release()
    }
}
