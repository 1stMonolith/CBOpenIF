package main

import "core:fmt"
import cb "../cbopenif"

// odin run main.odin -file -target:windows_i386

main :: proc() {

    component_name, component_type_name, component_description: string
    component_count: i32
    ok: bool

    dt: cb.DataType
    dt_component: cb.Component

    xml: string

    cb.connect()

    dt, ok = cb.datatype_new(name = "SomeName", description = "SomeDescption")
    defer cb.release(dt)

    component_count, ok = cb.count(dt)
    fmt.println("datatype component count: ", component_count)

    dt_component, ok = cb.component_new(name = "TestComponent1", type = "bool", description="Some Great Description")
    cb.add(dt, dt_component)
    
    dt_component, ok = cb.component_new(name = "TestComponent2", type = "real", description="Some Other Great Description")
    cb.add(dt, dt_component)

    component_count, ok = cb.count(dt)
    fmt.println("datatype component count: ", component_count)

    for i in 0..< component_count {
        dt_component, ok = cb.datatype_component(dt, i+1)

        component_name, ok = cb.name(dt_component)
        component_type_name, ok = cb.type_name(dt_component)
        component_description, ok = cb.description(dt_component)

        fmt.println("   datatype component name: ", component_name)
        fmt.println("   datatype component type name: ", component_type_name)
        fmt.println("   datatype component description: ", component_description)
    }

    application_variables: cb.ApplicationVariables
    application_variables, ok = cb.applicationvariables_new()
    
    variable: cb.Variable
    variable, ok = cb.variable_new("TestVariable", "bool")
    cb.add(application_variables, variable)

    cb.remove(application_variables, "TestVariable", cb.As_Varialbe)

    xml, ok = cb.serialize(dt)
    fmt.printf(xml)

    cb.disconnect()
}