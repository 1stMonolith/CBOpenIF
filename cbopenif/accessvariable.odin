package cbopenif

import "com"

AccessVariableKind :: enum i32 {
    Named     = 0,
    Addressed = 1,
}

AccessVariable :: struct {
    kind:          AccessVariableKind,
    name:          string,
    protocol_name: string,
    path:          string,
    row:           i32,
    va_attribute:  string,
    va_type:       string,
    va_type_path:  string,
}

AccessVariables :: struct {
    named:     [dynamic]AccessVariable,
}
