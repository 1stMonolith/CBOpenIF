package cbopenif

MessageBucket :: distinct rawptr

MessageBucketIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^MessageBucketVTable,
}

MessageBucketVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    NoOfErrorsGet:   proc "system" (this: ^MessageBucketIF, NoOfErrors: ^i32) -> HResult,
    NoOfErrorsPut:   proc "system" (this: ^MessageBucketIF, NoOfErrors: i32) -> HResult,
    NoOfWarningsGet: proc "system" (this: ^MessageBucketIF, NoOfWarnings: ^i32) -> HResult,
    NoOfWarningsPut: proc "system" (this: ^MessageBucketIF, NoOfWarnings: i32) -> HResult,
    Serialize:       proc "system" (this: ^MessageBucketIF, XML: ^BStr) -> HResult,
    Add:             proc "system" (this: ^MessageBucketIF, Message: rawptr) -> HResult,
    Item:            proc "system" (this: ^MessageBucketIF, Index: i32, Message: ^rawptr) -> HResult,
    Count:           proc "system" (this: ^MessageBucketIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^MessageBucketIF, Index: i32) -> HResult,
}

messagebucket_deserialize :: proc(bucket: ^MessageBucket, xml: string) -> (ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeMessageBucket(&bs, cast(^rawptr)bucket)
    if com_failed(hr) do return

    return true
}

messagebucket_serialize :: proc(bucket: MessageBucket) -> (xml: string, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^MessageBucketIF)(bucket)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

messagebucket_number_of_errors :: proc {
    messagebucket_number_of_errors_get,
    messagebucket_number_of_errors_set,
}

messagebucket_number_of_errors_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsGet(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_number_of_errors_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsPut(count)
    if com_failed(hr) do return

    return true
}

messagebucket_number_of_warnings :: proc {
    messagebucket_number_of_warnings_get,
    messagebucket_number_of_warnings_set,
}

messagebucket_number_of_warnings_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsGet(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_number_of_warnings_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsPut(count)
    if com_failed(hr) do return

    return true
}

messagebucket_message_add :: proc(bucket: MessageBucket, message: Message) -> (ok: bool) {
    if bucket == nil do return
    if message == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Add(message)
    if com_failed(hr) do return

    return true
}

messagebucket_message_by_index :: proc(bucket: MessageBucket, index: i32) -> (message: Message, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Item(index, cast(^rawptr)&message)
    if com_failed(hr) do return

    return message, true
}

messagebucket_message_count :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

messagebucket_message_remove_by_index :: proc(bucket: MessageBucket, index: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Remove(index)
    if com_failed(hr) do return

    return true
}

messagebucket_release :: proc(bucket: MessageBucket) {
    if bucket != nil {
        (^MessageBucketIF)(bucket)->Release()
    }
}
