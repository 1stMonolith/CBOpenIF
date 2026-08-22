package cbopenif

import "com"

ProjectTree :: struct {
    // TODO
}

ProjectConstant :: struct {
    name:  string,
    type:  string,
    value: string,
}

projectconstant_from_com :: proc(projectconstant: ProjectConstant, allocator := context.allocator) -> (result: t.ProjectConstant, ok: bool) {
    if projectconstant == nil do return

    context.allocator = allocator

    result.name, ok = name(projectconstant)
    if !ok do return
    result.type, ok = projectconstant_type_get(projectconstant)
    if !ok do return
    result.value, ok = projectconstant_value_get(projectconstant)
    if !ok do return

    return result, true
}

projectconstant_to_com :: proc(src: t.ProjectConstant) -> (result: ProjectConstant, ok: bool) {
    projectconstant: ProjectConstant
    projectconstant, ok = projectconstant_new(src.name, src.type, src.value)
    if !ok do return

    return projectconstant, true
}
