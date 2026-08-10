package cbopenif

ParameterSettings :: distinct rawptr

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

parametersettings_parametersetting_add :: proc {
    parametersettings_parametersetting_add_,
    parametersettings_parametersetting_add_at_index,
}

parametersettings_parametersetting_add_ :: proc(parametersettings: ParameterSettings, parametersetting: ParameterSetting) -> (ok: bool) {
    if parametersettings == nil do return
    if parametersetting == nil do return
    if !controlbuilder_connected() do return

    hr := (^ParameterSettingsIF)(parametersettings)->Add(parametersetting)
    if com_failed(hr) do return

    return true
}

parametersettings_parametersetting_add_at_index :: proc(parametersettings: ParameterSettings, parametersetting: ParameterSetting, index: i32) -> (ok: bool) {
    if parametersettings == nil do return
    if parametersetting == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->AddBefore(parametersetting, index)
    if com_failed(hr) do return

    return true
}

parametersettings_parametersetting :: proc {
    parametersettings_parametersetting_by_name,
    parametersettings_parametersetting_by_index,
}

parametersettings_parametersetting_by_name :: proc(parametersettings: ParameterSettings, name: string) -> (parametersetting: ParameterSetting, ok: bool) {
    if parametersettings == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParameterSettingsIF)(parametersettings)->Find(bstr_name, cast(^rawptr)&parametersetting)
    if com_failed(hr) do return
    
    return parametersetting, true
}

parametersettings_parametersetting_by_index :: proc(parametersettings: ParameterSettings, index: i32) -> (parametersetting: ParameterSetting, ok: bool) {
    if parametersettings == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Item(index + 1, cast(^rawptr)&parametersetting)
    if com_failed(hr) do return
    
    return parametersetting, true
}

parametersettings_parametersetting_index :: proc(parametersettings: ParameterSettings, name: string) -> (index: i32, ok: bool) {
    if parametersettings == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ParameterSettingsIF)(parametersettings)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

parametersettings_parametersetting_count :: proc(parametersettings: ParameterSettings) -> (count: i32, ok: bool) {
    if parametersettings == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

parametersettings_parametersetting_remove :: proc {
    parametersettings_parametersetting_remove_by_name,
    parametersettings_parametersetting_remove_by_index,
}

parametersettings_parametersetting_remove_by_name :: proc(parametersettings: ParameterSettings, name: string) -> (ok: bool) {
    if parametersettings == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = parametersettings_parametersetting_index(parametersettings, name)
    
    hr := (^ParameterSettingsIF)(parametersettings)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

parametersettings_parametersetting_remove_by_index :: proc(parametersettings: ParameterSettings, index: i32) -> (ok: bool) {
    if parametersettings == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ParameterSettingsIF)(parametersettings)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

parametersettings_release :: proc(parametersettings: ParameterSettings) {
    if parametersettings != nil {
        (^ParameterSettingsIF)(parametersettings)->Release()
    }
}
