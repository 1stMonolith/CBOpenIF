package com

import win "core:sys/windows"

GUID    :: win.GUID
HResult :: win.HRESULT

CBOPENIF_CLSID :: GUID{0x45902D56, 0xD537, 0x486C, {0x89, 0x1B, 0x81, 0x1C, 0xDA, 0x41, 0x0C, 0x77}}
CBOPENIF_IID   :: GUID{0xEDF53D60, 0xF499, 0x4EDC, {0xAB, 0x7F, 0x10, 0x38, 0x95, 0xFE, 0x89, 0x91}}
CBHELPER_CLSID :: GUID{0x3CEFCA96, 0x1892, 0x4539, {0x87, 0x47, 0x29, 0x2B, 0xB8, 0xAE, 0x1D, 0x4B}}
CBHELPER_IID   :: GUID{0x9198E466, 0x81F5, 0x4756, {0xB3, 0x9A, 0x12, 0xC7, 0x7F, 0xF5, 0xFF, 0x1A}}
NULL_IID       :: GUID{}

com_connect :: proc() -> (ok: bool) {
    ok = false
    clsid, iid: GUID

    if objectfactory != nil do return

    ok = com_initialize()
    if !ok do return

    clsid = CBOPENIF_CLSID
    iid = CBOPENIF_IID

    ok = com_create_instance(&clsid, &iid, cast(^rawptr)&cbopenif)
    if !ok {
        win.CoUninitialize()
        cbopenif = nil
        return
    }

    clsid = CBHELPER_CLSID
    iid = CBHELPER_IID

    ok = com_create_instance(&clsid, &iid, cast(^rawptr)&objectfactory)
    if !ok {
        win.CoUninitialize()
        objectfactory = nil
        return
    }

    return true
}

com_connected :: proc() -> (ok: bool) {
    if (cbopenif != nil) & (objectfactory != nil) do return true
    return false
}

com_disconnect :: proc()  -> (ok: bool) {
    if objectfactory != nil {
        objectfactory->Release()
        objectfactory = nil
    }

    if cbopenif != nil {
        cbopenif->Release()
        cbopenif = nil
    }

    win.CoUninitialize()

    return true
}

com_initialize :: proc() -> (ok: bool) {
    hr := win.CoInitializeEx(nil, win.COINIT.APARTMENTTHREADED)
    if com_failed(hr) do return false
    return true
}

com_create_instance :: proc(clsid: win.REFCLSID, iid: win.REFIID, vtable: ^win.LPVOID) -> (ok: bool) {
    hr := win.CoCreateInstance(
        clsid,
        nil,
        win.CLSCTX_LOCAL_SERVER | win.CLSCTX_INPROC_SERVER,
        iid,
        vtable,
    )
    if com_failed(hr) do return

    return true
}

com_failed :: proc(hr: HResult) -> (failed: bool) {
    return win.FAILED(hr)
}

DISPATCH_METHOD      :: u16(0x1)
DISPATCH_PROPERTYGET :: u16(0x2)
DISPATCH_PROPERTYPUT :: u16(0x4)
LOCALE_USER_DEFAULT  :: u32(0x400)
DISPID_PROPERTYPUT   :: i32(-3)     // DISPID for named PROPERTYPUT is always DISPID_PROPERTYPUT

DISPPARAMS :: struct {
    rgvarg:            [^]Variant,
    rgdispidNamedArgs: [^]i32,
    cArgs:             u32,
    cNamedArgs:        u32,
}

EXCEPINFO :: struct {
    wCode:             u16,
    wReserved:         u16,
    bstrSource:        BStr,
    bstrDescription:   BStr,
    bstrHelpFile:      BStr,
    dwHelpContext:     u32,
    pvReserved:        rawptr,
    pfnDeferredFillIn: rawptr,
    scode:             i32,
}

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
    Invoke:           proc "system" (this: ^IUnknownIF, dispIdMember: i32, riid: ^GUID, lcid: u32, wFlags: u16, pDispParams: ^DISPPARAMS, pVarResult: ^Variant, pExcepInfo: ^EXCEPINFO, puArgErr: ^u32) -> HResult,
}

com_get_dispid :: proc(this: ^IUnknownIF, name: string) -> (id: i32, ok: bool) {
    if this == nil do return

    wide := win.utf8_to_utf16(name, context.temp_allocator)
    if wide == nil do return

    // GetIDsOfNames wants an array of LPOLESTR
    name_ptr: [^]u16 = raw_data(wide)
    names: [1][^]u16 = { name_ptr }
    dispids: [1]i32

    iid := NULL_IID
    hr := this.vtable.GetIDsOfNames(
        this,
        &iid,
        raw_data(names[:]),
        1,
        LOCALE_USER_DEFAULT,
        raw_data(dispids[:]),
    )
    if com_failed(hr) do return

    return dispids[0], true
}

com_invoke :: proc(this: ^IUnknownIF, dispid: i32, args: []Variant, result: ^Variant, wflags := DISPATCH_METHOD) -> (hr: HResult) {
    hr = HResult(-2147467259) // E_FAIL default 0x80004005
    
    if this == nil do return

    dp: DISPPARAMS
    dp.cNamedArgs = 0
    dp.rgdispidNamedArgs = nil

    // Reverse copy for Invoke
    n := len(args)
    reversed: [dynamic]Variant
    if n > 0 {
        reversed = make([dynamic]Variant, n, context.temp_allocator)
        for i in 0..<n {
            reversed[n - 1 - i] = args[i]
        }
        dp.rgvarg = raw_data(reversed)
        dp.cArgs = u32(n)
    } else {
        dp.rgvarg = nil
        dp.cArgs = 0
    }

    if result != nil {
        variant_init(result)
    }

    excep: EXCEPINFO
    iid := NULL_IID

    arg_err: u32
    hr = this.vtable.Invoke(
        this,
        dispid,
        &iid,
        LOCALE_USER_DEFAULT,
        wflags,
        &dp,
        result,
        &excep,
        &arg_err,
    )

    // Free EXCEPINFO strings if present
    if excep.bstrSource != nil      do bstr_free(excep.bstrSource)
    if excep.bstrDescription != nil do bstr_free(excep.bstrDescription)
    if excep.bstrHelpFile != nil    do bstr_free(excep.bstrHelpFile)

    return hr
}

// Invoke by name (GetIDsOfNames + Invoke)
com_invoke_name :: proc(this: ^IUnknownIF, name: string, args: []Variant, result: ^Variant = nil, wflags := DISPATCH_METHOD) -> (ok: bool) {
    hr := HResult(-2147352573) // DISP_E_MEMBERNOTFOUND-ish 0x80020003

    dispid, found := com_get_dispid(this, name)
    if !found do return
    
    hr = com_invoke(this, dispid, args, result, wflags)
    
    return !com_failed(hr)
}
