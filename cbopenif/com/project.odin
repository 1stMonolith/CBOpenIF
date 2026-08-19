package com

project_new :: proc(name, dir, guid, template: string) -> (ok: bool) {
    if !com_connected() do return false
    
    bstr_name     := to_bstr(name)
    bstr_dir      := to_bstr(dir)
    bstr_guid     := to_bstr(guid)
    bstr_template := to_bstr(template)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_dir)
        bstr_free(bstr_guid)
        bstr_free(bstr_template)
    }
    hr := cbopenif->NewProject(bstr_name, bstr_dir, bstr_guid, bstr_template)
    if com_failed(hr) do return
    
    return true
}

project_open :: proc(file_path: string) -> (ok: bool) {
    if !com_connected() do return false
    
    bstr_file_path := to_bstr(file_path)
    defer bstr_free(bstr_file_path)
    hr := cbopenif->OpenProject(bstr_file_path)
    if com_failed(hr) do return
    
    return true
}

project_close :: proc() -> (ok: bool) {
    if !com_connected() do return false
    
    hr := cbopenif->CloseProject()
    if com_failed(hr) do return
    
    return true
}

project_refresh :: proc() -> (ok: bool) {
    if !com_connected() do return false
    
    hr := cbopenif->RefreshProject()
    if com_failed(hr) do return
    
    return true
}
