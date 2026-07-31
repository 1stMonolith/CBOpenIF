package parametersetting

import "../com"
import "../controlbuilder"
import "../bstr"
import "../variant"
import "../factory"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

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

parameter_setting_new :: proc(name: string, value: string) -> (parameter_setting: rawptr, ok: bool) {
    parameter_setting = nil
    ok = false

    if !controlbuilder.connected() do return
    
    bstr_name := bstr.from_string(name)
    bstr_value := bstr.from_string(value)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_value)
    }
    hr := factory.factoryif->NewParameterSetting(bstr_name, bstr_value, cast(^rawptr)&parameter_setting)
    if com.failed(hr) do return
    
    return parameter_setting, true
}

parameter_setting_name :: proc {
    parameter_setting_name_get,
    parameter_setting_name_set,
}

parameter_setting_name_get :: proc(parameter_setting: rawptr) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if parameter_setting == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parameter_setting)->NameGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_setting_name_set :: proc(parameter_setting: rawptr, name: string) -> (ok: bool) {
    ok = false

    if parameter_setting == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(name)
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parameter_setting)->NamePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_setting_parameter_value :: proc {
    parameter_setting_parameter_value_get,
    parameter_setting_parameter_value_set,
}

parameter_setting_parameter_value_get :: proc(parameter_setting: rawptr) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if parameter_setting == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parameter_setting)->ParameterValueGet(&bs)
    if com.failed(hr) do return
    
    return bstr.to_string(bs), true
}

parameter_setting_parameter_value_set :: proc(parameter_setting: rawptr, type_name: string) -> (ok: bool) {
    ok = false

    if parameter_setting == nil do return
    if !controlbuilder.connected() do return
    
    bs := bstr.from_string(type_name)
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parameter_setting)->ParameterValuePut(bs)
    if com.failed(hr) do return
    
    return true
}

parameter_setting_description_get :: proc(parameter_setting: rawptr) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if parameter_setting == nil do return
    if !controlbuilder.connected() do return
    
    bs: BStr
    defer bstr.free(bs)
    hr := (^ParameterSettingIF)(parameter_setting)->DescriptionGet(&bs)
    if com.failed(hr) do return

    return bstr.to_string(bs), true
}
