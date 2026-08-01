package main

import "core:fmt"

import cb "../cbopenif"

// odin run main.odin -file -target:windows_i386

main :: proc() {

    xml, component_name, component_type_name, component_description: string
    component_count: i32
    ok: bool
    dt: cb.DataType
    dt_component: cb.Component

    cb.connect()

    dt, ok = cb.datatype_new(name = "SomeName", description = "SomeDescption")

    xml, ok = cb.serialize(dt)
    fmt.println("", xml)

    component_count, ok = cb.component_count(dt)
    fmt.println("datatype component count: ", component_count)

    dt_component, ok = cb.component_new(name = "TestComponent1", type = "bool", description="Great Description")
    ok = cb.component_add(dt, dt_component)
    
    dt_component, ok = cb.component_new(name = "TestComponent2", type = "real", description="Greater Description")
    ok = cb.component_add(dt, dt_component)

    component_count, ok = cb.component_count(dt)
    fmt.println("datatype component count: ", component_count)

    for i in 0..< component_count {
        dt_component, ok = cb.component_by_index(dt, i+1)

        component_name, ok = cb.name(dt_component)
        component_type_name, ok = cb.type_name(dt_component)
        component_description, ok = cb.description(dt_component)

        fmt.println("   datatype component name: ", component_name)
        fmt.println("   datatype component type name: ", component_type_name)
        fmt.println("   datatype component description: ", component_description)
    }

    xml, ok = cb.serialize(dt)
    fmt.println("", xml)

    cb.disconnect()
}
