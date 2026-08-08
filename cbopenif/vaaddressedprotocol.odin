package cbopenif

VAAddressedProtocol :: distinct rawptr

VAAddressedProtocolIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAAddressedProtocolVTable,
}

VAAddressedProtocolVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^VAAddressedProtocolIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^VAAddressedProtocolIF, Name: BStr) -> HResult,
    Missing9:  proc "system" (this: ^VAAddressedProtocolIF) -> HResult,
    Missing10: proc "system" (this: ^VAAddressedProtocolIF) -> HResult,
    Missing11: proc "system" (this: ^VAAddressedProtocolIF) -> HResult,
    Add:       proc "system" (this: ^VAAddressedProtocolIF, VAAddressedVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^VAAddressedProtocolIF, VAAddressedVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^VAAddressedProtocolIF, Name, Path: BStr, VAAddressedVariable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^VAAddressedProtocolIF, Name, Path: BStr, Row: i32, VAAddressedVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^VAAddressedProtocolIF, Name: BStr, VAAddressedVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^VAAddressedProtocolIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^VAAddressedProtocolIF, Index: i32, VAAddressedVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^VAAddressedProtocolIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^VAAddressedProtocolIF, Index: i32) -> HResult,
}

vaaddressedprotocol_new :: proc(name: string) -> (vaaddressedprotocol: VAAddressedProtocol, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewVAAddressedProtocol(bstr_name, cast(^rawptr)&vaaddressedprotocol)
    if com_failed(hr) do return

    return vaaddressedprotocol, true
}

vaaddressedprotocol_name :: proc {
    vaaddressedprotocol_name_get,
    vaaddressedprotocol_name_set,
}

vaaddressedprotocol_name_get :: proc(vaaddressedprotocol: VAAddressedProtocol) -> (name: string, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedprotocol_name_set :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_add :: proc {
    vaaddressedprotocol_vaaddressedvariable_add_,
    vaaddressedprotocol_vaaddressedvariable_add_at_index,
}

vaaddressedprotocol_vaaddressedvariable_add_ :: proc(vaaddressedprotocol: VAAddressedProtocol, vaaddressedvariable: VAAddressedVariable) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if vaaddressedvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Add(vaaddressedvariable)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_add_at_index :: proc(vaaddressedprotocol: VAAddressedProtocol, vaaddressedvariable: VAAddressedVariable, index: i32) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if vaaddressedvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->AddBefore(vaaddressedvariable, index)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable :: proc {
    vaaddressedprotocol_vaaddressedvariable_by_name,
    vaaddressedprotocol_vaaddressedvariable_by_index,
}

vaaddressedprotocol_vaaddressedvariable_by_name :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (vaaddressedvariable: VAAddressedVariable, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Find(bstr_name, cast(^rawptr)&vaaddressedvariable)
    if com_failed(hr) do return

    return vaaddressedvariable, true
}

vaaddressedprotocol_vaaddressedvariable_by_index :: proc(vaaddressedprotocol: VAAddressedProtocol, index: i32) -> (vaaddressedvariable: VAAddressedVariable, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Item(index, cast(^rawptr)&vaaddressedvariable)
    if com_failed(hr) do return

    return vaaddressedvariable, true
}

vaaddressedprotocol_vaaddressedvariable_index :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (index: i32, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

vaaddressedprotocol_vaaddressedvariable_count :: proc(vaaddressedprotocol: VAAddressedProtocol) -> (count: i32, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

vaaddressedprotocol_vaaddressedvariable_remove :: proc {
    vaaddressedprotocol_vaaddressedvariable_remove_by_name,
    vaaddressedprotocol_vaaddressedvariable_remove_by_index,
}

vaaddressedprotocol_vaaddressedvariable_remove_by_name :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = vaaddressedprotocol_vaaddressedvariable_index(vaaddressedprotocol, name)
    if !ok do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Remove(index)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_remove_by_index :: proc(vaaddressedprotocol: VAAddressedProtocol, index: i32) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Remove(index)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_release :: proc(vaaddressedprotocol: VAAddressedProtocol) {
    if vaaddressedprotocol != nil {
        (^VAAddressedProtocolIF)(vaaddressedprotocol)->Release()
    }
}
