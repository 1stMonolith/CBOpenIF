package com

ConnectedLibrary   :: distinct rawptr
ConnectedLibraries :: distinct rawptr

ConnectedLibraryIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedLibraryVTable,
}

ConnectedLibraryVTable :: struct {
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

connectedlibrary_name_get :: proc(cl: ConnectedLibrary) -> (name: string, ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibraryIF)(cl)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibrary_name_set :: proc(cl: ConnectedLibrary, name: string) -> (ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedLibraryIF)(cl)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedlibrary_major_version_get :: proc(cl: ConnectedLibrary) -> (major_version: i32, ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedlibrary_major_version_set :: proc(cl: ConnectedLibrary, major_version: i32) -> (ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}

connectedlibrary_minor_version_get :: proc(cl: ConnectedLibrary) -> (minor_version: i32, ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedlibrary_minor_version_set :: proc(cl: ConnectedLibrary, minor_version: i32) -> (ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedlibrary_revision_get :: proc(cl: ConnectedLibrary) -> (revision: i32, ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedlibrary_revision_set :: proc(cl: ConnectedLibrary, revision: i32) -> (ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibraryIF)(cl)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedlibrary_guid_get :: proc(cl: ConnectedLibrary) -> (guid: string, ok: bool) {
    if cl == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibraryIF)(cl)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibrary_release :: proc(cl: ConnectedLibrary) {
    if cl != nil {
        (^ConnectedLibraryIF)(cl)->Release()
    }
}

ConnectedLibrariesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedLibrariesVTable,
}

ConnectedLibrariesVTable :: struct {
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

connectedlibraries_serialize :: proc(connectedlibraries: ConnectedLibraries) -> (xml: string, ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedlibraries_connectedlibrary_add :: proc(connectedlibraries: ConnectedLibraries, connectedlibrary: ConnectedLibrary) -> (ok: bool) {
    if connectedlibraries == nil do return
    if connectedlibrary == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Add(connectedlibrary)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary_add_at_index :: proc(connectedlibraries: ConnectedLibraries, connectedlibrary: ConnectedLibrary, index: i32) -> (ok: bool) {
    if connectedlibraries == nil do return
    if connectedlibrary == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->AddBefore(connectedlibrary, index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary_by_name :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (connectedlibrary: ConnectedLibrary, ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Find(bstr_name, cast(^rawptr)&connectedlibrary)
    if com_failed(hr) do return

    return connectedlibrary, true
}

connectedlibraries_connectedlibrary_by_index :: proc(connectedlibraries: ConnectedLibraries, index: i32) -> (connectedlibrary: ConnectedLibrary, ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Item(index + 1, cast(^rawptr)&connectedlibrary)
    if com_failed(hr) do return

    return connectedlibrary, true
}

connectedlibraries_connectedlibrary_index :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (index: i32, ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedLibrariesIF)(connectedlibraries)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedlibraries_connectedlibrary_count :: proc(connectedlibraries: ConnectedLibraries) -> (count: i32, ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedlibraries_connectedlibrary_remove_by_name :: proc(connectedlibraries: ConnectedLibraries, name: string) -> (ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    index: i32
    index, ok = connectedlibraries_connectedlibrary_index(connectedlibraries, name)
    if !ok do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedlibraries_connectedlibrary_remove_by_index :: proc(connectedlibraries: ConnectedLibraries, index: i32) -> (ok: bool) {
    if connectedlibraries == nil do return
    if !com_connected() do return

    hr := (^ConnectedLibrariesIF)(connectedlibraries)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedlibraries_release :: proc(connectedlibraries: ConnectedLibraries) {
    if connectedlibraries != nil {
        (^ConnectedLibrariesIF)(connectedlibraries)->Release()
    }
}