package component

import "../com"
import "../controlbuilder"
import "../bstr"

Components :: distinct rawptr

ComponentsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ComponentsVTable,
}

ComponentsVTable :: struct {
    using iunknown_vtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^ComponentsIF, Component: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ComponentsIF, Component: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ComponentsIF, Name, TypeName: BStr, Component: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ComponentsIF, Name, TypeName, Attribute, InitialValue, Description: BStr, Component: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ComponentsIF, Name: BStr, Component: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ComponentsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ComponentsIF, Index: i32, Component: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ComponentsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ComponentsIF, Index: i32) -> HResult,
}

components_add :: proc {
    components_add_,
    components_add_at_index,
}

components_add_ :: proc(components: Components, component: Component) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    if component == nil do return

    hr := (^ComponentsIF)(components)->Add(component)
    if com.failed(hr) do return

    return true
}

components_add_at_index :: proc(components: Components, component: Component, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    if component == nil do return
    
    hr := (^ComponentsIF)(components)->AddBefore(component, index)
    if com.failed(hr) do return

    return true
}

components_component :: proc {
    components_component_by_name,
    components_component_by_index,
}

components_component_by_name :: proc(components: Components, name: string) -> (component: Component, ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    
    bstr_name := bstr.from_string(name)
    p: rawptr
    hr := (^ComponentsIF)(components)->Find(bstr_name, &p)
    defer bstr.free(bstr_name)
    if com.failed(hr) do return
    
    return Component(p), true
}

components_component_by_index :: proc(components: Components, index: i32) -> (component: Component, ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    
    p: rawptr
    hr := (^ComponentsIF)(components)->Item(index, &p)
    if com.failed(hr) do return
    
    return Component(p), true
}

components_component_index :: proc(components: Components, name: string) -> (index: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    
    bstr_name := bstr.from_string(name)
    defer bstr.free(bstr_name)
    hr := (^ComponentsIF)(components)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

components_count :: proc(components: Components) -> (count: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    
    hr := (^ComponentsIF)(components)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

components_remove :: proc {
    components_remove_by_name,
    components_remove_by_index,
}

components_remove_by_name :: proc(components: Components, name: string) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return

    index: i32
    index, ok = components_component_index(components, name)
    if !ok do return

    hr := (^ComponentsIF)(components)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

components_remove_by_index :: proc(components: Components, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if components == nil do return
    
    hr := (^ComponentsIF)(components)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

components_release :: proc(components: Components) {
    if components != nil {
        (^ComponentsIF)(components)->Release()
    }
}
