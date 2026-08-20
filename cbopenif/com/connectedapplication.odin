package com

import t "../types"

ConnectedApplication  :: distinct rawptr
ConnectedApplications :: distinct rawptr

ConnectedApplicationIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationVTable,
}

ConnectedApplicationVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:         proc "system" (this: ^ConnectedApplicationIF, Name: ^BStr) -> HResult,
    NamePut:         proc "system" (this: ^ConnectedApplicationIF, Name: BStr) -> HResult,
    MajorVersionGet: proc "system" (this: ^ConnectedApplicationIF, MajorVersion: ^i32) -> HResult,
    MajorVersionPut: proc "system" (this: ^ConnectedApplicationIF, MajorVersion: i32) -> HResult,
    MinorVersionGet: proc "system" (this: ^ConnectedApplicationIF, MinorVersion: ^i32) -> HResult,
    MinorVersionPut: proc "system" (this: ^ConnectedApplicationIF, MinorVersion: i32) -> HResult,
    RevisionGet:     proc "system" (this: ^ConnectedApplicationIF, Revision: ^i32) -> HResult,
    RevisionPut:     proc "system" (this: ^ConnectedApplicationIF, Revision: i32) -> HResult,
    GuidGet:         proc "system" (this: ^ConnectedApplicationIF, Guid: ^BStr) -> HResult,
}

connectedapplication_name_get :: proc(ca: ConnectedApplication) -> (name: string, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplication_name_set :: proc(ca: ConnectedApplication, name: string) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

connectedapplication_major_version_get :: proc(ca: ConnectedApplication) -> (major_version: i32, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionGet(&major_version)
    if com_failed(hr) do return

    return major_version, true
}

connectedapplication_major_version_set :: proc(ca: ConnectedApplication, major_version: i32) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MajorVersionPut(major_version)
    if com_failed(hr) do return

    return true
}

connectedapplication_minor_version_get :: proc(ca: ConnectedApplication) -> (minor_version: i32, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionGet(&minor_version)
    if com_failed(hr) do return

    return minor_version, true
}

connectedapplication_minor_version_set :: proc(ca: ConnectedApplication, minor_version: i32) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->MinorVersionPut(minor_version)
    if com_failed(hr) do return

    return true
}

connectedapplication_revision_get :: proc(ca: ConnectedApplication) -> (revision: i32, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionGet(&revision)
    if com_failed(hr) do return

    return revision, true
}

connectedapplication_revision_set :: proc(ca: ConnectedApplication, revision: i32) -> (ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationIF)(ca)->RevisionPut(revision)
    if com_failed(hr) do return

    return true
}

connectedapplication_guid_get :: proc(ca: ConnectedApplication) -> (guid: string, ok: bool) {
    if ca == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationIF)(ca)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplication_release :: proc(ca: ConnectedApplication) {
    if ca != nil {
        (^ConnectedApplicationIF)(ca)->Release()
    }
}

connectedapplication_from_com :: proc(ca: ConnectedApplication, allocator := context.allocator) -> (result: t.ConnectedApplication, ok: bool) {
    if ca == nil do return

    context.allocator = allocator

    result.name, ok = name(ca)
    if !ok do return
    result.major_version, ok = major_version(ca)
    if !ok do return
    result.minor_version, ok = minor_version(ca)
    if !ok do return
    result.revision, ok = revision(ca)
    if !ok do return

    return result, true
}

connectedapplication_to_com :: proc(src: t.ConnectedApplication) -> (result: ConnectedApplication, ok: bool) {
    ca: ConnectedApplication
    ca, ok = connectedapplication_new1(src.name, src.major_version, src.minor_version, src.revision)
    if !ok do return

    return ca, true
}

ConnectedApplicationsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ConnectedApplicationsVTable,
}

ConnectedApplicationsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize: proc "system" (this: ^ConnectedApplicationsIF, XML: ^BStr) -> HResult,
    Add:       proc "system" (this: ^ConnectedApplicationsIF, ConnectedApplication: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ConnectedApplicationsIF, ConnectedApplication: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedApplication: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ConnectedApplicationsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ConnectedApplicationsIF, Index: i32, ConnectedApplication: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ConnectedApplicationsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ConnectedApplicationsIF, Index: i32) -> HResult,
}

connectedapplications_serialize :: proc(connectedapplications: ConnectedApplications) -> (xml: string, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

connectedapplications_connectedapplication_add :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication) -> (ok: bool) {
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Add(connectedapplication)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_add_at_index :: proc(connectedapplications: ConnectedApplications, connectedapplication: ConnectedApplication, index: i32) -> (ok: bool) {
    if connectedapplications == nil do return
    if connectedapplication == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->AddBefore(connectedapplication, index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_by_name :: proc(connectedapplications: ConnectedApplications, name: string) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->Find(bstr_name, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return

    return connectedapplication, true
}

connectedapplications_connectedapplication_by_index :: proc(connectedapplications: ConnectedApplications, index: i32) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Item(index + 1, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return

    return connectedapplication, true
}

connectedapplications_connectedapplication_index :: proc(connectedapplications: ConnectedApplications, name: string) -> (index: i32, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ConnectedApplicationsIF)(connectedapplications)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

connectedapplications_connectedapplication_count :: proc(connectedapplications: ConnectedApplications) -> (count: i32, ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

connectedapplications_connectedapplication_remove_by_name :: proc(connectedapplications: ConnectedApplications, name: string) -> (ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    index: i32
    index, ok = connectedapplications_connectedapplication_index(connectedapplications, name)
    if !ok do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index)
    if com_failed(hr) do return

    return true
}

connectedapplications_connectedapplication_remove_by_index :: proc(connectedapplications: ConnectedApplications, index: i32) -> (ok: bool) {
    if connectedapplications == nil do return
    if !com_connected() do return

    hr := (^ConnectedApplicationsIF)(connectedapplications)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

connectedapplications_release :: proc(connectedapplications: ConnectedApplications) {
    if connectedapplications != nil {
        (^ConnectedApplicationsIF)(connectedapplications)->Release()
    }
}
