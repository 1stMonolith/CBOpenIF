package cbopenif

import "com"

HardwareFileKind :: enum i32 {
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

HardwareLibraryFileKind :: enum i32 {
    HelpFile = 0,
    IconFile = 1,
}

HWChannel :: struct {
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

HWUnit :: struct {
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

hwunit_from_com :: proc(hwunit: HWUnit, allocator := context.allocator) -> (result: t.HWUnit, ok: bool) {
    if hwunit == nil do return
    context.allocator = allocator

    result.path, ok = path(hwunit)
    if !ok do return
    result.instance_name, ok = instance_name(hwunit)
    if !ok do return
    result.type_id, ok = type_id(hwunit)
    if !ok do return
    result.type_guid, ok = type_guid(hwunit)
    if !ok do return
    result.type_description, ok = hwunit_type_description_get(hwunit)
    if !ok do return
    result.guid, ok = guid(hwunit)
    if !ok do return
    result.reserved_by_function, ok = reserved_by_function(hwunit)
    if !ok do return
    result.hw_simulation, ok = hw_simulation(hwunit)
    if !ok do return
    result.hw_simulation_supported, ok = hw_simulation_supported(hwunit)
    if !ok do return
    result.redundant_pos, ok = redundant_pos(hwunit)
    if !ok do return

    {
        chs: HWChannels
        chs, ok = hwchannels(hwunit)
        if !ok do return
        defer release(chs)
        result.channels, ok = hwchannels_from_com(chs)
        if !ok do return
    }
    {
        units: HWUnits
        units, ok = hwunits(hwunit)
        if !ok do return
        defer release(units)
        result.units, ok = hwunits_from_com(units)
        if !ok do return
    }
    {
        pss: ParameterSettings
        pss, ok = parametersettings(hwunit)
        if !ok do return
        defer release(pss)
        result.parameter_settings, ok = parametersettings_from_com(pss)
        if !ok do return
    }

    return result, true
}

hwunit_to_com :: proc(src: t.HWUnit) -> (result: HWUnit, ok: bool) {
    hwunit: HWUnit
    hwunit, ok = hwunit_new1(src.path, src.type_id, src.type_description, src.guid)
    if !ok do return
    defer if !ok do release(hwunit)

    ok = instance_name(hwunit, src.instance_name)
    if !ok do return
    ok = type_guid(hwunit, src.type_guid)
    if !ok do return
    ok = reserved_by_function(hwunit, src.reserved_by_function)
    if !ok do return
    ok = hw_simulation(hwunit, src.hw_simulation)
    if !ok do return
    ok = hw_simulation_supported(hwunit, src.hw_simulation_supported)
    if !ok do return
    ok = redundant_pos(hwunit, src.redundant_pos)
    if !ok do return

    {
        chs: HWChannels
        chs, ok = hwchannels(hwunit)
        if !ok do return
        defer release(chs)
        ok = hwchannels_to_com(chs, src.channels[:])
        if !ok do return
    }
    {
        units: HWUnits
        units, ok = hwunits(hwunit)
        if !ok do return
        defer release(units)
        ok = hwunits_to_com(units, src.units[:])
        if !ok do return
    }
    {
        pss: ParameterSettings
        pss, ok = parametersettings(hwunit)
        if !ok do return
        defer release(pss)
        ok = parametersettings_to_com(pss, src.parameter_settings[:])
        if !ok do return
    }

    return hwunit, true
}

hwunits_from_com :: proc(units: HWUnits, allocator := context.allocator) -> (result: [dynamic]t.HWUnit, ok: bool) {
    if units == nil do return
    context.allocator = allocator

    count: i32
    count, ok = hwunits_hwunit_count(units) // procs has typo hwunit_vount
    if !ok do return

    result = make([dynamic]t.HWUnit, 0, int(count), allocator)
    for i in 0..<count {
        u: HWUnit
        u, ok = hwunit_by_index(units, i)
        if !ok do return
        defer release(u)

        us: t.HWUnit
        us, ok = hwunit_from_com(u)
        if !ok do return
        append(&result, us)
    }
    return result, true
}

hwunits_to_com :: proc(units: HWUnits, src: []t.HWUnit) -> (ok: bool) {
    if units == nil do return
    for item in src {
        u: HWUnit
        u, ok = hwunit_to_com(item)
        if !ok do return
        defer release(u)
        ok = hwunit_add(units, u)
        if !ok do return
    }
    return true
}

hwchannel_from_com :: proc(hwchannel: HWChannel, allocator := context.allocator) -> (result: t.HWChannel, ok: bool) {
    if hwchannel == nil do return

    context.allocator = allocator

    result.name, ok = name(hwchannel)
    if !ok do return
    result.address, ok = address(hwchannel)
    if !ok do return
    result.min, ok = min(hwchannel)
    if !ok do return
    result.max, ok = max(hwchannel)
    if !ok do return
    result.unit, ok = unit(hwchannel)
    if !ok do return
    result.fraction, ok = fraction(hwchannel)
    if !ok do return
    result.reversed, ok = reversed(hwchannel)
    if !ok do return
    result.con_variable, ok = con_variable(hwchannel)
    if !ok do return
    result.io_description, ok = hwchannel_io_description_get(hwchannel)
    if !ok do return

    return result, true
}

hwchannel_to_com :: proc(src: t.HWChannel) -> (result: HWChannel, ok: bool) {
    hwchannel: HWChannel
    hwchannel, ok = hwchannel_new1(
        src.address,
        src.name,
        src.con_variable,
        src.io_description,
        src.min,
        src.max,
        src.unit,
        src.fraction,
        src.reversed,
    )
    if !ok do return

    return hwchannel, true
}

hwchannels_from_com :: proc(chs: HWChannels, allocator := context.allocator) -> (result: [dynamic]t.HWChannel, ok: bool) {
    if chs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = hwchannel_count(chs)
    if !ok do return

    result = make([dynamic]t.HWChannel, 0, int(count), allocator)
    for i in 0..<count {
        ch: HWChannel
        ch, ok = hwchannel_by_index(chs, i)
        if !ok do return
        defer release(ch)

        chs_: t.HWChannel
        chs_, ok = hwchannel_from_com(ch)
        if !ok do return
        append(&result, chs_)
    }
    return result, true
}

hwchannels_to_com :: proc(chs: HWChannels, src: []t.HWChannel) -> (ok: bool) {
    if chs == nil do return
    for item in src {
        ch: HWChannel
        ch, ok = hwchannel_to_com(item)
        if !ok do return
        defer release(ch)
        ok = hwchannel_add(chs, ch)
        if !ok do return
    }
    return true
}
