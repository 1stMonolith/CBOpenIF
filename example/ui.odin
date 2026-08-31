#+feature dynamic-literals

package main

import "core:fmt"
import rl "vendor:raylib"
import cb "../cbopenif"

NUMBER_OF_APPLICATIONS   :: 3
NUMBER_OF_SUPPLIES       :: 3
NUMBER_OF_SECTIONS       :: 15
DRIVES_PER_SECTION       :: 2
SUPPLIES_PER_APPLICATION :: 1
SECTIONS_PER_APPLICATION :: 5
DRIVES_PER_APPLICATION   :: 10

main :: proc()
{
    y:  f32 = 20
    x:  f32 = 20
    bw: f32 = 150
    bh: f32 = 30

    rl.InitWindow(i32(bw + 2*x), i32(bh*7 + 5*7 + 2*y), "CBOpenIF UI Example")
    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose()
    {
        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)

        if cb.Connected() do rl.GuiDisable()

        x = 20
        y = 20
        if rl.GuiButton({x, y, bw, bh}, "Connect") do cb.Connect()

        if cb.Connected() do rl.GuiEnable()

        if !cb.Connected() do rl.GuiDisable()

        y = y + bh + 5
        if rl.GuiButton({x, y, bw, bh}, "Disconnect") do cb.Disconnect()

        y = y + bh + 5
        if rl.GuiButton({x, y, bw, bh}, "Make DataTypes") do makeDataTypes()

        y = y + bh + 5
        if rl.GuiButton({x, y, bw, bh}, "Make ControlModuleTypes") do makeControlModuleTypes()

        y = y + bh + 5
        if rl.GuiButton({x, y, bw, bh}, "Make Applications") do makeApplications()

        y = y + bh + 5
        if rl.GuiButton({x, y, bw, bh}, "Make Controllers") do makeControllers()

        if !cb.Connected() do rl.GuiEnable()

        rl.EndDrawing()
    }

    cb.Disconnect()
    rl.CloseWindow()
}

makeDataTypes :: proc()
{
    cb.NewLibrary("MyTypeLib", "")

    commondata_dt : cb.DataType = {
        name = "CommonData",
        description = "CommonData DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
        components = {
            cb.Component {name = "Comp1", type = "bool",  initialvalue = "false", description = "Comp1 of type bool"},
            cb.Component {name = "Comp2", type = "real",  initialvalue = "0.0",   description = "Comp2 of type real"},
            cb.Component {name = "Comp3", type = "dint",  initialvalue = "0",     description = "Comp3 of type dint"},
            cb.Component {name = "Comp4", type = "dword", initialvalue = "16#0",  description = "Comp4 of type dword"},
        },
    }
    cb.NewDataType("MyTypeLib", commondata_dt)


    drivedata_dt : cb.DataType = {
        name = "DriveData",
        description = "DriveData DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
        components = {
            cb.Component {name = "Comp1", type = "bool",  initialvalue = "false", description = "Comp1 of type bool"},
            cb.Component {name = "Comp2", type = "real",  initialvalue = "0.0",   description = "Comp2 of type real"},
            cb.Component {name = "Comp3", type = "dint",  initialvalue = "0",     description = "Comp3 of type dint"},
            cb.Component {name = "Comp4", type = "dword", initialvalue = "16#0",  description = "Comp4 of type dword"},
        },
    }
    cb.NewDataType("MyTypeLib", drivedata_dt)

    sectiondata_dt : cb.DataType = {
        name = "SectionData",
        description = "SectionData DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
        components = {
            cb.Component {name = "Comp1", type = "bool",  initialvalue = "false", description = "Comp1 of type bool"},
            cb.Component {name = "Comp2", type = "real",  initialvalue = "0.0",   description = "Comp2 of type real"},
            cb.Component {name = "Comp3", type = "dint",  initialvalue = "0",     description = "Comp3 of type dint"},
            cb.Component {name = "Comp4", type = "dword", initialvalue = "16#0",  description = "Comp4 of type dword"},
        },
    }
    cb.NewDataType("MyTypeLib", sectiondata_dt)

    supplydata_dt : cb.DataType = {
        name = "SupplyData",
        description = "SupplyData DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
        components = {
            cb.Component {name = "Comp1", type = "bool",  initialvalue = "false", description = "Comp1 of type bool"},
            cb.Component {name = "Comp2", type = "real",  initialvalue = "0.0",   description = "Comp2 of type real"},
            cb.Component {name = "Comp3", type = "dint",  initialvalue = "0",     description = "Comp3 of type dint"},
            cb.Component {name = "Comp4", type = "dword", initialvalue = "16#0",  description = "Comp4 of type dword"},
        },
    }
    cb.NewDataType("MyTypeLib", supplydata_dt)

    updparms_dt : cb.DataType = {
        name = "UDPParams",
        description = "UDPParams DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
        components = {
            cb.Component {name = "ItemsToSend",     type = "dint",       initialvalue = "0",                 description = "0=all, 32, 64, 128, or 256"},
            cb.Component {name = "IP",              type = "string[15]", initialvalue = "'192.168.80.200'",  description = "ip address"},
            cb.Component {name = "Port",            type = "uint",       initialvalue = "0",                 description = "port number"},
            cb.Component {name = "ResetOnDownlaod", type = "bool",       initialvalue = "0",                 description = "true = resets sequence counter"},
        },
    }
    cb.NewDataType("MyTypeLib", updparms_dt)

    udpmessage_dt : cb.DataType = {
        name = "UDPMessage",
        description = "UDPMessageData DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
    }

    for i in 0..<256 {
        c : cb.Component = {name = fmt.tprintf("V%03d", i), type = "dword", attribute = "hidden", initialvalue = "0"}
        append(&udpmessage_dt.components, c)
    }

    cb.NewDataType("MyTypeLib", udpmessage_dt)

    udpmessages_dt : cb.DataType = {
        name = "UDPMessage10",
        description = "UDPMessage10 DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
    }

    udpparams_dt : cb.DataType = {
        name = "UDPParams10",
        description = "UDPParams10 DataType",
        protected = false,
        hidden = false,
        scope = cb.Scope.Public,
    }

    for i in 0..<10 {
        m : cb.Component = {name = fmt.tprintf("M%01d", i+1), type = "UDPMessage", attribute = "retain"}
        p : cb.Component = {name = fmt.tprintf("M%01d", i+1), type = "UDPParams",  attribute = "retain"}
        append(&udpmessages_dt.components, m)
        append(&udpparams_dt.components, p)
    }
    cb.NewDataType("MyTypeLib", udpmessages_dt)
    cb.NewDataType("MyTypeLib", udpparams_dt)

    supplyCount  := 0
    driveCount   := 0
    sectionCount := 0
    
    for i in 0..<NUMBER_OF_APPLICATIONS
    {
        supplydata_ax_dt : cb.DataType = {
            name = fmt.tprintf("SupplyData_A%01d", i+1),
            description = fmt.tprintf("SupplyData_A%01d DataType", i+1),
            protected = false,
            hidden = false,
            scope = cb.Scope.Public,
            components = { cb.Component {name = "SupXXX", type = "SupplyData"} }
        }

        for i in 0..<SUPPLIES_PER_APPLICATION {
            c : cb.Component = {name = fmt.tprintf("Sup%02d", supplyCount+1), type = "SupplyData"}
            append(&supplydata_ax_dt.components, c)
            supplyCount += 1
        }
        cb.NewDataType("MyTypeLib", supplydata_ax_dt)

        drivedata_ax_dt : cb.DataType = {
            name = fmt.tprintf("DriveData_A%01d", i+1),
            description = fmt.tprintf("Drive_A%01d DataType", i+1),
            protected = false,
            hidden = false,
            scope = cb.Scope.Public,
            components = { cb.Component {name = "DXXX", type = "DriveData"} }
        }

        for i in 0..<DRIVES_PER_APPLICATION {
            c : cb.Component = {name = fmt.tprintf("D%02d", driveCount+1), type = "DriveData"}
            append(&drivedata_ax_dt.components, c)
            driveCount += 1
        }
        cb.NewDataType("MyTypeLib", drivedata_ax_dt)

        sectiondata_ax_dt : cb.DataType = {
            name = fmt.tprintf("SectionData_A%01d", i+1),
            description = fmt.tprintf("SectionData_A%02d DataType", i+1),
            protected = false,
            hidden = false,
            scope = cb.Scope.Public,
            components = { cb.Component {name = "SXXX", type = "SectionData"} }
        }

        for i in 0..<SECTIONS_PER_APPLICATION {
            c : cb.Component = {name = fmt.tprintf("S%02d", sectionCount+1), type = "SectionData"}
            append(&sectiondata_ax_dt.components, c)
            sectionCount += 1
        }
        cb.NewDataType("MyTypeLib", sectiondata_ax_dt)
    }
}

makeControlModuleTypes :: proc()
{
    cb.NewLibrary("MyTypeLib", "")

    driveinterface_cmt : cb.ControlModuleType = {
        name = "DriveInterface",
        scope = cb.Scope.Public,
        graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
        parameters = {
            cb.Parameter {name = "Common", type = "CommonData", fdport = "yes", direction = cb.Direction.Unspecified},
            cb.Parameter {name = "Drive",  type = "DriveData",  fdport = "yes", direction = cb.Direction.Unspecified},
        },
        variables = {
            cb.Variable {name = "LocalVariable", type = "bool", attribute = "nosort retain"},
        },
        codeblocks = {
            cb.CodeBlock {name = "Start_Block", stcode = "(* Start Block *)\n\nLocalVariable := Drive.Comp1;\n"}
        }
    }
    cb.NewControlModuleType("MyTypeLib", driveinterface_cmt)

    supplyinterface_cmt : cb.ControlModuleType = {
        name = "SupplyInterface",
        scope = cb.Scope.Public,
        graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
        parameters = {
            cb.Parameter {name = "Common", type = "CommonData", fdport = "yes", direction = cb.Direction.Unspecified},
            cb.Parameter {name = "Supply", type = "SupplyData", fdport = "yes", direction = cb.Direction.Unspecified},
        },
        variables = {
            cb.Variable {name = "LocalVariable", type = "bool", attribute = "nosort retain"},
        },
        codeblocks = {
            cb.CodeBlock {kind = cb.CodeBlockKind.ST, name = "Start_Block", stcode = "(* Start Block *)\n\nLocalVariable := Supply.Comp1;\n"}
        }
    }
    cb.NewControlModuleType("MyTypeLib", supplyinterface_cmt)

    paneldrive_cmt : cb.ControlModuleType = {
        name = "PanelDrive",
        scope = cb.Scope.Public,
        graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
        parameters = {
            cb.Parameter {name = "Common", type = "CommonData", fdport = "yes", direction = cb.Direction.Unspecified},
            cb.Parameter {name = "Drive",  type = "DriveData",  fdport = "yes", direction = cb.Direction.Unspecified},
        },
        variables = {
            cb.Variable {name = "LocalVariable", type = "bool", attribute = "nosort retain"},
        },
        codeblocks = {
            cb.CodeBlock {kind = cb.CodeBlockKind.ST, name = "Start_Block", stcode = "(* Start Block *)\n\nLocalVariable := Drive.Comp1;\n"}
        }
    }
    cb.NewControlModuleType("MyTypeLib", paneldrive_cmt)

    panelSection_cmt : cb.ControlModuleType = {
        name = "PanelSection",
        scope = cb.Scope.Public,
        graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
        parameters = {
            cb.Parameter {name = "Common",  type = "CommonData",  fdport = "yes", direction = cb.Direction.Unspecified},
            cb.Parameter {name = "Section", type = "SectionData", fdport = "yes", direction = cb.Direction.Unspecified},
        },
        variables = {
            cb.Variable {name = "LocalVariable", type = "bool", attribute = "nosort retain"},
        },
        codeblocks = {
            cb.CodeBlock {kind = cb.CodeBlockKind.ST, name = "Start_Block", stcode = "(* Start Block *)\n\nLocalVariable := Section.Comp1;\n"}
        }
    }
    cb.NewControlModuleType("MyTypeLib", panelSection_cmt)

    panelSupply_cmt : cb.ControlModuleType = {
        name = "PanelSupply",
        scope = cb.Scope.Public,
        graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
        parameters = {
            cb.Parameter {name = "Common", type = "CommonData", fdport = "yes", direction = cb.Direction.Unspecified},
            cb.Parameter {name = "Supply",  type = "SupplyData",  fdport = "yes", direction = cb.Direction.Unspecified},
        },
        variables = {
            cb.Variable {name = "LocalVariable", type = "bool", attribute = "nosort retain"},
        },
        codeblocks = {
            cb.CodeBlock {kind = cb.CodeBlockKind.ST, name = "Start_Block", stcode = "(* Start Block *)\n\nLocalVariable := Supply.Comp1;\n"}
        }
    }
    cb.NewControlModuleType("MyTypeLib", panelSupply_cmt)

    driveCount := 0
    supplyCount := 0
    sectionCount := 0

    for i in 0..<NUMBER_OF_APPLICATIONS
    {
        driveinterface_ax_cmt : cb.ControlModuleType = {
            name = fmt.tprintf("DriveInterface_A%01d", i+1),
            scope = cb.Scope.Public,
            graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
            parameters = {
                cb.Parameter {name = "Common",   type = "CommonData",                          fdport = "yes", direction = cb.Direction.Unspecified},
                cb.Parameter {name = "Drives",   type = fmt.tprintf("DriveData_A%01d", i+1),   fdport = "yes", direction = cb.Direction.Unspecified},
                cb.Parameter {name = "Supplies", type = fmt.tprintf("SupplyData_A%01d", i+1),  fdport = "yes", direction = cb.Direction.Unspecified},
            },
        }

        panelinterface_ax_cmt : cb.ControlModuleType = {
            name = fmt.tprintf("PanelInterface_A%01d", i+1),
            scope = cb.Scope.Public,
            graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
            parameters = {
                cb.Parameter {name = "Common",   type = "CommonData",                          fdport = "yes", direction = cb.Direction.Unspecified},
                cb.Parameter {name = "Drives",   type = fmt.tprintf("DriveData_A%01d", i+1),   fdport = "yes", direction = cb.Direction.Unspecified},
                cb.Parameter {name = "Sections", type = fmt.tprintf("SectionData_A%01d", i+1), fdport = "yes", direction = cb.Direction.Unspecified},
                cb.Parameter {name = "Supplies", type = fmt.tprintf("SupplyData_A%01d", i+1),  fdport = "yes", direction = cb.Direction.Unspecified},
            },
        }

        node_ax_cmt : cb.ControlModuleType = {
            name = fmt.tprintf("Node_A%01d", i+1),
            scope = cb.Scope.Public,
            graphsize = cb.GraphSize { cb.Point{-1.0,-1.0}, cb.Point{1.0, 1.0} },
            variables = {
                cb.Variable {name = "Common",  type = "CommonData",                         },
                cb.Variable {name = "Drives",   type = fmt.tprintf("DriveData_A%01d", i+1),  },
                cb.Variable {name = "Sections", type = fmt.tprintf("SectionData_A%01d", i+1),},
                cb.Variable {name = "Supplies",  type = fmt.tprintf("SupplyData_A%01d", i+1), },
            },
            externalvariables = {
                cb.Variable {name = "VeryFastTask", type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("AC%02d.VeryFast", i+1)},
                cb.Variable {name = "FastTask",     type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("AC%02d.Fast", i+1)},
                cb.Variable {name = "NormalTask",   type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("AC%02d.Normal", i+1)},
                cb.Variable {name = "SlowTask",     type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("AC%02d.Slow", i+1)},
                cb.Variable {name = "VerySlowTask", type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("AC%02d.VerySlow", i+1)},
            }
        }

        for j in 0..<DRIVES_PER_APPLICATION
        {
            driveinterface_cm : cb.ControlModule = {
                kind = cb.ControlModuleKind.ControlModule,
                name = fmt.tprintf("D%02d", driveCount+1),
                type = "DriveInterface",
                connections = {
                    cb.CMConnection {name = "Common", parameter = "Common"},
                    cb.CMConnection {name = "Drive",  parameter = fmt.tprintf("Drives.D%02d", driveCount+1)},
                },
            }
            append(&driveinterface_ax_cmt.controlmodules, driveinterface_cm)

            paneldrive_cm : cb.ControlModule = {
                kind = cb.ControlModuleKind.ControlModule,
                name = fmt.tprintf("D%02d", driveCount+1),
                type = "PanelDrive",
                connections = {
                    cb.CMConnection {name = "Common", parameter = "Common"},
                    cb.CMConnection {name = "Drive",  parameter = fmt.tprintf("Drives.D%02d", driveCount+1)},
                }
            }
            append(&panelinterface_ax_cmt.controlmodules, paneldrive_cm)

            driveCount += 1

        }

        for j in 0..<SECTIONS_PER_APPLICATION
        {
            panelsection_cm : cb.ControlModule = {
                kind = cb.ControlModuleKind.ControlModule,
                name = fmt.tprintf("S%02d", sectionCount+1),
                type = "PanelSection",
                connections = {
                    cb.CMConnection {name = "Common", parameter = "Common"},
                    cb.CMConnection {name = "Section",  parameter = fmt.tprintf("Sections.S%02d", sectionCount+1)},
                }
            }

            append(&panelinterface_ax_cmt.controlmodules, panelsection_cm)

            sectionCount += 1
        }

        for j in 0..<SUPPLIES_PER_APPLICATION
        {
            supplyinterface_cm : cb.ControlModule = {
                kind = cb.ControlModuleKind.ControlModule,
                name = fmt.tprintf("Sup%02d", supplyCount+1),
                type = "SupplyInterface",
                connections = {
                    cb.CMConnection {name = "Common", parameter = "Common"},
                    cb.CMConnection {name = "Supply",  parameter = fmt.tprintf("Supplies.Sup%02d", supplyCount+1)},
                }
            }

            append(&driveinterface_ax_cmt.controlmodules, supplyinterface_cm)

            panelsupply_cm : cb.ControlModule = {
                kind = cb.ControlModuleKind.ControlModule,
                name = fmt.tprintf("Sup%02d", supplyCount+1),
                type = "PanelSupply",
                connections = {
                    cb.CMConnection {name = "Common", parameter = "Common"},
                    cb.CMConnection {name = "Supply",  parameter = fmt.tprintf("Supplies.Sup%02d", supplyCount+1)},
                }
            }

            append(&panelinterface_ax_cmt.controlmodules, panelsupply_cm)

            supplyCount += 1
        }

        cb.NewControlModuleType("MyTypeLib", driveinterface_ax_cmt)
        cb.NewControlModuleType("MyTypeLib", panelinterface_ax_cmt)

        driveinterface_cm : cb.ControlModule = {
            kind = cb.ControlModuleKind.ControlModule,
            name = "DriveInterface",
            type = fmt.tprintf("DriveInterface_A%01d", i+1),
            task = "VeryFastTask",
            connections = {
                cb.CMConnection {name = "Common",   parameter = "Common"},
                cb.CMConnection {name = "Drives",   parameter = "Drives"},
                cb.CMConnection {name = "Sections", parameter = "Sections"},
                cb.CMConnection {name = "Supplies", parameter = "Supplies"},
            }
        }
        append(&node_ax_cmt.controlmodules, driveinterface_cm)

        panelinterface_cm : cb.ControlModule = {
            kind = cb.ControlModuleKind.ControlModule,
            name = "PanelInterface",
            type = fmt.tprintf("PanelInterface_A%01d", i+1),
            task = "SlowTask",
            connections = {
                cb.CMConnection {name = "Common",   parameter = "Common"},
                cb.CMConnection {name = "Drives",   parameter = "Drives"},
                cb.CMConnection {name = "Sections", parameter = "Sections"},
                cb.CMConnection {name = "Supplies", parameter = "Supplies"},
            }
        }
        append(&node_ax_cmt.controlmodules, panelinterface_cm)
    
        cb.NewControlModuleType("MyTypeLib", node_ax_cmt)
    }
}

makeApplications :: proc()
{
    applicationLibraries : [dynamic]cb.Library = {
        cb.Library {name = "BasicLib"},
        cb.Library {name = "MyTypeLib"},
    }

    for i in 0..<NUMBER_OF_APPLICATIONS
    {
        applicationGlobalVariables : [dynamic]cb.Variable = {
            cb.Variable {name = "VeryFastTask", type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("'AC%02d.VeryFast'", i+1)},
            cb.Variable {name = "FastTask",     type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("'AC%02d.Fast'", i+1)},
            cb.Variable {name = "NormalTask",   type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("'AC%02d.Normal'", i+1)},
            cb.Variable {name = "SlowTask",     type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("'AC%02d.Slow'", i+1)},
            cb.Variable {name = "VerySlowTask", type = "string[20]", attribute = "constant", initialvalue = fmt.tprintf("'AC%02d.VerySlow'", i+1)},
        }

        applicationControlModules : [dynamic]cb.ControlModule = {
            cb.ControlModule {name = "Node", type = fmt.tprintf("Node_A%01d", i+1), task = fmt.tprintf("AC%02d.Normal", i+1)},
        }

        applicationAX : cb.Application = {
            name = fmt.tprintf("A%01d", i+1),
            globalvariables = applicationGlobalVariables,
            libraries = applicationLibraries,
            controlmodules = applicationControlModules,
        }

        cb.NewApplication(applicationAX)
    }
}

makeControllers :: proc()
{
    controllerTasks : [dynamic]cb.Task = {
        cb.Task {name = "VeryFast", interval = 50,   offset = 0,   priority = cb.Priority.Highest, update = cb.Update.Last},
        cb.Task {name = "Fast",     interval = 100,  offset = 10,  priority = cb.Priority.High,    update = cb.Update.Last},
        cb.Task {name = "Normal",   interval = 200,  offset = 65,  priority = cb.Priority.Normal,  update = cb.Update.Last},
        cb.Task {name = "Slow",     interval = 600,  offset = 160, priority = cb.Priority.Low,     update = cb.Update.Last},
        cb.Task {name = "VerySLow", interval = 1200, offset = 350, priority = cb.Priority.Lowest,  update = cb.Update.Last},
    }

    for i in 0..<NUMBER_OF_APPLICATIONS
    {
        controllerAC0X : cb.Controller = {
            name = fmt.tprintf("AC%02d", i+1),
            type = cb.ControllerType.PM866,
            ipAddress = fmt.tprintf("192.168.80.15%v", i+1),
            application = fmt.tprintf("A%01d", i+1),
            tasks = controllerTasks,
        }
        cb.NewController(controllerAC0X)
    }
}
