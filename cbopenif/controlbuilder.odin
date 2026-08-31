package cbopenif

import "com"

Connect :: proc() -> (ok: bool)
{
    com.RegisterSurrogate()
    return com.ConnectCom()
}

Connected :: proc() -> (ok: bool)
{
    return com.ComConnected()
}

Disconnect :: proc() -> (ok: bool)
{
    return com.DisconnectCom()
}
