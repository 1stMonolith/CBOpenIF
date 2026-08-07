package cbopenif

IControlModule :: distinct rawptr

IControlModuleIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IControlModuleVTable,
}

IControlModuleVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^IControlModuleIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^IControlModuleIF, Name: BStr) -> HResult,
    IsControlModule:       proc "system" (this: ^IControlModuleIF, IsControlModule: ^VariantBool) -> HResult,
    IsSingleControlModule: proc "system" (this: ^IControlModuleIF, IsSingleControlModule: ^VariantBool) -> HResult,
}

icontrolmodule_name :: proc {
    icontrolmodule_name_get,
    icontrolmodule_name_set,
}

icontrolmodule_name_get :: proc(icontrolmodule: IControlModule) -> (name: string, ok: bool) {
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^IControlModuleIF)(icontrolmodule)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

icontrolmodule_name_set :: proc(icontrolmodule: IControlModule, name: string) -> (ok: bool) {
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^IControlModuleIF)(icontrolmodule)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

icontrolmodule_is_controlmodule :: proc(icontrolmodule: IControlModule) -> (is_controlmodule: bool, ok: bool) {
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^IControlModuleIF)(icontrolmodule)->IsControlModule(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icontrolmodule_is_singlecontrolmodule :: proc(icontrolmodule: IControlModule) -> (is_singlecontrolmodule: bool, ok: bool) {
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^IControlModuleIF)(icontrolmodule)->IsSingleControlModule(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}
