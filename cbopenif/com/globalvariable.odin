package com

GlobalVariable  :: distinct rawptr
GlobalVariables :: distinct rawptr

GlobalVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GlobalVariableVTable,
}

GlobalVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^GlobalVariableIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^GlobalVariableIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^GlobalVariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^GlobalVariableIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^GlobalVariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^GlobalVariableIF, Attribute: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^GlobalVariableIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^GlobalVariableIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^GlobalVariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^GlobalVariableIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^GlobalVariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^GlobalVariableIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^GlobalVariableIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^GlobalVariableIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^GlobalVariableIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^GlobalVariableIF, AuthenticationLevel: BStr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^GlobalVariableIF, GraphNodes: ^rawptr) -> HResult,
    Missing24:              proc "system" (this: ^GlobalVariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^GlobalVariableIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^GlobalVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^GlobalVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^GlobalVariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^GlobalVariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^GlobalVariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^GlobalVariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^GlobalVariableIF, SafetyType: BStr) -> HResult,
}

globalvariable_serialize :: proc(global_variable: GlobalVariable) -> (xml: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_name_get :: proc(global_variable: GlobalVariable) -> (name: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

globalvariable_name_set :: proc(global_variable: GlobalVariable, name: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_type_name_get :: proc(global_variable: GlobalVariable) -> (type_name: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

globalvariable_type_name_set :: proc(global_variable: GlobalVariable, type_name: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_attribute_get :: proc(global_variable: GlobalVariable) -> (attribute: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_attribute_set :: proc(global_variable: GlobalVariable, attribute: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_initial_value_get :: proc(global_variable: GlobalVariable) -> (inital_value: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_initial_value_set :: proc(global_variable: GlobalVariable, inital_value: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_description_get :: proc(global_variable: GlobalVariable) -> (description: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_description_set :: proc(global_variable: GlobalVariable, description: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_read_permission_get :: proc(global_variable: GlobalVariable) -> (read_permission: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_read_permission_set :: proc(global_variable: GlobalVariable, read_permission: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_write_permission_get :: proc(global_variable: GlobalVariable) -> (write_permission: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_write_permission_set :: proc(global_variable: GlobalVariable, write_permission: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_authentication_level_get :: proc(global_variable: GlobalVariable) -> (authentication_level: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_authentication_level_set :: proc(global_variable: GlobalVariable, authentication_level: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_graph_nodes_get :: proc(global_variable: GlobalVariable) -> (graph_nodes: GraphNodes, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

globalvariable_graph_nodes_set :: proc(global_variable: GlobalVariable, graph_nodes: GraphNodes) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

globalvariable_type_guid_get :: proc(global_variable: GlobalVariable) -> (guid: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_type_path_get :: proc(global_variable: GlobalVariable) -> (path: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_access_level_get :: proc(global_variable: GlobalVariable) -> (access_level: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_access_level_set :: proc(global_variable: GlobalVariable, access_level: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_safety_type_get :: proc(global_variable: GlobalVariable) -> (safety_type: string, ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

globalvariable_safety_type_set :: proc(global_variable: GlobalVariable, safety_type: string) -> (ok: bool) {
    if global_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

globalvariable_release :: proc(global_variable: GlobalVariable) {
    if global_variable != nil {
        (^GlobalVariableIF)(global_variable)->Release()
    }
}

GlobalVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GlobalVariablesVTable,
}

GlobalVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^GlobalVariablesIF, GlobalVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^GlobalVariablesIF, GlobalVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^GlobalVariablesIF, Name, TypeName: BStr, GlobalVariable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^GlobalVariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, GlobalVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^GlobalVariablesIF, Name: BStr, GlobalVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^GlobalVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^GlobalVariablesIF, Index: i32, GlobalVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^GlobalVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^GlobalVariablesIF, Index: i32) -> HResult,
}

globalvariables_globalvariable_add :: proc(globalvariables: GlobalVariables, globalvariable: GlobalVariable) -> (ok: bool) {
    if globalvariables == nil do return
    if globalvariable == nil do return
    if !com_connected() do return

    hr := (^GlobalVariablesIF)(globalvariables)->Add(globalvariable)
    if com_failed(hr) do return

    return true
}

globalvariables_globalvariable_add_at_index :: proc(globalvariables: GlobalVariables, globalvariable: GlobalVariable, index: i32) -> (ok: bool) {
    if globalvariables == nil do return
    if globalvariable == nil do return
    if !com_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->AddBefore(globalvariable, index)
    if com_failed(hr) do return

    return true
}

globalvariables_globalvariable_by_name :: proc(globalvariables: GlobalVariables, name: string) -> (globalvariable: GlobalVariable, ok: bool) {
    if globalvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(globalvariables)->Find(bstr_name, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

globalvariables_globalvariable_by_index :: proc(globalvariables: GlobalVariables, index: i32) -> (globalvariable: GlobalVariable, ok: bool) {
    if globalvariables == nil do return
    if !com_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Item(index + 1, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

globalvariables_globalvariable_index :: proc(globalvariables: GlobalVariables, name: string) -> (index: i32, ok: bool) {
    if globalvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^GlobalVariablesIF)(globalvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

globalvariables_globalvariable_count :: proc(globalvariables: GlobalVariables) -> (count: i32, ok: bool) {
    if globalvariables == nil do return
    if !com_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

globalvariables_globalvariable_remove_by_name :: proc(globalvariables: GlobalVariables, name: string) -> (ok: bool) {
    if globalvariables == nil do return
    if !com_connected() do return

    index: i32
    index, ok = globalvariables_globalvariable_index(globalvariables, name)
    
    hr := (^GlobalVariablesIF)(globalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

globalvariables_globalvariable_remove_by_index :: proc(globalvariables: GlobalVariables, index: i32) -> (ok: bool) {
    if globalvariables == nil do return
    if !com_connected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

globalvariables_release :: proc(globalvariables: GlobalVariables) {
    if globalvariables != nil {
        (^GlobalVariablesIF)(globalvariables)->Release()
    }
}
