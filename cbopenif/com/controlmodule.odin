package com

import t "../types"

IControlModule          :: distinct rawptr
ControlModule           :: distinct rawptr
ControlModules          :: distinct rawptr
ControlModuleType       :: distinct rawptr
SingleControlModuleType :: distinct rawptr
SingleControlModuleInst :: distinct rawptr
CMConnection            :: distinct rawptr
CMConnections           :: distinct rawptr
CMParameter             :: distinct rawptr
CMParameters            :: distinct rawptr

IControlModuleIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^IControlModuleVTable,
}

IControlModuleVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:               proc "system" (this: ^IControlModuleIF, Name: ^BStr) -> HResult,
    NamePut:               proc "system" (this: ^IControlModuleIF, Name: BStr) -> HResult,
    IsControlModule:       proc "system" (this: ^IControlModuleIF, IsControlModule: ^VariantBool) -> HResult,
    IsSingleControlModule: proc "system" (this: ^IControlModuleIF, IsSingleControlModule: ^VariantBool) -> HResult,
}

icontrolmodule_name_get :: proc(icontrolmodule: IControlModule) -> (name: string, ok: bool) {
    if icontrolmodule == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^IControlModuleIF)(icontrolmodule)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

icontrolmodule_name_set :: proc(icontrolmodule: IControlModule, name: string) -> (ok: bool) {
    if icontrolmodule == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^IControlModuleIF)(icontrolmodule)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

icontrolmodule_is_controlmodule :: proc(icontrolmodule: IControlModule) -> (is_controlmodule: bool, ok: bool) {
    if icontrolmodule == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^IControlModuleIF)(icontrolmodule)->IsControlModule(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

icontrolmodule_is_singlecontrolmodule :: proc(icontrolmodule: IControlModule) -> (is_singlecontrolmodule: bool, ok: bool) {
    if icontrolmodule == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^IControlModuleIF)(icontrolmodule)->IsSingleControlModule(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

ControlModuleIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModuleVTable,
}

ControlModuleVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                     proc "system" (this: ^ControlModuleIF, name: ^BStr) -> HResult,
    NamePut:                     proc "system" (this: ^ControlModuleIF, name: BStr) -> HResult,
    TypeNameGet:                 proc "system" (this: ^ControlModuleIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:                 proc "system" (this: ^ControlModuleIF, TypeName: BStr) -> HResult,
    TaskConnectionGet:           proc "system" (this: ^ControlModuleIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:           proc "system" (this: ^ControlModuleIF, TaskConnection: BStr) -> HResult,
    VisibilityinGraphicsGet:     proc "system" (this: ^ControlModuleIF, Visibility: ^VariantBool) -> HResult,
    VisibilityinGraphicsPut:     proc "system" (this: ^ControlModuleIF, Visibility: VariantBool) -> HResult,
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

controlmodule_serialize :: proc(controlmodule: ControlModule) -> (xml: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_name_get :: proc(controlmodule: ControlModule) -> (name: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_name_set :: proc(controlmodule: ControlModule, name: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_type_name_get :: proc(controlmodule: ControlModule) -> (type_name: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeNameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_type_name_set :: proc(controlmodule: ControlModule, type_name: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

controlmodule_task_connection_get :: proc(controlmodule: ControlModule) -> (task_connection: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_task_connection_set :: proc(controlmodule: ControlModule, task_connection: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_visibility_in_graphics_get :: proc(controlmodule: ControlModule) -> (visibility_in_graphics: bool, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmodule_visibility_in_graphics_set :: proc(controlmodule: ControlModule, visibility_in_graphics: bool) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    vb := to_variantbool(visibility_in_graphics)
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentPut(vb)
    if com_failed(hr) do return

    return true
}

controlmodule_guid_get :: proc(controlmodule: ControlModule) -> (guid: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_guid_set :: proc(controlmodule: ControlModule, guid: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_description_get :: proc(controlmodule: ControlModule) -> (description: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_description_set :: proc(controlmodule: ControlModule, description: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_cmconnections_get :: proc(controlmodule: ControlModule) -> (cmconnections: Parameters, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleIF)(controlmodule)->CMConnectionsGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

controlmodule_cmconnections_set :: proc(controlmodule: ControlModule, cmconnections: Parameters) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->CMConnectionsPut(cmconnections)
    if com_failed(hr) do return

    return true
}

controlmodule_graphpos_get :: proc(controlmodule: ControlModule) -> (graphpos: GraphPos, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleIF)(controlmodule)->GraphPosGet(&p)
    if com_failed(hr) do return

    return GraphPos(p), true
}

controlmodule_graphpos_set :: proc(controlmodule: ControlModule, graphpos: GraphPos) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->GraphPosPut(graphpos)
    if com_failed(hr) do return

    return true
}

controlmodule_instance_graphics_get :: proc(controlmodule: ControlModule) -> (instance_graphics: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->CMInstGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_instance_graphics_set :: proc(controlmodule: ControlModule, instance_graphics: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    bs := to_bstr(instance_graphics)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->CMInstGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_type_guid_get :: proc(controlmodule: ControlModule) -> (type_guid: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeGuidGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_type_path_get :: proc(controlmodule: ControlModule) -> (type_path: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypePathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_aspect_object_get :: proc(controlmodule: ControlModule) -> (aspect_object: bool, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmodule_aspect_object_set :: proc(controlmodule: ControlModule, aspect_object: bool) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

controlmodule_access_level_get :: proc(controlmodule: ControlModule) -> (access_level: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_access_level_set :: proc(controlmodule: ControlModule, access_level: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

controlmodule_safety_type_get :: proc(controlmodule: ControlModule) -> (safety_type: string, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_safety_type_set :: proc(controlmodule: ControlModule, safety_type: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

controlmodule_expose_properties_in_parent_get :: proc(controlmodule: ControlModule) -> (expose_properties_in_parent: bool, ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmodule_expose_properties_in_parent_set :: proc(controlmodule: ControlModule, expose_properties_in_parent: bool) -> (ok: bool) {
    if controlmodule == nil do return
    if !com_connected() do return
    
    vb := to_variantbool(expose_properties_in_parent)
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentPut(vb)
    if com_failed(hr) do return

    return true
}

controlmodule_release :: proc(controlmodule: ControlModule) {
    if controlmodule != nil {
        (^ControlModuleIF)(controlmodule)->Release()
    }
}

ControlModulesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModulesVTable,
}

ControlModulesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize:                   proc "system" (this: ^ControlModulesIF, XML: ^BStr) -> HResult,
    Add:                         proc "system" (this: ^ControlModulesIF, IControlModule: rawptr) -> HResult,
    AddBefore:                   proc "system" (this: ^ControlModulesIF, IControlModule: rawptr, Index: i32) -> HResult,
    AddControlModule:            proc "system" (this: ^ControlModulesIF, Name, TypeName: BStr, ControlModule: ^rawptr) -> HResult,
    AddControlModule1:           proc "system" (this: ^ControlModulesIF, Name, TypeName, TaskConnection: BStr, VisibilityInGraphics: i32, Guid, Description: BStr, ControlModules: ^rawptr) -> HResult,
    AddSingleControlModuleInst:  proc "system" (this: ^ControlModulesIF, Name: BStr, SingleControlModuleInst: ^rawptr) -> HResult,
    AddSingleControlModuleInst1: proc "system" (this: ^ControlModulesIF, Name, TaskConnection: BStr, VisibilityInGraphics: i32, TypeGuid, InstGuid: BStr, GraphPos: ^GraphPos, SingleControlModuleInst: ^rawptr) -> HResult,
    Find:                        proc "system" (this: ^ControlModulesIF, Name: BStr, IControlModule: ^rawptr) -> HResult,
    FindNr:                      proc "system" (this: ^ControlModulesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:                        proc "system" (this: ^ControlModulesIF, Index: i32, IControlModule: ^rawptr) -> HResult,
    Count:                       proc "system" (this: ^ControlModulesIF, Count: ^i32) -> HResult,
    Remove:                      proc "system" (this: ^ControlModulesIF, Index: i32) -> HResult,
}

controlmodules_serialize :: proc(controlmodules: ControlModules) -> (xml: string, ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodules)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodules_icontrolmodule_add :: proc(controlmodules: ControlModules, icontrolmodule: IControlModule) -> (ok: bool) {
    if controlmodules == nil do return
    if icontrolmodule == nil do return
    if !com_connected() do return

    hr := (^ExternalVariablesIF)(controlmodules)->Add(icontrolmodule)
    if com_failed(hr) do return

    return true
}

controlmodules_icontrolmodule_add_at_index :: proc(controlmodules: ControlModules, icontrolmodule: IControlModule, index: i32) -> (ok: bool) {
    if controlmodules == nil do return
    if icontrolmodule == nil do return
    if !com_connected() do return
    
    hr := (^ExternalVariablesIF)(controlmodules)->AddBefore(icontrolmodule, index)
    if com_failed(hr) do return

    return true
}

controlmodules_controlmodule_add :: proc(controlmodules: ControlModules, name, type_name: string, controlmodule: ControlModule) -> (ok: bool) {
    if controlmodules == nil do return
    if controlmodule == nil do return
    if !com_connected() do return

    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := (^ControlModulesIF)(controlmodules)->AddControlModule(bstr_name, bstr_type_name, cast(^rawptr)controlmodule)
    if com_failed(hr) do return

    return true
}

controlmodules_singlecontrolmodule_add :: proc(controlmodules: ControlModules, name: string, singlecontrolmoduleinst: SingleControlModuleInst) -> (ok: bool) {
    if controlmodules == nil do return
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->AddSingleControlModuleInst(bstr_name, cast(^rawptr)singlecontrolmoduleinst)
    if com_failed(hr) do return

    return true
}

controlmodules_controlmodule_by_name :: proc(controlmodules: ControlModules, name: string) -> (icontrolmodule: IControlModule, ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->Find(bstr_name, cast(^rawptr)&icontrolmodule)
    if com_failed(hr) do return
    
    return icontrolmodule, true
}

controlmodules_controlmodule_by_index :: proc(controlmodules: ControlModules, index: i32) -> (icontrolmodule: IControlModule, ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Item(index + 1, cast(^rawptr)&icontrolmodule)
    if com_failed(hr) do return
    
    return icontrolmodule, true
}

controlmodules_controlmodule_index :: proc(controlmodules: ControlModules, name: string) -> (index: i32, ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

controlmodules_controlmodule_count :: proc(controlmodules: ControlModules) -> (count: i32, ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

controlmodules_controlmodule_remove_by_name :: proc(controlmodules: ControlModules, name: string) -> (ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return

    index: i32
    index, ok = controlmodules_controlmodule_index(controlmodules, name)
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

controlmodules_controlmodule_remove_by_index :: proc(controlmodules: ControlModules, index: i32) -> (ok: bool) {
    if controlmodules == nil do return
    if !com_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

controlmodules_release :: proc(controlmodules: ControlModules) {
    if controlmodules != nil {
        (^ControlModulesIF)(controlmodules)->Release()
    }
}

ControlModuleTypeIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModuleTypeVTable,
}

ControlModuleTypeVTable :: struct {
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
    InstantiateAsAspectObjectGet: proc "system" (this: ^ControlModuleTypeIF, InstantiateAsAspectObject: ^VariantBool) -> HResult,
    InstantiateAsAspectObjectPut: proc "system" (this: ^ControlModuleTypeIF, InstantiateAsAspectObject: VariantBool) -> HResult,
    EmbeddedGraphicsVisibleGet:   proc "system" (this: ^ControlModuleTypeIF, EmbeddedGraphicsVisible: ^VariantBool) -> HResult,
    EmbeddedGraphicsVisiblePut:   proc "system" (this: ^ControlModuleTypeIF, EmbeddedGraphicsVisible: VariantBool) -> HResult,
    RestrictedSILGet:             proc "system" (this: ^ControlModuleTypeIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:             proc "system" (this: ^ControlModuleTypeIF, RestrictedSIL: VariantBool) -> HResult,
}

controlmoduletype_serialize :: proc(controlmoduletype: ControlModuleType) -> (xml: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_name_get :: proc(controlmoduletype: ControlModuleType) -> (name: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_name_set :: proc(controlmoduletype: ControlModuleType, name: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_protected_get :: proc(controlmoduletype: ControlModuleType) -> (protected: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_protected_set :: proc(controlmoduletype: ControlModuleType, protected: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

controlmoduletype_hidden_get :: proc(controlmoduletype: ControlModuleType) -> (hidden: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_hidden_set :: proc(controlmoduletype: ControlModuleType, hidden: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

controlmoduletype_scope_get :: proc(controlmoduletype: ControlModuleType) -> (scope: t.Scope, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    s: i32
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ScopeGet(&s)
    if com_failed(hr) do return

    return t.Scope(s), true
}

controlmoduletype_scope_set :: proc(controlmoduletype: ControlModuleType, scope: t.Scope) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ScopePut(i32(scope))
    if com_failed(hr) do return

    return true
}

controlmoduletype_interaction_window_get :: proc(controlmoduletype: ControlModuleType) -> (interaction_window: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InteractionWindowGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_interaction_window_set :: proc(controlmoduletype: ControlModuleType, interaction_window: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(interaction_window)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InteractionWindowPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_alarm_owner_get :: proc(controlmoduletype: ControlModuleType) -> (alarm_owner: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_alarm_owner_set :: proc(controlmoduletype: ControlModuleType, alarm_owner: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

controlmoduletype_guid_get :: proc(controlmoduletype: ControlModuleType) -> (guid: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_guid_set :: proc(controlmoduletype: ControlModuleType, guid: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_batch_object_get :: proc(controlmoduletype: ControlModuleType) -> (batch_object: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_batch_object_set :: proc(controlmoduletype: ControlModuleType, batch_object: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(batch_object)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->BatchObjectPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_sil_level_get :: proc(controlmoduletype: ControlModuleType) -> (sil_level: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_sil_level_set :: proc(controlmoduletype: ControlModuleType, sil_level: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_simulation_mark_get :: proc(controlmoduletype: ControlModuleType) -> (simulation_mark: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_simulation_mark_set :: proc(controlmoduletype: ControlModuleType, simulation_mark: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

controlmoduletype_reserved_by_function_get :: proc(controlmoduletype: ControlModuleType) -> (reserved_by_function: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_reserved_by_function_set :: proc(controlmoduletype: ControlModuleType, reserved_by_function: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_description_get :: proc(controlmoduletype: ControlModuleType) -> (description: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_description_set :: proc(controlmoduletype: ControlModuleType, description: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_cmgraphics_get :: proc(controlmoduletype: ControlModuleType) -> (cmgraphics: string, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMTypeGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_cmgraphics_set :: proc(controlmoduletype: ControlModuleType, cmgraphics: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    bs := to_bstr(cmgraphics)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMTypeGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_cmparameters_get :: proc(controlmoduletype: ControlModuleType) -> (cmparameters: CMParameters, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMParametersGet(&p)
    if com_failed(hr) do return

    return CMParameters(p), true
}

controlmoduletype_cmparameters_set :: proc(controlmoduletype: ControlModuleType, cmparameters: CMParameters) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMParametersPut(cmparameters)
    if com_failed(hr) do return

    return true
}

controlmoduletype_variables_get :: proc(controlmoduletype: ControlModuleType) -> (variables: Variables, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

controlmoduletype_variables_set :: proc(controlmoduletype: ControlModuleType, variables: Variables) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

controlmoduletype_externalvariables_get :: proc(controlmoduletype: ControlModuleType) -> (externalvariables: ExternalVariables, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ExternalVariablesGet(&p)
    if com_failed(hr) do return

    return ExternalVariables(p), true
}

controlmoduletype_externalvariables_set :: proc(controlmoduletype: ControlModuleType, externalvariables: ExternalVariables) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ExternalVariablesPut(externalvariables)
    if com_failed(hr) do return

    return true
}

controlmoduletype_functionblocks_get :: proc(controlmoduletype: ControlModuleType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

controlmoduletype_functionblocks_set :: proc(controlmoduletype: ControlModuleType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

controlmoduletype_controlmodules_get :: proc(controlmoduletype: ControlModuleType) -> (controlmodules: ControlModules, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

controlmoduletype_controlmodules_set :: proc(controlmoduletype: ControlModuleType, controlmodules: ControlModules) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

controlmoduletype_codeblocks_get :: proc(controlmoduletype: ControlModuleType) -> (codeblocks: CodeBlocks, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

controlmoduletype_codeblocks_set :: proc(controlmoduletype: ControlModuleType, codeblocks: CodeBlocks) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

controlmoduletype_graphsize_get :: proc(controlmoduletype: ControlModuleType) -> (graphsize: GraphSize, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GraphSizeGet(&p)
    if com_failed(hr) do return

    return GraphSize(p), true
}

controlmoduletype_graphsize_set :: proc(controlmoduletype: ControlModuleType, graphsize: GraphSize) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GraphSizePut(graphsize)
    if com_failed(hr) do return

    return true
}

controlmoduletype_instantiate_as_aspect_object_get :: proc(controlmoduletype: ControlModuleType) -> (instantiate_as_aspect_object: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InstantiateAsAspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_instantiate_as_aspect_object_set :: proc(controlmoduletype: ControlModuleType, instantiate_as_aspect_object: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InstantiateAsAspectObjectPut(to_variantbool(instantiate_as_aspect_object))
    if com_failed(hr) do return

    return true
}

controlmoduletype_embedded_graphiscs_visible_get :: proc(controlmoduletype: ControlModuleType) -> (embedded_graphiscs_visible: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->EmbeddedGraphicsVisibleGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_embedded_graphiscs_visible_set :: proc(controlmoduletype: ControlModuleType, embedded_graphiscs_visible: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->EmbeddedGraphicsVisiblePut(to_variantbool(embedded_graphiscs_visible))
    if com_failed(hr) do return

    return true
}

controlmoduletype_restricted_sil_get :: proc(controlmoduletype: ControlModuleType) -> (restricted_sil: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_restricted_sil_set :: proc(controlmoduletype: ControlModuleType, restricted_sil: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

controlmoduletype_release :: proc(controlmoduletype: ControlModuleType) {
    if controlmoduletype != nil {
        (^ControlModuleTypeIF)(controlmoduletype)->Release()
    }
}

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

singlecontrolmoduletype_serialize :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (xml: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_name_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (name: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_name_set :: proc(singlecontrolmoduletype: SingleControlModuleType, name: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_interaction_window_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (interaction_window: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InteractionWindowGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_interaction_window_set :: proc(singlecontrolmoduletype: SingleControlModuleType, interaction_window: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(interaction_window)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InteractionWindowPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_alarm_owner_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (alarm_owner: bool, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduletype_alarm_owner_set :: proc(singlecontrolmoduletype: SingleControlModuleType, alarm_owner: bool) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_type_guid_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (type_guid: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_type_guid_set :: proc(singlecontrolmoduletype: SingleControlModuleType, type_guid: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_batch_object_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (batch_object: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_batch_object_set :: proc(singlecontrolmoduletype: SingleControlModuleType, batch_object: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(batch_object)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->BatchObjectPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_sil_level_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (sil_level: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_sil_level_set :: proc(singlecontrolmoduletype: SingleControlModuleType, sil_level: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_simulation_mark_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (simulation_mark: bool, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduletype_simulation_mark_set :: proc(singlecontrolmoduletype: SingleControlModuleType, simulation_mark: bool) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_reserved_by_function_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (reserved_by_function: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_reserved_by_function_set :: proc(singlecontrolmoduletype: SingleControlModuleType, reserved_by_function: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_description_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (description: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_description_set :: proc(singlecontrolmoduletype: SingleControlModuleType, description: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_cmgraphics_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (cmgraphics: string, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMTypeGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduletype_cmgraphics_set :: proc(singlecontrolmoduletype: SingleControlModuleType, cmgraphics: string) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    bs := to_bstr(cmgraphics)
    defer bstr_free(bs)
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMTypeGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_cmparameters_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (cmparameters: CMParameters, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMParametersGet(&p)
    if com_failed(hr) do return

    return CMParameters(p), true
}

singlecontrolmoduletype_cmparameters_set :: proc(singlecontrolmoduletype: SingleControlModuleType, cmparameters: CMParameters) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CMParametersPut(cmparameters)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_variables_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (variables: Variables, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

singlecontrolmoduletype_variables_set :: proc(singlecontrolmoduletype: SingleControlModuleType, variables: Variables) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_externalvariables_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (externalvariables: ExternalVariables, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ExternalVariablesGet(&p)
    if com_failed(hr) do return

    return ExternalVariables(p), true
}

singlecontrolmoduletype_externalvariables_set :: proc(singlecontrolmoduletype: SingleControlModuleType, externalvariables: ExternalVariables) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ExternalVariablesPut(externalvariables)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_functionblocks_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

singlecontrolmoduletype_functionblocks_set :: proc(singlecontrolmoduletype: SingleControlModuleType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_controlmodules_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (controlmodules: ControlModules, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

singlecontrolmoduletype_controlmodules_set :: proc(singlecontrolmoduletype: SingleControlModuleType, controlmodules: ControlModules) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_codeblocks_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (codeblocks: CodeBlocks, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

singlecontrolmoduletype_codeblocks_set :: proc(singlecontrolmoduletype: SingleControlModuleType, codeblocks: CodeBlocks) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_graphsize_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (graphsize: GraphSize, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->GraphSizeGet(&p)
    if com_failed(hr) do return

    return GraphSize(p), true
}

singlecontrolmoduletype_graphsize_set :: proc(singlecontrolmoduletype: SingleControlModuleType, graphsize: GraphSize) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->GraphSizePut(graphsize)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_restricted_sil_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (restricted_sil: bool, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduletype_restricted_sil_set :: proc(singlecontrolmoduletype: SingleControlModuleType, restricted_sil: bool) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_commvariables_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (commvariables: CommVariables, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CommVariablesGet(&p)
    if com_failed(hr) do return

    return CommVariables(p), true
}

singlecontrolmoduletype_commvariables_set :: proc(singlecontrolmoduletype: SingleControlModuleType, commvariables: CommVariables) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->CommVariablesPut(commvariables)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_initvalues_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (initvalues: InitValues, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InitValuesGet(&p)
    if com_failed(hr) do return

    return InitValues(p), true
}

singlecontrolmoduletype_initvalues_set :: proc(singlecontrolmoduletype: SingleControlModuleType, initvalues: InitValues) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->InitValuesPut(initvalues)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_signals_get :: proc(singlecontrolmoduletype: SingleControlModuleType) -> (signals: Signals, ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SignalsGet(&p)
    if com_failed(hr) do return

    return Signals(p), true
}

singlecontrolmoduletype_signals_set :: proc(singlecontrolmoduletype: SingleControlModuleType, signals: Signals) -> (ok: bool) {
    if singlecontrolmoduletype == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->SignalsPut(signals)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduletype_release :: proc(singlecontrolmoduletype: SingleControlModuleType) {
    if singlecontrolmoduletype != nil {
        (^SingleControlModuleTypeIF)(singlecontrolmoduletype)->Release()
    }
}

SingleControlModuleInstIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^SingleControlModuleInstVTable,
}

SingleControlModuleInstVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:                     proc "system" (this: ^SingleControlModuleInstIF, name: ^BStr) -> HResult,
    NamePut:                     proc "system" (this: ^SingleControlModuleInstIF, name: BStr) -> HResult,
    TaskConnectionGet:           proc "system" (this: ^SingleControlModuleInstIF, TaskConnection: ^BStr) -> HResult,
    TaskConnectionPut:           proc "system" (this: ^SingleControlModuleInstIF, TaskConnection: BStr) -> HResult,
    VisibilityinGraphicsGet:     proc "system" (this: ^SingleControlModuleInstIF, Visibility: ^VariantBool) -> HResult,
    VisibilityinGraphicsPut:     proc "system" (this: ^SingleControlModuleInstIF, Visibility: VariantBool) -> HResult,
    TypeGuidGet:                 proc "system" (this: ^SingleControlModuleInstIF, TypeGuid: ^BStr) -> HResult,
    TypeGuidPut:                 proc "system" (this: ^SingleControlModuleInstIF, TypeGuid: BStr) -> HResult,
    InstGuidGet:                 proc "system" (this: ^SingleControlModuleInstIF, InstGuid: ^BStr) -> HResult,
    InstGuidPut:                 proc "system" (this: ^SingleControlModuleInstIF, InstGuid: BStr) -> HResult,
    DescriptionGet:              proc "system" (this: ^SingleControlModuleInstIF, Description: ^BStr) -> HResult,
    DescriptionPut:              proc "system" (this: ^SingleControlModuleInstIF, Description: BStr) -> HResult,
    CMConnectionsGet:            proc "system" (this: ^SingleControlModuleInstIF, CMConnections: ^rawptr) -> HResult,
    Missing20:                   proc "system" (this: ^SingleControlModuleInstIF) -> HResult,
    CMConnectionsPut:            proc "system" (this: ^SingleControlModuleInstIF, CMConnections: rawptr) -> HResult,
    GraphPosGet:                 proc "system" (this: ^SingleControlModuleInstIF, GraphPos: ^rawptr) -> HResult,
    Missing23:                   proc "system" (this: ^SingleControlModuleInstIF) -> HResult,
    GraphPosPut:                 proc "system" (this: ^SingleControlModuleInstIF, GraphPos: rawptr) -> HResult,
    CMInstGraphicsGet:           proc "system" (this: ^SingleControlModuleInstIF, CMinstGraphics: ^BStr) -> HResult,
    CMInstGraphicsPut:           proc "system" (this: ^SingleControlModuleInstIF, CMinstGraphics: BStr) -> HResult,
    Missing27:                   proc "system" (this: ^SingleControlModuleInstIF) -> HResult,
    Missing28:                   proc "system" (this: ^SingleControlModuleInstIF) -> HResult,
    Missing29:                   proc "system" (this: ^SingleControlModuleInstIF) -> HResult,
    Serialize:                   proc "system" (this: ^SingleControlModuleInstIF, XML: ^BStr) -> HResult,
    AccessLevelGet:              proc "system" (this: ^SingleControlModuleInstIF, AccessLevel: ^BStr) -> HResult,
    AccessLevelPut:              proc "system" (this: ^SingleControlModuleInstIF, AccessLevel: BStr) -> HResult,
    SafetyTypeGet:               proc "system" (this: ^SingleControlModuleInstIF, X: ^BStr) -> HResult,
    SafetyTypePut:               proc "system" (this: ^SingleControlModuleInstIF, X: BStr) -> HResult,
}

singlecontrolmoduleinst_serialize :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (xml: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_name_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (name: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_name_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, name: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_task_connection_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (task_connection: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_task_connection_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, task_connection: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_visibility_in_graphics_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (visibility_in_graphics: bool, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->VisibilityinGraphicsGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduleinst_visibility_in_graphics_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, visibility_in_graphics: bool) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    vb := to_variantbool(visibility_in_graphics)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->VisibilityinGraphicsPut(vb)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_type_guid_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (type_guid: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_type_guid_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, type_guid: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_inst_guid_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (inst_guid: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->InstGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_inst_guid_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, inst_guid: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs := to_bstr(inst_guid)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->InstGuidPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_description_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (description: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_description_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, description: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_cmconnections_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (cmconnections: Parameters, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMConnectionsGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

singlecontrolmoduleinst_cmconnections_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, cmconnections: Parameters) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMConnectionsPut(cmconnections)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_graphpos_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (graphpos: GraphPos, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->GraphPosGet(&p)
    if com_failed(hr) do return

    return GraphPos(p), true
}

singlecontrolmoduleinst_graphpos_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, graphpos: GraphPos) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->GraphPosPut(graphpos)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_instance_graphics_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (instance_graphics: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMInstGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_instance_graphics_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, instance_graphics: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return
    
    bs := to_bstr(instance_graphics)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMInstGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_access_level_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (access_level: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

singlecontrolmoduleinst_access_level_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, access_level: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

singlecontrolmoduleinst_safety_type_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (safety_type: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

singlecontrolmoduleinst_safety_type_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, safety_type: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !com_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

singlecontrolmoduleinst_release :: proc(singlecontrolmoduleinst: SingleControlModuleInst) {
    if singlecontrolmoduleinst != nil {
        (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->Release()
    }
}

CMConnectionIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMConnectionVTable,
}

CMConnectionVTable :: struct {
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

cmconnection_serialize :: proc(cmconnection: CMConnection) -> (xml: string, ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmconnection_name_get :: proc(cmconnection: CMConnection) -> (name: string, ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

cmconnection_name_set :: proc(cmconnection: CMConnection, name: string) -> (ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

cmconnection_actual_parameter_get :: proc(cmconnection: CMConnection) -> (actual_parameter: string, ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

cmconnection_actual_parameter_set :: proc(cmconnection: CMConnection, actual_parameter: string) -> (ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return

    bs := to_bstr(actual_parameter)
    defer bstr_free(bs)
    hr := (^CMConnectionIF)(cmconnection)->ActualParameterPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmconnection_graphical_connection_get :: proc(cmconnection: CMConnection) -> (graphical_connection: bool, ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

cmconnection_graphical_connection_set :: proc(cmconnection: CMConnection, graphical_connection: bool) -> (ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return

    hr := (^CMConnectionIF)(cmconnection)->GraphicalConnectionPut(to_variantbool(graphical_connection))
    if com_failed(hr) do return
    
    return true
}

cmconnection_points_get :: proc(cmconnection: CMConnection) -> (points: Points, ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^CMConnectionIF)(cmconnection)->PointsGet(&p)
    if com_failed(hr) do return

    return Points(p), true
}

cmconnection_points_set :: proc(cmconnection: CMConnection, points: Points) -> (ok: bool) {
    if cmconnection == nil do return
    if !com_connected() do return

    hr := (^CMConnectionIF)(cmconnection)->PointsPut(points)
    if com_failed(hr) do return
    
    return true
}

cmconnection_release :: proc(cmconnection: CMConnection) {
    if cmconnection != nil {
        (^CMConnectionIF)(cmconnection)->Release()
    }
}

CMConnectionsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMConnectionsVTable,
}

CMConnectionsVTable :: struct {
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
cmconnections_cmconnection_add :: proc(cmconnections: CMConnections, cmconnection: CMConnection) -> (ok: bool) {
    if cmconnections == nil do return
    if cmconnection == nil do return
    if !com_connected() do return

    hr := (^CMConnectionsIF)(cmconnections)->Add(cmconnection)
    if com_failed(hr) do return

    return true
}

cmconnections_cmconnection_add_at_index :: proc(cmconnections: CMConnections, cmconnection: CMConnection, index: i32) -> (ok: bool) {
    if cmconnections == nil do return
    if cmconnection == nil do return
    if !com_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->AddBefore(cmconnection, index)
    if com_failed(hr) do return

    return true
}

cmconnections_cmconnection_by_name :: proc(cmconnections: CMConnections, name: string) -> (cmconnection: CMConnection, ok: bool) {
    if cmconnections == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->Find(bstr_name, cast(^rawptr)&cmconnection)
    if com_failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_by_index :: proc(cmconnections: CMConnections, index: i32) -> (cmconnection: CMConnection, ok: bool) {
    if cmconnections == nil do return
    if !com_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Item(index + 1, cast(^rawptr)&cmconnection)
    if com_failed(hr) do return
    
    return cmconnection, true
}

cmconnections_cmconnection_index :: proc(cmconnections: CMConnections, name: string) -> (index: i32, ok: bool) {
    if cmconnections == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CMConnectionsIF)(cmconnections)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

cmconnections_cmconnection_count :: proc(cmconnections: CMConnections) -> (count: i32, ok: bool) {
    if cmconnections == nil do return
    if !com_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

cmconnections_cmconnection_remove_by_name :: proc(cmconnections: CMConnections, name: string) -> (ok: bool) {
    if cmconnections == nil do return
    if !com_connected() do return

    index: i32
    index, ok = cmconnections_cmconnection_index(cmconnections, name)
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

cmconnections_cmconnection_remove_by_index :: proc(cmconnections: CMConnections, index: i32) -> (ok: bool) {
    if cmconnections == nil do return
    if !com_connected() do return
    
    hr := (^CMConnectionsIF)(cmconnections)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

cmconnections_release :: proc(cmconnections: CMConnections) {
    if cmconnections != nil {
        (^CMConnectionsIF)(cmconnections)->Release()
    }
}

CMParameterIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMParameterVTable,
}

CMParameterVTable :: struct {
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

cmparameter_serialize :: proc(cmparameter: CMParameter) -> (xml: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_name_get :: proc(cmparameter: CMParameter) -> (name: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

cmparameter_name_set :: proc(cmparameter: CMParameter, name: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_type_name_get :: proc(cmparameter: CMParameter) -> (type_name: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

cmparameter_type_name_set :: proc(cmparameter: CMParameter, type_name: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_initial_value_get :: proc(cmparameter: CMParameter) -> (inital_value: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_initial_value_set :: proc(cmparameter: CMParameter, inital_value: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_description_get :: proc(cmparameter: CMParameter) -> (description: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_description_set :: proc(cmparameter: CMParameter, description: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_read_permission_get :: proc(cmparameter: CMParameter) -> (read_permission: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_read_permission_set :: proc(cmparameter: CMParameter, read_permission: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_write_permission_get :: proc(cmparameter: CMParameter) -> (write_permission: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_write_permission_set :: proc(cmparameter: CMParameter, write_permission: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(write_permission)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->WritePermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_authentication_level_get :: proc(cmparameter: CMParameter) -> (authentication_level: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_authentication_level_set :: proc(cmparameter: CMParameter, authentication_level: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(authentication_level)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AuthenticationLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_batch_property_get :: proc(cmparameter: CMParameter) -> (batch_property: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->BatchPropertyGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_batch_property_set :: proc(cmparameter: CMParameter, batch_property: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(batch_property)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->BatchPropertyPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_auto_point_get :: proc(cmparameter: CMParameter) -> (auto_point: AutoPoint, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointGet(cast(^rawptr)&auto_point)
    if com_failed(hr) do return
    
    return auto_point, true
}

cmparameter_auto_point_set :: proc(cmparameter: CMParameter, auto_point: AutoPoint) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->AutoPointPut(auto_point)
    if com_failed(hr) do return
    
    return true
}

cmparameter_graph_nodes_get :: proc(cmparameter: CMParameter) -> (graph_nodes: GraphNodes, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesGet(cast(^rawptr)&graph_nodes)
    if com_failed(hr) do return
    
    return graph_nodes, true
}

cmparameter_graph_nodes_set :: proc(cmparameter: CMParameter, graph_nodes: GraphNodes) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    hr := (^CMParameterIF)(cmparameter)->GraphNodesPut(graph_nodes)
    if com_failed(hr) do return
    
    return true
}

cmparameter_type_guid_get :: proc(cmparameter: CMParameter) -> (guid: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_type_path_get :: proc(cmparameter: CMParameter) -> (path: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_access_level_get :: proc(cmparameter: CMParameter) -> (access_level: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_access_level_set :: proc(cmparameter: CMParameter, access_level: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_safety_type_get :: proc(cmparameter: CMParameter) -> (safety_type: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_safety_type_set :: proc(cmparameter: CMParameter, safety_type: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_direction_get :: proc(cmparameter: CMParameter) -> (direction: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_direction_set :: proc(cmparameter: CMParameter, direction: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(direction)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->DirectionPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_fdport_get :: proc(cmparameter: CMParameter) -> (fdport: string, ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

cmparameter_fdport_set :: proc(cmparameter: CMParameter, fdport: string) -> (ok: bool) {
    if cmparameter == nil do return
    if !com_connected() do return
    
    bs := to_bstr(fdport)
    defer bstr_free(bs)
    hr := (^CMParameterIF)(cmparameter)->FDPortPut(bs)
    if com_failed(hr) do return
    
    return true
}

cmparameter_release :: proc(cmparameter: CMParameter) {
    if cmparameter != nil {
        (^CMParameterIF)(cmparameter)->Release()
    }
}

CMParametersIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CMParametersVTable,
}

CMParametersVTable :: struct {
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

cmparameters_cmparameter_add :: proc(cmparameters: CMParameters, cmparameter: CMParameter) -> (ok: bool) {
    if cmparameters == nil do return
    if cmparameter == nil do return
    if !com_connected() do return

    hr := (^CMParametersIF)(cmparameters)->Add(cmparameter)
    if com_failed(hr) do return

    return true
}

cmparameters_cmparameter_add_at_index :: proc(cmparameters: CMParameters, cmparameter: CMParameter, index: i32) -> (ok: bool) {
    if cmparameters == nil do return
    if cmparameter == nil do return
    if !com_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->AddBefore(cmparameter, index)
    if com_failed(hr) do return

    return true
}

cmparameters_cmparameter_by_name :: proc(cmparameters: CMParameters, name: string) -> (cmparameter: CMParameter, ok: bool) {
    if cmparameters == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->Find(bstr_name, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_by_index :: proc(cmparameters: CMParameters, index: i32) -> (cmparameter: CMParameter, ok: bool) {
    if cmparameters == nil do return
    if !com_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Item(index + 1, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

cmparameters_cmparameter_index :: proc(cmparameters: CMParameters, name: string) -> (index: i32, ok: bool) {
    if cmparameters == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CMParametersIF)(cmparameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

cmparameters_cmparameter_count :: proc(cmparameters: CMParameters) -> (count: i32, ok: bool) {
    if cmparameters == nil do return
    if !com_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

cmparameters_cmparameter_remove_by_name :: proc(cmparameters: CMParameters, name: string) -> (ok: bool) {
    if cmparameters == nil do return
    if !com_connected() do return

    index: i32
    index, ok = cmparameters_cmparameter_index(cmparameters, name)
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

cmparameters_cmparameter_remove_by_index :: proc(cmparameters: CMParameters, index: i32) -> (ok: bool) {
    if cmparameters == nil do return
    if !com_connected() do return
    
    hr := (^CMParametersIF)(cmparameters)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

cmparameters_release :: proc(cmparameters: CMParameters) {
    if cmparameters != nil {
        (^CMParametersIF)(cmparameters)->Release()
    }
}
