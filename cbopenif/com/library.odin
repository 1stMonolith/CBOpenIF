package com

ConnectedLibraries   :: distinct rawptr
ConnectedLibrary     :: distinct rawptr
ConnectedHWLibraries :: distinct rawptr
ConnectedHWLibrary   :: distinct rawptr

ConnectedLibrariesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedLibrariesVTable,
}

ConnectedLibrariesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedLibrariesIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedLibrariesIF, ConnectedLibrary: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedLibrariesIF, ConnectedLibrary: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, ConnectedLibrary: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedLibrary: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, ConnectedLibrary: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedLibrariesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedLibrariesIF, Index: i32, ConnectedLibrary: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedLibrariesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedLibrariesIF, Index: i32) -> HResult,
}

SerializeConnectedLibraries :: proc(connectedlibraries: ConnectedLibraries) -> (xml: string, ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

AddConnectedLibrary :: proc {
    _AddConnectedLibrary,
    _AddConnectedLibraryAtIndex,
}

_AddConnectedLibrary :: proc(connectedlibraries: ConnectedLibraries, connectedlibrary: ConnectedLibrary) -> (ok: bool)
{
    if connectedlibraries == nil do return
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Add(connectedlibrary)
    if ComFailed(hr) do return

    return true
}

_AddConnectedLibraryAtIndex :: proc(connectedlibraries: ConnectedLibraries, connectedlibrary: ConnectedLibrary, index: i32) -> (ok: bool)
{
    if connectedlibraries == nil do return
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->AddBefore(connectedlibrary, index)
    if ComFailed(hr) do return

    return true
}

GetConnectedLibrary :: proc {
    _GetConnectedLibraryWithName,
    _GetConnectedLibraryAtIndex,
}

_GetConnectedLibraryWithName :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (connectedlibrary: ConnectedLibrary, ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Find(bstr_name, cast(^rawptr)&connectedlibrary)
    if ComFailed(hr) do return

    return connectedlibrary, true
}

_GetConnectedLibraryAtIndex :: proc(connectedlibraries: ConnectedLibraries, index: i32) -> (connectedlibrary: ConnectedLibrary, ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Item(index + 1, cast(^rawptr)&connectedlibrary)
    if ComFailed(hr) do return

    return connectedlibrary, true
}

ConnectedLibraryIndex :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (index: i32, ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ConnectedLibraryCount :: proc(connectedlibraries: ConnectedLibraries) -> (count: i32, ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveConnectedLibrary :: proc {
    _RemoveConnectedLibraryWithName,
    _RemoveConnectedLibraryAtIndex,
}

_RemoveConnectedLibraryWithName :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ConnectedLibraryIndex(connectedlibraries, name)
    if !ok do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveConnectedLibraryAtIndex :: proc(connectedlibraries: ConnectedLibraries, index: i32) -> (ok: bool)
{
    if connectedlibraries == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseConnectedLibraries :: proc(connectedlibraries: ConnectedLibraries)
{
    if connectedlibraries != nil {
        (^ConnectedLibrariesIF)(connectedlibraries)->Release()
    }
}

ConnectedLibraryIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedLibraryVTable,
}

ConnectedLibraryVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedLibraryIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedLibraryIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedLibraryIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedLibraryIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedLibraryIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedLibraryIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedLibraryIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedLibraryIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedLibraryIF, Guid: ^BStr) -> HResult,
}

GetConnectedLibraryName :: proc(connectedlibrary: ConnectedLibrary) -> (name: string, ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedLibraryIF)(connectedlibrary)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetConnectedLibraryName :: proc(connectedlibrary: ConnectedLibrary, name: string) -> (ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ConnectedLibraryIF)(connectedlibrary)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetConnectedLibraryMajorVersion :: proc(connectedlibrary: ConnectedLibrary) -> (major_version: i32, ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibraryIF)(connectedlibrary)->MajorVersionGet(&major_version)
    if ComFailed(hr) do return

    return major_version, true
}

SetConnectedLibraryMajorVersion :: proc(connectedlibrary: ConnectedLibrary, major_version: i32) -> (ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibraryIF)(connectedlibrary)->MajorVersionPut(major_version)
    if ComFailed(hr) do return

    return true
}

GetConnectedLibraryMinorVersion :: proc(connectedlibrary: ConnectedLibrary) -> (minor_version: i32, ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibraryIF)(connectedlibrary)->MinorVersionGet(&minor_version)
    if ComFailed(hr) do return

    return minor_version, true
}

SetConnectedLibraryMinorVersion :: proc(connectedlibrary: ConnectedLibrary, minor_version: i32) -> (ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibraryIF)(connectedlibrary)->MinorVersionPut(minor_version)
    if ComFailed(hr) do return

    return true
}

GetConnectedLibraryRevision :: proc(connectedlibrary: ConnectedLibrary) -> (revision: i32, ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibraryIF)(connectedlibrary)->RevisionGet(&revision)
    if ComFailed(hr) do return

    return revision, true
}

SetConnectedLibraryRevision :: proc(connectedlibrary: ConnectedLibrary, revision: i32) -> (ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedLibraryIF)(connectedlibrary)->RevisionPut(revision)
    if ComFailed(hr) do return

    return true
}

GetConnectedLibraryGuid :: proc(connectedlibrary: ConnectedLibrary) -> (guid: string, ok: bool)
{
    if connectedlibrary == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedLibraryIF)(connectedlibrary)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseConnectedLibrary :: proc(connectedlibrary: ConnectedLibrary)
{
    if connectedlibrary != nil {
        (^ConnectedLibraryIF)(connectedlibrary)->Release()
    }
}

ConnectedHWLibrariesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedHWLibrariesVTable,
}

ConnectedHWLibrariesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedHWLibrariesIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedHWLibrariesIF, ConnectedHWLibrary: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedHWLibrariesIF, ConnectedHWLibrary: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, ConnectedHWLibrary: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedHWLibrary: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, ConnectedHWLibrary: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedHWLibrariesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedHWLibrariesIF, Index: i32, ConnectedHWLibrary: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedHWLibrariesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedHWLibrariesIF, Index: i32) -> HResult,
}

SerializeConnectedHWLibraries :: proc(connectedhwlibraries: ConnectedHWLibraries) -> (xml: string, ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

AddConnectedHWLibrary :: proc {
    _AddConnectedHWLibrary,
    _AddConnectedHWLibraryAtIndex,
}

_AddConnectedHWLibrary :: proc(connectedhwlibraries: ConnectedHWLibraries, connectedhwlibrary: ConnectedHWLibrary) -> (ok: bool)
{
    if connectedhwlibraries == nil do return
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Add(connectedhwlibrary)
    if ComFailed(hr) do return

    return true
}

_AddConnectedHWLibraryAtIndex :: proc(connectedhwlibraries: ConnectedHWLibraries, connectedhwlibrary: ConnectedHWLibrary, index: i32) -> (ok: bool)
{
    if connectedhwlibraries == nil do return
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->AddBefore(connectedhwlibrary, index)
    if ComFailed(hr) do return

    return true
}

GetConnectedHWLibrary :: proc {
    _GetConnectedHWLibraryWithName,
    _GetConnectedHWLibraryAtIndex,
}

_GetConnectedHWLibraryWithName :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Find(bstr_name, cast(^rawptr)&connectedhwlibrary)
    if ComFailed(hr) do return

    return connectedhwlibrary, true
}

_GetConnectedHWLibraryAtIndex :: proc(connectedhwlibraries: ConnectedHWLibraries, index: i32) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Item(index + 1, cast(^rawptr)&connectedhwlibrary)
    if ComFailed(hr) do return

    return connectedhwlibrary, true
}

ConnectedHWLibraryIndex :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (index: i32, ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

ConnectedHWLibraryCount :: proc(connectedhwlibraries: ConnectedHWLibraries) -> (count: i32, ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveConnectedHWLibrary :: proc {
    _RemoveConnectedHWLibraryWithName,
    _RemoveConnectedHWLibraryAtIndex,
}

_RemoveConnectedHWLibraryWithName :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ConnectedHWLibraryIndex(connectedhwlibraries, name)
    if !ok do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveConnectedHWLibraryAtIndex :: proc(connectedhwlibraries: ConnectedHWLibraries, index: i32) -> (ok: bool)
{
    if connectedhwlibraries == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseConnectedHWLibraries :: proc(connectedhwlibraries: ConnectedHWLibraries)
{
    if connectedhwlibraries != nil {
        (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Release()
    }
}

ConnectedHWLibraryIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedHWLibraryVTable,
}

ConnectedHWLibraryVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedHWLibraryIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedHWLibraryIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedHWLibraryIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedHWLibraryIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedHWLibraryIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedHWLibraryIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedHWLibraryIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedHWLibraryIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedHWLibraryIF, Guid: ^BStr) -> HResult,
}

GetConnectedHWLibraryName :: proc(connectedhwlibrary: ConnectedHWLibrary) -> (name: string, ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetConnectedHWLibraryName :: proc(connectedhwlibrary: ConnectedHWLibrary, name: string) -> (ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetConnectedHWLibraryMajorVersion :: proc(connectedhwlibrary: ConnectedHWLibrary) -> (major_version: i32, ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->MajorVersionGet(&major_version)
    if ComFailed(hr) do return

    return major_version, true
}

SetConnectedHWLibraryMajorVersion :: proc(connectedhwlibrary: ConnectedHWLibrary, major_version: i32) -> (ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->MajorVersionPut(major_version)
    if ComFailed(hr) do return

    return true
}
GetConnectedHWLibraryMinorVersion :: proc(connectedhwlibrary: ConnectedHWLibrary) -> (minor_version: i32, ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->MinorVersionGet(&minor_version)
    if ComFailed(hr) do return

    return minor_version, true
}

SetConnectedHWLibraryMinorVersion :: proc(connectedhwlibrary: ConnectedHWLibrary, minor_version: i32) -> (ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->MinorVersionPut(minor_version)
    if ComFailed(hr) do return

    return true
}

GetConnectedHWLibraryRevision :: proc(connectedhwlibrary: ConnectedHWLibrary) -> (revision: i32, ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->RevisionGet(&revision)
    if ComFailed(hr) do return

    return revision, true
}

SetConnectedHWLibraryRevision :: proc(connectedhwlibrary: ConnectedHWLibrary, revision: i32) -> (ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->RevisionPut(revision)
    if ComFailed(hr) do return

    return true
}

GetConnectedHWLibraryGuid :: proc(connectedhwlibrary: ConnectedHWLibrary) -> (guid: string, ok: bool)
{
    if connectedhwlibrary == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ConnectedHWLibraryIF)(connectedhwlibrary)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseConnectedHWLibrary :: proc(connectedhwlibrary: ConnectedHWLibrary)
{
    if connectedhwlibrary != nil {
        (^ConnectedHWLibraryIF)(connectedhwlibrary)->Release()
    }
}
