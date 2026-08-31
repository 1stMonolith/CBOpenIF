package com

DiagramType      :: distinct rawptr
Diagram          :: distinct rawptr
DiagramInstances :: distinct rawptr
DiagramInstance  :: distinct rawptr

DiagramTypeIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramTypeVTable,
}

DiagramTypeVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                      proc "system" (this: ^DiagramTypeIF, Name: ^BStr) -> HResult,
    NamePut:                      proc "system" (this: ^DiagramTypeIF, Name: BStr) -> HResult,
    ProtectedGet:                 proc "system" (this: ^DiagramTypeIF, Protected: ^VariantBool) -> HResult,
    ProtectedPut:                 proc "system" (this: ^DiagramTypeIF, Protected: VariantBool) -> HResult,
    HiddenGet:                    proc "system" (this: ^DiagramTypeIF, Hidden: ^VariantBool) -> HResult,
    HiddenPut:                    proc "system" (this: ^DiagramTypeIF, Hidden: VariantBool) -> HResult,
    ScopeGet:                     proc "system" (this: ^DiagramTypeIF, Scope: ^i32) -> HResult,
    ScopePut:                     proc "system" (this: ^DiagramTypeIF, Scope: i32) -> HResult,
    AlarmOwnerGet:                proc "system" (this: ^DiagramTypeIF, AlarmOwner: ^VariantBool) -> HResult,
    AlarmOwnerPut:                proc "system" (this: ^DiagramTypeIF, AlarmOwner: VariantBool) -> HResult,
    GuidGet:                      proc "system" (this: ^DiagramTypeIF, Guid: ^BStr) -> HResult,
    GuidPut:                      proc "system" (this: ^DiagramTypeIF, Guid: BStr) -> HResult,
    InstantiateAsAspectObjectGet: proc "system" (this: ^DiagramTypeIF, AspectObject: ^VariantBool) -> HResult,
    InstantiateAsAspectObjectPut: proc "system" (this: ^DiagramTypeIF, AspectObject: VariantBool) -> HResult,
    SILLevelGet:                  proc "system" (this: ^DiagramTypeIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:                  proc "system" (this: ^DiagramTypeIF, SILLevel: BStr) -> HResult,
    RestrictedSILGet:             proc "system" (this: ^DiagramTypeIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:             proc "system" (this: ^DiagramTypeIF, RestrictedSIL: VariantBool) -> HResult,
    SimulationMarkGet:            proc "system" (this: ^DiagramTypeIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:            proc "system" (this: ^DiagramTypeIF, SimulationMark: VariantBool) -> HResult,
    ReservedByFunctionGet:        proc "system" (this: ^DiagramTypeIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut:        proc "system" (this: ^DiagramTypeIF, ReservedByFunction: BStr) -> HResult,
    EmbeddedGraphicsVisibleGet:   proc "system" (this: ^DiagramTypeIF, EmbeddedGraphicsVisible: ^VariantBool) -> HResult,
    EmbeddedGraphicsVisiblePut:   proc "system" (this: ^DiagramTypeIF, EmbeddedGraphicsVisible: VariantBool) -> HResult,
    DescriptionGet:               proc "system" (this: ^DiagramTypeIF, Description: ^BStr) -> HResult,
    DescriptionPut:               proc "system" (this: ^DiagramTypeIF, Description: BStr) -> HResult,
    ParametersGet:                proc "system" (this: ^DiagramTypeIF, Parameters: ^rawptr) -> HResult,
    Missing34:                    proc "system" (this: ^DiagramTypeIF) -> HResult,
    ParametersPut:                proc "system" (this: ^DiagramTypeIF, Parameters: rawptr) -> HResult,
    VariablesGet:                 proc "system" (this: ^DiagramTypeIF, Variables: ^rawptr) -> HResult,
    Missing37:                    proc "system" (this: ^DiagramTypeIF) -> HResult,
    VariablesPut:                 proc "system" (this: ^DiagramTypeIF, Variables: rawptr) -> HResult,
    FunctionBlocksGet:            proc "system" (this: ^DiagramTypeIF, FunctionBlocks: ^rawptr) -> HResult,
    Missing40:                    proc "system" (this: ^DiagramTypeIF) -> HResult,
    FunctionBlocksPut:            proc "system" (this: ^DiagramTypeIF, FunctionBlocks: rawptr) -> HResult,
    ControlModulesGet:            proc "system" (this: ^DiagramTypeIF, ControlModules: ^rawptr) -> HResult,
    Missing43:                    proc "system" (this: ^DiagramTypeIF) -> HResult,
    ControlModulesPut:            proc "system" (this: ^DiagramTypeIF, ControlModules: rawptr) -> HResult,
    DiagramInstancesGet:          proc "system" (this: ^DiagramTypeIF, DiagramInstances: ^rawptr) -> HResult,
    Missing46:                    proc "system" (this: ^DiagramTypeIF) -> HResult,
    DiagramInstancesPut:          proc "system" (this: ^DiagramTypeIF, DiagramInstances: rawptr) -> HResult,
    CodeBlocksGet:                proc "system" (this: ^DiagramTypeIF, CodeBlocks: ^rawptr) -> HResult,
    Missing49:                    proc "system" (this: ^DiagramTypeIF) -> HResult,
    CodeBlocksPut:                proc "system" (this: ^DiagramTypeIF, CodeBlocks: rawptr) -> HResult,
    Serialize:                    proc "system" (this: ^DiagramTypeIF, XML: ^BStr) -> HResult,
    BatchObjectGet:               proc "system" (this: ^DiagramTypeIF, BatchObject: ^BStr) -> HResult,
    BatchObjectPut:               proc "system" (this: ^DiagramTypeIF, BatchObject: BStr) -> HResult,
}

SerializeDiagramType :: proc(diagramtype: DiagramType) -> (xml: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetDiagramTypeName :: proc(diagramtype: DiagramType) -> (name: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypeName :: proc(diagramtype: DiagramType, name: string) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeProtected :: proc(diagramtype: DiagramType) -> (protected: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->ProtectedGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeProtected :: proc(diagramtype: DiagramType, protected: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ProtectedPut(ToVariantBool(protected))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeHidden :: proc(diagramtype: DiagramType) -> (hidden: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->HiddenGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeHidden :: proc(diagramtype: DiagramType, hidden: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->HiddenPut(ToVariantBool(hidden))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeScope :: proc(diagramtype: DiagramType) -> (scope: i32, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    s: i32
    hr := (^DiagramTypeIF)(diagramtype)->ScopeGet(&s)
    if ComFailed(hr) do return

    return s, true
}

SetDiagramTypeScope :: proc(diagramtype: DiagramType, scope: i32) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ScopePut(scope)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeAlarmOwner :: proc(diagramtype: DiagramType) -> (alarm_owner: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->AlarmOwnerGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeAlarmOwner :: proc(diagramtype: DiagramType, alarm_owner: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->AlarmOwnerPut(ToVariantBool(alarm_owner))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeAlarmGuid :: proc(diagramtype: DiagramType) -> (guid: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypeAlarmGuid :: proc(diagramtype: DiagramType, guid: string) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeAspectObject :: proc(diagramtype: DiagramType) -> (instantiate: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->InstantiateAsAspectObjectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeAspectObject :: proc(diagramtype: DiagramType, instantiate: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->InstantiateAsAspectObjectPut(ToVariantBool(instantiate))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeSILLevel :: proc(diagramtype: DiagramType) -> (sil_level: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->SILLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypeSILLevel :: proc(diagramtype: DiagramType, sil_level: string) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs := ToBstr(sil_level)
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->SILLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeRestrictedSIL :: proc(diagramtype: DiagramType) -> (restricted_sil: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->RestrictedSILGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeRestrictedSIL :: proc(diagramtype: DiagramType, restricted_sil: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->RestrictedSILPut(ToVariantBool(restricted_sil))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeSimulationMark :: proc(diagramtype: DiagramType) -> (simulation_mark: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->SimulationMarkGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeSimulationMark :: proc(diagramtype: DiagramType, simulation_mark: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->SimulationMarkPut(ToVariantBool(simulation_mark))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeReservedBy :: proc(diagramtype: DiagramType) -> (reserved_by_function: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypeReservedBy :: proc(diagramtype: DiagramType, reserved_by_function: string) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeGraphicsVisible :: proc(diagramtype: DiagramType) -> (visible: bool, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->EmbeddedGraphicsVisibleGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramTypeGraphicsVisible :: proc(diagramtype: DiagramType, visible: bool) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->EmbeddedGraphicsVisiblePut(ToVariantBool(visible))
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeDescription :: proc(diagramtype: DiagramType) -> (description: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypeDescription :: proc(diagramtype: DiagramType, description: string) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeParameters :: proc(diagramtype: DiagramType) -> (parameters: Parameters, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->ParametersGet(&p)
    if ComFailed(hr) do return

    return Parameters(p), true
}

SetDiagramTypeParameters :: proc(diagramtype: DiagramType, parameters: Parameters) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ParametersPut(parameters)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeVariables :: proc(diagramtype: DiagramType) -> (variables: Variables, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->VariablesGet(&p)
    if ComFailed(hr) do return

    return Variables(p), true
}

SetDiagramTypeVariables :: proc(diagramtype: DiagramType, variables: Variables) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->VariablesPut(variables)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeFunctionBlocks :: proc(diagramtype: DiagramType) -> (functionblocks: FunctionBlocks, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->FunctionBlocksGet(&p)
    if ComFailed(hr) do return

    return FunctionBlocks(p), true
}

SetDiagramTypeFunctionBlocks :: proc(diagramtype: DiagramType, functionblocks: FunctionBlocks) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->FunctionBlocksPut(functionblocks)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeControlModules :: proc(diagramtype: DiagramType) -> (controlmodules: ControlModules, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->ControlModulesGet(&p)
    if ComFailed(hr) do return

    return ControlModules(p), true
}

SetDiagramTypeControlModules :: proc(diagramtype: DiagramType, controlmodules: ControlModules) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ControlModulesPut(controlmodules)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeDiagramInstances :: proc(diagramtype: DiagramType) -> (diagraminstances: DiagramInstances, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->DiagramInstancesGet(&p)
    if ComFailed(hr) do return

    return DiagramInstances(p), true
}

SetDiagramTypeDiagramInstances :: proc(diagramtype: DiagramType, diagraminstances: DiagramInstances) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->DiagramInstancesPut(diagraminstances)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeCodeBlocks :: proc(diagramtype: DiagramType) -> (codeblocks: CodeBlocks, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->CodeBlocksGet(&p)
    if ComFailed(hr) do return

    return CodeBlocks(p), true
}

SetDiagramTypeCodeBlocks :: proc(diagramtype: DiagramType, codeblocks: CodeBlocks) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    hr := (^DiagramTypeIF)(diagramtype)->CodeBlocksPut(codeblocks)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypeBatchObject :: proc(diagramtype: DiagramType) -> (batch_object: string, ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->BatchObjectGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypeBatchObject :: proc(diagramtype: DiagramType, batch_object: string) -> (ok: bool)
{
    if diagramtype == nil do return
    if !ComConnected() do return

    bs := ToBstr(batch_object)
    defer FreeBstr(bs)
    hr := (^DiagramTypeIF)(diagramtype)->BatchObjectPut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseDiagramType :: proc(diagramtype: DiagramType)
{
    if diagramtype != nil {
        (^DiagramTypeIF)(diagramtype)->Release()
    }
}

DiagramIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramVTable,
}

DiagramVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^DiagramIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^DiagramIF, Name: BStr) -> HResult,
    TaskConnectionGet:     proc "system" (this: ^DiagramIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:     proc "system" (this: ^DiagramIF, TaskConnection: BStr) -> HResult,
    TypeGuidGet:           proc "system" (this: ^DiagramIF, TypeGuid: ^BStr) -> HResult,
    TypeGuidPut:           proc "system" (this: ^DiagramIF, TypeGuid: BStr) -> HResult,
    InstGuidGet:           proc "system" (this: ^DiagramIF, InstGuid: ^BStr) -> HResult,
    InstGuidPut:           proc "system" (this: ^DiagramIF, InstGuid: BStr) -> HResult,
    DescriptionGet:        proc "system" (this: ^DiagramIF, Description: ^BStr) -> HResult,
    DescriptionPut:        proc "system" (this: ^DiagramIF, Description: BStr) -> HResult,
    SILLevelGet:           proc "system" (this: ^DiagramIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:           proc "system" (this: ^DiagramIF, SILLevel: BStr) -> HResult,
    RestrictedSILGet:      proc "system" (this: ^DiagramIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:      proc "system" (this: ^DiagramIF, RestrictedSIL: VariantBool) -> HResult,
    SimulationMarkGet:     proc "system" (this: ^DiagramIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:     proc "system" (this: ^DiagramIF, SimulationMark: VariantBool) -> HResult,
    ReservedByFunctionGet: proc "system" (this: ^DiagramIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut: proc "system" (this: ^DiagramIF, ReservedByFunction: BStr) -> HResult,
    AccessLevelGet:        proc "system" (this: ^DiagramIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:        proc "system" (this: ^DiagramIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:         proc "system" (this: ^DiagramIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:         proc "system" (this: ^DiagramIF, SafetyType: BStr) -> HResult,
    VariablesGet:          proc "system" (this: ^DiagramIF, Variables: ^rawptr) -> HResult,
    Missing30:             proc "system" (this: ^DiagramIF) -> HResult,
    VariablesPut:          proc "system" (this: ^DiagramIF, Variables: rawptr) -> HResult,
    CommVariablesGet:      proc "system" (this: ^DiagramIF, CommVariables: ^rawptr) -> HResult,
    Missing33:             proc "system" (this: ^DiagramIF) -> HResult,
    CommVariablesPut:      proc "system" (this: ^DiagramIF, CommVariables: rawptr) -> HResult,
    FunctionBlocksGet:     proc "system" (this: ^DiagramIF, FunctionBlocks: ^rawptr) -> HResult,
    Missing36:             proc "system" (this: ^DiagramIF) -> HResult,
    FunctionBlocksPut:     proc "system" (this: ^DiagramIF, FunctionBlocks: rawptr) -> HResult,
    ControlModulesGet:     proc "system" (this: ^DiagramIF, ControlModules: ^rawptr) -> HResult,
    Missing39:             proc "system" (this: ^DiagramIF) -> HResult,
    ControlModulesPut:     proc "system" (this: ^DiagramIF, ControlModules: rawptr) -> HResult,
    InitValuesGet:         proc "system" (this: ^DiagramIF, InitValues: ^rawptr) -> HResult,
    Missing42:             proc "system" (this: ^DiagramIF) -> HResult,
    InitValuesPut:         proc "system" (this: ^DiagramIF, InitValues: rawptr) -> HResult,
    CodeBlocksGet:         proc "system" (this: ^DiagramIF, CodeBlocks: ^rawptr) -> HResult,
    Missing45:             proc "system" (this: ^DiagramIF) -> HResult,
    CodeBlocksPut:         proc "system" (this: ^DiagramIF, CodeBlocks: rawptr) -> HResult,
    Serialize:             proc "system" (this: ^DiagramIF, XML: ^BStr) -> HResult,
    DiagramInstancesGet:   proc "system" (this: ^DiagramIF, DiagramInstances: ^rawptr) -> HResult,
    Missing49:             proc "system" (this: ^DiagramIF) -> HResult,
    DiagramInstancesPut:   proc "system" (this: ^DiagramIF, DiagramInstances: rawptr) -> HResult,
    SignalsGet:            proc "system" (this: ^DiagramIF, Signals: ^rawptr) -> HResult,
    Missing52:             proc "system" (this: ^DiagramIF) -> HResult,
    SignalsPut:            proc "system" (this: ^DiagramIF, Signals: rawptr) -> HResult,
    BatchObjectGet:        proc "system" (this: ^DiagramIF, BatchObject: ^BStr) -> HResult,
    BatchObjectPut:        proc "system" (this: ^DiagramIF, BatchObject: BStr) -> HResult,
}

SerializeDiagram :: proc(diagram: Diagram) -> (xml: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetDiagramName :: proc(diagram: Diagram) -> (name: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramName :: proc(diagram: Diagram, name: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTaskConnection :: proc(diagram: Diagram) -> (task_connection: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->TaskConnectionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTaskConnection :: proc(diagram: Diagram, task_connection: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(task_connection)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->TaskConnectionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramTypesGuid :: proc(diagram: Diagram) -> (type_guid: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->TypeGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramTypesGuid :: proc(diagram: Diagram, type_guid: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_guid)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->TypeGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstGuid :: proc(diagram: Diagram) -> (inst_guid: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->InstGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstGuid :: proc(diagram: Diagram, inst_guid: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(inst_guid)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->InstGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramDescription :: proc(diagram: Diagram) -> (description: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramDescription :: proc(diagram: Diagram, description: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramSILLevel :: proc(diagram: Diagram) -> (sil_level: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->SILLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramSILLevel :: proc(diagram: Diagram, sil_level: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(sil_level)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->SILLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramRestrictedSIL :: proc(diagram: Diagram) -> (restricted_sil: bool, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramIF)(diagram)->RestrictedSILGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramRestrictedSIL :: proc(diagram: Diagram, restricted_sil: bool) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->RestrictedSILPut(ToVariantBool(restricted_sil))
    if ComFailed(hr) do return

    return true
}

GetDiagramSimulationMark :: proc(diagram: Diagram) -> (simulation_mark: bool, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramIF)(diagram)->SimulationMarkGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramSimulationMark :: proc(diagram: Diagram, simulation_mark: bool) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->SimulationMarkPut(ToVariantBool(simulation_mark))
    if ComFailed(hr) do return

    return true
}

GetDiagramReservedBy :: proc(diagram: Diagram) -> (reserved_by_function: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramReservedBy :: proc(diagram: Diagram, reserved_by_function: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramAccessLevel :: proc(diagram: Diagram) -> (access_level: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->AccessLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramAccessLevel :: proc(diagram: Diagram, access_level: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->AccessLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramSafetyType :: proc(diagram: Diagram) -> (safety_type: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramSafetyType :: proc(diagram: Diagram, safety_type: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->SafetyTypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramVariables :: proc(diagram: Diagram) -> (variables: Variables, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->VariablesGet(&p)
    if ComFailed(hr) do return

    return Variables(p), true
}

SetDiagramVariables :: proc(diagram: Diagram, variables: Variables) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->VariablesPut(variables)
    if ComFailed(hr) do return

    return true
}

GetDiagramCommVariables :: proc(diagram: Diagram) -> (commvariables: CommVariables, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->CommVariablesGet(&p)
    if ComFailed(hr) do return

    return CommVariables(p), true
}

SetDiagramCommVariables :: proc(diagram: Diagram, commvariables: CommVariables) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->CommVariablesPut(commvariables)
    if ComFailed(hr) do return

    return true
}

GetDiagramFunctionBlocks :: proc(diagram: Diagram) -> (functionblocks: FunctionBlocks, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->FunctionBlocksGet(&p)
    if ComFailed(hr) do return

    return FunctionBlocks(p), true
}

SetDiagramFunctionBlocks :: proc(diagram: Diagram, functionblocks: FunctionBlocks) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->FunctionBlocksPut(functionblocks)
    if ComFailed(hr) do return

    return true
}

GetDiagramControlModules :: proc(diagram: Diagram) -> (controlmodules: ControlModules, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->ControlModulesGet(&p)
    if ComFailed(hr) do return

    return ControlModules(p), true
}

SetDiagramControlModules :: proc(diagram: Diagram, controlmodules: ControlModules) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->ControlModulesPut(controlmodules)
    if ComFailed(hr) do return

    return true
}

GetDiagramInitValues :: proc(diagram: Diagram) -> (initvalues: InitValues, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->InitValuesGet(&p)
    if ComFailed(hr) do return

    return InitValues(p), true
}

SetDiagramInitValues :: proc(diagram: Diagram, initvalues: InitValues) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->InitValuesPut(initvalues)
    if ComFailed(hr) do return

    return true
}

GetDiagramCodeBlocks :: proc(diagram: Diagram) -> (codeblocks: CodeBlocks, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->CodeBlocksGet(&p)
    if ComFailed(hr) do return

    return CodeBlocks(p), true
}

SetDiagramCodeBlocks :: proc(diagram: Diagram, codeblocks: CodeBlocks) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->CodeBlocksPut(codeblocks)
    if ComFailed(hr) do return

    return true
}

GetDiagramDiagramInstances :: proc(diagram: Diagram) -> (diagraminstances: DiagramInstances, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->DiagramInstancesGet(&p)
    if ComFailed(hr) do return

    return DiagramInstances(p), true
}

SetDiagramDiagramInstances :: proc(diagram: Diagram, diagraminstances: DiagramInstances) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->DiagramInstancesPut(diagraminstances)
    if ComFailed(hr) do return

    return true
}

GetDiagramSignals :: proc(diagram: Diagram) -> (signals: Signals, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->SignalsGet(&p)
    if ComFailed(hr) do return

    return Signals(p), true
}

SetDiagramSignals :: proc(diagram: Diagram, signals: Signals) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    hr := (^DiagramIF)(diagram)->SignalsPut(signals)
    if ComFailed(hr) do return

    return true
}

GetDiagramBatchObject :: proc(diagram: Diagram) -> (batch_object: string, ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->BatchObjectGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramBatchObject :: proc(diagram: Diagram, batch_object: string) -> (ok: bool)
{
    if diagram == nil do return
    if !ComConnected() do return

    bs := ToBstr(batch_object)
    defer FreeBstr(bs)
    hr := (^DiagramIF)(diagram)->BatchObjectPut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseDiagram :: proc(diagram: Diagram)
{
    if diagram != nil {
        (^DiagramIF)(diagram)->Release()
    }
}

DiagramInstancesIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramInstancesVTable,
}

DiagramInstancesVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^DiagramInstancesIF, DiagramInstance: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^DiagramInstancesIF, DiagramInstance: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^DiagramInstancesIF, Name, TypeName: BStr, DiagramInstance: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^DiagramInstancesIF, Name, TypeName, Guid, Description: BStr, DiagramInstance: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^DiagramInstancesIF, Name: BStr, DiagramInstance: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^DiagramInstancesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^DiagramInstancesIF, Index: i32, DiagramInstance: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^DiagramInstancesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^DiagramInstancesIF, Index: i32) -> HResult,
}

AddDiagramInstance :: proc {
    _AddDiagramInstance,
    _AddDiagramInstanceAtIndex,
}

_AddDiagramInstance :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance) -> (ok: bool)
{
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Add(diagraminstance)
    if ComFailed(hr) do return

    return true
}

_AddDiagramInstanceAtIndex :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance, index: i32) -> (ok: bool)
{
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->AddBefore(diagraminstance, index)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstance :: proc {
    _GetDiagramInstanceWithName,
    _GetDiagramInstanceAtIndex,
}

_GetDiagramInstanceWithName :: proc(diagraminstances: DiagramInstances, name: string) -> (diagraminstance: DiagramInstance, ok: bool)
{
    if diagraminstances == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->Find(bstr_name, cast(^rawptr)&diagraminstance)
    if ComFailed(hr) do return

    return diagraminstance, true
}

_GetDiagramInstanceAtIndex :: proc(diagraminstances: DiagramInstances, index: i32) -> (diagraminstance: DiagramInstance, ok: bool)
{
    if diagraminstances == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Item(index + 1, cast(^rawptr)&diagraminstance)
    if ComFailed(hr) do return

    return diagraminstance, true
}

DiagramInstanceIndex :: proc(diagraminstances: DiagramInstances, name: string) -> (index: i32, ok: bool)
{
    if diagraminstances == nil do return
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->FindNr(bstr_name, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

DiagramInstanceCount :: proc(diagraminstances: DiagramInstances) -> (count: i32, ok: bool)
{
    if diagraminstances == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveDiagramInstance :: proc {
    _RemoveDiagramInstanceWithName,
    _RemoveDiagramInstanceAtIndex,
}

_RemoveDiagramInstanceWithName :: proc(diagraminstances: DiagramInstances, name: string) -> (ok: bool)
{
    if diagraminstances == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = DiagramInstanceIndex(diagraminstances, name)
    if !ok do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveDiagramInstanceAtIndex :: proc(diagraminstances: DiagramInstances, index: i32) -> (ok: bool)
{
    if diagraminstances == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseDiagramInstances :: proc(diagraminstances: DiagramInstances)
{
    if diagraminstances != nil {
        (^DiagramInstancesIF)(diagraminstances)->Release()
    }
}

DiagramInstanceIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramInstanceVTable,
}

DiagramInstanceVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NameGet:                      proc "system" (this: ^DiagramInstanceIF, Name: ^BStr) -> HResult,
    NamePut:                      proc "system" (this: ^DiagramInstanceIF, Name: BStr) -> HResult,
    TypeNameGet:                  proc "system" (this: ^DiagramInstanceIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:                  proc "system" (this: ^DiagramInstanceIF, TypeName: BStr) -> HResult,
    GuidGet:                      proc "system" (this: ^DiagramInstanceIF, Guid: ^BStr) -> HResult,
    GuidPut:                      proc "system" (this: ^DiagramInstanceIF, Guid: BStr) -> HResult,
    DescriptionGet:               proc "system" (this: ^DiagramInstanceIF, Description: ^BStr) -> HResult,
    DescriptionPut:               proc "system" (this: ^DiagramInstanceIF, Description: BStr) -> HResult,
    AspectObjectGet:              proc "system" (this: ^DiagramInstanceIF, AspectObject: ^VariantBool) -> HResult,
    AspectObjectPut:              proc "system" (this: ^DiagramInstanceIF, AspectObject: VariantBool) -> HResult,
    ExposePropertiesInParentGet:  proc "system" (this: ^DiagramInstanceIF, ExposePropertiesInParent: ^VariantBool) -> HResult,
    ExposePropertiesInParentPut:  proc "system" (this: ^DiagramInstanceIF, ExposePropertiesInParent: VariantBool) -> HResult,
    AccessLevelGet:               proc "system" (this: ^DiagramInstanceIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:               proc "system" (this: ^DiagramInstanceIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:                proc "system" (this: ^DiagramInstanceIF, SafetyType: ^BStr) -> HResult,
    SafetyTypePut:                proc "system" (this: ^DiagramInstanceIF, SafetyType: BStr) -> HResult,
    TypeGuidGet:                  proc "system" (this: ^DiagramInstanceIF, TypeGuid: ^BStr) -> HResult,
    TypePathGet:                  proc "system" (this: ^DiagramInstanceIF, TypePath: ^BStr) -> HResult,
    Serialize:                    proc "system" (this: ^DiagramInstanceIF, XML: ^BStr) -> HResult,
}

SerializeDiagramInstance :: proc(diagraminstance: DiagramInstance) -> (xml: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetDiagramInstanceName :: proc(diagraminstance: DiagramInstance) -> (name: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstanceName :: proc(diagraminstance: DiagramInstance, name: string) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceTypeName :: proc(diagraminstance: DiagramInstance) -> (type_name: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstanceTypeName :: proc(diagraminstance: DiagramInstance, type_name: string) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_name)
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceGuid :: proc(diagraminstance: DiagramInstance) -> (guid: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstanceGuid :: proc(diagraminstance: DiagramInstance, guid: string) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceDescription :: proc(diagraminstance: DiagramInstance) -> (description: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstanceDescription :: proc(diagraminstance: DiagramInstance, description: string) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs := ToBstr(description)
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceAspectObject :: proc(diagraminstance: DiagramInstance) -> (aspect_object: bool, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramInstanceAspectObject :: proc(diagraminstance: DiagramInstance, aspect_object: bool) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectPut(ToVariantBool(aspect_object))
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceExposeProperties :: proc(diagraminstance: DiagramInstance) -> (expose: bool, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetDiagramInstanceExposeProperties :: proc(diagraminstance: DiagramInstance, expose: bool) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentPut(ToVariantBool(expose))
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceAccessLevel :: proc(diagraminstance: DiagramInstance) -> (access_level: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstanceAccessLevel :: proc(diagraminstance: DiagramInstance, access_level: string) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs := ToBstr(access_level)
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelPut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceSafetyType :: proc(diagraminstance: DiagramInstance) -> (safety_type: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetDiagramInstanceSafetyType :: proc(diagraminstance: DiagramInstance, safety_type: string) -> (ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs := ToBstr(safety_type)
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypePut(bs)
    if ComFailed(hr) do return

    return true
}

GetDiagramInstanceTypeGuid :: proc(diagraminstance: DiagramInstance) -> (type_guid: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetDiagramInstanceTypePath :: proc(diagraminstance: DiagramInstance) -> (type_path: string, ok: bool)
{
    if diagraminstance == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypePathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

ReleaseDiagramInstance :: proc(diagraminstance: DiagramInstance)
{
    if diagraminstance != nil {
        (^DiagramInstanceIF)(diagraminstance)->Release()
    }
}
