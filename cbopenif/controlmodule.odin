package cbopenif

ControlModule     :: distinct rawptr
ControlModules    :: distinct rawptr
ControlModuleType :: distinct rawptr

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

controlmodule_new :: proc (name, type_name: string) -> (controlmodule: ControlModule, ok: bool) {
    if !controlbuilder_connect() do return

    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := factoryif->NewControlModule(bstr_name, bstr_type_name, cast(^rawptr)controlmodule)
    if com_failed(hr) do return

    return controlmodule, true
}

controlmodule_deserialize :: proc(xml: string) -> (controlmodule: ControlModule, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeControlModule(&bs, cast(^rawptr)controlmodule)
    if com_failed(hr) do return

    return controlmodule, true
}

controlmodule_serialize :: proc(controlmodule: ControlModule) -> (xml: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_name :: proc {
    controlmodule_name_get,
    controlmodule_name_set,
}

controlmodule_name_get :: proc(controlmodule: ControlModule) -> (name: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_name_set :: proc(controlmodule: ControlModule, name: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_type_name :: proc {
    controlmodule_type_name_get,
    controlmodule_type_name_set,
}

controlmodule_type_name_get :: proc(controlmodule: ControlModule) -> (type_name: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeNameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_type_name_set :: proc(controlmodule: ControlModule, type_name: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

controlmodule_task_connection :: proc {
    controlmodule_task_connection_get,
    controlmodule_task_connection_set,
}

controlmodule_task_connection_get :: proc(controlmodule: ControlModule) -> (task_connection: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_task_connection_set :: proc(controlmodule: ControlModule, task_connection: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_visibility_in_graphics :: proc {
    controlmodule_visibility_in_graphics_get,
    controlmodule_visibility_in_graphics_set,
}

controlmodule_visibility_in_graphics_get :: proc(controlmodule: ControlModule) -> (visibility_in_graphics: bool, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmodule_visibility_in_graphics_set :: proc(controlmodule: ControlModule, visibility_in_graphics: bool) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    vb := to_variantbool(visibility_in_graphics)
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentPut(vb)
    if com_failed(hr) do return

    return true
}

controlmodule_guid :: proc {
    controlmodule_guid_get,
    controlmodule_guid_set,
}

controlmodule_guid_get :: proc(controlmodule: ControlModule) -> (guid: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_guid_set :: proc(controlmodule: ControlModule, guid: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_description :: proc {
    controlmodule_description_get,
    controlmodule_description_set,
}

controlmodule_description_get :: proc(controlmodule: ControlModule) -> (description: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_description_set :: proc(controlmodule: ControlModule, description: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_cmconnections :: proc {
    controlmodule_cmconnections_get,
    controlmodule_cmconnections_set,
}

controlmodule_cmconnections_get :: proc(controlmodule: ControlModule) -> (cmconnections: Parameters, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleIF)(controlmodule)->CMConnectionsGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

controlmodule_cmconnections_set :: proc(controlmodule: ControlModule, cmconnections: Parameters) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->CMConnectionsPut(cmconnections)
    if com_failed(hr) do return

    return true
}

controlmodule_graphpos :: proc {
    controlmodule_graphpos_get,
    controlmodule_graphpos_set,
}

controlmodule_graphpos_get :: proc(controlmodule: ControlModule) -> (graphpos: GraphPos, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleIF)(controlmodule)->GraphPosGet(&p)
    if com_failed(hr) do return

    return GraphPos(p), true
}

controlmodule_graphpos_set :: proc(controlmodule: ControlModule, graphpos: GraphPos) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->GraphPosPut(graphpos)
    if com_failed(hr) do return

    return true
}

controlmodule_instance_graphics :: proc {
    controlmodule_instance_graphics_get,
    controlmodule_instance_graphics_set,
}

controlmodule_instance_graphics_get :: proc(controlmodule: ControlModule) -> (instance_graphics: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->CMInstGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodule_instance_graphics_set :: proc(controlmodule: ControlModule, instance_graphics: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(instance_graphics)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->CMInstGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

controlmodule_type_guid_get :: proc(controlmodule: ControlModule) -> (type_guid: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypeGuidGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_type_path_get :: proc(controlmodule: ControlModule) -> (type_path: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->TypePathGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_aspect_object :: proc {
    controlmodule_aspect_object_get,
    controlmodule_aspect_object_set,
}

controlmodule_aspect_object_get :: proc(controlmodule: ControlModule) -> (aspect_object: bool, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->AspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmodule_aspect_object_set :: proc(controlmodule: ControlModule, aspect_object: bool) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleIF)(controlmodule)->AspectObjectPut(to_variantbool(aspect_object))
    if com_failed(hr) do return

    return true
}

controlmodule_access_level :: proc {
    controlmodule_access_level_get,
    controlmodule_access_level_set,
}

controlmodule_access_level_get :: proc(controlmodule: ControlModule) -> (access_level: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_access_level_set :: proc(controlmodule: ControlModule, access_level: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

controlmodule_safety_type :: proc {
    controlmodule_safety_type_get,
    controlmodule_safety_type_set,
}

controlmodule_safety_type_get :: proc(controlmodule: ControlModule) -> (safety_type: string, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

controlmodule_safety_type_set :: proc(controlmodule: ControlModule, safety_type: string) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(safety_type)
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodule)->SafetyTypePut(bs)
    if com_failed(hr) do return
    
    return true
}

controlmodule_expose_properties_in_parent :: proc {
    controlmodule_expose_properties_in_parent_get,
    controlmodule_expose_properties_in_parent_set,
}

controlmodule_expose_properties_in_parent_get :: proc(controlmodule: ControlModule) -> (expose_properties_in_parent: bool, ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleIF)(controlmodule)->ExposePropertiesinParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmodule_expose_properties_in_parent_set :: proc(controlmodule: ControlModule, expose_properties_in_parent: bool) -> (ok: bool) {
    if controlmodule == nil do return
    if !controlbuilder_connected() do return
    
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

controlmodules_new :: proc() -> (controlmodules: ControlModules, ok: bool) {
    if !controlbuilder_connect() do return

    hr := factoryif->NewControlModules(cast(^rawptr)&controlmodules)
    if com_failed(hr) do return

    return controlmodules, true
}

controlmodules_serialize :: proc(controlmodules: ControlModules) -> (xml: string, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodules)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodules_deserialize :: proc(xml: string) -> (controlmodules: ControlModules, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeControlModules(&bs, cast(^rawptr)controlmodules)
    if com_failed(hr) do return
    
    return controlmodules, true
}

controlmodules_controlmodule_add :: proc {
    controlmodules_icontrolmodule_add,
    controlmodules_icontrolmodule_add_at_index,
    controlmodules_controlmodule_add_,
    controlmodules_singlecontrolmodule_add,
}

controlmodules_icontrolmodule_add :: proc(controlmodules: ControlModules, icontrolmodule: IControlModule) -> (ok: bool) {
    if controlmodules == nil do return
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExternalVariablesIF)(controlmodules)->Add(icontrolmodule)
    if com_failed(hr) do return

    return true
}

controlmodules_icontrolmodule_add_at_index :: proc(controlmodules: ControlModules, icontrolmodule: IControlModule, index: i32) -> (ok: bool) {
    if controlmodules == nil do return
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(controlmodules)->AddBefore(icontrolmodule, index)
    if com_failed(hr) do return

    return true
}

controlmodules_controlmodule_add_ :: proc(controlmodules: ControlModules, name, type_name: string, controlmodule: ControlModule) -> (ok: bool) {
    if controlmodules == nil do return
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

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
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->AddSingleControlModuleInst(bstr_name, cast(^rawptr)singlecontrolmoduleinst)
    if com_failed(hr) do return

    return true
}

controlmodules_controlmodule :: proc {
    controlmodules_controlmodule_by_name,
    controlmodules_controlmodule_by_index,
}

controlmodules_controlmodule_by_name :: proc(controlmodules: ControlModules, name: string) -> (icontrolmodule: IControlModule, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->Find(bstr_name, cast(^rawptr)&icontrolmodule)
    if com_failed(hr) do return
    
    return icontrolmodule, true
}

controlmodules_controlmodule_by_index :: proc(controlmodules: ControlModules, index: i32) -> (icontrolmodule: IControlModule, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Item(index + 1, cast(^rawptr)&icontrolmodule)
    if com_failed(hr) do return
    
    return icontrolmodule, true
}

controlmodules_controlmodule_index :: proc(controlmodules: ControlModules, name: string) -> (index: i32, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

controlmodules_controlmodule_count :: proc(controlmodules: ControlModules) -> (count: i32, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

controlmodules_controlmodule_remove :: proc {
    controlmodules_controlmodule_remove_by_name,
    controlmodules_controlmodule_remove_by_index,
}

controlmodules_controlmodule_remove_by_name :: proc(controlmodules: ControlModules, name: string) -> (ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = controlmodules_controlmodule_index(controlmodules, name)
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

controlmodules_controlmodule_remove_by_index :: proc(controlmodules: ControlModules, index: i32) -> (ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
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

controlmoduletype_new :: proc (name: string, description := "") -> (controlmoduletype: ControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewControlModuleType(bstr_name, bstr_description, cast(^rawptr)&controlmoduletype)
    if com_failed(hr) do return
    
    return controlmoduletype, true
}

controlmoduletype_deserialize :: proc(xml: string) -> (controlmoduletype: ControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeControlModuleType(&bs, cast(^rawptr)controlmoduletype)
    if com_failed(hr) do return

    return controlmoduletype, true
}

controlmoduletype_serialize :: proc(controlmoduletype: ControlModuleType) -> (xml: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_name :: proc {
    controlmoduletype_name_get,
    controlmoduletype_name_set,
}

controlmoduletype_name_get :: proc(controlmoduletype: ControlModuleType) -> (name: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_name_set :: proc(controlmoduletype: ControlModuleType, name: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_protected :: proc {
    controlmoduletype_protected_get,
    controlmoduletype_protected_set,
}

controlmoduletype_protected_get :: proc(controlmoduletype: ControlModuleType) -> (protected: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ProtectedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_protected_set :: proc(controlmoduletype: ControlModuleType, protected: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ProtectedPut(to_variantbool(protected))
    if com_failed(hr) do return

    return true
}

controlmoduletype_hidden :: proc {
    controlmoduletype_hidden_get,
    controlmoduletype_hidden_set,
}

controlmoduletype_hidden_get :: proc(controlmoduletype: ControlModuleType) -> (hidden: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->HiddenGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_hidden_set :: proc(controlmoduletype: ControlModuleType, hidden: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->HiddenPut(to_variantbool(hidden))
    if com_failed(hr) do return

    return true
}

controlmoduletype_scope :: proc {
    controlmoduletype_scope_get,
    controlmoduletype_scope_set,
}

controlmoduletype_scope_get :: proc(controlmoduletype: ControlModuleType) -> (scope: ScopeType, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    s: i32
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ScopeGet(&s)
    if com_failed(hr) do return

    return ScopeType(s), true
}

controlmoduletype_scope_set :: proc(controlmoduletype: ControlModuleType, scope: ScopeType) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ScopePut(i32(scope))
    if com_failed(hr) do return

    return true
}

controlmoduletype_interaction_window :: proc {
    controlmoduletype_interaction_window_get,
    controlmoduletype_interaction_window_set,
}

controlmoduletype_interaction_window_get :: proc(controlmoduletype: ControlModuleType) -> (interaction_window: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InteractionWindowGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_interaction_window_set :: proc(controlmoduletype: ControlModuleType, interaction_window: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(interaction_window)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InteractionWindowPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_alarm_owner :: proc {
    controlmoduletype_alarm_owner_get,
    controlmoduletype_alarm_owner_set,
}

controlmoduletype_alarm_owner_get :: proc(controlmoduletype: ControlModuleType) -> (alarm_owner: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->AlarmOwnerGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_alarm_owner_set :: proc(controlmoduletype: ControlModuleType, alarm_owner: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->AlarmOwnerPut(to_variantbool(alarm_owner))
    if com_failed(hr) do return

    return true
}

controlmoduletype_guid :: proc {
    controlmoduletype_guid_get,
    controlmoduletype_guid_set,
}

controlmoduletype_guid_get :: proc(controlmoduletype: ControlModuleType) -> (guid: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_guid_set :: proc(controlmoduletype: ControlModuleType, guid: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_batch_object :: proc {
    controlmoduletype_batch_object_get,
    controlmoduletype_batch_object_set,
}

controlmoduletype_batch_object_get :: proc(controlmoduletype: ControlModuleType) -> (batch_object: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->BatchObjectGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_batch_object_set :: proc(controlmoduletype: ControlModuleType, batch_object: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(batch_object)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->BatchObjectPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_sil_level :: proc {
    controlmoduletype_sil_level_get,
    controlmoduletype_sil_level_set,
}

controlmoduletype_sil_level_get :: proc(controlmoduletype: ControlModuleType) -> (sil_level: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_sil_level_set :: proc(controlmoduletype: ControlModuleType, sil_level: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_simulation_mark :: proc {
    controlmoduletype_simulation_mark_get,
    controlmoduletype_simulation_mark_set,
}

controlmoduletype_simulation_mark_get :: proc(controlmoduletype: ControlModuleType) -> (simulation_mark: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_simulation_mark_set :: proc(controlmoduletype: ControlModuleType, simulation_mark: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

controlmoduletype_reserved_by_function :: proc {
    controlmoduletype_reserved_by_function_get,
    controlmoduletype_reserved_by_function_set,
}

controlmoduletype_reserved_by_function_get :: proc(controlmoduletype: ControlModuleType) -> (reserved_by_function: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_reserved_by_function_set :: proc(controlmoduletype: ControlModuleType, reserved_by_function: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_description :: proc {
    controlmoduletype_description_get,
    controlmoduletype_description_set,
}

controlmoduletype_description_get :: proc(controlmoduletype: ControlModuleType) -> (description: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_description_set :: proc(controlmoduletype: ControlModuleType, description: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_cmgraphics :: proc {
    controlmoduletype_cmgraphics_get,
    controlmoduletype_cmgraphics_set,
}

controlmoduletype_cmgraphics_get :: proc(controlmoduletype: ControlModuleType) -> (cmgraphics: string, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMTypeGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmoduletype_cmgraphics_set :: proc(controlmoduletype: ControlModuleType, cmgraphics: string) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(cmgraphics)
    defer bstr_free(bs)
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMTypeGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

controlmoduletype_cmparameters :: proc {
    controlmoduletype_cmparameters_get,
    controlmoduletype_cmparameters_set,
}

controlmoduletype_cmparameters_get :: proc(controlmoduletype: ControlModuleType) -> (cmparameters: CMParameters, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMParametersGet(&p)
    if com_failed(hr) do return

    return CMParameters(p), true
}

controlmoduletype_cmparameters_set :: proc(controlmoduletype: ControlModuleType, cmparameters: CMParameters) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CMParametersPut(cmparameters)
    if com_failed(hr) do return

    return true
}

controlmoduletype_variables :: proc {
    controlmoduletype_variables_get,
    controlmoduletype_variables_set,
}

controlmoduletype_variables_get :: proc(controlmoduletype: ControlModuleType) -> (variables: Variables, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->VariablesGet(&p)
    if com_failed(hr) do return

    return Variables(p), true
}

controlmoduletype_variables_set :: proc(controlmoduletype: ControlModuleType, variables: Variables) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->VariablesPut(variables)
    if com_failed(hr) do return

    return true
}

controlmoduletype_externalvariables :: proc {
    controlmoduletype_externalvariables_get,
    controlmoduletype_externalvariables_set,
}

controlmoduletype_externalvariables_get :: proc(controlmoduletype: ControlModuleType) -> (externalvariables: ExternalVariables, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ExternalVariablesGet(&p)
    if com_failed(hr) do return

    return ExternalVariables(p), true
}

controlmoduletype_externalvariables_set :: proc(controlmoduletype: ControlModuleType, externalvariables: ExternalVariables) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ExternalVariablesPut(externalvariables)
    if com_failed(hr) do return

    return true
}

controlmoduletype_functionblocks :: proc {
    controlmoduletype_functionblocks_get,
    controlmoduletype_functionblocks_set,
}

controlmoduletype_functionblocks_get :: proc(controlmoduletype: ControlModuleType) -> (functionblocks: FunctionBlocks, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->FunctionBlocksGet(&p)
    if com_failed(hr) do return

    return FunctionBlocks(p), true
}

controlmoduletype_functionblocks_set :: proc(controlmoduletype: ControlModuleType, functionblocks: FunctionBlocks) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->FunctionBlocksPut(functionblocks)
    if com_failed(hr) do return

    return true
}

controlmoduletype_controlmodules :: proc {
    controlmoduletype_controlmodules_get,
    controlmoduletype_controlmodules_set,
}

controlmoduletype_controlmodules_get :: proc(controlmoduletype: ControlModuleType) -> (controlmodules: ControlModules, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ControlModulesGet(&p)
    if com_failed(hr) do return

    return ControlModules(p), true
}

controlmoduletype_controlmodules_set :: proc(controlmoduletype: ControlModuleType, controlmodules: ControlModules) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->ControlModulesPut(controlmodules)
    if com_failed(hr) do return

    return true
}

controlmoduletype_codeblocks :: proc {
    controlmoduletype_codeblocks_get,
    controlmoduletype_codeblocks_set,
}

controlmoduletype_codeblocks_get :: proc(controlmoduletype: ControlModuleType) -> (codeblocks: CodeBlocks, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CodeBlocksGet(&p)
    if com_failed(hr) do return

    return CodeBlocks(p), true
}

controlmoduletype_codeblocks_set :: proc(controlmoduletype: ControlModuleType, codeblocks: CodeBlocks) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->CodeBlocksPut(codeblocks)
    if com_failed(hr) do return

    return true
}

controlmoduletype_graphsize :: proc {
    controlmoduletype_graphsize_get,
    controlmoduletype_graphsize_set,
}

controlmoduletype_graphsize_get :: proc(controlmoduletype: ControlModuleType) -> (graphsize: GraphSize, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GraphSizeGet(&p)
    if com_failed(hr) do return

    return GraphSize(p), true
}

controlmoduletype_graphsize_set :: proc(controlmoduletype: ControlModuleType, graphsize: GraphSize) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->GraphSizePut(graphsize)
    if com_failed(hr) do return

    return true
}

controlmoduletype_instantiate_as_aspect_object :: proc {
    controlmoduletype_instantiate_as_aspect_object_get,
    controlmoduletype_instantiate_as_aspect_object_set,
}

controlmoduletype_instantiate_as_aspect_object_get :: proc(controlmoduletype: ControlModuleType) -> (instantiate_as_aspect_object: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InstantiateAsAspectObjectGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_instantiate_as_aspect_object_set :: proc(controlmoduletype: ControlModuleType, instantiate_as_aspect_object: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->InstantiateAsAspectObjectPut(to_variantbool(instantiate_as_aspect_object))
    if com_failed(hr) do return

    return true
}

controlmoduletype_embedded_graphiscs_visible :: proc {
    controlmoduletype_embedded_graphiscs_visible_get,
    controlmoduletype_embedded_graphiscs_visible_set,
}

controlmoduletype_embedded_graphiscs_visible_get :: proc(controlmoduletype: ControlModuleType) -> (embedded_graphiscs_visible: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->EmbeddedGraphicsVisibleGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_embedded_graphiscs_visible_set :: proc(controlmoduletype: ControlModuleType, embedded_graphiscs_visible: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->EmbeddedGraphicsVisiblePut(to_variantbool(embedded_graphiscs_visible))
    if com_failed(hr) do return

    return true
}

controlmoduletype_restricted_sil :: proc {
    controlmoduletype_restricted_sil_get,
    controlmoduletype_restricted_sil_set,
}

controlmoduletype_restricted_sil_get :: proc(controlmoduletype: ControlModuleType) -> (restricted_sil: bool, ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^ControlModuleTypeIF)(controlmoduletype)->RestrictedSILGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

controlmoduletype_restricted_sil_set :: proc(controlmoduletype: ControlModuleType, restricted_sil: bool) -> (ok: bool) {
    if controlmoduletype == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModuleTypeIF)(controlmoduletype)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return

    return true
}

controlmoduletype_release :: proc(controlmoduletype: ControlModuleType) {
    if controlmoduletype != nil {
        (^ControlModuleTypeIF)(controlmoduletype)->Release()
    }
}
