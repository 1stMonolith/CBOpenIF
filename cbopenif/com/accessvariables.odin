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
VAProtocols         :: distinct rawptr
IVAProtocol         :: distinct rawptr
VAAddressedProtocol :: distinct rawptr
VAAddressedVariable :: distinct rawptr
VANamedProtocol     :: distinct rawptr
VANamedVariable     :: distinct rawptr

AccessVariablesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^AccessVariablesVTable,
}

AccessVariablesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    VAProtocolsGet: proc "system" (this: ^AccessVariablesIF, VAProtocols: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^AccessVariablesIF) -> HResult,
    VAProtocolsPut: proc "system" (this: ^AccessVariablesIF, VAProtocols: rawptr) -> HResult,
    Serialize:      proc "system" (this: ^AccessVariablesIF, XML: ^BStr) -> HResult,
}

SerializeAccessVariables :: proc(av: AccessVariables) -> (xml: string, ok: bool)
{
    if av == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^AccessVariablesIF)(av)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetVAProtocols :: proc(av: AccessVariables) -> (vaprotocols: VAProtocols, ok: bool)
{
    if av == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^AccessVariablesIF)(av)->VAProtocolsGet(&p)
    if ComFailed(hr) do return

    return VAProtocols(p), true
}

SetVAProtocols :: proc(av: AccessVariables, vaprotocols: VAProtocols) -> (ok: bool)
{
    if av == nil do return
    if !ComConnected() do return

    hr := (^AccessVariablesIF)(av)->VAProtocolsPut(vaprotocols)
    if ComFailed(hr) do return

    return true
}

ReleaseAccessVariables :: proc(av: AccessVariables)
{
    if av != nil {
        (^AccessVariablesIF)(av)->Release()
    }
}

VAProtocolsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAProtocolsVTable,
}

VAProtocolsVTable :: struct
{
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

AddVANamedProtocol :: proc(vaprotocols: VAProtocols, vanamedprotocol: VANamedProtocol) -> (ok: bool)
{
    if vaprotocols == nil do return
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddVANamedProtocol(vanamedprotocol)
    if ComFailed(hr) do return

    return true
}

AddVAAddressedProtocol :: proc(vaprotocols: VAProtocols, vaaddressedprotocol: VAAddressedProtocol) -> (ok: bool)
{
    if vaprotocols == nil do return
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddVAAddressedProtocol(vaaddressedprotocol)
    if ComFailed(hr) do return

    return true
}

AddVAProtocol :: proc {
    _AddIVAProtocol,
    _AddIVAProtocolAtIndex,
}

_AddIVAProtocol :: proc(vaprotocols: VAProtocols, ivaprotocol: IVAProtocol) -> (ok: bool)
{
    if vaprotocols == nil do return
    if ivaprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Add(ivaprotocol)
    if ComFailed(hr) do return

    return true
}

_AddIVAProtocolAtIndex :: proc(vaprotocols: VAProtocols, ivaprotocol: IVAProtocol, index: i32) -> (ok: bool)
{
    if vaprotocols == nil do return
    if ivaprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->AddBefore(ivaprotocol, index)
    if ComFailed(hr) do return

    return true
}

GetVAProtocol :: proc {
    _GetVAProtocolByName,
    _GetVAProtocolByIndex,
}

_GetVAProtocolByName :: proc(vaprotocols: VAProtocols, name: string) -> (iva: IVAProtocol, ok: bool)
{
    if vaprotocols == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VAProtocolsIF)(vaprotocols)->Find(bstr_name, cast(^rawptr)&iva)
    if ComFailed(hr) do return

    return iva, true
}

_GetVAProtocolByIndex :: proc(vaprotocols: VAProtocols, index: i32) -> (iva: IVAProtocol, ok: bool)
{
    if vaprotocols == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Item(index + 1, cast(^rawptr)&iva)
    if ComFailed(hr) do return

    return iva, true
}

VAProtocolIndex :: proc(vaprotocols: VAProtocols, name: string) -> (index: i32, ok: bool)
{
    if vaprotocols == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VAProtocolsIF)(vaprotocols)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

VAProtocolByCount :: proc(vaprotocols: VAProtocols) -> (count: i32, ok: bool)
{
    if vaprotocols == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveVAProtocol :: proc {
    _RemoveVAProtocolWithName,
    _RemoveVAProtocolAtIndex,
}

_RemoveVAProtocolWithName :: proc(vaprotocols: VAProtocols, name: string) -> (ok: bool)
{
    if vaprotocols == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = VAProtocolIndex(vaprotocols, name)
    if !ok do return

    hr := (^VAProtocolsIF)(vaprotocols)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveVAProtocolAtIndex :: proc(vaprotocols: VAProtocols, index: i32) -> (ok: bool)
{
    if vaprotocols == nil do return
    if !ComConnected() do return

    hr := (^VAProtocolsIF)(vaprotocols)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseVAProtocols :: proc(vaprotocols: VAProtocols)
{
    if vaprotocols != nil {
        (^VAProtocolsIF)(vaprotocols)->Release()
    }
}

IVAProtocolIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IVAProtocolVTable,
}

IVAProtocolVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                 proc "system" (this: ^IVAProtocolIF, Name: ^BStr) -> HResult,
    NamePut:                 proc "system" (this: ^IVAProtocolIF, Name: BStr) -> HResult,
    IsVANamedProtocolGet:    proc "system" (this: ^IVAProtocolIF, IsVANamedProtocol: ^VariantBool) -> HResult,
    IsVAAddressedProtocolGet: proc "system" (this: ^IVAProtocolIF, IsVAAddressedProtocol: ^VariantBool) -> HResult,
}

GetIVAProtocolName :: proc(iva: IVAProtocol) -> (name: string, ok: bool)
{
    if iva == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^IVAProtocolIF)(iva)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetIVAProtocolName :: proc(iva: IVAProtocol, name: string) -> (ok: bool)
{
    if iva == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^IVAProtocolIF)(iva)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

IsVANamedProtocol :: proc(iva: IVAProtocol) -> (is_vanamed: bool, ok: bool)
{
    if iva == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^IVAProtocolIF)(iva)->IsVANamedProtocolGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

IsVAAddressedProtocol :: proc(iva: IVAProtocol) -> (is_vaaddressed: bool, ok: bool)
{
    if iva == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^IVAProtocolIF)(iva)->IsVAAddressedProtocolGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

ReleaseIVAProtocol :: proc(iva: IVAProtocol)
{
    if iva != nil {
        (^IVAProtocolIF)(iva)->Release()
    }
}

VAAddressedProtocolIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAAddressedProtocolVTable,
}

VAAddressedProtocolVTable :: struct
{
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

GetVAAddressedProtocolName :: proc(vaaddressedprotocol: VAAddressedProtocol) -> (name: string, ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVAAddressedProtocolName :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

AddVAAddressedVariable :: proc {
    _AddVAAddressedVariable,
    _AddVAAddressedVariableAtIndex,
}

_AddVAAddressedVariable :: proc(vaaddressedprotocol: VAAddressedProtocol, vaaddressedvariable: VAAddressedVariable) -> (ok: bool)
{
    if vaaddressedprotocol == nil do return
    if vaaddressedvariable == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Add(vaaddressedvariable)
    if ComFailed(hr) do return

    return true
}

_AddVAAddressedVariableAtIndex :: proc(vaaddressedprotocol: VAAddressedProtocol, vaaddressedvariable: VAAddressedVariable, index: i32) -> (ok: bool)
{
    if vaaddressedprotocol == nil do return
    if vaaddressedvariable == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->AddBefore(vaaddressedvariable, index)
    if ComFailed(hr) do return

    return true
}

GetVAAddressedVariable :: proc {
    _GetVAAddressedVariableByName,
    _GetVAAddressedVariableByIndex,
}

_GetVAAddressedVariableByName :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (vaaddressedvariable: VAAddressedVariable, ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Find(bstr_name, cast(^rawptr)&vaaddressedvariable)
    if ComFailed(hr) do return

    return vaaddressedvariable, true
}

_GetVAAddressedVariableByIndex :: proc(vaaddressedprotocol: VAAddressedProtocol, index: i32) -> (vaaddressedvariable: VAAddressedVariable, ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Item(index + 1, cast(^rawptr)&vaaddressedvariable)
    if ComFailed(hr) do return

    return vaaddressedvariable, true
}

VAAddressedVariableIndex :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (index: i32, ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

VAAddressedVariableCount :: proc(vaaddressedprotocol: VAAddressedProtocol) -> (count: i32, ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveVAAddressedVariable :: proc {
    _RemoveVAAddressedVariableWithName,
    _RemoveVAAddressedVariableAtIndex,
}

_RemoveVAAddressedVariableWithName :: proc(vaaddressedprotocol: VAAddressedProtocol, name: string) -> (ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = VAAddressedVariableIndex(vaaddressedprotocol, name)
    if !ok do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveVAAddressedVariableAtIndex :: proc(vaaddressedprotocol: VAAddressedProtocol, index: i32) -> (ok: bool)
{
    if vaaddressedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedProtocolIF)(vaaddressedprotocol)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseVAAddressedProtocol :: proc(vaaddressedprotocol: VAAddressedProtocol)
{
    if vaaddressedprotocol != nil {
        (^VAAddressedProtocolIF)(vaaddressedprotocol)->Release()
    }
}

VAAddressedVariableIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VAAddressedVariableVTable,
}

VAAddressedVariableVTable :: struct
{
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

GetVAAddressedVariableName :: proc(vaav: VAAddressedVariable) -> (name: string, ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVAAddressedVariableName :: proc(vaav: VAAddressedVariable, name: string) -> (ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetVAAddressedVariablePath :: proc(vaav: VAAddressedVariable) -> (path: string, ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->PathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVAAddressedVariablePath :: proc(vaav: VAAddressedVariable, path: string) -> (ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs := ToBstr(path)
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->PathPut(bs)
    if ComFailed(hr) do return

    return true
}

GetVAAddressedVariableType :: proc(vaav: VAAddressedVariable) -> (va_type: string, ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVAAddressedVariableType :: proc(vaav: VAAddressedVariable, va_type: string) -> (ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs := ToBstr(va_type)
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetVAAddressedVariableRow :: proc(vaav: VAAddressedVariable) -> (row: i32, ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedVariableIF)(vaav)->RowGet(&row)
    if ComFailed(hr) do return

    return row, true
}

SetVAAddressedVariableRow :: proc(vaav: VAAddressedVariable, row: i32) -> (ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    hr := (^VAAddressedVariableIF)(vaav)->RowPut(row)
    if ComFailed(hr) do return

    return true
}

GetVAAddressedVariableTypePath :: proc(vaav: VAAddressedVariable) -> (va_type_path: string, ok: bool)
{
    if vaav == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VAAddressedVariableIF)(vaav)->VATypePathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseVAAddressedVariable :: proc(vaav: VAAddressedVariable)
{
    if vaav != nil {
        (^VAAddressedVariableIF)(vaav)->Release()
    }
}

VANamedProtocolIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VANamedProtocolVTable,
}

VANamedProtocolVTable :: struct
{
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

GetVANamedProtocolName :: proc(vanamedprotocol: VANamedProtocol) -> (name: string, ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVANamedProtocolName :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

AddVANammedVariable :: proc {
    _AddVANammedVariable,
    _AddVANammedVariableAtIndex,
}

_AddVANammedVariable :: proc(vanamedprotocol: VANamedProtocol, vanammedvariable: VANamedVariable) -> (ok: bool)
{
    if vanamedprotocol == nil do return
    if vanammedvariable == nil do return
    if !ComConnected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Add(vanammedvariable)
    if ComFailed(hr) do return

    return true
}

_AddVANammedVariableAtIndex :: proc(vanamedprotocol: VANamedProtocol, vanammedvariable: VANamedVariable, index: i32) -> (ok: bool)
{
    if vanamedprotocol == nil do return
    if vanammedvariable == nil do return
    if !ComConnected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->AddBefore(vanammedvariable, index)
    if ComFailed(hr) do return

    return true
}

GetVANammedVariable :: proc {
    _GetVANammedVariableByName,
    _GetVANammedVariableByIndex,
}

_GetVANammedVariableByName :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (vanammedvariable: VANamedVariable, ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->Find(bstr_name, cast(^rawptr)&vanammedvariable)
    if ComFailed(hr) do return

    return vanammedvariable, true
}

_GetVANammedVariableByIndex :: proc(vanamedprotocol: VANamedProtocol, index: i32) -> (vanammedvariable: VANamedVariable, ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Item(index + 1, cast(^rawptr)&vanammedvariable)
    if ComFailed(hr) do return

    return vanammedvariable, true
}

VANammedVariableIndex :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (index: i32, ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VANamedProtocolIF)(vanamedprotocol)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

VANammedVariableCount :: proc(vanamedprotocol: VANamedProtocol) -> (count: i32, ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveVANameedVariable :: proc {
    _RemoveVANameedVariableWithName,
    _RemoveVANameedVariableAtIndex,
}

_RemoveVANameedVariableWithName :: proc(vanamedprotocol: VANamedProtocol, name: string) -> (ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = VANammedVariableIndex(vanamedprotocol, name)
    if !ok do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveVANameedVariableAtIndex :: proc(vanamedprotocol: VANamedProtocol, index: i32) -> (ok: bool)
{
    if vanamedprotocol == nil do return
    if !ComConnected() do return

    hr := (^VANamedProtocolIF)(vanamedprotocol)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseVANamedProtocol :: proc(vanamedprotocol: VANamedProtocol)
{
    if vanamedprotocol != nil {
        (^VANamedProtocolIF)(vanamedprotocol)->Release()
    }
}

VANamedVariableIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VANamedVariableVTable,
}

VANamedVariableVTable :: struct
{
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

GetVANamedVariableName :: proc(vanv: VANamedVariable) -> (name: string, ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVANamedVariableName :: proc(vanv: VANamedVariable, name: string) -> (ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetVANamedVariablePath :: proc(vanv: VANamedVariable) -> (path: string, ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->PathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVANamedVariablePath :: proc(vanv: VANamedVariable, path: string) -> (ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs := ToBstr(path)
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->PathPut(bs)
    if ComFailed(hr) do return

    return true
}

GetVANamedVariableAttribute :: proc(vanv: VANamedVariable) -> (va_attribute: string, ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->VAAttributeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVANamedVariableAttribute :: proc(vanv: VANamedVariable, va_attribute: string) -> (ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs := ToBstr(va_attribute)
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->VAAttributePut(bs)
    if ComFailed(hr) do return

    return true
}

GetVANamedVariableType :: proc(vanv: VANamedVariable) -> (va_type: string, ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVANamedVariableType :: proc(vanv: VANamedVariable, va_type: string) -> (ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs := ToBstr(va_type)
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetVANamedVariableRow :: proc(vanv: VANamedVariable) -> (row: i32, ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    hr := (^VANamedVariableIF)(vanv)->RowGet(&row)
    if ComFailed(hr) do return

    return row, true
}

SetVANamedVariableRow :: proc(vanv: VANamedVariable, row: i32) -> (ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    hr := (^VANamedVariableIF)(vanv)->RowPut(row)
    if ComFailed(hr) do return

    return true
}

GetVANamedVariableTypePath :: proc(vanv: VANamedVariable) -> (va_type_path: string, ok: bool)
{
    if vanv == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VANamedVariableIF)(vanv)->VATypePathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseVANamedVariable :: proc(vanv: VANamedVariable)
{
    if vanv != nil {
        (^VANamedVariableIF)(vanv)->Release()
    }
}
