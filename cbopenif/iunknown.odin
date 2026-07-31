package cbopenif

IUnknowIF :: struct #raw_union {
    using vtable: ^IUnknowVTable,
}

IUnknowVTable :: struct {
    // IUnkown
    QueryInterface:   proc "system" (this: ^IUnknowIF, riid: ^GUID, ppvObject: ^rawptr) -> HResult,
    AddRef:           proc "system" (this: ^IUnknowIF) -> u32,
    Release:          proc "system" (this: ^IUnknowIF) -> u32,
    
    // IDispatch
    GetTypeInfoCount: proc "system" (this: ^IUnknowIF, pctinfo: ^u32) -> HResult,
    GetTypeInfo:      proc "system" (this: ^IUnknowIF, iTInfo: u32, lcid: u32, ppTInfo: ^rawptr) -> HResult,
    GetIDsOfNames:    proc "system" (this: ^IUnknowIF, riid: ^GUID, rgszNames: [^][^]u16, cNames: u32, lcid: u32, rgDispId: [^]i32) -> HResult,
    Invoke:           proc "system" (this: ^IUnknowIF, dispIdMember: i32, riid: ^GUID, lcid: u32, wFlags: u16, pDispParams: rawptr, pVarResult: rawptr, pExcepInfo: rawptr, puArgErr: ^u32) -> HResult,
}
