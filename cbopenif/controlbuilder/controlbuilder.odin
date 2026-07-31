package controlbuilder

import "../cbopen"
import "../factory"

connect :: proc() -> (ok: bool) {
    cbopen.connect()
    factory.connect()
    return true
}

connected :: proc() -> (ok: bool) {
    if (cbopen.cbopenif != nil) & (factory.factoryif != nil) do return true
    return false
}

disconnect :: proc() -> (ok: bool) {
    cbopen.disconnect()
    factory.disconnect()
    return true
}

online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !controlbuilder.connected() do return false, "", false
    vb: VariantBool
    bstr_messages: BStr

    hr := cbopenif->Online(&vb, &bstr_messages)
    if com.failed(hr) {
        return false, "", false
    }

    is_online = (vb == VariantBoolTrue)

    if bstr_messages != nil {
        defer bstr.free(bstr_messages)
        messages = bstr.to_string(bstr_messages)
    }

    return is_online, messages, false
}

offline :: proc() -> (messages: string, ok: bool) {
    if !controlbuilder.connected() do return "", false
    bstr_messages: BStr

    hr := cbopenif->Offline(&bstr_messages)
    if com.failed(hr) {
        return "", false
    }

    if bstr_messages != nil {
        defer bstr.free(bstr_messages)
        messages = bstr.to_string(bstr_messages)
    }

    return messages, true
}

get_setting :: proc(setting_name: string) -> (setting: Variant, ok: bool) {
    if !controlbuilder.connected() do return {}, false
    variant_init(&setting) // caller must variant_free(&value) when done, OR we clear on failure only!

    bstr_name := bstr.from_string(setting_name)
    defer bstr.free(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &setting)
    if com.failed(hr) {
        variant_free(&setting)
        return {}, false
    }

    return setting, true
}
