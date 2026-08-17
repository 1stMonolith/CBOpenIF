package com

ExternalVariable  :: distinct rawptr
ExternalVariables :: distinct rawptr

ExternalVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExternalVariableVTable,
}

ExternalVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^ExternalVariableIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^ExternalVariableIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^ExternalVariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^ExternalVariableIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^ExternalVariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^ExternalVariableIF, Attribute: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^ExternalVariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^ExternalVariableIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^ExternalVariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^ExternalVariableIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^ExternalVariableIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^ExternalVariableIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^ExternalVariableIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^ExternalVariableIF, AuthenticationLevel: BStr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^ExternalVariableIF, GraphNodes: ^rawptr) -> HResult,
    Missing22:              proc "system" (this: ^ExternalVariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^ExternalVariableIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^ExternalVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^ExternalVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^ExternalVariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^ExternalVariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^ExternalVariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^ExternalVariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^ExternalVariableIF, SafetyType: BStr) -> HResult,
}

externalvariable_serialize :: proc(external_variable: ExternalVariable) -> (xml: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_name_get :: proc(external_variable: ExternalVariable) -> (name: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

externalvariable_name_set :: proc(external_variable: ExternalVariable, name: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_type_name_get :: proc(external_variable: ExternalVariable) -> (type_name: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

externalvariable_type_name_set :: proc(external_variable: ExternalVariable, type_name: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_attribute_get :: proc(external_variable: ExternalVariable) -> (attribute: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_attribute_set :: proc(external_variable: ExternalVariable, attribute: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_description_get :: proc(external_variable: ExternalVariable) -> (description: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_description_set :: proc(external_variable: ExternalVariable, description: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_read_permission_get :: proc(external_variable: ExternalVariable) -> (read_permission: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_read_permission_set :: proc(external_variable: ExternalVariable, read_permission: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_write_permission_get :: proc(external_variable: ExternalVariable) -> (write_permission: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_write_permission_set :: proc(external_variable: ExternalVariable, write_permission: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_authentication_level_get :: proc(external_variable: ExternalVariable) -> (authentication_level: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_authentication_level_set :: proc(external_variable: ExternalVariable, authentication_level: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_graph_nodes_get :: proc(external_variable: ExternalVariable) -> (graph_nodes: GraphNodes, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

externalvariable_graph_nodes_set :: proc(external_variable: ExternalVariable, graph_nodes: GraphNodes) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

externalvariable_type_guid_get :: proc(external_variable: ExternalVariable) -> (guid: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_type_path_get :: proc(external_variable: ExternalVariable) -> (path: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_access_level_get :: proc(external_variable: ExternalVariable) -> (access_level: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_access_level_set :: proc(external_variable: ExternalVariable, access_level: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_safety_type_get :: proc(external_variable: ExternalVariable) -> (safety_type: string, ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_safety_type_set :: proc(external_variable: ExternalVariable, safety_type: string) -> (ok: bool) {
    if external_variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_release :: proc(external_variable: ExternalVariable) {
    if external_variable != nil {
        (^ExternalVariableIF)(external_variable)->Release()
    }
}

ExternalVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExternalVariablesVTable,
}

ExternalVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ExternalVariablesIF, ExternalVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ExternalVariablesIF, ExternalVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExternalVariablesIF, Name, TypeName: BStr, ExternalVariable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ExternalVariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, ExternalVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ExternalVariablesIF, Name: BStr, ExternalVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ExternalVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExternalVariablesIF, Index: i32, ExternalVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ExternalVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExternalVariablesIF, Index: i32) -> HResult,
}

externalvariables_externalvariable_add :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable) -> (ok: bool) {
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExternalVariablesIF)(externalvariables)->Add(externalvariable)
    if com_failed(hr) do return

    return true
}

externalvariables_externalvariable_add_at_index :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable, index: i32) -> (ok: bool) {
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->AddBefore(externalvariable, index)
    if com_failed(hr) do return

    return true
}

externalvariables_externalvariable_by_name :: proc(externalvariables: ExternalVariables, name: string) -> (externalvariable: ExternalVariable, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->Find(bstr_name, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariables_externalvariable_by_index :: proc(externalvariables: ExternalVariables, index: i32) -> (externalvariable: ExternalVariable, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Item(index + 1, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariables_externalvariable_index :: proc(externalvariables: ExternalVariables, name: string) -> (index: i32, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

externalvariables_externalvariable_count :: proc(externalvariables: ExternalVariables) -> (count: i32, ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

externalvariables_externalvariable_remove_by_name :: proc(externalvariables: ExternalVariables, name: string) -> (ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = externalvariables_externalvariable_index(externalvariables, name)
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

externalvariables_externalvariable_remove_by_index :: proc(externalvariables: ExternalVariables, index: i32) -> (ok: bool) {
    if externalvariables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

externalvariables_release :: proc(externalvariables: ExternalVariables) {
    if externalvariables != nil {
        (^ExternalVariablesIF)(externalvariables)->Release()
    }
}
