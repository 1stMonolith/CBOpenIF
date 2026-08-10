package cbopenif

Diagram          :: distinct rawptr
DiagramInstance  :: distinct rawptr
DiagramInstances :: distinct rawptr
DiagramType      :: distinct rawptr

DiagramIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramVTable,
}

DiagramVTable :: struct {
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

diagram_new :: proc(name: string, description := "") -> (diagram: Diagram, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewDiagram(bstr_name, bstr_description, cast(^rawptr)&diagram)
    if com_failed(hr) do return

    return diagram, true
}

diagram_deserialize :: proc(xml: string) -> (diagram: Diagram, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeDiagram(&bs, cast(^rawptr)&diagram)
    if com_failed(hr) do return

    return diagram, true
}

diagram_serialize :: proc(diagram: Diagram) -> (xml: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_name :: proc {
    diagram_name_get,
    diagram_name_set,
}

diagram_name_get :: proc(diagram: Diagram) -> (name: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_name_set :: proc(diagram: Diagram, name: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagram_task_connection :: proc {
    diagram_task_connection_get,
    diagram_task_connection_set,
}

diagram_task_connection_get :: proc(diagram: Diagram) -> (task_connection: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_task_connection_set :: proc(diagram: Diagram, task_connection: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_type_guid :: proc {
    diagram_type_guid_get,
    diagram_type_guid_set,
}

diagram_type_guid_get :: proc(diagram: Diagram) -> (type_guid: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_type_guid_set :: proc(diagram: Diagram, type_guid: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_inst_guid :: proc {
    diagram_inst_guid_get,
    diagram_inst_guid_set,
}

diagram_inst_guid_get :: proc(diagram: Diagram) -> (inst_guid: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->InstGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_inst_guid_set :: proc(diagram: Diagram, inst_guid: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(inst_guid)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->InstGuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_description :: proc {
    diagram_description_get,
    diagram_description_set,
}

diagram_description_get :: proc(diagram: Diagram) -> (description: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_description_set :: proc(diagram: Diagram, description: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_sil_level :: proc {
    diagram_sil_level_get,
    diagram_sil_level_set,
}

diagram_sil_level_get :: proc(diagram: Diagram) -> (sil_level: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_sil_level_set :: proc(diagram: Diagram, sil_level: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_restricted_sil :: proc {
    diagram_restricted_sil_get,
    diagram_restricted_sil_set,
}

diagram_restricted_sil_get :: proc(diagram: Diagram) -> (restricted_sil: bool, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramIF)(diagram)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagram_restricted_sil_set :: proc(diagram: Diagram, restricted_sil: bool) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

diagram_simulation_mark :: proc {
    diagram_simulation_mark_get,
    diagram_simulation_mark_set,
}

diagram_simulation_mark_get :: proc(diagram: Diagram) -> (simulation_mark: bool, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramIF)(diagram)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagram_simulation_mark_set :: proc(diagram: Diagram, simulation_mark: bool) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

diagram_reserved_by_function :: proc {
    diagram_reserved_by_function_get,
    diagram_reserved_by_function_set,
}

diagram_reserved_by_function_get :: proc(diagram: Diagram) -> (reserved_by_function: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_reserved_by_function_set :: proc(diagram: Diagram, reserved_by_function: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_access_level :: proc {
    diagram_access_level_get,
    diagram_access_level_set,
}

diagram_access_level_get :: proc(diagram: Diagram) -> (access_level: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_access_level_set :: proc(diagram: Diagram, access_level: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_safety_type :: proc {
    diagram_safety_type_get,
    diagram_safety_type_set,
}

diagram_safety_type_get :: proc(diagram: Diagram) -> (safety_type: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_safety_type_set :: proc(diagram: Diagram, safety_type: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

diagram_variables :: proc {
    diagram_variables_get,
    diagram_variables_set,
}

diagram_variables_get :: proc(diagram: Diagram) -> (variables: Variables, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

diagram_variables_set :: proc(diagram: Diagram, variables: Variables) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

diagram_commvariables :: proc {
    diagram_commvariables_get,
    diagram_commvariables_set,
}

diagram_commvariables_get :: proc(diagram: Diagram) -> (commvariables: CommVariables, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->CommVariablesGet(&p)
    if com_failed(hr) do return

    return CommVariables(p), true
}

diagram_commvariables_set :: proc(diagram: Diagram, commvariables: CommVariables) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->CommVariablesPut(commvariables)
    if com_failed(hr) do return

    return true
}

diagram_functionblocks :: proc {
    diagram_functionblocks_get,
    diagram_functionblocks_set,
}

diagram_functionblocks_get :: proc(diagram: Diagram) -> (functionblocks: FunctionBlocks, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

diagram_functionblocks_set :: proc(diagram: Diagram, functionblocks: FunctionBlocks) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

diagram_controlmodules :: proc {
    diagram_controlmodules_get,
    diagram_controlmodules_set,
}

diagram_controlmodules_get :: proc(diagram: Diagram) -> (controlmodules: ControlModules, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

diagram_controlmodules_set :: proc(diagram: Diagram, controlmodules: ControlModules) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

diagram_initvalues :: proc {
    diagram_initvalues_get,
    diagram_initvalues_set,
}

diagram_initvalues_get :: proc(diagram: Diagram) -> (initvalues: InitValues, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->InitValuesGet(&p)
    if com_failed(hr) do return

    return InitValues(p), true
}

diagram_initvalues_set :: proc(diagram: Diagram, initvalues: InitValues) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->InitValuesPut(initvalues)
    if com_failed(hr) do return

    return true
}

diagram_codeblocks :: proc {
    diagram_codeblocks_get,
    diagram_codeblocks_set,
}

diagram_codeblocks_get :: proc(diagram: Diagram) -> (codeblocks: CodeBlocks, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

diagram_codeblocks_set :: proc(diagram: Diagram, codeblocks: CodeBlocks) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

diagram_diagraminstances :: proc {
    diagram_diagraminstances_get,
    diagram_diagraminstances_set,
}

diagram_diagraminstances_get :: proc(diagram: Diagram) -> (diagraminstances: DiagramInstances, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->DiagramInstancesGet(&p)
    if com_failed(hr) do return

    return DiagramInstances(p), true
}

diagram_diagraminstances_set :: proc(diagram: Diagram, diagraminstances: DiagramInstances) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->DiagramInstancesPut(diagraminstances)
    if com_failed(hr) do return

    return true
}

diagram_signals :: proc {
    diagram_signals_get,
    diagram_signals_set,
}

diagram_signals_get :: proc(diagram: Diagram) -> (signals: Signals, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->SignalsGet(&p)
    if com_failed(hr) do return

    return Signals(p), true
}

diagram_signals_set :: proc(diagram: Diagram, signals: Signals) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramIF)(diagram)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

diagram_batch_object :: proc {
    diagram_batch_object_get,
    diagram_batch_object_set,
}

diagram_batch_object_get :: proc(diagram: Diagram) -> (batch_object: string, ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_batch_object_set :: proc(diagram: Diagram, batch_object: string) -> (ok: bool) {
    if diagram == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(batch_object)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->BatchObjectPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_release :: proc(diagram: Diagram) {
    if diagram != nil {
        (^DiagramIF)(diagram)->Release()
    }
}

DiagramInstanceIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramInstanceVTable,
}

DiagramInstanceVTable :: struct {
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

diagraminstance_new :: proc(name, type_name: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_type := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
    }
    hr := factoryif->NewDiagramInstance(bstr_name, bstr_type, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstance_deserialize :: proc(xml: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeDiagramInstance(&bs, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstance_serialize :: proc(diagraminstance: DiagramInstance) -> (xml: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_name :: proc {
    diagraminstance_name_get,
    diagraminstance_name_set,
}

diagraminstance_name_get :: proc(diagraminstance: DiagramInstance) -> (name: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_name_set :: proc(diagraminstance: DiagramInstance, name: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_type_name :: proc {
    diagraminstance_type_name_get,
    diagraminstance_type_name_set,
}

diagraminstance_type_name_get :: proc(diagraminstance: DiagramInstance) -> (type_name: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_type_name_set :: proc(diagraminstance: DiagramInstance, type_name: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNamePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_guid :: proc {
    diagraminstance_guid_get,
    diagraminstance_guid_set,
}

diagraminstance_guid_get :: proc(diagraminstance: DiagramInstance) -> (guid: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_guid_set :: proc(diagraminstance: DiagramInstance, guid: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_description :: proc {
    diagraminstance_description_get,
    diagraminstance_description_set,
}

diagraminstance_description_get :: proc(diagraminstance: DiagramInstance) -> (description: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_description_set :: proc(diagraminstance: DiagramInstance, description: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_aspect_object :: proc {
    diagraminstance_aspect_object_get,
    diagraminstance_aspect_object_set,
}

diagraminstance_aspect_object_get :: proc(diagraminstance: DiagramInstance) -> (aspect_object: bool, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagraminstance_aspect_object_set :: proc(diagraminstance: DiagramInstance, aspect_object: bool) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

diagraminstance_expose_properties_in_parent :: proc {
    diagraminstance_expose_properties_in_parent_get,
    diagraminstance_expose_properties_in_parent_set,
}

diagraminstance_expose_properties_in_parent_get :: proc(diagraminstance: DiagramInstance) -> (expose: bool, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagraminstance_expose_properties_in_parent_set :: proc(diagraminstance: DiagramInstance, expose: bool) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentPut(to_variantbool(expose))
    if com_failed(hr) do return

    return true
}

diagraminstance_access_level :: proc {
    diagraminstance_access_level_get,
    diagraminstance_access_level_set,
}

diagraminstance_access_level_get :: proc(diagraminstance: DiagramInstance) -> (access_level: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_access_level_set :: proc(diagraminstance: DiagramInstance, access_level: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_safety_type :: proc {
    diagraminstance_safety_type_get,
    diagraminstance_safety_type_set,
}

diagraminstance_safety_type_get :: proc(diagraminstance: DiagramInstance) -> (safety_type: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_safety_type_set :: proc(diagraminstance: DiagramInstance, safety_type: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_type_guid_get :: proc(diagraminstance: DiagramInstance) -> (type_guid: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_type_path_get :: proc(diagraminstance: DiagramInstance) -> (type_path: string, ok: bool) {
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypePathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_release :: proc(diagraminstance: DiagramInstance) {
    if diagraminstance != nil {
        (^DiagramInstanceIF)(diagraminstance)->Release()
    }
}

DiagramInstancesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramInstancesVTable,
}

DiagramInstancesVTable :: struct {
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

diagraminstances_add :: proc {
    diagraminstances_diagraminstance_add_,
    diagraminstances_diagraminstance_add_at_index,
}

diagraminstances_diagraminstance_add_ :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance) -> (ok: bool) {
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Add(diagraminstance)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_add_at_index :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance, index: i32) -> (ok: bool) {
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->AddBefore(diagraminstance, index)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance :: proc {
    diagraminstances_diagraminstance_by_name,
    diagraminstances_diagraminstance_by_index,
}

diagraminstances_diagraminstance_by_name :: proc(diagraminstances: DiagramInstances, name: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->Find(bstr_name, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstances_diagraminstance_by_index :: proc(diagraminstances: DiagramInstances, index: i32) -> (diagraminstance: DiagramInstance, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Item(index + 1, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstances_diagraminstance_index :: proc(diagraminstances: DiagramInstances, name: string) -> (index: i32, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

diagraminstances_diagraminstance_count :: proc(diagraminstances: DiagramInstances) -> (count: i32, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

diagraminstances_diagraminstance_remove :: proc {
    diagraminstances_diagraminstance_remove_by_name,
    diagraminstances_diagraminstance_remove_by_index,
}

diagraminstances_diagraminstance_remove_by_name :: proc(diagraminstances: DiagramInstances, name: string) -> (ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = diagraminstances_diagraminstance_index(diagraminstances, name)
    if !ok do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_remove_by_index :: proc(diagraminstances: DiagramInstances, index: i32) -> (ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

diagraminstances_release :: proc(diagraminstances: DiagramInstances) {
    if diagraminstances != nil {
        (^DiagramInstancesIF)(diagraminstances)->Release()
    }
}

DiagramTypeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramTypeVTable,
}

DiagramTypeVTable :: struct {
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
    InstantiateAsAspectObjectGet: proc "system" (this: ^DiagramTypeIF, InstantiateAsAspectObject: ^VariantBool) -> HResult,
    InstantiateAsAspectObjectPut: proc "system" (this: ^DiagramTypeIF, InstantiateAsAspectObject: VariantBool) -> HResult,
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

diagramtype_new :: proc(name: string, description := "") -> (diagramtype: DiagramType, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewDiagramType(bstr_name, bstr_description, cast(^rawptr)&diagramtype)
    if com_failed(hr) do return

    return diagramtype, true
}

diagramtype_deserialize :: proc(xml: string) -> (diagramtype: DiagramType, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeDiagramType(&bs, cast(^rawptr)&diagramtype)
    if com_failed(hr) do return

    return diagramtype, true
}

diagramtype_serialize :: proc(diagramtype: DiagramType) -> (xml: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_name :: proc {
    diagramtype_name_get,
    diagramtype_name_set,
}

diagramtype_name_get :: proc(diagramtype: DiagramType) -> (name: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_name_set :: proc(diagramtype: DiagramType, name: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_protected :: proc {
    diagramtype_protected_get,
    diagramtype_protected_set,
}

diagramtype_protected_get :: proc(diagramtype: DiagramType) -> (protected: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_protected_set :: proc(diagramtype: DiagramType, protected: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

diagramtype_hidden :: proc {
    diagramtype_hidden_get,
    diagramtype_hidden_set,
}

diagramtype_hidden_get :: proc(diagramtype: DiagramType) -> (hidden: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_hidden_set :: proc(diagramtype: DiagramType, hidden: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

diagramtype_scope :: proc {
    diagramtype_scope_get,
    diagramtype_scope_set,
}

diagramtype_scope_get :: proc(diagramtype: DiagramType) -> (scope: i32, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ScopeGet(&scope)
    if com_failed(hr) do return

    return scope, true
}

diagramtype_scope_set :: proc(diagramtype: DiagramType, scope: i32) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ScopePut(scope)
    if com_failed(hr) do return

    return true
}

diagramtype_alarm_owner :: proc {
    diagramtype_alarm_owner_get,
    diagramtype_alarm_owner_set,
}

diagramtype_alarm_owner_get :: proc(diagramtype: DiagramType) -> (alarm_owner: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_alarm_owner_set :: proc(diagramtype: DiagramType, alarm_owner: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

diagramtype_guid :: proc {
    diagramtype_guid_get,
    diagramtype_guid_set,
}

diagramtype_guid_get :: proc(diagramtype: DiagramType) -> (guid: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_guid_set :: proc(diagramtype: DiagramType, guid: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_instantiate_as_aspect_object :: proc {
    diagramtype_instantiate_as_aspect_object_get,
    diagramtype_instantiate_as_aspect_object_set,
}

diagramtype_instantiate_as_aspect_object_get :: proc(diagramtype: DiagramType) -> (instantiate: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->InstantiateAsAspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_instantiate_as_aspect_object_set :: proc(diagramtype: DiagramType, instantiate: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->InstantiateAsAspectObjectPut(to_variantbool(instantiate))
    if com_failed(hr) do return

    return true
}

diagramtype_sil_level :: proc {
    diagramtype_sil_level_get,
    diagramtype_sil_level_set,
}

diagramtype_sil_level_get :: proc(diagramtype: DiagramType) -> (sil_level: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_sil_level_set :: proc(diagramtype: DiagramType, sil_level: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_restricted_sil :: proc {
    diagramtype_restricted_sil_get,
    diagramtype_restricted_sil_set,
}

diagramtype_restricted_sil_get :: proc(diagramtype: DiagramType) -> (restricted_sil: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_restricted_sil_set :: proc(diagramtype: DiagramType, restricted_sil: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

diagramtype_simulation_mark :: proc {
    diagramtype_simulation_mark_get,
    diagramtype_simulation_mark_set,
}

diagramtype_simulation_mark_get :: proc(diagramtype: DiagramType) -> (simulation_mark: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_simulation_mark_set :: proc(diagramtype: DiagramType, simulation_mark: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

diagramtype_reserved_by_function :: proc {
    diagramtype_reserved_by_function_get,
    diagramtype_reserved_by_function_set,
}

diagramtype_reserved_by_function_get :: proc(diagramtype: DiagramType) -> (reserved_by_function: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_reserved_by_function_set :: proc(diagramtype: DiagramType, reserved_by_function: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_embedded_graphics_visible :: proc {
    diagramtype_embedded_graphics_visible_get,
    diagramtype_embedded_graphics_visible_set,
}

diagramtype_embedded_graphics_visible_get :: proc(diagramtype: DiagramType) -> (visible: bool, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->EmbeddedGraphicsVisibleGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_embedded_graphics_visible_set :: proc(diagramtype: DiagramType, visible: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->EmbeddedGraphicsVisiblePut(to_variantbool(visible))
    if com_failed(hr) do return

    return true
}

diagramtype_description :: proc {
    diagramtype_description_get,
    diagramtype_description_set,
}

diagramtype_description_get :: proc(diagramtype: DiagramType) -> (description: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_description_set :: proc(diagramtype: DiagramType, description: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_parameters :: proc {
    diagramtype_parameters_get,
    diagramtype_parameters_set,
}

diagramtype_parameters_get :: proc(diagramtype: DiagramType) -> (parameters: Parameters, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->ParametersGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

diagramtype_parameters_set :: proc(diagramtype: DiagramType, parameters: Parameters) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ParametersPut(parameters)
    if com_failed(hr) do return

    return true
}

diagramtype_variables :: proc {
    diagramtype_variables_get,
    diagramtype_variables_set,
}

diagramtype_variables_get :: proc(diagramtype: DiagramType) -> (variables: Variables, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

diagramtype_variables_set :: proc(diagramtype: DiagramType, variables: Variables) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

diagramtype_functionblocks :: proc {
    diagramtype_functionblocks_get,
    diagramtype_functionblocks_set,
}

diagramtype_functionblocks_get :: proc(diagramtype: DiagramType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

diagramtype_functionblocks_set :: proc(diagramtype: DiagramType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

diagramtype_controlmodules :: proc {
    diagramtype_controlmodules_get,
    diagramtype_controlmodules_set,
}

diagramtype_controlmodules_get :: proc(diagramtype: DiagramType) -> (controlmodules: ControlModules, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

diagramtype_controlmodules_set :: proc(diagramtype: DiagramType, controlmodules: ControlModules) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

diagramtype_diagraminstances :: proc {
    diagramtype_diagraminstances_get,
    diagramtype_diagraminstances_set,
}

diagramtype_diagraminstances_get :: proc(diagramtype: DiagramType) -> (diagraminstances: DiagramInstances, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->DiagramInstancesGet(&p)
    if com_failed(hr) do return

    return DiagramInstances(p), true
}

diagramtype_diagraminstances_set :: proc(diagramtype: DiagramType, diagraminstances: DiagramInstances) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->DiagramInstancesPut(diagraminstances)
    if com_failed(hr) do return

    return true
}

diagramtype_codeblocks :: proc {
    diagramtype_codeblocks_get,
    diagramtype_codeblocks_set,
}

diagramtype_codeblocks_get :: proc(diagramtype: DiagramType) -> (codeblocks: CodeBlocks, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

diagramtype_codeblocks_set :: proc(diagramtype: DiagramType, codeblocks: CodeBlocks) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

diagramtype_batch_object :: proc {
    diagramtype_batch_object_get,
    diagramtype_batch_object_set,
}

diagramtype_batch_object_get :: proc(diagramtype: DiagramType) -> (batch_object: string, ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_batch_object_set :: proc(diagramtype: DiagramType, batch_object: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(batch_object)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->BatchObjectPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_release :: proc(diagramtype: DiagramType) {
    if diagramtype != nil {
        (^DiagramTypeIF)(diagramtype)->Release()
    }
}
