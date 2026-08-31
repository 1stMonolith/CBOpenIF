package com

FunctionBlockType :: distinct rawptr
FunctionBlocks    :: distinct rawptr
FunctionBlock     :: distinct rawptr

FunctionBlockTypeIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlockTypeVTable,
}

FunctionBlockTypeVTable :: struct
{
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
    InstantiateAsAspectObjectGet: proc "system" (this: ^FunctionBlockTypeIF, AspectObject: ^VariantBool) -> HResult,
    InstantiateAsAspectObjectPut: proc "system" (this: ^FunctionBlockTypeIF, AspectObject: VariantBool) -> HResult,
    EmbeddedGraphicsVisibleGet:   proc "system" (this: ^FunctionBlockTypeIF, EmbeddedGraphicsVisible: ^VariantBool) -> HResult,
    EmbeddedGraphicsVisiblePut:   proc "system" (this: ^FunctionBlockTypeIF, EmbeddedGraphicsVisible: VariantBool) -> HResult,
    RestrictedSILGet:             proc "system" (this: ^FunctionBlockTypeIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:             proc "system" (this: ^FunctionBlockTypeIF, RestrictedSIL: VariantBool) -> HResult,
}

SerializeFunctionBlockType :: proc(functionblocktype: FunctionBlockType) -> (xml: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->Serialize(&bs)
    if ComFailed(hr) do return
    return FromBstr(bs), true
}

GetFunctionBlockTypeName :: proc(functionblocktype: FunctionBlockType) -> (name: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTypeName :: proc(functionblocktype: FunctionBlockType, name: string) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeProtected :: proc(functionblocktype: FunctionBlockType) -> (protected: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ProtectedGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeProtected :: proc(functionblocktype: FunctionBlockType, protected: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ProtectedPut(ToVariantBool(protected))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeHidden :: proc(functionblocktype: FunctionBlockType) -> (hidden: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->HiddenGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeHidden :: proc(functionblocktype: FunctionBlockType, hidden: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->HiddenPut(ToVariantBool(hidden))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeScope :: proc(functionblocktype: FunctionBlockType) -> (scope: i32, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    s: i32
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ScopeGet(&s)
    if ComFailed(hr) do return

    return s, true
}

SetFunctionBlockTypeScope :: proc(functionblocktype: FunctionBlockType, scope: i32) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ScopePut(scope)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeInteractionWindow :: proc(functionblocktype: FunctionBlockType) -> (interaction_window: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InteractionWindowGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTypeInteractionWindow :: proc(functionblocktype: FunctionBlockType, interaction_window: string) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs := ToBstr(interaction_window)
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InteractionWindowPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeAlarmOwner :: proc(functionblocktype: FunctionBlockType) -> (alarm_owner: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->AlarmOwnerGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeAlarmOwner :: proc(functionblocktype: FunctionBlockType, alarm_owner: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->AlarmOwnerPut(ToVariantBool(alarm_owner))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeGuid :: proc(functionblocktype: FunctionBlockType) -> (guid: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTypeGuid :: proc(functionblocktype: FunctionBlockType, guid: string) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeSILLevel :: proc(functionblocktype: FunctionBlockType) -> (sil_level: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SILLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTypeSILLevel :: proc(functionblocktype: FunctionBlockType, sil_level: string) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs := ToBstr(sil_level)
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SILLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeSimulationMark :: proc(functionblocktype: FunctionBlockType) -> (simulation_mark: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SimulationMarkGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeSimulationMark :: proc(functionblocktype: FunctionBlockType, simulation_mark: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SimulationMarkPut(ToVariantBool(simulation_mark))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeReservedBy :: proc(functionblocktype: FunctionBlockType) -> (reserved_by_function: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTypeReservedBy :: proc(functionblocktype: FunctionBlockType, reserved_by_function: string) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeDescription :: proc(functionblocktype: FunctionBlockType) -> (description: string, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTypeDescription :: proc(functionblocktype: FunctionBlockType, description: string) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeParameters :: proc(functionblocktype: FunctionBlockType) -> (parameters: Parameters, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ParametersGet(&p)
    if ComFailed(hr) do return

    return Parameters(p), true
}

SetFunctionBlockTypeParameters :: proc(functionblocktype: FunctionBlockType, parameters: Parameters) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ParametersPut(parameters)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeExtensibleParameters :: proc(functionblocktype: FunctionBlockType) -> (extensibleparameters: ExtensibleParameters, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExtensibleParametersGet(&p)
    if ComFailed(hr) do return

    return ExtensibleParameters(p), true
}

SetFunctionBlockTypeExtensibleParameters :: proc(functionblocktype: FunctionBlockType, extensibleparameters: ExtensibleParameters) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExtensibleParametersPut(extensibleparameters)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeVariables :: proc(functionblocktype: FunctionBlockType) -> (variables: Variables, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->VariablesGet(&p)
    if ComFailed(hr) do return

    return Variables(p), true
}

SetFunctionBlockTypeVariables :: proc(functionblocktype: FunctionBlockType, variables: Variables) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->VariablesPut(variables)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeExternalVariables :: proc(functionblocktype: FunctionBlockType) -> (externalvariables: ExternalVariables, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExternalVariablesGet(&p)
    if ComFailed(hr) do return

    return ExternalVariables(p), true
}

SetFunctionBlockTypeExternalVariables :: proc(functionblocktype: FunctionBlockType, externalvariables: ExternalVariables) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExternalVariablesPut(externalvariables)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeFunctionBlocks :: proc(functionblocktype: FunctionBlockType) -> (functionblocks: FunctionBlocks, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->FunctionBlocksGet(&p)
    if ComFailed(hr) do return

    return FunctionBlocks(p), true
}

SetFunctionBlockTypeFunctionBlocks :: proc(functionblocktype: FunctionBlockType, functionblocks: FunctionBlocks) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->FunctionBlocksPut(functionblocks)
    if ComFailed(hr) do return

    return true
}

/* I do not think function blocks have control modules...
GetFunctionBlockTypeControlModules :: proc(functionblocktype: FunctionBlockType) -> (controlmodules: ControlModules, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ControlModulesGet(&p)
    if ComFailed(hr) do return

    return ControlModules(p), true
}

// I do not think function blocks have control modules...
SetFunctionBlockTypeControlModules :: proc(functionblocktype: FunctionBlockType, controlmodules: ControlModules) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ControlModulesPut(controlmodules)
    if ComFailed(hr) do return

    return true
}
*/

GetFunctionBlockTypeCodeBlocks :: proc(functionblocktype: FunctionBlockType) -> (codeblocks: CodeBlocks, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->CodeBlocksGet(&p)
    if ComFailed(hr) do return

    return CodeBlocks(p), true
}

SetFunctionBlockTypeCodeBlocks :: proc(functionblocktype: FunctionBlockType, codeblocks: CodeBlocks) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->CodeBlocksPut(codeblocks)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeAspectObject :: proc(functionblocktype: FunctionBlockType) -> (instantiate_as_aspect_object: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InstantiateAsAspectObjectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeAspectObject :: proc(functionblocktype: FunctionBlockType, instantiate_as_aspect_object: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InstantiateAsAspectObjectPut(ToVariantBool(instantiate_as_aspect_object))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeGraphicsVisible :: proc(functionblocktype: FunctionBlockType) -> (embedded_graphiscs_visible: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->EmbeddedGraphicsVisibleGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeGraphicsVisible :: proc(functionblocktype: FunctionBlockType, embedded_graphiscs_visible: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->EmbeddedGraphicsVisiblePut(ToVariantBool(embedded_graphiscs_visible))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypeRestrictedSIL :: proc(functionblocktype: FunctionBlockType) -> (restricted_sil: bool, ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->RestrictedSILGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockTypeRestrictedSIL :: proc(functionblocktype: FunctionBlockType, restricted_sil: bool) -> (ok: bool)
{
    if functionblocktype == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->RestrictedSILPut(ToVariantBool(restricted_sil))
    if ComFailed(hr) do return

    return true
}

ReleaseFunctionBlockType :: proc(functionblocktype: FunctionBlockType) {
    if functionblocktype != nil {
        (^FunctionBlockTypeIF)(functionblocktype)->Release()
    }
}

FunctionBlocksIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlocksVTable,
}

FunctionBlocksVTable :: struct
{
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

AddFunctionBlock :: proc {
    _AddFunctionBlock,
    _AddFunctionBlockAtIndex,
}

_AddFunctionBlock :: proc(functionblocks: FunctionBlocks, functionblock: FunctionBlock) -> (ok: bool)
{
    if functionblocks == nil do return
    if functionblock == nil do return
    if !ComConnected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Add(functionblock)
    if ComFailed(hr) do return

    return true
}

_AddFunctionBlockAtIndex :: proc(functionblocks: FunctionBlocks, functionblock: FunctionBlock, index: i32) -> (ok: bool)
{
    if functionblocks == nil do return
    if functionblock == nil do return
    if !ComConnected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->AddBefore(functionblock, index)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockWithName :: proc(functionblocks: FunctionBlocks, name: string) -> (functionblock: FunctionBlock, ok: bool)
{
    if functionblocks == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^FunctionBlocksIF)(functionblocks)->Find(bstr_name, cast(^rawptr)&functionblock)
    if ComFailed(hr) do return

    return functionblock, true
}

GetFunctionBlockAtIndex :: proc(functionblocks: FunctionBlocks, index: i32) -> (functionblock: FunctionBlock, ok: bool)
{
    if functionblocks == nil do return
    if !ComConnected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Item(index + 1, cast(^rawptr)&functionblock)
    if ComFailed(hr) do return

    return functionblock, true
}

FunctionBlockIndex :: proc(functionblocks: FunctionBlocks, name: string) -> (index: i32, ok: bool)
{
    if functionblocks == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^FunctionBlocksIF)(functionblocks)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

FunctionBlockCount :: proc(functionblocks: FunctionBlocks) -> (count: i32, ok: bool)
{
    if functionblocks == nil do return
    if !ComConnected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveFunctionBlock :: proc {
    _RemoveFunctionBlockWithName,
    _RemoveFunctionBlockAtIndex,
}

_RemoveFunctionBlockWithName :: proc(functionblocks: FunctionBlocks, name: string) -> (ok: bool)
{
    if functionblocks == nil do return
    if !ComConnected() do return

    index, found := FunctionBlockIndex(functionblocks, name)
    if !found do return

    hr := (^FunctionBlocksIF)(functionblocks)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveFunctionBlockAtIndex :: proc(functionblocks: FunctionBlocks, index: i32) -> (ok: bool)
{
    if functionblocks == nil do return
    if !ComConnected() do return

    hr := (^FunctionBlocksIF)(functionblocks)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseFunctionBlocks :: proc(functionblocks: FunctionBlocks) {
    if functionblocks != nil {
        (^FunctionBlocksIF)(functionblocks)->Release()
    }
}

FunctionBlockIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^FunctionBlockVTable,
}

FunctionBlockVTable :: struct
{
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

SerializeFunctionBlock :: proc(functionblock: FunctionBlock) -> (xml: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetFunctionBlockName :: proc(functionblock: FunctionBlock) -> (name: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockName :: proc(functionblock: FunctionBlock, name: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypesName :: proc(functionblock: FunctionBlock) -> (type_name: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeNameGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetFunctionBlockTypesName :: proc(functionblock: FunctionBlock, type_name: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetFunctionBlockTaskConnection :: proc(functionblock: FunctionBlock) -> (task_connection: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->TaskConnectionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockTaskConnection :: proc(functionblock: FunctionBlock, task_connection: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs := ToBstr(task_connection)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->TaskConnectionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockGuid :: proc(functionblock: FunctionBlock) -> (guid: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockGuid :: proc(functionblock: FunctionBlock, guid: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockDescription :: proc(functionblock: FunctionBlock) -> (description: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetFunctionBlockDescription :: proc(functionblock: FunctionBlock, description: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockTypesGuid :: proc(functionblock: FunctionBlock) -> (type_guid: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypeGuidGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetFunctionBlockTypesPath :: proc(functionblock: FunctionBlock) -> (type_path: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->TypePathGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetFunctionBlockAspectObject :: proc(functionblock: FunctionBlock) -> (aspect_object: bool, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockIF)(functionblock)->AspectObjectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockAspectObject :: proc(functionblock: FunctionBlock, aspect_object: bool) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    hr := (^FunctionBlockIF)(functionblock)->AspectObjectPut(ToVariantBool(aspect_object))
    if ComFailed(hr) do return

    return true
}

GetFunctionBlockAccessLevel :: proc(functionblock: FunctionBlock) -> (access_level: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetFunctionBlockAccessLevel :: proc(functionblock: FunctionBlock, access_level: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetFunctionBlockSafetyType :: proc(functionblock: FunctionBlock) -> (safety_type: string, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetFunctionBlockSafetyType :: proc(functionblock: FunctionBlock, safety_type: string) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^FunctionBlockIF)(functionblock)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetFunctionBlockExposeProperties :: proc(functionblock: FunctionBlock) -> (expose_properties_in_parent: bool, ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockIF)(functionblock)->ExposePropertiesInParentGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetFunctionBlockExposeProperties :: proc(functionblock: FunctionBlock, expose_properties_in_parent: bool) -> (ok: bool)
{
    if functionblock == nil do return
    if !ComConnected() do return
    
    vb := ToVariantBool(expose_properties_in_parent)
    hr := (^FunctionBlockIF)(functionblock)->ExposePropertiesInParentPut(vb)
    if ComFailed(hr) do return

    return true
}

ReleaseFunctionBlock :: proc(functionblock: FunctionBlock) {
    if functionblock != nil {
        (^FunctionBlockIF)(functionblock)->Release()
    }
}
