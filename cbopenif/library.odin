package cbopenif

import "com"

LibraryKind :: enum i32 {
    Library   = 0,
    HWLibrary = 0,
}

Library :: struct {
    kind:          LibraryKind,
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

library_new :: proc(library_name, directory_path: string) {
    ok: bool
    ok = com.library_new(library_name, directory_path, "")
}

library_rename :: proc(library_name, new_library_name: string) {
    ok: bool
    ok = com.library_rename(library_name, new_library_name)
}

library_delete :: proc(library_name: string) {
    ok: bool
    ok = com.library_delete(library_name)
}

connectedlibrary_from_com :: proc(cl: ConnectedLibrary, allocator := context.allocator) -> (result: t.Library, ok: bool) {
    if cl == nil do return

    context.allocator = allocator

    result.name, ok = name(cl)
    if !ok do return
    result.major_version, ok = major_version(cl)
    if !ok do return
    result.minor_version, ok = minor_version(cl)
    if !ok do return
    result.revision, ok = revision(cl)
    if !ok do return

    return result, true
}

connectedlibrary_to_com :: proc(src: t.Library) -> (result: ConnectedLibrary, ok: bool) {
    cl: ConnectedLibrary
    cl, ok = connectedlibrary_new1(src.name, src.major_version, src.minor_version, src.revision)
    if !ok do return

    return cl, true
}

connectedlibraries_from_com :: proc(cls: ConnectedLibraries, allocator := context.allocator) -> (result: [dynamic]t.Library, ok: bool) {
    if cls == nil do return
    context.allocator = allocator

    count: i32
    count, ok = connectedlibrary_count(cls)
    if !ok do return

    result = make([dynamic]t.ConnectedLibrary, 0, int(count), allocator)
    for i in 0..<count {
        cl: ConnectedLibrary
        cl, ok = connectedlibrary_by_index(cls, i)
        if !ok do return
        defer release(cl)

        cls_: t.ConnectedLibrary
        cls_, ok = connectedlibrary_from_com(cl)
        if !ok do return
        append(&result, cls_)
    }
    return result, true
}

connectedlibraries_to_com :: proc(cls: ConnectedLibraries, src: []t.Library) -> (ok: bool) {
    if cls == nil do return
    for item in src {
        cl: ConnectedLibrary
        cl, ok = connectedlibrary_to_com(item)
        if !ok do return
        defer release(cl)
        ok = connectedlibrary_add(cls, cl)
        if !ok do return
    }
    return true
}

connectedhwlibrary_from_com :: proc(chl: ConnectedHWLibrary, allocator := context.allocator) -> (result: t.Library, ok: bool) {
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

connectedhwlibrary_to_com :: proc(src: t.Library) -> (result: ConnectedHWLibrary, ok: bool) {
    chl: ConnectedHWLibrary
    chl, ok = connectedhwlibrary_new1(src.name, src.major_version, src.minor_version, src.revision)
    if !ok do return

    return chl, true
}

connectedhwlibraries_from_com :: proc(chls: ConnectedHWLibraries, allocator := context.allocator) -> (result: [dynamic]t.Library, ok: bool) {
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

connectedhwlibraries_to_com :: proc(chls: ConnectedHWLibraries, src: []t.Library) -> (ok: bool) {
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
