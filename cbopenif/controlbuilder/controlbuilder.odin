package controlbuilder

import "../com"
import "../variant"
import "../bstr"
import "../cbopen"
import "../factory"

import "core:fmt"

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

set_setting :: proc(setting_name: string, value: Variant) -> (ok: bool) {
    ok = false
    if !connected() do return

    bstr_name := bstr.from_string(setting_name)
    defer bstr.free(bstr_name)

    // value is copied into the call by value; we still own our VARIANT
    hr := cbopen.cbopenif->SetSetting(bstr_name, value)
    fmt.printf("SetSetting hr=0x%X\n", u32(hr))
    if com.failed(hr) {
        return
    }
    return true
}

set_setting_invoke :: proc(setting_name: string, value: Variant) -> (ok: bool) {
    ok = false
    if !connected() do return

    // IDL: SetSetting(SettingName, Value)  — two args, IDL order
    v_name := variant.string_to_variant(setting_name)
    defer variant.free(&v_name)

    // value is already a Variant; do not free the caller's copy here
    args := []variant.Variant{ v_name, value }

    this := cast(^com.IUnknownIF)cbopen.cbopenif
    hr, arg_err, ok2 := com.invoke_name(this, "SetSetting", args, nil)
    if !ok2 {
        fmt.printf("SetSetting Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
        return false
    }
    return true
}


get_setting :: proc(setting_name: string) -> (setting: Variant, ok: bool) {
    if !connected() do return {}, false
    variant.init(&setting) // caller must variant_free(&value) when done, OR we clear on failure only!

    bstr_name := bstr.from_string(setting_name)
    defer bstr.free(bstr_name)

    hr := cbopen.cbopenif->GetSetting(bstr_name, &setting)
    fmt.printf("NewSignal hr = 0x%X\n", u32(hr))
    if com.failed(hr) {
        variant.free(&setting)
        return {}, false
    }

    return setting, true
}