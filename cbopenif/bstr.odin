package cbopenif

import "core:sys/windows"

BStr :: distinct rawptr

foreign import oleaut32 "system:oleaut32.lib"

@(default_calling_convention="system")
foreign oleaut32 {
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

bstr_to_string :: proc(bstr: BStr, allocator := context.allocator) -> string {
    if bstr == nil do return ""

    n := int(SysStringLen(bstr)) // character count
    if n == 0 do return ""

    // BStr is a pointer to the first UTF-16 character
    wide := windows.wstring(bstr)

    s, err := windows.wstring_to_utf8(wide, n, allocator)
    if err != nil do return ""
    return s
}

bstr_free :: proc(bstr: BStr) {
    SysFreeString(bstr)
}
