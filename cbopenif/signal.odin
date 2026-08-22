package cbopenif

import "com"

Signal :: struct {
    name:              string,
    path:              string,
    direction:         Direction,
    acknowledge_group: string,
    description:       string,
}

signal_from_com :: proc(signal: Signal, allocator := context.allocator) -> (result: t.Signal, ok: bool) {
    if signal == nil do return

    context.allocator = allocator

    result.name, ok = name(signal)
    if !ok do return
    result.path, ok = path(signal)
    if !ok do return

    dir_str: string
    dir_str, ok = direction(signal)
    if !ok do return
    result.direction = t.direction_from_string(dir_str)

    result.acknowledge_group, ok = acknowledge_group(signal)
    if !ok do return
    result.description, ok = description(signal)
    if !ok do return

    return result, true
}

signal_to_com :: proc(src: t.Signal) -> (result: Signal, ok: bool) {
    signal: Signal
    signal, ok = signal_new(
        src.name,
        src.path,
        t.direction_to_string(src.direction),
        src.acknowledge_group,
    )
    if !ok do return
    defer if !ok do release(signal)

    ok = description(signal, src.description)
    if !ok do return

    return signal, true
}

signals_from_com :: proc(sigs: Signals, allocator := context.allocator) -> (result: [dynamic]t.Signal, ok: bool) {
    if sigs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = signal_count(sigs)
    if !ok do return

    result = make([dynamic]t.Signal, 0, int(count), allocator)
    for i in 0..<count {
        s: Signal
        s, ok = signal_by_index(sigs, i)
        if !ok do return
        defer release(s)

        ss: t.Signal
        ss, ok = signal_from_com(s)
        if !ok do return
        append(&result, ss)
    }
    return result, true
}

signals_to_com :: proc(sigs: Signals, src: []t.Signal) -> (ok: bool) {
    if sigs == nil do return
    for item in src {
        s: Signal
        s, ok = signal_to_com(item)
        if !ok do return
        defer release(s)
        ok = signal_add(sigs, s)
        if !ok do return
    }
    return true
}
