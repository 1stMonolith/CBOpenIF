package cbopenif

CMParameters :: distinct rawptr

CMParametersIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^CMParametersVTable,
}

CMParametersVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    Add:       proc "system" (this: ^CMParametersIF, CMParameter: CMParameter) -> HResult,
    AddBefore: proc "system" (this: ^CMParametersIF, CMParameter: CMParameter, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CMParametersIF, Name, TypeNmae: BStr, CMParameter: ^CMParameter) -> HResult,
    Add2:      proc "system" (this: ^CMParametersIF, Name, TypeName, InitialValue, ReadPermission, WritePermission, Description: BStr, CMParameter: ^CMParameter) -> HResult,
    Find:      proc "system" (this: ^CMParametersIF, Name: BStr, CMParameter: ^CMParameter) -> HResult,
    FindNr:    proc "system" (this: ^CMParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CMParametersIF, Index: i32, CMParameter: ^CMParameter) -> HResult,
    Count:     proc "system" (this: ^CMParametersIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CMParametersIF, Index: i32) -> HResult,
}

cmparameters_add :: proc {
    cmparameters_add_,
    cmparameters_add_at_index,
}

@(private)
cmparameters_add_ :: proc(cmparameters: CMParameters, cmparameter: CMParameter) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    if cmparameter == nil do return

    hr := (^CMParametersIF)(cmparameters)->Add(cmparameter)
    if failed(hr) do return

    return true
}

cmparameters_add_at_index :: proc(cmparameters: CMParameters, cmparameter: CMParameter, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    if cmparameter == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->AddBefore(cmparameter, index)
    if failed(hr) do return

    return true
}

cmparameters_cmparameter :: proc {
    cmparameters_cmparameter_by_name,
    cmparameters_cmparameter_by_index,
}

cmparameters_cmparameter_by_name :: proc(cmparameters: CMParameters, name: string) -> (cmparameter: CMParameter, ok: bool) {
    cmparameter = nil
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->Find(bstr_name, &cmparameter)
    if failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_by_index :: proc(cmparameters: CMParameters, index: i32) -> (cmparameter: CMParameter, ok: bool) {
    cmparameter = nil
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->Item(index, &cmparameter)
    if failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_index :: proc(cmparameters: CMParameters, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    
    bstr_name := string_to_bstr(name)
    bstr_free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

cmparameters_count :: proc(cmparameters: CMParameters) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

cmparameters_remove :: proc {
    cmparameters_remove_by_name,
    cmparameters_remove_by_index,
}

cmparameters_remove_by_name :: proc(cmparameters: CMParameters, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmparameters == nil do return

    index: i32
    index, ok = cmparameters_cmparameter_index(cmparameters, name)
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if failed(hr) do return
    
    return true
}

cmparameters_remove_by_index :: proc(cmparameters: CMParameters, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if cmparameters == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if failed(hr) do return
    
    return true
}

cmparameters_release :: proc(cmparameters: CMParameters) {
    if cmparameters != nil {
        (^CMParametersIF)(cmparameters)->Release()
    }
}
