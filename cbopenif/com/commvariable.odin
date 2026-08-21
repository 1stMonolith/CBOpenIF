package com

import t "../types"

CommVariable  :: distinct rawptr
CommVariables :: distinct rawptr

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

commvariable_serialize :: proc(commvariable: CommVariable) -> (xml: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->Serialize(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_name_get :: proc(commvariable: CommVariable) -> (name: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

commvariable_name_set :: proc(commvariable: CommVariable, name: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_type_name_get :: proc(commvariable: CommVariable) -> (type_name: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

commvariable_type_name_set :: proc(commvariable: CommVariable, type_name: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return

    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeNamePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_attribute_get :: proc(commvariable: CommVariable) -> (attribute: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AttributeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_attribute_set :: proc(commvariable: CommVariable, attribute: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return

    bs := to_bstr(attribute)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AttributePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_initial_value_get :: proc(commvariable: CommVariable) -> (inital_value: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_initial_value_set :: proc(commvariable: CommVariable, inital_value: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(inital_value)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->InitialValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_direction_get :: proc(commvariable: CommVariable) -> (direction: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_direction_set :: proc(commvariable: CommVariable, direction: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(direction)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DirectionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_ipaddress_get :: proc(commvariable: CommVariable) -> (ipaddress: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_ipaddress_set :: proc(commvariable: CommVariable, ipaddress: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(ipaddress)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IPAddressPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_interval_time_get :: proc(commvariable: CommVariable) -> (interval_time: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimeGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_interval_time_set :: proc(commvariable: CommVariable, interval_time: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(interval_time)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->IntervalTimePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_priority_get :: proc(commvariable: CommVariable) -> (priority: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_priority_set :: proc(commvariable: CommVariable, priority: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(priority)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->PriorityPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_isp_value_get :: proc(commvariable: CommVariable) -> (isp_value: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_isp_value_set :: proc(commvariable: CommVariable, isp_value: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(isp_value)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ISPValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_read_permission_get :: proc(commvariable: CommVariable) -> (read_permission: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_read_permission_set :: proc(commvariable: CommVariable, read_permission: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(read_permission)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ReadPermissionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_description_get :: proc(commvariable: CommVariable) -> (description: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_description_set :: proc(commvariable: CommVariable, description: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(description)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->DescriptionPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_type_guid_get :: proc(commvariable: CommVariable) -> (guid: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypeGuid(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_type_path_get :: proc(commvariable: CommVariable) -> (path: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->TypePath(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_expected_sil_get :: proc(commvariable: CommVariable) -> (expected_sil: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_expected_sil_set :: proc(commvariable: CommVariable, expected_sil: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs := to_bstr(expected_sil)
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->ExpectedSILPut(bs)
    if com_failed(hr) do return
    
    return true
}

commvariable_unique_id_get :: proc(commvariable: CommVariable) -> (unique_id: i32, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    id: i32
    hr := (^CommVariableIF)(commvariable)->UniqueIDGet(&id)
    if com_failed(hr) do return
    
    return id, true
}

commvariable_unique_id_set :: proc(commvariable: CommVariable, unique_id: i32) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    hr := (^CommVariableIF)(commvariable)->UniqueIDPut(unique_id)
    if com_failed(hr) do return
    
    return true
}

commvariable_restricted_sil_get :: proc(commvariable: CommVariable) -> (restricted_sil: bool, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    vb: VariantBool
    hr := (^CommVariableIF)(commvariable)->RestrictedSILGet(&vb)
    if com_failed(hr) do return
    
    return from_variantbool(vb), true
}

commvariable_restricted_sil_set :: proc(commvariable: CommVariable, restricted_sil: bool) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    hr := (^CommVariableIF)(commvariable)->RestrictedSILPut(to_variantbool(restricted_sil))
    if com_failed(hr) do return
    
    return true
}

commvariable_acknowledge_group_get :: proc(commvariable: CommVariable) -> (acknowledge_group: string, ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^CommVariableIF)(commvariable)->AcknowledgeGroupGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

commvariable_acknowledge_group_set :: proc(commvariable: CommVariable, acknowledge_group: string) -> (ok: bool) {
    if commvariable == nil do return
    if !com_connected() do return
    
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

commvariable_from_com :: proc(commvariable: CommVariable, allocator := context.allocator) -> (result: t.CommVariable, ok: bool) {
    if commvariable == nil do return

    context.allocator = allocator

    result.name, ok = name(commvariable)
    if !ok do return
    result.type_name, ok = type_name(commvariable)
    if !ok do return
    result.attribute, ok = attribute(commvariable)
    if !ok do return
    result.initial_value, ok = initial_value(commvariable)
    if !ok do return
    result.description, ok = description(commvariable)
    if !ok do return

    dir_str: string
    dir_str, ok = direction(commvariable)
    if !ok do return
    result.direction = t.direction_from_string(dir_str)

    result.ip_address, ok = ipaddress(commvariable)
    if !ok do return
    result.interval_time, ok = interval_time(commvariable)
    if !ok do return
    result.priority, ok = priority(commvariable)
    if !ok do return
    result.isp_value, ok = isp_value(commvariable)
    if !ok do return
    result.read_permission, ok = read_permission(commvariable)
    if !ok do return
    result.expected_sil, ok = expected_sil(commvariable)
    if !ok do return
    result.unique_id, ok = unique_id(commvariable)
    if !ok do return
    result.restricted_sil, ok = restricted_sil(commvariable)
    if !ok do return
    result.acknowledge_group, ok = acknowledge_group(commvariable)
    if !ok do return
    result.type_guid, ok = type_guid(commvariable)
    if !ok do return
    result.type_path, ok = type_path(commvariable)
    if !ok do return

    return result, true
}

commvariable_to_com :: proc(src: t.CommVariable) -> (result: CommVariable, ok: bool) {
    commvariable: CommVariable
    commvariable, ok = commvariable_new1(
        src.name,
        src.type_name,
        t.direction_to_string(src.direction),
        src.attribute,
        src.initial_value,
        src.isp_value,
        src.priority,
        src.interval_time,
        src.read_permission,
        src.description,
    )
    if !ok do return
    defer if !ok do release(commvariable)

    ok = ipaddress(commvariable, src.ip_address)
    if !ok do return
    ok = expected_sil(commvariable, src.expected_sil)
    if !ok do return
    ok = unique_id(commvariable, src.unique_id)
    if !ok do return
    ok = restricted_sil(commvariable, src.restricted_sil)
    if !ok do return
    ok = acknowledge_group(commvariable, src.acknowledge_group)
    if !ok do return

    // type_guid / type_path are read-only

    return commvariable, true
}

CommVariablesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CommVariablesVTable,
}

CommVariablesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^CommVariablesIF, CommVariable: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^CommVariablesIF, CommVariable: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^CommVariablesIF, Name, TypeName, Direction: BStr, Variable: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^CommVariablesIF, Name, TypeName, Direction, Attribute, InitialValue, ISPValue, Priority, IntervalTime, ReadPermission, Description: BStr, CommVariable: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^CommVariablesIF, Name: BStr, CommVariable: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^CommVariablesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^CommVariablesIF, Index: i32, CommVariable: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^CommVariablesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^CommVariablesIF, Index: i32) -> HResult,
}

commvariables_commvariable_add :: proc(commvariables: CommVariables, commvariable: CommVariable) -> (ok: bool) {
    if commvariables == nil do return
    if commvariable == nil do return
    if !com_connected() do return

    hr := (^CommVariablesIF)(commvariables)->Add(commvariable)
    if com_failed(hr) do return

    return true
}

commvariables_commvariable_add_at_index :: proc(commvariables: CommVariables, commvariable: CommVariable, index: i32) -> (ok: bool) {
    if commvariables == nil do return
    if commvariable == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->AddBefore(commvariable, index)
    if com_failed(hr) do return

    return true
}

commvariables_commvariable_by_name :: proc(commvariables: CommVariables, name: string) -> (commvariable: CommVariable, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->Find(bstr_name, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariables_commvariable_by_index :: proc(commvariables: CommVariables, index: i32) -> (commvariable: CommVariable, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Item(index + 1, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariables_commvariable_index :: proc(commvariables: CommVariables, name: string) -> (index: i32, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^CommVariablesIF)(commvariables)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

commvariables_commvariable_count :: proc(commvariables: CommVariables) -> (count: i32, ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

commvariables_remove_by_name :: proc(commvariables: CommVariables, name: string) -> (ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return

    index: i32
    index, ok = commvariables_commvariable_index(commvariables, name)
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

commvariables_remove_by_index :: proc(commvariables: CommVariables, index: i32) -> (ok: bool) {
    if commvariables == nil do return
    if !com_connected() do return
    
    hr := (^CommVariablesIF)(commvariables)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

commvariables_release :: proc(commvariables: CommVariables) {
    if commvariables != nil {
        (^CommVariablesIF)(commvariables)->Release()
    }
}

commvariables_from_com :: proc(cvs: CommVariables, allocator := context.allocator) -> (result: [dynamic]t.CommVariable, ok: bool) {
    if cvs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = commvariable_count(cvs)
    if !ok do return

    result = make([dynamic]t.CommVariable, 0, int(count), allocator)
    for i in 0..<count {
        cv: CommVariable
        cv, ok = commvariable_by_index(cvs, i)
        if !ok do return
        defer release(cv)

        cvs_: t.CommVariable
        cvs_, ok = commvariable_from_com(cv)
        if !ok do return
        append(&result, cvs_)
    }
    return result, true
}

commvariables_to_com :: proc(cvs: CommVariables, src: []t.CommVariable) -> (ok: bool) {
    if cvs == nil do return
    for item in src {
        cv: CommVariable
        cv, ok = commvariable_to_com(item)
        if !ok do return
        defer release(cv)
        ok = commvariable_add(cvs, cv)
        if !ok do return
    }
    return true
}
