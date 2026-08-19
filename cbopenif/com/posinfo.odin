package com

import t "../types"

PosInfo :: distinct rawptr

PosInfoIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^PosInfoVTable,
}

PosInfoVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    RowGet:         proc "system" (this: ^PosInfoIF, Row: ^i32) -> HResult,
    RowPut:         proc "system" (this: ^PosInfoIF, Row: i32) -> HResult,
    ColGet:         proc "system" (this: ^PosInfoIF, Col: ^i32) -> HResult,
    ColPut:         proc "system" (this: ^PosInfoIF, Col: i32) -> HResult,
    StartPosGet:    proc "system" (this: ^PosInfoIF, StartPos: ^i32) -> HResult,
    StartPosPut:    proc "system" (this: ^PosInfoIF, StartPos: i32) -> HResult,
    EndPosGet:      proc "system" (this: ^PosInfoIF, EndPos: ^i32) -> HResult,
    EndPosPut:      proc "system" (this: ^PosInfoIF, EndPos: i32) -> HResult,
    ElementNameGet: proc "system" (this: ^PosInfoIF, ElementName: ^BStr) -> HResult,
    ElementNamePut: proc "system" (this: ^PosInfoIF, ElementName: BStr) -> HResult,
    FOUNameGet:     proc "system" (this: ^PosInfoIF, FOUName: ^BStr) -> HResult,
    FOUNamePut:     proc "system" (this: ^PosInfoIF, FOUName: BStr) -> HResult,
    POUNameGet:     proc "system" (this: ^PosInfoIF, POUName: ^BStr) -> HResult,
    POUNamePut:     proc "system" (this: ^PosInfoIF, POUName: BStr) -> HResult,
    TabNameGet:     proc "system" (this: ^PosInfoIF, TabName: ^BStr) -> HResult,
    TabNamePut:     proc "system" (this: ^PosInfoIF, TabName: BStr) -> HResult,
    MessageTypeGet: proc "system" (this: ^PosInfoIF, MessageType: ^i32) -> HResult,
    MessageTypePut: proc "system" (this: ^PosInfoIF, MessageType: i32) -> HResult,
    PageNoGet:      proc "system" (this: ^PosInfoIF, PageNo: ^i32) -> HResult,
    PageNoPut:      proc "system" (this: ^PosInfoIF, PageNo: i32) -> HResult,
    IdGet:          proc "system" (this: ^PosInfoIF, Id: ^BStr) -> HResult,
    IdPut:          proc "system" (this: ^PosInfoIF, Id: BStr) -> HResult,
}

posinfo_row_get :: proc(posinfo: PosInfo) -> (row: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->RowGet(&row)
    if com_failed(hr) do return

    return row, true
}

posinfo_row_set :: proc(posinfo: PosInfo, row: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->RowPut(row)
    if com_failed(hr) do return

    return true
}

posinfo_column_get :: proc(posinfo: PosInfo) -> (column: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->ColGet(&column)
    if com_failed(hr) do return

    return column, true
}

posinfo_column_set :: proc(posinfo: PosInfo, column: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->ColPut(column)
    if com_failed(hr) do return

    return true
}

posinfo_start_position_get :: proc(posinfo: PosInfo) -> (start_position: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->StartPosGet(&start_position)
    if com_failed(hr) do return

    return start_position, true
}

posinfo_start_position_set :: proc(posinfo: PosInfo, start_position: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->StartPosPut(start_position)
    if com_failed(hr) do return

    return true
}

posinfo_end_position_get :: proc(posinfo: PosInfo) -> (end_position: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->EndPosGet(&end_position)
    if com_failed(hr) do return

    return end_position, true
}

posinfo_end_position_set :: proc(posinfo: PosInfo, end_position: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->EndPosPut(end_position)
    if com_failed(hr) do return

    return true
}

posinfo_element_name_get :: proc(posinfo: PosInfo) -> (element_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->ElementNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_element_name_set :: proc(posinfo: PosInfo, element_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(element_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->ElementNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_fou_name_get :: proc(posinfo: PosInfo) -> (fou_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->FOUNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_fou_name_set :: proc(posinfo: PosInfo, fou_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(fou_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->FOUNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_pou_name_get :: proc(posinfo: PosInfo) -> (pou_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->POUNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_pou_name_set :: proc(posinfo: PosInfo, pou_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(pou_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->POUNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_tab_name_get :: proc(posinfo: PosInfo) -> (tab_name: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->TabNameGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_tab_name_set :: proc(posinfo: PosInfo, tab_name: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(tab_name)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->TabNamePut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_message_type_get :: proc(posinfo: PosInfo) -> (message_type: t.Message, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    mt: i32
    hr := (^PosInfoIF)(posinfo)->MessageTypeGet(&mt)
    if com_failed(hr) do return

    return t.Message(mt), true
}

posinfo_message_type_set :: proc(posinfo: PosInfo, message_type: t.Message) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->MessageTypePut(i32(message_type))
    if com_failed(hr) do return

    return true
}

posinfo_page_number_get :: proc(posinfo: PosInfo) -> (page_number: i32, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->PageNoGet(&page_number)
    if com_failed(hr) do return

    return page_number, true
}

posinfo_page_number_set :: proc(posinfo: PosInfo, page_number: i32) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    hr := (^PosInfoIF)(posinfo)->PageNoPut(page_number)
    if com_failed(hr) do return

    return true
}

posinfo_id_get :: proc(posinfo: PosInfo) -> (id: string, ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->IdGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

posinfo_id_set :: proc(posinfo: PosInfo, id: string) -> (ok: bool) {
    if posinfo == nil do return
    if !com_connected() do return

    bs := to_bstr(id)
    defer bstr_free(bs)
    hr := (^PosInfoIF)(posinfo)->IdPut(bs)
    if com_failed(hr) do return

    return true
}

posinfo_release :: proc(posinfo: PosInfo) {
    if posinfo != nil {
        (^PosInfoIF)(posinfo)->Release()
    }
}
