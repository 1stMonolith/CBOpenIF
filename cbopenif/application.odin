package cbopenif

import "core:strings"
import "core:fmt"
import "com"

Application :: struct
{
    name:                 string,
    description:          string,
    type:                 string,
    sillevel:             string,
    simulation:           bool,
    globalvariables:      [dynamic]Variable,
    variables:            [dynamic]Variable,
    signals:              [dynamic]Signal,
    libraries:            [dynamic]Library,
    controlmodules:       [dynamic]ControlModule,
}

ConnectedApplication :: struct
{
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

NewApplication :: proc(application: Application)
{
    _ = com.NewApplication(
        application.name,
        "", // directory
        "", // guid
        "", // template
    )

    {
        comApplicationVariables: com.ApplicationVariables
        comApplicationVariables, _ = ApplicationVariablesToCom(application)

        xml: string
        xml, _ = com.Serialize(comApplicationVariables)

        messages: string
        messages, _ = com.SetApplicationVariablesFromXML(application.name, xml)
    }

    {
        comApplicationProperties: com.ApplicationProperties
        comApplicationProperties, _ = ApplicationPropertiesToCom(application)

        xml: string
        xml, _ = com.Serialize(comApplicationProperties)

        _ = com.SetApplicationPropertiesFromXML(application.name, xml)
    }

    if len(application.libraries) > 0
    {
        for library in application.libraries {
            ConnectLibrary(application.name, library.name)
        }
    }

    if len(application.controlmodules) > 0
    {
        for controlmodule in application.controlmodules {
            AddControlModuleType(application.name, controlmodule.name, fmt.tprintf("%v_%v", controlmodule.name, application.name))
            if controlmodule.task != "" {
                _ = com.SetTaskConnection(
                    strings.concatenate({application.name, ".", controlmodule.name}),
                    controlmodule.task,
                )
            }
        }
    }
}

ApplicationPropertiesFromCom :: proc(comapplicationproperties: com.ApplicationProperties) -> (application: Application, ok: bool)
{
    if comapplicationproperties == nil do return

    application.sillevel, ok = com.SILLevel(comapplicationproperties)
    if !ok do return

    application.simulation, ok = com.SimulationMark(comapplicationproperties)
    if !ok do return

    application.type, ok = com.ApplicationType(comapplicationproperties)
    if !ok do return

    return application, true
}

ApplicationPropertiesToCom :: proc(application: Application) -> (comapplicationproperties: com.ApplicationProperties, ok: bool)
{
    return com.NewApplicationProperties(SILToString(SILLevel.SIL0), application.simulation)
}

ApplicationVariablesFromCom :: proc(comapplicationvariables: com.ApplicationVariables) -> (application: Application, ok: bool)
{
    if comapplicationvariables == nil do return

    application.description, ok = com.Description(comapplicationvariables)
    if !ok do return

        comglobalvariables: com.GlobalVariables
        comglobalvariables, ok = com.GetGlobalVariables(comapplicationvariables)
        if !ok do return
        defer com.Release(comglobalvariables)
        ok = GlobalVariablesFromCom(comglobalvariables, &application.globalvariables)
        if !ok do return

        comvariables: com.Variables
        comvariables, ok = com.GetVariables(comapplicationvariables)
        if !ok do return
        defer com.Release(comvariables)
        ok = VariablesFromCom(comvariables, &application.variables)
        if !ok do return

        comsignals: com.Signals
        comsignals, ok = com.GetSignals(comapplicationvariables)
        if !ok do return
        defer com.Release(comsignals)

        ok = SignalsFromCom(comsignals, &application.signals)
        if !ok do return

    return application, true
}

ApplicationVariablesToCom :: proc(application: Application) -> (comapplicationvariables: com.ApplicationVariables, ok: bool)
{
    comapplicationvariables, ok = com.NewApplicationVariables(application.description)
    if !ok do return
    defer if !ok do com.Release(comapplicationvariables)

        comglobalvariables: com.GlobalVariables
        comglobalvariables, ok = com.GetGlobalVariables(comapplicationvariables)
        if !ok do return
        defer com.Release(comglobalvariables)
        ok = GlobalVariablesToCom(comglobalvariables, application.globalvariables[:])
        if !ok do return

        comvariables: com.Variables
        comvariables, ok = com.GetVariables(comapplicationvariables)
        if !ok do return
        defer com.Release(comvariables)
        ok = VariablesToCom(comvariables, application.variables[:])
        if !ok do return

        comsignals: com.Signals
        comsignals, ok = com.GetSignals(comapplicationvariables)
        if !ok do return
        defer com.Release(comsignals)

        ok = SignalsToCom(comsignals, application.signals[:])
        if !ok do return

    return comapplicationvariables, true
}

ConnectedApplicationsFromCom :: proc(comconnectedapplications: com.ConnectedApplications, applications: ^[dynamic]ConnectedApplication) -> (ok: bool)
{
    if comconnectedapplications == nil do return

    count: i32
    count, ok = com.ConnectedApplicationCount(comconnectedapplications)
    if !ok do return

    for i in 0..<count {
        comconnectedapplication: com.ConnectedApplication
        comconnectedapplication, ok = com.GetConnectedApplication(comconnectedapplications, i)
        if !ok do return
        defer com.Release(comconnectedapplication)

        connectedapplication: ConnectedApplication
        connectedapplication, ok = ConnectedApplicationFromCom(comconnectedapplication)
        if !ok do return
        append(applications, connectedapplication)
    }

    return true
}

ConnectedApplicationFromCom :: proc(comconnectedapplication: com.ConnectedApplication) -> (connectedapplication: ConnectedApplication, ok: bool)
{
    if comconnectedapplication == nil do return

    connectedapplication.name, ok = com.Name(comconnectedapplication)
    if !ok do return

    connectedapplication.major_version, ok = com.MajorVersion(comconnectedapplication)
    if !ok do return

    connectedapplication.minor_version, ok = com.MinorVersion(comconnectedapplication)
    if !ok do return

    connectedapplication.revision, ok = com.Revision(comconnectedapplication)
    if !ok do return

    return connectedapplication, true
}

ConnectedApplicationsToCom :: proc(comconnectedapplications: com.ConnectedApplications, applications: []ConnectedApplication) -> (ok: bool)
{
    if comconnectedapplications == nil do return

    for application in applications {
        comconnectedapplication: com.ConnectedApplication
        comconnectedapplication, ok = ConnectedApplicationToCom(application)
        if !ok do return
        defer com.Release(comconnectedapplication)

        ok = com.AddConnectedApplication(comconnectedapplications, comconnectedapplication)
        if !ok do return
    }

    return true
}

ConnectedApplicationToCom :: proc(connectedapplication: ConnectedApplication) -> (comconnectedapplication: com.ConnectedApplication, ok: bool)
{
    return com.NewConnectedApplicationEx(connectedapplication.name, connectedapplication.major_version, connectedapplication.minor_version, connectedapplication.revision)
}
