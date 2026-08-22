package cbopenif

import "com"

initvalue_from_com :: proc(initvalue: InitValue, allocator := context.allocator) -> (result: t.InitValue, ok: bool) {
    if initvalue == nil do return

    context.allocator = allocator

    result.name, ok = name(initvalue)
    if !ok do return
    result.pou_path, ok = pou_path(initvalue)
    if !ok do return
    result.value, ok = initvalue_value_get(initvalue)
    if !ok do return

    return result, true
}

initvalue_to_com :: proc(src: t.InitValue) -> (result: InitValue, ok: bool) {
    initvalue: InitValue
    initvalue, ok = initvalue_new(src.pou_path, src.name, src.value)
    if !ok do return

    return initvalue, true
}

initvalues_from_com :: proc(ivs: InitValues, allocator := context.allocator) -> (result: [dynamic]t.InitValue, ok: bool) {
    if ivs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = initvalue_count(ivs)
    if !ok do return

    result = make([dynamic]t.InitValue, 0, int(count), allocator)
    for i in 0..<count {
        iv: InitValue
        iv, ok = initvalue_by_index(ivs, i)
        if !ok do return
        defer release(iv)

        ivs_: t.InitValue
        ivs_, ok = initvalue_from_com(iv)
        if !ok do return
        append(&result, ivs_)
    }
    return result, true
}

initvalues_to_com :: proc(ivs: InitValues, src: []t.InitValue) -> (ok: bool) {
    if ivs == nil do return
    for item in src {
        iv: InitValue
        iv, ok = initvalue_to_com(item)
        if !ok do return
        defer release(iv)
        ok = initvalue_add(ivs, iv)
        if !ok do return
    }
    return true
}
