package main

import "core:fmt"

import cb "../cbopenif"

// odin run main.odin -file -target:windows_i386

main :: proc() {

    cb.controlbuilder_connect()

    fmt.println("FunctionBlockType...")
    {
        functionblocktype, _ := cb.functionblocktype_new("SomeFunctionBlockType", "some function block type description")
        
        codeblocks, _ := cb.codeblocks(functionblocktype)

        stcodeblock, _ := cb.stcodeblock_new("SomeSTCodeBlock", "(* hello! *)")
        cb.codeblock_add(codeblocks, stcodeblock)
        cb.release(stcodeblock)
        
        fbdcodeblock, _ := cb.fbdcodeblock_new("SomeFBDCodeBlock", "")
        cb.codeblock_add(codeblocks, fbdcodeblock)
        cb.release(fbdcodeblock)

        codeblock1, _ := cb.codeblock(codeblocks, 1)
        fmt.println(" kind:", codeblock1.kind)
        fmt.println("block:", codeblock1.block)
        
        // Need a way to do this...
        //fmt.println("name: ", cb.name(codeblock1))
        //cb.release(codeblock1)

        codeblock2, _ := cb.codeblock(codeblocks, 2)
        fmt.println(" kind:", codeblock2.kind)
        fmt.println("block:", codeblock2.block)
        
        // Need a way to do this...
        //fmt.println("name: ", cb.name(codeblock2))
        //cb.release(codeblock2)

        xml, _ := cb.serialize(functionblocktype)

        fmt.println("", xml)
        cb.release(functionblocktype)
    }

    fmt.println("Application Variables...")
    {
        application_variable, ok := cb.applicationvariables_new()
        defer cb.release(application_variable)
    }

    // Auto Point
    fmt.println("Auto Point...")
    {
        auto_point, ok := cb.autopoint_new(cb.AutoPosType.Top)
        defer cb.release(auto_point)
    }

    // Control Builder
    fmt.println("Control Builder...")
    {
        ok := cb.controlbuilder_setting("ProjectsFolder", "SomeSettingValue")
    }

    fmt.println("DataType...")
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
            fmt.println("   name: ", name)
            fmt.println("   type name: ", type_name)
            fmt.println("   description: ", description)
            fmt.println("")

            cb.release(component)
        }
    }

    fmt.println("Signals...")
    {
        ok: bool
        xml, name, path, direction, acknowledge_group, description: string
        signals: cb.Signals
        signal: cb.Signal

        signal, ok = cb.signal_new("S1", "path.to.S1", "In", "")
        fmt.println("", cb.serialize(signal))
        cb.release(signal)
    }
    
    cb.controlbuilder_disconnect()
}
