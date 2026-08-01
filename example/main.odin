package main

import "core:fmt"

import cb "../cbopenif"

// odin run main.odin -file -target:windows_i386

main :: proc() {

    cb.connect()

    fmt.println("DataType stuff...")
    {
        ok: bool
        xml, name, type_name, description: string
        count: i32
        datatype: cb.DataType
        component: cb.Component

        datatype, ok = cb.datatype_new(name = "SomeName", description = "SomeDescption")
        defer cb.release(datatype)

        xml, ok = cb.serialize(datatype)
        fmt.println("datatype's xml prior to adding components: \n", xml)

        component, ok = cb.component_new(name = "TestComponent1", type = "bool", description="TestComponent1 Description1")
        if ok {
            cb.component_add(datatype, component)
            cb.release(component)
        }
        
        component, ok = cb.component_new(name = "TestComponent2", type = "real", initial_value = "1.234", description="TestComponent2 Description")
        if ok {
            cb.component_add(datatype, component)
            cb.release(component)
        }

        xml, ok = cb.serialize(datatype)
        fmt.println("datatype's xml after adding components: \n", xml)

        count, ok = cb.component_count(datatype)
        for i in 0..< count {
            component, ok = cb.component_by_index(datatype, i+1)

            name, ok = cb.name(component)
            type_name, ok = cb.type_name(component)
            description, ok = cb.description(component)

            fmt.println("")
            fmt.println("component", i)
            fmt.println("   datatype component name: ", name)
            fmt.println("   datatype component type name: ", type_name)
            fmt.println("   datatype component description: ", description)
            fmt.println("")

            cb.release(component)
        }
    }

    // signals
    fmt.println("Signals stuff...")
    {
        ok: bool
        xml, name, path, direction, acknowledge_group, description: string
        signals: cb.Signals
        signal: cb.Signal

        signal, ok = cb.signal_new("Signal1", "path.to.signal", "in", "some acknowledge group")
        fmt.println("here")
        
        if !ok {
            fmt.println("fail")
        }
        
        if ok {
            fmt.println("")
            fmt.println("", cb.serialize(signal))
            fmt.println("")
            cb.release(signal)
        }
    }
    
    cb.disconnect()
}
