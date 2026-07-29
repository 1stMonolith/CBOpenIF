package cbopenif

ParameterSettings :: distinct rawptr

ParameterSettingsIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^ParameterSettingsVTable,
}

ParameterSettingsVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    Add:       proc "system" (this: ^ParameterSettingsIF, ParameterSetting: ParameterSetting) -> HResult,
    AddBefore: proc "system" (this: ^ParameterSettingsIF, ParameterSetting: ParameterSetting, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParameterSettingsIF, Name, TypeName: BStr, ParameterSetting: ^ParameterSetting) -> HResult,
    Add2:      proc "system" (this: ^ParameterSettingsIF, Name, TypeName, Attribute, InitialValue, Description: BStr, ParameterSetting: ^ParameterSetting) -> HResult,
    Find:      proc "system" (this: ^ParameterSettingsIF, Name: BStr, ParameterSetting: ^ParameterSetting) -> HResult,
    FindNr:    proc "system" (this: ^ParameterSettingsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParameterSettingsIF, Index: i32, ParameterSetting: ^ParameterSetting) -> HResult,
    Count:     proc "system" (this: ^ParameterSettingsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParameterSettingsIF, Index: i32) -> HResult,
}

parametersettings_add :: proc {
    parametersettings_add_,
    parametersettings_add_at_index,
}

@(private)
parametersettings_add_ :: proc(parameter_settings: ParameterSettings, parameter_setting: ParameterSetting) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    if parameter_setting == nil do return

    hr := (^ParameterSettingsIF)(parameter_settings)->Add(parameter_setting)
    if failed(hr) do return

    return true
}

parametersettings_add_at_index :: proc(parameter_settings: ParameterSettings, parameter_setting: ParameterSetting, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    if parameter_setting == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->AddBefore(parameter_setting, index)
    if failed(hr) do return

    return true
}

parametersettings_parametersetting :: proc {
    parametersettings_parametersetting_by_name,
    parametersettings_parametersetting_by_index,
}

parametersettings_parametersetting_by_name :: proc(parameter_settings: ParameterSettings, name: string) -> (parameter_setting: ParameterSetting, ok: bool) {
    parameter_setting = nil
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    
    bstr_name := string_to_bstr(name)
    SysFreeString(bstr_name)
    hr := (^ParameterSettingsIF)(parameter_settings)->Find(bstr_name, &parameter_setting)
    if failed(hr) do return
    
    return parameter_setting, true
}

parametersettings_parametersetting_by_index :: proc(parameter_settings: ParameterSettings, index: i32) -> (parameter_setting: ParameterSetting, ok: bool) {
    parameter_setting = nil
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Item(index, &parameter_setting)
    if failed(hr) do return
    
    return parameter_setting, true
}

parametersettings_parametersetting_index :: proc(parameter_settings: ParameterSettings, name: string) -> (index: i32, ok: bool) {
    index = 0
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    
    bstr_name := string_to_bstr(name)
    SysFreeString(bstr_name)
    hr := (^ParameterSettingsIF)(parameter_settings)->FindNr(bstr_name, &index)
    if failed(hr) do return
    
    return index, true
}

parametersettings_count :: proc(parameter_settings: ParameterSettings) -> (count: i32, ok: bool) {
    count = 0
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Count(&count)
    if failed(hr) do return
    
    return count, true
}

parametersettings_remove :: proc {
    parametersettings_remove_by_name,
    parametersettings_remove_by_index,
}

parametersettings_remove_by_name :: proc(parameter_settings: ParameterSettings, name: string) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameter_settings == nil do return

    index: i32
    index, ok = parametersettings_parametersetting_index(parameter_settings, name)
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Remove(index)
    if failed(hr) do return
    
    return true
}

parametersettings_remove_by_index :: proc(parameter_settings: ParameterSettings, index: i32) -> (ok: bool) {
    ok = false

    if !connected() do return
    if parameter_settings == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Remove(index)
    if failed(hr) do return
    
    return true
}

parametersettings_release :: proc(parameter_settings: ParameterSettings) {
    if parameter_settings != nil {
        (^ParameterSettingsIF)(parameter_settings)->Release()
    }
}
