package cbopenif

import "core:strings"
import "com"

ControllerType :: enum
{
    PM851 = 0,
    PM856 = 1,
    PM858 = 2,
    PM860 = 3,
    PM861 = 4,
    PM862 = 5,
    PM864 = 6,
    PM866 = 7,
    PM891 = 8,
}

ControllerTypeToString :: proc(t: ControllerType) -> string
{
    switch t {
        case .PM851: return "AC 800M.PM851 / TP830"
        case .PM856: return "AC 800M.PM856 / TP830"
        case .PM858: return "AC 800M.PM858 / TP830"
        case .PM860: return "AC 800M.PM860 / TP830"
        case .PM861: return "AC 800M.PM861 / TP830"
        case .PM862: return "AC 800M.PM862 / TP830"
        case .PM864: return "AC 800M.PM864 / TP830"
        case .PM866: return "AC 800M.PM866 / TP830"
        case .PM891: return "AC 800M.PM891"
        case:        return "AC 800M.PM891"
    }
}

Controller :: struct
{
    name:        string,
    type:        ControllerType,
    ipAddress:   string,
    application: string,
    tasks:       [dynamic]Task,
}

NewController :: proc(controller: Controller)
{
    _ = com.NewController(
        controller.name,
        ControllerTypeToString(controller.type),
        "", // directory path
        "", // guid
        "", // template
    )

    if controller.ipAddress != ""
    {
        _ = com.SetSystemIdentity(controller.name, controller.ipAddress)
    }

    if controller.application != "" 
    {
        xml: string
        xml, _ = com.GetConnectedApplicationsAsXML(controller.name)

        comConnectedApplications: com.ConnectedApplications
        comConnectedApplications, _ = com.DeserializeConnectedApplications(xml)
        defer com.Release(comConnectedApplications)
        
        comConnectedApplication: com.ConnectedApplication
        comConnectedApplication, _ = com.NewConnectedApplication(controller.application)
        defer com.Release(comConnectedApplication)

        _ = com.AddConnectedApplication(comConnectedApplications, comConnectedApplication)

        xml, _ = com.Serialize(comConnectedApplications)

        messages: string
        messages, _ = com.SetConnectedApplicationsFromXML(controller.name, xml)
    }

    if len(controller.tasks) > 0
    {
        taskPath: string
        for task in controller.tasks {
            taskPath = strings.concatenate({controller.name, ".", task.name})
            _ = com.DeleteTask(taskPath)

            comTask: com.Task
            comTask, _ = TaskToCom(task)

            xml: string
            xml, _ = com.Serialize(comTask)

            _ = com.NewTaskFromXML(task.name, controller.name, xml)
        }
    }
}