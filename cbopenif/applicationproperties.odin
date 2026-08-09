package cbopenif

ApplicationProperties :: distinct rawptr

ApplicationPropertiesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ApplicationPropertiesVTable,
}

ApplicationPropertiesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    SILLevelGet:       proc "system" (this: ^ApplicationPropertiesIF, SILLevel: ^BStr) -> HResult,
    SILLevelPut:       proc "system" (this: ^ApplicationPropertiesIF, SILLevel: BStr) -> HResult,
    SimulationMarkGet: proc "system" (this: ^ApplicationPropertiesIF, SimulationMark: ^VariantBool) -> HResult,
    SimulationMarkPut: proc "system" (this: ^ApplicationPropertiesIF, SimulationMark: VariantBool) -> HResult,
    Serialize:         proc "system" (this: ^ApplicationPropertiesIF, XML: ^BStr) -> HResult,
    ApplicationTypeGet: proc "system" (this: ^ApplicationPropertiesIF, ApplicationType: ^BStr) -> HResult,
}

applicationproperties_new :: proc(sil_level: string, simulation_mark: bool) -> (applicationproperties: ApplicationProperties, ok: bool) {
    if !controlbuilder_connected() do return

    bstr_sil_level := to_bstr(sil_level)
    defer bstr_free(bstr_sil_level)
    hr := factoryif->NewApplicationProperties(bstr_sil_level, to_variantbool(simulation_mark), cast(^rawptr)&applicationproperties)
    if com_failed(hr) do return

    return applicationproperties, true
}

applicationproperties_deserialize :: proc(xml: string) -> (applicationproperties: ApplicationProperties, ok: bool) {
    if !controlbuilder_connected() do return

    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeApplicationProperties(&bs, cast(^rawptr)&applicationproperties)
    if com_failed(hr) do return

    return applicationproperties, true
}

applicationproperties_serialize :: proc(applicationproperties: ApplicationProperties) -> (xml: string, ok: bool) {
    if applicationproperties == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationproperties_sil_level :: proc {
    applicationproperties_sil_level_get,
    applicationproperties_sil_level_set,
}

applicationproperties_sil_level_get :: proc(applicationproperties: ApplicationProperties) -> (sil_level: string, ok: bool) {
    if applicationproperties == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SILLevelGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationproperties_sil_level_set :: proc(applicationproperties: ApplicationProperties, sil_level: string) -> (ok: bool) {
    if applicationproperties == nil do return
    if !controlbuilder_connected() do return

    bs := to_bstr(sil_level)
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SILLevelPut(bs)
    if com_failed(hr) do return

    return true
}

applicationproperties_simulation_mark :: proc {
    applicationproperties_simulation_mark_get,
    applicationproperties_simulation_mark_set,
}

applicationproperties_simulation_mark_get :: proc(applicationproperties: ApplicationProperties) -> (simulation_mark: bool, ok: bool) {
    if applicationproperties == nil do return
    if !controlbuilder_connected() do return

    vb: VariantBool
    hr := (^ApplicationPropertiesIF)(applicationproperties)->SimulationMarkGet(&vb)
    if com_failed(hr) do return

    return from_variantbool(vb), true
}

applicationproperties_simulation_mark_set :: proc(applicationproperties: ApplicationProperties, simulation_mark: bool) -> (ok: bool) {
    if applicationproperties == nil do return
    if !controlbuilder_connected() do return

    hr := (^ApplicationPropertiesIF)(applicationproperties)->SimulationMarkPut(to_variantbool(simulation_mark))
    if com_failed(hr) do return

    return true
}

applicationproperties_application_type_get :: proc(applicationproperties: ApplicationProperties) -> (application_type: string, ok: bool) {
    if applicationproperties == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ApplicationPropertiesIF)(applicationproperties)->ApplicationTypeGet(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

applicationproperties_release :: proc(applicationproperties: ApplicationProperties) {
    if applicationproperties != nil {
        (^ApplicationPropertiesIF)(applicationproperties)->Release()
    }
}
