package project

import "../bstr"
import "../cbopen"
import "../com"
import "../controlbuilder"

project_new :: proc(name, dir, guid, template: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return false
    bstr_name     := bstr.from_string(name)
    bstr_dir      := bstr.from_string(dir)
    bstr_guid     := bstr.from_string(guid)
    bstr_template := bstr.from_string(template)
    defer {
        bstr.free(bstr_name)
        bstr.free(bstr_dir)
        bstr.free(bstr_guid)
        bstr.free(bstr_template)
    }
    hr := cbopen.cbopenif->NewProject(bstr_name, bstr_dir, bstr_guid, bstr_template)
    if com.failed(hr) do return
    return true
}

project_open :: proc(file_path: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return false
    bstr_file_path     := bstr.from_string(file_path)
    defer bstr.free(bstr_file_path)
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
