package com

import "core:sys/windows"

import "../bstr"
@(private) BStr :: bstr.BStr

GUID    :: windows.GUID
HResult :: windows.HRESULT

IUnknownIF :: struct #raw_union {
    using vtable: ^IUnknownVTable,
}

IUnknownVTable :: struct {
    // IUnkown
    QueryInterface:   proc "system" (this: ^IUnknownIF, riid: ^GUID, ppvObject: ^rawptr) -> HResult,
    AddRef:           proc "system" (this: ^IUnknownIF) -> u32,
    Release:          proc "system" (this: ^IUnknownIF) -> u32,
    
    // IDispatch
    GetTypeInfoCount: proc "system" (this: ^IUnknownIF, pctinfo: ^u32) -> HResult,
    GetTypeInfo:      proc "system" (this: ^IUnknownIF, iTInfo: u32, lcid: u32, ppTInfo: ^rawptr) -> HResult,
    GetIDsOfNames:    proc "system" (this: ^IUnknownIF, riid: ^GUID, rgszNames: [^][^]u16, cNames: u32, lcid: u32, rgDispId: [^]i32) -> HResult,
    Invoke:           proc "system" (this: ^IUnknownIF, dispIdMember: i32, riid: ^GUID, lcid: u32, wFlags: u16, pDispParams: rawptr, pVarResult: rawptr, pExcepInfo: rawptr, puArgErr: ^u32) -> HResult,
}

initialize :: proc() -> (ok: bool) {
    hr := windows.CoInitializeEx(nil, windows.COINIT.APARTMENTTHREADED)
    if com.failed(hr) do return false
    return true
}

create_instance :: proc(clsid: windows.REFCLSID, iid: windows.REFIID, vtable: ^windows.LPVOID) -> (ok: bool) {
    ok = false

    hr := windows.CoCreateInstance(
        clsid,
        nil,
        windows.CLSCTX_LOCAL_SERVER | windows.CLSCTX_INPROC_SERVER,
        iid,
        vtable,
    )
    if com.failed(hr) do return

    return true
}

uninitialize :: proc() {
    windows.CoUninitialize()
}

failed :: proc(hr: HResult) -> (failed: bool) {
    return windows.FAILED(hr)
}
