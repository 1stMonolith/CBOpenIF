package cbopenif

import "core:sys/windows"

foreign import oleaut32 "system:oleaut32.lib"

GUID    :: windows.GUID
HResult :: windows.HRESULT

UnknownAndDispatchIF :: struct #raw_union {
    using vtable: ^UnknownAndDispatchVTable,
}

UnknownAndDispatchVTable :: struct {
    // IUnkown
    QueryInterface:         proc "system" (this: ^UnknownAndDispatchIF, riid: ^GUID, ppvObject: ^rawptr) -> HResult,
    AddRef:                 proc "system" (this: ^UnknownAndDispatchIF) -> u32,
    Release:                proc "system" (this: ^UnknownAndDispatchIF) -> u32,
    
    // IDispatch
    GetTypeInfoCount:       proc "system" (this: ^UnknownAndDispatchIF, pctinfo: ^u32) -> HResult,
    GetTypeInfo:            proc "system" (this: ^UnknownAndDispatchIF, iTInfo: u32, lcid: u32, ppTInfo: ^rawptr) -> HResult,
    GetIDsOfNames:          proc "system" (this: ^UnknownAndDispatchIF, riid: ^GUID, rgszNames: [^][^]u16, cNames: u32, lcid: u32, rgDispId: [^]i32) -> HResult,
    Invoke:                 proc "system" (this: ^UnknownAndDispatchIF, dispIdMember: i32, riid: ^GUID, lcid: u32, wFlags: u16, pDispParams: rawptr, pVarResult: rawptr, pExcepInfo: rawptr, puArgErr: ^u32) -> HResult,
}

failed :: proc(hr: HResult) -> bool {
    return windows.FAILED(hr)
}

BStr :: distinct rawptr

@(default_calling_convention="system")
foreign oleaut32 {
    SysAllocString    :: proc(psz: [^]u16) -> BStr ---
    SysAllocStringLen :: proc(psz: [^]u16, len: u32) -> BStr ---
    SysFreeString     :: proc(bstr: BStr) ---
    SysStringLen      :: proc(bstr: BStr) -> u32 ---
}

string_to_bstr :: proc(s: string) -> BStr {
    if len(s) == 0 {
        return nil
    }

    // Returns []u16 (not null-terminated in the slice length, but the
    // allocated block is null-terminated for the wstring helpers).
    wide := windows.utf8_to_utf16(s, context.temp_allocator)
    if wide == nil {
        return nil
    }

    result := SysAllocStringLen(raw_data(wide), u32(len(wide)))
    return result
}

bstr_to_string :: proc(BStr: BStr, allocator := context.allocator) -> string {
    if BStr == nil do return ""

    n := int(SysStringLen(BStr)) // character count
    if n == 0 do return ""

    // BStr is a pointer to the first UTF-16 character
    wide := windows.wstring(BStr)

    s, err := windows.wstring_to_utf8(wide, n, allocator)
    if err != nil do return ""
    return s
}

@(default_calling_convention="system")
foreign oleaut32 {
    VariantInit       :: proc(pvarg: ^Variant) ---
    VariantClear       :: proc(pvarg: ^Variant) ---
}

VariantType      :: distinct u16
VariantTypeEmpty    :: VariantType(0)
VariantTypeNull     :: VariantType(1)
VariantTypeI2       :: VariantType(2)
VariantTypeI4       :: VariantType(3)
VariantTypeR4       :: VariantType(4)
VariantTypeR8       :: VariantType(5)
VariantTypeCY       :: VariantType(6)
VariantTypeDate     :: VariantType(7)
VariantTypeBstr     :: VariantType(8)
VariantTypeDispatch :: VariantType(9)
VariantTypeError    :: VariantType(10)
VariantTypeBool     :: VariantType(11)
VariantTypeVariant  :: VariantType(12)
VariantTypeUnknown  :: VariantType(13)
VariantTypeDecimal  :: VariantType(14)
VariantTypeI1       :: VariantType(16)
VariantTypeUI1      :: VariantType(17)
VariantTypeUI2      :: VariantType(18)
VariantTypeUI4      :: VariantType(19)
VariantTypeI8       :: VariantType(20)
VariantTypeUI8      :: VariantType(21)
VariantTypeInt      :: VariantType(22)
VariantTypeUint     :: VariantType(23)

VariantBool      :: distinct i16
VariantBoolTrue  :: VariantBool(-1)
VariantBoolFalse :: VariantBool(0)

Variant :: struct #raw_union {
    using _: struct {
        vt:         VariantType,
        wReserved1: u16,
        wReserved2: u16,
        wReserved3: u16,
        using _: struct #raw_union {
            llVal:    i64,
            lVal:     i32,
            bVal:     u8,
            iVal:     i16,
            fltVal:   f32,
            dblVal:   f64,
            boolVal:  VariantBool,
            scode:    i32,
            bstrVal:  BStr,
            punkVal:  rawptr, // ^IUnknown
            pdispVal: rawptr, // ^IDispatch
            puintVal: ^u32,
        },
    },
}

string_to_variant :: proc(s: string) -> Variant {
    v: Variant
    VariantInit(&v)
    v.vt = VariantTypeBstr
    v.bstrVal = string_to_bstr(s)
    return v
}

bool_to_variant :: proc(b: bool) -> Variant {
    v: Variant
    VariantInit(&v)
    v.vt = VariantTypeBool
    if b do v.boolVal = VariantBoolTrue
    if !b do v.boolVal = VariantBoolFalse
    return v
}