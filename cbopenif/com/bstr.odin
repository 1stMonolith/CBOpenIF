package com

import "base:runtime"
import "core:sys/windows"

BStr :: distinct rawptr

foreign import oleaut32 "system:oleaut32.lib"

@(default_calling_convention="system")
foreign oleaut32 {
    SysAllocStringLen :: proc(psz: [^]u16, len: u32) -> BStr ---
    SysFreeString     :: proc(bs: BStr) ---
    SysStringLen      :: proc(bs: BStr) -> u32 ---
}

to_bstr :: proc(s: string) -> (bs: BStr) {
    bs = nil
    
    if len(s) == 0 do return

    // Returns []u16 (not null-terminated in the slice length, but the
    // allocated block is null-terminated for the wstring helpers).
    wide := windows.utf8_to_utf16(s, context.temp_allocator)
    if wide == nil do return

    bs = SysAllocStringLen(raw_data(wide), u32(len(wide)))
    
    return
}

from_bstr :: proc(bs: BStr, allocator := context.allocator) -> (s: string) {
    s = ""

    if bs == nil do return

    character_count := SysStringLen(bs)
    if character_count == 0 do return

    // bstr is a pointer to the first UTF-16 character
    wide := windows.wstring(bs)

    err: runtime.Allocator_Error
    s, err = windows.wstring_to_utf8(wide, int(character_count), allocator)
    if err != nil do return
    
    return s
}

bstr_free :: proc(bs: BStr) {
    SysFreeString(bs)
}
