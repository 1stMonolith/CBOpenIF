package main

import "core:fmt"

import cb "../cbopenif"

// odin run main.odin -file -target:windows_i386

main :: proc() {

    cb.controlbuilder_connect()

    fmt.println("FunctionBlockType...")
    {
        ok: bool
        count: i32
        type_name, type_description, block_name, stcode, xml: string
        functionblocktype: cb.FunctionBlockType
        stcodeblock: cb.STCodeBlock
        fbdcodeblock: cb.FBDCodeBlock
        codeblock: cb.CodeBlock

        type_name = "SomeFunctionBlockType"
        type_description = "some function block type description"
        fmt.printf("creating new functionblocktype with name '%v' and description '%v'... ", type_name, type_description)
        functionblocktype, ok = cb.functionblocktype_new(type_name, type_description)
        if !ok {
            fmt.print("failed\n")
            return
        }
        fmt.print("success\n")
        defer cb.release(functionblocktype)

        block_name = "SomeSTCodeBlock"
        stcode = "(* hello! *)"
        fmt.printf("creating new stcodeblock with name '%v' and stcode '%v'... ", block_name, stcode)
        stcodeblock, ok = cb.stcodeblock_new(block_name, stcode)
        if !ok {
            fmt.println("failed\n")
            return
        }
        fmt.print("success\n")
        fmt.print("adding codeblock to functionblocktype... ")
        cb.codeblock_add(functionblocktype, stcodeblock)
        if !ok {
            fmt.print("failed\n")
            return
        }
        fmt.print("success\n")
        cb.release(stcodeblock)

        block_name = "SomeFBDCodeBlock"
        stcode = ""
        fmt.printf("creating new fbdcodeblock with name '%v' and stcode '%v'... ", block_name, stcode)
        fbdcodeblock, ok = cb.fbdcodeblock_new(block_name, stcode)
        if !ok {
            fmt.println("failed\n")
            return
        }
        fmt.print("success\n")
        fmt.print("adding codeblock to functionblocktype... ")
        cb.codeblock_add(functionblocktype, fbdcodeblock)
        if !ok {
            fmt.print("failed\n")
            return
        }
        fmt.print("success\n")
        cb.release(fbdcodeblock)

        fmt.print("getting functionblocktype's codeblock count... ")
        count, ok = cb.codeblock_count(functionblocktype)
        if !ok {
            fmt.print("failed\n")
            return
        }
        fmt.printf("success count=%v\n", count)

        for i in 0..< count {
            codeblock, ok = cb.codeblock(functionblocktype, i)
            block_name, ok = cb.name(codeblock)
            stcode, ok = cb.stcode(codeblock)
            fmt.printfln("codeblock at index %v and name '%v' and stcode '%v'", i, block_name, stcode)
            cb.release(codeblock)
        }

        fmt.printfln("%v", xml)
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
