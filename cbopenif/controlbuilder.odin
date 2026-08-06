package cbopenif

controlbuilder_connect :: proc() -> (ok: bool) {
    cbopen_connect()
    factory_connect()
    return true
}

controlbuilder_connected :: proc() -> (ok: bool) {
    if (cbopenif != nil) & (factoryif != nil) do return true
    return false
}

controlbuilder_disconnect :: proc() -> (ok: bool) {
    cbopen_disconnect()
    factory_disconnect()
    return true
}

controlbuilder_online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !controlbuilder_connected() do return false, "", false
    
    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->Online(&vb, &bstr_messages)
    if com_failed(hr) {
        return false, "", false
    }

    is_online = (vb == VariantBoolTrue)

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return is_online, messages, false
}

controlbuilder_offline :: proc() -> (messages: string, ok: bool) {
    if !controlbuilder_connected() do return "", false
    
    bstr_messages: BStr
    hr := cbopenif->Offline(&bstr_messages)
    if com_failed(hr) {
        return "", false
    }

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

controlbuilder_setting :: proc {
    controlbuilder_get_setting,
    controlbuilder_set_setting_string,
    controlbuilder_set_setting_bool,
}

controlbuilder_get_setting :: proc(setting_name: string) -> (setting: Variant, ok: bool) {
    if !controlbuilder_connected() do return {}, false
    
    // caller must variant_free(&value) when done, OR we clear on failure only!
    variant_init(&setting)

    bstr_name := to_bstr(setting_name)
    defer bstr_free(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &setting)
    if com_failed(hr) {
        variant_free(&setting)
        return {}, false
    }

    return setting, true
}

controlbuilder_set_setting_string :: proc(setting_name: string, setting: string) -> (ok: bool) {
    if !controlbuilder_connected() do return

    // IDL: SetSetting(SettingName, Value)  — two args, IDL order
    v_setting_name := to_variant(setting_name)
    v_setting := to_variant(setting)
    defer {
        variant_free(&v_setting_name)
        variant_free(&v_setting)
    }

    // args in SetSetting order (setting_name, value)
    args := []Variant{ v_setting_name, v_setting }

    this := cast(^IUnknownIF)cbopenif
    hr, arg_err, ok2 := com_invoke_name(this, "SetSetting", args, nil)
    //fmt.printf("SetSetting Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if !ok2 do return

    return true
}

controlbuilder_set_setting_bool :: proc(setting_name: string, setting: bool) -> (ok: bool) {
    if !controlbuilder_connected() do return

    // IDL: SetSetting(SettingName, Value)  — two args, IDL order
    v_setting_name := to_variant(setting_name)
    v_setting := to_variant(setting)
    defer {
        variant_free(&v_setting_name)
        variant_free(&v_setting)
    }

    // args in SetSetting order (setting_name, value)
    args := []Variant{ v_setting_name, v_setting }

    this := cast(^IUnknownIF)cbopenif
    hr, arg_err, ok2 := com_invoke_name(this, "SetSetting", args, nil)
    //fmt.printf("SetSetting Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if !ok2 do return

    return true
}
