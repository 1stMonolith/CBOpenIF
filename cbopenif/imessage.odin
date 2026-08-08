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
