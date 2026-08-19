package cbopenif

import "com"
import reg "registry"

connect :: proc() -> (ok: bool) {
    reg.register_surrogate()
    return com.com_connect()
}

connected :: proc() -> (ok: bool) {
    return com.com_connected()
}

disconnect :: proc() -> (ok: bool) {
    return com.com_disconnect()
}
