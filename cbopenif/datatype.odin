package cbopenif

import "core:strings"
import "com"

DataType :: struct
{
    name:        string,
    description: string,
    protected:   bool,
    hidden:      bool,
    scope:       Scope,
    guid:        string,
    reservedby:  string,
    components:  [dynamic]Component,
}

Component :: struct
{
    name:                string,
    type:                string,
    attribute:           string,
    initialvalue:        string,
    description:         string,
    readpermission:      string,
    writepermission:     string,
    authenticationlevel: string,
    accesslevel:         string,
    safetytype:          string,
    ispvalue:            string,
    typeguid:            string, // read-only from COM
    typepath:            string, // read-only from COM
}

NewDataType :: proc(library_name: string, datatype: DataType) -> (ok: bool)
{
    comdatatype: com.DataType
    comdatatype, ok = DataTypeToCom(datatype)
    defer com.Release(comdatatype)

    xml: string
    xml, ok = com.SerializeDataType(comdatatype)

    msg: string
    msg, ok = com.NewDataTypeFromXML(datatype.name, library_name, xml)

    return true
}

GetDataType :: proc(library_name: string, datatype_name: string) -> (datatype: DataType, ok: bool)
{
    path := strings.concatenate({library_name, ".", datatype_name})
    defer delete(path)

    xml: string
    xml, ok = com.GetDataTypeAsXML(path)

    comdatatype: com.DataType
    comdatatype, ok = com.DeserializeDataType(xml)
    defer com.Release(comdatatype)

    datatype, ok = DataTypeFromCom(comdatatype)

    return datatype, true
}

/*
SetDatatype :: proc(library_name: string, datatype_name: string, datatype: DataType) -> (ok: bool)
{
    return true
}
*/

DeleteDataType :: proc(library_name: string, datatype_name: string) -> (ok: bool)
{
    path := strings.concatenate({library_name, ".", datatype_name})
    defer delete(path)

    ok = com.DeleteDataType(path)

    return true
}

DataTypeFromCom :: proc(comdatatype: com.DataType) -> (datatype: DataType, ok: bool)
{
    if comdatatype == nil do return

    datatype.name, ok = com.Name(comdatatype)
    if !ok do return

    datatype.description, ok = com.Description(comdatatype)
    if !ok do return

    datatype.protected, ok = com.Protected(comdatatype)
    if !ok do return

    datatype.hidden, ok = com.Hidden(comdatatype)
    if !ok do return

    scope: i32
    scope, ok = com.Scope(comdatatype)
    if !ok do return
    datatype.scope = Scope(scope)

    datatype.guid, ok = com.Guid(comdatatype)
    if !ok do return

    datatype.reservedby, ok = com.ReservedBy(comdatatype)
    if !ok do return

    comcomponents: com.Components
    comcomponents, ok = com.GetComponents(comdatatype)
    if !ok do return
    defer com.Release(comcomponents)
    ok = ComponentsFromCom(comcomponents, &datatype.components)
    if !ok do return

    return datatype, true
}

DataTypeToCom :: proc(datatype: DataType) -> (comdatatype: com.DataType, ok: bool)
{
    comdatatype, ok = com.NewDataTypeEx(
        datatype.name,
        datatype.description,
        datatype.protected,
        datatype.hidden,
        i32(datatype.scope),
    )
    if !ok do return
    defer if !ok do com.Release(comdatatype)

    ok = com.Guid(comdatatype, datatype.guid)
    if !ok do return

    ok = com.ReservedBy(comdatatype, datatype.reservedby)
    if !ok do return

    comcomponents: com.Components
    comcomponents, ok = com.GetComponents(comdatatype)
    if !ok do return
    defer com.Release(comcomponents)

    ok = ComponentsToCom(comcomponents, datatype.components[:])
    if !ok do return

    return comdatatype, true
}

ComponentsFromCom :: proc(comcomponents: com.Components, components: ^[dynamic]Component) -> (ok: bool)
{
    if comcomponents == nil do return

    count: i32
    count, ok = com.ComponentCount(comcomponents)
    if !ok do return

    for i in 0..<count {
        comcomponent: com.Component
        comcomponent, ok = com.GetComponent(comcomponents, i)
        if !ok do return
        defer com.Release(comcomponent)

        c: Component
        c, ok = ComponentFromCom(comcomponent)
        if !ok do return
        append(components, c)
    }
    return true
}

ComponentFromCom :: proc(comcomponent: com.Component) -> (component: Component, ok: bool)
{
    if comcomponent == nil do return

    component.name, ok = com.Name(comcomponent)
    if !ok do return

    component.type, ok = com.TypeName(comcomponent)
    if !ok do return

    component.attribute, ok = com.Attribute(comcomponent)
    if !ok do return

    component.initialvalue, ok = com.GetComponentInitialValue(comcomponent)
    if !ok do return

    component.description, ok = com.Description(comcomponent)
    if !ok do return

    component.readpermission, ok = com.ReadPermission(comcomponent)
    if !ok do return

    component.writepermission, ok = com.WritePermission(comcomponent)
    if !ok do return
    
    component.authenticationlevel, ok = com.AuthenticationLevel(comcomponent)
    if !ok do return

    component.accesslevel, ok = com.AccessLevel(comcomponent)
    if !ok do return

    component.safetytype, ok = com.SafetyType(comcomponent)
    if !ok do return

    component.ispvalue, ok = com.ISPValue(comcomponent)
    if !ok do return

    component.typeguid, ok = com.TypeGuid(comcomponent)
    if !ok do return

    component.typepath, ok = com.TypePath(comcomponent)
    if !ok do return

    return component, true
}

ComponentsToCom :: proc(comcomponents: com.Components, components: []Component) -> (ok: bool)
{
    if comcomponents == nil do return

    for component in components {
        comcomponent: com.Component
        comcomponent, ok = ComponentToCom(component)
        if !ok do return
        defer com.Release(comcomponent)

        ok = com.AddComponent(comcomponents, comcomponent)
        if !ok do return
    }
    return true
}

ComponentToCom :: proc(component: Component) -> (comcomponent: com.Component, ok: bool)
{
    comcomponent, ok = com.NewComponentEx(
        component.name,
        component.type,
        component.attribute,
        component.initialvalue,
        component.description,
    )
    if !ok do return
    defer if !ok do com.Release(comcomponent)

    ok = com.ReadPermission(comcomponent, component.readpermission)
    if !ok do return

    ok = com.WritePermission(comcomponent, component.writepermission)
    if !ok do return

    if component.authenticationlevel != "" {
        ok = com.AuthenticationLevel(comcomponent, component.authenticationlevel)
        if !ok do return
    }

    ok = com.AccessLevel(comcomponent, component.accesslevel)
    if !ok do return

    ok = com.SafetyType(comcomponent, component.safetytype)
    if !ok do return

    ok = com.ISPValue(comcomponent, component.ispvalue)
    if !ok do return

    return comcomponent, true
}
