package cbopenif

DiagramInstances :: distinct rawptr

DiagramInstancesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^DiagramInstancesVTable,
}

DiagramInstancesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^DiagramInstancesIF, DiagramInstance: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^DiagramInstancesIF, DiagramInstance: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^DiagramInstancesIF, Name, TypeName: BStr, DiagramInstance: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^DiagramInstancesIF, Name, TypeName, Guid, Description: BStr, DiagramInstance: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^DiagramInstancesIF, Name: BStr, DiagramInstance: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^DiagramInstancesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^DiagramInstancesIF, Index: i32, DiagramInstance: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^DiagramInstancesIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^DiagramInstancesIF, Index: i32) -> HResult,
}

diagraminstances_add :: proc {
    diagraminstances_diagraminstance_add_,
    diagraminstances_diagraminstance_add_at_index,
}

diagraminstances_diagraminstance_add_ :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance) -> (ok: bool) {
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Add(diagraminstance)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_add_at_index :: proc(diagraminstances: DiagramInstances, diagraminstance: DiagramInstance, index: i32) -> (ok: bool) {
    if diagraminstances == nil do return
    if diagraminstance == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->AddBefore(diagraminstance, index)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance :: proc {
    diagraminstances_diagraminstance_by_name,
    diagraminstances_diagraminstance_by_index,
}

diagraminstances_diagraminstance_by_name :: proc(diagraminstances: DiagramInstances, name: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->Find(bstr_name, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstances_diagraminstance_by_index :: proc(diagraminstances: DiagramInstances, index: i32) -> (diagraminstance: DiagramInstance, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Item(index + 1, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return

    return diagraminstance, true
}

diagraminstances_diagraminstance_index :: proc(diagraminstances: DiagramInstances, name: string) -> (index: i32, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^DiagramInstancesIF)(diagraminstances)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index - 1, true
}

diagraminstances_diagraminstance_count :: proc(diagraminstances: DiagramInstances) -> (count: i32, ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

diagraminstances_diagraminstance_remove :: proc {
    diagraminstances_diagraminstance_remove_by_name,
    diagraminstances_diagraminstance_remove_by_index,
}

diagraminstances_diagraminstance_remove_by_name :: proc(diagraminstances: DiagramInstances, name: string) -> (ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = diagraminstances_diagraminstance_index(diagraminstances, name)
    if !ok do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index)
    if com_failed(hr) do return

    return true
}

diagraminstances_diagraminstance_remove_by_index :: proc(diagraminstances: DiagramInstances, index: i32) -> (ok: bool) {
    if diagraminstances == nil do return
    if !controlbuilder_connected() do return

    hr := (^DiagramInstancesIF)(diagraminstances)->Remove(index + 1)
    if com_failed(hr) do return

    return true
}

diagraminstances_release :: proc(diagraminstances: DiagramInstances) {
    if diagraminstances != nil {
        (^DiagramInstancesIF)(diagraminstances)->Release()
    }
}
