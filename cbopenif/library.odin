package cbopenif

import "core:strings"
import "com"

library_new :: proc(library_name, directory_path: string) {
    ok: bool
    ok = com.cbopen_new_library(library_name, directory_path, "")
}

library_rename :: proc(library_name, new_library_name: string) {
    ok: bool
    ok = com.cbopen_rename_library(library_name, new_library_name)
}

library_delete :: proc(library_name: string) {
    ok: bool
    ok = com.cbopen_delete_library(library_name)
}
