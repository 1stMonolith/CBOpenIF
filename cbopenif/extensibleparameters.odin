package cbopenif

ExtensibleParameters :: distinct rawptr

ExtensibleParametersIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ExtensibleParametersVTable,
}

ExtensibleParametersVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Add:       proc "system" (this: ^ExtensibleParametersIF, Parameter: rawptr) -> HResult,
    AddBefore: proc "system" (this: ^ExtensibleParametersIF, Parameter: rawptr, Index: i32) -> HResult,
    Add1:      proc "system" (this: ^ExtensibleParametersIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    Add2:      proc "system" (this: ^ExtensibleParametersIF, Name, TypeName, Attribute: BStr, Direction: i32, InitialValue, Description: BStr, Parameter: ^rawptr) -> HResult,
    Find:      proc "system" (this: ^ExtensibleParametersIF, Name: BStr, Parameter: ^rawptr) -> HResult,
    FindNr:    proc "system" (this: ^ExtensibleParametersIF, Name: BStr, Index: ^i32) -> HResult,
    Item:      proc "system" (this: ^ExtensibleParametersIF, Index: i32, Parameter: ^rawptr) -> HResult,
    Count:     proc "system" (this: ^ExtensibleParametersIF, Count: ^i32) -> HResult,
    Remove:    proc "system" (this: ^ExtensibleParametersIF, Index: i32) -> HResult,
}

extensibleparameters_add :: proc {
    extensibleparameters_add_,
    extensibleparameters_add_at_index,
}

extensibleparameters_add_ :: proc(extensibleparameters: ExtensibleParameters, externalparameter: ExtensibleParameter) -> (ok: bool) {
    if extensibleparameters == nil do return
    if externalparameter == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Add(externalparameter)
    if com_failed(hr) do return

    return true
}

extensibleparameters_add_at_index :: proc(extensibleparameters: ExtensibleParameters, externalparameter: ExtensibleParameter, index: i32) -> (ok: bool) {
    if extensibleparameters == nil do return
    if externalparameter == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->AddBefore(externalparameter, index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_parameter :: proc {
    extensibleparameters_parameter_by_name,
    extensibleparameters_parameter_by_index,
}

extensibleparameters_parameter_by_name :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (externalparameter: ExtensibleParameter, ok: bool) {
    if extensibleparameters == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->Find(bstr_name, cast(^rawptr)&externalparameter)
    if com_failed(hr) do return

    return externalparameter, true
}

extensibleparameters_parameter_by_index :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (externalparameter: ExtensibleParameter, ok: bool) {
    if extensibleparameters == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Item(index, cast(^rawptr)&externalparameter)
    if com_failed(hr) do return

    return externalparameter, true
}

extensibleparameters_parameter_index :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (index: i32, ok: bool) {
    if extensibleparameters == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ExtensibleParametersIF)(extensibleparameters)->FindNr(bstr_name, &index)
    if com_failed(hr) do return

    return index, true
}

extensibleparameters_count :: proc(extensibleparameters: ExtensibleParameters) -> (count: i32, ok: bool) {
    if extensibleparameters == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Count(&count)
    if com_failed(hr) do return

    return count, true
}

extensibleparameters_remove :: proc {
    extensibleparameters_remove_by_name,
    extensibleparameters_remove_by_index,
}

extensibleparameters_remove_by_name :: proc(extensibleparameters: ExtensibleParameters, name: string) -> (ok: bool) {
    if extensibleparameters == nil do return
    if !controlbuilder_connected() do return

    index, found := extensibleparameters_parameter_index(extensibleparameters, name)
    if !found do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_remove_by_index :: proc(extensibleparameters: ExtensibleParameters, index: i32) -> (ok: bool) {
    if extensibleparameters == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExtensibleParametersIF)(extensibleparameters)->Remove(index)
    if com_failed(hr) do return

    return true
}

extensibleparameters_release :: proc(extensibleparameters: ExtensibleParameters) {
    if extensibleparameters != nil {
        (^ExtensibleParametersIF)(extensibleparameters)->Release()
    }
}
