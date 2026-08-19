package main

import "core:fmt"

import cb "../cbopenif"
import com "../cbopenif/com"

// using the com interface directly
main :: proc() {

    com.controlbuilder_connect()

    ok: bool
    xml, name, type_name, description: string
    count: i32
    datatype: com.DataType
    components: com.Components
    component: com.Component

    datatype, ok = com.datatype_new(name = "SomeName", description = "SomeDescption")
    defer com.release(datatype)

    components, ok = com.datatype_components_get(datatype)
    defer com.release(components)

    component, ok = com.component_new1(name = "TestComponent1", type_name = "bool", description="TestComponent1 Description")
    if ok {
        com.component_add(components, component)
        com.release(component)
    }
    
    component, ok = com.component_new1(name = "TestComponent2", type_name = "real", initial_value = "1.234", description="TestComponent2 Description")
    if ok {
        com.component_add(components, component)
        com.release(component)
    }

    count, ok = com.component_count(components)
    for i in 0..< count {
        component, ok = com.component_by_index(components, i)

        name, ok = com.name(component)
        type_name, ok = com.type_name(component)
        description, ok = com.description(component)

        fmt.printf("name: %v type: %v description: %v\n", name, type_name, description)

        com.release(component)
    }

    fmt.print("\n")

    xml, ok = com.serialize(datatype)
    fmt.printf("datatype xml:\n%v\n", xml)

    datatype_struct: cb.DataType
    datatype_struct, ok = com.datatype_from_com(datatype)

    fmt.printf("com -> struct:\n%v\n", datatype_struct)

    datatype2: com.DataType
    datatype2, ok = com.datatype_to_com(datatype_struct)

    fmt.print("\n")

    xml, ok = com.serialize(datatype2)
    fmt.printf("struct -> com -> xml:\n%v\n", xml)
    
    com.controlbuilder_disconnect()
}
