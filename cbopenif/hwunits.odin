package cbopenif

HWUnits :: distinct rawptr

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

hwunits_hwunit_add :: proc {
    hwunits_hwunit_add_,
    hwunits_hwunit_add_at_index,
}

hwunits_hwunit_add_ :: proc(hwunits: HWUnits, hwunit: HWUnit) -> (ok: bool) {
    if hwunits == nil do return
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Add(hwunit)
    if com_failed(hr) do return

    return true
}

hwunits_hwunit_add_at_index :: proc(hwunits: HWUnits, hwunit: HWUnit, index: i32) -> (ok: bool) {
    if hwunits == nil do return
    if hwunit == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitsIF)(hwunits)->AddBefore(hwunit, index)
    if com_failed(hr) do return

    return true
}

hwunits_hwunit :: proc {
    hwunits_hwunit_by_path,
    hwunits_hwunit_by_index,
}

hwunits_hwunit_by_path :: proc(hwunits: HWUnits, path: string) -> (hwunit: HWUnit, ok: bool) {
    if hwunits == nil do return
    if !controlbuilder_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := (^HWUnitsIF)(hwunits)->Find(bstr_path, cast(^rawptr)&hwunit)
    if com_failed(hr) do return

    return hwunit, true
}

hwunits_hwunit_by_index :: proc(hwunits: HWUnits, index: i32) -> (hwunit: HWUnit, ok: bool) {
    if hwunits == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Item(index, cast(^rawptr)&hwunit)
    if com_failed(hr) do return

    return hwunit, true
}

hwunits_hwunit_index :: proc(hwunits: HWUnits, path: string) -> (index: i32, ok: bool) {
    if hwunits == nil do return
    if !controlbuilder_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := (^HWUnitsIF)(hwunits)->FindNr(bstr_path, &index)
    if com_failed(hr) do return

    return index, true
}

hwunits_hwunit_count :: proc(hwunits: HWUnits) -> (count: i32, ok: bool) {
    if hwunits == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

hwunits_hwunit_remove :: proc {
    hwunits_hwunit_remove_by_path,
    hwunits_hwunit_remove_by_index,
}

hwunits_hwunit_remove_by_path :: proc(hwunits: HWUnits, path: string) -> (ok: bool) {
    if hwunits == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = hwunits_hwunit_index(hwunits, path)
    if !ok do return

    hr := (^HWUnitsIF)(hwunits)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwunits_hwunit_remove_by_index :: proc(hwunits: HWUnits, index: i32) -> (ok: bool) {
    if hwunits == nil do return
    if !controlbuilder_connected() do return

    hr := (^HWUnitsIF)(hwunits)->Remove(index)
    if com_failed(hr) do return

    return true
}

hwunits_release :: proc(hwunits: HWUnits) {
    if hwunits != nil {
        (^HWUnitsIF)(hwunits)->Release()
    }
}
