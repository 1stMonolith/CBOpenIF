package graph

AutoPos :: enum i32 {
    Top    = 0,
    Bottom = 1,
    Left   = 2,
    Right  = 3,
}

i32_to_autopos :: proc(n: i32) -> (AutoPos, bool) {
    switch n {
        case 0: return .Top, true
        case 1: return .Bottom, true
        case 2: return .Left, true
        case 3: return .Right, true
    }
    return {}, false
}