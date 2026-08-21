package com

import t "../types"

ConnectedHWLibrary   :: distinct rawptr
ConnectedHWLibraries :: distinct rawptr

ConnectedHWLibraryIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedHWLibraryVTable,
}

ConnectedHWLibraryVTable :: struct {
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

connectedhwlibrary_name_get :: proc(chl: ConnectedHWLibrary) -> (name: string, ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibraryIF)(chl)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibrary_name_set :: proc(chl: ConnectedHWLibrary, name: string) -> (ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedHWLibraryIF)(chl)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_major_version_get :: proc(chl: ConnectedHWLibrary) -> (major_version: i32, ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedhwlibrary_major_version_set :: proc(chl: ConnectedHWLibrary, major_version: i32) -> (ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}
connectedhwlibrary_minor_version_get :: proc(chl: ConnectedHWLibrary) -> (minor_version: i32, ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedhwlibrary_minor_version_set :: proc(chl: ConnectedHWLibrary, minor_version: i32) -> (ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_revision_get :: proc(chl: ConnectedHWLibrary) -> (revision: i32, ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedhwlibrary_revision_set :: proc(chl: ConnectedHWLibrary, revision: i32) -> (ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibraryIF)(chl)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedhwlibrary_guid_get :: proc(chl: ConnectedHWLibrary) -> (guid: string, ok: bool) {
    if chl == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibraryIF)(chl)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibrary_release :: proc(chl: ConnectedHWLibrary) {
    if chl != nil {
        (^ConnectedHWLibraryIF)(chl)->Release()
    }
}

connectedhwlibrary_from_com :: proc(chl: ConnectedHWLibrary, allocator := context.allocator) -> (result: t.ConnectedHWLibrary, ok: bool) {
    if chl == nil do return

    context.allocator = allocator

    result.name, ok = name(chl)
    if !ok do return
    result.major_version, ok = major_version(chl)
    if !ok do return
    result.minor_version, ok = minor_version(chl)
    if !ok do return
    result.revision, ok = revision(chl)
    if !ok do return

    return result, true
}

connectedhwlibrary_to_com :: proc(src: t.ConnectedHWLibrary) -> (result: ConnectedHWLibrary, ok: bool) {
    chl: ConnectedHWLibrary
    chl, ok = connectedhwlibrary_new1(src.name, src.major_version, src.minor_version, src.revision)
    if !ok do return

    return chl, true
}

ConnectedHWLibrariesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedHWLibrariesVTable,
}

ConnectedHWLibrariesVTable :: struct {
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

connectedhwlibraries_serialize :: proc(connectedhwlibraries: ConnectedHWLibraries) -> (xml: string, ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedhwlibraries_connectedhwlibrary_add :: proc(connectedhwlibraries: ConnectedHWLibraries, connectedhwlibrary: ConnectedHWLibrary) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if connectedhwlibrary == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Add(connectedhwlibrary)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary_add_at_index :: proc(connectedhwlibraries: ConnectedHWLibraries, connectedhwlibrary: ConnectedHWLibrary, index: i32) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if connectedhwlibrary == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->AddBefore(connectedhwlibrary, index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary_by_name :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Find(bstr_name, cast(^rawptr)&connectedhwlibrary)
    if com_failed(hr) do return

    return connectedhwlibrary, true
}

connectedhwlibraries_connectedhwlibrary_by_index :: proc(connectedhwlibraries: ConnectedHWLibraries, index: i32) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Item(index + 1, cast(^rawptr)&connectedhwlibrary)
    if com_failed(hr) do return

    return connectedhwlibrary, true
}

connectedhwlibraries_connectedhwlibrary_index :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (index: i32, ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedhwlibraries_connectedhwlibrary_count :: proc(connectedhwlibraries: ConnectedHWLibraries) -> (count: i32, ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedhwlibraries_connectedhwlibrary_remove_by_name :: proc(connectedhwlibraries: ConnectedHWLibraries, name: string) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    index: i32
    index, ok = connectedhwlibraries_connectedhwlibrary_index(connectedhwlibraries, name)
    if !ok do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_connectedhwlibrary_remove_by_index :: proc(connectedhwlibraries: ConnectedHWLibraries, index: i32) -> (ok: bool) {
    if connectedhwlibraries == nil do return
    if !com_connected() do return

    hr := (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedhwlibraries_release :: proc(connectedhwlibraries: ConnectedHWLibraries) {
    if connectedhwlibraries != nil {
        (^ConnectedHWLibrariesIF)(connectedhwlibraries)->Release()
    }
}

connectedhwlibraries_from_com :: proc(chls: ConnectedHWLibraries, allocator := context.allocator) -> (result: [dynamic]t.ConnectedHWLibrary, ok: bool) {
    if chls == nil do return
    context.allocator = allocator

    count: i32
    count, ok = connectedhwlibrary_count(chls)
    if !ok do return

    result = make([dynamic]t.ConnectedHWLibrary, 0, int(count), allocator)
    for i in 0..<count {
        chl: ConnectedHWLibrary
        chl, ok = connectedhwlibrary_by_index(chls, i)
        if !ok do return
        defer release(chl)

        chls_: t.ConnectedHWLibrary
        chls_, ok = connectedhwlibrary_from_com(chl)
        if !ok do return
        append(&result, chls_)
    }
    return result, true
}

connectedhwlibraries_to_com :: proc(chls: ConnectedHWLibraries, src: []t.ConnectedHWLibrary) -> (ok: bool) {
    if chls == nil do return
    for item in src {
        chl: ConnectedHWLibrary
        chl, ok = connectedhwlibrary_to_com(item)
        if !ok do return
        defer release(chl)
        ok = connectedhwlibrary_add(chls, chl)
        if !ok do return
    }
    return true
}
