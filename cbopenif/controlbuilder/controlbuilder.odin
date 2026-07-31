package controlbuilder

import "../cbopen"
import "../factory"

connect :: proc() -> (ok: bool) {
    cbopen.connect()
    factory.connect()
    return true
}

disconnect :: proc() -> (ok: bool) {
    cbopen.disconnect()
    factory.disconnect()
    return true
}

connected :: proc() -> (ok: bool) {
    if (cbopen.cbopenif != nil) & (factory.factoryif != nil) do return true
    return false
}

online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !connected() do return false, "", false
    vb: VariantBool
    bstr_messages: BStr

    hr := cbopenif->Online(&vb, &bstr_messages)
    if failed(hr) {
        return false, "", false
    }

    is_online = (vb == VariantBoolTrue)

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = bstr_to_string(bstr_messages)
    }

    return is_online, messages, false
}

offline :: proc() -> (messages: string, ok: bool) {
    if !connected() do return "", false
    bstr_messages: BStr

    hr := cbopenif->Offline(&bstr_messages)
    if failed(hr) {
        return "", false
    }

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = bstr_to_string(bstr_messages)
    }

    return messages, true
}

get_setting :: proc(setting_name: string) -> (setting: Variant, ok: bool) {
    if !connected() do return {}, false
    variant_init(&setting) // caller must variant_free(&value) when done, OR we clear on failure only!

    bstr_name := string_to_bstr(setting_name)
    defer bstr_free(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &setting)
    if failed(hr) {
        variant_free(&setting)
        return {}, false
    }

    return setting, true
}
