package com

HWUnit     :: distinct rawptr
HWUnits    :: distinct rawptr
HWChannel  :: distinct rawptr
HWChannels :: distinct rawptr

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

hwunit_serialize :: proc(hwunit: HWUnit) -> (xml: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_path_get :: proc(hwunit: HWUnit) -> (path: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->PathGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_path_set :: proc(hwunit: HWUnit, path: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(path)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->PathPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_type_id_get :: proc(hwunit: HWUnit) -> (type_id: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeIDGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_type_id_set :: proc(hwunit: HWUnit, type_id: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(type_id)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeIDPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_type_description_get :: proc(hwunit: HWUnit) -> (type_description: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeDescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_type_description_set :: proc(hwunit: HWUnit, type_description: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(type_description)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeDescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_guid_get :: proc(hwunit: HWUnit) -> (guid: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->GuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_guid_set :: proc(hwunit: HWUnit, guid: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(guid)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->GuidPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_redundant_pos_get :: proc(hwunit: HWUnit) -> (redundant_pos: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->RedundantPosGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_redundant_pos_set :: proc(hwunit: HWUnit, redundant_pos: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(redundant_pos)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->RedundantPosPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_hw_simulation_get :: proc(hwunit: HWUnit) -> (hw_simulation: bool, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^HWUnitIF)(hwunit)->HWSimulationGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwunit_hw_simulation_set :: proc(hwunit: HWUnit, hw_simulation: bool) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWSimulationPut(to_variantbool(hw_simulation))
    if com_failed(hr) do return

    return true
}

hwunit_hw_simulation_supported_get :: proc(hwunit: HWUnit) -> (hw_simulation_supported: bool, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^HWUnitIF)(hwunit)->HWSimulationSupportedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwunit_hw_simulation_supported_set :: proc(hwunit: HWUnit, hw_simulation_supported: bool) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWSimulationSupportedPut(to_variantbool(hw_simulation_supported))
    if com_failed(hr) do return

    return true
}

hwunit_reserved_by_function_get :: proc(hwunit: HWUnit) -> (reserved_by_function: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->ReservedByFunctionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_reserved_by_function_set :: proc(hwunit: HWUnit, reserved_by_function: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(reserved_by_function)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->ReservedByFunctionPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_parametersettings_get :: proc(hwunit: HWUnit) -> (parametersettings: ParameterSettings, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->ParameterSettingsGet(&p)
    if com_failed(hr) do return

    return ParameterSettings(p), true
}

hwunit_parametersettings_set :: proc(hwunit: HWUnit, parametersettings: ParameterSettings) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitIF)(hwunit)->ParameterSettingsPut(parametersettings)
    if com_failed(hr) do return

    return true
}

hwunit_hwchannels_get :: proc(hwunit: HWUnit) -> (hwchannels: HWChannels, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->HWChannelsGet(&p)
    if com_failed(hr) do return

    return HWChannels(p), true
}

hwunit_hwchannels_set :: proc(hwunit: HWUnit, hwchannels: HWChannels) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWChannelsPut(hwchannels)
    if com_failed(hr) do return

    return true
}

hwunit_hwunits_get :: proc(hwunit: HWUnit) -> (hwunits: HWUnits, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->HWUnitsGet(&p)
    if com_failed(hr) do return

    return HWUnits(p), true
}

hwunit_hwunits_set :: proc(hwunit: HWUnit, hwunits: HWUnits) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitIF)(hwunit)->HWUnitsPut(hwunits)
    if com_failed(hr) do return

    return true
}

hwunit_type_guid_get :: proc(hwunit: HWUnit) -> (type_guid: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeGuidGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_type_guid_set :: proc(hwunit: HWUnit, type_guid: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs := to_bstr(type_guid)
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->TypeGuidPut(bs)
    if com_failed(hr) do return

    return true
}

hwunit_instance_name_get :: proc(hwunit: HWUnit) -> (instance_name: string, ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWUnitIF)(hwunit)->InstanceNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwunit_instance_name_set :: proc(hwunit: HWUnit, instance_name: string) -> (ok: bool) {
    if hwunit == nil do return
    if !com_connected() do return

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

HWUnitsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWUnitsVTable,
}

HWUnitsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^HWUnitsIF, HWUnit: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^HWUnitsIF, HWUnit: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^HWUnitsIF, Path: BStr, HWUnit: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^HWUnitsIF, Path, TypeID, TypeDescription, Guid: BStr, HWUnit: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^HWUnitsIF, Path: BStr, HWUnit: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^HWUnitsIF, Path: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^HWUnitsIF, Index: i32, HWUnit: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^HWUnitsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^HWUnitsIF, Index: i32) -> HResult,
}

hwunits_hwunit_add :: proc(hwunits: HWUnits, hwunit: HWUnit) -> (ok: bool) {
    if hwunits == nil do return
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Add(hwunit)
    if com_failed(hr) do return

    return true
}

hwunits_hwunit_add_at_index :: proc(hwunits: HWUnits, hwunit: HWUnit, index: i32) -> (ok: bool) {
    if hwunits == nil do return
    if hwunit == nil do return
    if !com_connected() do return

    hr := (^HWUnitsIF)(hwunits)->AddBefore(hwunit, index)
    if com_failed(hr) do return

    return true
}

hwunits_hwunit_by_path :: proc(hwunits: HWUnits, path: string) -> (hwunit: HWUnit, ok: bool) {
    if hwunits == nil do return
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := (^HWUnitsIF)(hwunits)->Find(bstr_path, cast(^rawptr)&hwunit)
    if com_failed(hr) do return

    return hwunit, true
}

hwunits_hwunit_by_index :: proc(hwunits: HWUnits, index: i32) -> (hwunit: HWUnit, ok: bool) {
    if hwunits == nil do return
    if !com_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Item(index + 1, cast(^rawptr)&hwunit)
    if com_failed(hr) do return

    return hwunit, true
}

hwunits_hwunit_index :: proc(hwunits: HWUnits, path: string) -> (index: i32, ok: bool) {
    if hwunits == nil do return
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := (^HWUnitsIF)(hwunits)->FindNr(bstr_path, &index)
    if com_failed(hr) do return

    return index - 1, true
}

hwunits_hwunit_count :: proc(hwunits: HWUnits) -> (count: i32, ok: bool) {
    if hwunits == nil do return
    if !com_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

hwunits_hwunit_remove_by_path :: proc(hwunits: HWUnits, path: string) -> (ok: bool) {
    if hwunits == nil do return
    if !com_connected() do return

    index: i32
    index, ok = hwunits_hwunit_index(hwunits, path)
    if !ok do return

    hr := (^HWUnitsIF)(hwunits)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwunits_hwunit_remove_by_index :: proc(hwunits: HWUnits, index: i32) -> (ok: bool) {
    if hwunits == nil do return
    if !com_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

hwunits_release :: proc(hwunits: HWUnits) {
    if hwunits != nil {
        (^HWUnitsIF)(hwunits)->Release()
    }
}

HWChannelIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWChannelVTable,
}

HWChannelVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:          proc "system" (this: ^HWChannelIF, Name: ^BStr) -> HResult,
    NamePut:          proc "system" (this: ^HWChannelIF, Name: BStr) -> HResult,
    AddressGet:       proc "system" (this: ^HWChannelIF, Address: ^BStr) -> HResult,
    AddressPut:       proc "system" (this: ^HWChannelIF, Address: BStr) -> HResult,
    MinGet:           proc "system" (this: ^HWChannelIF, Min: ^BStr) -> HResult,
    MinPut:           proc "system" (this: ^HWChannelIF, Min: BStr) -> HResult,
    MaxGet:           proc "system" (this: ^HWChannelIF, Max: ^BStr) -> HResult,
    MaxPut:           proc "system" (this: ^HWChannelIF, Max: BStr) -> HResult,
    UnitGet:          proc "system" (this: ^HWChannelIF, Unit: ^BStr) -> HResult,
    UnitPut:          proc "system" (this: ^HWChannelIF, Unit: BStr) -> HResult,
    FractionGet:      proc "system" (this: ^HWChannelIF, Fraction: ^BStr) -> HResult,
    FractionPut:      proc "system" (this: ^HWChannelIF, Fraction: BStr) -> HResult,
    ReversedGet:      proc "system" (this: ^HWChannelIF, Reversed: ^VariantBool) -> HResult,
    ReversedPut:      proc "system" (this: ^HWChannelIF, Reversed: VariantBool) -> HResult,
    ConVariableGet:   proc "system" (this: ^HWChannelIF, ConVariable: ^BStr) -> HResult,
    ConVariablePut:   proc "system" (this: ^HWChannelIF, ConVariable: BStr) -> HResult,
    IODescriptionGet: proc "system" (this: ^HWChannelIF, IODescription: ^BStr) -> HResult,
    IODescriptionPut: proc "system" (this: ^HWChannelIF, IODescription: BStr) -> HResult,
    ChannelTypeGet:   proc "system" (this: ^HWChannelIF, ChannelType: ^BStr) -> HResult,
    IsSignalGet:      proc "system" (this: ^HWChannelIF, IsSignal: ^VariantBool) -> HResult,
    IsSignalPut:      proc "system" (this: ^HWChannelIF, IsSignal: VariantBool) -> HResult,
}

hwchannel_name_get :: proc(hwchannel: HWChannel) -> (name: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->NameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_name_set :: proc(hwchannel: HWChannel, name: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->NamePut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_address_get :: proc(hwchannel: HWChannel) -> (address: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_address_set :: proc(hwchannel: HWChannel, address: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(address)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_min_get :: proc(hwchannel: HWChannel) -> (min: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MinGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_min_set :: proc(hwchannel: HWChannel, min: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(min)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MinPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_max_get :: proc(hwchannel: HWChannel) -> (max: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_max_set :: proc(hwchannel: HWChannel, max: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(max)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_unit_get :: proc(hwchannel: HWChannel) -> (unit: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_unit_set :: proc(hwchannel: HWChannel, unit: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(unit)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_fraction_get :: proc(hwchannel: HWChannel) -> (fraction: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_fraction_set :: proc(hwchannel: HWChannel, fraction: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(fraction)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_reversed_get :: proc(hwchannel: HWChannel) -> (reversed: bool, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->ReversedGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwchannel_reversed_set :: proc(hwchannel: HWChannel, reversed: bool) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelIF)(hwchannel)->ReversedPut(to_variantbool(reversed))
    if com_failed(hr) do return

    return true
}

hwchannel_con_variable_get :: proc(hwchannel: HWChannel) -> (con_variable: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariableGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_con_variable_set :: proc(hwchannel: HWChannel, con_variable: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(con_variable)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariablePut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_io_description_get :: proc(hwchannel: HWChannel) -> (io_description: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_io_description_set :: proc(hwchannel: HWChannel, io_description: string) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs := to_bstr(io_description)
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionPut(bs)
    if com_failed(hr) do return

    return true
}

hwchannel_channel_type_get :: proc(hwchannel: HWChannel) -> (channel_type: string, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^HWChannelIF)(hwchannel)->ChannelTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

hwchannel_is_signal_get :: proc(hwchannel: HWChannel) -> (is_signal: bool, ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->IsSignalGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

hwchannel_is_signal_set :: proc(hwchannel: HWChannel, is_signal: bool) -> (ok: bool) {
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelIF)(hwchannel)->IsSignalPut(to_variantbool(is_signal))
    if com_failed(hr) do return

    return true
}

hwchannel_release :: proc(hwchannel: HWChannel) {
    if hwchannel != nil {
        (^HWChannelIF)(hwchannel)->Release()
    }
}

HWChannelsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWChannelsVTable,
}

HWChannelsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^HWChannelsIF, HWChannel: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^HWChannelsIF, HWChannel: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^HWChannelsIF, Address, Name, ConVariable, IODescription: BStr, HWChannel: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^HWChannelsIF, Address, Name, ConVariable, IODescription, Min, Max, Unit, Fraction: BStr, Reversed: VariantBool, HWChannel: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^HWChannelsIF, Address: BStr, HWChannel: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^HWChannelsIF, Address: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^HWChannelsIF, Index: i32, HWChannel: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^HWChannelsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^HWChannelsIF, Index: i32) -> HResult,
}

hwchannels_hwchannel_add :: proc(hwchannels: HWChannels, hwchannel: HWChannel) -> (ok: bool) {
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Add(hwchannel)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_add_at_index :: proc(hwchannels: HWChannels, hwchannel: HWChannel, index: i32) -> (ok: bool) {
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->AddBefore(hwchannel, index)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_by_address :: proc(hwchannels: HWChannels, address: string) -> (hwchannel: HWChannel, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    bstr_address := to_bstr(address)
    defer bstr_free(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->Find(bstr_address, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannels_hwchannel_by_index :: proc(hwchannels: HWChannels, index: i32) -> (hwchannel: HWChannel, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Item(index + 1, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return

    return hwchannel, true
}

hwchannels_hwchannel_index :: proc(hwchannels: HWChannels, address: string) -> (index: i32, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    bstr_address := to_bstr(address)
    defer bstr_free(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->FindNr(bstr_address, &index)
    if com_failed(hr) do return

    return index - 1, true
}

hwchannels_hwchannel_count :: proc(hwchannels: HWChannels) -> (count: i32, ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

hwchannels_hwchannel_remove_by_address :: proc(hwchannels: HWChannels, address: string) -> (ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    index: i32
    index, ok = hwchannels_hwchannel_index(hwchannels, address)
    if !ok do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwchannels_hwchannel_remove_by_index :: proc(hwchannels: HWChannels, index: i32) -> (ok: bool) {
    if hwchannels == nil do return
    if !com_connected() do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

hwchannels_release :: proc(hwchannels: HWChannels) {
    if hwchannels != nil {
        (^HWChannelsIF)(hwchannels)->Release()
    }
}
