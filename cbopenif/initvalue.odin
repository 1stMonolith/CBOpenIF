package cbopenif

import "com"

InitValuesFromCom :: proc(cominitvalues: com.InitValues, initvalues: ^[dynamic]InitValue) -> (ok: bool)
{
    if cominitvalues == nil do return

    count: i32
    count, ok = com.InitValueCount(cominitvalues)
    if !ok do return

    for i in 0..<count {
        cominitvalue: com.InitValue
        cominitvalue, ok = com.GetInitValue(cominitvalues, i)
        if !ok do return
        defer com.Release(cominitvalue)

        initvalue: InitValue
        initvalue, ok = InitValueFromCom(cominitvalue)
        if !ok do return
        append(initvalues, initvalue)
    }

    return true
}

InitValueFromCom :: proc(cominitvalue: com.InitValue) -> (initvalue: InitValue, ok: bool)
{
    if cominitvalue == nil do return

    initvalue.name, ok = com.Name(cominitvalue)
    if !ok do return

    initvalue.pou_path, ok = com.POUPath(cominitvalue)
    if !ok do return

    initvalue.value, ok = com.GetInitValueValue(cominitvalue)
    if !ok do return

    return initvalue, true
}

InitValuesToCom :: proc(cominitvalues: com.InitValues, initvalues: []InitValue) -> (ok: bool)
{
    if cominitvalues == nil do return

    for initvalue in initvalues {
        cominitvalue: com.InitValue
        cominitvalue, ok = InitValueToCom(initvalue)
        if !ok do return
        defer com.Release(cominitvalue)

        ok = com.AddInitValue(cominitvalues, cominitvalue)
        if !ok do return
    }
    
    return true
}

InitValueToCom :: proc(initvalue: InitValue) -> (cominitvalue: com.InitValue, ok: bool)
{
    return com.NewInitValue(initvalue.pou_path, initvalue.name, initvalue.value)
}
