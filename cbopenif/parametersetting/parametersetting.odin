package parametersetting

ParameterSetting  :: distinct rawptr

ParameterSettingIF :: struct #raw_union {
    #subtype iunknown: IUnknownIF,
    using vtable: ^ParameterSettingVTable,
}

ParameterSettingVTable :: struct {
    using iunknown_vtable: IUnknownVTable,
    NameGet:           proc "system" (this: ^ParameterSettingIF, Name: ^BStr) -> HResult,
    NamePut:           proc "system" (this: ^ParameterSettingIF, Name: BStr) -> HResult,
    ParameterValueGet: proc "system" (this: ^ParameterSettingIF, ParameterValue: ^BStr) -> HResult,
    ParameterValuePut: proc "system" (this: ^ParameterSettingIF, ParameterValue: BStr) -> HResult,
    DescriptionGet:    proc "system" (this: ^ParameterSettingIF, Description: ^BStr) -> HResult,
}

parameter_setting_new :: proc(name: string, value: string) -> (parameter_setting: ParameterSetting, ok: bool) {
    parameter_setting = nil
    ok = false

    if !connected() do return
    
    bstr_name := string_to_bstr(name)
    bstr_value := string_to_bstr(value)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_value)
    }
    hr := factoryif->NewParameterSetting(bstr_name, bstr_value, cast(^ParameterSetting)&parameter_setting)
    if failed(hr) do return
    
    return parameter_setting, true
}

parameter_setting_name :: proc {
    parameter_setting_name_,
    parameter_setting_name_set,
}

@(private)
parameter_setting_name_ :: proc(parameter_setting: ParameterSetting) -> (name: string, ok: bool) {
    name = ""
    ok = false

    if parameter_setting == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterSettingIF)(parameter_setting)->NameGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_setting_name_set :: proc(parameter_setting: ParameterSetting, name: string) -> (ok: bool) {
    ok = false

    if parameter_setting == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(name)
    defer bstr_free(bstr)
    hr := (^ParameterSettingIF)(parameter_setting)->NamePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_setting_parameter_value :: proc {
    parameter_setting_parameter_value_,
    parameter_setting_parameter_value_set,
}

@(private)
parameter_setting_parameter_value_ :: proc(parameter_setting: ParameterSetting) -> (type_name: string, ok: bool) {
    type_name = ""
    ok = false

    if parameter_setting == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterSettingIF)(parameter_setting)->ParameterValueGet(&bstr)
    if failed(hr) do return
    
    return bstr_to_string(bstr), true
}

@(private)
parameter_setting_parameter_value_set :: proc(parameter_setting: ParameterSetting, type_name: string) -> (ok: bool) {
    ok = false

    if parameter_setting == nil do return
    if !connected() do return
    
    bstr := string_to_bstr(type_name)
    defer bstr_free(bstr)
    hr := (^ParameterSettingIF)(parameter_setting)->ParameterValuePut(bstr)
    if failed(hr) do return
    
    return true
}

parameter_setting_description_ :: proc(parameter_setting: ParameterSetting) -> (description: string, ok: bool) {
    description = ""
    ok = false

    if parameter_setting == nil do return
    if !connected() do return
    
    bstr: BStr
    defer bstr_free(bstr)
    hr := (^ParameterSettingIF)(parameter_setting)->DescriptionGet(&bstr)
    if failed(hr) do return

    return bstr_to_string(bstr), true
}
