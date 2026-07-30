package cbopenif

foreign import oleaut32 "system:oleaut32.lib"

@(default_calling_convention="system")
foreign oleaut32 {
    VariantInit  :: proc(pvarg: ^Variant) ---
    VariantClear :: proc(pvarg: ^Variant) ---
}

VariantType      :: distinct u16
VariantTypeEmpty    :: VariantType(0)
VariantTypeNull     :: VariantType(1)
VariantTypeI2       :: VariantType(2)
VariantTypeI4       :: VariantType(3)
VariantTypeR4       :: VariantType(4)
VariantTypeR8       :: VariantType(5)
VariantTypeCY       :: VariantType(6)
VariantTypeDate     :: VariantType(7)
VariantTypeBstr     :: VariantType(8)
VariantTypeDispatch :: VariantType(9)
VariantTypeError    :: VariantType(10)
VariantTypeBool     :: VariantType(11)
VariantTypeVariant  :: VariantType(12)
VariantTypeUnknown  :: VariantType(13)
VariantTypeDecimal  :: VariantType(14)
VariantTypeI1       :: VariantType(16)
VariantTypeUI1      :: VariantType(17)
VariantTypeUI2      :: VariantType(18)
VariantTypeUI4      :: VariantType(19)
VariantTypeI8       :: VariantType(20)
VariantTypeUI8      :: VariantType(21)
VariantTypeInt      :: VariantType(22)
VariantTypeUint     :: VariantType(23)

VariantBool      :: distinct i16
VariantBoolTrue  :: VariantBool(-1)
VariantBoolFalse :: VariantBool(0)

Variant :: struct #raw_union {
    using _: struct {
        vt:         VariantType,
        wReserved1: u16,
        wReserved2: u16,
        wReserved3: u16,
        using _: struct #raw_union {
            llVal:    i64,
            lVal:     i32,
            bVal:     u8,
            iVal:     i16,
            fltVal:   f32,
            dblVal:   f64,
            boolVal:  VariantBool,
            scode:    i32,
            bstrVal:  BStr,
            punkVal:  rawptr, // ^IUnknown
            pdispVal: rawptr, // ^IDispatch
            puintVal: ^u32,
        },
    },
}

string_to_variant :: proc(s: string) -> Variant {
    v: Variant
    VariantInit(&v)
    v.vt = VariantTypeBstr
    v.bstrVal = string_to_bstr(s)
    return v
}

bool_to_variant :: proc(b: bool) -> Variant {
    v: Variant
    VariantInit(&v)
    v.vt = VariantTypeBool
    v.boolVal = VariantBoolTrue if b else VariantBoolFalse
    return v
}

bool_to_variantbool :: proc(b: bool) -> VariantBool {
    return VariantBoolTrue if b else VariantBoolFalse
}

variantbool_to_bool :: proc(vb: VariantBool) -> bool {
    return true if vb == VariantBoolTrue else false
}