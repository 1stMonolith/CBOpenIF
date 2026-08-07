package cbopenif

ControlModule :: distinct rawptr

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
