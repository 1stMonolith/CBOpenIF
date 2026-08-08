package cbopenif

IVAProtocol :: distinct rawptr

IVAProtocolIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IVAProtocolVTable,
}

IVAProtocolVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                 proc "system" (this: ^IVAProtocolIF, Name: ^BStr) -> HResult,
    NamePut:                 proc "system" (this: ^IVAProtocolIF, Name: BStr) -> HResult,
    IsVANamedProtocolGet:    proc "system" (this: ^IVAProtocolIF, IsVANamedProtocol: ^VariantBool) -> HResult,
    IsVAAddressedProtocolGet: proc "system" (this: ^IVAProtocolIF, IsVAAddressedProtocol: ^VariantBool) -> HResult,
}

ivaprotocol_name :: proc {
    ivaprotocol_name_get,
    ivaprotocol_name_set,
}

ivaprotocol_name_get :: proc(iva: IVAProtocol) -> (name: string, ok: bool) {
    if iva == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^IVAProtocolIF)(iva)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ivaprotocol_name_set :: proc(iva: IVAProtocol, name: string) -> (ok: bool) {
    if iva == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^IVAProtocolIF)(iva)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

ivaprotocol_is_vanamed_protocol_get :: proc(iva: IVAProtocol) -> (is_vanamed: bool, ok: bool) {
    if iva == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^IVAProtocolIF)(iva)->IsVANamedProtocolGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

ivaprotocol_is_vaaddressed_protocol_get :: proc(iva: IVAProtocol) -> (is_vaaddressed: bool, ok: bool) {
    if iva == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^IVAProtocolIF)(iva)->IsVAAddressedProtocolGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

ivaprotocol_release :: proc(iva: IVAProtocol) {
    if iva != nil {
        (^IVAProtocolIF)(iva)->Release()
    }
}
