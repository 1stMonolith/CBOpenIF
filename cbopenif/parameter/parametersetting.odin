package parameter

import "../bstr"
import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: bstr.BStr
@(private="file") HResult :: com.HResult

ParameterSetting :: distinct rawptr

ParameterSettingIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ParameterSettingVTable,
}

ParameterSettingVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NameGet:           proc "system" (this: ^ParameterSettingIF, Name: ^BStr) -> HResult,
    NamePut:           proc "system" (this: ^ParameterSettingIF, Name: BStr) -> HResult,
    ParameterValueGet: proc "system" (this: ^ParameterSettingIF, ParameterValue: ^BStr) -> HResult,
    ParameterValuePut: proc "system" (this: ^ParameterSettingIF, ParameterValue: BStr) -> HResult,
    DescriptionGet:    proc "system" (this: ^ParameterSettingIF, Description: ^BStr) -> HResult,
}

parametersetting_new :: proc(name: string, value: string) -> (parametersetting: ParameterSetting, ok: bool) {

    if !controlbuilder.controlbuilder_connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_value := bstr.from_string(value)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_value)
    }
    hr := factory.factoryif->NewParameterSetting(bstr_name, bstr_value, cast(^rawptr)&parametersetting)
    if com.failed(hr) do return
    
    return parametersetting, true
}

parametersetting_name :: proc {
    parametersetting_name_get,
    parametersetting_name_set,
}

parametersetting_name_get :: proc(parametersetting: ParameterSetting) -> (name: string, ok: bool) {

    if parametersetting == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->NameGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parametersetting_name_set :: proc(parametersetting: ParameterSetting, name: string) -> (ok: bool) {

    if parametersetting == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

parametersetting_parameter_value :: proc {
    parametersetting_parameter_value_get,
    parametersetting_parameter_value_set,
}

parametersetting_parameter_value_get :: proc(parametersetting: ParameterSetting) -> (type_name: string, ok: bool) {

    if parametersetting == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->ParameterValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parametersetting_parameter_value_set :: proc(parametersetting: ParameterSetting, type_name: string) -> (ok: bool) {

    if parametersetting == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->ParameterValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

parametersetting_description_get :: proc(parametersetting: ParameterSetting) -> (description: string, ok: bool) {

    if parametersetting == nil do return
    if !controlbuilder.controlbuilder_connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}

parametersetting_realease :: proc(parametersetting: ParameterSetting) {
    if parametersetting != nil {
        (^ParameterSettingIF)(parametersetting)->Release()
    }
}
