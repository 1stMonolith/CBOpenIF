package parameter

import "../com"
import "../controlbuilder"
import "../bstr"

CMParametersIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^CMParametersVTable,
}

CMParametersVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
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

cmparameters_add_ :: proc(cmparameters: rawptr, cmparameter: rawptr) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    if cmparameter == nil do return

    hr := (^CMParametersIF)(cmparameters)->Add(cmparameter)
    if com.failed(hr) do return

    return true
}

cmparameters_add_at_index :: proc(cmparameters: rawptr, cmparameter: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    if cmparameter == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->AddBefore(cmparameter, index)
    if com.failed(hr) do return

    return true
}

cmparameters_cmparameter :: proc {
    cmparameters_cmparameter_by_name,
    cmparameters_cmparameter_by_index,
}

cmparameters_cmparameter_by_name :: proc(cmparameters: rawptr, name: string) -> (cmparameter: rawptr, ok: bool) {
    cmparameter = nil
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->Find(bstr_name, &cmparameter)
    if com.failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_by_index :: proc(cmparameters: rawptr, index: i32) -> (cmparameter: rawptr, ok: bool) {
    cmparameter = nil
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->Item(index, &cmparameter)
    if com.failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_index :: proc(cmparameters: rawptr, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

cmparameters_count :: proc(cmparameters: rawptr) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

cmparameters_remove :: proc {
    cmparameters_remove_by_name,
    cmparameters_remove_by_index,
}

cmparameters_remove_by_name :: proc(cmparameters: rawptr, name: string) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return

    index: i32
    index, ok = cmparameters_cmparameter_index(cmparameters, name)
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

cmparameters_remove_by_index :: proc(cmparameters: rawptr, index: i32) -> (ok: bool) {
    ok = false

    if !controlbuilder.connected() do return
    if cmparameters == nil do return
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

cmparameters_release :: proc(cmparameters: rawptr) {
    if cmparameters != nil {
        (^CMParametersIF)(cmparameters)->Release()
    }
}
