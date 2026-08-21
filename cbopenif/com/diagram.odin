package com

import t "../types"

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

diagram_serialize :: proc(diagram: Diagram) -> (xml: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_name_get :: proc(diagram: Diagram) -> (name: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_name_set :: proc(diagram: Diagram, name: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagram_task_connection_get :: proc(diagram: Diagram) -> (task_connection: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_task_connection_set :: proc(diagram: Diagram, task_connection: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_type_guid_get :: proc(diagram: Diagram) -> (type_guid: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_type_guid_set :: proc(diagram: Diagram, type_guid: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_inst_guid_get :: proc(diagram: Diagram) -> (inst_guid: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->InstGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_inst_guid_set :: proc(diagram: Diagram, inst_guid: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(inst_guid)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->InstGuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_description_get :: proc(diagram: Diagram) -> (description: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_description_set :: proc(diagram: Diagram, description: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_sil_level_get :: proc(diagram: Diagram) -> (sil_level: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_sil_level_set :: proc(diagram: Diagram, sil_level: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_restricted_sil_get :: proc(diagram: Diagram) -> (restricted_sil: bool, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramIF)(diagram)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagram_restricted_sil_set :: proc(diagram: Diagram, restricted_sil: bool) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

diagram_simulation_mark_get :: proc(diagram: Diagram) -> (simulation_mark: bool, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramIF)(diagram)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagram_simulation_mark_set :: proc(diagram: Diagram, simulation_mark: bool) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

diagram_reserved_by_function_get :: proc(diagram: Diagram) -> (reserved_by_function: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_reserved_by_function_set :: proc(diagram: Diagram, reserved_by_function: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_access_level_get :: proc(diagram: Diagram) -> (access_level: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_access_level_set :: proc(diagram: Diagram, access_level: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagram_safety_type_get :: proc(diagram: Diagram) -> (safety_type: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_safety_type_set :: proc(diagram: Diagram, safety_type: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

diagram_variables_get :: proc(diagram: Diagram) -> (variables: Variables, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

diagram_variables_set :: proc(diagram: Diagram, variables: Variables) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

diagram_commvariables_get :: proc(diagram: Diagram) -> (commvariables: CommVariables, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->CommVariablesGet(&p)
    if com_failed(hr) do return

    return CommVariables(p), true
}

diagram_commvariables_set :: proc(diagram: Diagram, commvariables: CommVariables) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->CommVariablesPut(commvariables)
    if com_failed(hr) do return

    return true
}

diagram_functionblocks_get :: proc(diagram: Diagram) -> (functionblocks: FunctionBlocks, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

diagram_functionblocks_set :: proc(diagram: Diagram, functionblocks: FunctionBlocks) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

diagram_controlmodules_get :: proc(diagram: Diagram) -> (controlmodules: ControlModules, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

diagram_controlmodules_set :: proc(diagram: Diagram, controlmodules: ControlModules) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

diagram_initvalues_get :: proc(diagram: Diagram) -> (initvalues: InitValues, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->InitValuesGet(&p)
    if com_failed(hr) do return

    return InitValues(p), true
}

diagram_initvalues_set :: proc(diagram: Diagram, initvalues: InitValues) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->InitValuesPut(initvalues)
    if com_failed(hr) do return

    return true
}

diagram_codeblocks_get :: proc(diagram: Diagram) -> (codeblocks: CodeBlocks, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

diagram_codeblocks_set :: proc(diagram: Diagram, codeblocks: CodeBlocks) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

diagram_diagraminstances_get :: proc(diagram: Diagram) -> (diagraminstances: DiagramInstances, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->DiagramInstancesGet(&p)
    if com_failed(hr) do return

    return DiagramInstances(p), true
}

diagram_diagraminstances_set :: proc(diagram: Diagram, diagraminstances: DiagramInstances) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->DiagramInstancesPut(diagraminstances)
    if com_failed(hr) do return

    return true
}

diagram_signals_get :: proc(diagram: Diagram) -> (signals: Signals, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramIF)(diagram)->SignalsGet(&p)
    if com_failed(hr) do return

    return Signals(p), true
}

diagram_signals_set :: proc(diagram: Diagram, signals: Signals) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    hr := (^DiagramIF)(diagram)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

diagram_batch_object_get :: proc(diagram: Diagram) -> (batch_object: string, ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramIF)(diagram)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagram_batch_object_set :: proc(diagram: Diagram, batch_object: string) -> (ok: bool) {
    if diagram == nil do return
    if !com_connected() do return

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

diagram_from_com :: proc(diagram: Diagram, allocator := context.allocator) -> (result: t.Diagram, ok: bool) {
    if diagram == nil do return
    context.allocator = allocator

    result.name, ok = name(diagram)
    if !ok do return
    result.description, ok = description(diagram)
    if !ok do return
    result.access_level, ok = access_level(diagram)
    if !ok do return
    result.safety_type, ok = safety_type(diagram)
    if !ok do return
    result.task_connection, ok = task_connection(diagram)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(diagram)
    if !ok do return
    result.sil_level, ok = sil_level(diagram)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(diagram)
    if !ok do return
    // needs types: batch_object: string
    result.batch_object, ok = diagram_batch_object_get(diagram)
    if !ok do return
    result.inst_guid, ok = inst_guid(diagram)
    if !ok do return
    result.type_guid, ok = type_guid(diagram)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(diagram)
    if !ok do return

    {
        c: Variables
        c, ok = variables(diagram)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(diagram)
        if !ok do return
        defer release(c)
        result.signals, ok = signals_from_com(c)
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(diagram)
        if !ok do return
        defer release(c)
        result.comm_variables, ok = commvariables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(diagram)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(diagram)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(diagram)
        if !ok do return
        defer release(c)
        result.control_modules, result.single_control_modules, ok = controlmodules_from_com(c)
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(diagram)
        if !ok do return
        defer release(c)
        result.diagram_instances, ok = diagraminstances_from_com(c)
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(diagram)
        if !ok do return
        defer release(c)
        result.init_values, ok = initvalues_from_com(c)
        if !ok do return
    }

    return result, true
}

diagram_to_com :: proc(src: t.Diagram) -> (result: Diagram, ok: bool) {
    diagram: Diagram
    diagram, ok = diagram_new1(
        src.name,
        src.description,
        src.task_connection,
        src.type_guid,
        src.inst_guid,
    )
    if !ok do return
    defer if !ok do release(diagram)

    ok = access_level(diagram, src.access_level)
    if !ok do return
    ok = safety_type(diagram, src.safety_type)
    if !ok do return
    ok = simulation_mark(diagram, src.simulation_mark)
    if !ok do return
    ok = sil_level(diagram, src.sil_level)
    if !ok do return
    ok = restricted_sil(diagram, src.restricted_sil)
    if !ok do return
    ok = diagram_batch_object_set(diagram, src.batch_object)
    if !ok do return
    ok = reserved_by_function(diagram, src.reserved_by_function)
    if !ok do return

    {
        c: Variables
        c, ok = variables(diagram)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: Signals
        c, ok = signals(diagram)
        if !ok do return
        defer release(c)
        ok = signals_to_com(c, src.signals[:])
        if !ok do return
    }
    {
        c: CommVariables
        c, ok = commvariables(diagram)
        if !ok do return
        defer release(c)
        ok = commvariables_to_com(c, src.comm_variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(diagram)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(diagram)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(diagram)
        if !ok do return
        defer release(c)
        ok = controlmodules_to_com(c, src.control_modules[:], src.single_control_modules[:])
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(diagram)
        if !ok do return
        defer release(c)
        ok = diagraminstances_to_com(c, src.diagram_instances[:])
        if !ok do return
    }
    {
        c: InitValues
        c, ok = initvalues(diagram)
        if !ok do return
        defer release(c)
        ok = initvalues_to_com(c, src.init_values[:])
        if !ok do return
    }

    return diagram, true
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

diagraminstance_serialize :: proc(diagraminstance: DiagramInstance) -> (xml: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_name_get :: proc(diagraminstance: DiagramInstance) -> (name: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_name_set :: proc(diagraminstance: DiagramInstance, name: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_type_name_get :: proc(diagraminstance: DiagramInstance) -> (type_name: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_type_name_set :: proc(diagraminstance: DiagramInstance, type_name: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeNamePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_guid_get :: proc(diagraminstance: DiagramInstance) -> (guid: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_guid_set :: proc(diagraminstance: DiagramInstance, guid: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_description_get :: proc(diagraminstance: DiagramInstance) -> (description: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_description_set :: proc(diagraminstance: DiagramInstance, description: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_aspect_object_get :: proc(diagraminstance: DiagramInstance) -> (aspect_object: bool, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagraminstance_aspect_object_set :: proc(diagraminstance: DiagramInstance, aspect_object: bool) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

diagraminstance_expose_properties_in_parent_get :: proc(diagraminstance: DiagramInstance) -> (expose: bool, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagraminstance_expose_properties_in_parent_set :: proc(diagraminstance: DiagramInstance, expose: bool) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    hr := (^DiagramInstanceIF)(diagraminstance)->ExposePropertiesInParentPut(to_variantbool(expose))
    if com_failed(hr) do return

    return true
}

diagraminstance_access_level_get :: proc(diagraminstance: DiagramInstance) -> (access_level: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_access_level_set :: proc(diagraminstance: DiagramInstance, access_level: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->AccessLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_safety_type_get :: proc(diagraminstance: DiagramInstance) -> (safety_type: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_safety_type_set :: proc(diagraminstance: DiagramInstance, safety_type: string) -> (ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->SafetyTypePut(bs)
    if com_failed(hr) do return

    return true
}

diagraminstance_type_guid_get :: proc(diagraminstance: DiagramInstance) -> (type_guid: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramInstanceIF)(diagraminstance)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagraminstance_type_path_get :: proc(diagraminstance: DiagramInstance) -> (type_path: string, ok: bool) {
    if diagraminstance == nil do return
    if !com_connected() do return

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

diagraminstance_from_com :: proc(di: DiagramInstance, allocator := context.allocator) -> (result: t.DiagramInstance, ok: bool) {
    if di == nil do return
    context.allocator = allocator

    result.name, ok = name(di)
    if !ok do return
    result.type_name, ok = type_name(di)
    if !ok do return
    result.description, ok = description(di)
    if !ok do return
    result.access_level, ok = access_level(di)
    if !ok do return
    result.safety_type, ok = safety_type(di)
    if !ok do return
    result.aspect_object, ok = aspect_object(di)
    if !ok do return
    result.expose_properties_in_parent, ok = expose_properties_in_parent(di)
    if !ok do return
    result.guid, ok = guid(di)
    if !ok do return
    result.type_guid, ok = type_guid(di)
    if !ok do return
    result.type_path, ok = type_path(di)
    if !ok do return

    return result, true
}

diagraminstance_to_com :: proc(src: t.DiagramInstance) -> (result: DiagramInstance, ok: bool) {
    di: DiagramInstance
    di, ok = diagraminstance_new1(src.name, src.type_name, src.guid, src.description)
    if !ok do return
    defer if !ok do release(di)

    ok = access_level(di, src.access_level)
    if !ok do return
    ok = safety_type(di, src.safety_type)
    if !ok do return
    ok = aspect_object(di, src.aspect_object)
    if !ok do return
    ok = expose_properties_in_parent(di, src.expose_properties_in_parent)
    if !ok do return
    // type_guid / type_path read-only

    return di, true
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

diagraminstances_diagraminstance_add :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance) -> (ok: bool) {
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !com_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Add(diagraminstance)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_add_at_index :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance, index: i32) -> (ok: bool) {
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !com_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->AddBefore(diagraminstance, index)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_by_name :: proc(diagraminstances: DiagramInstances, name: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if diagraminstances == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->Find(bstr_name, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstances_diagraminstance_by_index :: proc(diagraminstances: DiagramInstances, index: i32) -> (diagraminstance: DiagramInstance, ok: bool) {
    if diagraminstances == nil do return
    if !com_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Item(index + 1, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstances_diagraminstance_index :: proc(diagraminstances: DiagramInstances, name: string) -> (index: i32, ok: bool) {
    if diagraminstances == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

diagraminstances_diagraminstance_count :: proc(diagraminstances: DiagramInstances) -> (count: i32, ok: bool) {
    if diagraminstances == nil do return
    if !com_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

diagraminstances_diagraminstance_remove_by_name :: proc(diagraminstances: DiagramInstances, name: string) -> (ok: bool) {
    if diagraminstances == nil do return
    if !com_connected() do return

    index: i32
    index, ok = diagraminstances_diagraminstance_index(diagraminstances, name)
    if !ok do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_remove_by_index :: proc(diagraminstances: DiagramInstances, index: i32) -> (ok: bool) {
    if diagraminstances == nil do return
    if !com_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

diagraminstances_release :: proc(diagraminstances: DiagramInstances) {
    if diagraminstances != nil {
        (^DiagramInstancesIF)(diagraminstances)->Release()
    }
}

diagraminstances_from_com :: proc(dis: DiagramInstances, allocator := context.allocator) -> (result: [dynamic]t.DiagramInstance, ok: bool) {
    if dis == nil do return
    context.allocator = allocator

    count: i32
    count, ok = diagraminstance_count(dis)
    if !ok do return

    result = make([dynamic]t.DiagramInstance, 0, int(count), allocator)
    for i in 0..<count {
        di: DiagramInstance
        di, ok = diagraminstance_by_index(dis, i)
        if !ok do return
        defer release(di)

        dis_: t.DiagramInstance
        dis_, ok = diagraminstance_from_com(di)
        if !ok do return
        append(&result, dis_)
    }
    return result, true
}

diagraminstances_to_com :: proc(dis: DiagramInstances, src: []t.DiagramInstance) -> (ok: bool) {
    if dis == nil do return
    for item in src {
        di: DiagramInstance
        di, ok = diagraminstance_to_com(item)
        if !ok do return
        defer release(di)

        ok = diagraminstance_add(dis, di)
        if !ok do return
    }
    return true
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

diagramtype_serialize :: proc(diagramtype: DiagramType) -> (xml: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_name_get :: proc(diagramtype: DiagramType) -> (name: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_name_set :: proc(diagramtype: DiagramType, name: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_protected_get :: proc(diagramtype: DiagramType) -> (protected: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_protected_set :: proc(diagramtype: DiagramType, protected: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

diagramtype_hidden_get :: proc(diagramtype: DiagramType) -> (hidden: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_hidden_set :: proc(diagramtype: DiagramType, hidden: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

diagramtype_scope_get :: proc(diagramtype: DiagramType) -> (scope: t.Scope, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    s: i32
    hr := (^DiagramTypeIF)(diagramtype)->ScopeGet(&s)
    if com_failed(hr) do return

    return t.Scope(s), true
}

diagramtype_scope_set :: proc(diagramtype: DiagramType, scope: i32) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ScopePut(scope)
    if com_failed(hr) do return

    return true
}

diagramtype_alarm_owner_get :: proc(diagramtype: DiagramType) -> (alarm_owner: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_alarm_owner_set :: proc(diagramtype: DiagramType, alarm_owner: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

diagramtype_guid_get :: proc(diagramtype: DiagramType) -> (guid: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_guid_set :: proc(diagramtype: DiagramType, guid: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_instantiate_as_aspect_object_get :: proc(diagramtype: DiagramType) -> (instantiate: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->InstantiateAsAspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_instantiate_as_aspect_object_set :: proc(diagramtype: DiagramType, instantiate: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->InstantiateAsAspectObjectPut(to_variantbool(instantiate))
    if com_failed(hr) do return

    return true
}

diagramtype_sil_level_get :: proc(diagramtype: DiagramType) -> (sil_level: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_sil_level_set :: proc(diagramtype: DiagramType, sil_level: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_restricted_sil_get :: proc(diagramtype: DiagramType) -> (restricted_sil: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_restricted_sil_set :: proc(diagramtype: DiagramType, restricted_sil: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

diagramtype_simulation_mark_get :: proc(diagramtype: DiagramType) -> (simulation_mark: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_simulation_mark_set :: proc(diagramtype: DiagramType, simulation_mark: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

diagramtype_reserved_by_function_get :: proc(diagramtype: DiagramType) -> (reserved_by_function: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_reserved_by_function_set :: proc(diagramtype: DiagramType, reserved_by_function: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_embedded_graphics_visible_get :: proc(diagramtype: DiagramType) -> (visible: bool, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^DiagramTypeIF)(diagramtype)->EmbeddedGraphicsVisibleGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

diagramtype_embedded_graphics_visible_set :: proc(diagramtype: DiagramType, visible: bool) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->EmbeddedGraphicsVisiblePut(to_variantbool(visible))
    if com_failed(hr) do return

    return true
}

diagramtype_description_get :: proc(diagramtype: DiagramType) -> (description: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_description_set :: proc(diagramtype: DiagramType, description: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

diagramtype_parameters_get :: proc(diagramtype: DiagramType) -> (parameters: Parameters, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->ParametersGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

diagramtype_parameters_set :: proc(diagramtype: DiagramType, parameters: Parameters) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ParametersPut(parameters)
    if com_failed(hr) do return

    return true
}

diagramtype_variables_get :: proc(diagramtype: DiagramType) -> (variables: Variables, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

diagramtype_variables_set :: proc(diagramtype: DiagramType, variables: Variables) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

diagramtype_functionblocks_get :: proc(diagramtype: DiagramType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

diagramtype_functionblocks_set :: proc(diagramtype: DiagramType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

diagramtype_controlmodules_get :: proc(diagramtype: DiagramType) -> (controlmodules: ControlModules, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

diagramtype_controlmodules_set :: proc(diagramtype: DiagramType, controlmodules: ControlModules) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

diagramtype_diagraminstances_get :: proc(diagramtype: DiagramType) -> (diagraminstances: DiagramInstances, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->DiagramInstancesGet(&p)
    if com_failed(hr) do return

    return DiagramInstances(p), true
}

diagramtype_diagraminstances_set :: proc(diagramtype: DiagramType, diagraminstances: DiagramInstances) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->DiagramInstancesPut(diagraminstances)
    if com_failed(hr) do return

    return true
}

diagramtype_codeblocks_get :: proc(diagramtype: DiagramType) -> (codeblocks: CodeBlocks, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^DiagramTypeIF)(diagramtype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

diagramtype_codeblocks_set :: proc(diagramtype: DiagramType, codeblocks: CodeBlocks) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    hr := (^DiagramTypeIF)(diagramtype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

diagramtype_batch_object_get :: proc(diagramtype: DiagramType) -> (batch_object: string, ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^DiagramTypeIF)(diagramtype)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

diagramtype_batch_object_set :: proc(diagramtype: DiagramType, batch_object: string) -> (ok: bool) {
    if diagramtype == nil do return
    if !com_connected() do return

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

diagramtype_from_com :: proc(dt: DiagramType, allocator := context.allocator) -> (result: t.DiagramType, ok: bool) {
    if dt == nil do return
    context.allocator = allocator

    result.name, ok = name(dt)
    if !ok do return
    result.description, ok = description(dt)
    if !ok do return
    result.protected, ok = protected(dt)
    if !ok do return
    result.hidden, ok = hidden(dt)
    if !ok do return
    result.scope, ok = scope(dt)
    if !ok do return
    result.guid, ok = guid(dt)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(dt)
    if !ok do return
    result.sil_level, ok = sil_level(dt)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(dt)
    if !ok do return
    result.alarm_owner, ok = alarm_owner(dt)
    if !ok do return
    // needs types: batch_object: string
    result.batch_object, ok = diagramtype_batch_object_get(dt)
    if !ok do return
    result.instantiate_as_aspect_object, ok = instantiate_as_aspect_object(dt)
    if !ok do return
    result.simulation_mark, ok = simulation_mark(dt)
    if !ok do return
    result.embedded_graphics_visible, ok = diagramtype_embedded_graphics_visible_get(dt)
    if !ok do return

    {
        c: Parameters
        c, ok = parameters(dt)
        if !ok do return
        defer release(c)
        result.parameters, ok = parameters_from_com(c)
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(dt)
        if !ok do return
        defer release(c)
        result.variables, ok = variables_from_com(c)
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(dt)
        if !ok do return
        defer release(c)
        result.code_blocks, ok = codeblocks_from_com(c)
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(dt)
        if !ok do return
        defer release(c)
        result.function_blocks, ok = functionblocks_from_com(c)
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(dt)
        if !ok do return
        defer release(c)
        result.control_modules, result.single_control_modules, ok = controlmodules_from_com(c)
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(dt)
        if !ok do return
        defer release(c)
        result.diagram_instances, ok = diagraminstances_from_com(c)
        if !ok do return
    }

    return result, true
}

diagramtype_to_com :: proc(src: t.DiagramType) -> (result: DiagramType, ok: bool) {
    dt: DiagramType
    dt, ok = diagramtype_new1(
        src.name,
        src.description,
        src.protected,
        src.hidden,
        src.scope,
        src.alarm_owner,
        src.guid,
    )
    if !ok do return
    defer if !ok do release(dt)

    ok = reserved_by_function(dt, src.reserved_by_function)
    if !ok do return
    ok = sil_level(dt, src.sil_level)
    if !ok do return
    ok = restricted_sil(dt, src.restricted_sil)
    if !ok do return
    ok = diagramtype_batch_object_set(dt, src.batch_object)
    if !ok do return
    ok = instantiate_as_aspect_object(dt, src.instantiate_as_aspect_object)
    if !ok do return
    ok = simulation_mark(dt, src.simulation_mark)
    if !ok do return
    ok = diagramtype_embedded_graphics_visible_set(dt, src.embedded_graphics_visible)
    if !ok do return

    {
        c: Parameters
        c, ok = parameters(dt)
        if !ok do return
        defer release(c)
        ok = parameters_to_com(c, src.parameters[:])
        if !ok do return
    }
    {
        c: Variables
        c, ok = variables(dt)
        if !ok do return
        defer release(c)
        ok = variables_to_com(c, src.variables[:])
        if !ok do return
    }
    {
        c: CodeBlocks
        c, ok = codeblocks(dt)
        if !ok do return
        defer release(c)
        ok = codeblocks_to_com(c, src.code_blocks[:])
        if !ok do return
    }
    {
        c: FunctionBlocks
        c, ok = functionblocks(dt)
        if !ok do return
        defer release(c)
        ok = functionblocks_to_com(c, src.function_blocks[:])
        if !ok do return
    }
    {
        c: ControlModules
        c, ok = controlmodules(dt)
        if !ok do return
        defer release(c)
        ok = controlmodules_to_com(c, src.control_modules[:], src.single_control_modules[:])
        if !ok do return
    }
    {
        c: DiagramInstances
        c, ok = diagraminstances(dt)
        if !ok do return
        defer release(c)
        ok = diagraminstances_to_com(c, src.diagram_instances[:])
        if !ok do return
    }

    return dt, true
}
