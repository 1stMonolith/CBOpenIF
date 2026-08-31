package cbopenif

import "com"

MessageTypeKind :: enum i32
{
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

MessageKind :: enum i32
{
    Error,
    Warning,
    Info,
    Find,
}

Message :: struct
{
    kind:    MessageKind,
    text:    string,
    error:   i32,
    warning: i32,
    pos:     MessagePosInfo,
    extra:   MessageExtraInfo,
}

MessagePosInfo :: struct
{
    fou:     string,
    pou:     string,
    element: string,
    tab:     string,
    page:    i32,
    row:     i32,
    column:  i32,
    start:   i32,
    end:     i32,
    id:      string,
    type:    MessageTypeKind,
}

MessageExtraInfo :: struct
{
    destination: string,
    var:         string,
    function:    string,
    expected:    string,
    traverse:    i32,
}

MessageBucket :: struct
{
    messages: [dynamic]Message,
}

MessagesFromCom :: proc(commsgbucket: com.MsgBucket, messages: ^[dynamic]Message) -> (ok: bool)
{
    if commsgbucket == nil do return

    count: i32
    count, ok = com.MsgCount(commsgbucket)
    if !ok do return

    for i in 0..<count {
        comimsg: com.IMsg
        comimsg, ok = com.GetMsgAtIndex(commsgbucket, i)
        if !ok do return
        defer com.Release(comimsg)

        commsg: com.Msg
        commsg, ok = com.FromIMsg(comimsg)
        if !ok do return
        defer com.Release(commsg)

        message: Message
        message, ok = MessageFromCom(commsg)
        if !ok do return
        append(messages, message)
    }

    return true
}

MessageFromCom :: proc(commsg: com.Msg) -> (message: Message, ok: bool)
{
    if commsg == nil do return

    message.text, ok = com.MsgText(commsg)
    if !ok do return

    composinfo: com.PosInfo
    composinfo, ok = com.GetPosInfo(commsg)
    if !ok do return
    defer com.Release(composinfo)
    message.pos, ok = PosInfoFromCom(composinfo)
    if !ok do return

    switch msg in commsg {
        case com.ErrorMsg:
            message.kind = .Error
            message.error, ok = com.GetErrorMsgNumber(msg)
            if !ok do return
            
            comextrainfo: com.ExtraInfo
            comextrainfo, ok = com.GetExtraInfo(msg)
            if !ok do return
            defer com.Release(comextrainfo)
            
            message.extra, ok = ExtraInfoFromCom(comextrainfo)
            if !ok do return

        case com.WarningMsg:
            message.kind = .Warning
            message.warning, ok = com.GetWarningMsgNumber(msg)
            if !ok do return
            
            comextrainfo: com.ExtraInfo
            comextrainfo, ok = com.GetExtraInfo(msg)
            if !ok do return
            defer com.Release(comextrainfo)
            
            message.extra, ok = ExtraInfoFromCom(comextrainfo)
            if !ok do return

        case com.InfoMsg:
            message.kind = .Info
            comextrainfo: com.ExtraInfo
            comextrainfo, ok = com.GetExtraInfo(msg)
            if !ok do return
            defer com.Release(comextrainfo)
            
            message.extra, ok = ExtraInfoFromCom(comextrainfo)
            if !ok do return

        case com.FindMsg:
            message.kind = .Find
    }

    return message, true
}

ExtraInfoFromCom :: proc(comextrainfo: com.ExtraInfo) -> (extrainfo: MessageExtraInfo, ok: bool)
{
    if comextrainfo == nil do return

    extrainfo.destination, ok = com.JumpDestination(comextrainfo)
    if !ok do return

    extrainfo.var, ok = com.VarName(comextrainfo)
    if !ok do return

    extrainfo.function, ok = com.FunctionName(comextrainfo)
    if !ok do return

    extrainfo.expected, ok = com.ExpectedType(comextrainfo)
    if !ok do return

    extrainfo.traverse, ok = com.TraverseNumber(comextrainfo)
    if !ok do return

    return extrainfo, true
}

PosInfoFromCom :: proc(composinfo: com.PosInfo) -> (posinfo: MessagePosInfo, ok: bool)
{
    if composinfo == nil do return

    posinfo.fou, ok = com.FOUName(composinfo)
    if !ok do return

    posinfo.pou, ok = com.POUName(composinfo)
    if !ok do return

    posinfo.element, ok = com.ElementName(composinfo)
    if !ok do return

    posinfo.tab, ok = com.TabName(composinfo)
    if !ok do return

    posinfo.page, ok = com.PageNumber(composinfo)
    if !ok do return

    posinfo.row, ok = com.Row(composinfo)
    if !ok do return

    posinfo.column, ok = com.Column(composinfo)
    if !ok do return

    posinfo.start, ok = com.StartPosition(composinfo)
    if !ok do return

    posinfo.end, ok = com.EndPosition(composinfo)
    if !ok do return

    posinfo.id, ok = com.ID(composinfo)
    if !ok do return

    type: i32
    type, ok = com.MsgType(composinfo)
    if !ok do return
    posinfo.type = MessageTypeKind(type)

    return posinfo, true
}
