package cbopenif

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
