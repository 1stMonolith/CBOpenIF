package cbopenif

import "com"

MessageTypeKind :: enum i32 {
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

MessageKind :: enum i32 {
    Error,
    Warning,
    Info,
    Find,
}

Message :: struct {
    kind:           MessageKind,
    text:           string,
    error_number:   i32,
    warning_number: i32,
    pos_info:       MessagePosInfo,
    extra_info:     MessageExtraInfo,
}

MessagePosInfo :: struct {
    fou_name:       string,
    pou_name:       string,
    element_name:   string,
    tab_name:       string,
    page_number:    i32,
    row:            i32,
    column:         i32,
    start_position: i32,
    end_position:   i32,
    id:             string,
    message_type:   MessageTypeKind,
}

MessageExtraInfo :: struct {
    jump_destination: string,
    var_name:         string,
    function_name:    string,
    expected_type:    string,
    traverse_no:      i32,
}

MessageBucket :: struct {
    messages: [dynamic]Message,
}

message_from_com :: proc(msg: Msg, allocator := context.allocator) -> (result: t.Message, ok: bool) {
    context.allocator = allocator

    result.text, ok = message_text(msg)
    if !ok do return

    pi: PosInfo
    pi, ok = posinfo(msg)
    if !ok do return
    defer release(pi)
    result.pos_info, ok = posinfo_from_com(pi)
    if !ok do return

    switch m in msg {
        case ErrorMsg:
            result.kind = .Error
            result.error_number, ok = error_number(m)
            if !ok do return
            
            ei: ExtraInfo
            ei, ok = extrainfo(m)
            if !ok do return
            defer release(ei)
            
            result.extra_info, ok = extrainfo_from_com(ei)
            if !ok do return

        case WarningMsg:
            result.kind = .Warning
            result.warning_number, ok = warning_number(m)
            if !ok do return
            
            ei: ExtraInfo
            ei, ok = extrainfo(m)
            if !ok do return
            defer release(ei)
            
            result.extra_info, ok = extrainfo_from_com(ei)
            if !ok do return

        case InfoMsg:
            result.kind = .Info
            ei: ExtraInfo
            ei, ok = extrainfo(m)
            if !ok do return
            defer release(ei)
            
            result.extra_info, ok = extrainfo_from_com(ei)
            if !ok do return

        case FindMsg:
            result.kind = .Find
    }

    return result, true
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

extrainfo_from_com :: proc(extrainfo: ExtraInfo, allocator := context.allocator) -> (result: t.MessageExtraInfo, ok: bool) {
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

posinfo_from_com :: proc(posinfo: PosInfo, allocator := context.allocator) -> (result: t.MessagePosInfo, ok: bool) {
    if posinfo == nil do return

    context.allocator = allocator

    result.fou_name, ok = fou_name(posinfo)
    if !ok do return
    result.pou_name, ok = pou_name(posinfo)
    if !ok do return
    result.element_name, ok = element_name(posinfo)
    if !ok do return
    result.tab_name, ok = tab_name(posinfo)
    if !ok do return
    result.page_number, ok = page_number(posinfo)
    if !ok do return
    result.row, ok = row(posinfo)
    if !ok do return
    result.column, ok = column(posinfo)
    if !ok do return
    result.start_position, ok = start_position(posinfo)
    if !ok do return
    result.end_position, ok = end_position(posinfo)
    if !ok do return
    result.id, ok = id(posinfo)
    if !ok do return
    result.message_type, ok = message_type(posinfo)
    if !ok do return

    return result, true
}
