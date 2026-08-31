package com

objectfactory: ^ObjectFactoryIF

ObjectFactoryIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^ObjectFactoryVTable,
}

ObjectFactoryVTable :: struct
{
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
    DeserializeSingleControlModule:     proc "system" (this: ^ObjectFactoryIF, XMLStr: ^BStr, SingleControlModule: ^rawptr) -> HResult,
    NewSingleControlModule:             proc "system" (this: ^ObjectFactoryIF, Name: BStr, SingleControlModule: ^rawptr) -> HResult,
    NewSingleControlModule1:            proc "system" (this: ^ObjectFactoryIF, Name, Task: BStr, VisibilityInGraphics: i32, Guid, InstGuide: BStr, GraphPos: rawptr, SingleControlModule: ^rawptr) -> HResult,
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

DeserializeExternalVariable :: proc(xml: string) -> (externalvariable: ExternalVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeExternalVariable(&bstr_xml, cast(^rawptr)&externalvariable)
    if ComFailed(hr) do return
    
    return externalvariable, true
}

DeserializeGlobalVariable :: proc(xml: string) -> (globalvariable: GlobalVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeGlobalVariable(&bstr_xml, cast(^rawptr)&globalvariable)
    if ComFailed(hr) do return
    
    return globalvariable, true
}

DeserializeVariable :: proc(xml: string) -> (variable: Variable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeVariable(&bstr_xml, cast(^rawptr)&variable)
    if ComFailed(hr) do return
    
    return variable, true
}

DeserializeCMParameter :: proc(xml: string) -> (cmparameter: CMParameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeCMParameter(&bstr_xml, cast(^rawptr)&cmparameter)
    if ComFailed(hr) do return
    
    return cmparameter, true
}

DeserializeExtensibleParameter :: proc(xml: string) -> (extensibleparameter: ExtensibleParameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeExtensibleParameter(&bstr_xml, cast(^rawptr)&extensibleparameter)
    if ComFailed(hr) do return
    
    return extensibleparameter, true
}

DeserializeParameter :: proc(xml: string) -> (parameter: Parameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeParameter(&bstr_xml, cast(^rawptr)&parameter)
    if ComFailed(hr) do return
    
    return parameter, true
}

DeserializeCodeBlock :: proc(xml: string) -> (codeblock: CodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeCodeBlock(&bstr_xml, cast(^rawptr)&codeblock)
    if ComFailed(hr) do return
    
    return codeblock, true
}

DeserializeCMConnection :: proc(xml: string) -> (cmconnection: CMConnection, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeCMConnection(&bstr_xml, cast(^rawptr)&cmconnection)
    if ComFailed(hr) do return
    
    return cmconnection, true
}

DeserializeDataType :: proc(xml: string) -> (datatype: DataType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeDataType(&bstr_xml, cast(^rawptr)&datatype)
    if ComFailed(hr) do return
    
    return datatype, true
}

DeserializeApplicationVariables :: proc(xml: string) -> (applicationvariables: ApplicationVariables, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeApplicationVariables(&bstr_xml, cast(^rawptr)&applicationvariables)
    if ComFailed(hr) do return
    
    return applicationvariables, true
}

DeserializeFunctionBlockType :: proc(xml: string) -> (functionblocktype: FunctionBlockType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeFunctionBlockType(&bstr_xml, cast(^rawptr)&functionblocktype)
    if ComFailed(hr) do return
    
    return functionblocktype, true
}

DeserializeFunctionBlock :: proc(xml: string) -> (bunctionblock: FunctionBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeFunctionBlock(&bstr_xml, cast(^rawptr)&bunctionblock)
    if ComFailed(hr) do return
    
    return bunctionblock, true
}

DeserializeControlModuleType :: proc(xml: string) -> (controlmoduletype: ControlModuleType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeControlModuleType(&bstr_xml, cast(^rawptr)&controlmoduletype)
    if ComFailed(hr) do return
    
    return controlmoduletype, true
}

DeserializeProgram :: proc(xml: string) -> (program: Program, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeProgram(&bstr_xml, cast(^rawptr)&program)
    if ComFailed(hr) do return
    
    return program, true
}

DeserializeControlModule :: proc(xml: string) -> (controlmodule: ControlModule, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeControlModule(&bstr_xml, cast(^rawptr)&controlmodule)
    if ComFailed(hr) do return
    
    return controlmodule, true
}

DeserializeControlModules :: proc(xml: string) -> (controlmodules: ControlModules, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeControlModules(&bstr_xml, cast(^rawptr)&controlmodules)
    if ComFailed(hr) do return
    
    return controlmodules, true
}

DeserializeSingleControlModule :: proc(xml: string) -> (singlecontrolmodule: SingleControlModule, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeSingleControlModule(&bstr_xml, cast(^rawptr)&singlecontrolmodule)
    if ComFailed(hr) do return
    
    return singlecontrolmodule, true
}

DeserializeTask :: proc(xml: string) -> (task: Task, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeTask(&bstr_xml, cast(^rawptr)&task)
    if ComFailed(hr) do return
    
    return task, true
}

DeserializeConnectedApplications :: proc(xml: string) -> (connectedapplications: ConnectedApplications, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeConnectedApplications(&bstr_xml, cast(^rawptr)&connectedapplications)
    if ComFailed(hr) do return
    
    return connectedapplications, true
}

DeserializeConnectedLibraries :: proc(xml: string) -> (connectedlibraries: ConnectedLibraries, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeConnectedLibraries(&bstr_xml, cast(^rawptr)&connectedlibraries)
    if ComFailed(hr) do return
    
    return connectedlibraries, true
}

DeserializeHWUnit :: proc(xml: string) -> (hwunit: HWUnit, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeHWUnit(&bstr_xml, cast(^rawptr)&hwunit)
    if ComFailed(hr) do return
    
    return hwunit, true
}

DeserializeAccessVariables :: proc(xml: string) -> (accessvariables: AccessVariables, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeAccessVariables(&bstr_xml, cast(^rawptr)&accessvariables)
    if ComFailed(hr) do return
    
    return accessvariables, true
}

DeserializeProjectConstants :: proc(xml: string) -> (projectsconstants: ProjectConstants, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeProjectConstants(&bstr_xml, cast(^rawptr)&projectsconstants)
    if ComFailed(hr) do return
    
    return projectsconstants, true
}

DeserializeMessageBucket :: proc(xml: string) -> (messagebucket: MsgBucket, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeMessageBucket(&bstr_xml, cast(^rawptr)&messagebucket)
    if ComFailed(hr) do return
    
    return messagebucket, true
}

DeserializeApplicationProperties :: proc(xml: string) -> (applicationproperties: ApplicationProperties, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeApplicationProperties(&bstr_xml, cast(^rawptr)&applicationproperties)
    if ComFailed(hr) do return
    
    return applicationproperties, true
}

DeserializeConnectedHWLibraries :: proc(xml: string) -> (connectedhwlibraries: ConnectedHWLibraries, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeConnectedHWLibraries(&bstr_xml, cast(^rawptr)&connectedhwlibraries)
    if ComFailed(hr) do return
    
    return connectedhwlibraries, true
}

DeserializeCommVariable :: proc(xml: string) -> (commvariable: CommVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeCommVariable(&bstr_xml, cast(^rawptr)&commvariable)
    if ComFailed(hr) do return
    
    return commvariable, true
}

DeserializeDiagram :: proc(xml: string) -> (diagram: Diagram, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeDiagram(&bstr_xml, cast(^rawptr)&diagram)
    if ComFailed(hr) do return
    
    return diagram, true
}

DeserializeExecutionOrder :: proc(xml: string) -> (executionorder: ExecutionOrder, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeExecutionOrder(&bstr_xml, cast(^rawptr)&executionorder)
    if ComFailed(hr) do return
    
    return executionorder, true
}

DeserializeDiagramType :: proc(xml: string) -> (diagramtype: DiagramType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeDiagramType(&bstr_xml, cast(^rawptr)&diagramtype)
    if ComFailed(hr) do return
    
    return diagramtype, true
}

DeserializeDiagramInstance :: proc(xml: string) -> (diagraminstance: DiagramInstance, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeDiagramInstance(&bstr_xml, cast(^rawptr)&diagraminstance)
    if ComFailed(hr) do return
    
    return diagraminstance, true
}

DeserializeSignal :: proc(xml: string) -> (signal: Signal, ok: bool)
{
    if !ComConnected() do return
    
    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)
    hr := objectfactory->DeserializeSignal(&bstr_xml, cast(^rawptr)&signal)
    if ComFailed(hr) do return
    
    return signal, true
}

NewDataType :: proc(name, description: string) -> (datatype: DataType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewDataType(bstr_name, bstr_description, cast(^rawptr)&datatype)
    if ComFailed(hr) do return
    
    return datatype, true
}

NewDataTypeEx :: proc(name, description: string, protected, hidden: bool, scope: i32) -> (datatype: DataType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewDataType1(bstr_name, bstr_description, ToVariantBool(protected), ToVariantBool(hidden), scope, cast(^rawptr)&datatype)
    if ComFailed(hr) do return
    
    return datatype, true
}

NewApplicationVariables :: proc(description: string) -> (applicationvariables: ApplicationVariables, ok: bool)
{
    if !ComConnected() do return
    
    bstr_description := ToBstr(description)
    defer FreeBstr(bstr_description)
    hr := objectfactory->NewApplicationVariables(bstr_description, cast(^rawptr)&applicationvariables)
    if ComFailed(hr) do return
    
    return applicationvariables, true
}

NewFunctionBlockType :: proc(name, description: string) -> (functionblocktype: FunctionBlockType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewFunctionBlockType(bstr_name, bstr_description, cast(^rawptr)&functionblocktype)
    if ComFailed(hr) do return
    
    return functionblocktype, true
}

NewFunctionBlockTypeEx :: proc(name, description: string, protected, hidden: bool, scope: i32, interaction_window: string, alarm_owner: bool, guid: string) -> (functionblocktype: FunctionBlockType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    bstr_iw          := ToBstr(interaction_window)
    bstr_guid        := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
        FreeBstr(bstr_iw)
        FreeBstr(bstr_guid)
    }
    hr := objectfactory->NewFunctionBlockType1(bstr_name, bstr_description, ToVariantBool(protected), ToVariantBool(hidden), scope, bstr_iw, ToVariantBool(alarm_owner), bstr_guid, cast(^rawptr)&functionblocktype)
    if ComFailed(hr) do return
    
    return functionblocktype, true
}

NewFunctionBlock :: proc(name, type_name: string) -> (functionblock: FunctionBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewFunctionBlock(bstr_name, bstr_type_name, cast(^rawptr)&functionblock)
    if ComFailed(hr) do return
    
    return functionblock, true
}

NewFunctionBlockEx :: proc(name, type_name, task, guid, description: string) -> (functionblock: FunctionBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_type_name   := ToBstr(type_name)
    bstr_task        := ToBstr(task)
    bstr_guid        := ToBstr(guid)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_task)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewFunctionBlock1(bstr_name, bstr_type_name, bstr_task, bstr_guid, bstr_description, cast(^rawptr)&functionblock)
    if ComFailed(hr) do return
    
    return functionblock, true
}

NewControlModuleType :: proc(name, description: string) -> (controlmoduletype: ControlModuleType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewControlModuleType(bstr_name, bstr_description, cast(^rawptr)&controlmoduletype)
    if ComFailed(hr) do return
    
    return controlmoduletype, true
}

NewControlModuleTypeEx :: proc(name, description: string, protected, hidden: bool, scope: i32, interaction_window: string, alarm_owner: bool, guid: string, graph_size: GraphSize) -> (controlmoduletype: ControlModuleType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    bstr_iw          := ToBstr(interaction_window)
    bstr_guid        := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
        FreeBstr(bstr_iw)
        FreeBstr(bstr_guid)
    }
    hr := objectfactory->NewControlModuleType1(bstr_name, bstr_description, ToVariantBool(protected), ToVariantBool(hidden), scope, bstr_iw, ToVariantBool(alarm_owner), bstr_guid, graph_size, cast(^rawptr)&controlmoduletype)
    if ComFailed(hr) do return
    
    return controlmoduletype, true
}

NewProgram :: proc(name, description: string) -> (program: Program, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewProgram(bstr_name, bstr_description, cast(^rawptr)&program)
    if ComFailed(hr) do return
    
    return program, true
}

NewProgramEx :: proc(name, description, task_connection, type_guid, inst_guid: string) -> (program: Program, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    bstr_task        := ToBstr(task_connection)
    bstr_tg          := ToBstr(type_guid)
    bstr_ig          := ToBstr(inst_guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
        FreeBstr(bstr_task)
        FreeBstr(bstr_tg)
        FreeBstr(bstr_ig)
    }
    hr := objectfactory->NewProgram1(bstr_name, bstr_description, bstr_task, bstr_tg, bstr_ig, cast(^rawptr)&program)
    if ComFailed(hr) do return
    
    return program, true
}

NewControlModule :: proc(name, type_name: string) -> (controlmodule: ControlModule, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewControlModule(bstr_name, bstr_type_name, cast(^rawptr)&controlmodule)
    if ComFailed(hr) do return
    
    return controlmodule, true
}

NewControlModuleEx :: proc(name, type_name, task: string, visibility: i32, guid, description: string, graph_pos: GraphPos) -> (controlmodule: ControlModule, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_type_name   := ToBstr(type_name)
    bstr_task        := ToBstr(task)
    bstr_guid        := ToBstr(guid)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_task)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewControlModule1(bstr_name, bstr_type_name, bstr_task, visibility, bstr_guid, bstr_description, graph_pos, cast(^rawptr)&controlmodule)
    if ComFailed(hr) do return
    
    return controlmodule, true
}

NewControlModules :: proc() -> (controlmodules: ControlModules, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewControlModules(cast(^rawptr)&controlmodules)
    if ComFailed(hr) do return
    
    return controlmodules, true
}

NewSingleControlModule :: proc(name: string) -> (singlecontrolmodule: SingleControlModule, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSingleControlModule(bstr_name, cast(^rawptr)&singlecontrolmodule)
    if ComFailed(hr) do return
    
    return singlecontrolmodule, true
}

NewSingleControlModuleEx :: proc(name, task: string, visibility: i32, type_guid, inst_guid: string, graph_pos: GraphPos) -> (singlecontrolmodule: SingleControlModule, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_task := ToBstr(task)
    bstr_tg   := ToBstr(type_guid)
    bstr_ig   := ToBstr(inst_guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_task)
        FreeBstr(bstr_tg)
        FreeBstr(bstr_ig)
    }
    hr := objectfactory->NewSingleControlModule1(bstr_name, bstr_task, visibility, bstr_tg, bstr_ig, graph_pos, cast(^rawptr)&singlecontrolmodule)
    if ComFailed(hr) do return
    
    return singlecontrolmodule, true
}

NewTask :: proc(name: string, interval_time: i32, priority: i32) -> (task: Task, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewTask(bstr_name, interval_time, priority, cast(^rawptr)&task)
    if ComFailed(hr) do return
    
    return task, true
}

NewTaskEx :: proc(name: string, interval_time: i32, priority, offset, output_update: i32) -> (task: Task, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewTask1(bstr_name, interval_time, priority, offset, output_update, cast(^rawptr)&task)
    if ComFailed(hr) do return
    
    return task, true
}

NewConnectedApplication :: proc(name: string) -> (connectedapplication: ConnectedApplication, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewConnectedApplication(bstr_name, cast(^rawptr)&connectedapplication)
    if ComFailed(hr) do return
    
    return connectedapplication, true
}

NewConnectedApplicationEx :: proc(name: string, major, minor, revision: i32) -> (connectedapplication: ConnectedApplication, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewConnectedApplication1(bstr_name, major, minor, revision, cast(^rawptr)&connectedapplication)
    if ComFailed(hr) do return
    
    return connectedapplication, true
}

NewConnectedApplications :: proc() -> (connectedapplications: ConnectedApplications, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewConnectedApplications(cast(^rawptr)&connectedapplications)
    if ComFailed(hr) do return
    
    return connectedapplications, true
}

NewConnectedLibrary :: proc(name: string) -> (connectedlibrary: ConnectedLibrary, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewConnectedLibrary(bstr_name, cast(^rawptr)&connectedlibrary)
    if ComFailed(hr) do return
    
    return connectedlibrary, true
}

NewConnectedLibraryEx :: proc(name: string, major, minor, revision: i32) -> (connectedlibrary: ConnectedLibrary, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewConnectedLibrary1(bstr_name, major, minor, revision, cast(^rawptr)&connectedlibrary)
    if ComFailed(hr) do return
    
    return connectedlibrary, true
}

NewConnectedLibraries :: proc() -> (connectedlibraries: ConnectedLibraries, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewConnectedLibraries(cast(^rawptr)&connectedlibraries)
    if ComFailed(hr) do return
    
    return connectedlibraries, true
}

NewHWUnit :: proc(path: string) -> (hwunit: HWUnit, ok: bool)
{
    if !ComConnected() do return
    
    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)
    hr := objectfactory->NewHWUnit(bstr_path, cast(^rawptr)&hwunit)
    if ComFailed(hr) do return
    
    return hwunit, true
}

NewHWUnitEx :: proc(path, type_id, type_description, guid: string) -> (hwunit: HWUnit, ok: bool)
{
    if !ComConnected() do return
    
    bstr_path := ToBstr(path)
    bstr_tid  := ToBstr(type_id)
    bstr_td   := ToBstr(type_description)
    bstr_guid := ToBstr(guid)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_tid)
        FreeBstr(bstr_td)
        FreeBstr(bstr_guid)
    }
    hr := objectfactory->NewHWUnit1(bstr_path, bstr_tid, bstr_td, bstr_guid, cast(^rawptr)&hwunit)
    if ComFailed(hr) do return
    
    return hwunit, true
}

NewHWUnitEx2 :: proc(path, type_id, type_description, guid, type_guid: string) -> (hwunit: HWUnit, ok: bool)
{
    if !ComConnected() do return
    
    bstr_path := ToBstr(path)
    bstr_tid  := ToBstr(type_id)
    bstr_td   := ToBstr(type_description)
    bstr_guid := ToBstr(guid)
    bstr_tg   := ToBstr(type_guid)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_tid)
        FreeBstr(bstr_td)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_tg)
    }
    hr := objectfactory->NewHWUnit2(bstr_path, bstr_tid, bstr_td, bstr_guid, bstr_tg, cast(^rawptr)&hwunit)
    if ComFailed(hr) do return
    
    return hwunit, true
}

NewHWChannel :: proc(address, name, con_variable, io_description: string) -> (hwchannel: HWChannel, ok: bool)
{
    if !ComConnected() do return
    
    bstr_addr           := ToBstr(address)
    bstr_name           := ToBstr(name)
    bstr_con_variable   := ToBstr(con_variable)
    bstr_io_description := ToBstr(io_description)
    defer {
        FreeBstr(bstr_addr)
        FreeBstr(bstr_name)
        FreeBstr(bstr_con_variable)
        FreeBstr(bstr_io_description)
    }
    hr := objectfactory->NewHWChannel(bstr_addr, bstr_name, bstr_con_variable, bstr_io_description, cast(^rawptr)&hwchannel)
    if ComFailed(hr) do return
    
    return hwchannel, true
}

NewHWChannelEx :: proc(address, name, con_variable, io_description: string, min, max, unit, fraction: string, reversed: bool) -> (hwchannel: HWChannel, ok: bool)
{
    if !ComConnected() do return
    
    bstr_addr           := ToBstr(address)
    bstr_name           := ToBstr(name)
    bstr_con_variable   := ToBstr(con_variable)
    bstr_io_description := ToBstr(io_description)
    bstr_min            := ToBstr(min)
    bstr_max            := ToBstr(max)
    bstr_unit           := ToBstr(unit)
    bstr_fraction       := ToBstr(fraction)
    defer {
        FreeBstr(bstr_addr)
        FreeBstr(bstr_name)
        FreeBstr(bstr_con_variable)
        FreeBstr(bstr_io_description)
        FreeBstr(bstr_min)
        FreeBstr(bstr_max)
        FreeBstr(bstr_unit)
        FreeBstr(bstr_fraction)
    }
    hr := objectfactory->NewHWChannel1(bstr_addr, bstr_name, bstr_con_variable, bstr_io_description, bstr_min, bstr_max, bstr_unit, bstr_fraction, ToVariantBool(reversed), cast(^rawptr)&hwchannel)
    if ComFailed(hr) do return
    
    return hwchannel, true
}

NewParameterSetting :: proc(name, parameter_value: string) -> (parametersetting: ParameterSetting, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name            := ToBstr(name)
    bstr_parameter_value := ToBstr(parameter_value)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parameter_value)
    }
    hr := objectfactory->NewParameterSetting(bstr_name, bstr_parameter_value, cast(^rawptr)&parametersetting)
    if ComFailed(hr) do return
    
    return parametersetting, true
}

NewVariable :: proc(name, type_name: string) -> (variable: Variable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewVariable(bstr_name, bstr_type_name, cast(^rawptr)&variable)
    if ComFailed(hr) do return
    
    return variable, true
}

NewVariableEx :: proc(name, type_name, attribute, initial_value, read_permission, write_permission, description: string) -> (variable: Variable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_type_name        := ToBstr(type_name)
    bstr_attribute        := ToBstr(attribute)
    bstr_initial_value    := ToBstr(initial_value)
    bstr_read_permission  := ToBstr(read_permission)
    bstr_write_permission := ToBstr(write_permission)
    bstr_description      := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_read_permission)
        FreeBstr(bstr_write_permission)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewVariable1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&variable)
    if ComFailed(hr) do return
    
    return variable, true
}

NewGlobalVariable :: proc(name, type_name: string) -> (globalvariable: GlobalVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewGlobalVariable(bstr_name, bstr_type_name, cast(^rawptr)&globalvariable)
    if ComFailed(hr) do return
    
    return globalvariable, true
}

NewGlobalVariableEx :: proc(name, type_name, attribute, initial_value, read_permission, write_permission, description: string) -> (globalvariable: GlobalVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_type_name        := ToBstr(type_name)
    bstr_attribute        := ToBstr(attribute)
    bstr_initial_value    := ToBstr(initial_value)
    bstr_read_permission  := ToBstr(read_permission)
    bstr_write_permission := ToBstr(write_permission)
    bstr_description      := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_read_permission)
        FreeBstr(bstr_write_permission)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewGlobalVariable1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&globalvariable)
    if ComFailed(hr) do return
    
    return globalvariable, true
}

NewExternalVariable :: proc(name, type_name: string) -> (externalvariable: ExternalVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewExternalVariable(bstr_name, bstr_type_name, cast(^rawptr)&externalvariable)
    if ComFailed(hr) do return
    
    return externalvariable, true
}

NewExternalVariableEx :: proc(name, type_name, attribute, read_permission, write_permission, description: string) -> (externalvariable: ExternalVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_type_name        := ToBstr(type_name)
    bstr_attribute        := ToBstr(attribute)
    bstr_read_permission  := ToBstr(read_permission)
    bstr_write_permission := ToBstr(write_permission)
    bstr_description      := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_read_permission)
        FreeBstr(bstr_write_permission)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewExternalVariable1(bstr_name, bstr_type_name, bstr_attribute, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&externalvariable)
    if ComFailed(hr) do return
    
    return externalvariable, true
}

NewParameter :: proc(name, type_name: string) -> (parameter: Parameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewParameter(bstr_name, bstr_type_name, cast(^rawptr)&parameter)
    if ComFailed(hr) do return
    
    return parameter, true
}

NewParameterEx :: proc(name, type_name, attribute: string, direction: i32, initial_value, read_permission, write_permission, description: string) -> (parameter: Parameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_type_name        := ToBstr(type_name)
    bstr_attribute        := ToBstr(attribute)
    bstr_initial_value    := ToBstr(initial_value)
    bstr_read_permission  := ToBstr(read_permission)
    bstr_write_permission := ToBstr(write_permission)
    bstr_description      := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_read_permission)
        FreeBstr(bstr_write_permission)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewParameter1(bstr_name, bstr_type_name, bstr_attribute, direction, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, cast(^rawptr)&parameter)
    if ComFailed(hr) do return
    
    return parameter, true
}

NewCMParameter :: proc(name, type_name: string) -> (cmparameter: CMParameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewCMParameter(bstr_name, bstr_type_name, cast(^rawptr)&cmparameter)
    if ComFailed(hr) do return
    
    return cmparameter, true
}

NewCMParameterEx :: proc(name, type_name, initial_value, read_permission, write_permission, description: string, auto_point: AutoPoint) -> (cmparameter: CMParameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_type_name        := ToBstr(type_name)
    bstr_initial_value    := ToBstr(initial_value)
    bstr_read_permission  := ToBstr(read_permission)
    bstr_write_permission := ToBstr(write_permission)
    bstr_description      := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_read_permission)
        FreeBstr(bstr_write_permission)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewCMParameter1(bstr_name, bstr_type_name, bstr_initial_value, bstr_read_permission, bstr_write_permission, bstr_description, auto_point, cast(^rawptr)&cmparameter)
    if ComFailed(hr) do return
    
    return cmparameter, true
}

NewExtensibleParameter :: proc(name, type_name: string) -> (extensibleparameter: ExtensibleParameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewExtensibleParameter(bstr_name, bstr_type_name, cast(^rawptr)&extensibleparameter)
    if ComFailed(hr) do return
    
    return extensibleparameter, true
}

NewExtensibleParameterEx :: proc(name, type_name, attribute: string, direction: i32, initial_value, description: string) -> (extensibleparameter: ExtensibleParameter, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name          := ToBstr(name)
    bstr_type_name     := ToBstr(type_name)
    bstr_attribute     := ToBstr(attribute)
    bstr_initial_value := ToBstr(initial_value)
    bstr_description   := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewExtensibleParameter1(bstr_name, bstr_type_name, bstr_attribute, direction, bstr_initial_value, bstr_description, cast(^rawptr)&extensibleparameter)
    if ComFailed(hr) do return
    
    return extensibleparameter, true
}

NewComponent :: proc(name, type_name: string) -> (component: Component, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewComponent(bstr_name, bstr_type_name, cast(^rawptr)&component)
    if ComFailed(hr) do return
    
    return component, true
}

NewComponentEx :: proc(name, type_name: string, attribute := "", initial_value := "", description: string) -> (component: Component, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name          := ToBstr(name)
    bstr_type_name     := ToBstr(type_name)
    bstr_attribute     := ToBstr(attribute)
    bstr_initial_value := ToBstr(initial_value)
    bstr_description   := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewComponent1(bstr_name, bstr_type_name, bstr_attribute, bstr_initial_value, bstr_description, cast(^rawptr)&component)
    if ComFailed(hr) do return
    
    return component, true
}

NewCMConnection :: proc(name, actual_parameter: string) -> (cmconnection: CMConnection, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_actual_parameter := ToBstr(actual_parameter)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_actual_parameter)
    }
    hr := objectfactory->NewCMConnection(bstr_name, bstr_actual_parameter, cast(^rawptr)&cmconnection)
    if ComFailed(hr) do return
    
    return cmconnection, true
}

NewCMConnectionEx :: proc(name, actual_parameter: string, graphical_connection: bool) -> (cmconnection: CMConnection, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name             := ToBstr(name)
    bstr_actual_parameter := ToBstr(actual_parameter)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_actual_parameter)
    }
    hr := objectfactory->NewCMConnection1(
        bstr_name, bstr_actual_parameter, ToVariantBool(graphical_connection), cast(^rawptr)&cmconnection,
    )
    if ComFailed(hr) do return
    
    return cmconnection, true
}

NewAutoPoint :: proc(auto_pos: i32) -> (autopoint: AutoPoint, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewAutoPoint(auto_pos, cast(^rawptr)&autopoint)
    if ComFailed(hr) do return
    
    return autopoint, true
}

NewPoint :: proc(x, y: f64) -> (point: Point, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewPoint(x, y, cast(^rawptr)&point)
    if ComFailed(hr) do return
    
    return point, true
}

NewGraphPos :: proc(x_pos, y_pos, rotation, x_scale, y_scale: f64) -> (graphpos: GraphPos, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewGraphPos(x_pos, y_pos, rotation, x_scale, y_scale, cast(^rawptr)&graphpos)
    if ComFailed(hr) do return
    
    return graphpos, true
}

NewGraphSize :: proc(lower_left, upper_right: Point) -> (graphsize: GraphSize, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewGraphSize(lower_left, upper_right, cast(^rawptr)&graphsize)
    if ComFailed(hr) do return
    
    return graphsize, true
}

NewGraphNode :: proc(name: string, x, y: f64) -> (graphnode: GraphNode, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewGraphNode(bstr_name, x, y, cast(^rawptr)&graphnode)
    if ComFailed(hr) do return
    
    return graphnode, true
}

NewSTCodeBlock :: proc(name: string) -> (stcodeblock: STCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSTCodeBlock(bstr_name, cast(^rawptr)&stcodeblock)
    if ComFailed(hr) do return
    
    return stcodeblock, true
}

NewSTCodeBlockEx :: proc(name: string, st_code: string) -> (stcodeblock: STCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name    := ToBstr(name)
    bstr_st_code := ToBstr(st_code)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_st_code)
    }
    hr := objectfactory->NewSTCodeBlock1(bstr_name, &bstr_st_code, cast(^rawptr)&stcodeblock)
    if ComFailed(hr) do return
    
    return stcodeblock, true
}

NewLDCodeBlock :: proc(name: string) -> (ldcodeblock: LDCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewLDCodeBlock(bstr_name, cast(^rawptr)&ldcodeblock)
    if ComFailed(hr) do return
    
    return ldcodeblock, true
}

NewLDCodeBlockEx :: proc(name: string, st_code: string) -> (ldcodeblock: LDCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name    := ToBstr(name)
    bstr_st_code := ToBstr(st_code)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_st_code)
    }
    hr := objectfactory->NewLDCodeBlock1(bstr_name, &bstr_st_code, cast(^rawptr)&ldcodeblock)
    if ComFailed(hr) do return
    
    return ldcodeblock, true
}

NewFBDCodeBlock :: proc(name: string) -> (fbdcodeblock: FBDCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewFBDCodeBlock(bstr_name, cast(^rawptr)&fbdcodeblock)
    if ComFailed(hr) do return
    
    return fbdcodeblock, true
}

NewFBDCodeBlockEx :: proc(name: string, st_code: string) -> (fbdcodeblock: FBDCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name    := ToBstr(name)
    bstr_st_code := ToBstr(st_code)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_st_code)
    }
    hr := objectfactory->NewFBDCodeBlock1(bstr_name, &bstr_st_code, cast(^rawptr)&fbdcodeblock)
    if ComFailed(hr) do return
    
    return fbdcodeblock, true
}

NewSFCCodeBlock :: proc(name: string) -> (sfccodeblock: SFCCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSFCCodeBlock(bstr_name, cast(^rawptr)&sfccodeblock)
    if ComFailed(hr) do return
    
    return sfccodeblock, true
}

NewSFCCodeBlockEx :: proc(name: string, seq_control, step_elapsed_time: bool) -> (sfccodeblock: SFCCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSFCCodeBlock1(bstr_name, ToVariantBool(seq_control), ToVariantBool(step_elapsed_time), cast(^rawptr)&sfccodeblock)
    if ComFailed(hr) do return
    
    return sfccodeblock, true
}

NewSFCStep :: proc(name: string) -> (sfcstep: SFCStep, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSFCStep(bstr_name, cast(^rawptr)&sfcstep)
    if ComFailed(hr) do return
    
    return sfcstep, true
}

NewSFCStepEx :: proc(name: string, initial_step: bool, p1_action, n_action, p0_action: string) -> (sfcstep: SFCStep, ok: bool)
{
    if !ComConnected() do return
   
    bstr_name := ToBstr(name)
    bstr_p1   := ToBstr(p1_action)
    bstr_n    := ToBstr(n_action)
    bstr_p0   := ToBstr(p0_action)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_p1)
        FreeBstr(bstr_n)
        FreeBstr(bstr_p0)
    }
    hr := objectfactory->NewSFCStep1(bstr_name, ToVariantBool(initial_step), bstr_p1, bstr_n, bstr_p0, cast(^rawptr)&sfcstep)
    if ComFailed(hr) do return
    
    return sfcstep, true
}

NewSFCTransition :: proc(name: string) -> (sfctransition: SFCTransition, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSFCTransition(bstr_name, cast(^rawptr)&sfctransition)
    if ComFailed(hr) do return
    
    return sfctransition, true
}

NewSFCTransitionEx :: proc(name, st_code, dest: string) -> (sfctransition: SFCTransition, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name    := ToBstr(name)
    bstr_st_code := ToBstr(st_code)
    bstr_dest    := ToBstr(dest)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_st_code)
        FreeBstr(bstr_dest)
    }
    hr := objectfactory->NewSFCTransition1(bstr_name, bstr_st_code, bstr_dest, cast(^rawptr)&sfctransition)
    if ComFailed(hr) do return
    
    return sfctransition, true
}

NewSFCSelection :: proc(nr_of_branches: i32) -> (sfcselection: SFCSelection, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewSFCSelection(nr_of_branches, cast(^rawptr)&sfcselection)
    if ComFailed(hr) do return
    
    return sfcselection, true
}

NewSFCSimultaneous :: proc(nr_of_branches: i32) -> (sfcsimultaneous: SFCSimultaneous, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewSFCSimultaneous(nr_of_branches, cast(^rawptr)&sfcsimultaneous)
    if ComFailed(hr) do return
    
    return sfcsimultaneous, true
}

NewSFCSubSequence :: proc(name: string) -> (sfcsubsequence: SFCSubSequence, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewSFCSubSequence(bstr_name, cast(^rawptr)&sfcsubsequence)
    if ComFailed(hr) do return
    
    return sfcsubsequence, true
}

NeILCodeBlock :: proc(name: string) -> (ilcodeblock: ILCodeBlock, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewILCodeBlock(bstr_name, cast(^rawptr)&ilcodeblock)
    if ComFailed(hr) do return
    
    return ilcodeblock, true
}

NewILRow :: proc(label, instruction, operand, description: string) -> (ilrow: ILRow, ok: bool)
{
    if !ComConnected() do return
    
    bstr_label        := ToBstr(label)
    bstr_instr        := ToBstr(instruction)
    bstr_op           := ToBstr(operand)
    bstr_description  := ToBstr(description)
    defer {
        FreeBstr(bstr_label)
        FreeBstr(bstr_instr)
        FreeBstr(bstr_op)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewILRow(bstr_label, bstr_instr, bstr_op, bstr_description, cast(^rawptr)&ilrow)
    if ComFailed(hr) do return
    
    return ilrow, true
}

NewILRowEx :: proc(comment: string) -> (ilrow: ILRow, ok: bool)
{
    if !ComConnected() do return
    
    bstr_comment := ToBstr(comment)
    defer FreeBstr(bstr_comment)
    hr := objectfactory->NewILComment(bstr_comment, cast(^rawptr)&ilrow)
    if ComFailed(hr) do return
    
    return ilrow, true
}

NewVANamedProtocol :: proc(name: string) -> (vanamedprotocol: VANamedProtocol, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewVANamedProtocol(bstr_name, cast(^rawptr)&vanamedprotocol)
    if ComFailed(hr) do return
    
    return vanamedprotocol, true
}

NewVAAddressedProtocol :: proc(name: string) -> (vaaddressedprotocol: VAAddressedProtocol, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewVAAddressedProtocol(bstr_name, cast(^rawptr)&vaaddressedprotocol)
    if ComFailed(hr) do return
    
    return vaaddressedprotocol, true
}

NewVANamedVariable :: proc(name, path: string) -> (vanamedvariable: VANamedVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_path := ToBstr(path)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_path)
    }
    hr := objectfactory->NewVANamedVariable(bstr_name, bstr_path, cast(^rawptr)&vanamedvariable)
    if ComFailed(hr) do return
    
    return vanamedvariable, true
}

NewVANamedVariableEx :: proc(name, path, va_attribute: string, row: i32) -> (vanamedvariable: VANamedVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_path      := ToBstr(path)
    bstr_attribute := ToBstr(va_attribute)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_path)
        FreeBstr(bstr_attribute)
    }
    hr := objectfactory->NewVANamedVariable1(bstr_name, bstr_path, bstr_attribute, row, cast(^rawptr)&vanamedvariable)
    if ComFailed(hr) do return
    
    return vanamedvariable, true
}

NewVAAddressedVariable :: proc(name, path: string) -> (vaaddressedvariable: VAAddressedVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_path := ToBstr(path)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_path)
    }
    hr := objectfactory->NewVAAddressedVariable(bstr_name, bstr_path, cast(^rawptr)&vaaddressedvariable)
    if ComFailed(hr) do return
    
    return vaaddressedvariable, true
}

NewVAAddressedVariableEx :: proc(name, path: string, row: i32) -> (vaaddressedvariable: VAAddressedVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_path := ToBstr(path)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_path)
    }
    hr := objectfactory->NewVAAddressedVariable1(bstr_name, bstr_path, row, cast(^rawptr)&vaaddressedvariable)
    if ComFailed(hr) do return
    
    return vaaddressedvariable, true
}

NewAccessVariables :: proc() -> (accessvariables: AccessVariables, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewAccessVariables(cast(^rawptr)&accessvariables)
    if ComFailed(hr) do return
    
    return accessvariables, true
}

NewProjectConstants :: proc() -> (projectconstants: ProjectConstants, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewProjectConstants(cast(^rawptr)&projectconstants)
    if ComFailed(hr) do return
    
    return projectconstants, true
}

NewProjectConstant :: proc(name, pc_type, value: string) -> (projectconstant: ProjectConstant, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(pc_type)
    bstr_val       := ToBstr(value)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_val)
    }
    hr := objectfactory->NewProjectConstant(bstr_name, bstr_type_name, bstr_val, cast(^rawptr)&projectconstant)
    if ComFailed(hr) do return
    
    return projectconstant, true
}

NewApplicationProperties :: proc(sil_level: string, simulation_mark: bool) -> (applicationproperties: ApplicationProperties, ok: bool)
{
    if !ComConnected() do return
    
    bstr_sil := ToBstr(sil_level)
    defer FreeBstr(bstr_sil)
    hr := objectfactory->NewApplicationProperties(bstr_sil, ToVariantBool(simulation_mark), cast(^rawptr)&applicationproperties)
    if ComFailed(hr) do return
    
    return applicationproperties, true
}

NewConnectedHWLibrary :: proc(name: string) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewConnectedHWLibrary(bstr_name, cast(^rawptr)&connectedhwlibrary)
    if ComFailed(hr) do return
    
    return connectedhwlibrary, true
}

NewConnectedHWLibraryEx :: proc(name: string, major, minor, revision: i32) -> (connectedhwlibrary: ConnectedHWLibrary, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewConnectedHWLibrary1(bstr_name, major, minor, revision, cast(^rawptr)&connectedhwlibrary)
    if ComFailed(hr) do return
    
    return connectedhwlibrary, true
}

NewConnectedHWLibraries :: proc() -> (connectedhwlibaries: ConnectedHWLibraries, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewConnectedHWLibraries(cast(^rawptr)&connectedhwlibaries)
    if ComFailed(hr) do return
    
    return connectedhwlibaries, true
}

NewCommVariable :: proc(name, type_name, direction: string) -> (commvariable: CommVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    bstr_dir       := ToBstr(direction)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_dir)
    }
    hr := objectfactory->NewCommVariable(bstr_name, bstr_type_name, bstr_dir, cast(^rawptr)&commvariable)
    if ComFailed(hr) do return
    
    return commvariable, true
}

NewCommVariableEx :: proc(name, type_name, direction, attribute, initial_value, isp_value, priority, interval_time, read_permission, description: string) -> (commvariable: CommVariable, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name            := ToBstr(name)
    bstr_type_name       := ToBstr(type_name)
    bstr_dir             := ToBstr(direction)
    bstr_attribute       := ToBstr(attribute)
    bstr_initial_value   := ToBstr(initial_value)
    bstr_isp             := ToBstr(isp_value)
    bstr_prio            := ToBstr(priority)
    bstr_int             := ToBstr(interval_time)
    bstr_read_permission := ToBstr(read_permission)
    bstr_description     := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_dir)
        FreeBstr(bstr_attribute)
        FreeBstr(bstr_initial_value)
        FreeBstr(bstr_isp)
        FreeBstr(bstr_prio)
        FreeBstr(bstr_int)
        FreeBstr(bstr_read_permission)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewCommVariable1(bstr_name, bstr_type_name, bstr_dir, bstr_attribute, bstr_initial_value, bstr_isp, bstr_prio, bstr_int, bstr_read_permission, bstr_description, cast(^rawptr)&commvariable)
    if ComFailed(hr) do return
    
    return commvariable, true
}

NewInitValue :: proc(pou_path, name, value: string) -> (initvalue: InitValue, ok: bool)
{
    if !ComConnected() do return
    
    bstr_path := ToBstr(pou_path)
    bstr_name := ToBstr(name)
    bstr_val  := ToBstr(value)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
        FreeBstr(bstr_val)
    }
    hr := objectfactory->NewInitValue(bstr_path, bstr_name, bstr_val, cast(^rawptr)&initvalue)
    if ComFailed(hr) do return
    
    return initvalue, true
}

NewDiagram :: proc(name, description: string) -> (diagram: Diagram, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewDiagram(bstr_name, bstr_description, cast(^rawptr)&diagram)
    if ComFailed(hr) do return
    
    return diagram, true
}

NewDiagramEx :: proc(name, description, task, type_guid, inst_guid: string) -> (diagram: Diagram, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    bstr_description := ToBstr(description)
    bstr_task := ToBstr(task)
    bstr_tg   := ToBstr(type_guid)
    bstr_ig   := ToBstr(inst_guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
        FreeBstr(bstr_task)
        FreeBstr(bstr_tg)
        FreeBstr(bstr_ig)
    }
    hr := objectfactory->NewDiagram1(bstr_name, bstr_description, bstr_task, bstr_tg, bstr_ig, cast(^rawptr)&diagram)
    if ComFailed(hr) do return
    
    return diagram, true
}

NewExecutionOrder :: proc() -> (executionorder: ExecutionOrder, ok: bool)
{
    if !ComConnected() do return
    
    hr := objectfactory->NewExecutionOrder(cast(^rawptr)&executionorder)
    if ComFailed(hr) do return
    
    return executionorder, true
}

NewExecutionInstance :: proc(name: string) -> (executioninstance: ExecutionInstance, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := objectfactory->NewExecutionInstance(bstr_name, cast(^rawptr)&executioninstance)
    if ComFailed(hr) do return
    
    return executioninstance, true
}

NewDiagramType :: proc(name, description: string) -> (diagramtype: DiagramType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewDiagramType(bstr_name, bstr_description, cast(^rawptr)&diagramtype)
    if ComFailed(hr) do return
    
    return diagramtype, true
}

NewDiagramTypeEx :: proc(name, description: string, protected, hidden: bool, scope: i32, alarm_owner: bool, guid: string) -> (diagramtype: DiagramType, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_description := ToBstr(description)
    bstr_guid        := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_description)
        FreeBstr(bstr_guid)
    }
    hr := objectfactory->NewDiagramType1(bstr_name, bstr_description, ToVariantBool(protected), ToVariantBool(hidden), scope, ToVariantBool(alarm_owner), bstr_guid, cast(^rawptr)&diagramtype)
    if ComFailed(hr) do return
    
    return diagramtype, true
}

NewDiagramInstance :: proc(name, type_name: string) -> (diagraminstance: DiagramInstance, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name      := ToBstr(name)
    bstr_type_name := ToBstr(type_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
    }
    hr := objectfactory->NewDiagramInstance(bstr_name, bstr_type_name, cast(^rawptr)&diagraminstance)
    if ComFailed(hr) do return
    
    return diagraminstance, true
}

NewDiagramInstanceEx :: proc(name, type_name, guid, description: string) -> (diagraminstance: DiagramInstance, ok: bool)
{
    if !ComConnected() do return
    
    bstr_name        := ToBstr(name)
    bstr_type_name   := ToBstr(type_name)
    bstr_guid        := ToBstr(guid)
    bstr_description := ToBstr(description)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type_name)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_description)
    }
    hr := objectfactory->NewDiagramInstance1(bstr_name, bstr_type_name, bstr_guid, bstr_description, cast(^rawptr)&diagraminstance)
    if ComFailed(hr) do return
    
    return diagraminstance, true
}

NewSignal :: proc(name, path: string, direction := "", acknowledge_group := "") -> (signal: Signal, ok: bool)
{
    if !ComConnected() do return

    v_name := ToVariant(name)
    v_path := ToVariant(path)
    v_dir  := ToVariant(direction)
    v_ag   := ToVariant(acknowledge_group)
    defer {
        FreeVariant(&v_name)
        FreeVariant(&v_path)
        FreeVariant(&v_dir)
        FreeVariant(&v_ag)
    }

    // ars in NewSignal order (Name, Path, Direction, AcknowledgeGroup)
    args := []Variant{ v_name, v_path, v_dir, v_ag }

    result: Variant
    this := cast(^IUnknownIF)objectfactory

    ok = InvokeComName(this, "NewSignal", args,  &result)
    if !ok do return
    defer FreeVariant(&result)

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
