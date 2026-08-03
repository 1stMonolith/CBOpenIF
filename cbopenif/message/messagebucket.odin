package message

import "../com"
import "../controlbuilder"
import "../factory"

@(private="file") BStr    :: com.BStr
@(private="file") HResult :: com.HResult

MessageBucket :: distinct rawptr

MessageBucketIF :: struct #raw_union {
    #subtype iunknownif: com.IUnknownIF,
    using vtable: ^MessageBucketVTable,
}

MessageBucketVTable :: struct {
    using iunknownvtable: com.IUnknownVTable,
    NoOfErrorsGet:   proc "system" (this: ^MessageBucketIF, NoOfErrors: ^i32) -> HResult,
    NoOfErrorsPut:   proc "system" (this: ^MessageBucketIF, NoOfErrors: i32) -> HResult,
    NoOfWarningsGet: proc "system" (this: ^MessageBucketIF, NoOfWarnings: ^i32) -> HResult,
    NoOfWarningsPut: proc "system" (this: ^MessageBucketIF, NoOfWarnings: i32) -> HResult,
    Serialize:       proc "system" (this: ^MessageBucketIF, XML: ^BStr) -> HResult,
    Add:             proc "system" (this: ^MessageBucketIF, Msg: rawptr) -> HResult,
    Item:            proc "system" (this: ^MessageBucketIF, Index: i32, Msg: ^rawptr) -> HResult,
    Count:           proc "system" (this: ^MessageBucketIF, Count: ^i32) -> HResult,
    Remove:          proc "system" (this: ^MessageBucketIF, Index: i32) -> HResult,
}

messagebucket_deserialize :: proc(bucket: ^MessageBucket, xml: string) -> (ok: bool) {
    if !controlbuilder.controlbuilder_connected() do return

    bs := com.from_string(xml)
    defer com.bstr_free(bs)
    hr := factory.factoryif->DeserializeMessageBucket(&bs, cast(^rawptr)bucket)
    if com.failed(hr) do return

    return true
}

messagebucket_serialize :: proc(bucket: MessageBucket) -> (xml: string, ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    bs: BStr
    defer com.bstr_free(bs)
    hr := (^MessageBucketIF)(bucket)->Serialize(&bs)
    if com.failed(hr) do return

    return com.to_string(bs), true
}

messagebucket_number_of_errors :: proc {
    messagebucket_number_of_errors_get,
    messagebucket_number_of_errors_set,
}

messagebucket_number_of_errors_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsGet(&count)
    if com.failed(hr) do return

    return count, true
}

messagebucket_number_of_errors_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfErrorsPut(count)
    if com.failed(hr) do return

    return true
}

messagebucket_number_of_warnings :: proc {
    messagebucket_number_of_warnings_get,
    messagebucket_number_of_warnings_set,
}

messagebucket_number_of_warnings_get :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsGet(&count)
    if com.failed(hr) do return

    return count, true
}

messagebucket_number_of_warnings_set :: proc(bucket: MessageBucket, count: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->NoOfWarningsPut(count)
    if com.failed(hr) do return

    return true
}

messagebucket_message_add :: proc(bucket: MessageBucket, msg: Msg) -> (ok: bool) {
    if bucket == nil do return
    if msg == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Add(msg)
    if com.failed(hr) do return

    return true
}

messagebucket_message_by_index :: proc(bucket: MessageBucket, index: i32) -> (msg: Msg, ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Item(index, cast(^rawptr)&msg)
    if com.failed(hr) do return

    return msg, true
}

messagebucket_message_count :: proc(bucket: MessageBucket) -> (count: i32, ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Count(&count)
    if com.failed(hr) do return

    return count, true
}

messagebucket_message_remove_by_index :: proc(bucket: MessageBucket, index: i32) -> (ok: bool) {
    if bucket == nil do return
    if !controlbuilder.controlbuilder_connected() do return

    hr := (^MessageBucketIF)(bucket)->Remove(index)
    if com.failed(hr) do return

    return true
}

messagebucket_release :: proc(bucket: MessageBucket) {
    if bucket != nil {
        (^MessageBucketIF)(bucket)->Release()
    }
}
