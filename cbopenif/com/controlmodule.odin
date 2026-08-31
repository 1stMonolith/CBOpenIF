package com

ControlModuleType   :: distinct rawptr
IControlModule      :: distinct rawptr
ControlModules      :: distinct rawptr
ControlModule       :: distinct rawptr
SingleControlModule :: distinct rawptr
CMConnections       :: distinct rawptr
CMConnection        :: distinct rawptr
CMParameters        :: distinct rawptr
CMParameter         :: distinct rawptr

Module :: union {
    ControlModule,
    SingleControlModule,
}

IID_ControlModule       :: GUID{0xCA6E74AC, 0xFBDC, 0x41F3, {0xA1, 0xB5, 0xEC, 0xA6, 0x34, 0xC8, 0x57, 0x7E}}
IID_SingleControlModule :: GUID{0x9DF1C57D, 0x2912, 0x4BF7, {0xB5, 0xBA, 0x0A, 0x0D, 0x87, 0xA4, 0x10, 0x80}}

ControlModuleTypeIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModuleTypeVTable,
}

ControlModuleTypeVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                      proc "system" (this: ^ControlModuleTypeIF, name: ^BStr) -> HResult,
    NamePut:                      proc "system" (this: ^ControlModuleTypeIF, name: BStr) -> HResult,
    ProtectedGet:                 proc "system" (this: ^ControlModuleTypeIF, Protected: ^VariantBool) -> HResult,
    ProtectedPut:                 proc "system" (this: ^ControlModuleTypeIF, Protected: VariantBool) -> HResult,
    HiddenGet:                    proc "system" (this: ^ControlModuleTypeIF, Hidden: ^VariantBool) -> HResult,
    HiddenPut:                    proc "system" (this: ^ControlModuleTypeIF, Hidden: VariantBool) -> HResult,
    ScopeGet:                     proc "system" (this: ^ControlModuleTypeIF, Scope: ^i32) -> HResult,
    ScopePut:                     proc "system" (this: ^ControlModuleTypeIF, Scope: i32) -> HResult,
    InteractionWindowGet:         proc "system" (this: ^ControlModuleTypeIF, InteractionWindow: ^BStr) -> HResult,
    InteractionWindowPut:         proc "system" (this: ^ControlModuleTypeIF, InteractionWindow: BStr) -> HResult,
    AlarmOwnerGet:                proc "system" (this: ^ControlModuleTypeIF, AlarmOwner: ^VariantBool) -> HResult,
    AlarmOwnerPut:                proc "system" (this: ^ControlModuleTypeIF, AlarmOwner: VariantBool) -> HResult,
    GuidGet:                      proc "system" (this: ^ControlModuleTypeIF, Guid: ^BStr) -> HResult,
    GuidPut:                      proc "system" (this: ^ControlModuleTypeIF, Guid: BStr) -> HResult,
    BatchObjectGet:               proc "system" (this: ^ControlModuleTypeIF, BatchObject: ^BStr) -> HResult,
    BatchObjectPut:               proc "system" (this: ^ControlModuleTypeIF, BatchObject: BStr) -> HResult,
    SILLevelGet:                  proc "system" (this: ^ControlModuleTypeIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:                  proc "system" (this: ^ControlModuleTypeIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet:            proc "system" (this: ^ControlModuleTypeIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:            proc "system" (this: ^ControlModuleTypeIF, SimulationMark: VariantBool) -> HResult,
    ReservedByFunctionGet:        proc "system" (this: ^ControlModuleTypeIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut:        proc "system" (this: ^ControlModuleTypeIF, ReservedByFunction: BStr) -> HResult,
    DescriptionGet:               proc "system" (this: ^ControlModuleTypeIF, Description: ^BStr) -> HResult,
    DescriptionPut:               proc "system" (this: ^ControlModuleTypeIF, Description: BStr) -> HResult,
    CMTypeGraphicsGet:            proc "system" (this: ^ControlModuleTypeIF, CMTypeGraphics: ^BStr) -> HResult,
    CMTypeGraphicsPut:            proc "system" (this: ^ControlModuleTypeIF, CMTypeGraphics: BStr) -> HResult,
    CMParametersGet:              proc "system" (this: ^ControlModuleTypeIF, CMParameters: ^rawptr) -> HResult,
    Missing34:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    CMParametersPut:              proc "system" (this: ^ControlModuleTypeIF, CMParameters: rawptr) -> HResult,
    VariablesGet:                 proc "system" (this: ^ControlModuleTypeIF, Variables: ^rawptr) -> HResult,
    Missing37:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    VariablesPut:                 proc "system" (this: ^ControlModuleTypeIF, Variables: rawptr) -> HResult,
    ExternalVariablesGet:         proc "system" (this: ^ControlModuleTypeIF, ExternalVariables: ^rawptr) -> HResult,
    Missing40:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    ExternalVariablesPut:         proc "system" (this: ^ControlModuleTypeIF, ExternalVariables: rawptr) -> HResult,
    FunctionBlocksGet:            proc "system" (this: ^ControlModuleTypeIF, FunctionBlocks: ^rawptr) -> HResult,
    Missing43:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    FunctionBlocksPut:            proc "system" (this: ^ControlModuleTypeIF, FunctionBlocks: rawptr) -> HResult,
    ControlModulesGet:            proc "system" (this: ^ControlModuleTypeIF, ControlModules: ^rawptr) -> HResult,
    Missing46:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    ControlModulesPut:            proc "system" (this: ^ControlModuleTypeIF, ControlModules: rawptr) -> HResult,
    CodeBlocksGet:                proc "system" (this: ^ControlModuleTypeIF, CodeBlocks: ^rawptr) -> HResult,
    Missing49:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    CodeBlocksPut:                proc "system" (this: ^ControlModuleTypeIF, CodeBlocks: rawptr) -> HResult,
    GraphSizeGet:                 proc "system" (this: ^ControlModuleTypeIF, GraphSize: ^rawptr) -> HResult,
    Missing52:                    proc "system" (this: ^ControlModuleTypeIF) -> HResult,
    GraphSizePut:                 proc "system" (this: ^ControlModuleTypeIF, GraphSize: rawptr) -> HResult,
    Serialize:                    proc "system" (this: ^ControlModuleTypeIF, XML: ^BStr) -> HResult,
    InstantiateAsAspectObjectGet: proc "system" (this: ^ControlModuleTypeIF, AspectObject: ^VariantBool) -> HResult,
    InstantiateAsAspectObjectPut: proc "system" (this: ^ControlModuleTypeIF, AspectObject: VariantBool) -> HResult,
    EmbeddedGraphicsVisibleGet:   proc "system" (this: ^ControlModuleTypeIF, EmbeddedGraphicsVisible: ^VariantBool) -> HResult,
    EmbeddedGraphicsVisiblePut:   proc "system" (this: ^ControlModuleTypeIF, EmbeddedGraphicsVisible: VariantBool) -> HResult,
    RestrictedSILGet:             proc "system" (this: ^ControlModuleTypeIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:             proc "system" (this: ^ControlModuleTypeIF, RestrictedSIL: VariantBool) -> HResult,
}

SerializeControlModuleType :: proc(controlmoduletype: ControlModuleType) -> (xml: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetControlModuleTypeName :: proc(controlmoduletype: ControlModuleType) -> (name: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeName :: proc(controlmoduletype: ControlModuleType, name: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeProtected :: proc(controlmoduletype: ControlModuleType) -> (protected: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ProtectedGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeProtected :: proc(controlmoduletype: ControlModuleType, protected: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ProtectedPut(ToVariantBool(protected))
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeHidden :: proc(controlmoduletype: ControlModuleType) -> (hidden: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->HiddenGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeHidden :: proc(controlmoduletype: ControlModuleType, hidden: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->HiddenPut(ToVariantBool(hidden))
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeScope :: proc(controlmoduletype: ControlModuleType) -> (scope: i32, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    s: i32
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ScopeGet(&s)
    if ComFailed(hr) do return

    return s, true
}

SetControlModuleTypeScope :: proc(controlmoduletype: ControlModuleType, scope: i32) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ScopePut(scope)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeInteractionWindow :: proc(controlmoduletype: ControlModuleType) -> (interaction_window: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InteractionWindowGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeInteractionWindow :: proc(controlmoduletype: ControlModuleType, interaction_window: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(interaction_window)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InteractionWindowPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeAlarmOwner :: proc(controlmoduletype: ControlModuleType) -> (alarm_owner: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->AlarmOwnerGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeAlarmOwner :: proc(controlmoduletype: ControlModuleType, alarm_owner: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->AlarmOwnerPut(ToVariantBool(alarm_owner))
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeGuid :: proc(controlmoduletype: ControlModuleType) -> (guid: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeGuid :: proc(controlmoduletype: ControlModuleType, guid: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeBatchObject :: proc(controlmoduletype: ControlModuleType) -> (batch_object: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->BatchObjectGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeBatchObject :: proc(controlmoduletype: ControlModuleType, batch_object: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(batch_object)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->BatchObjectPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeSILLevel :: proc(controlmoduletype: ControlModuleType) -> (sil_level: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SILLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeSILLevel :: proc(controlmoduletype: ControlModuleType, sil_level: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(sil_level)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SILLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeSimulationMark :: proc(controlmoduletype: ControlModuleType) -> (simulation_mark: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SimulationMarkGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeSimulationMark :: proc(controlmoduletype: ControlModuleType, simulation_mark: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SimulationMarkPut(ToVariantBool(simulation_mark))
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeReservedBy :: proc(controlmoduletype: ControlModuleType) -> (reserved_by_function: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeReservedBy :: proc(controlmoduletype: ControlModuleType, reserved_by_function: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeDescription :: proc(controlmoduletype: ControlModuleType) -> (description: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeDescription :: proc(controlmoduletype: ControlModuleType, description: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeCMGraphics :: proc(controlmoduletype: ControlModuleType) -> (cmgraphics: string, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMTypeGraphicsGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTypeCMGraphics :: proc(controlmoduletype: ControlModuleType, cmgraphics: string) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(cmgraphics)
    defer FreeBstr(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMTypeGraphicsPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeCMParameters :: proc(controlmoduletype: ControlModuleType) -> (cmparameters: CMParameters, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMParametersGet(&p)
    if ComFailed(hr) do return

    return CMParameters(p), true
}

SetControlModuleTypeCMParameters :: proc(controlmoduletype: ControlModuleType, cmparameters: CMParameters) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMParametersPut(cmparameters)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeVariables :: proc(controlmoduletype: ControlModuleType) -> (variables: Variables, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->VariablesGet(&p)
    if ComFailed(hr) do return

    return Variables(p), true
}

SetControlModuleTypeVariables :: proc(controlmoduletype: ControlModuleType, variables: Variables) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->VariablesPut(variables)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeExternalVariables :: proc(controlmoduletype: ControlModuleType) -> (externalvariables: ExternalVariables, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ExternalVariablesGet(&p)
    if ComFailed(hr) do return

    return ExternalVariables(p), true
}

SetControlModuleTypeExternalVariables :: proc(controlmoduletype: ControlModuleType, externalvariables: ExternalVariables) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ExternalVariablesPut(externalvariables)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeFunctionBlocks :: proc(controlmoduletype: ControlModuleType) -> (functionblocks: FunctionBlocks, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->FunctionBlocksGet(&p)
    if ComFailed(hr) do return

    return FunctionBlocks(p), true
}

SetControlModuleTypeFunctionBlocks :: proc(controlmoduletype: ControlModuleType, functionblocks: FunctionBlocks) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->FunctionBlocksPut(functionblocks)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeControlModules :: proc(controlmoduletype: ControlModuleType) -> (controlmodules: ControlModules, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ControlModulesGet(&p)
    if ComFailed(hr) do return

    return ControlModules(p), true
}

SetControlModuleTypeControlModules :: proc(controlmoduletype: ControlModuleType, controlmodules: ControlModules) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ControlModulesPut(controlmodules)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeCodeBlocks :: proc(controlmoduletype: ControlModuleType) -> (codeblocks: CodeBlocks, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CodeBlocksGet(&p)
    if ComFailed(hr) do return

    return CodeBlocks(p), true
}

SetControlModuleTypeCodeBlocks :: proc(controlmoduletype: ControlModuleType, codeblocks: CodeBlocks) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CodeBlocksPut(codeblocks)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeGraphSize :: proc(controlmoduletype: ControlModuleType) -> (graphsize: GraphSize, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GraphSizeGet(&p)
    if ComFailed(hr) do return

    return GraphSize(p), true
}

SetControlModuleTypeGraphSize :: proc(controlmoduletype: ControlModuleType, graphsize: GraphSize) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GraphSizePut(graphsize)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeAspectObject :: proc(controlmoduletype: ControlModuleType) -> (instantiate_as_aspect_object: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InstantiateAsAspectObjectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeAspectObject :: proc(controlmoduletype: ControlModuleType, instantiate_as_aspect_object: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InstantiateAsAspectObjectPut(ToVariantBool(instantiate_as_aspect_object))
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeGraphicsVisible :: proc(controlmoduletype: ControlModuleType) -> (embedded_graphiscs_visible: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->EmbeddedGraphicsVisibleGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeGraphicsVisible :: proc(controlmoduletype: ControlModuleType, embedded_graphiscs_visible: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->EmbeddedGraphicsVisiblePut(ToVariantBool(embedded_graphiscs_visible))
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypeRestrictedSIL :: proc(controlmoduletype: ControlModuleType) -> (restricted_sil: bool, ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->RestrictedSILGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleTypeRestrictedSIL :: proc(controlmoduletype: ControlModuleType, restricted_sil: bool) -> (ok: bool)
{
    if controlmoduletype == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->RestrictedSILPut(ToVariantBool(restricted_sil))
    if ComFailed(hr) do return

    return true
}

ReleaseControlModuleType :: proc(controlmoduletype: ControlModuleType) {
    if controlmoduletype != nil {
        (^ControlModuleTypeIF)(controlmoduletype)->Release()
    }
}

IControlModuleIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IControlModuleVTable,
}

IControlModuleVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^IControlModuleIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^IControlModuleIF, Name: BStr) -> HResult,
    IsControlModule:       proc "system" (this: ^IControlModuleIF, Is: ^VariantBool) -> HResult,
    IsSingleControlModule: proc "system" (this: ^IControlModuleIF, Is: ^VariantBool) -> HResult,
}

GetIControlModuleName :: proc(icontrolmodule: IControlModule) -> (name: string, ok: bool)
{
    if icontrolmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^IControlModuleIF)(icontrolmodule)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetIControlModuleName :: proc(icontrolmodule: IControlModule, name: string) -> (ok: bool)
{
    if icontrolmodule == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^IControlModuleIF)(icontrolmodule)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

IsControlModule :: proc(icontrolmodule: IControlModule) -> (is: bool, ok: bool)
{
    if icontrolmodule == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^IControlModuleIF)(icontrolmodule)->IsControlModule(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsControlModule :: proc(icm: IControlModule) -> (cm: ControlModule, ok: bool)
{
    if icm == nil do return
    IID := IID_ControlModule
    hr := (^IUnknownIF)(icm)->QueryInterface(&IID, cast(^rawptr)&cm)
    if ComFailed(hr) do return
    return cm, true
}

IsSingleControlModule :: proc(icontrolmodule: IControlModule) -> (is: bool, ok: bool)
{
    if icontrolmodule == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^IControlModuleIF)(icontrolmodule)->IsSingleControlModule(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

AsSingleControlModule :: proc(icm: IControlModule) -> (inst: SingleControlModule, ok: bool)
{
    if icm == nil do return
    IID := IID_SingleControlModule
    hr := (^IUnknownIF)(icm)->QueryInterface(&IID, cast(^rawptr)&inst)
    if ComFailed(hr) do return
    return inst, true
}

ReleaseIControlModule :: proc(icm: IControlModule)
{
    if icm != nil {
        (^IControlModuleIF)(icm)->Release()
    }
}

FromIControlModule :: proc(icm: IControlModule) -> (module: Module, ok: bool)
{
    if icm == nil do return

    is_single: bool
    is_single, ok = IsSingleControlModule(icm)
    if !ok do return
    
    if is_single {
        scm, okas := AsSingleControlModule(icm)
        if !okas do return
        return scm, true
    } else {
        cm, okas := AsControlModule(icm)
        if !okas do return
        return cm, true
    }

    return {}, false
}

GetModuleName :: proc(module: Module) -> (name: string, ok: bool)
{
    switch m in module {
        case ControlModule:
            return GetControlModuleName(m)

        case SingleControlModule:
            return GetSingleControlModuleName(m)
    }

    return
}

SetModuleName :: proc(module: Module, name: string) -> (ok: bool)
{
    switch m in module {
        case ControlModule:
            return SetControlModuleName(m, name)

        case SingleControlModule:
            return SetSingleControlModuleName(m, name)
    }

    return
}

ReleaseModule :: proc(module: Module) {
    switch m in module {
        case ControlModule:
            ReleaseControlModule(m)

        case SingleControlModule:
            ReleaseSingleControlModule(m)
    }
}

SerializeModule :: proc(module: Module) -> (xml: string, ok: bool)
{
    switch m in module {
        case ControlModule:
            return SerializeControlModule(m)

        case SingleControlModule:
            return SerializeSingleControlModule(m)
    }

    return
}

ControlModulesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModulesVTable,
}

ControlModulesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Serialize:               proc "system" (this: ^ControlModulesIF, XML: ^BStr) -> HResult,
    Add:                     proc "system" (this: ^ControlModulesIF, IControlModule: rawptr) -> HResult,
    AddBefore:               proc "system" (this: ^ControlModulesIF, IControlModule: rawptr, Index: i32) -> HResult,
    AddControlModule:        proc "system" (this: ^ControlModulesIF, Name, TypeName: BStr, ControlModule: ^rawptr) -> HResult,
    AddControlModule1:       proc "system" (this: ^ControlModulesIF, Name, TypeName, TaskConnection: BStr, VisibilityInGraphics: i32, Guid, Description: BStr, ControlModules: ^rawptr) -> HResult,
    AddSingleControlModule:  proc "system" (this: ^ControlModulesIF, Name: BStr, SingleControlModule: ^rawptr) -> HResult,
    AddSingleControlModule1: proc "system" (this: ^ControlModulesIF, Name, TaskConnection: BStr, VisibilityInGraphics: i32, TypeGuid, InstGuid: BStr, GraphPos: ^GraphPos, SingleControlModule: ^rawptr) -> HResult,
    Find:                    proc "system" (this: ^ControlModulesIF, Name: BStr, IControlModule: ^rawptr) -> HResult,
    FindNr:                  proc "system" (this: ^ControlModulesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:                    proc "system" (this: ^ControlModulesIF, Index: i32, IControlModule: ^rawptr) -> HResult,
    Count:                   proc "system" (this: ^ControlModulesIF, Count: ^i32) -> HResult,
    Remove:                  proc "system" (this: ^ControlModulesIF, Index: i32) -> HResult,
}

SerializeControlModules :: proc(controlmodules: ControlModules) -> (xml: string, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModulesIF)(controlmodules)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

AddControlModule :: proc(controlmodules: ControlModules, name, type_name: string) -> (controlmodule: ControlModule, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := (^ControlModulesIF)(controlmodules)->AddControlModule(bstr_name, bstr_type_name, cast(^rawptr)&controlmodule)
    if ComFailed(hr) do return

    return controlmodule, true
}

AddSingleControlModule :: proc(controlmodules: ControlModules, name: string) -> (singlecontrolmodule: SingleControlModule, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->AddSingleControlModule(bstr_name, cast(^rawptr)&singlecontrolmodule)
    if ComFailed(hr) do return

    return singlecontrolmodule, true
}

GetIControlModuleByName :: proc(controlmodules: ControlModules, name: string) -> (icontrolmodule: IControlModule, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    i: IControlModule
    hr := (^ControlModulesIF)(controlmodules)->Find(bstr_name, cast(^rawptr)&i)
    if ComFailed(hr) do return
    defer Release(i)
    
    return i, true
}

GetControlModule :: proc(controlmodules: ControlModules, name: string) -> (module: Module, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    i: IControlModule
    hr := (^ControlModulesIF)(controlmodules)->Find(bstr_name, cast(^rawptr)&i)
    if ComFailed(hr) do return
    defer Release(i)
    
    return FromIControlModule(i)
}

GetIControlModuleByIndex :: proc(controlmodules: ControlModules, index: i32) -> (icontrolmodule: IControlModule, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    i: IControlModule
    hr := (^ControlModulesIF)(controlmodules)->Item(index + 1, cast(^rawptr)&i)
    if ComFailed(hr) do return
    defer Release(i)
    
    return i, true
}

GetModuleByIndex :: proc(controlmodules: ControlModules, index: i32) -> (module: Module, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    i: IControlModule
    hr := (^ControlModulesIF)(controlmodules)->Item(index + 1, cast(^rawptr)&i)
    if ComFailed(hr) do return
    defer Release(i)
    
    return FromIControlModule(i)
}

ControlModuleIndex :: proc(controlmodules: ControlModules, name: string) -> (index: i32, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

ControlModuleCount :: proc(controlmodules: ControlModules) -> (count: i32, ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveControlModule :: proc {
    _RemoveControlModuleWithName,
    _RemoveControlModuleAtIndex,
}

_RemoveControlModuleWithName :: proc(controlmodules: ControlModules, name: string) -> (ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = ControlModuleIndex(controlmodules, name)
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveControlModuleAtIndex :: proc(controlmodules: ControlModules, index: i32) -> (ok: bool)
{
    if controlmodules == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseControlModules :: proc(controlmodules: ControlModules) {
    if controlmodules != nil {
        (^ControlModulesIF)(controlmodules)->Release()
    }
}

ControlModuleIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModuleVTable,
}

ControlModuleVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                     proc "system" (this: ^ControlModuleIF, name: ^BStr) -> HResult,
    NamePut:                     proc "system" (this: ^ControlModuleIF, name: BStr) -> HResult,
    TypeNameGet:                 proc "system" (this: ^ControlModuleIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:                 proc "system" (this: ^ControlModuleIF, TypeName: BStr) -> HResult,
    TaskConnectionGet:           proc "system" (this: ^ControlModuleIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:           proc "system" (this: ^ControlModuleIF, TaskConnection: BStr) -> HResult,
    VisibilityinGraphicsGet:     proc "system" (this: ^ControlModuleIF, Visibility: ^i32) -> HResult,
    VisibilityinGraphicsPut:     proc "system" (this: ^ControlModuleIF, Visibility: i32) -> HResult,
    GuidGet:                     proc "system" (this: ^ControlModuleIF, Guid: ^BStr) -> HResult,
    GuidPut:                     proc "system" (this: ^ControlModuleIF, Guid: BStr) -> HResult,
    DescriptionGet:              proc "system" (this: ^ControlModuleIF, Description: ^BStr) -> HResult,
    DescriptionPut:              proc "system" (this: ^ControlModuleIF, Description: BStr) -> HResult,
    CMConnectionsGet:            proc "system" (this: ^ControlModuleIF, CMConnections: ^rawptr) -> HResult,
    Missing20:                   proc "system" (this: ^ControlModuleIF) -> HResult,
    CMConnectionsPut:            proc "system" (this: ^ControlModuleIF, CMConnections: rawptr) -> HResult,
    GraphPosGet:                 proc "system" (this: ^ControlModuleIF, GraphPos: ^rawptr) -> HResult,
    Missing23:                   proc "system" (this: ^ControlModuleIF) -> HResult,
    GraphPosPut:                 proc "system" (this: ^ControlModuleIF, GraphPos: rawptr) -> HResult,
    CMInstGraphicsGet:           proc "system" (this: ^ControlModuleIF, CMinstGraphics: ^BStr) -> HResult,
    CMInstGraphicsPut:           proc "system" (this: ^ControlModuleIF, CMinstGraphics: BStr) -> HResult,
    Missing27:                   proc "system" (this: ^ControlModuleIF) -> HResult,
    Missing28:                   proc "system" (this: ^ControlModuleIF) -> HResult,
    Missing29:                   proc "system" (this: ^ControlModuleIF) -> HResult,
    TypeGuidGet:                 proc "system" (this: ^ControlModuleIF, TypeGuid: ^BStr) -> HResult,
    TypePathGet:                 proc "system" (this: ^ControlModuleIF, TypePath: ^BStr) -> HResult,
    Serialize:                   proc "system" (this: ^ControlModuleIF, XML: ^BStr) -> HResult,
    AspectObjectGet:             proc "system" (this: ^ControlModuleIF, AspectObject: ^VariantBool) -> HResult,
    AspectObjectPut:             proc "system" (this: ^ControlModuleIF, AspectObject: VariantBool) -> HResult,
    AccessLevelGet:              proc "system" (this: ^ControlModuleIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:              proc "system" (this: ^ControlModuleIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:               proc "system" (this: ^ControlModuleIF, X: ^BStr) -> HResult,
    SafetyTypePut:               proc "system" (this: ^ControlModuleIF, X: BStr) -> HResult,
    ExposePropertiesinParentGet: proc "system" (this: ^ControlModuleIF, Expose: ^VariantBool) -> HResult,
    ExposePropertiesinParentPut: proc "system" (this: ^ControlModuleIF, Expose: VariantBool) -> HResult,
}

SerializeControlModule :: proc(controlmodule: ControlModule) -> (xml: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetControlModuleName :: proc(controlmodule: ControlModule) -> (name: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleName :: proc(controlmodule: ControlModule, name: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypesName :: proc(controlmodule: ControlModule) -> (type_name: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeNameGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetControlModuleTypesName :: proc(controlmodule: ControlModule, type_name: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetControlModuleTaskConnection :: proc(controlmodule: ControlModule) -> (task_connection: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->TaskConnectionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleTaskConnection :: proc(controlmodule: ControlModule, task_connection: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(task_connection)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->TaskConnectionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleGraphicsVisibility :: proc(controlmodule: ControlModule) -> (visibility_in_graphics: i32, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    vb: i32
    hr := (^ControlModuleIF)(controlmodule)->VisibilityinGraphicsGet(&vb)
    if ComFailed(hr) do return

    return vb, true
}

SetControlModuleGraphicsVisibility :: proc(controlmodule: ControlModule, visibility_in_graphics: i32) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->VisibilityinGraphicsPut(visibility_in_graphics)
    if ComFailed(hr) do return

    return true
}

GetControlModuleGuid :: proc(controlmodule: ControlModule) -> (guid: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleGuid :: proc(controlmodule: ControlModule, guid: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleDescription :: proc(controlmodule: ControlModule) -> (description: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleDescription :: proc(controlmodule: ControlModule, description: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleCMConnections :: proc(controlmodule: ControlModule) -> (cmconnections: CMConnections, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleIF)(controlmodule)->CMConnectionsGet(&p)
    if ComFailed(hr) do return

    return CMConnections(p), true
}

SetControlModuleCMConnections :: proc(controlmodule: ControlModule, cmconnections: CMConnections) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->CMConnectionsPut(cmconnections)
    if ComFailed(hr) do return

    return true
}

GetControlModuleGraphPos :: proc(controlmodule: ControlModule) -> (graphpos: GraphPos, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^ControlModuleIF)(controlmodule)->GraphPosGet(&p)
    if ComFailed(hr) do return

    return GraphPos(p), true
}

SetControlModuleGraphPos :: proc(controlmodule: ControlModule, graphpos: GraphPos) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->GraphPosPut(graphpos)
    if ComFailed(hr) do return

    return true
}

GetControlModuleInstanceGraphics :: proc(controlmodule: ControlModule) -> (instance_graphics: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->CMInstGraphicsGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetControlModuleInstanceGraphics :: proc(controlmodule: ControlModule, instance_graphics: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(instance_graphics)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->CMInstGraphicsPut(bs)
    if ComFailed(hr) do return

    return true
}

GetControlModuleTypesGuid :: proc(controlmodule: ControlModule) -> (type_guid: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeGuidGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetControlModuleTypePath :: proc(controlmodule: ControlModule) -> (type_path: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypePathGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetControlModuleAspectObject :: proc(controlmodule: ControlModule) -> (aspect_object: bool, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->AspectObjectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleAspectObject :: proc(controlmodule: ControlModule, aspect_object: bool) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->AspectObjectPut(ToVariantBool(aspect_object))
    if ComFailed(hr) do return

    return true
}

GetControlModuleAccessLevel :: proc(controlmodule: ControlModule) -> (access_level: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetControlModuleAccessLevel :: proc(controlmodule: ControlModule, access_level: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetControlModuleSafetyType :: proc(controlmodule: ControlModule) -> (safety_type: string, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetControlModuleSafetyType :: proc(controlmodule: ControlModule, safety_type: string) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^ControlModuleIF)(controlmodule)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetControlModuleExposeProperties :: proc(controlmodule: ControlModule) -> (expose_properties_in_parent: bool, ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetControlModuleExposeProperties :: proc(controlmodule: ControlModule, expose_properties_in_parent: bool) -> (ok: bool)
{
    if controlmodule == nil do return
    if !ComConnected() do return
    
    vb := ToVariantBool(expose_properties_in_parent)
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentPut(vb)
    if ComFailed(hr) do return

    return true
}

ReleaseControlModule :: proc(controlmodule: ControlModule) {
    if controlmodule != nil {
        (^ControlModuleIF)(controlmodule)->Release()
    }
}

SingleControlModuleIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SingleControlModuleVTable,
}

SingleControlModuleVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                     proc "system" (this: ^SingleControlModuleIF, name: ^BStr) -> HResult,
    NamePut:                     proc "system" (this: ^SingleControlModuleIF, name: BStr) -> HResult,
    TaskConnectionGet:           proc "system" (this: ^SingleControlModuleIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:           proc "system" (this: ^SingleControlModuleIF, TaskConnection: BStr) -> HResult,
    VisibilityinGraphicsGet:     proc "system" (this: ^SingleControlModuleIF, Visibility: ^i32) -> HResult,
    VisibilityinGraphicsPut:     proc "system" (this: ^SingleControlModuleIF, Visibility: i32) -> HResult,
    TypeGuidGet:                 proc "system" (this: ^SingleControlModuleIF, TypeGuid: ^BStr) -> HResult,
    TypeGuidPut:                 proc "system" (this: ^SingleControlModuleIF, TypeGuid: BStr) -> HResult,
    InstGuidGet:                 proc "system" (this: ^SingleControlModuleIF, InstGuid: ^BStr) -> HResult,
    InstGuidPut:                 proc "system" (this: ^SingleControlModuleIF, InstGuid: BStr) -> HResult,
    DescriptionGet:              proc "system" (this: ^SingleControlModuleIF, Description: ^BStr) -> HResult,
    DescriptionPut:              proc "system" (this: ^SingleControlModuleIF, Description: BStr) -> HResult,
    CMConnectionsGet:            proc "system" (this: ^SingleControlModuleIF, CMConnections: ^rawptr) -> HResult,
    Missing20:                   proc "system" (this: ^SingleControlModuleIF) -> HResult,
    CMConnectionsPut:            proc "system" (this: ^SingleControlModuleIF, CMConnections: rawptr) -> HResult,
    GraphPosGet:                 proc "system" (this: ^SingleControlModuleIF, GraphPos: ^rawptr) -> HResult,
    Missing23:                   proc "system" (this: ^SingleControlModuleIF) -> HResult,
    GraphPosPut:                 proc "system" (this: ^SingleControlModuleIF, GraphPos: rawptr) -> HResult,
    CMInstGraphicsGet:           proc "system" (this: ^SingleControlModuleIF, CMinstGraphics: ^BStr) -> HResult,
    CMInstGraphicsPut:           proc "system" (this: ^SingleControlModuleIF, CMinstGraphics: BStr) -> HResult,
    Missing27:                   proc "system" (this: ^SingleControlModuleIF) -> HResult,
    Missing28:                   proc "system" (this: ^SingleControlModuleIF) -> HResult,
    Missing29:                   proc "system" (this: ^SingleControlModuleIF) -> HResult,
    Serialize:                   proc "system" (this: ^SingleControlModuleIF, XML: ^BStr) -> HResult,
    AccessLevelGet:              proc "system" (this: ^SingleControlModuleIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:              proc "system" (this: ^SingleControlModuleIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:               proc "system" (this: ^SingleControlModuleIF, X: ^BStr) -> HResult,
    SafetyTypePut:               proc "system" (this: ^SingleControlModuleIF, X: BStr) -> HResult,
}

SerializeSingleControlModule :: proc(singlecontrolmodule: SingleControlModule) -> (xml: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetSingleControlModuleName :: proc(singlecontrolmodule: SingleControlModule) -> (name: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSingleControlModuleName :: proc(singlecontrolmodule: SingleControlModule, name: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleTaskConnection :: proc(singlecontrolmodule: SingleControlModule) -> (task_connection: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->TaskConnectionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSingleControlModuleTaskConnection :: proc(singlecontrolmodule: SingleControlModule, task_connection: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(task_connection)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->TaskConnectionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleGraphicsVisibility :: proc(singlecontrolmodule: SingleControlModule) -> (visibility_in_graphics: i32, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    vb: i32
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->VisibilityinGraphicsGet(&vb)
    if ComFailed(hr) do return

    return vb, true
}

SetSingleControlModuleGraphicsVisibility :: proc(singlecontrolmodule: SingleControlModule, visibility_in_graphics: i32) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->VisibilityinGraphicsPut(visibility_in_graphics)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleTypeGuid :: proc(singlecontrolmodule: SingleControlModule) -> (type_guid: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->TypeGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSingleControlModuleTypeGuid :: proc(singlecontrolmodule: SingleControlModule, type_guid: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_guid)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->TypeGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleInstGuid :: proc(singlecontrolmodule: SingleControlModule) -> (inst_guid: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->InstGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSingleControlModuleInstGuid :: proc(singlecontrolmodule: SingleControlModule, inst_guid: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(inst_guid)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->InstGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleDescription :: proc(singlecontrolmodule: SingleControlModule) -> (description: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSingleControlModuleDescription :: proc(singlecontrolmodule: SingleControlModule, description: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleCMConnections :: proc(singlecontrolmodule: SingleControlModule) -> (cmconnections: CMConnections, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->CMConnectionsGet(&p)
    if ComFailed(hr) do return

    return CMConnections(p), true
}

SetSingleControlModuleCMConnections :: proc(singlecontrolmodule: SingleControlModule, cmconnections: CMConnections) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->CMConnectionsPut(cmconnections)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleGraphPos :: proc(singlecontrolmodule: SingleControlModule) -> (graphpos: GraphPos, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    p: rawptr
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->GraphPosGet(&p)
    if ComFailed(hr) do return

    return GraphPos(p), true
}

SetSingleControlModuleGraphPos :: proc(singlecontrolmodule: SingleControlModule, graphpos: GraphPos) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->GraphPosPut(graphpos)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleInstanceGraphics :: proc(singlecontrolmodule: SingleControlModule) -> (instance_graphics: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->CMInstGraphicsGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetSingleControlModuleInstanceGraphics :: proc(singlecontrolmodule: SingleControlModule, instance_graphics: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(instance_graphics)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->CMInstGraphicsPut(bs)
    if ComFailed(hr) do return

    return true
}

GetSingleControlModuleAccessLevel :: proc(singlecontrolmodule: SingleControlModule) -> (access_level: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetSingleControlModuleAccessLevel :: proc(singlecontrolmodule: SingleControlModule, access_level: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetSingleControlModuleSafetyType :: proc(singlecontrolmodule: SingleControlModule) -> (safety_type: string, ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetSingleControlModuleSafetyType :: proc(singlecontrolmodule: SingleControlModule, safety_type: string) -> (ok: bool)
{
    if singlecontrolmodule == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^SingleControlModuleIF)(singlecontrolmodule)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseSingleControlModule :: proc(singlecontrolmodule: SingleControlModule) {
    if singlecontrolmodule != nil {
        (^SingleControlModuleIF)(singlecontrolmodule)->Release()
    }
}

CMConnectionsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMConnectionsVTable,
}

CMConnectionsVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^CMConnectionsIF, CMConnection: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^CMConnectionsIF, CMConnection: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CMConnectionsIF, Name, ActualParameter: BStr, CMConnection: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^CMConnectionsIF, Name, ActualParameter: BStr, GraphicalConnection: VariantBool, CMConnection: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^CMConnectionsIF, Name: BStr, CMConnection: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^CMConnectionsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CMConnectionsIF, Index: i32, CMConnection: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^CMConnectionsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CMConnectionsIF, Index: i32) -> HResult,
}

AddCMConnection :: proc {
    _AddCMConnection,
    _AddCMConnectionAtIndex,
}

_AddCMConnection :: proc(cmconnections: CMConnections, cmconnection: CMConnection) -> (ok: bool)
{
    if cmconnections == nil do return
    if cmconnection == nil do return
    if !ComConnected() do return

    hr := (^CMConnectionsIF)(cmconnections)->Add(cmconnection)
    if ComFailed(hr) do return

    return true
}

_AddCMConnectionAtIndex :: proc(cmconnections: CMConnections, cmconnection: CMConnection, index: i32) -> (ok: bool)
{
    if cmconnections == nil do return
    if cmconnection == nil do return
    if !ComConnected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->AddBefore(cmconnection, index)
    if ComFailed(hr) do return

    return true
}

GetCMConnection :: proc {
    _GetCMConnectionWithName,
    _GetCMConnectionWithIndex,
}

_GetCMConnectionWithName :: proc(cmconnections: CMConnections, name: string) -> (cmconnection: CMConnection, ok: bool)
{
    if cmconnections == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->Find(bstr_name, cast(^rawptr)&cmconnection)
    if ComFailed(hr) do return
    
    return cmconnection, true
}

_GetCMConnectionWithIndex :: proc(cmconnections: CMConnections, index: i32) -> (cmconnection: CMConnection, ok: bool)
{
    if cmconnections == nil do return
    if !ComConnected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Item(index + 1, cast(^rawptr)&cmconnection)
    if ComFailed(hr) do return
    
    return cmconnection, true
}

CMConnectionIndex :: proc(cmconnections: CMConnections, name: string) -> (index: i32, ok: bool)
{
    if cmconnections == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

CMConnectionCount :: proc(cmconnections: CMConnections) -> (count: i32, ok: bool)
{
    if cmconnections == nil do return
    if !ComConnected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveCMConnection :: proc {
    _RemoveCMConnectionWithName,
    _RemoveCMConnectionAtIndex,
}

_RemoveCMConnectionWithName :: proc(cmconnections: CMConnections, name: string) -> (ok: bool)
{
    if cmconnections == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = CMConnectionIndex(cmconnections, name)
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveCMConnectionAtIndex :: proc(cmconnections: CMConnections, index: i32) -> (ok: bool)
{
    if cmconnections == nil do return
    if !ComConnected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseCMConnections :: proc(cmconnections: CMConnections) {
    if cmconnections != nil {
        (^CMConnectionsIF)(cmconnections)->Release()
    }
}

CMConnectionIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMConnectionVTable,
}

CMConnectionVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^CMConnectionIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^CMConnectionIF, Name: BStr) -> HResult,
    ActualParameterGet:     proc "system" (this: ^CMConnectionIF, ActualParameter: ^BStr) -> HResult,
    ActualParameterPut:     proc "system" (this: ^CMConnectionIF, ActualParameter: BStr) -> HResult,
    GraphicalConnectionGet: proc "system" (this: ^CMConnectionIF, GraphicalConnection: ^VariantBool) -> HResult,
    GraphicalConnectionPut: proc "system" (this: ^CMConnectionIF, GraphicalConnection: VariantBool) -> HResult,
    PointsGet:              proc "system" (this: ^CMConnectionIF, Points: ^rawptr) -> HResult,
    PointsPut:              proc "system" (this: ^CMConnectionIF, Points: rawptr) -> HResult,
    Missing14:              proc "system" (this: ^CMConnectionIF) -> HResult,
    Serialize:              proc "system" (this: ^CMConnectionIF, XML: ^BStr) -> HResult,
}

SerializeCMConnection :: proc(cmconnection: CMConnection) -> (xml: string, ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMConnectionIF)(cmconnection)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCMConnectionName :: proc(cmconnection: CMConnection) -> (name: string, ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMConnectionIF)(cmconnection)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetCMConnectionName :: proc(cmconnection: CMConnection, name: string) -> (ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^CMConnectionIF)(cmconnection)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMConnectionActualParameter :: proc(cmconnection: CMConnection) -> (actual_parameter: string, ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetCMConnectionActualParameter :: proc(cmconnection: CMConnection, actual_parameter: string) -> (ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return

    bs := ToBstr(actual_parameter)
    defer FreeBstr(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMConnectionGraphicalConnection :: proc(cmconnection: CMConnection) -> (graphical_connection: bool, ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return
    
    vb: VariantBool
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetCMConnectionGraphicalConnection :: proc(cmconnection: CMConnection, graphical_connection: bool) -> (ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return

    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionPut(ToVariantBool(graphical_connection))
    if ComFailed(hr) do return
    
    return true
}

GetCMConnectionPoints :: proc(cmconnection: CMConnection) -> (points: Points, ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^CMConnectionIF)(cmconnection)->PointsGet(&p)
    if ComFailed(hr) do return

    return Points(p), true
}

SetCMConnectionPoints :: proc(cmconnection: CMConnection, points: Points) -> (ok: bool)
{
    if cmconnection == nil do return
    if !ComConnected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsPut(points)
    if ComFailed(hr) do return
    
    return true
}

ReleaseCMConnection :: proc(cmconnection: CMConnection) {
    if cmconnection != nil {
        (^CMConnectionIF)(cmconnection)->Release()
    }
}

CMParametersIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMParametersVTable,
}

CMParametersVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
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

AddCMParameter :: proc {
    _AddCMParameter,
    _AddCMParameterAtIndex,
}

_AddCMParameter :: proc(cmparameters: CMParameters, cmparameter: CMParameter) -> (ok: bool)
{
    if cmparameters == nil do return
    if cmparameter == nil do return
    if !ComConnected() do return

    hr := (^CMParametersIF)(cmparameters)->Add(cmparameter)
    if ComFailed(hr) do return

    return true
}

_AddCMParameterAtIndex :: proc(cmparameters: CMParameters, cmparameter: CMParameter, index: i32) -> (ok: bool)
{
    if cmparameters == nil do return
    if cmparameter == nil do return
    if !ComConnected() do return
    
    hr := (^CMParametersIF)(cmparameters)->AddBefore(cmparameter, index)
    if ComFailed(hr) do return

    return true
}

GetCMParameter :: proc {
    _GetCMParameterWithName,
    _GetCMParameterWithIndex,
}

_GetCMParameterWithName :: proc(cmparameters: CMParameters, name: string) -> (cmparameter: CMParameter, ok: bool)
{
    if cmparameters == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->Find(bstr_name, cast(^rawptr)&cmparameter)
    if ComFailed(hr) do return
    
    return cmparameter, true
}

_GetCMParameterWithIndex :: proc(cmparameters: CMParameters, index: i32) -> (cmparameter: CMParameter, ok: bool)
{
    if cmparameters == nil do return
    if !ComConnected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Item(index + 1, cast(^rawptr)&cmparameter)
    if ComFailed(hr) do return
    
    return cmparameter, true
}

CMParameterIndex :: proc(cmparameters: CMParameters, name: string) -> (index: i32, ok: bool)
{
    if cmparameters == nil do return
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return
    
    return index - 1, true
}

CMParameterCount :: proc(cmparameters: CMParameters) -> (count: i32, ok: bool)
{
    if cmparameters == nil do return
    if !ComConnected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Count(&count)
    if ComFailed(hr) do return
    
    return count, true
}

RemoveCMParameter :: proc {
    _RemoveCMParameterWithName,
    _RemoveCMParameterAtIndex,
}

_RemoveCMParameterWithName :: proc(cmparameters: CMParameters, name: string) -> (ok: bool)
{
    if cmparameters == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = CMParameterIndex(cmparameters, name)
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

_RemoveCMParameterAtIndex :: proc(cmparameters: CMParameters, index: i32) -> (ok: bool)
{
    if cmparameters == nil do return
    if !ComConnected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index + 1)
    if ComFailed(hr) do return
    
    return true
}

ReleaseCMParameters :: proc(cmparameters: CMParameters) {
    if cmparameters != nil {
        (^CMParametersIF)(cmparameters)->Release()
    }
}

CMParameterIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMParameterVTable,
}

CMParameterVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                proc "system" (this: ^CMParameterIF, Name: ^BStr) -> HResult,
    NamePut:                proc "system" (this: ^CMParameterIF, Name: BStr) -> HResult,
    TypeNameGet:            proc "system" (this: ^CMParameterIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:            proc "system" (this: ^CMParameterIF, TypeName: BStr) -> HResult,
    InitialValueGet:        proc "system" (this: ^CMParameterIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:        proc "system" (this: ^CMParameterIF, InitialValue: BStr) -> HResult,
    DescriptionGet:         proc "system" (this: ^CMParameterIF, Description: ^BStr) -> HResult,
    DescriptionPut:         proc "system" (this: ^CMParameterIF, Description: BStr) -> HResult,
    ReadPermissionGet:      proc "system" (this: ^CMParameterIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:      proc "system" (this: ^CMParameterIF, ReadPermission: BStr) -> HResult,
    WritePermissionGet:     proc "system" (this: ^CMParameterIF, WritePermission: ^BStr) -> HResult,
    WritePermissionPut:     proc "system" (this: ^CMParameterIF, WritePermission: BStr) -> HResult,
    AuthenticationLevelGet: proc "system" (this: ^CMParameterIF, AuthenticationLevel: ^BStr) -> HResult,
    AuthenticationLevelPut: proc "system" (this: ^CMParameterIF, AuthenticationLevel: BStr) -> HResult,
    BatchPropertyGet:       proc "system" (this: ^CMParameterIF, BatchProperty: ^BStr) -> HResult,
    BatchPropertyPut:       proc "system" (this: ^CMParameterIF, BatchProperty: BStr) -> HResult,
    AutoPointGet:           proc "system" (this: ^CMParameterIF, AutoPoint: ^rawptr) -> HResult,
    Missing24:              proc "system" (this: ^CMParameterIF) -> HResult,
    AutoPointPut:           proc "system" (this: ^CMParameterIF, AutoPoint: rawptr) -> HResult,
    GraphNodesGet:          proc "system" (this: ^CMParameterIF, GraphNodes: ^rawptr) -> HResult,
    Missing27:              proc "system" (this: ^CMParameterIF) -> HResult,
    GraphNodesPut:          proc "system" (this: ^CMParameterIF, GraphNodes: rawptr) -> HResult,
    TypeGuid:               proc "system" (this: ^CMParameterIF, TypeGuid: ^BStr) -> HResult,
    TypePath:               proc "system" (this: ^CMParameterIF, TypePath: ^BStr) -> HResult,
    Serialize:              proc "system" (this: ^CMParameterIF, XML: ^BStr) -> HResult,
    AccessLevelGet:         proc "system" (this: ^CMParameterIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:         proc "system" (this: ^CMParameterIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:          proc "system" (this: ^CMParameterIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:          proc "system" (this: ^CMParameterIF, SafetyType: BStr) -> HResult,
    DirectionGet:           proc "system" (this: ^CMParameterIF, Direction: ^BStr) -> HResult,
    DirectionPut:           proc "system" (this: ^CMParameterIF, Direction: BStr) -> HResult,
    FDPortGet:              proc "system" (this: ^CMParameterIF, FDPort: ^BStr) -> HResult,
    FDPortPut:              proc "system" (this: ^CMParameterIF, FDPort: BStr) -> HResult,
}

SerializeCMParameter :: proc(cmparameter: CMParameter) -> (xml: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->Serialize(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCMParameterName :: proc(cmparameter: CMParameter) -> (name: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetCMParameterName :: proc(cmparameter: CMParameter, name: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->NamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterTypeName :: proc(cmparameter: CMParameter) -> (type_name: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetCMParameterTypeName :: proc(cmparameter: CMParameter, type_name: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNamePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterInitialValue :: proc(cmparameter: CMParameter) -> (inital_value: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValueGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterInitialValue :: proc(cmparameter: CMParameter, inital_value: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(inital_value)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValuePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterDescription :: proc(cmparameter: CMParameter) -> (description: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterDescription :: proc(cmparameter: CMParameter, description: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterReadPermission :: proc(cmparameter: CMParameter) -> (read_permission: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterReadPermission :: proc(cmparameter: CMParameter, read_permission: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(read_permission)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterWritePermission :: proc(cmparameter: CMParameter) -> (write_permission: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterWritePermission :: proc(cmparameter: CMParameter, write_permission: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(write_permission)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterAuthenticationLevel :: proc(cmparameter: CMParameter) -> (authentication_level: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterAuthenticationLevel :: proc(cmparameter: CMParameter, authentication_level: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(authentication_level)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterBatchProperty :: proc(cmparameter: CMParameter) -> (batch_property: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->BatchPropertyGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterBatchProperty :: proc(cmparameter: CMParameter, batch_property: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(batch_property)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->BatchPropertyPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterAutoPoint :: proc(cmparameter: CMParameter) -> (auto_point: AutoPoint, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointGet(cast(^rawptr)&auto_point)
    if ComFailed(hr) do return
    
    return auto_point, true
}

SetCMParameterAutoPoint :: proc(cmparameter: CMParameter, auto_point: AutoPoint) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointPut(auto_point)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterGraphNodes :: proc(cmparameter: CMParameter) -> (graph_nodes: GraphNodes, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if ComFailed(hr) do return
    
    return graph_nodes, true
}

SetCMParameterGraphNodes :: proc(cmparameter: CMParameter, graph_nodes: GraphNodes) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesPut(graph_nodes)
    if ComFailed(hr) do return
    
    return true
}

SetComponentTypeGuid :: proc(cmparameter: CMParameter) -> (guid: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeGuid(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCMParameterTypePath :: proc(cmparameter: CMParameter) -> (path: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->TypePath(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

GetCMParameterAccessLevel :: proc(cmparameter: CMParameter) -> (access_level: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterAccessLevel :: proc(cmparameter: CMParameter, access_level: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterSafetyType :: proc(cmparameter: CMParameter) -> (safety_type: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterSafetyType :: proc(cmparameter: CMParameter, safety_type: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypePut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterDirection :: proc(cmparameter: CMParameter) -> (direction: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterDirection :: proc(cmparameter: CMParameter, direction: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(direction)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionPut(bs)
    if ComFailed(hr) do return
    
    return true
}

GetCMParameterFDPort :: proc(cmparameter: CMParameter) -> (fdport: string, ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs: BStr
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortGet(&bs)
    if ComFailed(hr) do return
    
    return FromBstr(bs), true
}

SetCMParameterFDPort :: proc(cmparameter: CMParameter, fdport: string) -> (ok: bool)
{
    if cmparameter == nil do return
    if !ComConnected() do return
    
    bs := ToBstr(fdport)
    defer FreeBstr(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortPut(bs)
    if ComFailed(hr) do return
    
    return true
}

ReleaseCMParameter :: proc(cmparameter: CMParameter) {
    if cmparameter != nil {
        (^CMParameterIF)(cmparameter)->Release()
    }
}
