package cbopenif

import "core:sys/windows"

GUID    :: windows.GUID
HResult :: windows.HRESULT

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
