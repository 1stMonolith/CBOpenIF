package cbopenif

SingleControlModuleType :: distinct rawptr

SingleControlModuleTypeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SingleControlModuleTypeVTable,
}

SingleControlModuleTypeVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^SingleControlModuleTypeIF, name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^SingleControlModuleTypeIF, name: BStr) -> HResult,
    InteractionWindowGet:  proc "system" (this: ^SingleControlModuleTypeIF, InteractionWindow: ^BStr) -> HResult,
    InteractionWindowPut:  proc "system" (this: ^SingleControlModuleTypeIF, InteractionWindow: BStr) -> HResult,
    AlarmOwnerGet:         proc "system" (this: ^SingleControlModuleTypeIF, AlarmOwner: ^VariantBool) -> HResult,
    AlarmOwnerPut:         proc "system" (this: ^SingleControlModuleTypeIF, AlarmOwner: VariantBool) -> HResult,
    TypeGuidGet:           proc "system" (this: ^SingleControlModuleTypeIF, TypeGuid: ^BStr) -> HResult,
    TypeGuidPut:           proc "system" (this: ^SingleControlModuleTypeIF, TypeGuid: BStr) -> HResult,
    BatchObjectGet:        proc "system" (this: ^SingleControlModuleTypeIF, BatchObject: ^BStr) -> HResult,
    BatchObjectPut:        proc "system" (this: ^SingleControlModuleTypeIF, BatchObject: BStr) -> HResult,
    SILLevelGet:           proc "system" (this: ^SingleControlModuleTypeIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:           proc "system" (this: ^SingleControlModuleTypeIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet:     proc "system" (this: ^SingleControlModuleTypeIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut:     proc "system" (this: ^SingleControlModuleTypeIF, SimulationMark: VariantBool) -> HResult,
    ReservedByFunctionGet: proc "system" (this: ^SingleControlModuleTypeIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut: proc "system" (this: ^SingleControlModuleTypeIF, ReservedByFunction: BStr) -> HResult,
    DescriptionGet:        proc "system" (this: ^SingleControlModuleTypeIF, Description: ^BStr) -> HResult,
    DescriptionPut:        proc "system" (this: ^SingleControlModuleTypeIF, Description: BStr) -> HResult,
    CMTypeGraphicsGet:     proc "system" (this: ^SingleControlModuleTypeIF, CMTypeGraphics: ^BStr) -> HResult,
    CMTypeGraphicsPut:     proc "system" (this: ^SingleControlModuleTypeIF, CMTypeGraphics: BStr) -> HResult,
    CMParametersGet:       proc "system" (this: ^SingleControlModuleTypeIF, CMParameters: ^rawptr) -> HResult,
    Missing28:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    CMParametersPut:       proc "system" (this: ^SingleControlModuleTypeIF, CMParameters: rawptr) -> HResult,
    VariablesGet:          proc "system" (this: ^SingleControlModuleTypeIF, Variables: ^rawptr) -> HResult,
    Missing31:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    VariablesPut:          proc "system" (this: ^SingleControlModuleTypeIF, Variables: rawptr) -> HResult,
    ExternalVariablesGet:  proc "system" (this: ^SingleControlModuleTypeIF, ExternalVariables: ^rawptr) -> HResult,
    Missing34:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    ExternalVariablesPut:  proc "system" (this: ^SingleControlModuleTypeIF, ExternalVariables: rawptr) -> HResult,
    FunctionBlocksGet:     proc "system" (this: ^SingleControlModuleTypeIF, FunctionBlocks: ^rawptr) -> HResult,
    Missing37:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    FunctionBlocksPut:     proc "system" (this: ^SingleControlModuleTypeIF, FunctionBlocks: rawptr) -> HResult,
    ControlModulesGet:     proc "system" (this: ^SingleControlModuleTypeIF, ControlModules: ^rawptr) -> HResult,
    Missing40:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    ControlModulesPut:     proc "system" (this: ^SingleControlModuleTypeIF, ControlModules: rawptr) -> HResult,
    CodeBlocksGet:         proc "system" (this: ^SingleControlModuleTypeIF, CodeBlocks: ^rawptr) -> HResult,
    Missing43:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    CodeBlocksPut:         proc "system" (this: ^SingleControlModuleTypeIF, CodeBlocks: rawptr) -> HResult,
    GraphSizeGet:          proc "system" (this: ^SingleControlModuleTypeIF, GraphSize: ^rawptr) -> HResult,
    Missing46:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    GraphSizePut:          proc "system" (this: ^SingleControlModuleTypeIF, GraphSize: rawptr) -> HResult,
    Serialize:             proc "system" (this: ^SingleControlModuleTypeIF, XML: ^BStr) -> HResult,
    RestrictedSILGet:      proc "system" (this: ^SingleControlModuleTypeIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:      proc "system" (this: ^SingleControlModuleTypeIF, RestrictedSIL: VariantBool) -> HResult,
    CommVariablesGet:      proc "system" (this: ^SingleControlModuleTypeIF, CommVariables: ^rawptr) -> HResult,
    Missing52:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    CommVariablesPut:      proc "system" (this: ^SingleControlModuleTypeIF, CommVariables: rawptr) -> HResult,
    InitValuesGet:         proc "system" (this: ^SingleControlModuleTypeIF, InitValues: ^rawptr) -> HResult,
    Missing55:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    InitValuesPut:         proc "system" (this: ^SingleControlModuleTypeIF, InitValues: rawptr) -> HResult,
    SignalsGet:            proc "system" (this: ^SingleControlModuleTypeIF, Signals: ^rawptr) -> HResult,
    Missing58:             proc "system" (this: ^SingleControlModuleTypeIF) -> HResult,
    SignalsPut:            proc "system" (this: ^SingleControlModuleTypeIF, Signals: rawptr) -> HResult,
}

singlecontrolmoduletype_new :: proc (name: string, description := "") -> (singlecontrolmoduletype: SingleControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewSingleControlModuleType(bstr_name, bstr_description, cast(^rawptr)&singlecontrolmoduletype)
    if com_failed(hr) do return
    
    return singlecontrolmoduletype, true
}

singlecontrolmoduletype_deserialize :: proc(xml: string) -> (singlecontrolmoduletype: SingleControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeSingleControlModuleType(&bs, cast(^rawptr)singlecontrolmoduletype)
    if com_failed(hr) do return

    return singlecontrolmoduletype, true
}

singlecontrolmoduletype_serialize :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (xml: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_name :: proc {
    singlecontrolmoduletype_name_get,
    singlecontrolmoduletype_name_set,
}

singlecontrolmoduletype_name_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (name: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_name_set :: proc(singlecontrolmoduletype: SingleControlModuleType, name: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_interaction_window :: proc {
    singlecontrolmoduletype_interaction_window_get,
    singlecontrolmoduletype_interaction_window_set,
}

singlecontrolmoduletype_interaction_window_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (interaction_window: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InteractionWindowGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_interaction_window_set :: proc(singlecontrolmoduletype: SingleControlModuleType, interaction_window: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(interaction_window)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InteractionWindowPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_alarm_owner :: proc {
    singlecontrolmoduletype_alarm_owner_get,
    singlecontrolmoduletype_alarm_owner_set,
}

singlecontrolmoduletype_alarm_owner_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (alarm_owner: bool, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduletype_alarm_owner_set :: proc(singlecontrolmoduletype: SingleControlModuleType, alarm_owner: bool) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_type_guid :: proc {
    singlecontrolmoduletype_type_guid_get,
    singlecontrolmoduletype_type_guid_set,
}

singlecontrolmoduletype_type_guid_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (type_guid: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_type_guid_set :: proc(singlecontrolmoduletype: SingleControlModuleType, type_guid: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_batch_object :: proc {
    singlecontrolmoduletype_batch_object_get,
    singlecontrolmoduletype_batch_object_set,
}

singlecontrolmoduletype_batch_object_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (batch_object: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_batch_object_set :: proc(singlecontrolmoduletype: SingleControlModuleType, batch_object: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(batch_object)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->BatchObjectPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_sil_level :: proc {
    singlecontrolmoduletype_sil_level_get,
    singlecontrolmoduletype_sil_level_set,
}

singlecontrolmoduletype_sil_level_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (sil_level: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_sil_level_set :: proc(singlecontrolmoduletype: SingleControlModuleType, sil_level: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_simulation_mark :: proc {
    singlecontrolmoduletype_simulation_mark_get,
    singlecontrolmoduletype_simulation_mark_set,
}

singlecontrolmoduletype_simulation_mark_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (simulation_mark: bool, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduletype_simulation_mark_set :: proc(singlecontrolmoduletype: SingleControlModuleType, simulation_mark: bool) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_reserved_by_function :: proc {
    singlecontrolmoduletype_reserved_by_function_get,
    singlecontrolmoduletype_reserved_by_function_set,
}

singlecontrolmoduletype_reserved_by_function_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (reserved_by_function: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_reserved_by_function_set :: proc(singlecontrolmoduletype: SingleControlModuleType, reserved_by_function: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_description :: proc {
    singlecontrolmoduletype_description_get,
    singlecontrolmoduletype_description_set,
}

singlecontrolmoduletype_description_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (description: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_description_set :: proc(singlecontrolmoduletype: SingleControlModuleType, description: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_cmgraphics :: proc {
    singlecontrolmoduletype_cmgraphics_get,
    singlecontrolmoduletype_cmgraphics_set,
}

singlecontrolmoduletype_cmgraphics_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (cmgraphics: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMTypeGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_cmgraphics_set :: proc(singlecontrolmoduletype: SingleControlModuleType, cmgraphics: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(cmgraphics)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMTypeGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_cmparameters :: proc {
    singlecontrolmoduletype_cmparameters_get,
    singlecontrolmoduletype_cmparameters_set,
}

singlecontrolmoduletype_cmparameters_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (cmparameters: CMParameters, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMParametersGet(&p)
    if com_failed(hr) do return

    return CMParameters(p), true
}

singlecontrolmoduletype_cmparameters_set :: proc(singlecontrolmoduletype: SingleControlModuleType, cmparameters: CMParameters) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMParametersPut(cmparameters)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_variables :: proc {
    singlecontrolmoduletype_variables_get,
    singlecontrolmoduletype_variables_set,
}

singlecontrolmoduletype_variables_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (variables: Variables, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

singlecontrolmoduletype_variables_set :: proc(singlecontrolmoduletype: SingleControlModuleType, variables: Variables) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_externalvariables :: proc {
    singlecontrolmoduletype_externalvariables_get,
    singlecontrolmoduletype_externalvariables_set,
}

singlecontrolmoduletype_externalvariables_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (externalvariables: ExternalVariables, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ExternalVariablesGet(&p)
    if com_failed(hr) do return

    return ExternalVariables(p), true
}

singlecontrolmoduletype_externalvariables_set :: proc(singlecontrolmoduletype: SingleControlModuleType, externalvariables: ExternalVariables) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ExternalVariablesPut(externalvariables)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_functionblocks :: proc {
    singlecontrolmoduletype_functionblocks_get,
    singlecontrolmoduletype_functionblocks_set,
}

singlecontrolmoduletype_functionblocks_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

singlecontrolmoduletype_functionblocks_set :: proc(singlecontrolmoduletype: SingleControlModuleType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_controlmodules :: proc {
    singlecontrolmoduletype_controlmodules_get,
    singlecontrolmoduletype_controlmodules_set,
}

singlecontrolmoduletype_controlmodules_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (controlmodules: ControlModules, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

singlecontrolmoduletype_controlmodules_set :: proc(singlecontrolmoduletype: SingleControlModuleType, controlmodules: ControlModules) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_codeblocks :: proc {
    singlecontrolmoduletype_codeblocks_get,
    singlecontrolmoduletype_codeblocks_set,
}

singlecontrolmoduletype_codeblocks_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (codeblocks: CodeBlocks, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

singlecontrolmoduletype_codeblocks_set :: proc(singlecontrolmoduletype: SingleControlModuleType, codeblocks: CodeBlocks) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_graphsize :: proc {
    singlecontrolmoduletype_graphsize_get,
    singlecontrolmoduletype_graphsize_set,
}

singlecontrolmoduletype_graphsize_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (graphsize: GraphSize, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->GraphSizeGet(&p)
    if com_failed(hr) do return

    return GraphSize(p), true
}

singlecontrolmoduletype_graphsize_set :: proc(singlecontrolmoduletype: SingleControlModuleType, graphsize: GraphSize) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->GraphSizePut(graphsize)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_restricted_sil :: proc {
    singlecontrolmoduletype_restricted_sil_get,
    singlecontrolmoduletype_restricted_sil_set,
}

singlecontrolmoduletype_restricted_sil_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (restricted_sil: bool, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduletype_restricted_sil_set :: proc(singlecontrolmoduletype: SingleControlModuleType, restricted_sil: bool) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_commvariables :: proc {
    singlecontrolmoduletype_commvariables_get,
    singlecontrolmoduletype_commvariables_set,
}

singlecontrolmoduletype_commvariables_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (commvariables: CommVariables, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CommVariablesGet(&p)
    if com_failed(hr) do return

    return CommVariables(p), true
}

singlecontrolmoduletype_commvariables_set :: proc(singlecontrolmoduletype: SingleControlModuleType, commvariables: CommVariables) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CommVariablesPut(commvariables)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_initvalues :: proc {
    singlecontrolmoduletype_initvalues_get,
    singlecontrolmoduletype_initvalues_set,
}

singlecontrolmoduletype_initvalues_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (initvalues: InitValues, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InitValuesGet(&p)
    if com_failed(hr) do return

    return InitValues(p), true
}

singlecontrolmoduletype_initvalues_set :: proc(singlecontrolmoduletype: SingleControlModuleType, initvalues: InitValues) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InitValuesPut(initvalues)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_signals :: proc {
    singlecontrolmoduletype_signals_get,
    singlecontrolmoduletype_signals_set,
}

singlecontrolmoduletype_signals_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (signals: Signals, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SignalsGet(&p)
    if com_failed(hr) do return

    return Signals(p), true
}

singlecontrolmoduletype_signals_set :: proc(singlecontrolmoduletype: SingleControlModuleType, signals: Signals) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_release :: proc(singlecontrolmoduletype: SingleControlModuleType) {
    if singlecontrolmoduletype != nil {
        (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->Release()
    }
}
