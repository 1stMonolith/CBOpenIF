package com

import t "../types"

FunctionBlock     :: distinct rawptr
FunctionBlocks    :: distinct rawptr
FunctionBlockType :: distinct rawptr

FunctionBlockIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlockVTable,
}

FunctionBlockVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                     proc "system" (this: ^FunctionBlockIF, name: ^BStr) -> HResult,
    NamePut:                     proc "system" (this: ^FunctionBlockIF, name: BStr) -> HResult,
    TypeNameGet:                 proc "system" (this: ^FunctionBlockIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:                 proc "system" (this: ^FunctionBlockIF, TypeName: BStr) -> HResult,
    TaskConnectionGet:           proc "system" (this: ^FunctionBlockIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:           proc "system" (this: ^FunctionBlockIF, TaskConnection: BStr) -> HResult,
    GuidGet:                     proc "system" (this: ^FunctionBlockIF, Guid: ^BStr) -> HResult,
    GuidPut:                     proc "system" (this: ^FunctionBlockIF, Guid: BStr) -> HResult,
    DescriptionGet:              proc "system" (this: ^FunctionBlockIF, Description: ^BStr) -> HResult,
    DescriptionPut:              proc "system" (this: ^FunctionBlockIF, Description: BStr) -> HResult,
    TypeGuidGet:                 proc "system" (this: ^FunctionBlockIF, TypeGuid: ^BStr) -> HResult,
    TypePathGet:                 proc "system" (this: ^FunctionBlockIF, TypePath: ^BStr) -> HResult,
    Serialize:                   proc "system" (this: ^FunctionBlockIF, XML: ^BStr) -> HResult,
    AspectObjectGet:             proc "system" (this: ^FunctionBlockIF, AspectObject: ^VariantBool) -> HResult,
    AspectObjectPut:             proc "system" (this: ^FunctionBlockIF, AspectObject: VariantBool) -> HResult,
    AccessLevelGet:              proc "system" (this: ^FunctionBlockIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:              proc "system" (this: ^FunctionBlockIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:               proc "system" (this: ^FunctionBlockIF, X: ^BStr) -> HResult,
    SafetyTypePut:               proc "system" (this: ^FunctionBlockIF, X: BStr) -> HResult,
    ExposePropertiesInParentGet: proc "system" (this: ^FunctionBlockIF, Expose: ^VariantBool) -> HResult,
    ExposePropertiesInParentPut: proc "system" (this: ^FunctionBlockIF, Expose: VariantBool) -> HResult,
}

functionblock_serialize :: proc(functionblock: FunctionBlock) -> (xml: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_name_get :: proc(functionblock: FunctionBlock) -> (name: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_name_set :: proc(functionblock: FunctionBlock, name: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_type_name_get :: proc(functionblock: FunctionBlock) -> (type_name: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeNameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_type_name_set :: proc(functionblock: FunctionBlock, type_name: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

functionblock_task_connection_get :: proc(functionblock: FunctionBlock) -> (task_connection: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_task_connection_set :: proc(functionblock: FunctionBlock, task_connection: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_guid_get :: proc(functionblock: FunctionBlock) -> (guid: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_guid_set :: proc(functionblock: FunctionBlock, guid: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_description_get :: proc(functionblock: FunctionBlock) -> (description: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblock_description_set :: proc(functionblock: FunctionBlock, description: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblock_type_guid_get :: proc(functionblock: FunctionBlock) -> (type_guid: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeGuidGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_type_path_get :: proc(functionblock: FunctionBlock) -> (type_path: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypePathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_aspect_object_get :: proc(functionblock: FunctionBlock) -> (aspect_object: bool, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockIF)(functionblock)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblock_aspect_object_set :: proc(functionblock: FunctionBlock, aspect_object: bool) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockIF)(functionblock)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

functionblock_access_level_get :: proc(functionblock: FunctionBlock) -> (access_level: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_access_level_set :: proc(functionblock: FunctionBlock, access_level: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

functionblock_safety_type_get :: proc(functionblock: FunctionBlock) -> (safety_type: string, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

functionblock_safety_type_set :: proc(functionblock: FunctionBlock, safety_type: string) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^FunctionBlockIF)(functionblock)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

functionblock_expose_properties_in_parent_get :: proc(functionblock: FunctionBlock) -> (expose_properties_in_parent: bool, ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockIF)(functionblock)->ExposePropertiesInParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblock_expose_properties_in_parent_set :: proc(functionblock: FunctionBlock, expose_properties_in_parent: bool) -> (ok: bool) {
    if functionblock == nil do return
    if !com_connected() do return
    
    vb := to_variantbool(expose_properties_in_parent)
    hr := (^FunctionBlockIF)(functionblock)->ExposePropertiesInParentPut(vb)
    if com_failed(hr) do return

    return true
}

functionblock_release :: proc(functionblock: FunctionBlock) {
    if functionblock != nil {
        (^FunctionBlockIF)(functionblock)->Release()
    }
}

FunctionBlocksIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlocksVTable,
}

FunctionBlocksVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^FunctionBlocksIF, FunctionBlocks: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^FunctionBlocksIF, FunctionBlocks: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^FunctionBlocksIF, Name, TypeName: BStr, FunctionBlock: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^FunctionBlocksIF, Name, TypeName, TaskConnection, Guid, Description: BStr, FunctionBlock: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^FunctionBlocksIF, Name: BStr, FunctionBlock: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^FunctionBlocksIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^FunctionBlocksIF, Index: i32, FunctionBlock: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^FunctionBlocksIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^FunctionBlocksIF, Index: i32) -> HResult,
}

functionblocks_functionblock_add :: proc(functionblocks: FunctionBlocks, functionblock: FunctionBlock) -> (ok: bool) {
    if functionblocks == nil do return
    if functionblock == nil do return
    if !com_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Add(functionblock)
    if com_failed(hr) do return

    return true
}

functionblocks_functionblock_add_at_index :: proc(functionblocks: FunctionBlocks, functionblock: FunctionBlock, index: i32) -> (ok: bool) {
    if functionblocks == nil do return
    if functionblock == nil do return
    if !com_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->AddBefore(functionblock, index)
    if com_failed(hr) do return

    return true
}

functionblocks_functionblock_by_name :: proc(functionblocks: FunctionBlocks, name: string) -> (functionblock: FunctionBlock, ok: bool) {
    if functionblocks == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^FunctionBlocksIF)(functionblocks)->Find(bstr_name, cast(^rawptr)&functionblock)
    if com_failed(hr) do return

    return functionblock, true
}

functionblocks_functionblock_by_index :: proc(functionblocks: FunctionBlocks, index: i32) -> (functionblock: FunctionBlock, ok: bool) {
    if functionblocks == nil do return
    if !com_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Item(index + 1, cast(^rawptr)&functionblock)
    if com_failed(hr) do return

    return functionblock, true
}

functionblocks_functionblock_index :: proc(functionblocks: FunctionBlocks, name: string) -> (index: i32, ok: bool) {
    if functionblocks == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^FunctionBlocksIF)(functionblocks)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

functionblocks_functionblock_count :: proc(functionblocks: FunctionBlocks) -> (count: i32, ok: bool) {
    if functionblocks == nil do return
    if !com_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

functionblocks_functionblock_remove_by_name :: proc(functionblocks: FunctionBlocks, name: string) -> (ok: bool) {
    if functionblocks == nil do return
    if !com_connected() do return

    index, found := functionblocks_functionblock_index(functionblocks, name)
    if !found do return

    hr := (^FunctionBlocksIF)(functionblocks)->Remove(index)
    if com_failed(hr) do return

    return true
}

functionblocks_functionblock_remove_by_index :: proc(functionblocks: FunctionBlocks, index: i32) -> (ok: bool) {
    if functionblocks == nil do return
    if !com_connected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

functionblocks_release :: proc(functionblocks: FunctionBlocks) {
    if functionblocks != nil {
        (^FunctionBlocksIF)(functionblocks)->Release()
    }
}

FunctionBlockTypeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlockTypeVTable,
}

FunctionBlockTypeVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                      proc "system" (this: ^FunctionBlockTypeIF, name: ^BStr) -> HResult,
    NamePut:                      proc "system" (this: ^FunctionBlockTypeIF, name: BStr) -> HResult,
    ProtectedGet:                 proc "system" (this: ^FunctionBlockTypeIF, Protected: ^VariantBool) -> HResult,
    ProtectedPut:                 proc "system" (this: ^FunctionBlockTypeIF, Protected: VariantBool) -> HResult,
    HiddenGet:                    proc "system" (this: ^FunctionBlockTypeIF, Hidden: ^VariantBool) -> HResult,
    HiddenPut:                    proc "system" (this: ^FunctionBlockTypeIF, Hidden: VariantBool) -> HResult,
    ScopeGet:                     proc "system" (this: ^FunctionBlockTypeIF, Scope: ^i32) -> HResult,
    ScopePut:                     proc "system" (this: ^FunctionBlockTypeIF, Scope: i32) -> HResult,
    InteractionWindowGet:         proc "system" (this: ^FunctionBlockTypeIF, InteractionWindow: ^BStr) -> HResult,
    InteractionWindowPut:         proc "system" (this: ^FunctionBlockTypeIF, InteractionWindow: BStr) -> HResult,
    AlarmOwnerGet:                proc "system" (this: ^FunctionBlockTypeIF, AlarmOwner: ^VariantBool) -> HResult,
    AlarmOwnerPut:                proc "system" (this: ^FunctionBlockTypeIF, AlarmOwner: VariantBool) -> HResult,
    GuidGet:                      proc "system" (this: ^FunctionBlockTypeIF, Guid: ^BStr) -> HResult,
    GuidPut:                      proc "system" (this: ^FunctionBlockTypeIF, Guid: BStr) -> HResult,
    SILLevelGet:                  proc "system" (this: ^FunctionBlockTypeIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:                  proc "system" (this: ^FunctionBlockTypeIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet:            proc "system" (this: ^FunctionBlockTypeIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:            proc "system" (this: ^FunctionBlockTypeIF, SimulationMark: VariantBool) -> HResult,
    ReservedByFunctionGet:        proc "system" (this: ^FunctionBlockTypeIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut:        proc "system" (this: ^FunctionBlockTypeIF, ReservedByFunction: BStr) -> HResult,
    DescriptionGet:               proc "system" (this: ^FunctionBlockTypeIF, Description: ^BStr) -> HResult,
    DescriptionPut:               proc "system" (this: ^FunctionBlockTypeIF, Description: BStr) -> HResult,
    ParametersGet:                proc "system" (this: ^FunctionBlockTypeIF, Parameters: ^rawptr) -> HResult,
    Missing30:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    ParametersPut:                proc "system" (this: ^FunctionBlockTypeIF, Parameters: rawptr) -> HResult,
    ExtensibleParametersGet:      proc "system" (this: ^FunctionBlockTypeIF, ExtensibleParameters: ^rawptr) -> HResult,
    Missing33:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    ExtensibleParametersPut:      proc "system" (this: ^FunctionBlockTypeIF, ExtensibleParameters: rawptr) -> HResult,
    VariablesGet:                 proc "system" (this: ^FunctionBlockTypeIF, Variables: ^rawptr) -> HResult,
    Missing36:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    VariablesPut:                 proc "system" (this: ^FunctionBlockTypeIF, Variables: rawptr) -> HResult,
    ExternalVariablesGet:         proc "system" (this: ^FunctionBlockTypeIF, ExternalVariables: ^rawptr) -> HResult,
    Missing39:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    ExternalVariablesPut:         proc "system" (this: ^FunctionBlockTypeIF, ExternalVariables: rawptr) -> HResult,
    FunctionBlocksGet:            proc "system" (this: ^FunctionBlockTypeIF, FunctionBlocks: ^rawptr) -> HResult,
    Missing42:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    FunctionBlocksPut:            proc "system" (this: ^FunctionBlockTypeIF, FunctionBlocks: rawptr) -> HResult,
    ControlModulesGet:            proc "system" (this: ^FunctionBlockTypeIF, ControlModules: ^rawptr) -> HResult,
    Missing45:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    ControlModulesPut:            proc "system" (this: ^FunctionBlockTypeIF, ControlModules: rawptr) -> HResult,
    CodeBlocksGet:                proc "system" (this: ^FunctionBlockTypeIF, CodeBlocks: ^rawptr) -> HResult,
    Missing48:                    proc "system" (this: ^FunctionBlockTypeIF) -> HResult,
    CodeBlocksPut:                proc "system" (this: ^FunctionBlockTypeIF, CodeBlocks: rawptr) -> HResult,
    Serialize:                    proc "system" (this: ^FunctionBlockTypeIF, XML: ^BStr) -> HResult,
    InstantiateAsAspectObjectGet: proc "system" (this: ^FunctionBlockTypeIF, InstantiateAsAspectObject: ^VariantBool) -> HResult,
    InstantiateAsAspectObjectPut: proc "system" (this: ^FunctionBlockTypeIF, InstantiateAsAspectObject: VariantBool) -> HResult,
    EmbeddedGraphicsVisibleGet:   proc "system" (this: ^FunctionBlockTypeIF, EmbeddedGraphicsVisible: ^VariantBool) -> HResult,
    EmbeddedGraphicsVisiblePut:   proc "system" (this: ^FunctionBlockTypeIF, EmbeddedGraphicsVisible: VariantBool) -> HResult,
    RestrictedSILGet:             proc "system" (this: ^FunctionBlockTypeIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:             proc "system" (this: ^FunctionBlockTypeIF, RestrictedSIL: VariantBool) -> HResult,
}

functionblocktype_serialize :: proc(functionblocktype: FunctionBlockType) -> (xml: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->Serialize(&bs)
    if com_failed(hr) do return
    return from_bstr(bs), true
}

functionblocktype_name_get :: proc(functionblocktype: FunctionBlockType) -> (name: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_name_set :: proc(functionblocktype: FunctionBlockType, name: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_protected_get :: proc(functionblocktype: FunctionBlockType) -> (protected: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_protected_set :: proc(functionblocktype: FunctionBlockType, protected: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

functionblocktype_hidden_get :: proc(functionblocktype: FunctionBlockType) -> (hidden: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_hidden_set :: proc(functionblocktype: FunctionBlockType, hidden: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

functionblocktype_scope_get :: proc(functionblocktype: FunctionBlockType) -> (scope: t.Scope, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    s: i32
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ScopeGet(&s)
    if com_failed(hr) do return

    return t.Scope(s), true
}

functionblocktype_scope_set :: proc(functionblocktype: FunctionBlockType, scope: t.Scope) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ScopePut(i32(scope))
    if com_failed(hr) do return

    return true
}

functionblocktype_interaction_window_get :: proc(functionblocktype: FunctionBlockType) -> (interaction_window: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InteractionWindowGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_interaction_window_set :: proc(functionblocktype: FunctionBlockType, interaction_window: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs := to_bstr(interaction_window)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InteractionWindowPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_alarm_owner_get :: proc(functionblocktype: FunctionBlockType) -> (alarm_owner: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_alarm_owner_set :: proc(functionblocktype: FunctionBlockType, alarm_owner: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

functionblocktype_guid_get :: proc(functionblocktype: FunctionBlockType) -> (guid: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_guid_set :: proc(functionblocktype: FunctionBlockType, guid: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_sil_level_get :: proc(functionblocktype: FunctionBlockType) -> (sil_level: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_sil_level_set :: proc(functionblocktype: FunctionBlockType, sil_level: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_simulation_mark_get :: proc(functionblocktype: FunctionBlockType) -> (simulation_mark: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_simulation_mark_set :: proc(functionblocktype: FunctionBlockType, simulation_mark: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

functionblocktype_reserved_by_function_get :: proc(functionblocktype: FunctionBlockType) -> (reserved_by_function: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_reserved_by_function_set :: proc(functionblocktype: FunctionBlockType, reserved_by_function: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_description_get :: proc(functionblocktype: FunctionBlockType) -> (description: string, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_description_set :: proc(functionblocktype: FunctionBlockType, description: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_parameters_get :: proc(functionblocktype: FunctionBlockType) -> (parameters: Parameters, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ParametersGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

functionblocktype_parameters_set :: proc(functionblocktype: FunctionBlockType, parameters: Parameters) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ParametersPut(parameters)
    if com_failed(hr) do return

    return true
}

functionblocktype_extensibleparameters_get :: proc(functionblocktype: FunctionBlockType) -> (extensibleparameters: ExtensibleParameters, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExtensibleParametersGet(&p)
    if com_failed(hr) do return

    return ExtensibleParameters(p), true
}

functionblocktype_extensibleparameters_set :: proc(functionblocktype: FunctionBlockType, extensibleparameters: ExtensibleParameters) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExtensibleParametersPut(extensibleparameters)
    if com_failed(hr) do return

    return true
}

functionblocktype_variables_get :: proc(functionblocktype: FunctionBlockType) -> (variables: Variables, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

functionblocktype_variables_set :: proc(functionblocktype: FunctionBlockType, variables: Variables) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

functionblocktype_externalvariables_get :: proc(functionblocktype: FunctionBlockType) -> (externalvariables: ExternalVariables, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExternalVariablesGet(&p)
    if com_failed(hr) do return

    return ExternalVariables(p), true
}

functionblocktype_externalvariables_set :: proc(functionblocktype: FunctionBlockType, externalvariables: ExternalVariables) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExternalVariablesPut(externalvariables)
    if com_failed(hr) do return

    return true
}

functionblocktype_functionblocks_get :: proc(functionblocktype: FunctionBlockType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

functionblocktype_functionblocks_set :: proc(functionblocktype: FunctionBlockType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

// I do not think function blocks have control modules...
functionblocktype_controlmodules_get :: proc(functionblocktype: FunctionBlockType) -> (controlmodules: ControlModules, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

// I do not think function blocks have control modules...
functionblocktype_controlmodules_set :: proc(functionblocktype: FunctionBlockType, controlmodules: ControlModules) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

functionblocktype_codeblocks_get :: proc(functionblocktype: FunctionBlockType) -> (codeblocks: CodeBlocks, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

functionblocktype_codeblocks_set :: proc(functionblocktype: FunctionBlockType, codeblocks: CodeBlocks) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

functionblocktype_instantiate_as_aspect_object_get :: proc(functionblocktype: FunctionBlockType) -> (instantiate_as_aspect_object: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InstantiateAsAspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_instantiate_as_aspect_object_set :: proc(functionblocktype: FunctionBlockType, instantiate_as_aspect_object: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InstantiateAsAspectObjectPut(to_variantbool(instantiate_as_aspect_object))
    if com_failed(hr) do return

    return true
}

functionblocktype_embedded_graphiscs_visible_get :: proc(functionblocktype: FunctionBlockType) -> (embedded_graphiscs_visible: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->EmbeddedGraphicsVisibleGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_embedded_graphiscs_visible_set :: proc(functionblocktype: FunctionBlockType, embedded_graphiscs_visible: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->EmbeddedGraphicsVisiblePut(to_variantbool(embedded_graphiscs_visible))
    if com_failed(hr) do return

    return true
}

functionblocktype_restricted_sil_get :: proc(functionblocktype: FunctionBlockType) -> (restricted_sil: bool, ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_restricted_sil_set :: proc(functionblocktype: FunctionBlockType, restricted_sil: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !com_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

functionblocktype_release :: proc(functionblocktype: FunctionBlockType) {
    if functionblocktype != nil {
        (^FunctionBlockTypeIF)(functionblocktype)->Release()
    }
}
