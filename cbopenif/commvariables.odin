package cbopenif

CommVariables :: distinct rawptr

CommVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CommVariablesVTable,
}

CommVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^CommVariablesIF, CommVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^CommVariablesIF, CommVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CommVariablesIF, Name, TypeName, Direction: BStr, Variable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^CommVariablesIF, Name, TypeName, Direction, Attribute, InitialValue, ISPValue, Priority, IntervalTime, ReadPermission, Description: BStr, CommVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^CommVariablesIF, Name: BStr, CommVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^CommVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CommVariablesIF, Index: i32, CommVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^CommVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CommVariablesIF, Index: i32) -> HResult,
}

commvariables_commvariable_add :: proc {
    commvariables_commvariable_add_,
    commvariables_commvariable_add_at_index,
}

commvariables_commvariable_add_ :: proc(commvariables: CommVariables, commvariable: CommVariable) -> (ok: bool) {
    if commvariables == nil do return
    if commvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^CommVariablesIF)(commvariables)->Add(commvariable)
    if com_failed(hr) do return

    return true
}

commvariables_commvariable_add_at_index :: proc(commvariables: CommVariables, commvariable: CommVariable, index: i32) -> (ok: bool) {
    if commvariables == nil do return
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->AddBefore(commvariable, index)
    if com_failed(hr) do return

    return true
}

commvariables_commvariable :: proc {
    commvariables_commvariable_by_name,
    commvariables_commvariable_by_index,
}

commvariables_commvariable_by_name :: proc(commvariables: CommVariables, name: string) -> (commvariable: CommVariable, ok: bool) {
    if commvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->Find(bstr_name, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariables_commvariable_by_index :: proc(commvariables: CommVariables, index: i32) -> (commvariable: CommVariable, ok: bool) {
    if commvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Item(index + 1, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariables_commvariable_index :: proc(commvariables: CommVariables, name: string) -> (index: i32, ok: bool) {
    if commvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

commvariables_commvariable_count :: proc(commvariables: CommVariables) -> (count: i32, ok: bool) {
    if commvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

commvariables_commvariable_remove :: proc {
    commvariables_remove_by_name,
    commvariables_remove_by_index
}

commvariables_remove_by_name :: proc(commvariables: CommVariables, name: string) -> (ok: bool) {
    if commvariables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = commvariables_commvariable_index(commvariables, name)
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

commvariables_remove_by_index :: proc(commvariables: CommVariables, index: i32) -> (ok: bool) {
    if commvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

commvariables_release :: proc(commvariables: CommVariables) {
    if commvariables != nil {
        (^CommVariablesIF)(commvariables)->Release()
    }
}
