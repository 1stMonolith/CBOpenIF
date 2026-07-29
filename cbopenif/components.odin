package cbopenif

Components :: distinct rawptr

ComponentsIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ComponentsVTable,
}

ComponentsVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:       proc "system" (this: ^ComponentsIF, Component: Component) -> HResult,
    AddBefore: proc "system" (this: ^ComponentsIF, Component: Component, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ComponentsIF, Name, TypeName: BStr, Component: ^Component) -> HResult,
    Add2:      proc "system" (this: ^ComponentsIF, Name, TypeName, Attribute, InitialValue, Description: BStr, Component: ^Component) -> HResult,
    Find:      proc "system" (this: ^ComponentsIF, Name: BStr, Component: ^Component) -> HResult,
    FindNr:    proc "system" (this: ^ComponentsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ComponentsIF, Index: i32, Component: ^Component) -> HResult,
    Count:     proc "system" (this: ^ComponentsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ComponentsIF, Index: i32) -> HResult,
}

components_add :: proc {
    components_add_,
    components_add_at_index,
}

@(private)
components_add_ :: proc(components: Components, component: Component) -> (ok: bool) {
    ok = false

    if !connected() do return
    if components == nil do return
    if component == nil do return

    hr := (^ComponentsIF)(components)->Add(component)
    if failed(hr) do return

    return true
}

components_add_at_index :: proc(components: Components, component: Component, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if components == nil do return
    if component == nil do return
    
    hr := (^ComponentsIF)(components)->AddBefore(component, index)
    if failed(hr) do return

    return true
}

components_component :: proc {
    components_component_by_name,
    components_component_by_index,
}

components_component_by_name :: proc(components: Components, name: string) -> (component: Component, ok: bool) {
    component = nil
    ok = false

    if !connected() do return
    if components == nil do return
    
    bstr_name := string_to_bstr(name)
    SysFreeString(bstr_name)
    hr := (^ComponentsIF)(components)->Find(bstr_name, &component)
    if failed(hr) do return
    
    return component, true
}

components_component_by_index :: proc(components: Components, index: i32) -> (component: Component, ok: bool) {
    component = nil
    ok = false

    if !connected() do return
    if components == nil do return
    
    hr := (^ComponentsIF)(components)->Item(index, &component)
    if failed(hr) do return
    
    return component, true
}

components_component_index :: proc(components: Components, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if components == nil do return
    
    bstr_name := string_to_bstr(name)
    SysFreeString(bstr_name)
    hr := (^ComponentsIF)(components)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

components_count :: proc(components: Components) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if components == nil do return
    
    hr := (^ComponentsIF)(components)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

components_remove :: proc {
    components_remove_by_name,
    components_remove_by_index
}

components_remove_by_name :: proc(components: Components, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if components == nil do return

    index: i32
    index, ok = components_component_index(components, name)
    
    hr := (^ComponentsIF)(components)->Remove(index)
    if failed(hr) do return
    
    return true
}

components_remove_by_index :: proc(components: Components, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if components == nil do return
    
    hr := (^ComponentsIF)(components)->Remove(index)
    if failed(hr) do return
    
    return true
}

components_release :: proc(components: Components) {
    if components != nil {
        (^ComponentsIF)(components)->Release()
    }
}
