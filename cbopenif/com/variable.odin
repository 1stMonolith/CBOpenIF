package com

Variable          :: distinct rawptr
Variables         :: distinct rawptr
ExternalVariable  :: distinct rawptr
ExternalVariables :: distinct rawptr
GlobalVariable    :: distinct rawptr
GlobalVariables   :: distinct rawptr
CommVariable      :: distinct rawptr
CommVariables     :: distinct rawptr

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
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_name_get :: proc(variable: Variable) -> (name: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

variable_name_set :: proc(variable: Variable, name: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_type_name_get :: proc(variable: Variable) -> (type_name: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

variable_type_name_set :: proc(variable: Variable, type_name: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_attribute_get :: proc(variable: Variable) -> (attribute: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_attribute_set :: proc(variable: Variable, attribute: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_initial_value_get :: proc(variable: Variable) -> (inital_value: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_initial_value_set :: proc(variable: Variable, inital_value: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_description_get :: proc(variable: Variable) -> (description: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_description_set :: proc(variable: Variable, description: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_read_permission_get :: proc(variable: Variable) -> (read_permission: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_read_permission_set :: proc(variable: Variable, read_permission: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_write_permission_get :: proc(variable: Variable) -> (write_permission: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_write_permission_set :: proc(variable: Variable, write_permission: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_authentication_level_get :: proc(variable: Variable) -> (authentication_level: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_authentication_level_set :: proc(variable: Variable, authentication_level: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_batch_property_get :: proc(variable: Variable) -> (batch_property: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_batch_property_set :: proc(variable: Variable, batch_property: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(batch_property)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->BatchPropertyPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_graph_nodes_get :: proc(variable: Variable) -> (graph_nodes: GraphNodes, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

variable_graph_nodes_set :: proc(variable: Variable, graph_nodes: GraphNodes) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

variable_type_guid_get :: proc(variable: Variable) -> (guid: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_type_path_get :: proc(variable: Variable) -> (path: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_access_level_get :: proc(variable: Variable) -> (access_level: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_access_level_set :: proc(variable: Variable, access_level: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

variable_safety_type_get :: proc(variable: Variable) -> (safety_type: string, ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^VariableIF)(variable)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

variable_safety_type_set :: proc(variable: Variable, safety_type: string) -> (ok: bool) {
    if variable == nil do return
    if !com_connected() do return
    
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
    if !com_connected() do return

    hr := (^VariablesIF)(variables)->Add(variable)
    if com_failed(hr) do return

    return true
}

variables_variable_add_at_index :: proc(variables: Variables, variable: Variable, index: i32) -> (ok: bool) {
    if variables == nil do return
    if variable == nil do return
    if !com_connected() do return
    
    hr := (^VariablesIF)(variables)->AddBefore(variable, index)
    if com_failed(hr) do return

    return true
}

variables_variable_by_name :: proc(variables: Variables, name: string) -> (variable: Variable, ok: bool) {
    if variables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->Find(bstr_name, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variables_variable_by_index :: proc(variables: Variables, index: i32) -> (variable: Variable, ok: bool) {
    if variables == nil do return
    if !com_connected() do return
    
    hr := (^VariablesIF)(variables)->Item(index + 1, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variables_variable_index :: proc(variables: Variables, name: string) -> (index: i32, ok: bool) {
    if variables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^VariablesIF)(variables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

variables_variable_count :: proc(variables: Variables) -> (count: i32, ok: bool) {
    if variables == nil do return
    if !com_connected() do return
    
    hr := (^VariablesIF)(variables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

variables_variable_remove_by_name :: proc(variables: Variables, name: string) -> (ok: bool) {
    if variables == nil do return
    if !com_connected() do return

    index: i32
    index, ok = variables_variable_index(variables, name)
    
    hr := (^VariablesIF)(variables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

variables_variable_remove_by_index :: proc(variables: Variables, index: i32) -> (ok: bool) {
    if variables == nil do return
    if !com_connected() do return
    
    hr := (^VariablesIF)(variables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

variables_release :: proc(variables: Variables) {
    if variables != nil {
        (^VariablesIF)(variables)->Release()
    }
}

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
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_name_get :: proc(external_variable: ExternalVariable) -> (name: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

externalvariable_name_set :: proc(external_variable: ExternalVariable, name: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_type_name_get :: proc(external_variable: ExternalVariable) -> (type_name: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

externalvariable_type_name_set :: proc(external_variable: ExternalVariable, type_name: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_attribute_get :: proc(external_variable: ExternalVariable) -> (attribute: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_attribute_set :: proc(external_variable: ExternalVariable, attribute: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_description_get :: proc(external_variable: ExternalVariable) -> (description: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_description_set :: proc(external_variable: ExternalVariable, description: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_read_permission_get :: proc(external_variable: ExternalVariable) -> (read_permission: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_read_permission_set :: proc(external_variable: ExternalVariable, read_permission: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_write_permission_get :: proc(external_variable: ExternalVariable) -> (write_permission: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_write_permission_set :: proc(external_variable: ExternalVariable, write_permission: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_authentication_level_get :: proc(external_variable: ExternalVariable) -> (authentication_level: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_authentication_level_set :: proc(external_variable: ExternalVariable, authentication_level: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_graph_nodes_get :: proc(external_variable: ExternalVariable) -> (graph_nodes: GraphNodes, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

externalvariable_graph_nodes_set :: proc(external_variable: ExternalVariable, graph_nodes: GraphNodes) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

externalvariable_type_guid_get :: proc(external_variable: ExternalVariable) -> (guid: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_type_path_get :: proc(external_variable: ExternalVariable) -> (path: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_access_level_get :: proc(external_variable: ExternalVariable) -> (access_level: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_access_level_set :: proc(external_variable: ExternalVariable, access_level: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

externalvariable_safety_type_get :: proc(external_variable: ExternalVariable) -> (safety_type: string, ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

externalvariable_safety_type_set :: proc(external_variable: ExternalVariable, safety_type: string) -> (ok: bool) {
    if external_variable == nil do return
    if !com_connected() do return
    
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
    if !com_connected() do return

    hr := (^ExternalVariablesIF)(externalvariables)->Add(externalvariable)
    if com_failed(hr) do return

    return true
}

externalvariables_externalvariable_add_at_index :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable, index: i32) -> (ok: bool) {
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->AddBefore(externalvariable, index)
    if com_failed(hr) do return

    return true
}

externalvariables_externalvariable_by_name :: proc(externalvariables: ExternalVariables, name: string) -> (externalvariable: ExternalVariable, ok: bool) {
    if externalvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->Find(bstr_name, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariables_externalvariable_by_index :: proc(externalvariables: ExternalVariables, index: i32) -> (externalvariable: ExternalVariable, ok: bool) {
    if externalvariables == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Item(index + 1, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariables_externalvariable_index :: proc(externalvariables: ExternalVariables, name: string) -> (index: i32, ok: bool) {
    if externalvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

externalvariables_externalvariable_count :: proc(externalvariables: ExternalVariables) -> (count: i32, ok: bool) {
    if externalvariables == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

externalvariables_externalvariable_remove_by_name :: proc(externalvariables: ExternalVariables, name: string) -> (ok: bool) {
    if externalvariables == nil do return
    if !com_connected() do return

    index: i32
    index, ok = externalvariables_externalvariable_index(externalvariables, name)
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

externalvariables_externalvariable_remove_by_index :: proc(externalvariables: ExternalVariables, index: i32) -> (ok: bool) {
    if externalvariables == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

externalvariables_release :: proc(externalvariables: ExternalVariables) {
    if externalvariables != nil {
        (^ExternalVariablesIF)(externalvariables)->Release()
    }
}

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

CommVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CommVariableVTable,
}

CommVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:             proc "system" (this: ^CommVariableIF, Name: ^BStr) -> HResult,
    NamePut:             proc "system" (this: ^CommVariableIF, Name: BStr) -> HResult,
    TypeNameGet:         proc "system" (this: ^CommVariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:         proc "system" (this: ^CommVariableIF, TypeName: BStr) -> HResult,
    AttributeGet:        proc "system" (this: ^CommVariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:        proc "system" (this: ^CommVariableIF, Attribute: BStr) -> HResult,
    InitialValueGet:     proc "system" (this: ^CommVariableIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:     proc "system" (this: ^CommVariableIF, InitialValue: BStr) -> HResult,
    DirectionGet:        proc "system" (this: ^CommVariableIF, Direction: ^BStr) -> HResult,
    DirectionPut:        proc "system" (this: ^CommVariableIF, Direction: BStr) -> HResult,
    IPAddressGet:        proc "system" (this: ^CommVariableIF, IPAddress: ^BStr) -> HResult,
    IPAddressPut:        proc "system" (this: ^CommVariableIF, IPAddress: BStr) -> HResult,
    IntervalTimeGet:     proc "system" (this: ^CommVariableIF, IntervalTime: ^BStr) -> HResult,
    IntervalTimePut:     proc "system" (this: ^CommVariableIF, IntervalTime: BStr) -> HResult,
    PriorityGet:         proc "system" (this: ^CommVariableIF, Priority: ^BStr) -> HResult,
    PriorityPut:         proc "system" (this: ^CommVariableIF, Priority: BStr) -> HResult,
    ISPValueGet:         proc "system" (this: ^CommVariableIF, ISPValue: ^BStr) -> HResult,
    ISPValuePut:         proc "system" (this: ^CommVariableIF, ISPValue: BStr) -> HResult,
    ReadPermissionGet:   proc "system" (this: ^CommVariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:   proc "system" (this: ^CommVariableIF, ReadPermission: BStr) -> HResult,
    DescriptionGet:      proc "system" (this: ^CommVariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:      proc "system" (this: ^CommVariableIF, Description: BStr) -> HResult,
    TypeGuid:            proc "system" (this: ^CommVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:            proc "system" (this: ^CommVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:           proc "system" (this: ^CommVariableIF, XML: ^BStr) -> HResult,
    ExpectedSILGet:      proc "system" (this: ^CommVariableIF, ExpectedSIL: ^BStr) -> HResult,
    ExpectedSILPut:      proc "system" (this: ^CommVariableIF, ExpectedSIL: BStr) -> HResult,
    UniqueIDGet:         proc "system" (this: ^CommVariableIF, UniqueID: ^i32) -> HResult,
    UniqueIDPut:         proc "system" (this: ^CommVariableIF, UniqueID: i32) -> HResult,
    RestrictedSILGet:    proc "system" (this: ^CommVariableIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:    proc "system" (this: ^CommVariableIF, RestrictedSIL: VariantBool) -> HResult,
    AcknowledgeGroupGet: proc "system" (this: ^CommVariableIF, AcknowledgeGroup: ^BStr) -> HResult,
    AcknowledgeGroupPut: proc "system" (this: ^CommVariableIF, AcknowledgeGroup: BStr) -> HResult,
}

commvariable_serialize :: proc(commvariable: CommVariable) -> (xml: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_name_get :: proc(commvariable: CommVariable) -> (name: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

commvariable_name_set :: proc(commvariable: CommVariable, name: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_type_name_get :: proc(commvariable: CommVariable) -> (type_name: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

commvariable_type_name_set :: proc(commvariable: CommVariable, type_name: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_attribute_get :: proc(commvariable: CommVariable) -> (attribute: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_attribute_set :: proc(commvariable: CommVariable, attribute: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_initial_value_get :: proc(commvariable: CommVariable) -> (inital_value: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_initial_value_set :: proc(commvariable: CommVariable, inital_value: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_direction_get :: proc(commvariable: CommVariable) -> (direction: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_direction_set :: proc(commvariable: CommVariable, direction: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(direction)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_ipaddress_get :: proc(commvariable: CommVariable) -> (ipaddress: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_ipaddress_set :: proc(commvariable: CommVariable, ipaddress: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(ipaddress)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_interval_time_get :: proc(commvariable: CommVariable) -> (interval_time: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_interval_time_set :: proc(commvariable: CommVariable, interval_time: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(interval_time)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_priority_get :: proc(commvariable: CommVariable) -> (priority: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_priority_set :: proc(commvariable: CommVariable, priority: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(priority)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_isp_value_get :: proc(commvariable: CommVariable) -> (isp_value: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_isp_value_set :: proc(commvariable: CommVariable, isp_value: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(isp_value)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_read_permission_get :: proc(commvariable: CommVariable) -> (read_permission: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_read_permission_set :: proc(commvariable: CommVariable, read_permission: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_description_get :: proc(commvariable: CommVariable) -> (description: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_description_set :: proc(commvariable: CommVariable, description: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_type_guid_get :: proc(commvariable: CommVariable) -> (guid: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_type_path_get :: proc(commvariable: CommVariable) -> (path: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_expected_sil_get :: proc(commvariable: CommVariable) -> (expected_sil: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_expected_sil_set :: proc(commvariable: CommVariable, expected_sil: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(expected_sil)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_unique_id_get :: proc(commvariable: CommVariable) -> (unique_id: i32, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    id: i32
    hr := (^CommVariableIF)(commvariable)->UniqueIDGet(&id)
    if com_failed(hr) do return
    
    return id, true
}

commvariable_unique_id_set :: proc(commvariable: CommVariable, unique_id: i32) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    hr := (^CommVariableIF)(commvariable)->UniqueIDPut(unique_id)
    if com_failed(hr) do return
    
    return true
}

commvariable_restricted_sil_get :: proc(commvariable: CommVariable) -> (restricted_sil: bool, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^CommVariableIF)(commvariable)->RestrictedSILGet(&vb)
    if com_failed(hr) do return
    
    return from_variantbool(vb), true
}

commvariable_restricted_sil_set :: proc(commvariable: CommVariable, restricted_sil: bool) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    hr := (^CommVariableIF)(commvariable)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return
    
    return true
}

commvariable_acknowledge_group_get :: proc(commvariable: CommVariable) -> (acknowledge_group: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_acknowledge_group_set :: proc(commvariable: CommVariable, acknowledge_group: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(acknowledge_group)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_release :: proc(commvariable: CommVariable) {
    if commvariable != nil {
        (^CommVariableIF)(commvariable)->Release()
    }
}

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

commvariables_commvariable_add :: proc(commvariables: CommVariables, commvariable: CommVariable) -> (ok: bool) {
    if commvariables == nil do return
    if commvariable == nil do return
    if !com_connected() do return

    hr := (^CommVariablesIF)(commvariables)->Add(commvariable)
    if com_failed(hr) do return

    return true
}

commvariables_commvariable_add_at_index :: proc(commvariables: CommVariables, commvariable: CommVariable, index: i32) -> (ok: bool) {
    if commvariables == nil do return
    if commvariable == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->AddBefore(commvariable, index)
    if com_failed(hr) do return

    return true
}

commvariables_commvariable_by_name :: proc(commvariables: CommVariables, name: string) -> (commvariable: CommVariable, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->Find(bstr_name, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariables_commvariable_by_index :: proc(commvariables: CommVariables, index: i32) -> (commvariable: CommVariable, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Item(index + 1, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariables_commvariable_index :: proc(commvariables: CommVariables, name: string) -> (index: i32, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

commvariables_commvariable_count :: proc(commvariables: CommVariables) -> (count: i32, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

commvariables_remove_by_name :: proc(commvariables: CommVariables, name: string) -> (ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return

    index: i32
    index, ok = commvariables_commvariable_index(commvariables, name)
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

commvariables_remove_by_index :: proc(commvariables: CommVariables, index: i32) -> (ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

commvariables_release :: proc(commvariables: CommVariables) {
    if commvariables != nil {
        (^CommVariablesIF)(commvariables)->Release()
    }
}
