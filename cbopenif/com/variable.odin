package com

Variables         :: distinct rawptr
Variable          :: distinct rawptr
ExternalVariables :: distinct rawptr
ExternalVariable  :: distinct rawptr
GlobalVariables   :: distinct rawptr
GlobalVariable    :: distinct rawptr
CommVariables     :: distinct rawptr
CommVariable      :: distinct rawptr

VariablesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VariablesVTable,
}

VariablesVTable :: struct
{
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

AddVariable :: proc {
    _AddVariable,
    _AddVariableAtIndex,
}

_AddVariable :: proc(variables: Variables, variable: Variable) -> (ok: bool)
{
    if variables == nil do return
    if variable == nil do return
    if !ComConnected() do return

    hr := (^VariablesIF)(variables)->Add(variable)
    if ComFailed(hr) do return

    return true
}

_AddVariableAtIndex :: proc(variables: Variables, variable: Variable, index: i32) -> (ok: bool)
{
    if variables == nil do return
    if variable == nil do return
    if !ComConnected() do return
    
    hr := (^VariablesIF)(variables)->AddBefore(variable, index)
    if ComFailed(hr) do return

    return true
}

GetVariable :: proc {
    _GetVariableWithName,
    _GetVariableAtIndex,
}

_GetVariableWithName :: proc(variables: Variables, name: string) -> (variable: Variable, ok: bool)
{
    if variables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VariablesIF)(variables)->Find(bstr_name, cast(^rawptr)&variable)
    if ComFailed(hr) do return
    
    return variable, true
}

_GetVariableAtIndex :: proc(variables: Variables, index: i32) -> (variable: Variable, ok: bool)
{
    if variables == nil do return
    if !ComConnected() do return
    
    hr := (^VariablesIF)(variables)->Item(index + 1, cast(^rawptr)&variable)
    if ComFailed(hr) do return
    
    return variable, true
}

VariableIndex :: proc(variables: Variables, name: string) -> (index: i32, ok: bool)
{
    if variables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^VariablesIF)(variables)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

VariableCount :: proc(variables: Variables) -> (count: i32, ok: bool)
{
    if variables == nil do return
    if !ComConnected() do return
    
    hr := (^VariablesIF)(variables)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveVariable :: proc {
    _RemoveVariableWithName,
    _RemoveVariableAtIndex,
}

_RemoveVariableWithName :: proc(variables: Variables, name: string) -> (ok: bool)
{
    if variables == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = VariableIndex(variables, name)
    
    hr := (^VariablesIF)(variables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveVariableAtIndex :: proc(variables: Variables, index: i32) -> (ok: bool)
{
    if variables == nil do return
    if !ComConnected() do return
    
    hr := (^VariablesIF)(variables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseVariables :: proc(variables: Variables)
{
    if variables != nil {
        (^VariablesIF)(variables)->Release()
    }
}

VariableIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^VariableVTable,
}

VariableVTable :: struct
{
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

SerializeVariable :: proc(variable: Variable) -> (xml: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetVariableName :: proc(variable: Variable) -> (name: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVariableName :: proc(variable: Variable, name: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableTypeName :: proc(variable: Variable) -> (type_name: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetVariableTypeName :: proc(variable: Variable, type_name: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableAttribute :: proc(variable: Variable) -> (attribute: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->AttributeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableAttribute :: proc(variable: Variable, attribute: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->AttributePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableInitialValue :: proc(variable: Variable) -> (inital_value: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->InitialValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableInitialValue :: proc(variable: Variable, inital_value: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(inital_value)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->InitialValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableDescription :: proc(variable: Variable) -> (description: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableDescription :: proc(variable: Variable, description: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableReadPermission :: proc(variable: Variable) -> (read_permission: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableReadPermission :: proc(variable: Variable, read_permission: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableWritePermission :: proc(variable: Variable) -> (write_permission: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->WritePermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableWritePermission :: proc(variable: Variable, write_permission: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(write_permission)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->WritePermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableAuthenticationLevel :: proc(variable: Variable) -> (authentication_level: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableAuthenticationLevel :: proc(variable: Variable, authentication_level: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(authentication_level)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->AuthenticationLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableBatchProperty :: proc(variable: Variable) -> (batch_property: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->BatchPropertyGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableBatchProperty :: proc(variable: Variable, batch_property: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(batch_property)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->BatchPropertyPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableGraphNodes :: proc(variable: Variable) -> (graph_nodes: GraphNodes, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if ComFailed(hr) do return
    
    return graph_nodes, true
}

SetVariableGraphNodes :: proc(variable: Variable, graph_nodes: GraphNodes) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    hr := (^VariableIF)(variable)->GraphNodesPut(graph_nodes)
    if ComFailed(hr) do return
    
    return true
}

GetVariableTypeGuid :: proc(variable: Variable) -> (guid: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->TypeGuid(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetVariableTypePath :: proc(variable: Variable) -> (path: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->TypePath(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetVariableAccessLevel :: proc(variable: Variable) -> (access_level: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableAccessLevel :: proc(variable: Variable, access_level: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetVariableSafetyType :: proc(variable: Variable) -> (safety_type: string, ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetVariableSafetyType :: proc(variable: Variable, safety_type: string) -> (ok: bool)
{
    if variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^VariableIF)(variable)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseVariable :: proc(variable: Variable)
{
    if variable != nil {
        (^VariableIF)(variable)->Release()
    }
}

ExternalVariablesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExternalVariablesVTable,
}

ExternalVariablesVTable :: struct
{
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

AddExternalVariable :: proc {
    _AddExternalVariable,
    _AddExternalVariableAtIndex,
}

_AddExternalVariable :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable) -> (ok: bool)
{
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !ComConnected() do return

    hr := (^ExternalVariablesIF)(externalvariables)->Add(externalvariable)
    if ComFailed(hr) do return

    return true
}

_AddExternalVariableAtIndex :: proc(externalvariables: ExternalVariables, externalvariable: ExternalVariable, index: i32) -> (ok: bool)
{
    if externalvariables == nil do return
    if externalvariable == nil do return
    if !ComConnected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->AddBefore(externalvariable, index)
    if ComFailed(hr) do return

    return true
}

GetExternalVariable :: proc {
    _GetExternalVariableWithName,
    _GetExternalVariableAtIndex,
}

_GetExternalVariableWithName :: proc(externalvariables: ExternalVariables, name: string) -> (externalvariable: ExternalVariable, ok: bool)
{
    if externalvariables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->Find(bstr_name, cast(^rawptr)&externalvariable)
    if ComFailed(hr) do return
    
    return externalvariable, true
}

_GetExternalVariableAtIndex :: proc(externalvariables: ExternalVariables, index: i32) -> (externalvariable: ExternalVariable, ok: bool)
{
    if externalvariables == nil do return
    if !ComConnected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Item(index + 1, cast(^rawptr)&externalvariable)
    if ComFailed(hr) do return
    
    return externalvariable, true
}

ExternalVariableIndex :: proc(externalvariables: ExternalVariables, name: string) -> (index: i32, ok: bool)
{
    if externalvariables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ExternalVariablesIF)(externalvariables)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

ExternalVariableCount :: proc(externalvariables: ExternalVariables) -> (count: i32, ok: bool)
{
    if externalvariables == nil do return
    if !ComConnected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveExternalVariable :: proc {
    _RemoveExternalVariableWithName,
    _RemoveExternalVariableAtIndex,
}

_RemoveExternalVariableWithName :: proc(externalvariables: ExternalVariables, name: string) -> (ok: bool)
{
    if externalvariables == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ExternalVariableIndex(externalvariables, name)
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveExternalVariableAtIndex :: proc(externalvariables: ExternalVariables, index: i32) -> (ok: bool)
{
    if externalvariables == nil do return
    if !ComConnected() do return
    
    hr := (^ExternalVariablesIF)(externalvariables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseExternalVariables :: proc(externalvariables: ExternalVariables)
{
    if externalvariables != nil {
        (^ExternalVariablesIF)(externalvariables)->Release()
    }
}

ExternalVariableIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExternalVariableVTable,
}

ExternalVariableVTable :: struct
{
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

SerializeExternalVariable :: proc(external_variable: ExternalVariable) -> (xml: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetExternalVariableName :: proc(external_variable: ExternalVariable) -> (name: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExternalVariableName :: proc(external_variable: ExternalVariable, name: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableTypeName :: proc(external_variable: ExternalVariable) -> (type_name: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetExternalVariableTypeName :: proc(external_variable: ExternalVariable, type_name: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableAttribute :: proc(external_variable: ExternalVariable) -> (attribute: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableAttribute :: proc(external_variable: ExternalVariable, attribute: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->AttributePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableDescription :: proc(external_variable: ExternalVariable) -> (description: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableDescription :: proc(external_variable: ExternalVariable, description: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableReadPermission :: proc(external_variable: ExternalVariable) -> (read_permission: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableReadPermission :: proc(external_variable: ExternalVariable, read_permission: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableWritePermission :: proc(external_variable: ExternalVariable) -> (write_permission: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableWritePermission :: proc(external_variable: ExternalVariable, write_permission: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(write_permission)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->WritePermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableAuthenticationLevel :: proc(external_variable: ExternalVariable) -> (authentication_level: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableAuthenticationLevel :: proc(external_variable: ExternalVariable, authentication_level: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(authentication_level)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->AuthenticationLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableGraphNodes :: proc(external_variable: ExternalVariable) -> (graph_nodes: GraphNodes, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if ComFailed(hr) do return
    
    return graph_nodes, true
}

SetExternalVariableGraphNodes :: proc(external_variable: ExternalVariable, graph_nodes: GraphNodes) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    hr := (^ExternalVariableIF)(external_variable)->GraphNodesPut(graph_nodes)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableTypeGuid :: proc(external_variable: ExternalVariable) -> (guid: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypeGuid(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetExternalVariableTypePath :: proc(external_variable: ExternalVariable) -> (path: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->TypePath(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetExternalVariableAccessLevel :: proc(external_variable: ExternalVariable) -> (access_level: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableAccessLevel :: proc(external_variable: ExternalVariable, access_level: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetExternalVariableSafetyType :: proc(external_variable: ExternalVariable) -> (safety_type: string, ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetExternalVariableSafetyType :: proc(external_variable: ExternalVariable, safety_type: string) -> (ok: bool)
{
    if external_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^ExternalVariableIF)(external_variable)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseExternalVariable :: proc(external_variable: ExternalVariable)
{
    if external_variable != nil {
        (^ExternalVariableIF)(external_variable)->Release()
    }
}

GlobalVariablesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GlobalVariablesVTable,
}

GlobalVariablesVTable :: struct
{
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

AddGlobalVariable :: proc {
    _AddGlobalVariable,
    _AddGlobalVariableAtIndex,
}

_AddGlobalVariable :: proc(globalvariables: GlobalVariables, globalvariable: GlobalVariable) -> (ok: bool)
{
    if globalvariables == nil do return
    if globalvariable == nil do return
    if !ComConnected() do return

    hr := (^GlobalVariablesIF)(globalvariables)->Add(globalvariable)
    if ComFailed(hr) do return

    return true
}

_AddGlobalVariableAtIndex :: proc(globalvariables: GlobalVariables, globalvariable: GlobalVariable, index: i32) -> (ok: bool)
{
    if globalvariables == nil do return
    if globalvariable == nil do return
    if !ComConnected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->AddBefore(globalvariable, index)
    if ComFailed(hr) do return

    return true
}

GetGlobalVariable :: proc {
    _GetGlobalVariableWithName,
    _GetGlobalVariableAtIndex,
}

_GetGlobalVariableWithName :: proc(globalvariables: GlobalVariables, name: string) -> (globalvariable: GlobalVariable, ok: bool)
{
    if globalvariables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^GlobalVariablesIF)(globalvariables)->Find(bstr_name, cast(^rawptr)&globalvariable)
    if ComFailed(hr) do return
    
    return globalvariable, true
}

_GetGlobalVariableAtIndex :: proc(globalvariables: GlobalVariables, index: i32) -> (globalvariable: GlobalVariable, ok: bool)
{
    if globalvariables == nil do return
    if !ComConnected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Item(index + 1, cast(^rawptr)&globalvariable)
    if ComFailed(hr) do return
    
    return globalvariable, true
}

GlobalVariableIndex :: proc(globalvariables: GlobalVariables, name: string) -> (index: i32, ok: bool)
{
    if globalvariables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^GlobalVariablesIF)(globalvariables)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

GlobalVariableCount :: proc(globalvariables: GlobalVariables) -> (count: i32, ok: bool)
{
    if globalvariables == nil do return
    if !ComConnected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveGlobalVariable :: proc {
    _RemoveGlobalVariableWithName,
    _RemoveGlobalVariableAtIndex,
}

_RemoveGlobalVariableWithName :: proc(globalvariables: GlobalVariables, name: string) -> (ok: bool)
{
    if globalvariables == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = GlobalVariableIndex(globalvariables, name)
    
    hr := (^GlobalVariablesIF)(globalvariables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveGlobalVariableAtIndex :: proc(globalvariables: GlobalVariables, index: i32) -> (ok: bool)
{
    if globalvariables == nil do return
    if !ComConnected() do return
    
    hr := (^GlobalVariablesIF)(globalvariables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseGlobalVariables :: proc(globalvariables: GlobalVariables)
{
    if globalvariables != nil {
        (^GlobalVariablesIF)(globalvariables)->Release()
    }
}

GlobalVariableIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^GlobalVariableVTable,
}

GlobalVariableVTable :: struct
{
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

SerializeGlobalVariable :: proc(global_variable: GlobalVariable) -> (xml: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetGlobalVariableName :: proc(global_variable: GlobalVariable) -> (name: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetGlobalVariableName :: proc(global_variable: GlobalVariable, name: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableTypeName :: proc(global_variable: GlobalVariable) -> (type_name: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetGlobalVariableTypeName :: proc(global_variable: GlobalVariable, type_name: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableAttribute :: proc(global_variable: GlobalVariable) -> (attribute: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableAttribute :: proc(global_variable: GlobalVariable, attribute: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->AttributePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableInitialValue :: proc(global_variable: GlobalVariable) -> (inital_value: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableInitialValue :: proc(global_variable: GlobalVariable, inital_value: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(inital_value)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->InitialValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableDescription :: proc(global_variable: GlobalVariable) -> (description: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableDescription :: proc(global_variable: GlobalVariable, description: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableReadPermission :: proc(global_variable: GlobalVariable) -> (read_permission: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableReadPermission :: proc(global_variable: GlobalVariable, read_permission: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableWritePermission :: proc(global_variable: GlobalVariable) -> (write_permission: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableWritePermission :: proc(global_variable: GlobalVariable, write_permission: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(write_permission)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->WritePermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableAuthenticationLevel :: proc(global_variable: GlobalVariable) -> (authentication_level: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableAuthenticationLevel :: proc(global_variable: GlobalVariable, authentication_level: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(authentication_level)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->AuthenticationLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableGraphNodes :: proc(global_variable: GlobalVariable) -> (graph_nodes: GraphNodes, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if ComFailed(hr) do return
    
    return graph_nodes, true
}

SetGlobalVariableGraphNodes :: proc(global_variable: GlobalVariable, graph_nodes: GraphNodes) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    hr := (^GlobalVariableIF)(global_variable)->GraphNodesPut(graph_nodes)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableTypeGuid :: proc(global_variable: GlobalVariable) -> (guid: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypeGuid(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetGlobalVariableTypePath :: proc(global_variable: GlobalVariable) -> (path: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->TypePath(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetGlobalVariableAccessLevel :: proc(global_variable: GlobalVariable) -> (access_level: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableAccessLevel :: proc(global_variable: GlobalVariable, access_level: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetGlobalVariableSafetyType :: proc(global_variable: GlobalVariable) -> (safety_type: string, ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetGlobalVariableSafetyType :: proc(global_variable: GlobalVariable, safety_type: string) -> (ok: bool)
{
    if global_variable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^GlobalVariableIF)(global_variable)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseGlobalVariable :: proc(global_variable: GlobalVariable)
{
    if global_variable != nil {
        (^GlobalVariableIF)(global_variable)->Release()
    }
}

CommVariablesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CommVariablesVTable,
}

CommVariablesVTable :: struct
{
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

AddCommVariable :: proc {
    _AddCommVariable,
    _AddCommVariableAtIndex,
}

_AddCommVariable :: proc(commvariables: CommVariables, commvariable: CommVariable) -> (ok: bool)
{
    if commvariables == nil do return
    if commvariable == nil do return
    if !ComConnected() do return

    hr := (^CommVariablesIF)(commvariables)->Add(commvariable)
    if ComFailed(hr) do return

    return true
}

_AddCommVariableAtIndex :: proc(commvariables: CommVariables, commvariable: CommVariable, index: i32) -> (ok: bool)
{
    if commvariables == nil do return
    if commvariable == nil do return
    if !ComConnected() do return
    
    hr := (^CommVariablesIF)(commvariables)->AddBefore(commvariable, index)
    if ComFailed(hr) do return

    return true
}

GetCommVariable :: proc {
    _GetCommVariableWithName,
    _GetCommVariableAtIndex,
}

_GetCommVariableWithName :: proc(commvariables: CommVariables, name: string) -> (commvariable: CommVariable, ok: bool)
{
    if commvariables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->Find(bstr_name, cast(^rawptr)&commvariable)
    if ComFailed(hr) do return
    
    return commvariable, true
}

_GetCommVariableAtIndex :: proc(commvariables: CommVariables, index: i32) -> (commvariable: CommVariable, ok: bool)
{
    if commvariables == nil do return
    if !ComConnected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Item(index + 1, cast(^rawptr)&commvariable)
    if ComFailed(hr) do return
    
    return commvariable, true
}

CommVariableIndex :: proc(commvariables: CommVariables, name: string) -> (index: i32, ok: bool)
{
    if commvariables == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

CommVariableCount :: proc(commvariables: CommVariables) -> (count: i32, ok: bool)
{
    if commvariables == nil do return
    if !ComConnected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveCommVariable :: proc {
    _RemoveCommVariableWithName,
    _RemoveCommVariableAtIndex
}

_RemoveCommVariableWithName :: proc(commvariables: CommVariables, name: string) -> (ok: bool)
{
    if commvariables == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = CommVariableIndex(commvariables, name)
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveCommVariableAtIndex :: proc(commvariables: CommVariables, index: i32) -> (ok: bool)
{
    if commvariables == nil do return
    if !ComConnected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseCommVariables :: proc(commvariables: CommVariables)
{
    if commvariables != nil {
        (^CommVariablesIF)(commvariables)->Release()
    }
}

CommVariableIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CommVariableVTable,
}

CommVariableVTable :: struct
{
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

SerializeCommVariable :: proc(commvariable: CommVariable) -> (xml: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCommVariableName :: proc(commvariable: CommVariable) -> (name: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetCommVariableName :: proc(commvariable: CommVariable, name: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableTypeName :: proc(commvariable: CommVariable) -> (type_name: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetCommVariableTypeName :: proc(commvariable: CommVariable, type_name: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableAttribute :: proc(commvariable: CommVariable) -> (attribute: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->AttributeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableAttribute :: proc(commvariable: CommVariable, attribute: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return

    bs := ToBstr(attribute)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->AttributePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableInitialValue :: proc(commvariable: CommVariable) -> (inital_value: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableInitialValue :: proc(commvariable: CommVariable, inital_value: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(inital_value)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableDirection :: proc(commvariable: CommVariable) -> (direction: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableDirection :: proc(commvariable: CommVariable, direction: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(direction)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableIpAddress :: proc(commvariable: CommVariable) -> (ipaddress: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableIpAddress :: proc(commvariable: CommVariable, ipaddress: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(ipaddress)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableIntervalTime :: proc(commvariable: CommVariable) -> (interval_time: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableIntervalTime :: proc(commvariable: CommVariable, interval_time: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(interval_time)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariablePriority :: proc(commvariable: CommVariable) -> (priority: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariablePriority :: proc(commvariable: CommVariable, priority: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(priority)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableISPValue :: proc(commvariable: CommVariable) -> (isp_value: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableISPValue :: proc(commvariable: CommVariable, isp_value: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(isp_value)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableReadPermission :: proc(commvariable: CommVariable) -> (read_permission: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableReadPermission :: proc(commvariable: CommVariable, read_permission: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableDescription :: proc(commvariable: CommVariable) -> (description: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableDescription :: proc(commvariable: CommVariable, description: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableTypeGuid :: proc(commvariable: CommVariable) -> (guid: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->TypeGuid(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCommVariableTypePath :: proc(commvariable: CommVariable) -> (path: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->TypePath(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCommVariableExpectedSil :: proc(commvariable: CommVariable) -> (expected_sil: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableExpectedSil :: proc(commvariable: CommVariable, expected_sil: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(expected_sil)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableUniqueID :: proc(commvariable: CommVariable) -> (unique_id: i32, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    id: i32
    hr := (^CommVariableIF)(commvariable)->UniqueIDGet(&id)
    if ComFailed(hr) do return
    
    return id, true
}

SetCommVariableUniqueID :: proc(commvariable: CommVariable, unique_id: i32) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    hr := (^CommVariableIF)(commvariable)->UniqueIDPut(unique_id)
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableRestrictedSIL :: proc(commvariable: CommVariable) -> (restricted_sil: bool, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^CommVariableIF)(commvariable)->RestrictedSILGet(&vb)
    if ComFailed(hr) do return
    
    return FromVariantBool(vb), true
}

SetCommVariableRestrictedSIL :: proc(commvariable: CommVariable, restricted_sil: bool) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    hr := (^CommVariableIF)(commvariable)->RestrictedSILPut(ToVariantBool(restricted_sil))
    if ComFailed(hr) do return
    
    return true
}

GetCommVariableAcknowledgeGroup :: proc(commvariable: CommVariable) -> (acknowledge_group: string, ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCommVariableAcknowledgeGroup :: proc(commvariable: CommVariable, acknowledge_group: string) -> (ok: bool)
{
    if commvariable == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(acknowledge_group)
    defer FreeBstr(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupPut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseCommVariable :: proc(commvariable: CommVariable)
{
    if commvariable != nil {
        (^CommVariableIF)(commvariable)->Release()
    }
}
