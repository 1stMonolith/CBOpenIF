package cbopenif

VAProtocols :: distinct rawptr

VAProtocolsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAProtocolsVTable,
}

VAProtocolsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    AddVANamedProtocol:      proc "system" (this: ^VAProtocolsIF, VANamedProtocol: rawptr) -> HResult,
    AddVANamedProtocol1:     proc "system" (this: ^VAProtocolsIF, Name: BStr, VANamedProtocol: ^rawptr) -> HResult,
    AddVAAddressedProtocol:  proc "system" (this: ^VAProtocolsIF, VAAddressedProtocol: rawptr) -> HResult,
    AddVAAddressedProtocol1: proc "system" (this: ^VAProtocolsIF, Name: BStr, VAAddressedProtocol: ^rawptr) -> HResult,
    Find:                    proc "system" (this: ^VAProtocolsIF, Name: BStr, IVAProtocol: ^rawptr) -> HResult,
    FindNr:                  proc "system" (this: ^VAProtocolsIF, Name: BStr, Index: ^i32) -> HResult,
    Add:                     proc "system" (this: ^VAProtocolsIF, IVAProtocol: rawptr) -> HResult,
    AddBefore:               proc "system" (this: ^VAProtocolsIF, IVAProtocol: rawptr, Index: i32) -> HResult,
    Item:                    proc "system" (this: ^VAProtocolsIF, Index: i32, IVAProtocol: ^rawptr) -> HResult,
    Count:                   proc "system" (this: ^VAProtocolsIF, Count: ^i32) -> HResult,
    Remove:                  proc "system" (this: ^VAProtocolsIF, Index: i32) -> HResult,
}

vaprotocols_add :: proc {
    vaprotocols_vanammedprotocol_add,
    vaprotocols_vaaddressedprotocol_add,
    vaprotocols_ivaprotocol_add,
    vaprotocols_ivaprotocol_add_at_index,
}

vaprotocols_vanammedprotocol_add :: proc(vaprotocols: VAProtocols, vanamedprotocol: VANamedProtocol) -> (ok: bool) {
    if vaprotocols == nil do return
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddVANamedProtocol(vanamedprotocol)
    if com_failed(hr) do return

    return true
}

vaprotocols_vaaddressedprotocol_add :: proc(vaprotocols: VAProtocols, vaaddressedprotocol: VAAddressedProtocol) -> (ok: bool) {
    if vaprotocols == nil do return
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddVAAddressedProtocol(vaaddressedprotocol)
    if com_failed(hr) do return

    return true
}

vaprotocols_ivaprotocol_add :: proc(vaprotocols: VAProtocols, ivaprotocol: IVAProtocol) -> (ok: bool) {
    if vaprotocols == nil do return
    if ivaprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Add(ivaprotocol)
    if com_failed(hr) do return

    return true
}

vaprotocols_ivaprotocol_add_at_index :: proc(vaprotocols: VAProtocols, ivaprotocol: IVAProtocol, index: i32) -> (ok: bool) {
    if vaprotocols == nil do return
    if ivaprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddBefore(ivaprotocol, index)
    if com_failed(hr) do return

    return true
}

vaprotocols_vaprotocol :: proc {
    vaprotocols_vaprotocol_by_name,
    vaprotocols_vaprotocol_by_index,
}

vaprotocols_vaprotocol_by_name :: proc(vaprotocols: VAProtocols, name: string) -> (iva: IVAProtocol, ok: bool) {
    if vaprotocols == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAProtocolsIF)(vaprotocols)->Find(bstr_name, cast(^rawptr)&iva)
    if com_failed(hr) do return

    return iva, true
}

vaprotocols_vaprotocol_by_index :: proc(vaprotocols: VAProtocols, index: i32) -> (iva: IVAProtocol, ok: bool) {
    if vaprotocols == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Item(index, cast(^rawptr)&iva)
    if com_failed(hr) do return

    return iva, true
}

vaprotocols_vaprotocol_index :: proc(vaprotocols: VAProtocols, name: string) -> (index: i32, ok: bool) {
    if vaprotocols == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAProtocolsIF)(vaprotocols)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

vaprotocols_vaprotocol_count :: proc(vaprotocols: VAProtocols) -> (count: i32, ok: bool) {
    if vaprotocols == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

vaprotocols_vaprotocol_remove :: proc {
    vaprotocols_vaprotocol_remove_by_name,
    vaprotocols_vaprotocol_remove_by_index,
}

vaprotocols_vaprotocol_remove_by_name :: proc(vaprotocols: VAProtocols, name: string) -> (ok: bool) {
    if vaprotocols == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = vaprotocols_vaprotocol_index(vaprotocols, name)
    if !ok do return

    hr := (^VAProtocolsIF)(vaprotocols)->Remove(index)
    if com_failed(hr) do return

    return true
}

vaprotocols_vaprotocol_remove_by_index :: proc(vaprotocols: VAProtocols, index: i32) -> (ok: bool) {
    if vaprotocols == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Remove(index)
    if com_failed(hr) do return

    return true
}

vaprotocols_release :: proc(vaprotocols: VAProtocols) {
    if vaprotocols != nil {
        (^VAProtocolsIF)(vaprotocols)->Release()
    }
}
