package com

controlbuilder_connect :: proc() -> (ok: bool) {
    cbopen_connect()
    factory_connect()
    return true
}

controlbuilder_connected :: proc() -> (ok: bool) {
    if (cbopenif != nil) & (objectfactory != nil) do return true
    return false
}

controlbuilder_disconnect :: proc() -> (ok: bool) {
    cbopen_disconnect()
    factory_disconnect()
    return true
}
