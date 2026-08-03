package project

import "../cbopen"
import "../com"
import "../controlbuilder"

project_new :: proc(name, dir, guid, template: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return false
    bstr_name     := com.from_string(name)
    bstr_dir      := com.from_string(dir)
    bstr_guid     := com.from_string(guid)
    bstr_template := com.from_string(template)
    defer {
        com.bstr_free(bstr_name)
        com.bstr_free(bstr_dir)
        com.bstr_free(bstr_guid)
        com.bstr_free(bstr_template)
    }
    hr := cbopen.cbopenif->NewProject(bstr_name, bstr_dir, bstr_guid, bstr_template)
    if com.failed(hr) do return
    return true
}

project_open :: proc(file_path: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return false
    bstr_file_path     := com.from_string(file_path)
    defer com.bstr_free(bstr_file_path)
    hr := cbopen.cbopenif->OpenProject(bstr_file_path)
    if com.failed(hr) do return
    return true
}

project_close :: proc() -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return false
    hr := cbopen.cbopenif->CloseProject()
    if com.failed(hr) do return
    return true
}

project_refresh :: proc() -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return false
    hr := cbopen.cbopenif->RefreshProject()
    if com.failed(hr) do return
    return true
}
