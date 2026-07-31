package controlbuilder

import "../com"
import "../variant"
import "../bstr"
import "../cbopen"
import "../factory"

@(private) BStr             :: bstr.BStr
@(private) Variant          :: variant.Variant
@(private) VariantBool      :: variant.VariantBool
@(private) VariantBoolTrue  :: variant.VariantBoolTrue
@(private) VariantBoolFalse :: variant.VariantBoolFalse

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
    if !connected() do return false, "", false
    vb: VariantBool
    bstr_messages: BStr

    hr := cbopen.cbopenif->Online(&vb, &bstr_messages)
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
    if !connected() do return "", false
    bstr_messages: BStr

    hr := cbopen.cbopenif->Offline(&bstr_messages)
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
    if !connected() do return {}, false
    variant.init(&setting) // caller must variant_free(&value) when done, OR we clear on failure only!

    bstr_name := bstr.from_string(setting_name)
    defer bstr.free(bstr_name)

    hr := cbopen.cbopenif->GetSetting(bstr_name, &setting)
    if com.failed(hr) {
        variant.free(&setting)
        return {}, false
    }

    return setting, true
}
