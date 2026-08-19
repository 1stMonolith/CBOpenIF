package registry

import "core:fmt"
import "core:os"
import win "core:sys/windows"

CBHELPER_CLISID_STRING :: "{3CEFCA96-1892-4539-8747-292BB8AE1D4B}"
CBHELPER_DLL           :: "CBOpenIFHelper.dll"

registry_key_exists :: proc(key_path: string) -> (exists: bool) {
    key: win.HKEY
    status := win.RegOpenKeyExW(
        win.HKEY_CLASSES_ROOT,
        win.utf8_to_wstring(key_path),
        0,
        win.KEY_READ | win.KEY_WOW64_32KEY,
        &key,
    )
    if status != i32(win.ERROR_SUCCESS) do return
    defer win.RegCloseKey(key)
    return true
}

registry_key_get :: proc(key_path: string) -> (ok: bool, key: win.HKEY) {
    status := win.RegOpenKeyExW(
        win.HKEY_CLASSES_ROOT,
        win.utf8_to_wstring(key_path),
        0,
        win.KEY_READ | win.KEY_WRITE | win.KEY_WOW64_32KEY,
        &key,
    )
    if status != i32(win.ERROR_SUCCESS) do return
    return true, key
}

registry_key_create :: proc(key_path: string) -> (ok: bool, key: win.HKEY) {
        status := win.RegCreateKeyExW(
            win.HKEY_CLASSES_ROOT,
            win.utf8_to_wstring(key_path),
            0,
            nil,
            win.REG_OPTION_NON_VOLATILE,
            win.KEY_ALL_ACCESS,
            nil,
            &key,
            nil,
        )
    if status != i32(win.ERROR_SUCCESS) do return
    return true, key
}

registry_value_exists :: proc(key: win.HKEY, value_name: string) -> (exists: bool) {

    status := win.RegGetValueW(
        key,
        nil,
        win.utf8_to_wstring(value_name),
        win.RRF_RT_ANY,
        nil,
        nil,
        nil,
    )
    if status != i32(win.ERROR_SUCCESS) do return false
    return true
}

registry_value_set :: proc(key: win.HKEY, name, value: string) -> (ok: bool) {

    name_w := win.utf8_to_wstring(name)
    value_w := win.utf8_to_wstring(value)

    status := win.RegSetValueExW(
        key,
        name_w,
        0,
        win.REG_SZ,
        cast(^win.BYTE)rawptr(value_w),
        u32((len(value) + 1) * size_of(u16)),
    )
    if status != i32(win.ERROR_SUCCESS) do return
    return true
}

register_surrogate :: proc() -> bool {
    
    fmt.print("Registering CBOpenIFHelper.dll with regsvr32.exe ...")
    { // Register the 32-bit DLL
        regsvr32 := "C:\\Windows\\SysWOW64\\regsvr32.exe"
        dllpath  := "C:\\Windows\\SysWOW64\\" + CBHELPER_DLL
        args := fmt.tprintf("/s \"%s\"", dllpath)
        
        cmd := win.utf8_to_wstring(fmt.tprintf( "\"%s\" %s", regsvr32, args))
        defer delete(cmd)

        si: win.STARTUPINFOW
        si.cb = size_of(si)
        pi: win.PROCESS_INFORMATION

        if !win.CreateProcessW(nil, cmd, nil, nil, false, 0, nil, nil, &si, &pi) {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
        
        win.WaitForSingleObject(pi.hProcess, win.INFINITE)
        win.CloseHandle(pi.hProcess)
        win.CloseHandle(pi.hThread)
    }

    {
        key_path := fmt.tprintf("Wow6432Node\\CLSID\\%s", CBHELPER_CLISID_STRING)
        
        fmt.printf("Looking for key %v ... ", key_path)
        if !registry_key_exists(key_path) {
            fmt.println("Not Found")
            return false
        }
        fmt.println("Found")

        fmt.printf("Getting key %v ... ", key_path)
        ok, key := registry_key_get(key_path)
        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
        defer win.RegCloseKey(key)

        fmt.printf("creating AppID value... ")
        ok = registry_value_set(key, "AppID", CBHELPER_CLISID_STRING)

        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
    }

    {
        ok: bool
        key: win.HKEY
        key_path := fmt.tprintf("Wow6432Node\\AppID\\%s", CBHELPER_CLISID_STRING)

        fmt.printf("Looking for key %v ... ", key_path)
        found := registry_key_exists(key_path)
        if !found {
            fmt.println("Not Found")
            
            fmt.printf("Creating key %v ... ", key_path)
            ok, key = registry_key_create(key_path)
            if !ok {
                fmt.println("Failed")
                return false
            }
            fmt.println("Success")
            defer win.RegCloseKey(key)
        }
        if found {
            fmt.println("Found")
        }

        fmt.printf("Getting key %v ... ", key_path)
        ok, key = registry_key_get(key_path)
        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
        defer win.RegCloseKey(key)

        fmt.printf("creating DllSurrogate value... ")
        ok = registry_value_set(key, "DllSurrogate", "")

        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
    }

    return true
}