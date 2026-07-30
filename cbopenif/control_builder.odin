package cbopenif

controlbuilder_online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !connected() do return false, "", false
    vb: VariantBool
    bstr_messages: BStr

    hr := cbopenif->Online(&vb, &bstr_messages)
    if failed(hr) {
        return false, "", false
    }

    is_online = (vb == VariantBoolTrue)

    if bstr_messages != nil {
        defer SysFreeString(bstr_messages)
        messages = bstr_to_string(bstr_messages)
    }

    return is_online, messages, false
}

controlbuilder_offline :: proc() -> (messages: string, ok: bool) {
    if !connected() do return "", false
    bstr_messages: BStr

    hr := cbopenif->Offline(&bstr_messages)
    if failed(hr) {
        return "", false
    }

    if bstr_messages != nil {
        defer SysFreeString(bstr_messages)
        messages = bstr_to_string(bstr_messages)
    }

    return messages, true
}

controlbuilder_get_setting :: proc(setting_name: string) -> (value: Variant, ok: bool) {
    if !connected() do return {}, false
    VariantInit(&value) // caller must VariantClear(&value) when done, OR we clear on failure only!

    bstr_name := string_to_bstr(setting_name)
    defer SysFreeString(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &value)
    if failed(hr) {
        VariantClear(&value)
        return {}, false
    }

    return value, true
}
