package cbopenif

CMParameters :: distinct rawptr

CMParametersIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMParametersVTable,
}

CMParametersVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^CMParametersIF, CMParameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^CMParametersIF, CMParameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CMParametersIF, Name, TypeNmae: BStr, CMParameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^CMParametersIF, Name, TypeName, InitialValue, ReadPermission, WritePermission, Description: BStr, CMParameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^CMParametersIF, Name: BStr, CMParameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^CMParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CMParametersIF, Index: i32, CMParameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^CMParametersIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CMParametersIF, Index: i32) -> HResult,
}

cmparameters_add :: proc {
    cmparameters_add_,
    cmparameters_add_at_index,
}

cmparameters_add_ :: proc(cmparameters: CMParameters, cmparameter: CMParameter) -> (ok: bool) {
    if cmparameters == nil do return
    if cmparameter == nil do return
    if !controlbuilder_connected() do return

    hr := (^CMParametersIF)(cmparameters)->Add(cmparameter)
    if com_failed(hr) do return

    return true
}

cmparameters_add_at_index :: proc(cmparameters: CMParameters, cmparameter: CMParameter, index: i32) -> (ok: bool) {
    if cmparameters == nil do return
    if cmparameter == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->AddBefore(cmparameter, index)
    if com_failed(hr) do return

    return true
}

cmparameters_cmparameter :: proc {
    cmparameters_cmparameter_by_name,
    cmparameters_cmparameter_by_index,
}

cmparameters_cmparameter_by_name :: proc(cmparameters: CMParameters, name: string) -> (cmparameter: CMParameter, ok: bool) {
    if cmparameters == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->Find(bstr_name, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_by_index :: proc(cmparameters: CMParameters, index: i32) -> (cmparameter: CMParameter, ok: bool) {
    if cmparameters == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Item(index, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_index :: proc(cmparameters: CMParameters, name: string) -> (index: i32, ok: bool) {
    if cmparameters == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index, true
}

cmparameters_count :: proc(cmparameters: CMParameters) -> (count: i32, ok: bool) {
    if cmparameters == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

cmparameters_remove :: proc {
    cmparameters_remove_by_name,
    cmparameters_remove_by_index,
}

cmparameters_remove_by_name :: proc(cmparameters: CMParameters, name: string) -> (ok: bool) {
    if cmparameters == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = cmparameters_cmparameter_index(cmparameters, name)
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

cmparameters_remove_by_index :: proc(cmparameters: CMParameters, index: i32) -> (ok: bool) {
    if cmparameters == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

cmparameters_release :: proc(cmparameters: CMParameters) {
    if cmparameters != nil {
        (^CMParametersIF)(cmparameters)->Release()
    }
}
