package cbopenif

SingleControlModuleInst :: distinct rawptr

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

singlecontrolmoduleinst_new :: proc (name) -> (singlecontrolmoduleinst: SingleControlModuleInst, ok: bool) {
    if !controlbuilder_connect() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := factoryif->NewSingleControlModuleInst(bstr_name, cast(^rawptr)singlecontrolmoduleinst)
    if com_failed(hr) do return

    return singlecontrolmoduleinst, true
}

singlecontrolmoduleinst_deserialize :: proc(xml: string) -> (singlecontrolmoduleinst: SingleControlModuleInst, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeSingleControlModuleInst(&bs, cast(^rawptr)singlecontrolmoduleinst)
    if com_failed(hr) do return

    return singlecontrolmoduleinst, true
}

singlecontrolmoduleinst_serialize :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (xml: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_name :: proc {
    singlecontrolmoduleinst_name_get,
    singlecontrolmoduleinst_name_set,
}

singlecontrolmoduleinst_name_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (name: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_name_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, name: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_task_connection :: proc {
    singlecontrolmoduleinst_task_connection_get,
    singlecontrolmoduleinst_task_connection_set,
}

singlecontrolmoduleinst_task_connection_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (task_connection: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TaskConnectionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_task_connection_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, task_connection: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(task_connection)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TaskConnectionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_visibility_in_graphics :: proc {
    singlecontrolmoduleinst_visibility_in_graphics_get,
    singlecontrolmoduleinst_visibility_in_graphics_set,
}

singlecontrolmoduleinst_visibility_in_graphics_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (visibility_in_graphics: bool, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->ExposePropertiesinParentGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

singlecontrolmoduleinst_visibility_in_graphics_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, visibility_in_graphics: bool) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    vb := to_variantbool(visibility_in_graphics)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->ExposePropertiesinParentPut(vb)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_type_guid :: proc {
    singlecontrolmoduleinst_type_guid_get,
    singlecontrolmoduleinst_type_guid_set,
}

singlecontrolmoduleinst_type_guid_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (type_guid: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_type_guid_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, type_guid: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_inst_guid :: proc {
    singlecontrolmoduleinst_inst_guid_get,
    singlecontrolmoduleinst_inst_guid_set,
}

singlecontrolmoduleinst_inst_guid_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (inst_guid: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->InstGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_inst_guid_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, inst_guid: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(inst_guid)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->InstGuidPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_description :: proc {
    singlecontrolmoduleinst_description_get,
    singlecontrolmoduleinst_description_set,
}

singlecontrolmoduleinst_description_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (description: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_description_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, description: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->DescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_cmconnections :: proc {
    singlecontrolmoduleinst_cmconnections_get,
    singlecontrolmoduleinst_cmconnections_set,
}

singlecontrolmoduleinst_cmconnections_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (cmconnections: Parameters, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMConnectionsGet(&p)
    if com_failed(hr) do return

    return Parameters(p), true
}

singlecontrolmoduleinst_cmconnections_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, cmconnections: Parameters) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMConnectionsPut(cmconnections)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_graphpos :: proc {
    singlecontrolmoduleinst_graphpos_get,
    singlecontrolmoduleinst_graphpos_set,
}

singlecontrolmoduleinst_graphpos_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (graphpos: GraphPos, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    p: rawptr
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->GraphPosGet(&p)
    if com_failed(hr) do return

    return GraphPos(p), true
}

singlecontrolmoduleinst_graphpos_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, graphpos: GraphPos) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->GraphPosPut(graphpos)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_instance_graphics :: proc {
    singlecontrolmoduleinst_instance_graphics_get,
    singlecontrolmoduleinst_instance_graphics_set,
}

singlecontrolmoduleinst_instance_graphics_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (instance_graphics: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMInstGraphicsGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

singlecontrolmoduleinst_instance_graphics_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, instance_graphics: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(instance_graphics)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->CMInstGraphicsPut(bs)
    if com_failed(hr) do return

    return true
}

singlecontrolmoduleinst_access_level :: proc {
    singlecontrolmoduleinst_access_level_get,
    singlecontrolmoduleinst_access_level_set,
}

singlecontrolmoduleinst_access_level_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (access_level: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->AccessLevelGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

singlecontrolmoduleinst_access_level_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, access_level: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(access_level)
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->AccessLevelPut(bs)
    if com_failed(hr) do return
    
    return true
}

singlecontrolmoduleinst_safety_type :: proc {
    singlecontrolmoduleinst_safety_type_get,
    singlecontrolmoduleinst_safety_type_set,
}

singlecontrolmoduleinst_safety_type_get :: proc(singlecontrolmoduleinst: SingleControlModuleInst) -> (safety_type: string, ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^SingleControlModuleInstIF)(singlecontrolmoduleinst)->SafetyTypeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

singlecontrolmoduleinst_safety_type_set :: proc(singlecontrolmoduleinst: SingleControlModuleInst, safety_type: string) -> (ok: bool) {
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return

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
