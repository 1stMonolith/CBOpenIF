package com

/*
AccessVariables                         ← top-level object (Serialize + owns the protocol list)
  └── VAProtocols                       ← collection of protocols
        │
        ├── IVAProtocol                 ← common base interface
        │     • Name
        │     • IsVANamedProtocol
        │     • IsVAAddressedProtocol
        │
        ├── VANamedProtocol
        │     └── VANamedVariable[]     ← Name, Path, VAAttribute, VAType, Row, VATypePath
        │
        └── VAAddressedProtocol
              └── VAAddressedVariable[] ← Name, Path, VAType, Row, VATypePath
*/

AccessVariables     :: distinct rawptr
IVAProtocol         :: distinct rawptr
VAAddressedProtocol :: distinct rawptr
VANamedProtocol     :: distinct rawptr
VAProtocols         :: distinct rawptr
VANamedVariable     :: distinct rawptr
VAAddressedVariable :: distinct rawptr

AccessVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^AccessVariablesVTable,
}

AccessVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    VAProtocolsGet: proc "system" (this: ^AccessVariablesIF, VAProtocols: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^AccessVariablesIF) -> HResult,
    VAProtocolsPut: proc "system" (this: ^AccessVariablesIF, VAProtocols: rawptr) -> HResult,
    Serialize:      proc "system" (this: ^AccessVariablesIF, XML: ^BStr) -> HResult,
}

accessvariables_serialize :: proc(av: AccessVariables) -> (xml: string, ok: bool) {
    if av == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^AccessVariablesIF)(av)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

accessvariables_vaprotocols_get :: proc(av: AccessVariables) -> (vaprotocols: VAProtocols, ok: bool) {
    if av == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^AccessVariablesIF)(av)->VAProtocolsGet(&p)
    if com_failed(hr) do return

    return VAProtocols(p), true
}

accessvariables_vaprotocols_set :: proc(av: AccessVariables, vaprotocols: VAProtocols) -> (ok: bool) {
    if av == nil do return
    if !com_connected() do return

    hr := (^AccessVariablesIF)(av)->VAProtocolsPut(vaprotocols)
    if com_failed(hr) do return

    return true
}

accessvariables_release :: proc(av: AccessVariables) {
    if av != nil {
        (^AccessVariablesIF)(av)->Release()
    }
}

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

ivaprotocol_name_get :: proc(iva: IVAProtocol) -> (name: string, ok: bool) {
    if iva == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^IVAProtocolIF)(iva)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

ivaprotocol_name_set :: proc(iva: IVAProtocol, name: string) -> (ok: bool) {
    if iva == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^IVAProtocolIF)(iva)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

ivaprotocol_is_vanamed_protocol_get :: proc(iva: IVAProtocol) -> (is_vanamed: bool, ok: bool) {
    if iva == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^IVAProtocolIF)(iva)->IsVANamedProtocolGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

ivaprotocol_is_vaaddressed_protocol_get :: proc(iva: IVAProtocol) -> (is_vaaddressed: bool, ok: bool) {
    if iva == nil do return
    if !com_connected() do return

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

vaaddressedprotocol_name_get :: proc(vaaddressedprotocol: VAAddressedProtocol) -> (name: string, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedprotocol_name_set :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_add :: proc(vaaddressedprotocol: VAAddressedProtocol, vaaddressedvariable: VAAddressedVariable) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if vaaddressedvariable == nil do return
    if !com_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Add(vaaddressedvariable)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_add_at_index :: proc(vaaddressedprotocol: VAAddressedProtocol, vaaddressedvariable: VAAddressedVariable, index: i32) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if vaaddressedvariable == nil do return
    if !com_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->AddBefore(vaaddressedvariable, index)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_by_name :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (vaaddressedvariable: VAAddressedVariable, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Find(bstr_name, cast(^rawptr)&vaaddressedvariable)
    if com_failed(hr) do return

    return vaaddressedvariable, true
}

vaaddressedprotocol_vaaddressedvariable_by_index :: proc(vaaddressedprotocol: VAAddressedProtocol, index: i32) -> (vaaddressedvariable: VAAddressedVariable, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Item(index + 1, cast(^rawptr)&vaaddressedvariable)
    if com_failed(hr) do return

    return vaaddressedvariable, true
}

vaaddressedprotocol_vaaddressedvariable_index :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (index: i32, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

vaaddressedprotocol_vaaddressedvariable_count :: proc(vaaddressedprotocol: VAAddressedProtocol) -> (count: i32, ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

vaaddressedprotocol_vaaddressedvariable_remove_by_name :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    index: i32
    index, ok = vaaddressedprotocol_vaaddressedvariable_index(vaaddressedprotocol, name)
    if !ok do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Remove(index)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_vaaddressedvariable_remove_by_index :: proc(vaaddressedprotocol: VAAddressedProtocol, index: i32) -> (ok: bool) {
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

vaaddressedprotocol_release :: proc(vaaddressedprotocol: VAAddressedProtocol) {
    if vaaddressedprotocol != nil {
        (^VAAddressedProtocolIF)(vaaddressedprotocol)->Release()
    }
}

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

vanamedprotocol_name_get :: proc(vanamedprotocol: VANamedProtocol) -> (name: string, ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedprotocol_name_set :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanammedvariable_add :: proc(vanamedprotocol: VANamedProtocol, vanammedvariable: VANamedVariable) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if vanammedvariable == nil do return
    if !com_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Add(vanammedvariable)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanammedvariable_add_at_index :: proc(vanamedprotocol: VANamedProtocol, vanammedvariable: VANamedVariable, index: i32) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if vanammedvariable == nil do return
    if !com_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->AddBefore(vanammedvariable, index)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanamedvariable_by_name :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (vanammedvariable: VANamedVariable, ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->Find(bstr_name, cast(^rawptr)&vanammedvariable)
    if com_failed(hr) do return

    return vanammedvariable, true
}

vanamedprotocol_vanamedvariable_by_index :: proc(vanamedprotocol: VANamedProtocol, index: i32) -> (vanammedvariable: VANamedVariable, ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Item(index + 1, cast(^rawptr)&vanammedvariable)
    if com_failed(hr) do return

    return vanammedvariable, true
}

vanamedprotocol_vanamedvariable_index :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (index: i32, ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

vanamedprotocol_vanamedvariable_count :: proc(vanamedprotocol: VANamedProtocol) -> (count: i32, ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

vanamedprotocol_vanamedvariable_remove_by_name :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    index: i32
    index, ok = vanamedprotocol_vanamedvariable_index(vanamedprotocol, name)
    if !ok do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Remove(index)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_vanamedvariable_remove_by_index :: proc(vanamedprotocol: VANamedProtocol, index: i32) -> (ok: bool) {
    if vanamedprotocol == nil do return
    if !com_connected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

vanamedprotocol_release :: proc(vanamedprotocol: VANamedProtocol) {
    if vanamedprotocol != nil {
        (^VANamedProtocolIF)(vanamedprotocol)->Release()
    }
}

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

vaprotocols_vanammedprotocol_add :: proc(vaprotocols: VAProtocols, vanamedprotocol: VANamedProtocol) -> (ok: bool) {
    if vaprotocols == nil do return
    if vanamedprotocol == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddVANamedProtocol(vanamedprotocol)
    if com_failed(hr) do return

    return true
}

vaprotocols_vaaddressedprotocol_add :: proc(vaprotocols: VAProtocols, vaaddressedprotocol: VAAddressedProtocol) -> (ok: bool) {
    if vaprotocols == nil do return
    if vaaddressedprotocol == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddVAAddressedProtocol(vaaddressedprotocol)
    if com_failed(hr) do return

    return true
}

vaprotocols_ivaprotocol_add :: proc(vaprotocols: VAProtocols, ivaprotocol: IVAProtocol) -> (ok: bool) {
    if vaprotocols == nil do return
    if ivaprotocol == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Add(ivaprotocol)
    if com_failed(hr) do return

    return true
}

vaprotocols_ivaprotocol_add_at_index :: proc(vaprotocols: VAProtocols, ivaprotocol: IVAProtocol, index: i32) -> (ok: bool) {
    if vaprotocols == nil do return
    if ivaprotocol == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddBefore(ivaprotocol, index)
    if com_failed(hr) do return

    return true
}

vaprotocols_vaprotocol_by_name :: proc(vaprotocols: VAProtocols, name: string) -> (iva: IVAProtocol, ok: bool) {
    if vaprotocols == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAProtocolsIF)(vaprotocols)->Find(bstr_name, cast(^rawptr)&iva)
    if com_failed(hr) do return

    return iva, true
}

vaprotocols_vaprotocol_by_index :: proc(vaprotocols: VAProtocols, index: i32) -> (iva: IVAProtocol, ok: bool) {
    if vaprotocols == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Item(index + 1, cast(^rawptr)&iva)
    if com_failed(hr) do return

    return iva, true
}

vaprotocols_vaprotocol_index :: proc(vaprotocols: VAProtocols, name: string) -> (index: i32, ok: bool) {
    if vaprotocols == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VAProtocolsIF)(vaprotocols)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

vaprotocols_vaprotocol_count :: proc(vaprotocols: VAProtocols) -> (count: i32, ok: bool) {
    if vaprotocols == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

vaprotocols_vaprotocol_remove_by_name :: proc(vaprotocols: VAProtocols, name: string) -> (ok: bool) {
    if vaprotocols == nil do return
    if !com_connected() do return

    index: i32
    index, ok = vaprotocols_vaprotocol_index(vaprotocols, name)
    if !ok do return

    hr := (^VAProtocolsIF)(vaprotocols)->Remove(index)
    if com_failed(hr) do return

    return true
}

vaprotocols_vaprotocol_remove_by_index :: proc(vaprotocols: VAProtocols, index: i32) -> (ok: bool) {
    if vaprotocols == nil do return
    if !com_connected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

vaprotocols_release :: proc(vaprotocols: VAProtocols) {
    if vaprotocols != nil {
        (^VAProtocolsIF)(vaprotocols)->Release()
    }
}

VANamedVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VANamedVariableVTable,
}

VANamedVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:        proc "system" (this: ^VANamedVariableIF, Name: ^BStr) -> HResult,
    NamePut:        proc "system" (this: ^VANamedVariableIF, Name: BStr) -> HResult,
    PathGet:        proc "system" (this: ^VANamedVariableIF, Path: ^BStr) -> HResult,
    PathPut:        proc "system" (this: ^VANamedVariableIF, Path: BStr) -> HResult,
    VAAttributeGet: proc "system" (this: ^VANamedVariableIF, VAAttribute: ^BStr) -> HResult,
    VAAttributePut: proc "system" (this: ^VANamedVariableIF, VAAttribute: BStr) -> HResult,
    VATypeGet:      proc "system" (this: ^VANamedVariableIF, VAType: ^BStr) -> HResult,
    VATypePut:      proc "system" (this: ^VANamedVariableIF, VAType: BStr) -> HResult,
    RowGet:         proc "system" (this: ^VANamedVariableIF, Row: ^i32) -> HResult,
    RowPut:         proc "system" (this: ^VANamedVariableIF, Row: i32) -> HResult,
    VATypePathGet:  proc "system" (this: ^VANamedVariableIF, VATypePath: ^BStr) -> HResult,
}

vanamedvariable_name_get :: proc(vanv: VANamedVariable) -> (name: string, ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_name_set :: proc(vanv: VANamedVariable, name: string) -> (ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_path_get :: proc(vanv: VANamedVariable) -> (path: string, ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->PathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_path_set :: proc(vanv: VANamedVariable, path: string) -> (ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->PathPut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_va_attribute_get :: proc(vanv: VANamedVariable) -> (va_attribute: string, ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VAAttributeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_va_attribute_set :: proc(vanv: VANamedVariable, va_attribute: string) -> (ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs := to_bstr(va_attribute)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VAAttributePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_va_type_get :: proc(vanv: VANamedVariable) -> (va_type: string, ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_va_type_set :: proc(vanv: VANamedVariable, va_type: string) -> (ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs := to_bstr(va_type)
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypePut(bs)
    if com_failed(hr) do return

    return true
}

vanamedvariable_row_get :: proc(vanv: VANamedVariable) -> (row: i32, ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    hr := (^VANamedVariableIF)(vanv)->RowGet(&row)
    if com_failed(hr) do return

    return row, true
}

vanamedvariable_row_set :: proc(vanv: VANamedVariable, row: i32) -> (ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    hr := (^VANamedVariableIF)(vanv)->RowPut(row)
    if com_failed(hr) do return

    return true
}

vanamedvariable_va_type_path_get :: proc(vanv: VANamedVariable) -> (va_type_path: string, ok: bool) {
    if vanv == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypePathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vanamedvariable_release :: proc(vanv: VANamedVariable) {
    if vanv != nil {
        (^VANamedVariableIF)(vanv)->Release()
    }
}

VAAddressedVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAAddressedVariableVTable,
}

VAAddressedVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:       proc "system" (this: ^VAAddressedVariableIF, Name: ^BStr) -> HResult,
    NamePut:       proc "system" (this: ^VAAddressedVariableIF, Name: BStr) -> HResult,
    PathGet:       proc "system" (this: ^VAAddressedVariableIF, Path: ^BStr) -> HResult,
    PathPut:       proc "system" (this: ^VAAddressedVariableIF, Path: BStr) -> HResult,
    VATypeGet:     proc "system" (this: ^VAAddressedVariableIF, VAType: ^BStr) -> HResult,
    VATypePut:     proc "system" (this: ^VAAddressedVariableIF, VAType: BStr) -> HResult,
    RowGet:        proc "system" (this: ^VAAddressedVariableIF, Row: ^i32) -> HResult,
    RowPut:        proc "system" (this: ^VAAddressedVariableIF, Row: i32) -> HResult,
    VATypePathGet: proc "system" (this: ^VAAddressedVariableIF, VATypePath: ^BStr) -> HResult,
}

vaaddressedvariable_name_get :: proc(vaav: VAAddressedVariable) -> (name: string, ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_name_set :: proc(vaav: VAAddressedVariable, name: string) -> (ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_path_get :: proc(vaav: VAAddressedVariable) -> (path: string, ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->PathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_path_set :: proc(vaav: VAAddressedVariable, path: string) -> (ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->PathPut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_va_type_get :: proc(vaav: VAAddressedVariable) -> (va_type: string, ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_va_type_set :: proc(vaav: VAAddressedVariable, va_type: string) -> (ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs := to_bstr(va_type)
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypePut(bs)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_row_get :: proc(vaav: VAAddressedVariable) -> (row: i32, ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    hr := (^VAAddressedVariableIF)(vaav)->RowGet(&row)
    if com_failed(hr) do return

    return row, true
}

vaaddressedvariable_row_set :: proc(vaav: VAAddressedVariable, row: i32) -> (ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    hr := (^VAAddressedVariableIF)(vaav)->RowPut(row)
    if com_failed(hr) do return

    return true
}

vaaddressedvariable_va_type_path_get :: proc(vaav: VAAddressedVariable) -> (va_type_path: string, ok: bool) {
    if vaav == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypePathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

vaaddressedvariable_release :: proc(vaav: VAAddressedVariable) {
    if vaav != nil {
        (^VAAddressedVariableIF)(vaav)->Release()
    }
}
