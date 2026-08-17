package main

import "core:fmt"

import com "../cbopenif/com"

// odin run com.odin -file -target:windows_i386


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

    xml, ok = com.serialize(datatype)
    fmt.printf("datatype xml:\n%v\n", xml)
    
    com.controlbuilder_disconnect()
}
