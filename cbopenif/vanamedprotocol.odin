package cbopenif

VANamedProtocol :: distinct rawptr

VANamedProtocolIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VANamedProtocolVTable,
}

VANamedProtocolVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:   proc "system" (this: ^VANamedProtocolIF, Name: ^BStr) -> HResult,
    NamePut:   proc "system" (this: ^VANamedProtocolIF, Name: BStr) -> HResult,
    Missing9:  proc "system" (this: ^VANamedProtocolIF) -> HResult,
    Missing10: proc "system" (this: ^VANamedProtocolIF) -> HResult,
    Missing11: proc "system" (this: ^VANamedProtocolIF) -> HResult,
    Add:       proc "system" (this: ^VANamedProtocolIF, VANamedVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^VANamedProtocolIF, VANamedVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^VANamedProtocolIF, Name, Path: BStr, VANamedVariable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^VANamedProtocolIF, Name, Path, VAAttribute: BStr, Row: i32, VANamedVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^VANamedProtocolIF, Name: BStr, VANamedVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^VANamedProtocolIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^VANamedProtocolIF, Index: i32, VANamedVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^VANamedProtocolIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^VANamedProtocolIF, Index: i32) -> HResult,
}

vanamedprotocol_new :: proc(name: string) -> (vanamedprotocol: VANamedProtocol, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewVANamedProtocol(bstr_name, cast(^rawptr)&vanamedprotocol)
    if com_failed(hr) do return

    return vanamedprotocol, true
}

vanamedprotocol_name :: proc {
    vanamedprotocol_name_get,
    vanamedprotocol_name_set,
}

vanamedprotocol_name_get :: proc(vanamedprotocol: VANamedProtocol) -> (name: string, ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedprotocol_name_set :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanammedvariable_add :: proc {
    vanamedprotocol_vanammedvariable_add_,
    vanamedprotocol_vanammedvariable_add_at_index,
}

vanamedprotocol_vanammedvariable_add_ :: proc(vanamedprotocol: VANamedProtocol, vanammedvariable: VANamedVariable) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if vanammedvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Add(vanammedvariable)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanammedvariable_add_at_index :: proc(vanamedprotocol: VANamedProtocol, vanammedvariable: VANamedVariable, index: i32) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if vanammedvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->AddBefore(vanammedvariable, index)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanamedvariable :: proc {
    vanamedprotocol_vanamedvariable_by_name,
    vanamedprotocol_vanamedvariable_by_index,
}

vanamedprotocol_vanamedvariable_by_name :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (vanammedvariable: VANamedVariable, ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->Find(bstr_name, cast(^rawptr)&vanammedvariable)
    if com_failed(hr) do return

    return vanammedvariable, true
}

vanamedprotocol_vanamedvariable_by_index :: proc(vanamedprotocol: VANamedProtocol, index: i32) -> (vanammedvariable: VANamedVariable, ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Item(index, cast(^rawptr)&vanammedvariable)
    if com_failed(hr) do return

    return vanammedvariable, true
}

vanamedprotocol_vanamedvariable_index :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (index: i32, ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

vanamedprotocol_vanamedvariable_count :: proc(vanamedprotocol: VANamedProtocol) -> (count: i32, ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

vanamedprotocol_vanamedvariable_remove :: proc {
    vanamedprotocol_vanamedvariable_remove_by_name,
    vanamedprotocol_vanamedvariable_remove_by_index,
}

vanamedprotocol_vanamedvariable_remove_by_name :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = vanamedprotocol_vanamedvariable_index(vanamedprotocol, name)
    if !ok do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Remove(index)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanamedvariable_remove_by_index :: proc(vanamedprotocol: VANamedProtocol, index: i32) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if !controlbuilder_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Remove(index)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_release :: proc(vanamedprotocol: VANamedProtocol) {
    if vanamedprotocol != nil {
        (^VANamedProtocolIF)(vanamedprotocol)->Release()
    }
}
