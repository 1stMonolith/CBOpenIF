package com

Variable  :: distinct rawptr
Variables :: distinct rawptr

VariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VariableVTable,
}

VariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^VariableIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^VariableIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^VariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^VariableIF, TypeName: BStr) -> HResult,
    AttributeGet:           proc "system" (this: ^VariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:           proc "system" (this: ^VariableIF, Attribute: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^VariableIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^VariableIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^VariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^VariableIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^VariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^VariableIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^VariableIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^VariableIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^VariableIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^VariableIF, AuthenticationLevel: BStr) -> HResult,
    BatchPropertyGet:       proc "system" (this: ^VariableIF, BatchProperty: ^BStr) -> HResult,
    BatchPropertyPut:       proc "system" (this: ^VariableIF, BatchProperty: BStr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^VariableIF, GraphNodes: ^rawptr) -> HResult,
    Missing26:              proc "system" (this: ^VariableIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^VariableIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^VariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^VariableIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^VariableIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^VariableIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^VariableIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^VariableIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^VariableIF, SafetyType: BStr) -> HResult,
}

variable_serialize :: proc(variable: Variable) -> (xml: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_name_get :: proc(variable: Variable) -> (name: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

variable_name_set :: proc(variable: Variable, name: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_type_name_get :: proc(variable: Variable) -> (type_name: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

variable_type_name_set :: proc(variable: Variable, type_name: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_attribute_get :: proc(variable: Variable) -> (attribute: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_attribute_set :: proc(variable: Variable, attribute: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_initial_value_get :: proc(variable: Variable) -> (inital_value: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_initial_value_set :: proc(variable: Variable, inital_value: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_description_get :: proc(variable: Variable) -> (description: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_description_set :: proc(variable: Variable, description: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_read_permission_get :: proc(variable: Variable) -> (read_permission: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_read_permission_set :: proc(variable: Variable, read_permission: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_write_permission_get :: proc(variable: Variable) -> (write_permission: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_write_permission_set :: proc(variable: Variable, write_permission: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_authentication_level_get :: proc(variable: Variable) -> (authentication_level: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_authentication_level_set :: proc(variable: Variable, authentication_level: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_batch_property_get :: proc(variable: Variable) -> (batch_property: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_batch_property_set :: proc(variable: Variable, batch_property: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(batch_property)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_graph_nodes_get :: proc(variable: Variable) -> (graph_nodes: GraphNodes, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

variable_graph_nodes_set :: proc(variable: Variable, graph_nodes: GraphNodes) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

variable_type_guid_get :: proc(variable: Variable) -> (guid: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_type_path_get :: proc(variable: Variable) -> (path: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_access_level_get :: proc(variable: Variable) -> (access_level: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_access_level_set :: proc(variable: Variable, access_level: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_safety_type_get :: proc(variable: Variable) -> (safety_type: string, ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_safety_type_set :: proc(variable: Variable, safety_type: string) -> (ok: bool) {
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_release :: proc(variable: Variable) {
    if variable != nil {
        (^VariableIF)(variable)->Release()
    }
}

VariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VariablesVTable,
}

VariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^VariablesIF, Variable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^VariablesIF, Variable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^VariablesIF, Name, TypeName: BStr, Variable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^VariablesIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, Variable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^VariablesIF, Name: BStr, Variable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^VariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^VariablesIF, Index: i32, Variable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^VariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^VariablesIF, Index: i32) -> HResult,
}

variables_variable_add :: proc(variables: Variables, variable: Variable) -> (ok: bool) {
    if variables == nil do return
    if variable == nil do return
    if !controlbuilder_connected() do return

    hr := (^VariablesIF)(variables)->Add(variable)
    if com_failed(hr) do return

    return true
}

variables_variable_add_at_index :: proc(variables: Variables, variable: Variable, index: i32) -> (ok: bool) {
    if variables == nil do return
    if variable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->AddBefore(variable, index)
    if com_failed(hr) do return

    return true
}

variables_variable_by_name :: proc(variables: Variables, name: string) -> (variable: Variable, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->Find(bstr_name, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variables_variable_by_index :: proc(variables: Variables, index: i32) -> (variable: Variable, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->Item(index + 1, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variables_variable_index :: proc(variables: Variables, name: string) -> (index: i32, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

variables_variable_count :: proc(variables: Variables) -> (count: i32, ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

variables_variable_remove_by_name :: proc(variables: Variables, name: string) -> (ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = variables_variable_index(variables, name)
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

variables_variable_remove_by_index :: proc(variables: Variables, index: i32) -> (ok: bool) {
    if variables == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^VariablesIF)(variables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

variables_release :: proc(variables: Variables) {
    if variables != nil {
        (^VariablesIF)(variables)->Release()
    }
}
