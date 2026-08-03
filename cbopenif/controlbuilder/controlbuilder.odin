package controlbuilder

import "../cbopen"
import "../com"
import "../factory"

@(private="file") BStr             :: com.BStr
@(private="file") Variant          :: com.Variant
@(private="file") VariantBool      :: com.VariantBool
@(private="file") VariantBoolTrue  :: com.VariantBoolTrue
@(private="file") VariantBoolFalse :: com.VariantBoolFalse

controlbuilder_connect :: proc() -> (ok: bool) {
    cbopen.connect()
    factory.connect()
    return true
}

controlbuilder_connected :: proc() -> (ok: bool) {
    if (cbopen.cbopenif != nil) & (factory.factoryif != nil) do return true
    return false
}

controlbuilder_disconnect :: proc() -> (ok: bool) {
    cbopen.disconnect()
    factory.disconnect()
    return true
}

controlbuilder_online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !controlbuilder_connected() do return false, "", false
    vb: VariantBool
    bstr_messages: BStr

    hr := cbopen.cbopenif->Online(&vb, &bstr_messages)
    if com.failed(hr) {
        return false, "", false
    }

    is_online = (vb == VariantBoolTrue)

    if bstr_messages != nil {
        defer com.bstr_free(bstr_messages)
        messages = com.to_string(bstr_messages)
    }

    return is_online, messages, false
}

controlbuilder_offline :: proc() -> (messages: string, ok: bool) {
    if !controlbuilder_connected() do return "", false
    bstr_messages: BStr

    hr := cbopen.cbopenif->Offline(&bstr_messages)
    if com.failed(hr) {
        return "", false
    }

    if bstr_messages != nil {
        defer com.bstr_free(bstr_messages)
        messages = com.to_string(bstr_messages)
    }

    return messages, true
}

/* use of Variant as an out required use of IDispatch->Invoke
set_setting :: proc(setting_name: string, value: Variant) -> (ok: bool) {
    ok = false
    if !connected() do return

    bstr_name := com.from_string(setting_name)
    defer com.bstr_free(bstr_name)

    // value is copied into the call by value; we still own our VARIANT
    hr := cbopen.cbopenif->SetSetting(bstr_name, value)
    if com.failed(hr) {
        return
    }
    return true
}
*/

controlbuilder_setting :: proc {
    controlbuilder_get_setting,
    controlbuilder_set_setting_string,
}

controlbuilder_get_setting :: proc(setting_name: string) -> (setting: Variant, ok: bool) {
    
    if !controlbuilder_connected() do return {}, false
    
    // caller must variant_free(&value) when done, OR we clear on failure only!
    com.variant_init(&setting)

    bstr_name := com.from_string(setting_name)
    defer com.bstr_free(bstr_name)

    hr := cbopen.cbopenif->GetSetting(bstr_name, &setting)
    if com.failed(hr) {
        com.variant_free(&setting)
        return {}, false
    }

    return setting, true
}

// TODO: make version for each Variant type used in interface so user does not have to deal with Variant at all.
controlbuilder_set_setting_string :: proc(setting_name: string, setting: string) -> (ok: bool) {

    if !controlbuilder_connected() do return

    // IDL: SetSetting(SettingName, Value)  — two args, IDL order
    v_setting_name := com.to_variant(setting_name)
    v_setting := com.to_variant(setting)
    defer {
        com.variant_free(&v_setting_name)
        com.variant_free(&v_setting)
    }

    // args in SetSetting order (setting_name, value)
    args := []com.Variant{ v_setting_name, v_setting }

    this := cast(^com.IUnknownIF)cbopen.cbopenif
    hr, arg_err, ok2 := com.invoke_name(this, "SetSetting", args, nil)
    //fmt.printf("SetSetting Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if !ok2 do return

    return true
}
