package cbopenif

import "com"

HardwareFileKind :: enum i32
{
    Firmware         = 0,
    Update           = 1,
    FirmwareIdx      = 2,
    PHControlBuilder = 3,
    PHController     = 4,
    PHIdx            = 5,
    Help             = 6,
    FWFunctions      = 7,
    CopyRoutines     = 8,
}

HardwareLibraryFileKind :: enum i32
{
    HelpFile = 0,
    IconFile = 1,
}

HWChannel :: struct
{
    name:           string,
    address:        string,
    unit:           string,
    min:            string,
    max:            string,
    fraction:       string,
    reversed:       bool,
    con_variable:   string,
    io_description: string,
}

HWUnit :: struct
{
    path:                    string,
    instance_name:           string,
    type_id:                 string,
    type_guid:               string,
    type_description:        string,
    guid:                    string,
    reserved_by_function:    string,
    hw_simulation:           bool,
    hw_simulation_supported: bool,
    redundant_pos:           string,
    channels:                [dynamic]HWChannel,
    hw_units:                [dynamic]HWUnit,
    parameter_settings:      [dynamic]ParameterSetting,
}

HWUnitsFromCom :: proc(comhwunits: com.HWUnits, hwunits: ^[dynamic]HWUnit) -> (ok: bool)
{
    if comhwunits == nil do return

    count: i32
    count, ok = com.HWUnitCount(comhwunits)
    if !ok do return

    for i in 0..<count {
        comhwunit: com.HWUnit
        comhwunit, ok = com.GetHWUnit(comhwunits, i)
        if !ok do return
        defer com.Release(comhwunit)

        hwunit: HWUnit
        hwunit, ok = HWUnitFromCom(comhwunit)
        if !ok do return
        append(hwunits, hwunit)
    }

    return true
}

HWUnitFromCom :: proc(comhwunit: com.HWUnit) -> (hwunit: HWUnit, ok: bool)
{
    if comhwunit == nil do return

    hwunit.path, ok = com.Path(comhwunit)
    if !ok do return

    hwunit.instance_name, ok = com.InstanceName(comhwunit)
    if !ok do return

    hwunit.type_id, ok = com.ID(comhwunit)
    if !ok do return

    hwunit.type_guid, ok = com.TypeGuid(comhwunit)
    if !ok do return

    hwunit.type_description, ok = com.GetHWUnitDescription(comhwunit)
    if !ok do return

    hwunit.guid, ok = com.Guid(comhwunit)
    if !ok do return

    hwunit.reserved_by_function, ok = com.ReservedBy(comhwunit)
    if !ok do return

    hwunit.hw_simulation, ok = com.Simulation(comhwunit)
    if !ok do return

    hwunit.hw_simulation_supported, ok = com.SimulationSupported(comhwunit)
    if !ok do return

    hwunit.redundant_pos, ok = com.RedundantPos(comhwunit)
    if !ok do return

    comhwchannels: com.HWChannels
    comhwchannels, ok = com.GetHWChannels(comhwunit)
    if !ok do return
    defer com.Release(comhwchannels)
    ok = HWChannelsFromCom(comhwchannels, &hwunit.channels)
    if !ok do return

    comhwunits: com.HWUnits
    comhwunits, ok = com.GetHWUnitHwUnits(comhwunit)
    if !ok do return
    defer com.Release(comhwunits)
    ok = HWUnitsFromCom(comhwunits, &hwunit.hw_units)
    if !ok do return

    comparametersettings: com.ParameterSettings
    comparametersettings, ok = com.GetParameterSettings(comhwunit)
    if !ok do return
    defer com.Release(comparametersettings)
    ok = ParameterSettingsFromCom(comparametersettings, &hwunit.parameter_settings)
    if !ok do return

    return hwunit, true
}

HWUnitsToCom :: proc(comhwunits: com.HWUnits, hwunits: []HWUnit) -> (ok: bool)
{
    if comhwunits == nil do return
    
    for hwu in hwunits {
        comhwunit: com.HWUnit
        comhwunit, ok = HWUnitToCom(hwu)
        if !ok do return
        defer com.Release(comhwunit)

        ok = com.AddHWUnit(comhwunits, comhwunit)
        if !ok do return
    }

    return true
}

HWUnitToCom :: proc(hwu: HWUnit) -> (comhwunit: com.HWUnit, ok: bool)
{
    comhwunit, ok = com.NewHWUnitEx(hwu.path, hwu.type_id, hwu.type_description, hwu.guid)
    if !ok do return
    defer if !ok do com.Release(comhwunit)

    ok = com.InstanceName(comhwunit, hwu.instance_name)
    if !ok do return

    ok = com.TypeGuid(comhwunit, hwu.type_guid)
    if !ok do return

    ok = com.ReservedBy(comhwunit, hwu.reserved_by_function)
    if !ok do return

    ok = com.Simulation(comhwunit, hwu.hw_simulation)
    if !ok do return

    ok = com.SimulationSupported(comhwunit, hwu.hw_simulation_supported)
    if !ok do return

    ok = com.RedundantPos(comhwunit, hwu.redundant_pos)
    if !ok do return

    comhwchannels: com.HWChannels
    comhwchannels, ok = com.GetHWChannels(comhwunit)
    if !ok do return
    defer com.Release(comhwchannels)
    ok = HWChannelsToCom(comhwchannels, hwu.channels[:])
    if !ok do return

    comhwunits: com.HWUnits
    comhwunits, ok = com.GetHWUnitHwUnits(comhwunit)
    if !ok do return
    defer com.Release(comhwunits)
    ok = HWUnitsToCom(comhwunits, hwu.hw_units[:])
    if !ok do return

    comparametersettings: com.ParameterSettings
    comparametersettings, ok = com.GetParameterSettings(comhwunit)
    if !ok do return
    defer com.Release(comparametersettings)
    ok = ParameterSettingsToCom(comparametersettings, hwu.parameter_settings[:])
    if !ok do return

    return comhwunit, true
}

HWChannelsFromCom :: proc(comhwchannels: com.HWChannels, hwchannels: ^[dynamic]HWChannel) -> (ok: bool)
{
    if comhwchannels == nil do return

    count: i32
    count, ok = com.HWChannelCount(comhwchannels)
    if !ok do return

    for i in 0..<count {
        comhwchannel: com.HWChannel
        comhwchannel, ok = com.GetHWChannel(comhwchannels, i)
        if !ok do return
        defer com.Release(comhwchannel)

        hwchannel: HWChannel
        hwchannel, ok = HWChannelFromCom(comhwchannel)
        if !ok do return
        append(hwchannels, hwchannel)
    }
    return true
}

HWChannelFromCom :: proc(comhwchannel: com.HWChannel) -> (hwchannel: HWChannel, ok: bool)
{
    if comhwchannel == nil do return

    hwchannel.name, ok = com.Name(comhwchannel)
    if !ok do return

    hwchannel.address, ok = com.Address(comhwchannel)
    if !ok do return

    hwchannel.min, ok = com.Min(comhwchannel)
    if !ok do return

    hwchannel.max, ok = com.Max(comhwchannel)
    if !ok do return

    hwchannel.unit, ok = com.Unit(comhwchannel)
    if !ok do return

    hwchannel.fraction, ok = com.Fraction(comhwchannel)
    if !ok do return

    hwchannel.reversed, ok = com.Reversed(comhwchannel)
    if !ok do return

    hwchannel.con_variable, ok = com.ConVariable(comhwchannel)
    if !ok do return

    hwchannel.io_description, ok = com.GetHWChannelIODescription(comhwchannel)
    if !ok do return

    return hwchannel, true
}

HWChannelsToCom :: proc(comhwchannels: com.HWChannels, hwchannels: []HWChannel) -> (ok: bool)
{
    if comhwchannels == nil do return

    for hwc in hwchannels {
        comhwchannel: com.HWChannel
        comhwchannel, ok = HWChannelToCom(hwc)
        if !ok do return
        defer com.Release(comhwchannel)

        ok = com.AddHWChannel(comhwchannels, comhwchannel)
        if !ok do return
    }

    return true
}

HWChannelToCom :: proc(hwchannel: HWChannel) -> (comhwchannel: com.HWChannel, ok: bool)
{
    comhwchannel, ok = com.NewHWChannelEx(
        hwchannel.address,
        hwchannel.name,
        hwchannel.con_variable,
        hwchannel.io_description,
        hwchannel.min,
        hwchannel.max,
        hwchannel.unit,
        hwchannel.fraction,
        hwchannel.reversed,
    )
    if !ok do return

    return comhwchannel, true
}
