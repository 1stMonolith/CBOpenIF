package cbopenif

HWUnit :: distinct rawptr

HWUnitIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWUnitVTable,
}

HWUnitVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    PathGet:                  proc "system" (this: ^HWUnitIF, Path: ^BStr) -> HResult,
    PathPut:                  proc "system" (this: ^HWUnitIF, Path: BStr) -> HResult,
    TypeIDGet:                proc "system" (this: ^HWUnitIF, TypeID: ^BStr) -> HResult,
    TypeIDPut:                proc "system" (this: ^HWUnitIF, TypeID: BStr) -> HResult,
    TypeDescriptionGet:       proc "system" (this: ^HWUnitIF, TypeDescription: ^BStr) -> HResult,
    TypeDescriptionPut:       proc "system" (this: ^HWUnitIF, TypeDescription: BStr) -> HResult,
    GuidGet:                  proc "system" (this: ^HWUnitIF, Guid: ^BStr) -> HResult,
    GuidPut:                  proc "system" (this: ^HWUnitIF, Guid: BStr) -> HResult,
    RedundantPosGet:          proc "system" (this: ^HWUnitIF, RedundantPos: ^BStr) -> HResult,
    RedundantPosPut:          proc "system" (this: ^HWUnitIF, RedundantPos: BStr) -> HResult,
    HWSimulationGet:          proc "system" (this: ^HWUnitIF, HWSimulation: ^VariantBool) -> HResult,
    HWSimulationPut:          proc "system" (this: ^HWUnitIF, HWSimulation: VariantBool) -> HResult,
    HWSimulationSupportedGet: proc "system" (this: ^HWUnitIF, HWSimulationSupported: ^VariantBool) -> HResult,
    HWSimulationSupportedPut: proc "system" (this: ^HWUnitIF, HWSimulationSupported: VariantBool) -> HResult,
    ReservedByFunctionGet:    proc "system" (this: ^HWUnitIF, ReservedByFunction: ^BStr) -> HResult,
    ReservedByFunctionPut:    proc "system" (this: ^HWUnitIF, ReservedByFunction: BStr) -> HResult,
    ParameterSettingsGet:     proc "system" (this: ^HWUnitIF, ParameterSettings: ^rawptr) -> HResult,
    Missing24:                proc "system" (this: ^HWUnitIF) -> HResult,
    ParameterSettingsPut:     proc "system" (this: ^HWUnitIF, ParameterSettings: rawptr) -> HResult,
    HWChannelsGet:            proc "system" (this: ^HWUnitIF, HWChannels: ^rawptr) -> HResult,
    Missing27:                proc "system" (this: ^HWUnitIF) -> HResult,
    HWChannelsPut:            proc "system" (this: ^HWUnitIF, HWChannels: rawptr) -> HResult,
    HWUnitsGet:               proc "system" (this: ^HWUnitIF, HWUnits: ^rawptr) -> HResult,
    Missing30:                proc "system" (this: ^HWUnitIF) -> HResult,
    HWUnitsPut:               proc "system" (this: ^HWUnitIF, HWUnits: rawptr) -> HResult,
    Serialize:                proc "system" (this: ^HWUnitIF, XML: ^BStr) -> HResult,
    TypeGuidGet:              proc "system" (this: ^HWUnitIF, TypeGuid: ^BStr) -> HResult,
    TypeGuidPut:              proc "system" (this: ^HWUnitIF, TypeGuid: BStr) -> HResult,
    InstanceNameGet:          proc "system" (this: ^HWUnitIF, InstanceName: ^BStr) -> HResult,
    InstanceNamePut:          proc "system" (this: ^HWUnitIF, InstanceName: BStr) -> HResult,
}

hwunit_new :: proc(path, type_id, type_description, guid, type_guid: string) -> (hwunit: HWUnit, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_path             := to_bstr(path)
    bstr_type_id          := to_bstr(type_id)
    bstr_type_description := to_bstr(type_description)
    bstr_guid             := to_bstr(guid)
    bstr_type_guid        := to_bstr(type_guid)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_type_id)
        bstr_free(bstr_type_description)
        bstr_free(bstr_guid)
        bstr_free(bstr_type_guid)
    }
    hr := factoryif->NewHWUnit2(bstr_path, bstr_type_id, bstr_type_description, bstr_guid, bstr_type_guid, cast(^rawptr)&hwunit)
    if com_failed(hr) do return

    return hwunit, true
}

hwunit_deserialize :: proc(xml: string) -> (hwunit: HWUnit, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeHWUnit(&bs, cast(^rawptr)&hwunit)
    if com_failed(hr) do return

    return hwunit, true
}

hwunit_serialize :: proc(hwunit: HWUnit) -> (xml: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_path :: proc {
    hwunit_path_get,
    hwunit_path_set,
}

hwunit_path_get :: proc(hwunit: HWUnit) -> (path: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->PathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_path_set :: proc(hwunit: HWUnit, path: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->PathPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_type_id :: proc {
    hwunit_type_id_get,
    hwunit_type_id_set,
}

hwunit_type_id_get :: proc(hwunit: HWUnit) -> (type_id: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeIDGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_type_id_set :: proc(hwunit: HWUnit, type_id: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_id)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeIDPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_type_description :: proc {
    hwunit_type_description_get,
    hwunit_type_description_set,
}

hwunit_type_description_get :: proc(hwunit: HWUnit) -> (type_description: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeDescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_type_description_set :: proc(hwunit: HWUnit, type_description: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_description)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeDescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_guid :: proc {
    hwunit_guid_get,
    hwunit_guid_set,
}

hwunit_guid_get :: proc(hwunit: HWUnit) -> (guid: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_guid_set :: proc(hwunit: HWUnit, guid: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_redundant_pos :: proc {
    hwunit_redundant_pos_get,
    hwunit_redundant_pos_set,
}

hwunit_redundant_pos_get :: proc(hwunit: HWUnit) -> (redundant_pos: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->RedundantPosGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_redundant_pos_set :: proc(hwunit: HWUnit, redundant_pos: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(redundant_pos)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->RedundantPosPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_hw_simulation :: proc {
    hwunit_hw_simulation_get,
    hwunit_hw_simulation_set,
}

hwunit_hw_simulation_get :: proc(hwunit: HWUnit) -> (hw_simulation: bool, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^HWUnitIF)(hwunit)->HWSimulationGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwunit_hw_simulation_set :: proc(hwunit: HWUnit, hw_simulation: bool) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWSimulationPut(to_variantbool(hw_simulation))
    if com_failed(hr) do return

    return true
}

hwunit_hw_simulation_supported :: proc {
    hwunit_hw_simulation_supported_get,
    hwunit_hw_simulation_supported_set,
}

hwunit_hw_simulation_supported_get :: proc(hwunit: HWUnit) -> (hw_simulation_supported: bool, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^HWUnitIF)(hwunit)->HWSimulationSupportedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwunit_hw_simulation_supported_set :: proc(hwunit: HWUnit, hw_simulation_supported: bool) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWSimulationSupportedPut(to_variantbool(hw_simulation_supported))
    if com_failed(hr) do return

    return true
}

hwunit_reserved_by_function :: proc {
    hwunit_reserved_by_function_get,
    hwunit_reserved_by_function_set,
}

hwunit_reserved_by_function_get :: proc(hwunit: HWUnit) -> (reserved_by_function: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_reserved_by_function_set :: proc(hwunit: HWUnit, reserved_by_function: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_parametersettings :: proc {
    hwunit_parametersettings_get,
    hwunit_parametersettings_set,
}

hwunit_parametersettings_get :: proc(hwunit: HWUnit) -> (parametersettings: ParameterSettings, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->ParameterSettingsGet(&p)
    if com_failed(hr) do return

    return ParameterSettings(p), true
}

hwunit_parametersettings_set :: proc(hwunit: HWUnit, parametersettings: ParameterSettings) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitIF)(hwunit)->ParameterSettingsPut(parametersettings)
    if com_failed(hr) do return

    return true
}

hwunit_hwchannels :: proc {
    hwunit_hwchannels_get,
    hwunit_hwchannels_set,
}

hwunit_hwchannels_get :: proc(hwunit: HWUnit) -> (hwchannels: HWChannels, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->HWChannelsGet(&p)
    if com_failed(hr) do return

    return HWChannels(p), true
}

hwunit_hwchannels_set :: proc(hwunit: HWUnit, hwchannels: HWChannels) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWChannelsPut(hwchannels)
    if com_failed(hr) do return

    return true
}

hwunit_hwunits :: proc {
    hwunit_hwunits_get,
    hwunit_hwunits_set,
}

hwunit_hwunits_get :: proc(hwunit: HWUnit) -> (hwunits: HWUnits, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->HWUnitsGet(&p)
    if com_failed(hr) do return

    return HWUnits(p), true
}

hwunit_hwunits_set :: proc(hwunit: HWUnit, hwunits: HWUnits) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWUnitsPut(hwunits)
    if com_failed(hr) do return

    return true
}

hwunit_type_guid :: proc {
    hwunit_type_guid_get,
    hwunit_type_guid_set,
}

hwunit_type_guid_get :: proc(hwunit: HWUnit) -> (type_guid: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_type_guid_set :: proc(hwunit: HWUnit, type_guid: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_instance_name :: proc {
    hwunit_instance_name_get,
    hwunit_instance_name_set,
}

hwunit_instance_name_get :: proc(hwunit: HWUnit) -> (instance_name: string, ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->InstanceNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_instance_name_set :: proc(hwunit: HWUnit, instance_name: string) -> (ok: bool) {
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(instance_name)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->InstanceNamePut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_release :: proc(hwunit: HWUnit) {
    if hwunit != nil {
        (^HWUnitIF)(hwunit)->Release()
    }
}
