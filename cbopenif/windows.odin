package cbopenif

import "core:sys/windows"

GUID    :: windows.GUID
HResult :: windows.HRESULT

UnknownAndDispatchIF :: struct #raw_union {
    using vtable: ^UnknownAndDispatchVTable,
}

UnknownAndDispatchVTable :: struct {
    // IUnkown
    QueryInterface:   proc "system" (this: ^UnknownAndDispatchIF, riid: ^GUID, ppvObject: ^rawptr) -> HResult,
    AddRef:           proc "system" (this: ^UnknownAndDispatchIF) -> u32,
    Release:          proc "system" (this: ^UnknownAndDispatchIF) -> u32,
    
    // IDispatch
    GetTypeInfoCount: proc "system" (this: ^UnknownAndDispatchIF, pctinfo: ^u32) -> HResult,
    GetTypeInfo:      proc "system" (this: ^UnknownAndDispatchIF, iTInfo: u32, lcid: u32, ppTInfo: ^rawptr) -> HResult,
    GetIDsOfNames:    proc "system" (this: ^UnknownAndDispatchIF, riid: ^GUID, rgszNames: [^][^]u16, cNames: u32, lcid: u32, rgDispId: [^]i32) -> HResult,
    Invoke:           proc "system" (this: ^UnknownAndDispatchIF, dispIdMember: i32, riid: ^GUID, lcid: u32, wFlags: u16, pDispParams: rawptr, pVarResult: rawptr, pExcepInfo: rawptr, puArgErr: ^u32) -> HResult,
}

com_initialize :: proc() -> (ok: bool) {
    hr := windows.CoInitializeEx(nil, windows.COINIT.APARTMENTTHREADED)
    if failed(hr) do return false
    return true
}

com_create_instance :: proc(clsid: windows.REFCLSID, iid: windows.REFIID, vtable: ^windows.LPVOID) -> (ok: bool) {
    ok = false

    hr := windows.CoCreateInstance(
        clsid,
        nil,
        windows.CLSCTX_LOCAL_SERVER | windows.CLSCTX_INPROC_SERVER,
        iid,
        vtable,
    )
    if failed(hr) do return

    return true
}

com_uninitialize :: proc() {
    windows.CoUninitialize()
}

failed :: proc(hr: HResult) -> (failed: bool) {
    return windows.FAILED(hr)
}
