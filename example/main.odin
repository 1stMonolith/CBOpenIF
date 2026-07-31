package main

import "core:fmt"
import cb "../cbopenif/controlbuilder"
import "../cbopenif/type"
import "../cbopenif/component"

// odin run main.odin -file -target:windows_i386

main :: proc() {

    component_name, component_type_name, component_description: string
    component_count: i32
    ok: bool
    dt, dt_components, dt_component: rawptr
    xml: string

    cb.connect()

    dt, ok = type.datatype_new(name = "SomeName", description = "SomeDescption")
    defer type.datatype_release(dt)

    xml, ok = type.datatype_serialize(dt)
    fmt.println("", xml)

    dt_components, ok = type.datatype_components_get(dt)

    component_count, ok = component.components_count(dt_components)
    fmt.println("datatype component count: ", component_count)

    dt_component, ok = component.component_new(name = "TestComponent1", type = "bool", description="Great Description")
    component.components_add(dt_components, dt_component)
    
    dt_component, ok = component.component_new(name = "TestComponent2", type = "real", description="Greater Description")
    component.components_add(dt_components, dt_component)

    component_count, ok = component.components_count(dt_components)
    fmt.println("datatype component count: ", component_count)

    for i in 0..< component_count {
        dt_component, ok = component.components_component(dt_components, i+1)

        component_name, ok = component.component_name_get(dt_component)
        component_type_name, ok = component.component_type_name_get(dt_component)
        component_description, ok = component.component_description_get(dt_component)

        fmt.println("   datatype component name: ", component_name)
        fmt.println("   datatype component type name: ", component_type_name)
        fmt.println("   datatype component description: ", component_description)
    }

    xml, ok = type.datatype_serialize(dt)
    fmt.println("", xml)

    cb.disconnect()
}