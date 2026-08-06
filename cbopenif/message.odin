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

Message :: distinct rawptr

MessageIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^MessageVTable,
}

MessageVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    MessageGet:    proc "system" (this: ^MessageIF, Message: ^BStr) -> HResult,
    MessagePut:    proc "system" (this: ^MessageIF, Message: BStr) -> HResult,
    IsErrorMessage:    proc "system" (this: ^MessageIF, IsErrorMessage: ^VariantBool) -> HResult,
    IsWarningMessage:  proc "system" (this: ^MessageIF, IsWarningMessage: ^VariantBool) -> HResult,
    IsInfoMessage:     proc "system" (this: ^MessageIF, IsInfoMessage: ^VariantBool) -> HResult,
    IsFindMessage:     proc "system" (this: ^MessageIF, IsFindMessage: ^VariantBool) -> HResult,
}

message_message :: proc {
    message_get,
    message_set,
}

message_get :: proc(message: Message) -> (msg: string, ok: bool) {
    if message == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^MessageIF)(message)->MessageGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

message_set :: proc(message: Message, msg: string) -> (ok: bool) {
    if message == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(msg)
    defer bstr_free(bs)
    hr := (^MessageIF)(message)->MessagePut(bs)
    if com_failed(hr) do return

    return true
}

message_is_error :: proc(message: Message) -> (is_error: bool, ok: bool) {
    if message == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MessageIF)(message)->IsErrorMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

message_is_warning :: proc(message: Message) -> (is_warning: bool, ok: bool) {
    if message == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MessageIF)(message)->IsWarningMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

message_is_info :: proc(message: Message) -> (is_info: bool, ok: bool) {
    if message == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MessageIF)(message)->IsInfoMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

message_is_find :: proc(message: Message) -> (is_find: bool, ok: bool) {
    if message == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^MessageIF)(message)->IsFindMessage(&vb)
    if com_failed(hr) do return

    return vb == VariantBoolTrue, true
}

message_release :: proc(message: Message) {
    if message != nil {
        (^MessageIF)(message)->Release()
    }
}
