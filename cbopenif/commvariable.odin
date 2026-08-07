package cbopenif

CommVariable :: distinct rawptr

CommVariableIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CommVariableVTable,
}

CommVariableVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:             proc "system" (this: ^CommVariableIF, Name: ^BStr) -> HResult,
    NamePut:             proc "system" (this: ^CommVariableIF, Name: BStr) -> HResult,
    TypeNameGet:         proc "system" (this: ^CommVariableIF, TypeName: ^BStr) -> HResult,
    TypeNamePut:         proc "system" (this: ^CommVariableIF, TypeName: BStr) -> HResult,
    AttributeGet:        proc "system" (this: ^CommVariableIF, Attribute: ^BStr) -> HResult,
    AttributePut:        proc "system" (this: ^CommVariableIF, Attribute: BStr) -> HResult,
    InitialValueGet:     proc "system" (this: ^CommVariableIF, InitialValue: ^BStr) -> HResult,
    InitialValuePut:     proc "system" (this: ^CommVariableIF, InitialValue: BStr) -> HResult,
    DirectionGet:        proc "system" (this: ^CommVariableIF, Direction: ^BStr) -> HResult,
    DirectionPut:        proc "system" (this: ^CommVariableIF, Direction: BStr) -> HResult,
    IPAddressGet:        proc "system" (this: ^CommVariableIF, IPAddress: ^BStr) -> HResult,
    IPAddressPut:        proc "system" (this: ^CommVariableIF, IPAddress: BStr) -> HResult,
    IntervalTimeGet:     proc "system" (this: ^CommVariableIF, IntervalTime: ^BStr) -> HResult,
    IntervalTimePut:     proc "system" (this: ^CommVariableIF, IntervalTime: BStr) -> HResult,
    PriorityGet:         proc "system" (this: ^CommVariableIF, Priority: ^BStr) -> HResult,
    PriorityPut:         proc "system" (this: ^CommVariableIF, Priority: BStr) -> HResult,
    ISPValueGet:         proc "system" (this: ^CommVariableIF, ISPValue: ^BStr) -> HResult,
    ISPValuePut:         proc "system" (this: ^CommVariableIF, ISPValue: BStr) -> HResult,
    ReadPermissionGet:   proc "system" (this: ^CommVariableIF, ReadPermission: ^BStr) -> HResult,
    ReadPermissionPut:   proc "system" (this: ^CommVariableIF, ReadPermission: BStr) -> HResult,
    DescriptionGet:      proc "system" (this: ^CommVariableIF, Description: ^BStr) -> HResult,
    DescriptionPut:      proc "system" (this: ^CommVariableIF, Description: BStr) -> HResult,
    TypeGuid:            proc "system" (this: ^CommVariableIF, TypeGuid: ^BStr) -> HResult,
    TypePath:            proc "system" (this: ^CommVariableIF, TypePath: ^BStr) -> HResult,
    Serialize:           proc "system" (this: ^CommVariableIF, XML: ^BStr) -> HResult,
    ExpectedSILGet:      proc "system" (this: ^CommVariableIF, ExpectedSIL: ^BStr) -> HResult,
    ExpectedSILPut:      proc "system" (this: ^CommVariableIF, ExpectedSIL: BStr) -> HResult,
    UniqueIDGet:         proc "system" (this: ^CommVariableIF, UniqueID: ^i32) -> HResult,
    UniqueIDPut:         proc "system" (this: ^CommVariableIF, UniqueID: i32) -> HResult,
    RestrictedSILGet:    proc "system" (this: ^CommVariableIF, RestrictedSIL: ^VariantBool) -> HResult,
    RestrictedSILPut:    proc "system" (this: ^CommVariableIF, RestrictedSIL: VariantBool) -> HResult,
    AcknowledgeGroupGet: proc "system" (this: ^CommVariableIF, AcknowledgeGroup: ^BStr) -> HResult,
    AcknowledgeGroupPut: proc "system" (this: ^CommVariableIF, AcknowledgeGroup: BStr) -> HResult,
}

commvariable_new :: proc(
    name: string,
    type: string,
    direction := "",
    attribute := "",
    initial_value := "",
    isp_value := "",
    priority := "",
    interval_time := "",
    readpermission := "",
    description := ""
) -> (commvariable: CommVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type := to_bstr(type)
    bstr_direction := to_bstr(direction)
    bstr_attribute := to_bstr(attribute)
    bstr_initial_value := to_bstr(initial_value)
    bstr_isp_value := to_bstr(isp_value)
    bstr_priority := to_bstr(priority)
    bstr_interval_time := to_bstr(interval_time)
    bstr_readpermission := to_bstr(readpermission)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_direction)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_isp_value)
        bstr_free(bstr_priority)
        bstr_free(bstr_interval_time)
        bstr_free(bstr_readpermission)
        bstr_free(bstr_description)
    }
    hr := factoryif->NewCommVariable1(
        bstr_name,
        bstr_type,
        bstr_direction,
        bstr_attribute,
        bstr_initial_value,
        bstr_isp_value,
        bstr_priority,
        bstr_interval_time,
        bstr_readpermission,
        bstr_description,
        cast(^rawptr)&commvariable
    )
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariable_deserialize :: proc(xml: string) -> (commvariable: CommVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeCommVariable(&bs, cast(^rawptr)commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariable_serialize :: proc(commvariable: CommVariable) -> (xml: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_name :: proc {
    commvariable_name_get,
    commvariable_name_set,
}

commvariable_name_get :: proc(commvariable: CommVariable) -> (name: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

commvariable_name_set :: proc(commvariable: CommVariable, name: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_type_name :: proc {
    commvariable_type_name_get,
    commvariable_type_name_set,
}

commvariable_type_name_get :: proc(commvariable: CommVariable) -> (type_name: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

commvariable_type_name_set :: proc(commvariable: CommVariable, type_name: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_attribute :: proc {
    commvariable_attribute_get,
    commvariable_attribute_set,
}

commvariable_attribute_get :: proc(commvariable: CommVariable) -> (attribute: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_attribute_set :: proc(commvariable: CommVariable, attribute: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_initial_value :: proc {
    commvariable_initial_value_get,
    commvariable_initial_value_set,
}

commvariable_initial_value_get :: proc(commvariable: CommVariable) -> (inital_value: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_initial_value_set :: proc(commvariable: CommVariable, inital_value: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_direction :: proc {
    commvariable_direction_get,
    commvariable_direction_set,
}

commvariable_direction_get :: proc(commvariable: CommVariable) -> (direction: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_direction_set :: proc(commvariable: CommVariable, direction: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(direction)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_ipaddress :: proc {
    commvariable_ipaddress_get,
    commvariable_ipaddress_set,
}

commvariable_ipaddress_get :: proc(commvariable: CommVariable) -> (ipaddress: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_ipaddress_set :: proc(commvariable: CommVariable, ipaddress: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(ipaddress)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_interval_time :: proc {
    commvariable_interval_time_get,
    commvariable_interval_time_set,
}

commvariable_interval_time_get :: proc(commvariable: CommVariable) -> (interval_time: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_interval_time_set :: proc(commvariable: CommVariable, interval_time: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(interval_time)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_priority :: proc {
    commvariable_priority_get,
    commvariable_priority_set,
}

commvariable_priority_get :: proc(commvariable: CommVariable) -> (priority: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_priority_set :: proc(commvariable: CommVariable, priority: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(priority)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_isp_value :: proc {
    commvariable_isp_value_get,
    commvariable_isp_value_set,
}

commvariable_isp_value_get :: proc(commvariable: CommVariable) -> (isp_value: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_isp_value_set :: proc(commvariable: CommVariable, isp_value: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(isp_value)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_read_permission :: proc {
    commvariable_read_permission_get,
    commvariable_read_permission_set,
}

commvariable_read_permission_get :: proc(commvariable: CommVariable) -> (read_permission: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_read_permission_set :: proc(commvariable: CommVariable, read_permission: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_description :: proc {
    commvariable_description_get,
    commvariable_description_set,
}

commvariable_description_get :: proc(commvariable: CommVariable) -> (description: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_description_set :: proc(commvariable: CommVariable, description: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_type_guid_get :: proc(commvariable: CommVariable) -> (guid: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_type_path_get :: proc(commvariable: CommVariable) -> (path: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_expected_sil :: proc {
    commvariable_expected_sil_get,
    commvariable_expected_sil_set,
}

commvariable_expected_sil_get :: proc(commvariable: CommVariable) -> (expected_sil: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_expected_sil_set :: proc(commvariable: CommVariable, expected_sil: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(expected_sil)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_unique_id :: proc {
    commvariable_unique_id_get,
    commvariable_unique_id_set,
}

commvariable_unique_id_get :: proc(commvariable: CommVariable) -> (unique_id: i32, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    id: i32
    hr := (^CommVariableIF)(commvariable)->UniqueIDGet(&id)
    if com_failed(hr) do return
    
    return id, true
}

commvariable_unique_id_set :: proc(commvariable: CommVariable, unique_id: i32) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CommVariableIF)(commvariable)->UniqueIDPut(unique_id)
    if com_failed(hr) do return
    
    return true
}

commvariable_restricted_sil :: proc {
    commvariable_restricted_sil_get,
    commvariable_restricted_sil_set,
}

commvariable_restricted_sil_get :: proc(commvariable: CommVariable) -> (restricted_sil: bool, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    vb: VariantBool
    hr := (^CommVariableIF)(commvariable)->RestrictedSILGet(&vb)
    if com_failed(hr) do return
    
    return from_variantbool(vb), true
}

commvariable_restricted_sil_set :: proc(commvariable: CommVariable, restricted_sil: bool) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^CommVariableIF)(commvariable)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return
    
    return true
}

commvariable_acknowledge_group :: proc {
    commvariable_acknowledge_group_get,
    commvariable_acknowledge_group_set,
}

commvariable_acknowledge_group_get :: proc(commvariable: CommVariable) -> (acknowledge_group: string, ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_acknowledge_group_set :: proc(commvariable: CommVariable, acknowledge_group: string) -> (ok: bool) {
    if commvariable == nil do return
    if !controlbuilder_connected() do return
    
    bs := to_bstr(acknowledge_group)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_release :: proc(commvariable: CommVariable) {
    if commvariable != nil {
        (^CommVariableIF)(commvariable)->Release()
    }
}
