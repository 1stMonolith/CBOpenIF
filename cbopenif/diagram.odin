package cbopenif

Diagram :: distinct rawptr

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
