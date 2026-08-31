package com

cbopenif: ^CBOpenIF

CBOpenIF :: struct #raw_union
{
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CBOpenVTable,
}

CBOpenVTable :: struct
{
    using iunknownvtable: IUnknownVTable,
    NewProject:                          proc "system" (this: ^CBOpenIF, ProjectName, DirectoryPath, GUID, TemplateName: BStr) -> HResult,
    OpenProject:                         proc "system" (this: ^CBOpenIF, FilePath: BStr) -> HResult,
    CloseProject:                        proc "system" (this: ^CBOpenIF) -> HResult,
    GetProjectConstants:                 proc "system" (this: ^CBOpenIF, Constants: ^BStr) -> HResult,
    SetProjectConstants:                 proc "system" (this: ^CBOpenIF, Constants: BStr, Messages: ^BStr) -> HResult,
    NewLibrary:                          proc "system" (this: ^CBOpenIF, LibraryName, DirectoryPath, GUID: BStr) -> HResult,
    InsertLibrary:                       proc "system" (this: ^CBOpenIF, FilePath: BStr) -> HResult,
    RenameLibrary:                       proc "system" (this: ^CBOpenIF, LibraryName, NewLibraryName: BStr) -> HResult,
    DeleteLibrary:                       proc "system" (this: ^CBOpenIF, LibraryName: BStr) -> HResult,
    GetLibraryProjectConstants:          proc "system" (this: ^CBOpenIF, LibraryName: BStr, Constants: ^BStr) -> HResult,
    SetLibraryProjectConstants:          proc "system" (this: ^CBOpenIF, LibraryName, Constants: BStr, Messages: ^BStr) -> HResult,
    NewApplication:                      proc "system" (this: ^CBOpenIF, ApplicationName, DirectoryPath, GUID, TemplateName: BStr) -> HResult,
    InsertApplication:                   proc "system" (this: ^CBOpenIF, FilePath: BStr) -> HResult,
    RenameApplication:                   proc "system" (this: ^CBOpenIF, ApplicationName, NewApplicationName: BStr) -> HResult,
    DeleteApplication:                   proc "system" (this: ^CBOpenIF, ApplicationName: BStr) -> HResult,
    GetApplicationVariables:             proc "system" (this: ^CBOpenIF, ApplicationName: BStr, Variables: ^BStr) -> HResult,
    SetApplicationVariables:             proc "system" (this: ^CBOpenIF, ApplicationName, Variables: BStr, Messages: ^BStr) -> HResult,
    GetTaskConnection:                   proc "system" (this: ^CBOpenIF, ObjectPath: BStr, TaskConnection: ^BStr) -> HResult,
    SetTaskConnection:                   proc "system" (this: ^CBOpenIF, ObjectPath, TaskConnection: BStr) -> HResult,
    NewController:                       proc "system" (this: ^CBOpenIF, ControllerName, ControllerType, DirectoryPath, GUID, TemplateName: BStr) -> HResult,
    InsertController:                    proc "system" (this: ^CBOpenIF, FilePath: BStr) -> HResult,
    RenameController:                    proc "system" (this: ^CBOpenIF, ControllerName, NewControllerName: BStr) -> HResult,
    DeleteController:                    proc "system" (this: ^CBOpenIF, ControllerName: BStr) -> HResult,
    GetSystemIdentity:                   proc "system" (this: ^CBOpenIF, ControllerName: BStr, SystemIdentity: ^BStr) -> HResult,
    SetSystemIdentity:                   proc "system" (this: ^CBOpenIF, ControllerName, SystemIdentity: BStr) -> HResult,
    NewDataType:                         proc "system" (this: ^CBOpenIF, DataTypeName, AppOrLibraryName, DataTypeContent: BStr, Messages: ^BStr) -> HResult,
    GetDataType:                         proc "system" (this: ^CBOpenIF, DataTypePath: BStr, DataTypeContent: ^BStr) -> HResult,
    SetDataType:                         proc "system" (this: ^CBOpenIF, DataTypePath, DataTypeContent: BStr, Messages: ^BStr) -> HResult,
    DeleteDataType:                      proc "system" (this: ^CBOpenIF, DataTypePath: BStr) -> HResult,
    NewFunctionBlockType:                proc "system" (this: ^CBOpenIF, FunctionBlockTypeName, AppOrLibraryName, FunctionBlockTypeContent: BStr, Messages: ^BStr) -> HResult,
    GetFunctionBlockType:                proc "system" (this: ^CBOpenIF, FunctionBlockTypePath: BStr, Content: ^BStr) -> HResult,
    SetFunctionBlockType:                proc "system" (this: ^CBOpenIF, FunctionBlockTypePath, FunctionBlockTypeContent: BStr, Messages: ^BStr) -> HResult,
    DeleteFunctionBlockType:             proc "system" (this: ^CBOpenIF, FunctionBlockTypePath: BStr) -> HResult,
    NewControlModuleType:                proc "system" (this: ^CBOpenIF, ControlModuelTypeName, AppOrLibraryName, ControlModuelTypeContent: BStr, Messages: ^BStr) -> HResult,
    GetControlModuleType:                proc "system" (this: ^CBOpenIF, ControlModuelTypePath: BStr, ControlModuelTypeContent: ^BStr) -> HResult,
    SetControlModuleType:                proc "system" (this: ^CBOpenIF, ControlModuelTypePath, ControlModuelTypeContent: BStr, Messages: ^BStr) -> HResult,
    DeleteControlModuleType:             proc "system" (this: ^CBOpenIF, ControlModuelTypePath: BStr) -> HResult,
    NewControlModule:                    proc "system" (this: ^CBOpenIF, ControlModuleName, ControlModuleType, PathToParent, ControlModuleContent: BStr, Messages: ^BStr) -> HResult,
    NewSingleControlModule:              proc "system" (this: ^CBOpenIF, ControlModuleName, PathToParent, ControlModuleContent: BStr, Messages: ^BStr) -> HResult,
    GetControlModule:                    proc "system" (this: ^CBOpenIF, ControlModulePath: BStr, ControlModuleContent: ^BStr) -> HResult,
    SetControlModule:                    proc "system" (this: ^CBOpenIF, ControlModulePath, ControlModuleContent: BStr, Messages: ^BStr) -> HResult,
    DeleteControlModule:                 proc "system" (this: ^CBOpenIF, ControlModulePath: BStr) -> HResult,
    NewProgram:                          proc "system" (this: ^CBOpenIF, ProgramName, ApplicationName, ProgramContent: BStr, Messages: ^BStr) -> HResult,
    GetProgram:                          proc "system" (this: ^CBOpenIF, ProgramPath: BStr, ProgramContent: ^BStr) -> HResult,
    SetProgram:                          proc "system" (this: ^CBOpenIF, ProgramPath, ProgramContent: BStr, Messages: ^BStr) -> HResult,
    DeleteProgram:                       proc "system" (this: ^CBOpenIF, ProgramPath: BStr) -> HResult,
    GetAccessVariables:                  proc "system" (this: ^CBOpenIF, ControllerName: BStr, AccessVariableContent: ^BStr) -> HResult,
    SetAccessVariables:                  proc "system" (this: ^CBOpenIF, ControllerName, AccessVariableContent: BStr, Messages: ^BStr) -> HResult,
    NewTask:                             proc "system" (this: ^CBOpenIF, TaskName, ControllerName, TaskContent: BStr) -> HResult,
    GetTask:                             proc "system" (this: ^CBOpenIF, TaskPath: BStr, TaskContent: ^BStr) -> HResult,
    SetTask:                             proc "system" (this: ^CBOpenIF, TaskPath, TaskContent: BStr) -> HResult,
    DeleteTask:                          proc "system" (this: ^CBOpenIF, TaskPath: BStr) -> HResult,
    GetConnectedApplications:            proc "system" (this: ^CBOpenIF, ControllerName: BStr, ConnectedApplicationsContent: ^BStr) -> HResult,
    SetConnectedApplications:            proc "system" (this: ^CBOpenIF, ControllerName, ConnectedApplicationsContent: BStr, Messages: ^BStr) -> HResult,
    Online:                              proc "system" (this: ^CBOpenIF, IsOnline: ^VariantBool, Messages: ^BStr) -> HResult,
    DownloadAndGoOnline:                 proc "system" (this: ^CBOpenIF, IsOnline: ^VariantBool, Messages: ^BStr) -> HResult,
    TestMode:                            proc "system" (this: ^CBOpenIF, IsTestMode: ^VariantBool, Messages: ^BStr) -> HResult,
    Offline:                             proc "system" (this: ^CBOpenIF, Messages: ^BStr) -> HResult,
    NewHardwareUnit:                     proc "system" (this: ^CBOpenIF, HwPath: BStr, HwTypeID: Variant, HwQualifier, HwUnitContent, RedundantTo: BStr, Messages: ^BStr) -> HResult,
    GetHardwareUnit:                     proc "system" (this: ^CBOpenIF, HwPath: BStr, IncludeSubUnits: VariantBool, HwUnitContent: ^BStr) -> HResult,
    GetHardwareType:                     proc "system" (this: ^CBOpenIF, HarwareLibraryName, HarwareLibraryTypeNmae: BStr, HarwareTypeContent: ^BStr) -> HResult,
    SetHardwareUnit:                     proc "system" (this: ^CBOpenIF, HwPath, HwUnitContent: BStr, Messages: ^BStr) -> HResult,
    DeleteHardwareUnit:                  proc "system" (this: ^CBOpenIF, HwPath: BStr, RemoveRedundantOnly: VariantBool) -> HResult,
    MoveHardwareUnitTo:                  proc "system" (this: ^CBOpenIF, HwPath, NewHwPath: BStr, DoSwap: VariantBool) -> HResult,
    GetProjectTree:                      proc "system" (this: ^CBOpenIF, Path: BStr, Depth: i32, IncludeRuntimeInstances: VariantBool, ProjectTreeContent: ^BStr) -> HResult,
    NewFunctionBlock:                    proc "system" (this: ^CBOpenIF, FunctionBlockName, FunctionBlockType, PathToParent, FunctionBlockContent: BStr, Messages: ^BStr) -> HResult,
    GetFunctionBlock:                    proc "system" (this: ^CBOpenIF, FunctionBlockPath: BStr, FunctionBlockContent: ^BStr) -> HResult,
    SetFunctionBlock:                    proc "system" (this: ^CBOpenIF, FunctionBlockPath, FunctionBlockContent: BStr, Messages: ^BStr) -> HResult,
    DeleteFunctionBlock:                 proc "system" (this: ^CBOpenIF, FunctionBlockPath: BStr) -> HResult,
    Reserve:                             proc "system" (this: ^CBOpenIF, FOUName: BStr) -> HResult,
    IsReservedBy:                        proc "system" (this: ^CBOpenIF, FOUName: BStr, Reserver: ^BStr) -> HResult,
    ReleaseReservation:                  proc "system" (this: ^CBOpenIF, FOUName: BStr) -> HResult,
    GetSetting:                          proc "system" (this: ^CBOpenIF, SettingName: BStr, Value: ^Variant) -> HResult,
    SetSetting:                          proc "system" (this: ^CBOpenIF, SettingName: BStr, Value: Variant) -> HResult,
    GetApplicationControlModules:        proc "system" (this: ^CBOpenIF, ApplicationName: BStr, ApplicationControlModulesContent: ^BStr) -> HResult,
    SetApplicationControlModules:        proc "system" (this: ^CBOpenIF, ApplicationName, ApplicationControlModulesContent: BStr, Messages: ^BStr) -> HResult,
    NewParameter:                        proc "system" (this: ^CBOpenIF, CBOpenIFParameterType: i32, ParameterName, DataType, PathToParent, ParameterContent: BStr, Messages: ^BStr) -> HResult,
    GetParameter:                        proc "system" (this: ^CBOpenIF, CBOpenIFParameterType: i32, ParameterPath: BStr, ParameterContent: ^BStr) -> HResult,
    SetParameter:                        proc "system" (this: ^CBOpenIF, CBOpenIFParameterType: i32, ParameterPath, ParameterContent: BStr, Messages: ^BStr) -> HResult,
    DeleteParameter:                     proc "system" (this: ^CBOpenIF, CBOpenIFParameterType: i32, ParameterPath: BStr) -> HResult,
    NewVariable:                         proc "system" (this: ^CBOpenIF, CBOpenIFVariableType: i32, VariableName, DataType, PathToParent, VariableContent: BStr, Messages: ^BStr) -> HResult,
    GetVariable:                         proc "system" (this: ^CBOpenIF, CBOpenIFVariableType: i32, VariablePath: BStr, VariableContent: ^BStr) -> HResult,
    SetVariable:                         proc "system" (this: ^CBOpenIF, CBOpenIFVariableType: i32, VariablePath, VariableContent: BStr, Messages: ^BStr) -> HResult,
    DeleteVariable:                      proc "system" (this: ^CBOpenIF, CBOpenIFVariableType: i32, VariablePath: BStr) -> HResult,
    GetCMConnection:                     proc "system" (this: ^CBOpenIF, ConnectionPath: BStr, ConnectionContent: ^BStr) -> HResult,
    SetCMConnection:                     proc "system" (this: ^CBOpenIF, ConnectionPath, ConnectionContent: BStr, Messages: ^BStr) -> HResult,
    NewCodeBlock:                        proc "system" (this: ^CBOpenIF, CBOpenIFCodeBlockType: i32, CodeBlockName, PathToParent, CodeBlockContent: BStr, Messages: ^BStr) -> HResult,
    GetCodeBlock:                        proc "system" (this: ^CBOpenIF, CodeBlockPath: BStr, CodeBlockContent: ^BStr) -> HResult,
    SetCodeBlock:                        proc "system" (this: ^CBOpenIF, CodeBlockPath, CodeBlockContent: BStr, Messages: ^BStr) -> HResult,
    DeleteCodeBlock:                     proc "system" (this: ^CBOpenIF, CodeBlockPath: BStr) -> HResult,
    GetOneInstanceInitVals:              proc "system" (this: ^CBOpenIF, InstacePath: BStr, InitValsContent: ^BStr) -> HResult,
    GetAllInstancesInitVals:             proc "system" (this: ^CBOpenIF, PathToParent: BStr, InitValsContent: ^BStr) -> HResult,
    SetOneInstanceInitVals:              proc "system" (this: ^CBOpenIF, InstancePath, InitValsContent: BStr, Messages: ^BStr) -> HResult,
    SetAllInstancesInitVals:             proc "system" (this: ^CBOpenIF, PathToParent, InitValsContent: BStr, Messages: ^BStr) -> HResult,
    DeleteOneInstanceInitVals:           proc "system" (this: ^CBOpenIF, InstancePath: BStr) -> HResult,
    DeleteAllInstancesInitVals:          proc "system" (this: ^CBOpenIF, PathToParent: BStr) -> HResult,
    RenameInstanceDataPath:              proc "system" (this: ^CBOpenIF, InstancePath, NewInstancePath: BStr) -> HResult,
    RenameDataType:                      proc "system" (this: ^CBOpenIF, DataTypePath, NewDataTypeName: BStr) -> HResult,
    RenameFunctionBlockType:             proc "system" (this: ^CBOpenIF, FunctionBlockTypePath, NewFunctionBlockTypeName: BStr) -> HResult,
    RenameControlModuleType:             proc "system" (this: ^CBOpenIF, ControlModuleTypePath, NewControlModuleTypeName: BStr) -> HResult,
    GetSingleControlModule:              proc "system" (this: ^CBOpenIF, SingleControlModulePath: BStr, SingleControlModuleContent: ^BStr) -> HResult,
    SetSingleControlModule:              proc "system" (this: ^CBOpenIF, SingleControlModulePath, SingleControlModuleContent: BStr, Messages: ^BStr) -> HResult,
    DeleteSingleControlModule:           proc "system" (this: ^CBOpenIF, SingleControlModulePath: BStr) -> HResult,
    GetConnectedLibraries:               proc "system" (this: ^CBOpenIF, AppOrLibraryName: BStr, ConnectedLibrariesContent: ^BStr) -> HResult,
    SetConnectedLibraries:               proc "system" (this: ^CBOpenIF, AppOrLibraryName, ConnectedLibrariesContent: BStr, Messages: ^BStr) -> HResult,
    SetLibraryVersion:                   proc "system" (this: ^CBOpenIF, LibraryName: BStr, MajorVersion, MinorVersion, Revision: i32) -> HResult,
    SetApplicationVersion:               proc "system" (this: ^CBOpenIF, ApplicationName: BStr, MajorVersion, MinorVersion, Revision: i32) -> HResult,
    SetControllerVersion:                proc "system" (this: ^CBOpenIF, ControllerName: BStr, MajorVersion, MinorVersion, Revision: i32) -> HResult,
    GetLibraryState:                     proc "system" (this: ^CBOpenIF, LibraryName: BStr, libraryState: ^BStr) -> HResult,
    SetLibraryState:                     proc "system" (this: ^CBOpenIF, LibraryName, libraryState: BStr) -> HResult,
    ConnectLibrary:                      proc "system" (this: ^CBOpenIF, AppOrLibraryName, LibraryName: BStr) -> HResult,
    DisconnectLibrary:                   proc "system" (this: ^CBOpenIF, AppOrLibraryName, LibraryName: BStr) -> HResult,
    GetControllerProperties:             proc "system" (this: ^CBOpenIF, ControllerName: BStr, PropertiesContent: ^BStr) -> HResult,
    SetControllerProperties:             proc "system" (this: ^CBOpenIF, ControllerName, PropertiesContent: BStr) -> HResult,
    GetTypePathFromGUID:                 proc "system" (this: ^CBOpenIF, AppOrLibraryName, GUID: BStr, TypePath: ^BStr) -> HResult,
    RenameProgram:                       proc "system" (this: ^CBOpenIF, ProgramPath, NewProgramName: BStr) -> HResult,
    RenameFunctionBlock:                 proc "system" (this: ^CBOpenIF, FunctionBlockPath, NewFunctionBlockName: BStr) -> HResult,
    RenameControlModule:                 proc "system" (this: ^CBOpenIF, ControlModulePath, NewControlModuleName: BStr) -> HResult,
    RenameTask:                          proc "system" (this: ^CBOpenIF, TaskPath, NewTaskName: BStr) -> HResult,
    RefreshProject:                      proc "system" (this: ^CBOpenIF) -> HResult,
    RefreshLibrary:                      proc "system" (this: ^CBOpenIF, LibraryName: BStr) -> HResult,
    RefreshApplication:                  proc "system" (this: ^CBOpenIF, ApplicationName: BStr) -> HResult,
    RefreshController:                   proc "system" (this: ^CBOpenIF, ControllerName: BStr) -> HResult,
    ReplaceHardwareUnitType:             proc "system" (this: ^CBOpenIF, HwPath: BStr, HwTypeId: Variant, HwQualifier: BStr) -> HResult,
    GetValidHardwarePositions:           proc "system" (this: ^CBOpenIF, HwFatherPath: BStr, HwTypeId: Variant, HwQualifier: BStr, Positions: ^BStr) -> HResult,
    InsertDataType:                      proc "system" (this: ^CBOpenIF, DataTypeName, AppOrLibraryName, GUID: BStr) -> HResult,
    InsertFunctionBlockType:             proc "system" (this: ^CBOpenIF, FunctionBlockName, AppOrLibraryName, GUID: BStr) -> HResult,
    InsertControlModuleType:             proc "system" (this: ^CBOpenIF, ControlModuleTypeName, AppOrLibraryName, GUID: BStr) -> HResult,
    InsertProgram:                       proc "system" (this: ^CBOpenIF, ProgramName, ApplicationName, GUID: BStr) -> HResult,
    InsertSingleControlModule:           proc "system" (this: ^CBOpenIF, ModuleName, PathToParent, GUID: BStr) -> HResult,
    GetApplicationProperties:            proc "system" (this: ^CBOpenIF, ApplicationName: BStr, PropertiesContent: ^BStr) -> HResult,
    SetApplicationProperties:            proc "system" (this: ^CBOpenIF, ApplicationName, PropertiesContent: BStr) -> HResult,
    NewHardwareLibrary:                  proc "system" (this: ^CBOpenIF, HardwareLibraryName, DirectoryPath, GUID: BStr) -> HResult,
    InsertHardwareLibrary:               proc "system" (this: ^CBOpenIF, FilePath: BStr) -> HResult,
    DeleteHardwareLibrary:               proc "system" (this: ^CBOpenIF, HardwareLibraryName: BStr) -> HResult,
    ConnectHardwareLibrary:              proc "system" (this: ^CBOpenIF, ControllerName, HardwareLibrary: BStr) -> HResult,
    DisconnectHardwareLibrary:           proc "system" (this: ^CBOpenIF, ControllerName, HardwareLibrary: BStr) -> HResult,
    GetHardwareLibraryState:             proc "system" (this: ^CBOpenIF, HardwareLibraryName: BStr, LibraryState: ^BStr) -> HResult,
    SetHardwareLibraryState:             proc "system" (this: ^CBOpenIF, HardwareLibraryName, state: BStr) -> HResult,
    SetHardwareLibraryVersion:           proc "system" (this: ^CBOpenIF, HardwareLibraryName: BStr, MajorVersion, MinorVersion, Revision: i32) -> HResult,
    CopyHardwareType:                    proc "system" (this: ^CBOpenIF, SourceHardwareLibraryName, SourceHardwareTypeGUID, DestinationHardwareLibraryName, DestinationHardwareTypeGUID: BStr) -> HResult,
    DeleteHardwareType:                  proc "system" (this: ^CBOpenIF, HardwareLibraryName, Type_Name: BStr) -> HResult,
    GetConnectedHardwareLibraries:       proc "system" (this: ^CBOpenIF, ControllerName: BStr, ConnectedHardwareLibrariesContent: ^BStr) -> HResult,
    SetConnectedHardwareLibraries:       proc "system" (this: ^CBOpenIF, ControllerName, ConnectedHardwareLibrariesContent: BStr, Messages: ^BStr) -> HResult,
    CopyHardwareLibrary:                 proc "system" (this: ^CBOpenIF, SourceHardwareLibraryName, DestinationHardwareLibraryName, DestinationHardwareLibraryGUID: BStr) -> HResult,
    RefreshHardwareLibrary:              proc "system" (this: ^CBOpenIF, Name: BStr) -> HResult,
    ReplaceConnectedHardwareLibrary:     proc "system" (this: ^CBOpenIF, ControllerName, ConnectedHardwareLibraryName, replacingHardwareLibraryName: BStr) -> HResult,
    AddHardwareTypeFile:                 proc "system" (this: ^CBOpenIF, HardwareLibraryName, hardwareTypeGUID: BStr, FileType: i32, FilePath, Version, BuildVersion, BuildDate, FwName: BStr) -> HResult,
    InsertHardwareType:                  proc "system" (this: ^CBOpenIF, HardwareTypeName, HardwareLibraryName, HardwareTypeGUID, HardwareTypeID: BStr) -> HResult,
    ReplaceConnectedLibrary:             proc "system" (this: ^CBOpenIF, AppOrLibraryName, ConnectedLibraryName, ReplacingLibraryName: BStr) -> HResult,
    NewProjectInEnvironment:             proc "system" (this: ^CBOpenIF, ProjectName, GUID, RemplateName, EnvironmentGUIDOrName: BStr) -> HResult,
    OpenProjectInEnvironment:            proc "system" (this: ^CBOpenIF, ProjectGUIDOrName, EnvironmentGUIDOrName: BStr) -> HResult,
    RenameHardwareLibrary:               proc "system" (this: ^CBOpenIF, HardwareLibraryName, NewHardwareLibraryName: BStr) -> HResult,
    GetProjectAndEnvironmentInformation: proc "system" (this: ^CBOpenIF, ProjectName, ProjectGUID, EnvironmentName, EnvironmentGUID: ^BStr) -> HResult,
    SetStorage:                          proc "system" (this: ^CBOpenIF, pIAcStorage: rawptr) -> HResult,
    WriteInformation:                    proc "system" (this: ^CBOpenIF, Message: BStr) -> HResult,
    WriteWarning:                        proc "system" (this: ^CBOpenIF, Message: BStr) -> HResult,
    WriteError:                          proc "system" (this: ^CBOpenIF, Message: BStr) -> HResult,
    NewFolder:                           proc "system" (this: ^CBOpenIF, CBOpenIFFolderType: i32, FolderName, PathToParentFolder, GUID: BStr) -> HResult,
    RenameFolder:                        proc "system" (this: ^CBOpenIF, CBOpenIFFolderType: i32, FolderPath, NewFolderName: BStr) -> HResult,
    DeleteFolder:                        proc "system" (this: ^CBOpenIF, CBOpenIFFolderType: i32, FolderPath: BStr) -> HResult,
    MoveFolder:                          proc "system" (this: ^CBOpenIF, CBOpenIFFolderType: i32, FolderPath, DestinationFolderPath: BStr) -> HResult,
    MoveFolderObject:                    proc "system" (this: ^CBOpenIF, CBOpenIFFolderType: i32, ObjectName, DestinationFolderPath: BStr) -> HResult,
    NewDiagram:                          proc "system" (this: ^CBOpenIF, DiagramName, ApplicationName, DiagramContent: BStr, Messages: ^BStr) -> HResult,
    GetDiagram:                          proc "system" (this: ^CBOpenIF, DiagramPath: BStr, DiagramContent: ^BStr) -> HResult,
    SetDiagram:                          proc "system" (this: ^CBOpenIF, DiagramPath, DiagramContent: BStr, Messages: ^BStr) -> HResult,
    DeleteDiagram:                       proc "system" (this: ^CBOpenIF, DiagramPath: BStr) -> HResult,
    RenameDiagram:                       proc "system" (this: ^CBOpenIF, DiagramPath, newDiagramName: BStr) -> HResult,
    InsertDiagram:                       proc "system" (this: ^CBOpenIF, DiagramName, ApplicationName, GUID: BStr) -> HResult,
    InsertHardwareDefinitionFile:        proc "system" (this: ^CBOpenIF, HardwareLibraryName, FilePath: BStr, fileAdded: ^VariantBool, Messages: ^BStr) -> HResult,
    GetExecutionOrder:                   proc "system" (this: ^CBOpenIF, CBOpenIFExecutionInstanceType: i32, ApplicationName: BStr, ExecutionOrderContent: ^BStr) -> HResult,
    SetExecutionOrder:                   proc "system" (this: ^CBOpenIF, CBOpenIFExecutionInstanceType: i32, ApplicationName, ExecutionOrderContent: BStr, Messages: ^BStr) -> HResult,
    NewDiagramType:                      proc "system" (this: ^CBOpenIF, DiagramTypeName, AppOrLibraryName, Content: BStr, Messages: ^BStr) -> HResult,
    GetDiagramType:                      proc "system" (this: ^CBOpenIF, DiagramTypePath: BStr, DiagramTypeContent: ^BStr) -> HResult,
    SetDiagramType:                      proc "system" (this: ^CBOpenIF, DiagramTypePath, DiagramTypeContent: BStr, Messages: ^BStr) -> HResult,
    DeleteDiagramType:                   proc "system" (this: ^CBOpenIF, DiagramTypePath: BStr) -> HResult,
    RenameDiagramType:                   proc "system" (this: ^CBOpenIF, DiagramTypePath, NewDiagramTypeName: BStr) -> HResult,
    InsertDiagramType:                   proc "system" (this: ^CBOpenIF, DiagramTypeName, AppOrLibraryName, GUID: BStr) -> HResult,
    NewDiagramInstance:                  proc "system" (this: ^CBOpenIF, DiagramInstanceName, DiagramType, PathToParent, DiagramInstanceContent: BStr, Messages: ^BStr) -> HResult,
    GetDiagramInstance:                  proc "system" (this: ^CBOpenIF, DiagramInstancePath: BStr, DiagramInstanceContent: ^BStr) -> HResult,
    SetDiagramInstance:                  proc "system" (this: ^CBOpenIF, DiagramInstancePath, DiagramInstanceContent: BStr, Messages: ^BStr) -> HResult,
    DeleteDiagramInstance:               proc "system" (this: ^CBOpenIF, DiagramInstancePath: BStr) -> HResult,
    RenameDiagramInstance:               proc "system" (this: ^CBOpenIF, DiagramInstancePath, NewDiagramInstanceName: BStr) -> HResult,
    NewSignal:                           proc "system" (this: ^CBOpenIF, CBOpenIFSignalType: i32, SignalName, PathToParent, SignalContent: BStr, Messages: ^BStr) -> HResult,
    GetSignal:                           proc "system" (this: ^CBOpenIF, CBOpenIFSignalType: i32, SignalName, PathToParent: BStr, SignalContent: ^BStr) -> HResult,
    SetSignal:                           proc "system" (this: ^CBOpenIF, CBOpenIFSignalType: i32, SignalName, PathToParent, SignalContent: BStr, Messages: ^BStr) -> HResult,
    DeleteSignal:                        proc "system" (this: ^CBOpenIF, CBOpenIFSignalType: i32, SignalName, PathToParent: BStr) -> HResult,
    AddHardwareLibraryFile:              proc "system" (this: ^CBOpenIF, HardwareLibraryName: BStr, CBOpenIFHardwareLibraryFileType: i32, FilePath, Version: BStr) -> HResult,
    GetHardwareLibraryFiles:             proc "system" (this: ^CBOpenIF, HardwareLibraryName: BStr, HardwareLibraryFiles: ^BStr) -> HResult,
    DeleteHardwareLibraryFile:           proc "system" (this: ^CBOpenIF, HardwareLibraryName: BStr, CBOpenIFHardwareLibraryFileType: i32, FileName: BStr) -> HResult,
    SetHardwareType:                     proc "system" (this: ^CBOpenIF, HardwareLibraryName, HardwareTypeName, HardwareTypeNameContent: BStr, Messages: ^BStr) -> HResult,
    GetHardwareDefinitionInfo:           proc "system" (this: ^CBOpenIF, HardwareLibraryName, HardwareTypeName: BStr, HwdInfoContent: ^BStr) -> HResult,
    InsertHardwareUnit:                  proc "system" (this: ^CBOpenIF, ParentHwPath, GUID: BStr) -> HResult,
    GetControllerSettings:               proc "system" (this: ^CBOpenIF, ControllerName: BStr, ControllerSettings: ^BStr) -> HResult,
    SetControllerSettings:               proc "system" (this: ^CBOpenIF, ControllerName, ControllerSettings: BStr) -> HResult,
    GetFDConnection:                     proc "system" (this: ^CBOpenIF, ConnectionPath: BStr, ConnectionContent: ^BStr) -> HResult,
    SetFDConnection:                     proc "system" (this: ^CBOpenIF, ConnectionPath, ConnectionContent: BStr, Messages: ^BStr) -> HResult,
    ListAvailableLibraries:              proc "system" (this: ^CBOpenIF, Libraries: ^BStr) -> HResult,
    ListAvailableHardwareLibraries:      proc "system" (this: ^CBOpenIF, HardwareLibraries: ^BStr) -> HResult,
    LoopCheckDownloadAndGoOnline:        proc "system" (this: ^CBOpenIF, IsOnline: ^VariantBool, Messages: ^BStr) -> HResult,
}

NewProject :: proc(project_name, directory_path, guid, template_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_project        := ToBstr(project_name)
    bstr_directory_path := ToBstr(directory_path)
    bstr_guid           := ToBstr(guid)
    bstr_template       := ToBstr(template_name)
    defer {
        FreeBstr(bstr_project)
        FreeBstr(bstr_directory_path)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_template)
    }
    hr := cbopenif->NewProject(bstr_project, bstr_directory_path, bstr_guid, bstr_template)
    if !ComFailed(hr) do return

    return true
}

OpenProject :: proc(file_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_file_path := ToBstr(file_path)
    defer FreeBstr(bstr_file_path)
    hr := cbopenif->OpenProject(bstr_file_path)
    if !ComFailed(hr) do return

    return true
}

CloseProject :: proc() -> (ok: bool)
{
    if !ComConnected() do return
    
    hr := cbopenif->CloseProject()
    if !ComFailed(hr) do return

    return true
}

RefreshProject :: proc() -> (ok: bool)
{
    if !ComConnected() do return

    hr := cbopenif->RefreshProject()
    if !ComFailed(hr) do return

    return true
}

GetProjectConstantsAsXML :: proc() -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_xml: BStr
    hr := cbopenif->GetProjectConstants(&bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetProjectConstantsFromXML :: proc(xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_xml := ToBstr(xml)
    defer FreeBstr(bstr_xml)

    bstr_messages: BStr
    hr := cbopenif->SetProjectConstants(bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

NewProjectInEnvironment :: proc(project_name, guid, template_name, environment_guid_or_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(project_name)
    bstr_guid := ToBstr(guid)
    bstr_tmpl := ToBstr(template_name)
    bstr_env  := ToBstr(environment_guid_or_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_tmpl)
        FreeBstr(bstr_env)
    }
    hr := cbopenif->NewProjectInEnvironment(bstr_name, bstr_guid, bstr_tmpl, bstr_env)
    if !ComFailed(hr) do return

    return true
}

OpenProjectInEnvironment :: proc(project_guid_or_name, environment_guid_or_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_proj := ToBstr(project_guid_or_name)
    bstr_env  := ToBstr(environment_guid_or_name)
    defer {
        FreeBstr(bstr_proj)
        FreeBstr(bstr_env)
    }
    hr := cbopenif->OpenProjectInEnvironment(bstr_proj, bstr_env)
    if !ComFailed(hr) do return

    return true
}

GetProjectAndEnvironmentInformation :: proc() -> (project_name, project_guid, environment_name, environment_guid: string, ok: bool)
{
    if !ComConnected() do return

    bstr_pname, bstr_pguid, bstr_ename, bstr_eguid: BStr
    hr := cbopenif->GetProjectAndEnvironmentInformation(&bstr_pname, &bstr_pguid, &bstr_ename, &bstr_eguid)
    if ComFailed(hr) do return

    if bstr_pname != nil {
        defer FreeBstr(bstr_pname)
        project_name = FromBstr(bstr_pname)
    }
    if bstr_pguid != nil {
        defer FreeBstr(bstr_pguid)
        project_guid = FromBstr(bstr_pguid)
    }
    if bstr_ename != nil {
        defer FreeBstr(bstr_ename)
        environment_name = FromBstr(bstr_ename)
    }
    if bstr_eguid != nil {
        defer FreeBstr(bstr_eguid)
        environment_guid = FromBstr(bstr_eguid)
    }

    return project_name, project_guid, environment_name, environment_guid, true
}

NewLibrary :: proc(library_name, directory_path, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_library_name   := ToBstr(library_name)
    bstr_directory_path := ToBstr(directory_path)
    bstr_guid           := ToBstr(guid)
    defer {
        FreeBstr(bstr_library_name)
        FreeBstr(bstr_directory_path)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->NewLibrary(bstr_library_name, bstr_directory_path, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

InsertLibrary :: proc(file_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_file_path := ToBstr(file_path)
    defer FreeBstr(bstr_file_path)
    hr := cbopenif->InsertLibrary(bstr_file_path)
    if !ComFailed(hr) do return

    return true
}

RenameLibrary :: proc(library_name, new_library_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_library_name     := ToBstr(library_name)
    bstr_new_library_name := ToBstr(new_library_name)
    defer {
        FreeBstr(bstr_library_name)
        FreeBstr(bstr_new_library_name)
    }

    hr := cbopenif->RenameLibrary(bstr_library_name, bstr_new_library_name)
    if !ComFailed(hr) do return

    return true
}

DeleteLibrary :: proc(library_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_library_name := ToBstr(library_name)
    defer FreeBstr(bstr_library_name)

    hr := cbopenif->DeleteLibrary(bstr_library_name)
    if !ComFailed(hr) do return

    return true
}

GetLibraryProjectConstatnsAsXML :: proc(library_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_library_name := ToBstr(library_name)
    defer FreeBstr(bstr_library_name)

    bstr_xml: BStr
    hr := cbopenif->GetLibraryProjectConstants(bstr_library_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetLibraryProjectConstatnsFromXML :: proc(library_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_library_name := ToBstr(library_name)
    bstr_xml          := ToBstr(xml)
    defer {
        FreeBstr(bstr_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetLibraryProjectConstants(bstr_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

SetLibraryVersion :: proc(library_name: string, major, minor, revision: i32) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(library_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->SetLibraryVersion(bstr_name, major, minor, revision)
    if !ComFailed(hr) do return

    return true
}

GetLibraryVersion :: proc(library_name: string) -> (state: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(library_name)
    defer FreeBstr(bstr_name)

    bstr_state: BStr
    hr := cbopenif->GetLibraryState(bstr_name, &bstr_state)
    if ComFailed(hr) do return

    if bstr_state != nil {
        defer FreeBstr(bstr_state)
        state = FromBstr(bstr_state)
    }

    return state, true
}

SetLibraryState :: proc(library_name, state: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name  := ToBstr(library_name)
    bstr_state := ToBstr(state)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_state)
    }
    hr := cbopenif->SetLibraryState(bstr_name, bstr_state)
    if !ComFailed(hr) do return

    return true
}

ConnectLibrary :: proc(app_or_library_name, library_to_connect: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_lib                 := ToBstr(library_to_connect)
    defer {
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_lib)
    }
    hr := cbopenif->ConnectLibrary(bstr_app_or_library_name, bstr_lib)
    if !ComFailed(hr) do return

    return true
}

DisconnectLibrary :: proc(app_or_library_name, library_to_disconnect: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_lib                 := ToBstr(library_to_disconnect)
    defer {
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_lib)
    }
    hr := cbopenif->DisconnectLibrary(bstr_app_or_library_name, bstr_lib)
    if !ComFailed(hr) do return

    return true
}

RefreshLibrary :: proc(library_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(library_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->RefreshLibrary(bstr_name)
    if !ComFailed(hr) do return

    return true
}

NewHWLibrary :: proc(name, directory_path, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name           := ToBstr(name)
    bstr_directory_path := ToBstr(directory_path)
    bstr_guid           := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_directory_path)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->NewHardwareLibrary(bstr_name, bstr_directory_path, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

InsertHWLibrary :: proc(file_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(file_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->InsertHardwareLibrary(bstr_path)
    if !ComFailed(hr) do return

    return true
}

DeleteHWLibrary :: proc(name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->DeleteHardwareLibrary(bstr_name)
    if !ComFailed(hr) do return

    return true
}

ConnectHWLibrary :: proc(controller_name, name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_ctrl := ToBstr(controller_name)
    bstr_name := ToBstr(name)
    defer {
        FreeBstr(bstr_ctrl)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->ConnectHardwareLibrary(bstr_ctrl, bstr_name)
    if !ComFailed(hr) do return

    return true
}

DisconnectHWLibrary :: proc(controller_name, name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_ctrl := ToBstr(controller_name)
    bstr_name := ToBstr(name)
    defer {
        FreeBstr(bstr_ctrl)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->DisconnectHardwareLibrary(bstr_ctrl, bstr_name)
    if !ComFailed(hr) do return

    return true
}

GetHWLibraryState :: proc(name: string) -> (state: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)

    bstr_state: BStr
    hr := cbopenif->GetHardwareLibraryState(bstr_name, &bstr_state)
    if ComFailed(hr) do return

    if bstr_state != nil {
        defer FreeBstr(bstr_state)
        state = FromBstr(bstr_state)
    }

    return state, true
}

SetHWLibraryState :: proc(name, state: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name  := ToBstr(name)
    bstr_state := ToBstr(state)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_state)
    }
    hr := cbopenif->SetHardwareLibraryState(bstr_name, bstr_state)
    if !ComFailed(hr) do return

    return true
}

SetHWLibraryVersion :: proc(name: string, major, minor, revision: i32) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->SetHardwareLibraryVersion(bstr_name, major, minor, revision)
    if !ComFailed(hr) do return

    return true
}

CopyHWLibrary :: proc(src_name, dst_name, dst_guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_src  := ToBstr(src_name)
    bstr_dst  := ToBstr(dst_name)
    bstr_guid := ToBstr(dst_guid)
    defer {
        FreeBstr(bstr_src)
        FreeBstr(bstr_dst)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->CopyHardwareLibrary(bstr_src, bstr_dst, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

RefreshHWLibrary :: proc(name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->RefreshHardwareLibrary(bstr_name)
    if !ComFailed(hr) do return

    return true
}

RenameHWLibrary :: proc(name, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(name)
    bstr_new  := ToBstr(new_name)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_new)
    }
    hr := cbopenif->RenameHardwareLibrary(bstr_name, bstr_new)
    if !ComFailed(hr) do return

    return true
}

AddHWLibraryFile :: proc(libstr_name: string, file_kind: i32, file_path, version: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(libstr_name)
    bstr_path := ToBstr(file_path)
    bstr_ver  := ToBstr(version)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_path)
        FreeBstr(bstr_ver)
    }
    hr := cbopenif->AddHardwareLibraryFile(bstr_lib, file_kind, bstr_path, bstr_ver)
    if !ComFailed(hr) do return

    return true
}

GetHWLibraryFiles :: proc(libstr_name: string) -> (files: string, ok: bool)
{
    if !ComConnected() do return

    bstr_lib := ToBstr(libstr_name)
    defer FreeBstr(bstr_lib)

    bstr_files: BStr
    hr := cbopenif->GetHardwareLibraryFiles(bstr_lib, &bstr_files)
    if ComFailed(hr) do return

    if bstr_files != nil {
        defer FreeBstr(bstr_files)
        files = FromBstr(bstr_files)
    }

    return files, true
}

DeleteHWLibraryFile :: proc(libstr_name: string, file_kind: i32, file_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(libstr_name)
    bstr_file := ToBstr(file_name)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_file)
    }
    hr := cbopenif->DeleteHardwareLibraryFile(bstr_lib, file_kind, bstr_file)
    if !ComFailed(hr) do return

    return true
}

NewApplication :: proc(application_name, directory_path, guid, template_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_application_name := ToBstr(application_name)
    bstr_directory_path   := ToBstr(directory_path)
    bstr_guid             := ToBstr(guid)
    bstr_template         := ToBstr(template_name)
    defer {
        FreeBstr(bstr_application_name)
        FreeBstr(bstr_directory_path)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_template)
    }
    hr := cbopenif->NewApplication(bstr_application_name, bstr_directory_path, bstr_guid, bstr_template)
    if !ComFailed(hr) do return

    return true
}

InsertApplication :: proc(file_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_file_path := ToBstr(file_path)
    defer FreeBstr(bstr_file_path)
    hr := cbopenif->InsertApplication(bstr_file_path)
    if !ComFailed(hr) do return

    return true
}

RenameApplication :: proc(application_name, new_application_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_application_name     := ToBstr(application_name)
    bstr_new_application_name := ToBstr(new_application_name)
    defer {
        FreeBstr(bstr_application_name)
        FreeBstr(bstr_new_application_name)
    }
    hr := cbopenif->RenameApplication(bstr_application_name, bstr_new_application_name)
    if !ComFailed(hr) do return

    return true
}

DeleteApplication :: proc(application_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_application_name := ToBstr(application_name)
    defer FreeBstr(bstr_application_name)
    hr := cbopenif->DeleteApplication(bstr_application_name)
    if !ComFailed(hr) do return

    return true
}

GetApplicationVariablesAsXML :: proc(application_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_application_name := ToBstr(application_name)
    defer FreeBstr(bstr_application_name)

    bstr_xml: BStr
    hr := cbopenif->GetApplicationVariables(bstr_application_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetApplicationVariablesFromXML :: proc(application_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_application_name := ToBstr(application_name)
    bstr_xml              := ToBstr(xml)
    defer {
        FreeBstr(bstr_application_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetApplicationVariables(bstr_application_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetApplicationControlModulesAsXML :: proc(application_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(application_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetApplicationControlModules(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetApplicationControlModulesFromXML :: proc(application_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(application_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetApplicationControlModules(bstr_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

SetApplicationVersion :: proc(application_name: string, major, minor, revision: i32) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(application_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->SetApplicationVersion(bstr_name, major, minor, revision)

    if !ComFailed(hr) do return

    return true
}

RefreshApplication :: proc(application_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(application_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->RefreshApplication(bstr_name)
    if !ComFailed(hr) do return

    return true
}

GetTaskConnection :: proc(object_path: string) -> (task_connection: string, ok: bool)
{
    if !ComConnected() do return

    bstr_object_path := ToBstr(object_path)
    defer FreeBstr(bstr_object_path)

    bstr_conn: BStr
    hr := cbopenif->GetTaskConnection(bstr_object_path, &bstr_conn)
    if ComFailed(hr) do return

    if bstr_conn != nil {
        defer FreeBstr(bstr_conn)
        task_connection = FromBstr(bstr_conn)
    }

    return task_connection, true
}

SetTaskConnection :: proc(object_path, task_connection: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_object_path     := ToBstr(object_path)
    bstr_task_connection := ToBstr(task_connection)
    defer {
        FreeBstr(bstr_object_path)
        FreeBstr(bstr_task_connection)
    }
    hr := cbopenif->SetTaskConnection(bstr_object_path, bstr_task_connection)
    if !ComFailed(hr) do return

    return true
}

NewTaskFromXML :: proc(task_name, controller_name, xml: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(task_name)
    bstr_ctrl := ToBstr(controller_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_ctrl)
        FreeBstr(bstr_xml)
    }
    hr := cbopenif->NewTask(bstr_name, bstr_ctrl, bstr_xml)
    if !ComFailed(hr) do return

    return true
}

GetTaskAsXML :: proc(task_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(task_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetTask(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetTaskFromXML :: proc(task_path, xml: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(task_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }
    hr := cbopenif->SetTask(bstr_path, bstr_xml)
    if !ComFailed(hr) do return

    return true
}

DeleteTask :: proc(task_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(task_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteTask(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameTask :: proc(task_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(task_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameTask(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

NewController :: proc(controller_name, controller_type, directory_path, guid, template_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_controller_name := ToBstr(controller_name)
    bstr_controller_type := ToBstr(controller_type)
    bstr_directory_path  := ToBstr(directory_path)
    bstr_guid            := ToBstr(guid)
    bstr_template        := ToBstr(template_name)
    defer {
        FreeBstr(bstr_controller_name)
        FreeBstr(bstr_controller_type)
        FreeBstr(bstr_directory_path)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_template)
    }
    hr := cbopenif->NewController(bstr_controller_name, bstr_controller_type, bstr_directory_path, bstr_guid, bstr_template)
    if !ComFailed(hr) do return

    return true
}

InsertController :: proc(file_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_file_path := ToBstr(file_path)
    defer FreeBstr(bstr_file_path)
    hr := cbopenif->InsertController(bstr_file_path)
    if !ComFailed(hr) do return

    return true
}

RenameController :: proc(controller_name, new_controller_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_controller_name     := ToBstr(controller_name)
    bstr_new_controller_name := ToBstr(new_controller_name)
    defer {
        FreeBstr(bstr_controller_name)
        FreeBstr(bstr_new_controller_name)
    }
    hr := cbopenif->RenameController(bstr_controller_name, bstr_new_controller_name)
    if !ComFailed(hr) do return

    return true
}

DeleteController :: proc(controller_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_controller_name := ToBstr(controller_name)
    defer FreeBstr(bstr_controller_name)
    hr := cbopenif->DeleteController(bstr_controller_name)
    if !ComFailed(hr) do return

    return true
}

SetControllerVersion :: proc(controller_name: string, major, minor, revision: i32) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->SetControllerVersion(bstr_name, major, minor, revision)
    if !ComFailed(hr) do return

    return true
}

GetControllerPropertiesAsXML :: proc(controller_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetControllerProperties(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetControllerPropertiesFromXML :: proc(controller_name, xml: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }
    hr := cbopenif->SetControllerProperties(bstr_name, bstr_xml)
    if !ComFailed(hr) do return

    return true
}

GetControllerSettingsAsXML :: proc(controller_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetControllerSettings(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetControllerSettingFromXML :: proc(controller_name, xml: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }
    hr := cbopenif->SetControllerSettings(bstr_name, bstr_xml)
    if !ComFailed(hr) do return

    return true
}

GetSystemIdentity :: proc(controller_name: string) -> (system_identity: string, ok: bool)
{
    if !ComConnected() do return

    bstr_controller_name := ToBstr(controller_name)
    defer FreeBstr(bstr_controller_name)

    bstr_system_identity: BStr
    hr := cbopenif->GetSystemIdentity(bstr_controller_name, &bstr_system_identity)
    if ComFailed(hr) do return

    if bstr_system_identity != nil {
        defer FreeBstr(bstr_system_identity)
        system_identity = FromBstr(bstr_system_identity)
    }

    return system_identity, true
}

SetSystemIdentity :: proc(controller_name, system_identity: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_controller_name := ToBstr(controller_name)
    bstr_system_identity := ToBstr(system_identity)
    defer {
        FreeBstr(bstr_controller_name)
        FreeBstr(bstr_system_identity)
    }
    hr := cbopenif->SetSystemIdentity(bstr_controller_name, bstr_system_identity)
    if !ComFailed(hr) do return

    return true
}

NewDataTypeFromXML :: proc(name, app_or_library_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDataType(bstr_name, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetDataTypeAsXML :: proc(data_type_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_data_type_path := ToBstr(data_type_path)
    defer FreeBstr(bstr_data_type_path)

    bstr_xml: BStr
    hr := cbopenif->GetDataType(bstr_data_type_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetDataTypeFromXML :: proc(data_type_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_data_type_path := ToBstr(data_type_path)
    bstr_xml            := ToBstr(xml)
    defer {
        FreeBstr(bstr_data_type_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDataType(bstr_data_type_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteDataType :: proc(data_type_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_data_type_path := ToBstr(data_type_path)
    defer FreeBstr(bstr_data_type_path)
    hr := cbopenif->DeleteDataType(bstr_data_type_path)
    if !ComFailed(hr) do return

    return true
}

InsertDataType :: proc(name, app_or_library_name, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertDataType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

RenameDataType :: proc(data_type_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(data_type_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameDataType(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

NewFunctionBlockTypeFromXML :: proc(fbstr_type_name, app_or_library_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(fbstr_type_name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewFunctionBlockType(bstr_name, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetFunctionBlockTypeAsXML :: proc(fbstr_type_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_type_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetFunctionBlockType(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetFunctionBlockTypeFromXML :: proc(fbstr_type_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path    := ToBstr(fbstr_type_path)
    bstr_xml := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetFunctionBlockType(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteFunctionBlockType :: proc(fbstr_type_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_type_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteFunctionBlockType(bstr_path)
    if !ComFailed(hr) do return

    return true
}

InsertFunctionBlockType :: proc(name, app_or_library_name, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertFunctionBlockType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

RenameFunctionBlockType :: proc(fbstr_type_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_type_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameFunctionBlockType(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

NewControlModuleTypeFromXML :: proc(cm_type_name, app_or_library_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(cm_type_name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewControlModuleType(bstr_name, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetControlModuleTypeAsXML :: proc(cm_type_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_type_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetControlModuleType(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetControlModuleTypeFromXML :: proc(cm_type_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_type_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetControlModuleType(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteControlModuleType :: proc(cm_type_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_type_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteControlModuleType(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameControlModuleType :: proc(cm_type_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_type_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameControlModuleType(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

InsertControlModuleType :: proc(name, app_or_library_name, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertControlModuleType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

NewControlModuleFromXML :: proc(cm_name, cm_type, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(cm_name)
    bstr_type   := ToBstr(cm_type)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewControlModule(bstr_name, bstr_type, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

NewControlModuleAsXML :: proc(cm_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetControlModule(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetControlModuleFromXML :: proc(cm_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetControlModule(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteControlModule :: proc(cm_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteControlModule(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameControlModule :: proc(cm_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(cm_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameControlModule(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

NewSingleControlModuleFromXML :: proc(cm_name, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(cm_name)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewSingleControlModule(bstr_name, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetSingleControlModuleAsXML :: proc(path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetSingleControlModule(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetSingleControlModuleFromXML :: proc(path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetSingleControlModule(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteSingleControlModule :: proc(path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteSingleControlModule(bstr_path)
    if !ComFailed(hr) do return

    return true
}

InsertSingleControlModule :: proc(module_name, path_to_parent, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(module_name)
    bstr_parent := ToBstr(path_to_parent)
    bstr_guid   := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertSingleControlModule(bstr_name, bstr_parent, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

NewProgramFromXML :: proc(program_name, application_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(program_name)
    bstr_app_or_library_name := ToBstr(application_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewProgram(bstr_name, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetProgramAsXML :: proc(program_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(program_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetProgram(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetProgramFromXML :: proc(program_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(program_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetProgram(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteProgram :: proc(program_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(program_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteProgram(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameProgram :: proc(program_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(program_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameProgram(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

InsertProgram :: proc(name, application_name, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(application_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertProgram(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

GetAccessVariablesAsXML :: proc(controller_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetAccessVariables(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetAccessVariablesFromXML :: proc(controller_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetAccessVariables(bstr_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetConnectedApplicationsAsXML :: proc(controller_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetConnectedApplications(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetConnectedApplicationsFromXML :: proc(controller_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetConnectedApplications(bstr_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

IsOnline :: proc() -> (is_online: bool, messages: string, ok: bool)
{
    if !ComConnected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->Online(&vb, &bstr_messages)
    if ComFailed(hr) do return

    is_online = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return is_online, messages, true
}

DownloadAndGoOnline :: proc() -> (is_online: bool, messages: string, ok: bool)
{
    if !ComConnected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->DownloadAndGoOnline(&vb, &bstr_messages)
    if ComFailed(hr) do return

    is_online = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return is_online, messages, true
}

IsInTestMode :: proc() -> (is_test_mode: bool, messages: string, ok: bool)
{
    if !ComConnected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->TestMode(&vb, &bstr_messages)
    if ComFailed(hr) do return

    is_test_mode = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return is_test_mode, messages, true
}

Offline :: proc() -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_messages: BStr
    hr := cbopenif->Offline(&bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

NewHWUnitFromXML :: proc(hw_path: string, hw_type_id: Variant, hw_qualifier, xml, redundant_to: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path      := ToBstr(hw_path)
    bstr_qualifier := ToBstr(hw_qualifier)
    bstr_xml       := ToBstr(xml)
    bstr_red       := ToBstr(redundant_to)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_qualifier)
        FreeBstr(bstr_xml)
        FreeBstr(bstr_red)
    }

    bstr_messages: BStr
    hr := cbopenif->NewHardwareUnit(bstr_path, hw_type_id, bstr_qualifier, bstr_xml, bstr_red, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetHWUnitAsXML :: proc(hw_path: string, include_substr_units: bool) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(hw_path)
    defer FreeBstr(bstr_path)

    vb: VariantBool = VariantBoolTrue if include_substr_units else VariantBoolFalse
    bstr_xml: BStr
    hr := cbopenif->GetHardwareUnit(bstr_path, vb, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetHWUnitFromXML :: proc(hw_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(hw_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetHardwareUnit(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteHWUnit :: proc(hw_path: string, remove_redundant_only: bool) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(hw_path)
    defer FreeBstr(bstr_path)

    vb: VariantBool = VariantBoolTrue if remove_redundant_only else VariantBoolFalse
    hr := cbopenif->DeleteHardwareUnit(bstr_path, vb)
    if !ComFailed(hr) do return

    return true
}

MoveHWUnit :: proc(old_hw_path, new_hw_path: string, do_swap: bool) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_old := ToBstr(old_hw_path)
    bstr_new := ToBstr(new_hw_path)
    defer {
        FreeBstr(bstr_old)
        FreeBstr(bstr_new)
    }

    vb: VariantBool = VariantBoolTrue if do_swap else VariantBoolFalse
    hr := cbopenif->MoveHardwareUnitTo(bstr_old, bstr_new, vb)
    if !ComFailed(hr) do return

    return true
}

ReplaceHWUnit :: proc(hw_path: string, hw_type_id: Variant, hw_qualifier: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path      := ToBstr(hw_path)
    bstr_qualifier := ToBstr(hw_qualifier)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_qualifier)
    }
    hr := cbopenif->ReplaceHardwareUnitType(bstr_path, hw_type_id, bstr_qualifier)
    if !ComFailed(hr) do return

    return true
}

InsertHWUnit :: proc(parent_hw_path, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(parent_hw_path)
    bstr_guid := ToBstr(guid)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertHardwareUnit(bstr_path, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

GetHWTypeAsXML :: proc(hardware_library_name, hardware_type_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(hardware_library_name)
    bstr_type := ToBstr(hardware_type_name)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_type)
    }

    bstr_xml: BStr
    hr := cbopenif->GetHardwareType(bstr_lib, bstr_type, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

CopyHWType :: proc(src_lib, src_guid, dst_lib, dst_guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_src_lib  := ToBstr(src_lib)
    bstr_src_guid := ToBstr(src_guid)
    bstr_dst_lib  := ToBstr(dst_lib)
    bstr_dst_guid := ToBstr(dst_guid)
    defer {
        FreeBstr(bstr_src_lib)
        FreeBstr(bstr_src_guid)
        FreeBstr(bstr_dst_lib)
        FreeBstr(bstr_dst_guid)
    }
    hr := cbopenif->CopyHardwareType(bstr_src_lib, bstr_src_guid, bstr_dst_lib, bstr_dst_guid)
    if !ComFailed(hr) do return

    return true
}

DeleteHWType :: proc(libstr_name, type_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(libstr_name)
    bstr_type := ToBstr(type_name)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_type)
    }
    hr := cbopenif->DeleteHardwareType(bstr_lib, bstr_type)
    if !ComFailed(hr) do return

    return true
}

InsertHWType :: proc(type_name, libstr_name, type_guid, type_id: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_type := ToBstr(type_name)
    bstr_lib  := ToBstr(libstr_name)
    bstr_guid := ToBstr(type_guid)
    bstr_id   := ToBstr(type_id)
    defer {
        FreeBstr(bstr_type)
        FreeBstr(bstr_lib)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_id)
    }
    hr := cbopenif->InsertHardwareType(bstr_type, bstr_lib, bstr_guid, bstr_id)
    if !ComFailed(hr) do return

    return true
}

AddHWTypeFile :: proc(libstr_name, type_guid: string, file_type: i32, file_path, version, build_version, build_date, fw_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_lib   := ToBstr(libstr_name)
    bstr_guid  := ToBstr(type_guid)
    bstr_path  := ToBstr(file_path)
    bstr_ver   := ToBstr(version)
    bstr_bver  := ToBstr(build_version)
    bstr_bdate := ToBstr(build_date)
    bstr_fw    := ToBstr(fw_name)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_guid)
        FreeBstr(bstr_path)
        FreeBstr(bstr_ver)
        FreeBstr(bstr_bver)
        FreeBstr(bstr_bdate)
        FreeBstr(bstr_fw)
    }
    hr := cbopenif->AddHardwareTypeFile(bstr_lib, bstr_guid, file_type, bstr_path, bstr_ver, bstr_bver, bstr_bdate, bstr_fw)
    if !ComFailed(hr) do return

    return true
}

SetHWTypeFromXML :: proc(libstr_name, type_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(libstr_name)
    bstr_type := ToBstr(type_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_type)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetHardwareType(bstr_lib, bstr_type, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetProjectTressAsXML :: proc(path: string, depth: i32, include_runtime_instances: bool) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)

    vb: VariantBool = VariantBoolTrue if include_runtime_instances else VariantBoolFalse
    bstr_xml: BStr
    hr := cbopenif->GetProjectTree(bstr_path, depth, vb, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

NewFunctionBlockFromXML :: proc(fbstr_name, fbstr_type, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(fbstr_name)
    bstr_type   := ToBstr(fbstr_type)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewFunctionBlock(bstr_name, bstr_type, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetFunctionBlockAsXML :: proc(fbstr_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetFunctionBlock(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetFunctionBlockFromXML :: proc(fbstr_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetFunctionBlock(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteFunctionBlock :: proc(fbstr_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteFunctionBlock(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameFunctionBlock :: proc(fbstr_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(fbstr_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameFunctionBlock(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

Reserve :: proc(fou_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(fou_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->Reserve(bstr_name)
    if !ComFailed(hr) do return

    return true
}

Reserver :: proc(fou_name: string) -> (reserver: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(fou_name)
    defer FreeBstr(bstr_name)

    bstr_reserver: BStr
    hr := cbopenif->IsReservedBy(bstr_name, &bstr_reserver)
    if ComFailed(hr) do return

    if bstr_reserver != nil {
        defer FreeBstr(bstr_reserver)
        reserver = FromBstr(bstr_reserver)
    }

    return reserver, true
}

ReleaseReservation :: proc(fou_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(fou_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->ReleaseReservation(bstr_name)
    if !ComFailed(hr) do return

    return true
}

GetSetting :: proc(setting_name: string) -> (value: Variant, ok: bool)
{
    if !ComConnected() do return

    InitVariant(&value)
    bstr_name := ToBstr(setting_name)
    defer FreeBstr(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &value)
    if ComFailed(hr) {
        FreeVariant(&value)
        return
    }

    return value, true
}

SetSettingFromString :: proc(setting_name: string, setting: string) -> (ok: bool)
{
    if !ComConnected() do return

    v_setting_name := ToVariant(setting_name)
    v_setting      := ToVariant(setting)
    defer {
        FreeVariant(&v_setting_name)
        FreeVariant(&v_setting)
    }

    args := []Variant{ v_setting_name, v_setting }

    this := cast(^IUnknownIF)cbopenif
    ok = InvokeComName(this, "SetSetting", args, nil)
    if !ok do return

    return true
}

SetSettingFromBool :: proc(setting_name: string, setting: bool) -> (ok: bool)
{
    if !ComConnected() do return

    v_setting_name := ToVariant(setting_name)
    v_setting      := ToVariant(setting)
    defer {
        FreeVariant(&v_setting_name)
        FreeVariant(&v_setting)
    }

    args := []Variant{ v_setting_name, v_setting }

    this := cast(^IUnknownIF)cbopenif
    ok = InvokeComName(this, "SetSetting", args, nil)
    if !ok do return

    return true
}

NewParameterFromXML :: proc(parameter_kind: i32, parameter_name, data_type, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(parameter_name)
    bstr_dtype  := ToBstr(data_type)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_dtype)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewParameter(parameter_kind, bstr_name, bstr_dtype, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetParameterAsXML :: proc(parameter_kind: i32, parameter_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(parameter_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetParameter(parameter_kind, bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetParameterFromXML :: proc(parameter_kind: i32, parameter_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(parameter_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetParameter(parameter_kind, bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteParameter :: proc(parameter_kind: i32, parameter_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(parameter_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteParameter(parameter_kind, bstr_path)
    if !ComFailed(hr) do return

    return true
}

NewVariableFromXML :: proc(variable_kind: i32, variable_name, data_type, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(variable_name)
    bstr_dtype  := ToBstr(data_type)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_dtype)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewVariable(variable_kind, bstr_name, bstr_dtype, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetVariableAsXML :: proc(variable_kind: i32, variable_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(variable_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetVariable(variable_kind, bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetVariableFromXML :: proc(variable_kind: i32, variable_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(variable_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetVariable(variable_kind, bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteVariable :: proc(variable_kind: i32, variable_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(variable_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteVariable(variable_kind, bstr_path)
    if !ComFailed(hr) do return

    return true
}

GetCMConnectionAsXML :: proc(connection_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(connection_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetCMConnection(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetCMConnectionFromXML :: proc(connection_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(connection_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetCMConnection(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

NewCodeBlockFromXML :: proc(codeblock_kind: i32, code_block_name, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(code_block_name)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewCodeBlock(codeblock_kind, bstr_name, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetCodeBlockAsXML :: proc(code_block_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(code_block_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetCodeBlock(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetCodeBlockFromXML :: proc(code_block_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(code_block_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetCodeBlock(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteCodeBlock :: proc(code_block_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(code_block_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteCodeBlock(bstr_path)
    if !ComFailed(hr) do return

    return true
}

GetOneInstanceInitValsAsXML :: proc(instance_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(instance_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetOneInstanceInitVals(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

GetAllInstanceInitValsAsXML :: proc(path_to_parent: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path_to_parent)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetAllInstancesInitVals(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetOneInstanceInitValsFromXML :: proc(instance_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(instance_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetOneInstanceInitVals(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

SetAllInstanceInitValsFromXML :: proc(path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path_to_parent)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetAllInstancesInitVals(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteOneInstanceInitVals :: proc(instance_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(instance_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteOneInstanceInitVals(bstr_path)
    if !ComFailed(hr) do return

    return true
}

DeleteAllInstanceInitVals :: proc(path_to_parent: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path_to_parent)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteAllInstancesInitVals(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameInstanceDataPath :: proc(old_path, new_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_old := ToBstr(old_path)
    bstr_new := ToBstr(new_path)
    defer {
        FreeBstr(bstr_old)
        FreeBstr(bstr_new)
    }
    hr := cbopenif->RenameInstanceDataPath(bstr_old, bstr_new)
    if !ComFailed(hr) do return

    return true
}

GetConnectedLibrariesAsXML :: proc(app_or_library_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(app_or_library_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetConnectedLibraries(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetConnectedLibrariesFromXML :: proc(app_or_library_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(app_or_library_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetConnectedLibraries(bstr_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetTypePathFromGuid :: proc(app_or_library_name, guid: string) -> (type_path: string, ok: bool)
{
    if !ComConnected() do return

    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }

    bstr_path: BStr
    hr := cbopenif->GetTypePathFromGUID(bstr_app_or_library_name, bstr_guid, &bstr_path)
    if ComFailed(hr) do return

    if bstr_path != nil {
        defer FreeBstr(bstr_path)
        type_path = FromBstr(bstr_path)
    }

    return type_path, true
}

RefreshController :: proc(controller_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)
    hr := cbopenif->RefreshController(bstr_name)
    if !ComFailed(hr) do return

    return true
}

GetValidHWPositions :: proc(hw_father_path: string, hw_type_id: Variant, hw_qualifier: string) -> (positions: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path      := ToBstr(hw_father_path)
    bstr_qualifier := ToBstr(hw_qualifier)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_qualifier)
    }

    bstr_positions: BStr
    hr := cbopenif->GetValidHardwarePositions(bstr_path, hw_type_id, bstr_qualifier, &bstr_positions)
    if ComFailed(hr) do return

    if bstr_positions != nil {
        defer FreeBstr(bstr_positions)
        positions = FromBstr(bstr_positions)
    }

    return positions, true
}

GetApplicationPropertiesAsXML :: proc(application_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(application_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetApplicationProperties(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetApplicationPropertiesFromXML :: proc(application_name, xml: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(application_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }
    hr := cbopenif->SetApplicationProperties(bstr_name, bstr_xml)
    if !ComFailed(hr) do return

    return true
}

GetConnectedHWLibrariesAsXML :: proc(controller_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    defer FreeBstr(bstr_name)

    bstr_xml: BStr
    hr := cbopenif->GetConnectedHardwareLibraries(bstr_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetConnectedHWLibrariesFromXML :: proc(controller_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name := ToBstr(controller_name)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetConnectedHardwareLibraries(bstr_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

ReplaceConnectedHWLibrary :: proc(controller_name, connected_name, replacing_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_ctrl := ToBstr(controller_name)
    bstr_conn := ToBstr(connected_name)
    bstr_repl := ToBstr(replacing_name)
    defer {
        FreeBstr(bstr_ctrl)
        FreeBstr(bstr_conn)
        FreeBstr(bstr_repl)
    }
    hr := cbopenif->ReplaceConnectedHardwareLibrary(bstr_ctrl, bstr_conn, bstr_repl)
    if !ComFailed(hr) do return

    return true
}

ReplaceConnectedLibrary :: proc(app_or_library_name, connected_name, replacing_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_conn                := ToBstr(connected_name)
    bstr_repl                := ToBstr(replacing_name)
    defer {
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_conn)
        FreeBstr(bstr_repl)
    }
    hr := cbopenif->ReplaceConnectedLibrary(bstr_app_or_library_name, bstr_conn, bstr_repl)
    if !ComFailed(hr) do return

    return true
}

SetStorage :: proc(p_iac_storage: rawptr) -> (ok: bool)
{
    if !ComConnected() do return

    hr := cbopenif->SetStorage(p_iac_storage)
    if !ComFailed(hr) do return

    return true
}

WriteInformation :: proc(message: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_msg := ToBstr(message)
    defer FreeBstr(bstr_msg)
    hr := cbopenif->WriteInformation(bstr_msg)
    if !ComFailed(hr) do return

    return true
}

WriteWarning :: proc(message: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_msg := ToBstr(message)
    defer FreeBstr(bstr_msg)
    hr := cbopenif->WriteWarning(bstr_msg)
    if !ComFailed(hr) do return

    return true
}

WriteError :: proc(message: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_msg := ToBstr(message)
    defer FreeBstr(bstr_msg)
    hr := cbopenif->WriteError(bstr_msg)
    if !ComFailed(hr) do return

    return true
}

NewFolder :: proc(folder_name, path_to_parent, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(folder_name)
    bstr_parent := ToBstr(path_to_parent)
    bstr_guid   := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->NewFolder(0, bstr_name, bstr_parent, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

RenameFolder :: proc(folder_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(folder_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameFolder(0, bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

DeleteFolder :: proc(folder_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(folder_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteFolder(0, bstr_path)
    if !ComFailed(hr) do return

    return true
}

MoveFolder :: proc(folder_path, destination_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(folder_path)
    bstr_dest := ToBstr(destination_path)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_dest)
    }
    hr := cbopenif->MoveFolder(0, bstr_path, bstr_dest)
    if !ComFailed(hr) do return

    return true
}

MoveFolderObject :: proc(object_name, destination_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_obj  := ToBstr(object_name)
    bstr_dest := ToBstr(destination_path)
    defer {
        FreeBstr(bstr_obj)
        FreeBstr(bstr_dest)
    }
    hr := cbopenif->MoveFolderObject(0, bstr_obj, bstr_dest)
    if !ComFailed(hr) do return

    return true
}

NewDiagramFromXML :: proc(diagram_name, application_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(diagram_name)
    bstr_app_or_library_name := ToBstr(application_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDiagram(bstr_name, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetDiagramAsXML :: proc(diagram_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(diagram_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetDiagram(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetDiagramAsXML :: proc(diagram_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(diagram_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDiagram(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteDiagram :: proc(diagram_path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(diagram_path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteDiagram(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameDiagram :: proc(diagram_path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(diagram_path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameDiagram(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

InsertDiagram :: proc(diagram_name, application_name, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(diagram_name)
    bstr_app_or_library_name := ToBstr(application_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertDiagram(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

InsertHardwareDefinitionFile :: proc(hardware_library_name, file_path: string) -> (file_added: bool, messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(hardware_library_name)
    bstr_path := ToBstr(file_path)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_path)
    }

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->InsertHardwareDefinitionFile(bstr_lib, bstr_path, &vb, &bstr_messages)
    if ComFailed(hr) do return

    file_added = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return file_added, messages, true
}

GetExecutiOnorderAsXML :: proc(application_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_app_or_library_name := ToBstr(application_name)
    defer FreeBstr(bstr_app_or_library_name)

    bstr_xml: BStr
    hr := cbopenif->GetExecutionOrder(0, bstr_app_or_library_name, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetExecutionOrderFromXML :: proc(application_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_app_or_library_name := ToBstr(application_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetExecutionOrder(0, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

NewDiagramTypeFromXML :: proc(name, app_or_library_name, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_xml                 := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDiagramType(bstr_name, bstr_app_or_library_name, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetDiagramTypeAsXML :: proc(path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetDiagramType(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetDiagramTypeFromXML :: proc(path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDiagramType(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeteletDiagramType :: proc(path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteDiagramType(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameDiagramType :: proc(path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameDiagramType(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

InsertDiagramType :: proc(name, app_or_library_name, guid: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name                := ToBstr(name)
    bstr_app_or_library_name := ToBstr(app_or_library_name)
    bstr_guid                := ToBstr(guid)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_app_or_library_name)
        FreeBstr(bstr_guid)
    }
    hr := cbopenif->InsertDiagramType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !ComFailed(hr) do return

    return true
}

NewDiagramInstancefromXML :: proc(name, diagram_type, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(name)
    bstr_type   := ToBstr(diagram_type)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_type)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDiagramInstance(bstr_name, bstr_type, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetDiagramInstanceAsXML :: proc(path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetDiagramInstance(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetDiagramInstanceFromXML :: proc(path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDiagramInstance(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteDiagramInstance :: proc(path: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    defer FreeBstr(bstr_path)
    hr := cbopenif->DeleteDiagramInstance(bstr_path)
    if !ComFailed(hr) do return

    return true
}

RenameDiagramInstance :: proc(path, new_name: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(path)
    bstr_name := ToBstr(new_name)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_name)
    }
    hr := cbopenif->RenameDiagramInstance(bstr_path, bstr_name)
    if !ComFailed(hr) do return

    return true
}

NewSignalFromXML :: proc(signal_name, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(signal_name)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->NewSignal(0, bstr_name, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetSignalAsXML :: proc(signal_name, path_to_parent: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(signal_name)
    bstr_parent := ToBstr(path_to_parent)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
    }

    bstr_xml: BStr
    hr := cbopenif->GetSignal(0, bstr_name, bstr_parent, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetSignalFromXML :: proc(signal_name, path_to_parent, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(signal_name)
    bstr_parent := ToBstr(path_to_parent)
    bstr_xml    := ToBstr(xml)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetSignal(0, bstr_name, bstr_parent, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

DeleteSignal :: proc(signal_name, path_to_parent: string) -> (ok: bool)
{
    if !ComConnected() do return

    bstr_name   := ToBstr(signal_name)
    bstr_parent := ToBstr(path_to_parent)
    defer {
        FreeBstr(bstr_name)
        FreeBstr(bstr_parent)
    }
    hr := cbopenif->DeleteSignal(0, bstr_name, bstr_parent)
    if !ComFailed(hr) do return

    return true
}

GetHWDefinitionInfoAsXML :: proc(libstr_name, type_name: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_lib  := ToBstr(libstr_name)
    bstr_type := ToBstr(type_name)
    defer {
        FreeBstr(bstr_lib)
        FreeBstr(bstr_type)
    }

    bstr_xml: BStr
    hr := cbopenif->GetHardwareDefinitionInfo(bstr_lib, bstr_type, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

GetFDConnectionAsXML :: proc(connection_path: string) -> (xml: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(connection_path)
    defer FreeBstr(bstr_path)

    bstr_xml: BStr
    hr := cbopenif->GetFDConnection(bstr_path, &bstr_xml)
    if ComFailed(hr) do return

    if bstr_xml != nil {
        defer FreeBstr(bstr_xml)
        xml = FromBstr(bstr_xml)
    }

    return xml, true
}

SetFDConnectionFromXML :: proc(connection_path, xml: string) -> (messages: string, ok: bool)
{
    if !ComConnected() do return

    bstr_path := ToBstr(connection_path)
    bstr_xml  := ToBstr(xml)
    defer {
        FreeBstr(bstr_path)
        FreeBstr(bstr_xml)
    }

    bstr_messages: BStr
    hr := cbopenif->SetFDConnection(bstr_path, bstr_xml, &bstr_messages)
    if ComFailed(hr) do return

    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return messages, true
}

GetAvailableLibrariesList :: proc() -> (libraries: string, ok: bool)
{
    if !ComConnected() do return

    bstr_libs: BStr
    hr := cbopenif->ListAvailableLibraries(&bstr_libs)
    if ComFailed(hr) do return

    if bstr_libs != nil {
        defer FreeBstr(bstr_libs)
        libraries = FromBstr(bstr_libs)
    }

    return libraries, true
}

GetAvailableHWLibrariesList :: proc() -> (libraries: string, ok: bool)
{
    if !ComConnected() do return

    bstr_libs: BStr
    hr := cbopenif->ListAvailableHardwareLibraries(&bstr_libs)
    if ComFailed(hr) do return

    if bstr_libs != nil {
        defer FreeBstr(bstr_libs)
        libraries = FromBstr(bstr_libs)
    }

    return libraries, true
}

CheckDownloadAndGoOnlineLoop :: proc() -> (is_online: bool, messages: string, ok: bool)
{
    if !ComConnected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->LoopCheckDownloadAndGoOnline(&vb, &bstr_messages)
    if ComFailed(hr) do return

    is_online = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer FreeBstr(bstr_messages)
        messages = FromBstr(bstr_messages)
    }

    return is_online, messages, true
}
