package cbopenif

project_new :: proc(name, dir, guid, template: string) -> (ok: bool) {
    if !connected() do return false
    bstr_name     := string_to_bstr(name)
    bstr_dir      := string_to_bstr(dir)
    bstr_guid     := string_to_bstr(guid)
    bstr_template := string_to_bstr(template)
    defer {
        SysFreeString(bstr_name)
        SysFreeString(bstr_dir)
        SysFreeString(bstr_guid)
        SysFreeString(bstr_template)
    }
    hr := cbopenif->NewProject(bstr_name, bstr_dir, bstr_guid, bstr_template)
    if failed(hr) {
        return false
    }
    return true
}

project_open :: proc(file_path: string) -> (ok: bool) {
    if !connected() do return false
    bstr_file_path     := string_to_bstr(file_path)
    defer SysFreeString(bstr_file_path)
    hr := cbopenif->OpenProject(bstr_file_path)
    if failed(hr) {
        return false
    }
    return true
}

project_close :: proc() -> (ok: bool) {
    if !connected() do return false
    hr := cbopenif->CloseProject()
    if failed(hr) {
        return false
    }
    return true
}

project_refresh :: proc() -> (ok: bool) {
    if !connected() do return false
    hr := cbopenif->RefreshProject()
    if failed(hr) {
        return false
    }
    return true
}