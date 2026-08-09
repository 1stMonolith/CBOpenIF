package cbopenif

DiagramType :: distinct rawptr

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
