package parameter

import "../bstr"
import "../com"
import "../controlbuilder"

@(private="file") BStr    :: bstr.BStr
@(private="file") HResult :: com.HResult

ParameterSettings :: distinct rawptr

ParameterSettingsIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^ParameterSettingsVTable,
}

ParameterSettingsVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    Add:       proc "system" (this: ^ParameterSettingsIF, ParameterSetting: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ParameterSettingsIF, ParameterSetting: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParameterSettingsIF, Name, ParameterValue: BStr, ParameterSetting: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ParameterSettingsIF, Name: BStr, ParameterSetting: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ParameterSettingsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParameterSettingsIF, Index: i32, ParameterSetting: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ParameterSettingsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParameterSettingsIF, Index: i32) -> HResult,
}

parametersettings_add :: proc {
    parametersettings_add_get,
    parametersettings_add_at_index,
}

parametersettings_add_get :: proc(parameter_settings: ParameterSettings, parameter_setting: ParameterSetting) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    if parameter_setting == nil do return

    hr := (^ParameterSettingsIF)(parameter_settings)->Add(parameter_setting)
    if com.failed(hr) do return

    return true
}

parametersettings_add_at_index :: proc(parameter_settings: ParameterSettings, parameter_setting: ParameterSetting, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    if parameter_setting == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->AddBefore(parameter_setting, index)
    if com.failed(hr) do return

    return true
}

parametersettings_parametersetting :: proc {
    parametersettings_parametersetting_by_name,
    parametersettings_parametersetting_by_index,
}

parametersettings_parametersetting_by_name :: proc(parameter_settings: ParameterSettings, name: string) -> (parameter_setting: ParameterSetting, ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^ParameterSettingsIF)(parameter_settings)->Find(bstr_name, cast(^rawptr)&parameter_setting)
    if com.failed(hr) do return
    
    return parameter_setting, true
}

parametersettings_parametersetting_by_index :: proc(parameter_settings: ParameterSettings, index: i32) -> (parameter_setting: ParameterSetting, ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Item(index, cast(^rawptr)&parameter_setting)
    if com.failed(hr) do return
    
    return parameter_setting, true
}

parametersettings_parametersetting_index :: proc(parameter_settings: ParameterSettings, name: string) -> (index: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    
    bstr_name := bstr.from_string(name)
    bstr.free(bstr_name)
    hr := (^ParameterSettingsIF)(parameter_settings)->FindNr(bstr_name, &index)
    if com.failed(hr) do return
    
    return index, true
}

parametersettings_count :: proc(parameter_settings: ParameterSettings) -> (count: i32, ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Count(&count)
    if com.failed(hr) do return
    
    return count, true
}

parametersettings_remove :: proc {
    parametersettings_remove_by_name,
    parametersettings_remove_by_index,
}

parametersettings_remove_by_name :: proc(parameter_settings: ParameterSettings, name: string) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return

    index: i32
    index, ok = parametersettings_parametersetting_index(parameter_settings, name)
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

parametersettings_remove_by_index :: proc(parameter_settings: ParameterSettings, index: i32) -> (ok: bool) {

    if !controlbuilder.connected() do return
    if parameter_settings == nil do return
    
    hr := (^ParameterSettingsIF)(parameter_settings)->Remove(index)
    if com.failed(hr) do return
    
    return true
}

parametersettings_release :: proc(parameter_settings: ParameterSettings) {
    if parameter_settings != nil {
        (^ParameterSettingsIF)(parameter_settings)->Release()
    }
}
