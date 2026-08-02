package com

import "core:sys/windows"

import "../bstr"
import "../variant"

@(private) BStr    :: bstr.BStr
@(private) Variant :: variant.Variant

GUID    :: windows.GUID
HResult :: windows.HRESULT

IID_NULL := GUID{}

DISPATCH_METHOD      :: u16(0x1)
DISPATCH_PROPERTYGET :: u16(0x2)
DISPATCH_PROPERTYPUT :: u16(0x4)

LOCALE_USER_DEFAULT  :: u32(0x400)

// DISPID for named PROPERTYPUT is always DISPID_PROPERTYPUT
DISPID_PROPERTYPUT   :: i32(-3)

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

initialize :: proc() -> (ok: bool) {
    hr := windows.CoInitializeEx(nil, windows.COINIT.APARTMENTTHREADED)
    if failed(hr) do return false
    return true
}

create_instance :: proc(clsid: windows.REFCLSID, iid: windows.REFIID, vtable: ^windows.LPVOID) -> (ok: bool) {

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

uninitialize :: proc() {
    windows.CoUninitialize()
}

failed :: proc(hr: HResult) -> (failed: bool) {
    return windows.FAILED(hr)
}

get_dispid :: proc(this: ^IUnknownIF, name: string) -> (id: i32, ok: bool) {

    if this == nil do return

    wide := windows.utf8_to_utf16(name, context.temp_allocator)
    if wide == nil do return

    // GetIDsOfNames wants an array of LPOLESTR
    name_ptr: [^]u16 = raw_data(wide)
    names: [1][^]u16 = { name_ptr }
    dispids: [1]i32

    iid_null := IID_NULL
    hr := this.vtable.GetIDsOfNames(
        this,
        &iid_null,
        raw_data(names[:]),
        1,
        LOCALE_USER_DEFAULT,
        raw_data(dispids[:]),
    )
    if failed(hr) do return

    return dispids[0], true
}

invoke :: proc(this: ^IUnknownIF, dispid: i32, args: []Variant, result: ^Variant, wflags := DISPATCH_METHOD) -> (hr: HResult, arg_err: u32) {
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
        variant.init(result)
    }

    excep: EXCEPINFO
    iid_null := IID_NULL

    hr = this.vtable.Invoke(
        this,
        dispid,
        &iid_null,
        LOCALE_USER_DEFAULT,
        wflags,
        &dp,
        result,
        &excep,
        &arg_err,
    )

    // Free EXCEPINFO strings if present
    if excep.bstrSource != nil      do bstr.free(excep.bstrSource)
    if excep.bstrDescription != nil do bstr.free(excep.bstrDescription)
    if excep.bstrHelpFile != nil    do bstr.free(excep.bstrHelpFile)

    return hr, arg_err
}

// Invoke by name (GetIDsOfNames + Invoke)
invoke_name :: proc(this: ^IUnknownIF, name: string, args: []Variant, result: ^Variant = nil, wflags := DISPATCH_METHOD) -> (hr: HResult, arg_err: u32, ok: bool) {
    hr = HResult(-2147352573) // DISP_E_MEMBERNOTFOUND-ish 0x80020003

    dispid, found := get_dispid(this, name)
    if !found do return
    
    hr, arg_err = invoke(this, dispid, args, result, wflags)
    
    return hr, arg_err, !failed(hr)
}
