package cbopenif

import "com"

Scope :: enum i32 {
    Public  = 0,
    Private = 1,
}

Direction :: enum i32 {
    Input  = 0,
    Output = 1,
    InOut  = 2,
}

// For Signal and CommVariable COM because it exposes Direction as BStr
direction_from_string :: proc(s: string) -> Direction {
    switch s {
        case "Input",  "0": return .Input
        case "Output", "1": return .Output
        case "InOut",  "2": return .InOut
        case:               return .Input
    }
}

// For Signal and CommVariable COM because it exposes Direction as BStr
direction_to_string :: proc(d: Direction) -> string {
    switch d {
        case .Input:  return "Input"
        case .Output: return "Output"
        case .InOut:  return "InOut"
        case:         return "Input"
    }
}

InitValue :: struct {
    name:     string,
    pou_path: string,
    value:    string,
}