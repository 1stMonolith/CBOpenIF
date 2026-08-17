package com

import cb ".."

objectfactory: ^ObjectFactoryIF

ObjectFactoryIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ObjectFactoryVTable,
}

ObjectFactoryVTable :: struct {
    using iunknownvtable: IUnknownVTable,
    DeserializeExternalVariable:        proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ExternalVariable: ^rawptr) -> HResult,
    DeserializeGlobalVariable:          proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, GlobalVariable: ^rawptr) -> HResult,
    DeserializeVariable:                proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Variable: ^rawptr) -> HResult,
    DeserializeCMParameter:             proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, CMParameter: ^rawptr) -> HResult,
    DeserializeExtensibleParameter:     proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, extensibleparameter: ^rawptr) -> HResult,
    DeserializeParameter:               proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Parameter: ^rawptr) -> HResult,
    DeserializeCodeBlock:               proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ICodeBlock: ^rawptr) -> HResult,
    DeserializeCMConnection:            proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, CMConnection: ^rawptr) -> HResult,
    DeserializeDataType:                proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Datatype: ^rawptr) -> HResult,
    NewDataType:                        proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, DataType: ^rawptr) -> HResult,
    NewDataType1:                       proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: i32, DataType: ^rawptr) -> HResult,
    DeserializeApplicationVariables:    proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ApplicationVariables: ^rawptr) -> HResult,
    NewApplicationVariables:            proc "system" (this: ^ObjectFactoryIF, Description: BStr, ApplicationVariables: ^rawptr) -> HResult,
    DeserializeFunctionBlockType:       proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, FunctionBlockType: ^rawptr) -> HResult,
    NewFunctionBlockType:               proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, FunctionBlockType: ^rawptr) -> HResult,
    NewFunctionBlockType1:              proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: i32, InteractionWindow: BStr, AlarmOwner: VariantBool, Guid: BStr, FunctionBlockType: ^rawptr) -> HResult,
    DeserializeFunctionBlock:           proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, functionblock: ^rawptr) -> HResult,
    NewFunctionBlock:                   proc "system" (this: ^ObjectFactoryIF, Name, Type: BStr, functionblock: ^rawptr) -> HResult,
    NewFunctionBlock1:                  proc "system" (this: ^ObjectFactoryIF, Name, Type, Task, Guid, Description: BStr, FunctionBlock: ^rawptr) -> HResult,
    DeserializeControlModuleType:       proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ControlModuleType: ^rawptr) -> HResult,
    NewControlModuleType:               proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, ControlModuleType: ^rawptr) -> HResult,
    NewControlModuleType1:              proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: i32, InteractionWindow: BStr, AlarmOwner: VariantBool, Guid: BStr, GraphSize: rawptr, ControlModuleType: ^rawptr) -> HResult,
    DeserializeProgram:                 proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Program: ^rawptr) -> HResult,
    NewProgram:                         proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, Program: ^rawptr) -> HResult,
    NewProgram1:                        proc "system" (this: ^ObjectFactoryIF, Name, Description, TaskCOnnection, Guid, InstGuid: BStr, Program: ^rawptr) -> HResult,
    DeserializeControlModule:           proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ControlModule: ^rawptr) -> HResult,
    NewControlModule:                   proc "system" (this: ^ObjectFactoryIF, Name, Type: BStr, ControlModule: ^rawptr) -> HResult,
    NewControlModule1:                  proc "system" (this: ^ObjectFactoryIF, Name, Type, Task: BStr, VisibilityInGraphics: i32, Guid, Description: BStr, GraphPos: rawptr, ControlModule: ^rawptr) -> HResult,
    DeserializeControlModules:          proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ControlModules: ^rawptr) -> HResult,
    NewControlModules:                  proc "system" (this: ^ObjectFactoryIF, ControlModules: ^rawptr) -> HResult,
    NewSingleControlModuleType:         proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, SingleControlModuleType: ^rawptr) -> HResult,
    NewSingleControlModuleType1:        proc "system" (this: ^ObjectFactoryIF, Name, Description, InteractionWindow: BStr, AlarmOwner: VariantBool, Guid: BStr, GraphSize: rawptr, SingleControlModuleType: ^rawptr) -> HResult,
    DeserializeSingleControlModuleType: proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, SingleControlModuleType: ^rawptr) -> HResult,
    DeserializeSingleControlModuleInst: proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, SingleControlModuleInst: ^rawptr) -> HResult,
    NewSingleControlModuleInst:         proc "system" (this: ^ObjectFactoryIF, Name: BStr, SingleControlModuleInst: ^rawptr) -> HResult,
    NewSingleControlModuleInst1:        proc "system" (this: ^ObjectFactoryIF, Name, Task: BStr, VisibilityInGraphics: i32, Guid, InstGuide: BStr, GraphPos: rawptr, SingleControlModuleInst: ^rawptr) -> HResult,
    DeserializeTask:                    proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Task: ^rawptr) -> HResult,
    NewTask:                            proc "system" (this: ^ObjectFactoryIF, Name: BStr, IntervalTime: i32, TaskPriority: i32, Task: ^rawptr) -> HResult,
    NewTask1:                           proc "system" (this: ^ObjectFactoryIF, Name: BStr, IntervalTime: i32, TaskPriority: i32, Offset: i32, OutputUpdate: i32, Task: ^rawptr) -> HResult,
    DeserializeConnectedApplications:   proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ConnectedApplications: ^rawptr) -> HResult,
    NewConnectedApplication:            proc "system" (this: ^ObjectFactoryIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    NewConnectedApplication1:           proc "system" (this: ^ObjectFactoryIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedApplication: ^rawptr) -> HResult,
    NewConnectedApplications:           proc "system" (this: ^ObjectFactoryIF, ConnectedApplication: ^rawptr) -> HResult,
    DeserializeConnectedLibraries:      proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ConnectedLibraries: ^rawptr) -> HResult,
    NewConnectedLibrary:                proc "system" (this: ^ObjectFactoryIF, Name: BStr, ConnectedLibrary: ^rawptr) -> HResult,
    NewConnectedLibrary1:               proc "system" (this: ^ObjectFactoryIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedLibrary: ^rawptr) -> HResult,
    NewConnectedLibraries:              proc "system" (this: ^ObjectFactoryIF, ConnectedLibraries: ^rawptr) -> HResult,
    DeserializeHWUnit:                  proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, HWUnit: ^rawptr) -> HResult,
    NewHWUnit:                          proc "system" (this: ^ObjectFactoryIF, Path: BStr, HWUnit: ^rawptr) -> HResult,
    NewHWUnit1:                         proc "system" (this: ^ObjectFactoryIF, Path, TypeID, TypeDescription, Guid: BStr, HWUnit: ^rawptr) -> HResult,
    NewHWChannel:                       proc "system" (this: ^ObjectFactoryIF, Address, Name, ConVariable, IODescription: BStr, HWChannel: ^rawptr) -> HResult,
    NewHWChannel1:                      proc "system" (this: ^ObjectFactoryIF, Address, Name, ConVariable, IODescription, Min, Max, Unit, Fraction: BStr, Reversed: VariantBool, HWChannel: ^rawptr) -> HResult,
    NewParameterSetting:                proc "system" (this: ^ObjectFactoryIF, Name, ParameterValue: BStr, ParameterSetting: ^rawptr) -> HResult,
    NewVariable:                        proc "system" (this: ^ObjectFactoryIF, Name, TypeName: BStr, variable: ^rawptr) -> HResult,
    NewVariable1:                       proc "system" (this: ^ObjectFactoryIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, variable: ^rawptr) -> HResult,
    NewGlobalVariable:                  proc "system" (this: ^ObjectFactoryIF, Name, TypeName: BStr, GlobalVariable: ^rawptr) -> HResult,
    NewGlobalVariable1:                 proc "system" (this: ^ObjectFactoryIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, GlobalVariable: ^rawptr) -> HResult,
    NewExternalVariable:                proc "system" (this: ^ObjectFactoryIF, Name, Type: BStr, ExternalVariable: ^rawptr) -> HResult,
    NewExternalVariable1:               proc "system" (this: ^ObjectFactoryIF, Name, Type, Attribute, ReadPermission, WritePermission, Description: BStr, ExternalVariable: ^rawptr) -> HResult,
    NewParameter:                       proc "system" (this: ^ObjectFactoryIF, Name, TypeName: BStr, Parameter: ^rawptr) -> HResult,
    NewParameter1:                      proc "system" (this: ^ObjectFactoryIF, Name, TypeName, Attribute: BStr, Direction: i32, InitialValue, ReadPermission, WritePermission, Description: BStr, Parameter: ^rawptr) -> HResult,
    NewCMParameter:                     proc "system" (this: ^ObjectFactoryIF, Name, TypeName: BStr, CMParameter: ^rawptr) -> HResult,
    NewCMParameter1:                    proc "system" (this: ^ObjectFactoryIF, Name, TypeName, InitialValue, ReadPermission, WritePermission, Description: BStr, AutoPoint: rawptr, CMParameter: ^rawptr) -> HResult,
    NewExtensibleParameter:             proc "system" (this: ^ObjectFactoryIF, Name, Type: BStr, extensibleparameter: ^rawptr) -> HResult,
    NewExtensibleParameter1:            proc "system" (this: ^ObjectFactoryIF, Name, Type, Attribute: BStr, Direction: i32, InitialValue, Description: BStr, extensibleparameter: ^rawptr) -> HResult,
    NewComponent:                       proc "system" (this: ^ObjectFactoryIF, Name, TypeName: BStr, Component: ^rawptr) -> HResult,
    NewComponent1:                      proc "system" (this: ^ObjectFactoryIF, Name, TypeName, Attribute, InitialValue, Description: BStr, Component: ^rawptr) -> HResult,
    NewCMConnection:                    proc "system" (this: ^ObjectFactoryIF, Name, ActualParameter: BStr, CMConnection: ^rawptr) -> HResult,
    NewCMConnection1:                   proc "system" (this: ^ObjectFactoryIF, Name, ActualParameter: BStr, GraphicalConnection: VariantBool, CMConnection: ^rawptr) -> HResult,
    NewAutoPoint:                       proc "system" (this: ^ObjectFactoryIF, AutoPos: i32, AutoPoint: ^rawptr) -> HResult,
    NewPoint:                           proc "system" (this: ^ObjectFactoryIF, X, Y: f64, Point: ^rawptr) -> HResult,
    NewGraphPos:                        proc "system" (this: ^ObjectFactoryIF, XPos, YPos, Rotation, XScale, YScale: f64, GraphPos: ^rawptr) -> HResult,
    NewGraphSize:                       proc "system" (this: ^ObjectFactoryIF, LowerLeft, UpperRight: rawptr, GraphSize: ^rawptr) -> HResult,
    NewGraphNode:                       proc "system" (this: ^ObjectFactoryIF, Name: BStr, X, Y: f64, GraphNode: ^rawptr) -> HResult,
    NewSTCodeBlock:                     proc "system" (this: ^ObjectFactoryIF, Name: BStr, STCodeBlock: ^rawptr) -> HResult,
    NewSTCodeBlock1:                    proc "system" (this: ^ObjectFactoryIF, Name: BStr, STCode: ^BStr, STCodeBlock: ^rawptr) -> HResult,
    NewLDCodeBlock:                     proc "system" (this: ^ObjectFactoryIF, Name: BStr, LDCodeBlock: ^rawptr) -> HResult,
    NewLDCodeBlock1:                    proc "system" (this: ^ObjectFactoryIF, Name: BStr, STCode: ^BStr, LDCodeBlock: ^rawptr) -> HResult,
    NewFBDCodeBlock:                    proc "system" (this: ^ObjectFactoryIF, Name: BStr, FBDCodeBlock: ^rawptr) -> HResult,
    NewFBDCodeBlock1:                   proc "system" (this: ^ObjectFactoryIF, Name: BStr, STCode: ^BStr, FBDCodeBlock: ^rawptr) -> HResult,
    NewSFCCodeBlock:                    proc "system" (this: ^ObjectFactoryIF, Name: BStr, SFCCodeBlock: ^rawptr) -> HResult,
    NewSFCCodeBlock1:                   proc "system" (this: ^ObjectFactoryIF, Name: BStr, SeqControl, StepElapsedTime: VariantBool, SFCCodeBlock: ^rawptr) -> HResult,
    NewSFCStep:                         proc "system" (this: ^ObjectFactoryIF, Name: BStr, SFCStep: ^rawptr) -> HResult,
    NewSFCStep1:                        proc "system" (this: ^ObjectFactoryIF, Name: BStr, InitialStep: VariantBool, P1_Action_STCode, N_Action_STCode, P0_Action_STCode: BStr, SFCStep: ^rawptr) -> HResult,
    NewSFCTransition:                   proc "system" (this: ^ObjectFactoryIF, Name: BStr, SFCTransition: ^rawptr) -> HResult,
    NewSFCTransition1:                  proc "system" (this: ^ObjectFactoryIF, Name, STCode, Dest: BStr, SFCTransition: ^rawptr) -> HResult,
    NewSFCSelection:                    proc "system" (this: ^ObjectFactoryIF, NrOfBranches: i32, SFCSelection: ^rawptr) -> HResult,
    NewSFCSimultaneous:                 proc "system" (this: ^ObjectFactoryIF, NrOfBranches: i32, SFCSimultaneous: ^rawptr) -> HResult,
    NewSFCSubSequence:                  proc "system" (this: ^ObjectFactoryIF, Name: BStr, SFCSubSequence: ^rawptr) -> HResult,
    NewILCodeBlock:                     proc "system" (this: ^ObjectFactoryIF, Name: BStr, ILCodeBlock: ^rawptr) -> HResult,
    NewILRow:                           proc "system" (this: ^ObjectFactoryIF, Label, Instruction, Operand, Description: BStr, ILRow: ^rawptr) -> HResult,
    NewILComment:                       proc "system" (this: ^ObjectFactoryIF, Comment: BStr, ILRow: ^rawptr) -> HResult,
    NewVANamedProtocol:                 proc "system" (this: ^ObjectFactoryIF, Name: BStr, VANamedProtocol: ^rawptr) -> HResult,
    NewVAAddressedProtocol:             proc "system" (this: ^ObjectFactoryIF, Name: BStr, VAAddressedProtocol: ^rawptr) -> HResult,
    NewVANamedVariable:                 proc "system" (this: ^ObjectFactoryIF, Name, Path: BStr, VANamedVariable: ^rawptr) -> HResult,
    NewVANamedVariable1:                proc "system" (this: ^ObjectFactoryIF, Name, Path, VAAttribute: BStr, row: i32, VANamedVariable: ^rawptr) -> HResult,
    NewVAAddressedVariable:             proc "system" (this: ^ObjectFactoryIF, Name, Path: BStr, VAAddressedVariable: ^rawptr) -> HResult,
    NewVAAddressedVariable1:            proc "system" (this: ^ObjectFactoryIF, Name, Path: BStr, row: i32, VAAddressedVariable: ^rawptr) -> HResult,
    NewAccessVariables:                 proc "system" (this: ^ObjectFactoryIF, AccessVariables: ^rawptr) -> HResult,
    DeserializeAccessVariables:         proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, AccessVariables: ^rawptr) -> HResult,
    NewProjectConstants:                proc "system" (this: ^ObjectFactoryIF, ProjectConstants: ^rawptr) -> HResult,
    DeserializeProjectConstants:        proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ProjectConstants: ^rawptr) -> HResult,
    NewProjectConstant:                 proc "system" (this: ^ObjectFactoryIF, Name, Type, Value: BStr, ProjectConstants: ^rawptr) -> HResult,
    DeserializeMessageBucket:           proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, MessageBucket: ^rawptr) -> HResult,
    DeserializeApplicationProperties:   proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ApplicationProperties: ^rawptr) -> HResult,
    NewApplicationProperties:           proc "system" (this: ^ObjectFactoryIF, SILLevel: BStr, SimulationMark: VariantBool, ApplicationProperties: ^rawptr) -> HResult,
    DeserializeConnectedHWLibraries:    proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ConnectedHWLibraries: ^rawptr) -> HResult,
    NewConnectedHWLibrary:              proc "system" (this: ^ObjectFactoryIF, Name: BStr, ConnectedHWLibrary: ^rawptr) -> HResult,
    NewConnectedHWLibrary1:             proc "system" (this: ^ObjectFactoryIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedHWLibrary: ^rawptr) -> HResult,
    NewConnectedHWLibraries:            proc "system" (this: ^ObjectFactoryIF, ConnectedHWLibraries: ^rawptr) -> HResult,
    NewHWUnit2:                         proc "system" (this: ^ObjectFactoryIF, Path, TypeID, TypeDescription, Guid, type_guid: BStr, HWUnit: ^rawptr) -> HResult,
    DeserializeCommVariable:            proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, CommVariable: ^rawptr) -> HResult,
    NewCommVariable:                    proc "system" (this: ^ObjectFactoryIF, Name, Type, Direction: BStr, CommVariable: ^rawptr) -> HResult,
    NewCommVariable1:                   proc "system" (this: ^ObjectFactoryIF, Name, Type, Direction, Attribute, InitialValue, ISPValue, Priority, IntervalTime, ReadPermission, Description: BStr, CommVariable: ^rawptr) -> HResult,
    NewInitValue:                       proc "system" (this: ^ObjectFactoryIF, POUPath, Name, Value: BStr, InitValue: ^rawptr) -> HResult,
    DeserializeDiagram:                 proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Diagram: ^rawptr) -> HResult,
    NewDiagram:                         proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, Diagram: ^rawptr) -> HResult,
    NewDiagram1:                        proc "system" (this: ^ObjectFactoryIF, Name, Description, Task, Guid, InstGuid: BStr, Diagram: ^rawptr) -> HResult,
    DeserializeExecutionOrder:          proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, ExecutionOrder: ^rawptr) -> HResult,
    NewExecutionOrder:                  proc "system" (this: ^ObjectFactoryIF, ExecutionOrder: ^rawptr) -> HResult,
    NewExecutionInstance:               proc "system" (this: ^ObjectFactoryIF, Name: BStr, ExecutionInstance: ^rawptr) -> HResult,
    DeserializeDiagramType:             proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, DiagramType: ^rawptr) -> HResult,
    NewDiagramType:                     proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, DiagramType: ^rawptr) -> HResult,
    NewDiagramType1:                    proc "system" (this: ^ObjectFactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: i32, AlarmOwner: VariantBool, Guid: BStr, DiagramType: ^rawptr) -> HResult,
    DeserializeDiagramInstance:         proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, DiagramInstance: ^rawptr) -> HResult,
    NewDiagramInstance:                 proc "system" (this: ^ObjectFactoryIF, Name, Type: BStr, _DiagramInstance: ^rawptr) -> HResult,
    NewDiagramInstance1:                proc "system" (this: ^ObjectFactoryIF, Name, Type, Guid, Description: BStr, DiagramInstance: ^rawptr) -> HResult,
    DeserializeSignal:                  proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, Signal: ^rawptr) -> HResult,
    NewSignal:                          proc "system" (this: ^ObjectFactoryIF, Name, Path, Direction: BStr, AcknowledgeGroup: Variant, Signal: ^rawptr) -> HResult,
}

factory_connect :: proc() -> (ok: bool) {
    ok = false

    if objectfactory != nil do return

    ok = com_initialize()
    if !ok do return

    clsid := GUID{
        0x3CEFCA96,
        0x1892,
        0x4539,
        {0x87, 0x47, 0x29, 0x2B, 0xB8, 0xAE, 0x1D, 0x4B},
    }

    iid := GUID{
        0x9198E466,
        0x81F5,
        0x4756,
        {0xB3, 0x9A, 0x12, 0xC7, 0x7F, 0xF5, 0xFF, 0x1A},
    }

    ok = com_create_instance(&clsid, &iid, cast(^rawptr)&objectfactory)
    if !ok {
        com_uninitialize()
        objectfactory = nil
        return
    }

    return true
}

factory_disconnect :: proc()  -> (ok: bool) {
    if objectfactory != nil {
        objectfactory->Release()
        objectfactory = nil
    }
    com_uninitialize()

    return true
}

externalvariable_deserialize :: proc(xml: string) -> (externalvariable: ExternalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeExternalVariable(&bstr_xml, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

globalvariable_deserialize :: proc(xml: string) -> (globalvariable: GlobalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeGlobalVariable(&bstr_xml, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

variable_deserialize :: proc(xml: string) -> (variable: Variable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeVariable(&bstr_xml, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

cmparameter_deserialize :: proc(xml: string) -> (cmparameter: CMParameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeCMParameter(&bstr_xml, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

extensibleparameter_deserialize :: proc(xml: string) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeExtensibleParameter(&bstr_xml, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return
    
    return extensibleparameter, true
}

parameter_deserialize :: proc(xml: string) -> (parameter: Parameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeParameter(&bstr_xml, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

codeblock_deserialize :: proc(xml: string) -> (codeblock: CodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeCodeBlock(&bstr_xml, cast(^rawptr)&codeblock)
    if com_failed(hr) do return
    
    return codeblock, true
}

cmconnection_deserialize :: proc(xml: string) -> (cmconnection: CMConnection, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeCMConnection(&bstr_xml, cast(^rawptr)&cmconnection)
    if com_failed(hr) do return
    
    return cmconnection, true
}

datatype_deserialize :: proc(xml: string) -> (datatype: DataType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeDataType(&bstr_xml, cast(^rawptr)&datatype)
    if com_failed(hr) do return
    
    return datatype, true
}

applicationvariables_deserialize :: proc(xml: string) -> (applicationvariables: ApplicationVariables, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeApplicationVariables(&bstr_xml, cast(^rawptr)&applicationvariables)
    if com_failed(hr) do return
    
    return applicationvariables, true
}

functionblocktype_deserialize :: proc(xml: string) -> (functionblocktype: FunctionBlockType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeFunctionBlockType(&bstr_xml, cast(^rawptr)&functionblocktype)
    if com_failed(hr) do return
    
    return functionblocktype, true
}

bunctionblock_deserialize :: proc(xml: string) -> (bunctionblock: FunctionBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeFunctionBlock(&bstr_xml, cast(^rawptr)&bunctionblock)
    if com_failed(hr) do return
    
    return bunctionblock, true
}

controlmoduletype_deserialize :: proc(xml: string) -> (controlmoduletype: ControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeControlModuleType(&bstr_xml, cast(^rawptr)&controlmoduletype)
    if com_failed(hr) do return
    
    return controlmoduletype, true
}

program_deserialize :: proc(xml: string) -> (program: Program, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeProgram(&bstr_xml, cast(^rawptr)&program)
    if com_failed(hr) do return
    
    return program, true
}

controlmodule_deserialize :: proc(xml: string) -> (controlmodule: ControlModule, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeControlModule(&bstr_xml, cast(^rawptr)&controlmodule)
    if com_failed(hr) do return
    
    return controlmodule, true
}

controlmodules_deserialize :: proc(xml: string) -> (controlmodules: ControlModules, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeControlModules(&bstr_xml, cast(^rawptr)&controlmodules)
    if com_failed(hr) do return
    
    return controlmodules, true
}

singlecontrolmoduletype_deserialize :: proc(xml: string) -> (singlecontrolmoduletype: SingleControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeSingleControlModuleType(&bstr_xml, cast(^rawptr)&singlecontrolmoduletype)
    if com_failed(hr) do return
    
    return singlecontrolmoduletype, true
}

singlecontrolmoduleinst_deserialize :: proc(xml: string) -> (singlecontrolmoduleinst: SingleControlModuleInst, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeSingleControlModuleInst(&bstr_xml, cast(^rawptr)&singlecontrolmoduleinst)
    if com_failed(hr) do return
    
    return singlecontrolmoduleinst, true
}

task_deserialize :: proc(xml: string) -> (task: Task, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeTask(&bstr_xml, cast(^rawptr)&task)
    if com_failed(hr) do return
    
    return task, true
}

connectedapplications_deserialize :: proc(xml: string) -> (connectedapplications: ConnectedApplications, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeConnectedApplications(&bstr_xml, cast(^rawptr)&connectedapplications)
    if com_failed(hr) do return
    
    return connectedapplications, true
}

connectedlibraries_deserialize :: proc(xml: string) -> (connectedlibraries: ConnectedLibraries, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeConnectedLibraries(&bstr_xml, cast(^rawptr)&connectedlibraries)
    if com_failed(hr) do return
    
    return connectedlibraries, true
}

hwunit_deserialize :: proc(xml: string) -> (hwunit: HWUnit, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeHWUnit(&bstr_xml, cast(^rawptr)&hwunit)
    if com_failed(hr) do return
    
    return hwunit, true
}

accessvariables_deserialize :: proc(xml: string) -> (accessvariables: AccessVariables, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeAccessVariables(&bstr_xml, cast(^rawptr)&accessvariables)
    if com_failed(hr) do return
    
    return accessvariables, true
}

projectsconstants_deserialize :: proc(xml: string) -> (projectsconstants: ProjectConstants, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeProjectConstants(&bstr_xml, cast(^rawptr)&projectsconstants)
    if com_failed(hr) do return
    
    return projectsconstants, true
}

messagebucket_deserialize :: proc(xml: string) -> (messagebucket: MessageBucket, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeMessageBucket(&bstr_xml, cast(^rawptr)&messagebucket)
    if com_failed(hr) do return
    
    return messagebucket, true
}

applicationproperties_deserialize :: proc(xml: string) -> (applicationproperties: ApplicationProperties, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeApplicationProperties(&bstr_xml, cast(^rawptr)&applicationproperties)
    if com_failed(hr) do return
    
    return applicationproperties, true
}

connectedhwlibraries_deserialize :: proc(xml: string) -> (connectedhwlibraries: ConnectedHWLibraries, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeConnectedHWLibraries(&bstr_xml, cast(^rawptr)&connectedhwlibraries)
    if com_failed(hr) do return
    
    return connectedhwlibraries, true
}

commvariable_deserialize :: proc(xml: string) -> (commvariable: CommVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeCommVariable(&bstr_xml, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

diagram_deserialize :: proc(xml: string) -> (diagram: Diagram, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeDiagram(&bstr_xml, cast(^rawptr)&diagram)
    if com_failed(hr) do return
    
    return diagram, true
}

executionorder_deserialize :: proc(xml: string) -> (executionorder: ExecutionOrder, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeExecutionOrder(&bstr_xml, cast(^rawptr)&executionorder)
    if com_failed(hr) do return
    
    return executionorder, true
}

diagramtype_deserialize :: proc(xml: string) -> (diagramtype: DiagramType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeDiagramType(&bstr_xml, cast(^rawptr)&diagramtype)
    if com_failed(hr) do return
    
    return diagramtype, true
}

diagraminstance_deserialize :: proc(xml: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeDiagramInstance(&bstr_xml, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return
    
    return diagraminstance, true
}

signal_deserialize :: proc(xml: string) -> (signal: Signal, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_xml := to_bstr(xml)
    defer bstr_free(bstr_xml)
    hr := objectfactory->DeserializeSignal(&bstr_xml, cast(^rawptr)&signal)
    if com_failed(hr) do return
    
    return signal, true
}

datatype_new :: proc(name, description: string) -> (datatype: DataType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewDataType(bstr_name, bstr_description, cast(^rawptr)&datatype)
    if com_failed(hr) do return
    
    return datatype, true
}

datatype_new1 :: proc(name, description: string, protected, hidden: bool, scope: cb.Scope) -> (datatype: DataType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewDataType1(bstr_name, bstr_description, to_variantbool(protected), to_variantbool(hidden), i32(scope), cast(^rawptr)&datatype)
    if com_failed(hr) do return
    
    return datatype, true
}

applicationvariables_new :: proc(description: string) -> (applicationvariables: ApplicationVariables, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_description := to_bstr(description)
    defer bstr_free(bstr_description)
    hr := objectfactory->NewApplicationVariables(bstr_description, cast(^rawptr)&applicationvariables)
    if com_failed(hr) do return
    
    return applicationvariables, true
}

functionblocktype_new :: proc(name, description: string) -> (functionblocktype: FunctionBlockType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewFunctionBlockType(bstr_name, bstr_description, cast(^rawptr)&functionblocktype)
    if com_failed(hr) do return
    
    return functionblocktype, true
}

functionblocktype_new1 :: proc(name, description: string, protected, hidden: bool, scope: cb.Scope, interaction_window: string, alarm_owner: bool, guid: string) -> (functionblocktype: FunctionBlockType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    bstr_iw          := to_bstr(interaction_window)
    bstr_guid        := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
        bstr_free(bstr_iw)
        bstr_free(bstr_guid)
    }
    hr := objectfactory->NewFunctionBlockType1(bstr_name, bstr_description, to_variantbool(protected), to_variantbool(hidden), i32(scope), bstr_iw, to_variantbool(alarm_owner), bstr_guid, cast(^rawptr)&functionblocktype)
    if com_failed(hr) do return
    
    return functionblocktype, true
}

functionblock_new :: proc(name, type_name: string) -> (functionblock: FunctionBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewFunctionBlock(bstr_name, bstr_type_name, cast(^rawptr)&functionblock)
    if com_failed(hr) do return
    
    return functionblock, true
}

functionblock_new1 :: proc(name, type_name, task, guid, description: string) -> (functionblock: FunctionBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_type_name   := to_bstr(type_name)
    bstr_task        := to_bstr(task)
    bstr_guid        := to_bstr(guid)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_task)
        bstr_free(bstr_guid)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewFunctionBlock1(bstr_name, bstr_type_name, bstr_task, bstr_guid, bstr_description, cast(^rawptr)&functionblock)
    if com_failed(hr) do return
    
    return functionblock, true
}

controlmoduletype_new :: proc(name, description: string) -> (controlmoduletype: ControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewControlModuleType(bstr_name, bstr_description, cast(^rawptr)&controlmoduletype)
    if com_failed(hr) do return
    
    return controlmoduletype, true
}

controlmoduletype_new1 :: proc(name, description: string, protected, hidden: bool, scope: cb.Scope, interaction_window: string, alarm_owner: bool, guid: string, graph_size: GraphSize) -> (controlmoduletype: ControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    bstr_iw          := to_bstr(interaction_window)
    bstr_guid        := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
        bstr_free(bstr_iw)
        bstr_free(bstr_guid)
    }
    hr := objectfactory->NewControlModuleType1(bstr_name, bstr_description, to_variantbool(protected), to_variantbool(hidden), i32(scope), bstr_iw, to_variantbool(alarm_owner), bstr_guid, graph_size, cast(^rawptr)&controlmoduletype)
    if com_failed(hr) do return
    
    return controlmoduletype, true
}

program_new :: proc(name, description: string) -> (program: Program, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewProgram(bstr_name, bstr_description, cast(^rawptr)&program)
    if com_failed(hr) do return
    
    return program, true
}

program_new1 :: proc(name, description, task_connection, type_guid, inst_guid: string) -> (program: Program, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    bstr_task        := to_bstr(task_connection)
    bstr_tg          := to_bstr(type_guid)
    bstr_ig          := to_bstr(inst_guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
        bstr_free(bstr_task)
        bstr_free(bstr_tg)
        bstr_free(bstr_ig)
    }
    hr := objectfactory->NewProgram1(bstr_name, bstr_description, bstr_task, bstr_tg, bstr_ig, cast(^rawptr)&program)
    if com_failed(hr) do return
    
    return program, true
}

controlmodule_new :: proc(name, type_name: string) -> (controlmodule: ControlModule, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewControlModule(bstr_name, bstr_type_name, cast(^rawptr)&controlmodule)
    if com_failed(hr) do return
    
    return controlmodule, true
}

controlmodule_new1 :: proc(name, type_name, task: string, visibility: i32, guid, description: string, graph_pos: GraphPos) -> (controlmodule: ControlModule, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_type_name   := to_bstr(type_name)
    bstr_task        := to_bstr(task)
    bstr_guid        := to_bstr(guid)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_task)
        bstr_free(bstr_guid)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewControlModule1(bstr_name, bstr_type_name, bstr_task, visibility, bstr_guid, bstr_description, graph_pos, cast(^rawptr)&controlmodule)
    if com_failed(hr) do return
    
    return controlmodule, true
}

controlmodules_new :: proc() -> (controlmodules: ControlModules, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewControlModules(cast(^rawptr)&controlmodules)
    if com_failed(hr) do return
    
    return controlmodules, true
}

singlecontrolmoduletype_new :: proc(name, description: string) -> (singlecontrolmoduletype: SingleControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewSingleControlModuleType(bstr_name, bstr_description, cast(^rawptr)&singlecontrolmoduletype)
    if com_failed(hr) do return
    
    return singlecontrolmoduletype, true
}

singlecontrolmoduletype_new1 :: proc(name, description, interaction_window: string, alarm_owner: bool, type_guid: string, graph_size: GraphSize) -> (singlecontrolmoduletype: SingleControlModuleType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    bstr_iw          := to_bstr(interaction_window)
    bstr_guid        := to_bstr(type_guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
        bstr_free(bstr_iw)
        bstr_free(bstr_guid)
    }
    hr := objectfactory->NewSingleControlModuleType1(bstr_name, bstr_description, bstr_iw, to_variantbool(alarm_owner), bstr_guid, graph_size, cast(^rawptr)&singlecontrolmoduletype)
    if com_failed(hr) do return
    
    return singlecontrolmoduletype, true
}

singlecontrolmoduleinst_new :: proc(name: string) -> (singlecontrolmoduleinst: SingleControlModuleInst, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSingleControlModuleInst(bstr_name, cast(^rawptr)&singlecontrolmoduleinst)
    if com_failed(hr) do return
    
    return singlecontrolmoduleinst, true
}

singlecontrolmoduleinst_new1 :: proc(name, task: string, visibility: i32, type_guid, inst_guid: string, graph_pos: GraphPos) -> (singlecontrolmoduleinst: SingleControlModuleInst, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_task := to_bstr(task)
    bstr_tg   := to_bstr(type_guid)
    bstr_ig   := to_bstr(inst_guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_task)
        bstr_free(bstr_tg)
        bstr_free(bstr_ig)
    }
    hr := objectfactory->NewSingleControlModuleInst1(bstr_name, bstr_task, visibility, bstr_tg, bstr_ig, graph_pos, cast(^rawptr)&singlecontrolmoduleinst)
    if com_failed(hr) do return
    
    return singlecontrolmoduleinst, true
}

task_new :: proc(name: string, interval_time: i32, priority: cb.TaskPriority) -> (task: Task, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewTask(bstr_name, interval_time, i32(priority), cast(^rawptr)&task)
    if com_failed(hr) do return
    
    return task, true
}

task_new1 :: proc(name: string, interval_time: i32, priority: cb.TaskPriority, offset: i32, output_update: cb.TaskOutputUpdate) -> (task: Task, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewTask1(bstr_name, interval_time, i32(priority), offset, i32(output_update), cast(^rawptr)&task)
    if com_failed(hr) do return
    
    return task, true
}

connectedapplication_new :: proc(name: string) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewConnectedApplication(bstr_name, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return
    
    return connectedapplication, true
}

connectedapplication_new1 :: proc(name: string, major, minor, revision: i32) -> (connectedapplication: ConnectedApplication, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewConnectedApplication1(bstr_name, major, minor, revision, cast(^rawptr)&connectedapplication)
    if com_failed(hr) do return
    
    return connectedapplication, true
}

connectedapplications_new :: proc() -> (connectedapplications: ConnectedApplications, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewConnectedApplications(cast(^rawptr)&connectedapplications)
    if com_failed(hr) do return
    
    return connectedapplications, true
}

connectedlibrary_new :: proc(name: string) -> (connectedlibrary: ConnectedLibrary, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewConnectedLibrary(bstr_name, cast(^rawptr)&connectedlibrary)
    if com_failed(hr) do return
    
    return connectedlibrary, true
}

connectedlibrary_new1 :: proc(name: string, major, minor, revision: i32) -> (connectedlibrary: ConnectedLibrary, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewConnectedLibrary1(bstr_name, major, minor, revision, cast(^rawptr)&connectedlibrary)
    if com_failed(hr) do return
    
    return connectedlibrary, true
}

connectedlibraries_new :: proc() -> (connectedlibraries: ConnectedLibraries, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewConnectedLibraries(cast(^rawptr)&connectedlibraries)
    if com_failed(hr) do return
    
    return connectedlibraries, true
}

hwunit_new :: proc(path: string) -> (hwunit: HWUnit, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := objectfactory->NewHWUnit(bstr_path, cast(^rawptr)&hwunit)
    if com_failed(hr) do return
    
    return hwunit, true
}

hwunit_new1 :: proc(path, type_id, type_description, guid: string) -> (hwunit: HWUnit, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_path := to_bstr(path)
    bstr_tid  := to_bstr(type_id)
    bstr_td   := to_bstr(type_description)
    bstr_guid := to_bstr(guid)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_tid)
        bstr_free(bstr_td)
        bstr_free(bstr_guid)
    }
    hr := objectfactory->NewHWUnit1(bstr_path, bstr_tid, bstr_td, bstr_guid, cast(^rawptr)&hwunit)
    if com_failed(hr) do return
    
    return hwunit, true
}

hwunit_new2 :: proc(path, type_id, type_description, guid, type_guid: string) -> (hwunit: HWUnit, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_path := to_bstr(path)
    bstr_tid  := to_bstr(type_id)
    bstr_td   := to_bstr(type_description)
    bstr_guid := to_bstr(guid)
    bstr_tg   := to_bstr(type_guid)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_tid)
        bstr_free(bstr_td)
        bstr_free(bstr_guid)
        bstr_free(bstr_tg)
    }
    hr := objectfactory->NewHWUnit2(bstr_path, bstr_tid, bstr_td, bstr_guid, bstr_tg, cast(^rawptr)&hwunit)
    if com_failed(hr) do return
    
    return hwunit, true
}

hwchannel_new :: proc(address, name, con_variable, io_description: string) -> (hwchannel: HWChannel, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_addr           := to_bstr(address)
    bstr_name           := to_bstr(name)
    bstr_con_variable   := to_bstr(con_variable)
    bstr_io_description := to_bstr(io_description)
    defer {
        bstr_free(bstr_addr)
        bstr_free(bstr_name)
        bstr_free(bstr_con_variable)
        bstr_free(bstr_io_description)
    }
    hr := objectfactory->NewHWChannel(bstr_addr, bstr_name, bstr_con_variable, bstr_io_description, cast(^rawptr)&hwchannel)
    if com_failed(hr) do return
    
    return hwchannel, true
}

hwchannel_new1 :: proc(address, name, con_variable, io_description: string, min, max, unit, fraction: string, reversed: bool) -> (hwchannel: HWChannel, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_addr           := to_bstr(address)
    bstr_name           := to_bstr(name)
    bstr_con_variable   := to_bstr(con_variable)
    bstr_io_description := to_bstr(io_description)
    bstr_min            := to_bstr(min)
    bstr_max            := to_bstr(max)
    bstr_unit           := to_bstr(unit)
    bstr_fraction       := to_bstr(fraction)
    defer {
        bstr_free(bstr_addr)
        bstr_free(bstr_name)
        bstr_free(bstr_con_variable)
        bstr_free(bstr_io_description)
        bstr_free(bstr_min)
        bstr_free(bstr_max)
        bstr_free(bstr_unit)
        bstr_free(bstr_fraction)
    }
    hr := objectfactory->NewHWChannel1(bstr_addr, bstr_name, bstr_con_variable, bstr_io_description, bstr_min, bstr_max, bstr_unit, bstr_fraction, to_variantbool(reversed), cast(^rawptr)&hwchannel)
    if com_failed(hr) do return
    
    return hwchannel, true
}

parametersetting_new :: proc(name, parameter_value: string) -> (parametersetting: ParameterSetting, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name            := to_bstr(name)
    bstr_parameter_value := to_bstr(parameter_value)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parameter_value)
    }
    hr := objectfactory->NewParameterSetting(bstr_name, bstr_parameter_value, cast(^rawptr)&parametersetting)
    if com_failed(hr) do return
    
    return parametersetting, true
}

variable_new :: proc(name, type_name: string) -> (variable: Variable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewVariable(bstr_name, bstr_type_name, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

variable_new1 :: proc(name, type_name, attribute, initial_value, read_permission, write_permission, description: string) -> (variable: Variable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_type_name        := to_bstr(type_name)
    bstr_attribute        := to_bstr(attribute)
    bstr_initial_value    := to_bstr(initial_value)
    bstr_read_permission  := to_bstr(read_permission)
    bstr_write_permission := to_bstr(write_permission)
    bstr_description      := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_read_permission)
        bstr_free(bstr_write_permission)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewVariable1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&variable)
    if com_failed(hr) do return
    
    return variable, true
}

globalvariable_new :: proc(name, type_name: string) -> (globalvariable: GlobalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewGlobalVariable(bstr_name, bstr_type_name, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

globalvariable_new1 :: proc(name, type_name, attribute, initial_value, read_permission, write_permission, description: string) -> (globalvariable: GlobalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_type_name        := to_bstr(type_name)
    bstr_attribute        := to_bstr(attribute)
    bstr_initial_value    := to_bstr(initial_value)
    bstr_read_permission  := to_bstr(read_permission)
    bstr_write_permission := to_bstr(write_permission)
    bstr_description      := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_read_permission)
        bstr_free(bstr_write_permission)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewGlobalVariable1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&globalvariable)
    if com_failed(hr) do return
    
    return globalvariable, true
}

externalvariable_new :: proc(name, type_name: string) -> (externalvariable: ExternalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewExternalVariable(bstr_name, bstr_type_name, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

externalvariable_new1 :: proc(name, type_name, attribute, read_permission, write_permission, description: string) -> (externalvariable: ExternalVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_type_name        := to_bstr(type_name)
    bstr_attribute        := to_bstr(attribute)
    bstr_read_permission  := to_bstr(read_permission)
    bstr_write_permission := to_bstr(write_permission)
    bstr_description      := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_read_permission)
        bstr_free(bstr_write_permission)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewExternalVariable1(bstr_name, bstr_type_name, bstr_attribute, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&externalvariable)
    if com_failed(hr) do return
    
    return externalvariable, true
}

parameter_new :: proc(name, type_name: string) -> (parameter: Parameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewParameter(bstr_name, bstr_type_name, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

parameter_new1 :: proc(name, type_name, attribute: string, direction: i32, initial_value, read_permission, write_permission, description: string) -> (parameter: Parameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_type_name        := to_bstr(type_name)
    bstr_attribute        := to_bstr(attribute)
    bstr_initial_value    := to_bstr(initial_value)
    bstr_read_permission  := to_bstr(read_permission)
    bstr_write_permission := to_bstr(write_permission)
    bstr_description      := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_read_permission)
        bstr_free(bstr_write_permission)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewParameter1(bstr_name, bstr_type_name, bstr_attribute, direction, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&parameter)
    if com_failed(hr) do return
    
    return parameter, true
}

cmparameter_new :: proc(name, type_name: string) -> (cmparameter: CMParameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewCMParameter(bstr_name, bstr_type_name, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

cmparameter_new1 :: proc(name, type_name, initial_value, read_permission, write_permission, description: string, auto_point: AutoPoint) -> (cmparameter: CMParameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_type_name        := to_bstr(type_name)
    bstr_initial_value    := to_bstr(initial_value)
    bstr_read_permission  := to_bstr(read_permission)
    bstr_write_permission := to_bstr(write_permission)
    bstr_description      := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_read_permission)
        bstr_free(bstr_write_permission)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewCMParameter1(bstr_name, bstr_type_name, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, auto_point, cast(^rawptr)&cmparameter)
    if com_failed(hr) do return
    
    return cmparameter, true
}

extensibleparameter_new :: proc(name, type_name: string) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewExtensibleParameter(bstr_name, bstr_type_name, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return
    
    return extensibleparameter, true
}

extensibleparameter_new1 :: proc(name, type_name, attribute: string, direction: i32, initial_value, description: string) -> (extensibleparameter: ExtensibleParameter, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name          := to_bstr(name)
    bstr_type_name     := to_bstr(type_name)
    bstr_attribute     := to_bstr(attribute)
    bstr_initial_value := to_bstr(initial_value)
    bstr_description   := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewExtensibleParameter1(bstr_name, bstr_type_name, bstr_attribute, direction, bstr_initial_value, bstr_description, cast(^rawptr)&extensibleparameter)
    if com_failed(hr) do return
    
    return extensibleparameter, true
}

component_new :: proc(name, type_name: string) -> (component: Component, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewComponent(bstr_name, bstr_type_name, cast(^rawptr)&component)
    if com_failed(hr) do return
    
    return component, true
}

component_new1 :: proc(name, type_name: string, attribute := "", initial_value := "", description: string) -> (component: Component, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name          := to_bstr(name)
    bstr_type_name     := to_bstr(type_name)
    bstr_attribute     := to_bstr(attribute)
    bstr_initial_value := to_bstr(initial_value)
    bstr_description   := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewComponent1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_description, cast(^rawptr)&component)
    if com_failed(hr) do return
    
    return component, true
}

cmconnection_new :: proc(name, actual_parameter: string) -> (cmconnection: CMConnection, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_actual_parameter := to_bstr(actual_parameter)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_actual_parameter)
    }
    hr := objectfactory->NewCMConnection(bstr_name, bstr_actual_parameter, cast(^rawptr)&cmconnection)
    if com_failed(hr) do return
    
    return cmconnection, true
}

cmconnection_new1 :: proc(name, actual_parameter: string, graphical_connection: bool) -> (cmconnection: CMConnection, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name             := to_bstr(name)
    bstr_actual_parameter := to_bstr(actual_parameter)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_actual_parameter)
    }
    hr := objectfactory->NewCMConnection1(
        bstr_name, bstr_actual_parameter, to_variantbool(graphical_connection), cast(^rawptr)&cmconnection,
    )
    if com_failed(hr) do return
    
    return cmconnection, true
}

autopoint_new :: proc(auto_pos: i32) -> (autopoint: AutoPoint, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewAutoPoint(auto_pos, cast(^rawptr)&autopoint)
    if com_failed(hr) do return
    
    return autopoint, true
}

point_new :: proc(x, y: f64) -> (point: Point, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewPoint(x, y, cast(^rawptr)&point)
    if com_failed(hr) do return
    
    return point, true
}

graphpos_new :: proc(x_pos, y_pos, rotation, x_scale, y_scale: f64) -> (graphpos: GraphPos, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewGraphPos(x_pos, y_pos, rotation, x_scale, y_scale, cast(^rawptr)&graphpos)
    if com_failed(hr) do return
    
    return graphpos, true
}

graphsize_new :: proc(lower_left, upper_right: Point) -> (graphsize: GraphSize, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewGraphSize(lower_left, upper_right, cast(^rawptr)&graphsize)
    if com_failed(hr) do return
    
    return graphsize, true
}

graphnode_new :: proc(name: string, x, y: f64) -> (graphnode: GraphNode, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewGraphNode(bstr_name, x, y, cast(^rawptr)&graphnode)
    if com_failed(hr) do return
    
    return graphnode, true
}

stcodeblock_new :: proc(name: string) -> (stcodeblock: STCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSTCodeBlock(bstr_name, cast(^rawptr)&stcodeblock)
    if com_failed(hr) do return
    
    return stcodeblock, true
}

stcodeblock_new1 :: proc(name: string, st_code: string) -> (stcodeblock: STCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name    := to_bstr(name)
    bstr_st_code := to_bstr(st_code)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_st_code)
    }
    hr := objectfactory->NewSTCodeBlock1(bstr_name, &bstr_st_code, cast(^rawptr)&stcodeblock)
    if com_failed(hr) do return
    
    return stcodeblock, true
}

ldcodeblock_new_ld :: proc(name: string) -> (ldcodeblock: LDCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewLDCodeBlock(bstr_name, cast(^rawptr)&ldcodeblock)
    if com_failed(hr) do return
    
    return ldcodeblock, true
}

ldcodeblock_new1 :: proc(name: string, st_code: string) -> (ldcodeblock: LDCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name    := to_bstr(name)
    bstr_st_code := to_bstr(st_code)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_st_code)
    }
    hr := objectfactory->NewLDCodeBlock1(bstr_name, &bstr_st_code, cast(^rawptr)&ldcodeblock)
    if com_failed(hr) do return
    
    return ldcodeblock, true
}

fbdcodeblock_new :: proc(name: string) -> (fbdcodeblock: FBDCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewFBDCodeBlock(bstr_name, cast(^rawptr)&fbdcodeblock)
    if com_failed(hr) do return
    
    return fbdcodeblock, true
}

fbdcodeblock_new1 :: proc(name: string, st_code: string) -> (fbdcodeblock: FBDCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name    := to_bstr(name)
    bstr_st_code := to_bstr(st_code)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_st_code)
    }
    hr := objectfactory->NewFBDCodeBlock1(bstr_name, &bstr_st_code, cast(^rawptr)&fbdcodeblock)
    if com_failed(hr) do return
    
    return fbdcodeblock, true
}

sfccodeblock_new :: proc(name: string) -> (sfccodeblock: SFCCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSFCCodeBlock(bstr_name, cast(^rawptr)&sfccodeblock)
    if com_failed(hr) do return
    
    return sfccodeblock, true
}

sfccodeblock_new1 :: proc(name: string, seq_control, step_elapsed_time: bool) -> (sfccodeblock: SFCCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSFCCodeBlock1(bstr_name, to_variantbool(seq_control), to_variantbool(step_elapsed_time), cast(^rawptr)&sfccodeblock)
    if com_failed(hr) do return
    
    return sfccodeblock, true
}

sfcstep_new :: proc(name: string) -> (sfcstep: SFCStep, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSFCStep(bstr_name, cast(^rawptr)&sfcstep)
    if com_failed(hr) do return
    
    return sfcstep, true
}

sfcstep_new1 :: proc(name: string, initial_step: bool, p1_action, n_action, p0_action: string) -> (sfcstep: SFCStep, ok: bool) {
    if !controlbuilder_connected() do return
   
    bstr_name := to_bstr(name)
    bstr_p1   := to_bstr(p1_action)
    bstr_n    := to_bstr(n_action)
    bstr_p0   := to_bstr(p0_action)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_p1)
        bstr_free(bstr_n)
        bstr_free(bstr_p0)
    }
    hr := objectfactory->NewSFCStep1(bstr_name, to_variantbool(initial_step), bstr_p1, bstr_n, bstr_p0, cast(^rawptr)&sfcstep)
    if com_failed(hr) do return
    
    return sfcstep, true
}

sfctransition_new :: proc(name: string) -> (sfctransition: SFCTransition, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSFCTransition(bstr_name, cast(^rawptr)&sfctransition)
    if com_failed(hr) do return
    
    return sfctransition, true
}

sfctransition_new1 :: proc(name, st_code, dest: string) -> (sfctransition: SFCTransition, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name    := to_bstr(name)
    bstr_st_code := to_bstr(st_code)
    bstr_dest    := to_bstr(dest)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_st_code)
        bstr_free(bstr_dest)
    }
    hr := objectfactory->NewSFCTransition1(bstr_name, bstr_st_code, bstr_dest, cast(^rawptr)&sfctransition)
    if com_failed(hr) do return
    
    return sfctransition, true
}

sfcselection_new :: proc(nr_of_branches: i32) -> (sfcselection: SFCSelection, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewSFCSelection(nr_of_branches, cast(^rawptr)&sfcselection)
    if com_failed(hr) do return
    
    return sfcselection, true
}

sfcsimultaneous_new :: proc(nr_of_branches: i32) -> (sfcsimultaneous: SFCSimultaneous, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewSFCSimultaneous(nr_of_branches, cast(^rawptr)&sfcsimultaneous)
    if com_failed(hr) do return
    
    return sfcsimultaneous, true
}

sfcsubsequence_new :: proc(name: string) -> (sfcsubsequence: SFCSubSequence, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewSFCSubSequence(bstr_name, cast(^rawptr)&sfcsubsequence)
    if com_failed(hr) do return
    
    return sfcsubsequence, true
}

ilcodeblock_new :: proc(name: string) -> (ilcodeblock: ILCodeBlock, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewILCodeBlock(bstr_name, cast(^rawptr)&ilcodeblock)
    if com_failed(hr) do return
    
    return ilcodeblock, true
}

ilrow_new :: proc(label, instruction, operand, description: string) -> (ilrow: ILRow, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_label        := to_bstr(label)
    bstr_instr        := to_bstr(instruction)
    bstr_op           := to_bstr(operand)
    bstr_description  := to_bstr(description)
    defer {
        bstr_free(bstr_label)
        bstr_free(bstr_instr)
        bstr_free(bstr_op)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewILRow(bstr_label, bstr_instr, bstr_op, bstr_description, cast(^rawptr)&ilrow)
    if com_failed(hr) do return
    
    return ilrow, true
}

ilrow_new1 :: proc(comment: string) -> (ilrow: ILRow, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_comment := to_bstr(comment)
    defer bstr_free(bstr_comment)
    hr := objectfactory->NewILComment(bstr_comment, cast(^rawptr)&ilrow)
    if com_failed(hr) do return
    
    return ilrow, true
}

vanamedprotocol_new :: proc(name: string) -> (vanamedprotocol: VANamedProtocol, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewVANamedProtocol(bstr_name, cast(^rawptr)&vanamedprotocol)
    if com_failed(hr) do return
    
    return vanamedprotocol, true
}

vaaddressedprotocol_new :: proc(name: string) -> (vaaddressedprotocol: VAAddressedProtocol, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewVAAddressedProtocol(bstr_name, cast(^rawptr)&vaaddressedprotocol)
    if com_failed(hr) do return
    
    return vaaddressedprotocol, true
}

vanamedvariable_new :: proc(name, path: string) -> (vanamedvariable: VANamedVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_path := to_bstr(path)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
    }
    hr := objectfactory->NewVANamedVariable(bstr_name, bstr_path, cast(^rawptr)&vanamedvariable)
    if com_failed(hr) do return
    
    return vanamedvariable, true
}

vanamedvariable_new1 :: proc(name, path, va_attribute: string, row: i32) -> (vanamedvariable: VANamedVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_path      := to_bstr(path)
    bstr_attribute := to_bstr(va_attribute)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
        bstr_free(bstr_attribute)
    }
    hr := objectfactory->NewVANamedVariable1(bstr_name, bstr_path, bstr_attribute, row, cast(^rawptr)&vanamedvariable)
    if com_failed(hr) do return
    
    return vanamedvariable, true
}

vaaddressedvariable_new :: proc(name, path: string) -> (vaaddressedvariable: VAAddressedVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_path := to_bstr(path)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
    }
    hr := objectfactory->NewVAAddressedVariable(bstr_name, bstr_path, cast(^rawptr)&vaaddressedvariable)
    if com_failed(hr) do return
    
    return vaaddressedvariable, true
}

vaaddressedvariable_new1 :: proc(name, path: string, row: i32) -> (vaaddressedvariable: VAAddressedVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_path := to_bstr(path)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_path)
    }
    hr := objectfactory->NewVAAddressedVariable1(bstr_name, bstr_path, row, cast(^rawptr)&vaaddressedvariable)
    if com_failed(hr) do return
    
    return vaaddressedvariable, true
}

accessvariables_new :: proc() -> (accessvariables: AccessVariables, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewAccessVariables(cast(^rawptr)&accessvariables)
    if com_failed(hr) do return
    
    return accessvariables, true
}

projectconstants_new :: proc() -> (projectconstants: ProjectConstants, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewProjectConstants(cast(^rawptr)&projectconstants)
    if com_failed(hr) do return
    
    return projectconstants, true
}

projectconstant_new :: proc(name, pc_type, value: string) -> (projectconstant: ProjectConstant, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(pc_type)
    bstr_val       := to_bstr(value)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_val)
    }
    hr := objectfactory->NewProjectConstant(bstr_name, bstr_type_name, bstr_val, cast(^rawptr)&projectconstant)
    if com_failed(hr) do return
    
    return projectconstant, true
}

applicationproperties_new :: proc(sil_level: string, simulation_mark: bool) -> (applicationproperties: ApplicationProperties, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_sil := to_bstr(sil_level)
    defer bstr_free(bstr_sil)
    hr := objectfactory->NewApplicationProperties(bstr_sil, to_variantbool(simulation_mark), cast(^rawptr)&applicationproperties)
    if com_failed(hr) do return
    
    return applicationproperties, true
}

connectedhwlibrary_new :: proc(name: string) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewConnectedHWLibrary(bstr_name, cast(^rawptr)&connectedhwlibrary)
    if com_failed(hr) do return
    
    return connectedhwlibrary, true
}

connectedhwlibrary_new1 :: proc(name: string, major, minor, revision: i32) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewConnectedHWLibrary1(bstr_name, major, minor, revision, cast(^rawptr)&connectedhwlibrary)
    if com_failed(hr) do return
    
    return connectedhwlibrary, true
}

connectedhwlibaries_new :: proc() -> (connectedhwlibaries: ConnectedHWLibraries, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewConnectedHWLibraries(cast(^rawptr)&connectedhwlibaries)
    if com_failed(hr) do return
    
    return connectedhwlibaries, true
}

commvariable_new :: proc(name, type_name, direction: string) -> (commvariable: CommVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    bstr_dir       := to_bstr(direction)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_dir)
    }
    hr := objectfactory->NewCommVariable(bstr_name, bstr_type_name, bstr_dir, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

commvariable_new1 :: proc(name, type_name, direction, attribute, initial_value, isp_value, priority, interval_time, read_permission, description: string) -> (commvariable: CommVariable, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name            := to_bstr(name)
    bstr_type_name       := to_bstr(type_name)
    bstr_dir             := to_bstr(direction)
    bstr_attribute       := to_bstr(attribute)
    bstr_initial_value   := to_bstr(initial_value)
    bstr_isp             := to_bstr(isp_value)
    bstr_prio            := to_bstr(priority)
    bstr_int             := to_bstr(interval_time)
    bstr_read_permission := to_bstr(read_permission)
    bstr_description     := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_dir)
        bstr_free(bstr_attribute)
        bstr_free(bstr_initial_value)
        bstr_free(bstr_isp)
        bstr_free(bstr_prio)
        bstr_free(bstr_int)
        bstr_free(bstr_read_permission)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewCommVariable1(bstr_name, bstr_type_name, bstr_dir, bstr_attribute, bstr_initial_value, bstr_isp, bstr_prio, bstr_int, bstr_read_permission, bstr_description, cast(^rawptr)&commvariable)
    if com_failed(hr) do return
    
    return commvariable, true
}

initvalue_new :: proc(pou_path, name, value: string) -> (initvalue: InitValue, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_path := to_bstr(pou_path)
    bstr_name := to_bstr(name)
    bstr_val  := to_bstr(value)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
        bstr_free(bstr_val)
    }
    hr := objectfactory->NewInitValue(bstr_path, bstr_name, bstr_val, cast(^rawptr)&initvalue)
    if com_failed(hr) do return
    
    return initvalue, true
}

diagram_new :: proc(name, description: string) -> (diagram: Diagram, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewDiagram(bstr_name, bstr_description, cast(^rawptr)&diagram)
    if com_failed(hr) do return
    
    return diagram, true
}

diagram_new1 :: proc(name, description, task, type_guid, inst_guid: string) -> (diagram: Diagram, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    bstr_description := to_bstr(description)
    bstr_task := to_bstr(task)
    bstr_tg   := to_bstr(type_guid)
    bstr_ig   := to_bstr(inst_guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
        bstr_free(bstr_task)
        bstr_free(bstr_tg)
        bstr_free(bstr_ig)
    }
    hr := objectfactory->NewDiagram1(bstr_name, bstr_description, bstr_task, bstr_tg, bstr_ig, cast(^rawptr)&diagram)
    if com_failed(hr) do return
    
    return diagram, true
}

executionorder_new :: proc() -> (executionorder: ExecutionOrder, ok: bool) {
    if !controlbuilder_connected() do return
    
    hr := objectfactory->NewExecutionOrder(cast(^rawptr)&executionorder)
    if com_failed(hr) do return
    
    return executionorder, true
}

executioninstance_new :: proc(name: string) -> (executioninstance: ExecutionInstance, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := objectfactory->NewExecutionInstance(bstr_name, cast(^rawptr)&executioninstance)
    if com_failed(hr) do return
    
    return executioninstance, true
}

diagramtype_new :: proc(name, description: string) -> (diagramtype: DiagramType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewDiagramType(bstr_name, bstr_description, cast(^rawptr)&diagramtype)
    if com_failed(hr) do return
    
    return diagramtype, true
}

diagramtype_new1 :: proc(name, description: string, protected, hidden: bool, scope: cb.Scope, alarm_owner: bool, guid: string) -> (diagramtype: DiagramType, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_description := to_bstr(description)
    bstr_guid        := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_description)
        bstr_free(bstr_guid)
    }
    hr := objectfactory->NewDiagramType1(bstr_name, bstr_description, to_variantbool(protected), to_variantbool(hidden), i32(scope), to_variantbool(alarm_owner), bstr_guid, cast(^rawptr)&diagramtype)
    if com_failed(hr) do return
    
    return diagramtype, true
}

diagraminstance_new :: proc(name, type_name: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name      := to_bstr(name)
    bstr_type_name := to_bstr(type_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
    }
    hr := objectfactory->NewDiagramInstance(bstr_name, bstr_type_name, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return
    
    return diagraminstance, true
}

diagraminstance_new1 :: proc(name, type_name, guid, description: string) -> (diagraminstance: DiagramInstance, ok: bool) {
    if !controlbuilder_connected() do return
    
    bstr_name        := to_bstr(name)
    bstr_type_name   := to_bstr(type_name)
    bstr_guid        := to_bstr(guid)
    bstr_description := to_bstr(description)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type_name)
        bstr_free(bstr_guid)
        bstr_free(bstr_description)
    }
    hr := objectfactory->NewDiagramInstance1(bstr_name, bstr_type_name, bstr_guid, bstr_description, cast(^rawptr)&diagraminstance)
    if com_failed(hr) do return
    
    return diagraminstance, true
}

signal_new :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: Signal, ok: bool) {
    if !controlbuilder_connected() do return

    v_name := to_variant(name)
    v_path := to_variant(path)
    v_dir  := to_variant(direction)
    v_ag   := to_variant(acknowledge_group)
    defer {
        variant_free(&v_name)
        variant_free(&v_path)
        variant_free(&v_dir)
        variant_free(&v_ag)
    }

    // ars in NewSignal order (Name, Path, Direction, AcknowledgeGroup)
    args := []Variant{ v_name, v_path, v_dir, v_ag }

    result: Variant
    this := cast(^IUnknownIF)objectfactory

    hr, arg_err, ok2 := com_invoke_name(this, "NewSignal", args,  &result)
    defer variant_free(&result)
    //fmt.printf("NewSignal Invoke hr=0x%X argErr=%d\n", u32(hr), arg_err)
    if com_failed(hr) do return

    // Retval is usually VT_DISPATCH or VT_UNKNOWN
    sig: rawptr
    switch result.vt {
        case VariantTypeDispatch:
            sig = result.pdispVal
            result.pdispVal = nil
            result.vt = VariantTypeEmpty
        // I think we only every use Dispatch so this case is probably not needed
        case VariantTypeUnknown:
            sig = result.punkVal
            result.punkVal = nil
            result.vt = VariantTypeEmpty
        case:
            return
    }

    if sig == nil do return

    return Signal(sig), true
}
