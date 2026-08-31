package com

HWUnits    :: distinct rawptr
HWUnit     :: distinct rawptr
HWChannels :: distinct rawptr
HWChannel  :: distinct rawptr

HWUnitsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWUnitsVTable,
}

HWUnitsVTable :: struct
{
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

AddHWUnit :: proc {
    _AddHWUnit,
    _AddHWUnitAtIndex,
}

_AddHWUnit :: proc(hwunits: HWUnits, hwunit: HWUnit) -> (ok: bool)
{
    if hwunits == nil do return
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitsIF)(hwunits)->Add(hwunit)
    if ComFailed(hr) do return

    return true
}

_AddHWUnitAtIndex :: proc(hwunits: HWUnits, hwunit: HWUnit, index: i32) -> (ok: bool)
{
    if hwunits == nil do return
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitsIF)(hwunits)->AddBefore(hwunit, index)
    if ComFailed(hr) do return

    return true
}

GetHWUnit :: proc {
    _GetHWUnitByPath,
    _GetHWUnitAtIndex,
}

_GetHWUnitByPath :: proc(hwunits: HWUnits, path: string) -> (hwunit: HWUnit, ok: bool)
{
    if hwunits == nil do return
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)
    hr := (^HWUnitsIF)(hwunits)->Find(bstr_path, cast(^rawptr)&hwunit)
    if ComFailed(hr) do return

    return hwunit, true
}

_GetHWUnitAtIndex :: proc(hwunits: HWUnits, index: i32) -> (hwunit: HWUnit, ok: bool)
{
    if hwunits == nil do return
    if !ComConnected() do return

    hr := (^HWUnitsIF)(hwunits)->Item(index + 1, cast(^rawptr)&hwunit)
    if ComFailed(hr) do return

    return hwunit, true
}

HWUnitIndex :: proc(hwunits: HWUnits, path: string) -> (index: i32, ok: bool)
{
    if hwunits == nil do return
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)
    hr := (^HWUnitsIF)(hwunits)->FindNr(bstr_path, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

HWUnitCount :: proc(hwunits: HWUnits) -> (count: i32, ok: bool)
{
    if hwunits == nil do return
    if !ComConnected() do return

    hr := (^HWUnitsIF)(hwunits)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveHWUnit :: proc {
    _RemoveHWUnitByPath,
    _RemoveHWUnitAtIndex,
}

_RemoveHWUnitByPath :: proc(hwunits: HWUnits, path: string) -> (ok: bool)
{
    if hwunits == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = HWUnitIndex(hwunits, path)
    if !ok do return

    hr := (^HWUnitsIF)(hwunits)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveHWUnitAtIndex :: proc(hwunits: HWUnits, index: i32) -> (ok: bool)
{
    if hwunits == nil do return
    if !ComConnected() do return

    hr := (^HWUnitsIF)(hwunits)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseHWUnits :: proc(hwunits: HWUnits) {
    if hwunits != nil {
        (^HWUnitsIF)(hwunits)->Release()
    }
}

HWUnitIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWUnitVTable,
}

HWUnitVTable :: struct
{
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

SerializeHWUnit :: proc(hwunit: HWUnit) -> (xml: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->Serialize(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetHWUnitPath :: proc(hwunit: HWUnit) -> (path: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->PathGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitPath :: proc(hwunit: HWUnit, path: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(path)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->PathPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitID :: proc(hwunit: HWUnit) -> (type_id: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->TypeIDGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitID :: proc(hwunit: HWUnit, type_id: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_id)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->TypeIDPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitDescription :: proc(hwunit: HWUnit) -> (type_description: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->TypeDescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitDescription :: proc(hwunit: HWUnit, type_description: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_description)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->TypeDescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitGuid :: proc(hwunit: HWUnit) -> (guid: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->GuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitGuid :: proc(hwunit: HWUnit, guid: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(guid)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->GuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitRedundantPOS :: proc(hwunit: HWUnit) -> (redundant_pos: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->RedundantPosGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitRedundantPOS :: proc(hwunit: HWUnit, redundant_pos: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(redundant_pos)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->RedundantPosPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitSimulation :: proc(hwunit: HWUnit) -> (hw_simulation: bool, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^HWUnitIF)(hwunit)->HWSimulationGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetHWUnitSimulation :: proc(hwunit: HWUnit, hw_simulation: bool) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitIF)(hwunit)->HWSimulationPut(ToVariantBool(hw_simulation))
    if ComFailed(hr) do return

    return true
}

GetHWUnitSimulationSupported :: proc(hwunit: HWUnit) -> (hw_simulation_supported: bool, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^HWUnitIF)(hwunit)->HWSimulationSupportedGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetHWUnitSimulationSupported :: proc(hwunit: HWUnit, hw_simulation_supported: bool) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitIF)(hwunit)->HWSimulationSupportedPut(ToVariantBool(hw_simulation_supported))
    if ComFailed(hr) do return

    return true
}

GetHWUnitReservedBy :: proc(hwunit: HWUnit) -> (reserved_by_function: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->ReservedByFunctionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitReservedBy :: proc(hwunit: HWUnit, reserved_by_function: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(reserved_by_function)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->ReservedByFunctionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitParameterSettings :: proc(hwunit: HWUnit) -> (parametersettings: ParameterSettings, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->ParameterSettingsGet(&p)
    if ComFailed(hr) do return

    return ParameterSettings(p), true
}

SetHWUnitParameterSettings :: proc(hwunit: HWUnit, parametersettings: ParameterSettings) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitIF)(hwunit)->ParameterSettingsPut(parametersettings)
    if ComFailed(hr) do return

    return true
}

GetHWUnitHWChannels :: proc(hwunit: HWUnit) -> (hwchannels: HWChannels, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->HWChannelsGet(&p)
    if ComFailed(hr) do return

    return HWChannels(p), true
}

SetHWUnitHWChannels :: proc(hwunit: HWUnit, hwchannels: HWChannels) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitIF)(hwunit)->HWChannelsPut(hwchannels)
    if ComFailed(hr) do return

    return true
}

GetHWUnitHwUnits :: proc(hwunit: HWUnit) -> (hwunits: HWUnits, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    p: rawptr
    hr := (^HWUnitIF)(hwunit)->HWUnitsGet(&p)
    if ComFailed(hr) do return

    return HWUnits(p), true
}

SetHWUnitHwUnits :: proc(hwunit: HWUnit, hwunits: HWUnits) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    hr := (^HWUnitIF)(hwunit)->HWUnitsPut(hwunits)
    if ComFailed(hr) do return

    return true
}

GetHWUnitTypeGuid :: proc(hwunit: HWUnit) -> (type_guid: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->TypeGuidGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitTypeGuid :: proc(hwunit: HWUnit, type_guid: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(type_guid)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->TypeGuidPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWUnitInstanceName :: proc(hwunit: HWUnit) -> (instance_name: string, ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->InstanceNameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWUnitInstanceName :: proc(hwunit: HWUnit, instance_name: string) -> (ok: bool)
{
    if hwunit == nil do return
    if !ComConnected() do return

    bs := ToBstr(instance_name)
    defer FreeBstr(bs)
    hr := (^HWUnitIF)(hwunit)->InstanceNamePut(bs)
    if ComFailed(hr) do return

    return true
}

ReleaseHWUnit :: proc(hwunit: HWUnit)
{
    if hwunit != nil {
        (^HWUnitIF)(hwunit)->Release()
    }
}

HWChannelsIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWChannelsVTable,
}

HWChannelsVTable :: struct
{
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

AddHWChannel :: proc {
    _AddHWChannel,
    _AddHWChannelAtIndex,
}

_AddHWChannel :: proc(hwchannels: HWChannels, hwchannel: HWChannel) -> (ok: bool)
{
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !ComConnected() do return

    hr := (^HWChannelsIF)(hwchannels)->Add(hwchannel)
    if ComFailed(hr) do return

    return true
}

_AddHWChannelAtIndex :: proc(hwchannels: HWChannels, hwchannel: HWChannel, index: i32) -> (ok: bool)
{
    if hwchannels == nil do return
    if hwchannel == nil do return
    if !ComConnected() do return

    hr := (^HWChannelsIF)(hwchannels)->AddBefore(hwchannel, index)
    if ComFailed(hr) do return

    return true
}

AddHWChannelByAddress :: proc(hwchannels: HWChannels, address: string) -> (hwchannel: HWChannel, ok: bool)
{
    if hwchannels == nil do return
    if !ComConnected() do return

    bstr_address := ToBstr(address)
    defer FreeBstr(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->Find(bstr_address, cast(^rawptr)&hwchannel)
    if ComFailed(hr) do return

    return hwchannel, true
}

GetHWChannel :: proc(hwchannels: HWChannels, index: i32) -> (hwchannel: HWChannel, ok: bool)
{
    if hwchannels == nil do return
    if !ComConnected() do return

    hr := (^HWChannelsIF)(hwchannels)->Item(index + 1, cast(^rawptr)&hwchannel)
    if ComFailed(hr) do return

    return hwchannel, true
}

HWChannelIndex :: proc(hwchannels: HWChannels, address: string) -> (index: i32, ok: bool)
{
    if hwchannels == nil do return
    if !ComConnected() do return

    bstr_address := ToBstr(address)
    defer FreeBstr(bstr_address)
    hr := (^HWChannelsIF)(hwchannels)->FindNr(bstr_address, &index)
    if ComFailed(hr) do return

    return index - 1, true
}

HWChannelCount :: proc(hwchannels: HWChannels) -> (count: i32, ok: bool)
{
    if hwchannels == nil do return
    if !ComConnected() do return

    hr := (^HWChannelsIF)(hwchannels)->Count(&count)
    if ComFailed(hr) do return

    return count, true
}

RemoveHWChannel :: proc {
    _RemoveHWChannelByAddress,
    _RemoveHWChannelAtIndex,
}

_RemoveHWChannelByAddress :: proc(hwchannels: HWChannels, address: string) -> (ok: bool)
{
    if hwchannels == nil do return
    if !ComConnected() do return

    index: i32
    index, ok = HWChannelIndex(hwchannels, address)
    if !ok do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

_RemoveHWChannelAtIndex :: proc(hwchannels: HWChannels, index: i32) -> (ok: bool)
{
    if hwchannels == nil do return
    if !ComConnected() do return

    hr := (^HWChannelsIF)(hwchannels)->Remove(index + 1)
    if ComFailed(hr) do return

    return true
}

ReleaseHWChannels :: proc(hwchannels: HWChannels) {
    if hwchannels != nil {
        (^HWChannelsIF)(hwchannels)->Release()
    }
}

HWChannelIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^HWChannelVTable,
}

HWChannelVTable :: struct
{
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

GetHWChannelName :: proc(hwchannel: HWChannel) -> (name: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->NameGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelName :: proc(hwchannel: HWChannel, name: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(name)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->NamePut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelAddress :: proc(hwchannel: HWChannel) -> (address: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelAddress :: proc(hwchannel: HWChannel, address: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(address)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->AddressPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelMin :: proc(hwchannel: HWChannel) -> (min: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->MinGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelMin :: proc(hwchannel: HWChannel, min: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(min)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->MinPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelMax :: proc(hwchannel: HWChannel) -> (max: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelMax :: proc(hwchannel: HWChannel, max: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(max)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->MaxPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelUnit :: proc(hwchannel: HWChannel) -> (unit: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelUnit :: proc(hwchannel: HWChannel, unit: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(unit)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->UnitPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelFraction :: proc(hwchannel: HWChannel) -> (fraction: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelFraction :: proc(hwchannel: HWChannel, fraction: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(fraction)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->FractionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelReversed :: proc(hwchannel: HWChannel) -> (reversed: bool, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->ReversedGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetHWChannelReversed :: proc(hwchannel: HWChannel, reversed: bool) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    hr := (^HWChannelIF)(hwchannel)->ReversedPut(ToVariantBool(reversed))
    if ComFailed(hr) do return

    return true
}

GetHWChannelConVariable :: proc(hwchannel: HWChannel) -> (con_variable: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariableGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelConVariable :: proc(hwchannel: HWChannel, con_variable: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(con_variable)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->ConVariablePut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelIODescription :: proc(hwchannel: HWChannel) -> (io_description: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

SetHWChannelIODescription :: proc(hwchannel: HWChannel, io_description: string) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs := ToBstr(io_description)
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->IODescriptionPut(bs)
    if ComFailed(hr) do return

    return true
}

GetHWChannelType :: proc(hwchannel: HWChannel) -> (channel_type: string, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    bs: BStr
    defer FreeBstr(bs)
    hr := (^HWChannelIF)(hwchannel)->ChannelTypeGet(&bs)
    if ComFailed(hr) do return

    return FromBstr(bs), true
}

GetHWChannelIsSignal :: proc(hwchannel: HWChannel) -> (is_signal: bool, ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    vb: VariantBool
    hr := (^HWChannelIF)(hwchannel)->IsSignalGet(&vb)
    if ComFailed(hr) do return

    return FromVariantBool(vb), true
}

SetHWChannelIsSignal :: proc(hwchannel: HWChannel, is_signal: bool) -> (ok: bool)
{
    if hwchannel == nil do return
    if !ComConnected() do return

    hr := (^HWChannelIF)(hwchannel)->IsSignalPut(ToVariantBool(is_signal))
    if ComFailed(hr) do return

    return true
}

ReleaseHWChannel :: proc(hwchannel: HWChannel)
{
    if hwchannel != nil {
        (^HWChannelIF)(hwchannel)->Release()
    }
}
