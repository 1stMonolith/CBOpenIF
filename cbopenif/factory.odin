package cbopenif

import "core:fmt"
import "core:sys/windows"

FactoryIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^FactoryVTable,
}

factoryif: ^FactoryIF

FactoryVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    DeserializeExternalVariable:        proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ExternalVariable: ^ExternalVariable) -> HResult,
    DeserializeGlobalVariable:          proc "system" (this: ^FactoryIF, XMLStr: ^BStr, GlobalVariable: ^GlobalVariable) -> HResult,
    DeserializeVariable:                proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Variable: ^Variable) -> HResult,
    DeserializeCMParameter:             proc "system" (this: ^FactoryIF, XMLStr: ^BStr, CMParameter: ^CMParameter) -> HResult,
    DeserializeExtensibleParameter:     proc "system" (this: ^FactoryIF, XMLStr: ^BStr, extensibleparameter: ^rawptr) -> HResult,
    DeserializeParameter:               proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Parameter: ^Parameter) -> HResult,
    DeserializeCodeBlock:               proc "system" (this: ^FactoryIF, XMLStr: ^BStr, codeblock: ^rawptr) -> HResult,
    DeserializeCMConnection:            proc "system" (this: ^FactoryIF, XMLStr: ^BStr, CMConnection: ^CMConnection) -> HResult,
    DeserializeDataType:                proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Datatype: ^DataType) -> HResult,
    NewDataType:                        proc "system" (this: ^FactoryIF, Name, Description: BStr, DataType: ^DataType) -> HResult,
    NewDataType1:                       proc "system" (this: ^FactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: Scope, DataType: ^DataType) -> HResult,
    DeserializeApplicationVariables:    proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ApplicationVariables: ^ApplicationVariables) -> HResult,
    NewApplicationVariables:            proc "system" (this: ^FactoryIF, Description: BStr, ApplicationVariables: ^ApplicationVariables) -> HResult,
    DeserializeFunctionBlockType:       proc "system" (this: ^FactoryIF, XMLStr: ^BStr, FunctionBlockType: ^rawptr) -> HResult,
    NewFunctionBlockType:               proc "system" (this: ^FactoryIF, Name, Description: BStr, FunctionBlockType: ^rawptr) -> HResult,
    NewFunctionBlockType1:              proc "system" (this: ^FactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: Scope, FunctionBlockType: ^rawptr) -> HResult,
    DeserializeFunctionBlock:           proc "system" (this: ^FactoryIF, XMLStr: ^BStr, functionblock: ^rawptr) -> HResult,
    NewFunctionBlock:                   proc "system" (this: ^FactoryIF, Name, Type: BStr, functionblock: ^rawptr) -> HResult,
    NewFunctionBlock1:                  proc "system" (this: ^FactoryIF, Name, Type, Task, Guid, Description: BStr, FunctionBlock: ^rawptr) -> HResult,
    DeserializeControlModuleType:       proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ControlModuleType: ^rawptr) -> HResult,
    NewControlModuleType:               proc "system" (this: ^FactoryIF, Name, Description: BStr, ControlModuleType: ^rawptr) -> HResult,
    NewControlModuleType1:              proc "system" (this: ^FactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: Scope, InteractionWindow: BStr, AlarmOwner: VariantBool, Guid: BStr, GraphSize: GraphSize, ControlModuleType: ^rawptr) -> HResult,
    DeserializeProgram:                 proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Program: ^rawptr) -> HResult,
    NewProgram:                         proc "system" (this: ^FactoryIF, Name, Description: BStr, Program: ^rawptr) -> HResult,
    NewProgram1:                        proc "system" (this: ^FactoryIF, Name, Description, TaskCOnnection, Guid, InstGuid: BStr, Program: ^rawptr) -> HResult,
    DeserializeControlModule:           proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ControlModule: ^rawptr) -> HResult,
    NewControlModule:                   proc "system" (this: ^FactoryIF, Name, Type: BStr, ControlModule: ^rawptr) -> HResult,
    NewControlModule1:                  proc "system" (this: ^FactoryIF, Name, Type, Task: BStr, VisibilityInGraphics: VisibilityInGraphics, Guid, Description: BStr, GraphPos: rawptr, ControlModule: ^rawptr) -> HResult,
    DeserializeControlModules:          proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ControlModules: ^rawptr) -> HResult,
    NewControlModules:                  proc "system" (this: ^FactoryIF, ControlModules: ^rawptr) -> HResult,
    NewSingleControlModuleType:         proc "system" (this: ^FactoryIF, Name, Description: BStr, SingleControlModuleType: ^rawptr) -> HResult,
    NewSingleControlModuleType1:        proc "system" (this: ^FactoryIF, Name, Description, InteractionWindow: BStr, AlarmOwner: VariantBool, Guid: BStr, GraphSize: GraphSize, SingleControlModuleType: ^rawptr) -> HResult,
    DeserializeSingleControlModuleType: proc "system" (this: ^FactoryIF, XMLStr: ^BStr, SingleControlModuleType: ^rawptr) -> HResult,
    DeserializeSingleControlModuleInst: proc "system" (this: ^FactoryIF, XMLStr: ^BStr, SingleControlModuleInst: ^rawptr) -> HResult,
    NewSingleControlModuleInst:         proc "system" (this: ^FactoryIF, Name: BStr, SingleControlModuleInst: ^rawptr) -> HResult,
    NewSingleControlModuleInst1:        proc "system" (this: ^FactoryIF, Name, Task: BStr, VisibilityInGraphics: VisibilityInGraphics, Guid, InstGuide: BStr, GraphPos: rawptr, SingleControlModuleInst: ^rawptr) -> HResult,
    DeserializeTask:                    proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Task: ^rawptr) -> HResult,
    NewTask:                            proc "system" (this: ^FactoryIF, Name: BStr, IntervalTime: i32, TaskPriority: TaskPriority, Task: ^rawptr) -> HResult,
    NewTask1:                           proc "system" (this: ^FactoryIF, Name: BStr, IntervalTime: i32, TaskPriority: TaskPriority, Offset: i32, OutputUpdate: OutputUpdate, Task: ^rawptr) -> HResult,
    DeserializeConnectedApplications:   proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ConnectedApplications: ^rawptr) -> HResult,
    NewConnectedApplication:            proc "system" (this: ^FactoryIF, Name: BStr, ConnectedApplication: ^rawptr) -> HResult,
    NewConnectedApplication1:           proc "system" (this: ^FactoryIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedApplication: ^rawptr) -> HResult,
    NewConnectedApplications:           proc "system" (this: ^FactoryIF, ConnectedApplication: ^rawptr) -> HResult,
    DeserializeConnectedLibraries:      proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ConnectedLibraries: ^rawptr) -> HResult,
    NewConnectedLibrary:                proc "system" (this: ^FactoryIF, Name: BStr, ConnectedLibrary: ^rawptr) -> HResult,
    NewConnectedLibrary1:               proc "system" (this: ^FactoryIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedLibrary: ^rawptr) -> HResult,
    NewConnectedLibraries:              proc "system" (this: ^FactoryIF, ConnectedLibraries: ^rawptr) -> HResult,
    DeserializeHWUnit:                  proc "system" (this: ^FactoryIF, XMLStr: ^BStr, HWUnit: ^rawptr) -> HResult,
    NewHWUnit:                          proc "system" (this: ^FactoryIF, Path: BStr, HWUnit: ^rawptr) -> HResult,
    NewHWUnit1:                         proc "system" (this: ^FactoryIF, Path, TypeID, TypeDescription, Guid: BStr, HWUnit: ^rawptr) -> HResult,
    NewHWChannel:                       proc "system" (this: ^FactoryIF, Address, Name, ConVariable, IODescription: BStr, HWChannel: ^rawptr) -> HResult,
    NewHWChannel1:                      proc "system" (this: ^FactoryIF, Address, Name, ConVariable, IODescription, Min, Max, Unit, Fraction: BStr, Reversed: VariantBool, HWChannel: ^rawptr) -> HResult,
    NewParameterSetting:                proc "system" (this: ^FactoryIF, Name, ParameterValue: BStr, ParameterSetting: ^ParameterSetting) -> HResult,
    NewVariable:                        proc "system" (this: ^FactoryIF, Name, TypeName: BStr, variable: ^Variable) -> HResult,
    NewVariable1:                       proc "system" (this: ^FactoryIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, variable: ^Variable) -> HResult,
    NewGlobalVariable:                  proc "system" (this: ^FactoryIF, Name, TypeName: BStr, GlobalVariable: ^GlobalVariable) -> HResult,
    NewGlobalVariable1:                 proc "system" (this: ^FactoryIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, GlobalVariable: ^GlobalVariable) -> HResult,
    NewExternalVariable:                proc "system" (this: ^FactoryIF, Name, Type: BStr, ExternalVariable: ^ExternalVariable) -> HResult,
    NewExternalVariable1:               proc "system" (this: ^FactoryIF, Name, Type, Attribute, ReadPermission, WritePermission, Description: BStr, ExternalVariable: ^ExternalVariable) -> HResult,
    NewParameter:                       proc "system" (this: ^FactoryIF, Name, TypeName: BStr, Parameter: ^Parameter) -> HResult,
    NewParameter1:                      proc "system" (this: ^FactoryIF, Name, TypeName, Attribute: BStr, Direction: i32, InitialValue, ReadPermission, WritePermission, Description: BStr, Parameter: ^Parameter) -> HResult,
    NewCMParameter:                     proc "system" (this: ^FactoryIF, Name, TypeName: BStr, CMParameter: ^CMParameter) -> HResult,
    NewCMParameter1:                    proc "system" (this: ^FactoryIF, Name, TypeName, Attribute, InitialValue, ReadPermission, WritePermission, Description: BStr, AutoPoint: AutoPoint, CMParameter: ^CMParameter) -> HResult,
    NewExtensibleParameter:             proc "system" (this: ^FactoryIF, Name, Type: BStr, extensibleparameter: ^rawptr) -> HResult,
    NewExtensibleParameter1:            proc "system" (this: ^FactoryIF, Name, Type, Attribute: BStr, Direction: Direction, InitialValue, Description: BStr, extensibleparameter: ^rawptr) -> HResult,
    NewComponent:                       proc "system" (this: ^FactoryIF, Name, TypeName: BStr, Component: ^Component) -> HResult,
    NewComponent1:                      proc "system" (this: ^FactoryIF, Name, TypeName, Attribute, InitialValue, Description: BStr, Component: ^Component) -> HResult,
    NewCMConnection:                    proc "system" (this: ^FactoryIF, Name, ActualParameter: BStr, CMConnection: ^CMConnection) -> HResult,
    NewCMConnection1:                   proc "system" (this: ^FactoryIF, Name, ActualParameter: BStr, GraphicalConnection: VariantBool, CMConnection: ^CMConnection) -> HResult,
    NewAutoPoint:                       proc "system" (this: ^FactoryIF, AutoPos: i32, AutoPoint: ^AutoPoint) -> HResult,
    NewPoint:                           proc "system" (this: ^FactoryIF, X, Y: f64, Point: ^Point) -> HResult,
    NewGraphPos:                        proc "system" (this: ^FactoryIF, XPos, YPos, Rotation, XScale, YScale: f64, GraphPos: ^GraphPos) -> HResult,
    NewGraphSize:                       proc "system" (this: ^FactoryIF, LowerLeft, UpperRight: Point, GraphSize: ^GraphSize) -> HResult,
    NewGraphNode:                       proc "system" (this: ^FactoryIF, Name: BStr, X, Y: f64, GraphNode: ^GraphNode) -> HResult,
    NewSTCodeBlock:                     proc "system" (this: ^FactoryIF, Name: BStr, STCodeBLock: ^rawptr) -> HResult,
    NewSTCodeBlock1:                    proc "system" (this: ^FactoryIF, Name: BStr, STCode: ^BStr, STCodeBLock: ^rawptr) -> HResult,
    NewLDCodeBlock:                     proc "system" (this: ^FactoryIF, Name: BStr, LDCodeBlock: ^rawptr) -> HResult,
    NewLDCodeBlock1:                    proc "system" (this: ^FactoryIF, Name: BStr, STCode: ^BStr, LDCodeBlock: ^rawptr) -> HResult,
    NewFBDCodeBlock:                    proc "system" (this: ^FactoryIF, Name: BStr, FBDCodeBlock: ^rawptr) -> HResult,
    NewFBDCodeBlock1:                   proc "system" (this: ^FactoryIF, Name: BStr, STCode: ^BStr, FBDCodeBlock: ^rawptr) -> HResult,
    NewSFCCodeBlock:                    proc "system" (this: ^FactoryIF, Name: BStr, SFCCodeBlock: ^rawptr) -> HResult,
    NewSFCCodeBlock1:                   proc "system" (this: ^FactoryIF, Name: BStr, SeqControl, StepElapsedTime: VariantBool, SFCCodeBlock: ^rawptr) -> HResult,
    NewSFCStep:                         proc "system" (this: ^FactoryIF, Name: BStr, SFCStep: ^rawptr) -> HResult,
    NewSFCStep1:                        proc "system" (this: ^FactoryIF, Name: BStr, InitialStep: VariantBool, P1_Action_STCode, N_Action_STCode, P0_Action_STCode: BStr, SFCStep: ^rawptr) -> HResult,
    NewSFCTransition:                   proc "system" (this: ^FactoryIF, Name: BStr, SFCTransition: ^rawptr) -> HResult,
    NewSFCTransition1:                  proc "system" (this: ^FactoryIF, Name, Transition_STCode, Dest: BStr, SFCTransition: ^rawptr) -> HResult,
    NewSFCSelection:                    proc "system" (this: ^FactoryIF, NrOfBranches: i32, SFCSelection: ^rawptr) -> HResult,
    NewSFCSimultaneous:                 proc "system" (this: ^FactoryIF, NrOfBranches: i32, SFCSimultaneous: ^rawptr) -> HResult,
    NewSFCSubSequence:                  proc "system" (this: ^FactoryIF, NrOfBranches: i32, SFCSubSequence: ^rawptr) -> HResult,
    NewILCodeBlock:                     proc "system" (this: ^FactoryIF, Name: BStr, ILCodeBlock: ^rawptr) -> HResult,
    NewILRow:                           proc "system" (this: ^FactoryIF, Label, Instruction, Operand, Description: BStr, ILRow: ^rawptr) -> HResult,
    NewILComment:                       proc "system" (this: ^FactoryIF, ILRowComment: BStr, ILRow: ^rawptr) -> HResult,
    NewVANamedProtocol:                 proc "system" (this: ^FactoryIF, Name: BStr, VANamedProtocol: ^rawptr) -> HResult,
    NewVAAddressedProtocol:             proc "system" (this: ^FactoryIF, Name: BStr, VAAddressedProtocol: ^rawptr) -> HResult,
    NewVANamedVariable:                 proc "system" (this: ^FactoryIF, Name, Path: BStr, VANamedVariable: ^rawptr) -> HResult,
    NewVANamedVariable1:                proc "system" (this: ^FactoryIF, Name, Path, VAAttribute: BStr, row: i32, VANamedVariable: ^rawptr) -> HResult,
    NewVAAddressedVariable:             proc "system" (this: ^FactoryIF, Name, Path: BStr, VAAddressedVariable: ^rawptr) -> HResult,
    NewVAAddressedVariable1:            proc "system" (this: ^FactoryIF, Name, Path: BStr, row: i32, VAAddressedVariable: ^rawptr) -> HResult,
    NewAccessVariables:                 proc "system" (this: ^FactoryIF, AccessVariables: ^rawptr) -> HResult,
    DeserializeAccessVariables:         proc "system" (this: ^FactoryIF, XMLStr: ^BStr, AccessVariables: ^rawptr) -> HResult,
    NewProjectConstants:                proc "system" (this: ^FactoryIF, ProjectConstants: ^rawptr) -> HResult,
    DeserializeProjectConstants:        proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ProjectConstants: ^rawptr) -> HResult,
    NewProjectConstant:                 proc "system" (this: ^FactoryIF, Name, Type, Value: BStr, ProjectConstants: ^rawptr) -> HResult,
    DeserializeMessageBucket:           proc "system" (this: ^FactoryIF, XMLStr: ^BStr, MessageBucket: ^rawptr) -> HResult,
    DeserializeApplicationProperties:   proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ApplicationProperties: ^rawptr) -> HResult,
    NewApplicationProperties:           proc "system" (this: ^FactoryIF, SILLevel: BStr, SimulationMark: VariantBool, ApplicationProperties: ^rawptr) -> HResult,
    DeserializeConnectedHWLibraries:    proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ConnectedHWLibraries: ^rawptr) -> HResult,
    NewConnectedHWLibrary:              proc "system" (this: ^FactoryIF, Name: BStr, ConnectedHWLibrary: ^rawptr) -> HResult,
    NewConnectedHWLibrary1:             proc "system" (this: ^FactoryIF, Name: BStr, MajorVersion, MinorVersion, Revision: i32, ConnectedHWLibrary: ^rawptr) -> HResult,
    NewConnectedHWLibraries:            proc "system" (this: ^FactoryIF, ConnectedHWLibraries: ^rawptr) -> HResult,
    NewHWUnit2:                         proc "system" (this: ^FactoryIF, Path, TypeID, TypeDescription, Guid, type_guid: BStr, HWUnit: ^rawptr) -> HResult,
    DeserializeCommVariable:            proc "system" (this: ^FactoryIF, XMLStr: ^BStr, CommVariable: ^rawptr) -> HResult,
    NewCommVariable:                    proc "system" (this: ^FactoryIF, Name, Type, Direction: BStr, CommVariable: ^rawptr) -> HResult,
    NewCommVariable1:                   proc "system" (this: ^FactoryIF, Name, Type, Direction, Attribute, InitialValue, ISPValue, Priority, IntervalTime, ReadPermission, Description: BStr, CommVariable: ^rawptr) -> HResult,
    NewInitValue:                       proc "system" (this: ^FactoryIF, POUPath, Name, Value: BStr, InitValue: ^rawptr) -> HResult,
    DeserializeDiagram:                 proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Diagram: ^rawptr) -> HResult,
    NewDiagram:                         proc "system" (this: ^FactoryIF, Name, Description: BStr, Diagram: ^rawptr) -> HResult,
    NewDiagram1:                        proc "system" (this: ^FactoryIF, Name, Description, Task, Guid, InstGuid: BStr, Diagram: ^rawptr) -> HResult,
    DeserializeExecutionOrder:          proc "system" (this: ^FactoryIF, XMLStr: ^BStr, ExecutionOrder: ^rawptr) -> HResult,
    NewExecutionOrder:                  proc "system" (this: ^FactoryIF, ExecutionOrder: ^rawptr) -> HResult,
    NewExecutionInstance:               proc "system" (this: ^FactoryIF, Name: BStr, ExecutionInstance: ^rawptr) -> HResult,
    DeserializeDiagramType:             proc "system" (this: ^FactoryIF, XMLStr: ^BStr, DiagramType: ^rawptr) -> HResult,
    NewDiagramType:                     proc "system" (this: ^FactoryIF, Name, Description: BStr, DiagramType: ^rawptr) -> HResult,
    NewDiagramType1:                    proc "system" (this: ^FactoryIF, Name, Description: BStr, Protected, Hidden: VariantBool, Scope: Scope, AlarmOwner: VariantBool, Guid: BStr, DiagramType: ^rawptr) -> HResult,
    DeserializeDiagramInstance:         proc "system" (this: ^FactoryIF, XMLStr: ^BStr, DiagramInstance: ^rawptr) -> HResult,
    NewDiagramInstance:                 proc "system" (this: ^FactoryIF, Name, Type: BStr, _DiagramInstance: ^rawptr) -> HResult,
    NewDiagramInstance1:                proc "system" (this: ^FactoryIF, Name, Type, Guid, Description: BStr, _DiagramInstance: ^rawptr) -> HResult,
    DeserializeSignal:                  proc "system" (this: ^FactoryIF, XMLStr: ^BStr, Signal: ^Signal) -> HResult,
    NewSignal:                          proc "system" (this: ^FactoryIF, Name, Path, Direction: BStr, AcknowledgeGroup: Variant, Signal: ^Signal) -> HResult,
}

factory_connect :: proc() -> (ok: bool) {

    if factoryif != nil do return true

    hr := windows.CoInitializeEx(nil, .APARTMENTTHREADED)
    if failed(hr) {
        fmt.printf("CoInitializeEx failed: 0x%08X\n", u32(hr))
        return false
    }

    clsid := &GUID{
        0x3CEFCA96,
        0x1892,
        0x4539,
        {0x87, 0x47, 0x29, 0x2B, 0xB8, 0xAE, 0x1D, 0x4B},
    }

    iid := &GUID{
        0x9198E466,
        0x81F5,
        0x4756,
        {0xB3, 0x9A, 0x12, 0xC7, 0x7F, 0xF5, 0xFF, 0x1A},
    }

    hr = windows.CoCreateInstance(
        clsid,
        nil,
        windows.CLSCTX_ALL,
        iid,
        cast(^rawptr)&factoryif,
    )
    if failed(hr) {
        fmt.printf("CoCreateInstance failed: 0x%08X\n", u32(hr))
        windows.CoUninitialize()
        factoryif = nil
        return false
    }
    return true
}

factory_disconnect :: proc()  -> (ok: bool) {
    if factoryif != nil {
        factoryif->Release()
        factoryif = nil
    }
    windows.CoUninitialize()
    return true
}