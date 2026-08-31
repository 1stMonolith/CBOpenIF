package cbopenif

import "com"

Signal :: struct
{
    name:             string,
    path:             string,
    direction:        Direction,
    acknowledgegroup: string,
    description:      string,
}

SignalsFromCom :: proc(comsignals: com.Signals, signals: ^[dynamic]Signal) -> (ok: bool)
{
    if comsignals == nil do return

    count: i32
    count, ok = com.SignalCount(comsignals)
    if !ok do return

    for i in 0..<count {
        comsignal: com.Signal
        comsignal, ok = com.GetSignal(comsignals, i)
        if !ok do return
        defer com.Release(comsignal)

        signal: Signal
        signal, ok = SignalFromCom(comsignal)
        if !ok do return
        append(signals, signal)
    }
    return true
}

SignalFromCom :: proc(comsignal: com.Signal) -> (signal: Signal, ok: bool)
{
    if comsignal == nil do return

    signal.name, ok = com.Name(comsignal)
    if !ok do return
    signal.path, ok = com.Path(comsignal)
    if !ok do return

    direction: string
    direction, ok = com.Direction(comsignal)
    if !ok do return
    signal.direction = DirectionFromString(direction)

    signal.acknowledgegroup, ok = com.AcknowledgeGroup(comsignal)
    if !ok do return
    signal.description, ok = com.Description(comsignal)
    if !ok do return

    return signal, true
}

SignalsToCom :: proc(comsignals: com.Signals, signals: []Signal) -> (ok: bool)
{
    if comsignals == nil do return
    
    for signal in signals {
        comsignal: com.Signal
        comsignal, ok = SignalToCom(signal)
        if !ok do return
        defer com.Release(comsignal)
        
        ok = com.AddSignal(comsignals, comsignal)
        if !ok do return
    }
    return true
}

SignalToCom :: proc(signal: Signal) -> (comsignal: com.Signal, ok: bool)
{
    comsignal, ok = com.NewSignal(
        signal.name,
        signal.path,
        DirectionToString(signal.direction),
        signal.acknowledgegroup,
    )
    if !ok do return
    defer if !ok do com.Release(comsignal)

    ok = com.Description(comsignal, signal.description)
    if !ok do return

    return comsignal, true
}
