package cbopenif

import "core:strings"
import "com"

DataType :: struct {
    name:                 string,
    description:          string,
    protected:            bool,
    hidden:               bool,
    scope:                Scope,
    guid:                 string,
    reserved_by_function: string,
    components:           [dynamic]Component,
}

Component :: struct {
    name:                 string,
    type_name:            string,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    isp_value:            string,
    type_guid:            string, // read-only from COM
    type_path:            string, // read-only from COM
}

datatype_new :: proc(library_name: string, datatype: DataType) {
    ok: bool
    cdt: com.DataType
    xml, msg: string
    
    cdt, ok = datatype_to_com(datatype)
    defer com.release(cdt)
    xml, ok = com.datatype_serialize(cdt)

    // TODO: find out why is this required
    xml, _ = strings.replace_all(xml, "AuthenticationLevel=''", "AuthenticationLevel='None'")
    // or this....
    //xml, _ = strings.replace_all(xml, "AuthenticationLevel=''", "")

    msg, ok = com.datatype_new(datatype.name, library_name, xml)
}

datatype_get :: proc(library_name: string, datatype_name: string) -> (datatype: DataType) {
    ok: bool
    cdt: com.DataType
    dt: DataType
    xml: string

    path := strings.concatenate({library_name, ".", datatype_name})
    defer delete(path)

    xml, ok = com.datatype_get(path)
    cdt, ok = com.datatype_deserialize(xml)
    defer com.release(cdt)
    dt, ok = datatype_from_com(cdt)

    return dt
}

datatype_set :: proc(library_name: string, datatype_name: string, datatype: DataType) {
}

datatype_delete :: proc(library_name: string, datatype_name: string) {
    ok: bool

    path := strings.concatenate({library_name, ".", datatype_name})
    defer delete(path)

    ok = com.datatype_delete(path)
}

datatype_from_com :: proc(datatype: com.DataType, allocator := context.allocator) -> (result: DataType, ok: bool) {
    if datatype == nil do return

    context.allocator = allocator

    result.name, ok = com.name(datatype)
    if !ok do return
    result.description, ok = com.description(datatype)
    if !ok do return
    result.protected, ok = com.protected(datatype)
    if !ok do return
    result.hidden, ok = com.hidden(datatype)
    if !ok do return
    result.scope, ok = com.scope(datatype)
    if !ok do return
    result.guid, ok = com.guid(datatype)
    if !ok do return
    result.reserved_by_function, ok = com.reserved_by_function(datatype)
    if !ok do return

    comps: com.Components
    comps, ok = components(datatype)
    if !ok do return
    defer release(comps)
    result.components, ok = com.components_from_com(comps)
    if !ok do return

    return result, true
}

datatype_to_com :: proc(src: DataType) -> (result: com.DataType, ok: bool) {
    datatype: com.DataType
    datatype, ok = com.datatype_new1(
        src.name,
        src.description,
        src.protected,
        src.hidden,
        src.scope,
    )
    if !ok do return
    defer if !ok do com.release(datatype)

    ok = com.guid(datatype, src.guid)
    if !ok do return
    ok = com.reserved_by_function(datatype, src.reserved_by_function)
    if !ok do return

    comps: com.Components
    comps, ok = com.components(datatype)
    if !ok do return
    defer release(comps)
    ok = com.components_to_com(comps, src.components[:])
    if !ok do return

    return datatype, true
}

components_from_com :: proc(comps: com.Components, allocator := context.allocator) -> (result: [dynamic]Component, ok: bool) {
    if comps == nil do return
    context.allocator = allocator

    count: i32
    count, ok = com.component_count(comps)
    if !ok do return

    result = make([dynamic]t.Component, 0, int(count), allocator)
    for i in 0..<count {
        c: com.Component
        c, ok = com.component_by_index(comps, i)
        if !ok do return
        defer com.release(c)

        cs: Component
        cs, ok = com.component_from_com(c)
        if !ok do return
        append(&result, cs)
    }
    return result, true
}

components_to_com :: proc(comps: com.Components, src: []Component) -> (ok: bool) {
    if comps == nil do return
    for item in src {
        c: com.Component
        c, ok = com.component_to_com(item)
        if !ok do return
        defer com.release(c)
        ok = com.component_add(comps, c)
        if !ok do return
    }
    return true
}

component_from_com :: proc(component: com.Component) -> (result: Component, ok: bool) {
    if component == nil do return

    result.name, ok = com.name(component)
    if !ok do return
    result.type_name, ok = com.type_name(component)
    if !ok do return
    result.attribute, ok = com.attribute(component)
    if !ok do return
    result.initial_value, ok = com.initial_value(component)
    if !ok do return
    result.description, ok = com.description(component)
    if !ok do return
    result.read_permission, ok = com.read_permission(component)
    if !ok do return
    result.write_permission, ok = com.write_permission(component)
    if !ok do return
    result.authentication_level, ok = com.authentication_level(component)
    if !ok do return
    result.access_level, ok = com.access_level(component)
    if !ok do return
    result.safety_type, ok = com.safety_type(component)
    if !ok do return
    result.isp_value, ok = com.isp_value(component)
    if !ok do return
    result.type_guid, ok = com.type_guid(component)
    if !ok do return
    result.type_path, ok = com.type_path(component)
    if !ok do return

    return result, true
}

component_to_com :: proc(src: Component) -> (result: com.Component, ok: bool) {
    component: com.Component
    component, ok = com.component_new1(
        src.name,
        src.type_name,
        src.attribute,
        src.initial_value,
        src.description,
    )
    if !ok do return
    defer if !ok do com.release(component)

    ok = com.read_permission(component, src.read_permission)
    if !ok do return
    ok = com.write_permission(component, src.write_permission)
    if !ok do return
    ok = com.authentication_level(component, src.authentication_level)
    if !ok do return
    ok = com.access_level(component, src.access_level)
    if !ok do return
    ok = com.safety_type(component, src.safety_type)
    if !ok do return
    ok = com.isp_value(component, src.isp_value)
    if !ok do return

    return component, true
}
