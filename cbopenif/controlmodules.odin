package cbopenif

ControlModules :: distinct rawptr

ControlModulesIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ControlModulesVTable,
}

ControlModulesVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    Serialize:                   proc "system" (this: ^ControlModulesIF, XML: ^BStr) -> HResult,
    Add:                         proc "system" (this: ^ControlModulesIF, IControlModule: rawptr) -> HResult,
    AddBefore:                   proc "system" (this: ^ControlModulesIF, IControlModule: rawptr, Index: i32) -> HResult,
    AddControlModule:            proc "system" (this: ^ControlModulesIF, Name, TypeName: BStr, ControlModule: ^rawptr) -> HResult,
    AddControlModule1:           proc "system" (this: ^ControlModulesIF, Name, TypeName, TaskConnection: BStr, VisibilityInGraphics: i32, Guid, Description: BStr, ControlModules: ^rawptr) -> HResult,
    AddSingleControlModuleInst:  proc "system" (this: ^ControlModulesIF, Name: BStr, SingleControlModuleInst: ^rawptr) -> HResult,
    AddSingleControlModuleInst1: proc "system" (this: ^ControlModulesIF, Name, TaskConnection: BStr, VisibilityInGraphics: i32, TypeGuid, InstGuid: BStr, GraphPos: ^GraphPos, SingleControlModuleInst: ^rawptr) -> HResult,
    Find:                        proc "system" (this: ^ControlModulesIF, Name: BStr, IControlModule: ^rawptr) -> HResult,
    FindNr:                      proc "system" (this: ^ControlModulesIF, Name: BStr, Index: ^i32) -> HResult,
    Item:                        proc "system" (this: ^ControlModulesIF, Index: i32, IControlModule: ^rawptr) -> HResult,
    Count:                       proc "system" (this: ^ControlModulesIF, Count: ^i32) -> HResult,
    Remove:                      proc "system" (this: ^ControlModulesIF, Index: i32) -> HResult,
}

controlmodules_new :: proc() -> (controlmodules: ControlModules, ok: bool) {
    if !controlbuilder_connect() do return

    hr := factoryif->NewControlModules(cast(^rawptr)&controlmodules)
    if com_failed(hr) do return

    return controlmodules, true
}

controlmodules_serialize :: proc(controlmodules: ControlModules) -> (xml: string, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return

    bs: BStr
    defer bstr_free(bs)
    hr := (^ControlModuleIF)(controlmodules)->Serialize(&bs)
    if com_failed(hr) do return

    return from_bstr(bs), true
}

controlmodules_deserialize :: proc(xml: string) -> (controlmodules: ControlModules, ok: bool) {
    if !controlbuilder_connected() do return
    
    bs := to_bstr(xml)
    defer bstr_free(bs)
    hr := factoryif->DeserializeControlModules(&bs, cast(^rawptr)controlmodules)
    if com_failed(hr) do return
    
    return controlmodules, true
}

controlmodules_controlmodule_add :: proc {
    controlmodules_icontrolmodule_add,
    controlmodules_icontrolmodule_add_at_index,
    controlmodules_controlmodule_add_,
    controlmodules_singlecontrolmodule_add,
}

controlmodules_icontrolmodule_add :: proc(controlmodules: ControlModules, icontrolmodule: IControlModule) -> (ok: bool) {
    if controlmodules == nil do return
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return

    hr := (^ExternalVariablesIF)(controlmodules)->Add(icontrolmodule)
    if com_failed(hr) do return

    return true
}

controlmodules_icontrolmodule_add_at_index :: proc(controlmodules: ControlModules, icontrolmodule: IControlModule, index: i32) -> (ok: bool) {
    if controlmodules == nil do return
    if icontrolmodule == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ExternalVariablesIF)(controlmodules)->AddBefore(icontrolmodule, index)
    if com_failed(hr) do return

    return true
}

controlmodules_controlmodule_add_ :: proc(controlmodules: ControlModules, name, type_name: string, controlmodule: ControlModule) -> (ok: bool) {
    if controlmodules == nil do return
    if controlmodule == nil do return
    if !controlbuilder_connected() do return

    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := (^ControlModulesIF)(controlmodules)->AddControlModule(bstr_name, bstr_type_name, cast(^rawptr)controlmodule)
    if com_failed(hr) do return

    return true
}

controlmodules_singlecontrolmodule_add :: proc(controlmodules: ControlModules, name: string, singlecontrolmoduleinst: SingleControlModuleInst) -> (ok: bool) {
    if controlmodules == nil do return
    if singlecontrolmoduleinst == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->AddSingleControlModuleInst(bstr_name, cast(^rawptr)singlecontrolmoduleinst)
    if com_failed(hr) do return

    return true
}

controlmodules_controlmodule :: proc {
    controlmodules_controlmodule_by_name,
    controlmodules_controlmodule_by_index,
}

controlmodules_controlmodule_by_name :: proc(controlmodules: ControlModules, name: string) -> (icontrolmodule: IControlModule, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->Find(bstr_name, cast(^rawptr)&icontrolmodule)
    if com_failed(hr) do return
    
    return icontrolmodule, true
}

controlmodules_controlmodule_by_index :: proc(controlmodules: ControlModules, index: i32) -> (icontrolmodule: IControlModule, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Item(index + 1, cast(^rawptr)&icontrolmodule)
    if com_failed(hr) do return
    
    return icontrolmodule, true
}

controlmodules_controlmodule_index :: proc(controlmodules: ControlModules, name: string) -> (index: i32, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := (^ControlModulesIF)(controlmodules)->FindNr(bstr_name, &index)
    if com_failed(hr) do return
    
    return index - 1, true
}

controlmodules_controlmodule_count :: proc(controlmodules: ControlModules) -> (count: i32, ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Count(&count)
    if com_failed(hr) do return
    
    return count, true
}

controlmodules_controlmodule_remove :: proc {
    controlmodules_controlmodule_remove_by_name,
    controlmodules_controlmodule_remove_by_index,
}

controlmodules_controlmodule_remove_by_name :: proc(controlmodules: ControlModules, name: string) -> (ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return

    index: i32
    index, ok = controlmodules_controlmodule_index(controlmodules, name)
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index)
    if com_failed(hr) do return
    
    return true
}

controlmodules_controlmodule_remove_by_index :: proc(controlmodules: ControlModules, index: i32) -> (ok: bool) {
    if controlmodules == nil do return
    if !controlbuilder_connected() do return
    
    hr := (^ControlModulesIF)(controlmodules)->Remove(index + 1)
    if com_failed(hr) do return
    
    return true
}

controlmodules_release :: proc(controlmodules: ControlModules) {
    if controlmodules != nil {
        (^ControlModulesIF)(controlmodules)->Release()
    }
}
