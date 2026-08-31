package cbopenif

import "com"

ProjectTree :: struct
{
    // TODO
}

ProjectConstant :: struct
{
    name:  string,
    type:  string,
    value: string,
}

ProjectConstantFromCom :: proc(comprojectconstant: com.ProjectConstant) -> (projectconstant: ProjectConstant, ok: bool)
{
    if comprojectconstant == nil do return

    projectconstant.name, ok = com.Name(comprojectconstant)
    if !ok do return

    projectconstant.type, ok = com.GetProjectConstantType(comprojectconstant)
    if !ok do return

    projectconstant.value, ok = com.GetProjectConstantValue(comprojectconstant)
    if !ok do return

    return projectconstant, true
}

ProjectConstantToCom :: proc(projectconstant: ProjectConstant) -> (comprojectconstant: com.ProjectConstant, ok: bool)
{
    return com.NewProjectConstant(projectconstant.name, projectconstant.type, projectconstant.value)
}
