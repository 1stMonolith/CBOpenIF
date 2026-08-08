package cbopenif

/*
AccessVariables                         ← top-level object (Serialize + owns the protocol list)
  └── VAProtocols                       ← collection of protocols
        │
        ├── IVAProtocol                 ← common base interface
        │     • Name
        │     • IsVANamedProtocol
        │     • IsVAAddressedProtocol
        │
        ├── VANamedProtocol
        │     └── VANamedVariable[]     ← Name, Path, VAAttribute, VAType, Row, VATypePath
        │
        └── VAAddressedProtocol
              └── VAAddressedVariable[] ← Name, Path, VAType, Row, VATypePath
*/

AccessVariables :: distinct rawptr

AccessVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^AccessVariablesVTable,
}

AccessVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    VAProtocolsGet: proc "system" (this: ^AccessVariablesIF, VAProtocols: ^rawptr) -> HResult,
    Missing8:       proc "system" (this: ^AccessVariablesIF) -> HResult,
    VAProtocolsPut: proc "system" (this: ^AccessVariablesIF, VAProtocols: rawptr) -> HResult,
    Serialize:      proc "system" (this: ^AccessVariablesIF, XML: ^BStr) -> HResult,
}

accessvariables_new :: proc() -> (av: AccessVariables, ok: bool) {
    if !controlbuilder_connected() do return

    hr := factoryif->NewAccessVariables(cast(^rawptr)&av)
    if com_failed(hr) do return

    return av, true
}

accessvariables_deserialize :: proc(xml: string) -> (av: AccessVariables, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeAccessVariables(&bs, cast(^rawptr)&av)
    if com_failed(hr) do return

    return av, true
}

accessvariables_serialize :: proc(av: AccessVariables) -> (xml: string, ok: bool) {
    if av == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^AccessVariablesIF)(av)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

accessvariables_vaprotocols :: proc {
    accessvariables_vaprotocols_get,
    accessvariables_vaprotocols_set,
}

accessvariables_vaprotocols_get :: proc(av: AccessVariables) -> (vaprotocols: VAProtocols, ok: bool) {
    if av == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^AccessVariablesIF)(av)->VAProtocolsGet(&p)
    if com_failed(hr) do return

    return VAProtocols(p), true
}

accessvariables_vaprotocols_set :: proc(av: AccessVariables, vaprotocols: VAProtocols) -> (ok: bool) {
    if av == nil do return
    if !controlbuilder_connected() do return

    hr := (^AccessVariablesIF)(av)->VAProtocolsPut(vaprotocols)
    if com_failed(hr) do return

    return true
}

accessvariables_release :: proc(av: AccessVariables) {
    if av != nil {
        (^AccessVariablesIF)(av)->Release()
    }
}
