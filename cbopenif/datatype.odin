package cbopenif

import "core:strings"
import "com"

datatype_new :: proc(library_name: string, datatype: DataType) {
    ok: bool
    cdt: com.DataType
    xml, msg: string
    
    cdt, ok = com.datatype_to_com(datatype)
    defer com.release(cdt)
    xml, ok = com.datatype_serialize(cdt)

    // TODO: find out why is this required
    xml, _ = strings.replace_all(xml, "AuthenticationLevel=''", "AuthenticationLevel='None'")
    // or this....
    //xml, _ = strings.replace_all(xml, "AuthenticationLevel=''", "")

    msg, ok = com.cbopen_new_data_type(datatype.name, library_name, xml)
}

datatype_get :: proc(library_name: string, datatype_name: string) -> (datatype: DataType) {
    ok: bool
    cdt: com.DataType
    dt: DataType
    xml: string

    path := strings.concatenate({library_name, ".", datatype_name})
    defer delete(path)

    xml, ok = com.cbopen_get_data_type(path)
    cdt, ok = com.datatype_deserialize(xml)
    defer com.release(cdt)
    dt, ok = com.datatype_from_com(cdt)

    return dt
}

datatype_set :: proc(library_name: string, datatype_name: string, datatype: DataType) {
}

datatype_delete :: proc(library_name: string, datatype_name: string) {
    ok: bool

    path := strings.concatenate({library_name, ".", datatype_name})
    defer delete(path)

    ok = com.cbopen_delete_data_type(path)
}