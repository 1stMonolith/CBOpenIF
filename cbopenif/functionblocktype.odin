package cbopenif

import "core:fmt"

FunctionBlockType :: distinct rawptr

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

functionblocktype_new :: proc (name: string, description := "") -> (functionblocktype: FunctionBlockType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewFunctionBlockType(bstr_name, bstr_description, cast(^rawptr)&functionblocktype)
    if com_failed(hr) do return
    return functionblocktype, true
}

functionblocktype_deserialize :: proc(xml: string) -> (functionblocktype: FunctionBlockType, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeFunctionBlockType(&bs, cast(^rawptr)functionblocktype)
    if com_failed(hr) do return

    return functionblocktype, true
}

functionblocktype_serialize :: proc(functionblocktype: FunctionBlockType) -> (xml: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->Serialize(&bs)
    if com_failed(hr) do return
    return from_bstr(bs), true
}

functionblocktype_name :: proc {
    functionblocktype_name_get,
    functionblocktype_name_set,
}

functionblocktype_name_get :: proc(functionblocktype: FunctionBlockType) -> (name: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_name_set :: proc(functionblocktype: FunctionBlockType, name: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_protected :: proc {
    functionblocktype_protected_get,
    functionblocktype_protected_set,
}

functionblocktype_protected_get :: proc(functionblocktype: FunctionBlockType) -> (protected: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_protected_set :: proc(functionblocktype: FunctionBlockType, protected: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

functionblocktype_hidden :: proc {
    functionblocktype_hidden_get,
    functionblocktype_hidden_set,
}

functionblocktype_hidden_get :: proc(functionblocktype: FunctionBlockType) -> (hidden: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_hidden_set :: proc(functionblocktype: FunctionBlockType, hidden: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

functionblocktype_scope :: proc {
    functionblocktype_scope_get,
    functionblocktype_scope_set,
}

functionblocktype_scope_get :: proc(functionblocktype: FunctionBlockType) -> (scope: ScopeType, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    s: i32
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ScopeGet(&s)
    if com_failed(hr) do return

    return ScopeType(s), true
}

functionblocktype_scope_set :: proc(functionblocktype: FunctionBlockType, scope: ScopeType) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ScopePut(i32(scope))
    if com_failed(hr) do return

    return true
}

functionblocktype_interaction_window :: proc {
    functionblocktype_interaction_window_get,
    functionblocktype_interaction_window_set,
}

functionblocktype_interaction_window_get :: proc(functionblocktype: FunctionBlockType) -> (interaction_window: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InteractionWindowGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_interaction_window_set :: proc(functionblocktype: FunctionBlockType, interaction_window: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(interaction_window)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InteractionWindowPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_alarm_owner :: proc {
    functionblocktype_alarm_owner_get,
    functionblocktype_alarm_owner_set,
}

functionblocktype_alarm_owner_get :: proc(functionblocktype: FunctionBlockType) -> (alarm_owner: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_alarm_owner_set :: proc(functionblocktype: FunctionBlockType, alarm_owner: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

functionblocktype_guid :: proc {
    functionblocktype_guid_get,
    functionblocktype_guid_set,
}

functionblocktype_guid_get :: proc(functionblocktype: FunctionBlockType) -> (guid: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_guid_set :: proc(functionblocktype: FunctionBlockType, guid: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_sil_level :: proc {
    functionblocktype_sil_level_get,
    functionblocktype_sil_level_set,
}

functionblocktype_sil_level_get :: proc(functionblocktype: FunctionBlockType) -> (sil_level: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_sil_level_set :: proc(functionblocktype: FunctionBlockType, sil_level: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_simulation_mark :: proc {
    functionblocktype_simulation_mark_get,
    functionblocktype_simulation_mark_set,
}

functionblocktype_simulation_mark_get :: proc(functionblocktype: FunctionBlockType) -> (simulation_mark: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_simulation_mark_set :: proc(functionblocktype: FunctionBlockType, simulation_mark: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

functionblocktype_reserved_by_function :: proc {
    functionblocktype_reserved_by_function_get,
    functionblocktype_reserved_by_function_set,
}

functionblocktype_reserved_by_function_get :: proc(functionblocktype: FunctionBlockType) -> (reserved_by_function: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_reserved_by_function_set :: proc(functionblocktype: FunctionBlockType, reserved_by_function: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_description :: proc {
    functionblocktype_description_get,
    functionblocktype_description_set,
}

functionblocktype_description_get :: proc(functionblocktype: FunctionBlockType) -> (description: string, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

functionblocktype_description_set :: proc(functionblocktype: FunctionBlockType, description: string) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^FunctionBlockTypeIF)(functionblocktype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

functionblocktype_parameters :: proc {
    functionblocktype_parameters_get,
    functionblocktype_parameters_set,
}

functionblocktype_parameters_get :: proc(functionblocktype: FunctionBlockType) -> (parameters: Parameters, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ParametersGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

functionblocktype_parameters_set :: proc(functionblocktype: FunctionBlockType, parameters: Parameters) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ParametersPut(parameters)
    if com_failed(hr) do return

    return true
}

functionblocktype_extensibleparameters :: proc {
    functionblocktype_extensibleparameters_get,
    functionblocktype_extensibleparameters_set,
}

functionblocktype_extensibleparameters_get :: proc(functionblocktype: FunctionBlockType) -> (extensibleparameters: ExtensibleParameters, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExtensibleParametersGet(&p)
    if com_failed(hr) do return

    return ExtensibleParameters(p), true
}

functionblocktype_extensibleparameters_set :: proc(functionblocktype: FunctionBlockType, extensibleparameters: ExtensibleParameters) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExtensibleParametersPut(extensibleparameters)
    if com_failed(hr) do return

    return true
}

functionblocktype_variables :: proc {
    functionblocktype_variables_get,
    functionblocktype_variables_set,
}

functionblocktype_variables_get :: proc(functionblocktype: FunctionBlockType) -> (variables: Variables, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

functionblocktype_variables_set :: proc(functionblocktype: FunctionBlockType, variables: Variables) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

functionblocktype_externalvariables :: proc {
    functionblocktype_externalvariables_get,
    functionblocktype_externalvariables_set,
}

functionblocktype_externalvariables_get :: proc(functionblocktype: FunctionBlockType) -> (externalvariables: ExternalVariables, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExternalVariablesGet(&p)
    if com_failed(hr) do return

    return ExternalVariables(p), true
}

functionblocktype_externalvariables_set :: proc(functionblocktype: FunctionBlockType, externalvariables: ExternalVariables) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ExternalVariablesPut(externalvariables)
    if com_failed(hr) do return

    return true
}

functionblocktype_functionblocks :: proc {
    functionblocktype_functionblocks_get,
    functionblocktype_functionblocks_set,
}

functionblocktype_functionblocks_get :: proc(functionblocktype: FunctionBlockType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

functionblocktype_functionblocks_set :: proc(functionblocktype: FunctionBlockType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

/* I do not think function blocks have control modules
functionblocktype_controlmodules :: proc {
    functionblocktype_controlmodules_get,
    functionblocktype_controlmodules_set,
}

functionblocktype_controlmodules_get :: proc(functionblocktype: FunctionBlockType) -> (controlmodules: ControlModules, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

functionblocktype_controlmodules_set :: proc(functionblocktype: FunctionBlockType, controlmodules: ControlModules) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}
*/

functionblocktype_codeblocks :: proc {
    functionblocktype_codeblocks_get,
    functionblocktype_codeblocks_set,
}

functionblocktype_codeblocks_get :: proc(functionblocktype: FunctionBlockType) -> (codeblocks: CodeBlocks, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^FunctionBlockTypeIF)(functionblocktype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

functionblocktype_codeblocks_set :: proc(functionblocktype: FunctionBlockType, codeblocks: CodeBlocks) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

functionblocktype_instantiate_as_aspect_object :: proc {
    functionblocktype_instantiate_as_aspect_object_get,
    functionblocktype_instantiate_as_aspect_object_set,
}

functionblocktype_instantiate_as_aspect_object_get :: proc(functionblocktype: FunctionBlockType) -> (instantiate_as_aspect_object: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InstantiateAsAspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_instantiate_as_aspect_object_set :: proc(functionblocktype: FunctionBlockType, instantiate_as_aspect_object: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->InstantiateAsAspectObjectPut(to_variantbool(instantiate_as_aspect_object))
    if com_failed(hr) do return

    return true
}

functionblocktype_embedded_graphiscs_visible :: proc {
    functionblocktype_embedded_graphiscs_visible_get,
    functionblocktype_embedded_graphiscs_visible_set,
}

functionblocktype_embedded_graphiscs_visible_get :: proc(functionblocktype: FunctionBlockType) -> (embedded_graphiscs_visible: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->EmbeddedGraphicsVisibleGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_embedded_graphiscs_visible_set :: proc(functionblocktype: FunctionBlockType, embedded_graphiscs_visible: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->EmbeddedGraphicsVisiblePut(to_variantbool(embedded_graphiscs_visible))
    if com_failed(hr) do return

    return true
}

functionblocktype_restricted_sil :: proc {
    functionblocktype_restricted_sil_get,
    functionblocktype_restricted_sil_set,
}

functionblocktype_restricted_sil_get :: proc(functionblocktype: FunctionBlockType) -> (restricted_sil: bool, ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^FunctionBlockTypeIF)(functionblocktype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

functionblocktype_restricted_sil_set :: proc(functionblocktype: FunctionBlockType, restricted_sil: bool) -> (ok: bool) {
    if functionblocktype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^FunctionBlockTypeIF)(functionblocktype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

functionblocktype_release :: proc(functionblocktype: FunctionBlockType) {
    if functionblocktype != nil {
        (^FunctionBlockTypeIF)(functionblocktype)->Release()
    }
}
