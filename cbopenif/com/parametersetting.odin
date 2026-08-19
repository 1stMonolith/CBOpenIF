package com

ParameterSetting  :: distinct rawptr
ParameterSettings :: distinct rawptr

ParameterSettingIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParameterSettingVTable,
}

ParameterSettingVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NameGet:           proc "system" (this: ^ParameterSettingIF, Name: ^BStr) -> HResult,
    NamePut:           proc "system" (this: ^ParameterSettingIF, Name: BStr) -> HResult,
    ParameterValueGet: proc "system" (this: ^ParameterSettingIF, ParameterValue: ^BStr) -> HResult,
    ParameterValuePut: proc "system" (this: ^ParameterSettingIF, ParameterValue: BStr) -> HResult,
    DescriptionGet:    proc "system" (this: ^ParameterSettingIF, Description: ^BStr) -> HResult,
}

parametersetting_name_get :: proc(parametersetting: ParameterSetting) -> (name: string, ok: bool) {
    if parametersetting == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->NameGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parametersetting_name_set :: proc(parametersetting: ParameterSetting, name: string) -> (ok: bool) {
    if parametersetting == nil do return
    if !com_connected() do return
    
    bs := to_bstr(name)
    defer bstr_free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->NamePut(bs)
    if com_failed(hr) do return
    
    return true
}

parametersetting_parameter_value_get :: proc(parametersetting: ParameterSetting) -> (type_name: string, ok: bool) {
    if parametersetting == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->ParameterValueGet(&bs)
    if com_failed(hr) do return
    
    return from_bstr(bs), true
}

parametersetting_parameter_value_set :: proc(parametersetting: ParameterSetting, type_name: string) -> (ok: bool) {
    if parametersetting == nil do return
    if !com_connected() do return
    
    bs := to_bstr(type_name)
    defer bstr_free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->ParameterValuePut(bs)
    if com_failed(hr) do return
    
    return true
}

parametersetting_description_get :: proc(parametersetting: ParameterSetting) -> (description: string, ok: bool) {
    if parametersetting == nil do return
    if !com_connected() do return
    
    bs: BStr
    defer bstr_free(bs)
    hr := (^ParameterSettingIF)(parametersetting)->DescriptionGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

parametersetting_release :: proc(parametersetting: ParameterSetting) {
    if parametersetting != nil {
        (^ParameterSettingIF)(parametersetting)->Release()
    }
}

ParameterSettingsIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ParameterSettingsVTable,
}

ParameterSettingsVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ParameterSettingsIF, ParameterSetting: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ParameterSettingsIF, ParameterSetting: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ParameterSettingsIF, Name, ParameterValue: BStr, ParameterSetting: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ParameterSettingsIF, Name: BStr, ParameterSetting: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ParameterSettingsIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ParameterSettingsIF, Index: i32, ParameterSetting: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ParameterSettingsIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ParameterSettingsIF, Index: i32) -> HResult,
}

parametersettings_parametersetting_add :: proc(parametersettings: ParameterSettings, parametersetting: ParameterSetting) -> (ok: bool) {
    if parametersettings == nil do return
    if parametersetting == nil do return
    if !com_connected() do return

    hr := (^ParameterSettingsIF)(parametersettings)->Add(parametersetting)
    if com_failed(hr) do return

    return true
}

parametersettings_parametersetting_add_at_index :: proc(parametersettings: ParameterSettings, parametersetting: ParameterSetting, index: i32) -> (ok: bool) {
    if parametersettings == nil do return
    if parametersetting == nil do return
    if !com_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->AddBefore(parametersetting, index)
    if com_failed(hr) do return

    return true
}

parametersettings_parametersetting_by_name :: proc(parametersettings: ParameterSettings, name: string) -> (parametersetting: ParameterSetting, ok: bool) {
    if parametersettings == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParameterSettingsIF)(parametersettings)->Find(bstr_name, cast(^rawptr)&parametersetting)
    if com_failed(hr) do return
    
    return parametersetting, true
}

parametersettings_parametersetting_by_index :: proc(parametersettings: ParameterSettings, index: i32) -> (parametersetting: ParameterSetting, ok: bool) {
    if parametersettings == nil do return
    if !com_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Item(index + 1, cast(^rawptr)&parametersetting)
    if com_failed(hr) do return
    
    return parametersetting, true
}

parametersettings_parametersetting_index :: proc(parametersettings: ParameterSettings, name: string) -> (index: i32, ok: bool) {
    if parametersettings == nil do return
    if !com_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParameterSettingsIF)(parametersettings)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

parametersettings_parametersetting_count :: proc(parametersettings: ParameterSettings) -> (count: i32, ok: bool) {
    if parametersettings == nil do return
    if !com_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

parametersettings_parametersetting_remove_by_name :: proc(parametersettings: ParameterSettings, name: string) -> (ok: bool) {
    if parametersettings == nil do return
    if !com_connected() do return

    index: i32
    index, ok = parametersettings_parametersetting_index(parametersettings, name)
    
    hr := (^ParameterSettingsIF)(parametersettings)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

parametersettings_parametersetting_remove_by_index :: proc(parametersettings: ParameterSettings, index: i32) -> (ok: bool) {
    if parametersettings == nil do return
    if !com_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

parametersettings_release :: proc(parametersettings: ParameterSettings) {
    if parametersettings != nil {
        (^ParameterSettingsIF)(parametersettings)->Release()
    }
}
