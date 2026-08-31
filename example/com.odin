package main

import "core:fmt"

import com "../cbopenif/com"

// using the com interface directly
main :: proc()
{
    ok: bool
    xml, name, type_name, description: string
    count: i32
    datatype: com.DataType
    components: com.Components
    component: com.Component

    com.ConnectCom()

    datatype, ok = com.NewDataType(name = "SomeName", description = "SomeDescption")
    defer com.Release(datatype)

    components, ok = com.GetDataTypeComponents(datatype)
    defer com.Release(components)

    component, ok = com.NewComponentEx(name = "TestComponent1", type_name = "bool", description="TestComponent1 Description")
    if ok
    {
        com.AddComponent(components, component)
        com.Release(component)
    }
    
    component, ok = com.NewComponentEx(name = "TestComponent2", type_name = "real", initial_value = "1.234", description="TestComponent2 Description")
    if ok
    {
        com.AddComponent(components, component)
        com.Release(component)
    }

    count, ok = com.ComponentCount(components)
    for i in 0..< count
    {
        component, ok = com.GetComponent(components, i)

        name, ok = com.Name(component)
        type_name, ok = com.TypeName(component)
        description, ok = com.Description(component)

        fmt.printf("name: %v type: %v description: %v\n", name, type_name, description)

        com.Release(component)
    }

    xml, ok = com.Serialize(datatype)
    fmt.printf("datatype xml:\n%v\n", xml)
    
    com.DisconnectCom()
}
