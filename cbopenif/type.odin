package cbopenif

MAX_COMPONENTS :: 256

Scope :: enum i32
{
    Public  = 0,
    Private = 1,
}

Direction :: enum i32
{
    In  = 0,
    Out = 1,
    Unspecified = 2,
}

// For Signal and CommVariable COM because it exposes Direction as BStr
DirectionFromString :: proc(s: string) -> Direction
{
    switch s {
        case "in",  "0":         return .In
        case "out", "1":         return .Out
        case "unspecified", "2": return .Unspecified
        case:                    return .Unspecified
    }
}

// For Signal and CommVariable COM because it exposes Direction as BStr
DirectionToString :: proc(d: Direction) -> string
{
    switch d {
        case .In:          return "in"
        case .Out:         return "out"
        case .Unspecified: return "unspecified"
        case:              return "unspecified"
    }
}

SILLevel :: enum i32
{
    SIL0 = 0,
    SIL2 = 1,
    SIL3 = 2,
}

SILToString :: proc(s: SILLevel) -> string
{
    switch s {
        case .SIL0: return "0"
        case .SIL2: return "2"
        case .SIL3: return "3"
        case:       return "0"
    }
}

InitValue :: struct
{
    name:     string,
    pou_path: string,
    value:    string,
}