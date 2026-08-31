package com

import "core:fmt"
import "core:strings"
import "core:os"
import win "core:sys/windows"

CBHELPER_CLISID_STRING :: "{3CEFCA96-1892-4539-8747-292BB8AE1D4B}"
CBHELPER_DLL           :: "CBOpenIFHelper.dll"

CheckSurrogate :: proc() -> bool
{
    { // registry key "Wow6432Node\CLSID\{3CEFCA96-1892-4539-8747-292BB8AE1D4B}" must exist 
      // and have "AppID" string value of "{3CEFCA96-1892-4539-8747-292BB8AE1D4B}"
        clsid_path := fmt.tprintf("Wow6432Node\\CLSID\\%s", CBHELPER_CLISID_STRING)

        if !RegistryKeyExists(clsid_path) do return false

        key: win.HKEY
        ok: bool
        ok, key = GetRegistryKeyRead(clsid_path)
        if !ok do return false
        defer win.RegCloseKey(key)

        if !RegistryValueExists(key, "AppID") do return false

        // TODO: verify the value has correct data
    }

    { // registry key "Wow6432Node\AppID\{3CEFCA96-1892-4539-8747-292BB8AE1D4B}" must exist 
      // and have "DllSurrogate" string value of ""
        appid_path := fmt.tprintf("Wow6432Node\\AppID\\%s", CBHELPER_CLISID_STRING)

        if !RegistryKeyExists(appid_path) do return false

        key: win.HKEY
        ok: bool
        ok, key = GetRegistryKeyRead(appid_path)
        if !ok do return false
        defer win.RegCloseKey(key)

        if !RegistryValueExists(key, "DllSurrogate") do return false

        // TODO: verify the value has correct data
    }

    return true
}

RegisterSurrogate :: proc() -> bool
{
    if CheckSurrogate() {
        fmt.println("COM surrogate registry settings present - skipping registration")
        return true
    }

    if !ProcessIsElevated() {
        RelaunchAsElevated()
        fmt.println("COM surrogate registry settings are missing.")
        fmt.println("Please re-run this program as Administrator so the required registry keys can be created.")
        return false
    }
    
    fmt.print("Registering CBOpenIFHelper.dll with regsvr32.exe ...")
    { // Register the 32-bit DLL
        regsvr32 := "C:\\Windows\\SysWOW64\\regsvr32.exe"
        dllpath  := "C:\\Windows\\SysWOW64\\" + CBHELPER_DLL
        args := fmt.tprintf("/s \"%s\"", dllpath)
        
        cmd := win.utf8_to_wstring(fmt.tprintf( "\"%s\" %s", regsvr32, args), context.allocator)
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
        ok: bool
        key: win.HKEY
        clsid_path := fmt.aprintf("Wow6432Node\\CLSID\\%s", CBHELPER_CLISID_STRING)
        defer delete(clsid_path)
        
        fmt.printf("Looking for key %v ... ", clsid_path)
        if !RegistryKeyExists(clsid_path) {
            fmt.println("Not Found")
            return false
        }
        fmt.println("Found")

        fmt.printf("Getting key %v ... ", clsid_path)
        ok, key = GetRegistryKeyReadWrite(clsid_path)
        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
        defer win.RegCloseKey(key)

        fmt.printf("creating AppID value... ")
        ok = SetRegistryValue(key, "AppID", CBHELPER_CLISID_STRING)

        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
    }

    {
        ok: bool
        key: win.HKEY
        appid_path := fmt.aprintf("Wow6432Node\\AppID\\%s", CBHELPER_CLISID_STRING)
        defer delete(appid_path)

        fmt.printf("Looking for key %v ... ", appid_path)
        if RegistryKeyExists(appid_path) {
            fmt.println("Found")
            fmt.printf("Getting key %v ... ", appid_path)
            ok, key = GetRegistryKeyReadWrite(appid_path)
        } else {
            fmt.println("Not Found")
            fmt.printf("Creating key %v ... ", appid_path)
            ok, key = CreateRegistryKey(appid_path)
        }
        if !ok {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
        defer win.RegCloseKey(key)

        fmt.printf("creating DllSurrogate value... ")
        if !SetRegistryValue(key, "DllSurrogate", "") {
            fmt.println("Failed")
            return false
        }
        fmt.println("Success")
    }

    return true
}

RegistryKeyExists :: proc(key_path: string) -> (exists: bool)
{
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

GetRegistryKeyReadWrite :: proc(key_path: string) -> (ok: bool, key: win.HKEY)
{
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

GetRegistryKeyRead :: proc(key_path: string) -> (ok: bool, key: win.HKEY)
{
    status := win.RegOpenKeyExW(
        win.HKEY_CLASSES_ROOT,
        win.utf8_to_wstring(key_path),
        0,
        win.KEY_READ | win.KEY_WOW64_32KEY,
        &key,
    )
    if status != i32(win.ERROR_SUCCESS) do return
    return true, key
}

CreateRegistryKey :: proc(key_path: string) -> (ok: bool, key: win.HKEY)
{
        status := win.RegCreateKeyExW(
            win.HKEY_CLASSES_ROOT,
            win.utf8_to_wstring(key_path),
            0,
            nil,
            win.REG_OPTION_NON_VOLATILE | win.KEY_WOW64_32KEY,
            win.KEY_ALL_ACCESS,
            nil,
            &key,
            nil,
        )
    if status != i32(win.ERROR_SUCCESS) do return
    return true, key
}

RegistryValueExists :: proc(key: win.HKEY, value_name: string) -> bool
{
    name_w := win.utf8_to_wstring(value_name, context.temp_allocator)
    
    status := win.RegGetValueW(
        key,
        nil, // no sub-key
        name_w,
        win.RRF_RT_ANY,
        nil, // type
        nil, // data
        nil, // size
    )
    
    return status == i32(win.ERROR_SUCCESS)
}

SetRegistryValue :: proc(key: win.HKEY, name, value: string) -> (ok: bool)
{
    name_w := win.utf8_to_wstring(name, context.allocator)
    defer delete(name_w)

    value_w := win.utf8_to_wstring(value, context.allocator)
    defer delete(value_w)

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

TOKEN_ELEVATION :: struct
{
    TokenIsElevated: win.DWORD,
}

ProcessIsElevated :: proc() -> bool
{
    token:     win.HANDLE
    elevation: TOKEN_ELEVATION
    size:      win.DWORD

    if !win.OpenProcessToken(
        win.GetCurrentProcess(),
        win.TOKEN_QUERY,
        &token
    ) {
        return false
    }
    defer win.CloseHandle(token)

    if !win.GetTokenInformation(
        token,
        .TokenElevation,
        &elevation,
        size_of(elevation),
        &size,
    ) {
        return false
    }

    return elevation.TokenIsElevated != 0
}

RelaunchAsElevated :: proc() -> bool
{
    // Get the full path of the running executable
    exe_path_buf: [win.MAX_PATH]u16
    length := win.GetModuleFileNameW(nil, &exe_path_buf[0], win.MAX_PATH)
    if length == 0 || length >= win.MAX_PATH {
        fmt.eprintln("RelaunchAsElevated: GetModuleFileNameW failed")
        return false
    }

    // preserve the original command-line arguments
    // (skip argv[0] which is the executable itself)
    args: string
    if len(os.args) > 1 {
        args = strings.join(os.args[1:], " ")
    }

    sei: win.SHELLEXECUTEINFOW
    sei.cbSize       = size_of(sei)
    sei.fMask        = win.SEE_MASK_NOCLOSEPROCESS
    sei.hwnd         = nil
    sei.lpVerb       = win.utf8_to_wstring("runas")
    sei.lpFile       = cstring16(&exe_path_buf[0])
    sei.lpParameters = win.utf8_to_wstring(args) if args != "" else nil
    sei.nShow        = win.SW_NORMAL

    if !win.ShellExecuteExW(&sei) {
        err := win.GetLastError()
        if err == 1223 {
            fmt.println("Elevation cancelled by user")
        } else {
            fmt.eprintf("ShellExecuteExW failed (error %v)\n", err)
        }
        return false
    }

    // TODO: Wait for the elevated process to finish?

    return true
}
