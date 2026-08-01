package sfc

import "../com"
import "../bstr"
import "../variant"

@(private) HResult     :: com.HResult
@(private) BStr        :: bstr.BStr
@(private) GUID        :: com.GUID
@(private) VariantBool :: variant.VariantBool

SFCElementType :: enum i32 {
    Step         = 0,
    Transition   = 1,
    SubSequence  = 2,
    Selection    = 3,
    Simultaneous = 4,
}

SFCPriorityType :: enum i32 {
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5
}
