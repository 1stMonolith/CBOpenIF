package cbopenif

import "com"

AccessVariableKind :: enum i32
{
    Named     = 0,
    Addressed = 1,
}

AccessVariable :: struct
{
    kind:      AccessVariableKind,
    name:      string,
    protocol:  string,
    path:      string,
    row:       i32,
    attribute: string,
    type:      string,
    typepath:  string,
}

AccessVariables :: struct
{
    named: [dynamic]AccessVariable,
}
