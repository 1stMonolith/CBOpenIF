package cbopenif

import "com"

Library :: struct
{
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

NewLibrary :: proc(name, path: string) -> (ok: bool)
{
    return com.NewLibrary(name, path, "")
}

RenameLibrary :: proc(name, new_name: string) -> (ok: bool)
{
    return com.RenameLibrary(name, new_name)
}

DeleteLibrary :: proc(name: string) -> (ok: bool)
{
    return com.DeleteLibrary(name)
}

ConnectLibrary :: proc(application_name, library_name: string) -> (ok: bool)
{
    librariesxml: string
    librariesxml, ok = com.GetConnectedLibrariesAsXML(application_name)

    comconnectedlibraries: com.ConnectedLibraries
    comconnectedlibraries, ok = com.DeserializeConnectedLibraries(librariesxml)
    defer com.Release(comconnectedlibraries)

    comconnectedlibrary: com.ConnectedLibrary
    comconnectedlibrary, ok = com.NewConnectedLibrary(library_name)
    defer com.Release(comconnectedlibrary)

    ok = com.AddConnectedLibrary(comconnectedlibraries, comconnectedlibrary)

    librariesxml, ok = com.Serialize(comconnectedlibraries)

    msg: string
    msg, ok = com.SetConnectedLibrariesFromXML(application_name, librariesxml)

    return true
}

RemoveLibrary :: proc(application_name, library_name: string) -> (ok: bool)
{
    librariesxml: string
    librariesxml, ok = com.GetConnectedLibrariesAsXML(application_name)

    comconnectedlibraries: com.ConnectedLibraries
    comconnectedlibraries, ok = com.DeserializeConnectedLibraries(librariesxml)
    defer com.Release(comconnectedlibraries)

    ok = com.RemoveConnectedLibrary(comconnectedlibraries, library_name)

    librariesxml, ok = com.Serialize(comconnectedlibraries)

    msg: string
    msg, ok = com.SetConnectedLibrariesFromXML(application_name, librariesxml)

    return true
}

ConnectedLibrariesFromCom :: proc(comconnectedlibraries: com.ConnectedLibraries, libraries: ^[dynamic]Library) -> (ok: bool)
{
    if comconnectedlibraries == nil do return

    count: i32
    count, ok = com.ConnectedLibraryCount(comconnectedlibraries)
    if !ok do return

    for i in 0..<count {
        comconnectedlibrary: com.ConnectedLibrary
        comconnectedlibrary, ok = com.GetConnectedLibrary(comconnectedlibraries, i)
        if !ok do return
        defer com.Release(comconnectedlibrary)

        library: Library
        library, ok = ConnectedLibraryFromCom(comconnectedlibrary)
        if !ok do return
        append(libraries, library)
    }
    return true
}

ConnectedLibraryFromCom :: proc(comconnectedlibrary: com.ConnectedLibrary) -> (library: Library, ok: bool)
{
    if comconnectedlibrary == nil do return

    library.name, ok = com.Name(comconnectedlibrary)
    if !ok do return

    library.major_version, ok = com.MajorVersion(comconnectedlibrary)
    if !ok do return

    library.minor_version, ok = com.MinorVersion(comconnectedlibrary)
    if !ok do return

    library.revision, ok = com.Revision(comconnectedlibrary)
    if !ok do return

    return library, true
}

ConnectedLibrariesToCom :: proc(libraries: []Library) -> (comconnectedlibraries: com.ConnectedLibraries, ok: bool)
{
    for library in libraries {
        comconnectedlibrary: com.ConnectedLibrary
        comconnectedlibrary, ok = ConnectedLibraryToCom(library)
        if !ok do return
        defer com.Release(comconnectedlibrary)

        ok = com.AddConnectedLibrary(comconnectedlibraries, comconnectedlibrary)
        if !ok do return
    }
    return comconnectedlibraries, true
}

ConnectedLibraryToCom :: proc(library: Library) -> (comconnectedlibrary: com.ConnectedLibrary, ok: bool)
{
    return com.NewConnectedLibraryEx(library.name, library.major_version, library.minor_version, library.revision)
}

ConnectedHWLibrariesFromCom :: proc(comconnectedhwlibraries: com.ConnectedHWLibraries, libraries: ^[dynamic]Library) -> (ok: bool)
{
    if comconnectedhwlibraries == nil do return

    count: i32
    count, ok = com.ConnectedHWLibraryCount(comconnectedhwlibraries)
    if !ok do return

    for i in 0..<count {
        comconnectedhwlibrary: com.ConnectedHWLibrary
        comconnectedhwlibrary, ok = com.GetConnectedHWLibrary(comconnectedhwlibraries, i)
        if !ok do return
        defer com.Release(comconnectedhwlibrary)

        library: Library
        library, ok = ConnectedHWLibraryFromCom(comconnectedhwlibrary)
        if !ok do return
        append(libraries, library)
    }
    
    return true
}

ConnectedHWLibraryFromCom :: proc(comconnectedhwlibrary: com.ConnectedHWLibrary) -> (library: Library, ok: bool)
{
    if comconnectedhwlibrary == nil do return

    library.name, ok = com.Name(comconnectedhwlibrary)
    if !ok do return

    library.major_version, ok = com.MajorVersion(comconnectedhwlibrary)
    if !ok do return

    library.minor_version, ok = com.MinorVersion(comconnectedhwlibrary)
    if !ok do return

    library.revision, ok = com.Revision(comconnectedhwlibrary)
    if !ok do return

    return library, true
}

ConnectedHWLibrariesToCom :: proc(libraries: []Library) -> (comconnectedhwlibraries: com.ConnectedHWLibraries, ok: bool)
{
    for library in libraries {
        comconnectedhwlibrary: com.ConnectedHWLibrary
        comconnectedhwlibrary, ok = ConnectedHWLibraryToCom(library)
        if !ok do return
        defer com.Release(comconnectedhwlibrary)
        
        ok = com.AddConnectedHWLibrary(comconnectedhwlibraries, comconnectedhwlibrary)
        if !ok do return
    }
    
    return comconnectedhwlibraries, true
}

ConnectedHWLibraryToCom :: proc(library: Library) -> (comconnectedhwlibrary: com.ConnectedHWLibrary, ok: bool)
{
    return com.NewConnectedHWLibraryEx(library.name, library.major_version, library.minor_version, library.revision)
}
