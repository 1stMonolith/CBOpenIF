package cbopenif

ExecutionInstance :: distinct rawptr

ExecutionInstanceIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExecutionInstanceVTable,
}

ExecutionInstanceVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet: proc "system" (this: ^ExecutionInstanceIF, Name: ^BStr) -> HResult,
    NamePut: proc "system" (this: ^ExecutionInstanceIF, Name: BStr) -> HResult,
}

executioninstance_new :: proc(name: string) -> (ei: ExecutionInstance, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewExecutionInstance(bstr_name, cast(^rawptr)&ei)
    if com_failed(hr) do return

    return ei, true
}

executioninstance_name :: proc {
    executioninstance_name_get,
    executioninstance_name_set,
}

executioninstance_name_get :: proc(ei: ExecutionInstance) -> (name: string, ok: bool) {
    if ei == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExecutionInstanceIF)(ei)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

executioninstance_name_set :: proc(ei: ExecutionInstance, name: string) -> (ok: bool) {
    if ei == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExecutionInstanceIF)(ei)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

executioninstance_release :: proc(ei: ExecutionInstance) {
    if ei != nil {
        (^ExecutionInstanceIF)(ei)->Release()
    }
}
