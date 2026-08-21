package com

import t "../types"

CBOpenIFErrorCodes :: enum u32 {
    NotSupported     = 0x80040bc2,
    Mode             = 0x80040bc3,
    Xml              = 0x80040bc4,
    Name             = 0x80040bc5,
    Path             = 0x80040bc6,
    CreatedDirectory = 0x80040bc7,
    AlreadyExists    = 0x80040bc8,
    MaxExceeded      = 0x80040bc9,
    Open             = 0x80040bca,
    Save             = 0x80040bcb,
    DoesNotExist     = 0x80040bcc,
    Delete           = 0x80040bcd,
    Type             = 0x80040bce,
    State            = 0x80040bcf,
    Version          = 0x80040bd0,
    ModalDialog      = 0x80040bd1,
    NameConflict     = 0x80040bd2,
    GUID             = 0x80040bd3,
    Decryption       = 0x80040bd4,
    Checksum         = 0x80040bd5,
    ChecksumCodePage = 0x80040bd6,
    InUse            = 0x80040bd7,
    Reservation      = 0x80040bd8
}

cbopenif: ^CBOpenIF

CBOpenIF :: struct #raw_union {
    #subtype iunknownif: IUnknownIF,
    using vtable: ^CBOpenVTable,
}

CBOpenVTable :: struct {
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

cbopen_new_project :: proc(project_name, directory_path, guid, template_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_project        := to_bstr(project_name)
    bstr_directory_path := to_bstr(directory_path)
    bstr_guid           := to_bstr(guid)
    bstr_template       := to_bstr(template_name)
    defer {
        bstr_free(bstr_project)
        bstr_free(bstr_directory_path)
        bstr_free(bstr_guid)
        bstr_free(bstr_template)
    }
    hr := cbopenif->NewProject(bstr_project, bstr_directory_path, bstr_guid, bstr_template)
    if !com_failed(hr) do return

    return true
}

cbopen_open_project :: proc(file_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_file_path := to_bstr(file_path)
    defer bstr_free(bstr_file_path)
    hr := cbopenif->OpenProject(bstr_file_path)
    if !com_failed(hr) do return

    return true
}

cbopen_close_project :: proc() -> (ok: bool) {
    if !com_connected() do return
    
    hr := cbopenif->CloseProject()
    if !com_failed(hr) do return

    return true
}

cbopen_get_project_constants :: proc() -> (constants: string, ok: bool) {
    if !com_connected() do return

    bstr_constants: BStr
    hr := cbopenif->GetProjectConstants(&bstr_constants)
    if com_failed(hr) do return

    if bstr_constants != nil {
        defer bstr_free(bstr_constants)
        constants = from_bstr(bstr_constants)
    }

    return constants, true
}

cbopen_set_project_constants :: proc(constants: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_constants := to_bstr(constants)
    defer bstr_free(bstr_constants)

    bstr_messages: BStr
    hr := cbopenif->SetProjectConstants(bstr_constants, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_library :: proc(library_name, directory_path, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_library_name   := to_bstr(library_name)
    bstr_directory_path := to_bstr(directory_path)
    bstr_guid           := to_bstr(guid)
    defer {
        bstr_free(bstr_library_name)
        bstr_free(bstr_directory_path)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->NewLibrary(bstr_library_name, bstr_directory_path, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_library :: proc(file_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_file_path := to_bstr(file_path)
    defer bstr_free(bstr_file_path)
    hr := cbopenif->InsertLibrary(bstr_file_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_library :: proc(library_name, new_library_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_library_name     := to_bstr(library_name)
    bstr_new_library_name := to_bstr(new_library_name)
    defer {
        bstr_free(bstr_library_name)
        bstr_free(bstr_new_library_name)
    }

    hr := cbopenif->RenameLibrary(bstr_library_name, bstr_new_library_name)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_library :: proc(library_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_library_name := to_bstr(library_name)
    defer bstr_free(bstr_library_name)

    hr := cbopenif->DeleteLibrary(bstr_library_name)
    if !com_failed(hr) do return

    return true
}

cbopen_get_library_project_constants :: proc(library_name: string) -> (constants: string, ok: bool) {
    if !com_connected() do return

    bstr_library_name := to_bstr(library_name)
    defer bstr_free(bstr_library_name)

    bstr_constants: BStr
    hr := cbopenif->GetLibraryProjectConstants(bstr_library_name, &bstr_constants)
    if com_failed(hr) do return

    if bstr_constants != nil {
        defer bstr_free(bstr_constants)
        constants = from_bstr(bstr_constants)
    }

    return constants, true
}

cbopen_set_library_project_constants :: proc(library_name, constants: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_library_name := to_bstr(library_name)
    bstr_constants    := to_bstr(constants)
    defer {
        bstr_free(bstr_library_name)
        bstr_free(bstr_constants)
    }

    bstr_messages: BStr
    hr := cbopenif->SetLibraryProjectConstants(bstr_library_name, bstr_constants, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_application :: proc(application_name, directory_path, guid, template_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_application_name := to_bstr(application_name)
    bstr_directory_path   := to_bstr(directory_path)
    bstr_guid             := to_bstr(guid)
    bstr_template         := to_bstr(template_name)
    defer {
        bstr_free(bstr_application_name)
        bstr_free(bstr_directory_path)
        bstr_free(bstr_guid)
        bstr_free(bstr_template)
    }
    hr := cbopenif->NewApplication(bstr_application_name, bstr_directory_path, bstr_guid, bstr_template)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_application :: proc(file_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_file_path := to_bstr(file_path)
    defer bstr_free(bstr_file_path)
    hr := cbopenif->InsertApplication(bstr_file_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_application :: proc(application_name, new_application_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_application_name     := to_bstr(application_name)
    bstr_new_application_name := to_bstr(new_application_name)
    defer {
        bstr_free(bstr_application_name)
        bstr_free(bstr_new_application_name)
    }
    hr := cbopenif->RenameApplication(bstr_application_name, bstr_new_application_name)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_application :: proc(application_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_application_name := to_bstr(application_name)
    defer bstr_free(bstr_application_name)
    hr := cbopenif->DeleteApplication(bstr_application_name)
    if !com_failed(hr) do return

    return true
}

cbopen_get_application_variables :: proc(application_name: string) -> (variables: string, ok: bool) {
    if !com_connected() do return

    bstr_application_name := to_bstr(application_name)
    defer bstr_free(bstr_application_name)

    bstr_variables: BStr
    hr := cbopenif->GetApplicationVariables(bstr_application_name, &bstr_variables)
    if com_failed(hr) do return

    if bstr_variables != nil {
        defer bstr_free(bstr_variables)
        variables = from_bstr(bstr_variables)
    }

    return variables, true
}

cbopen_set_application_variables :: proc(application_name, variables: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_application_name := to_bstr(application_name)
    bstr_variables        := to_bstr(variables)
    defer {
        bstr_free(bstr_application_name)
        bstr_free(bstr_variables)
    }

    bstr_messages: BStr
    hr := cbopenif->SetApplicationVariables(bstr_application_name, bstr_variables, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_task_connection :: proc(object_path: string) -> (task_connection: string, ok: bool) {
    if !com_connected() do return

    bstr_object_path := to_bstr(object_path)
    defer bstr_free(bstr_object_path)

    bstr_conn: BStr
    hr := cbopenif->GetTaskConnection(bstr_object_path, &bstr_conn)
    if com_failed(hr) do return

    if bstr_conn != nil {
        defer bstr_free(bstr_conn)
        task_connection = from_bstr(bstr_conn)
    }

    return task_connection, true
}

cbopen_set_task_connection :: proc(object_path, task_connection: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_object_path     := to_bstr(object_path)
    bstr_task_connection := to_bstr(task_connection)
    defer {
        bstr_free(bstr_object_path)
        bstr_free(bstr_task_connection)
    }
    hr := cbopenif->SetTaskConnection(bstr_object_path, bstr_task_connection)
    if !com_failed(hr) do return

    return true
}

cbopen_new_controller :: proc(controller_name, controller_type, directory_path, guid, template_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_controller_name := to_bstr(controller_name)
    bstr_controller_type := to_bstr(controller_type)
    bstr_directory_path  := to_bstr(directory_path)
    bstr_guid            := to_bstr(guid)
    bstr_template        := to_bstr(template_name)
    defer {
        bstr_free(bstr_controller_name)
        bstr_free(bstr_controller_type)
        bstr_free(bstr_directory_path)
        bstr_free(bstr_guid)
        bstr_free(bstr_template)
    }
    hr := cbopenif->NewController(bstr_controller_name, bstr_controller_type, bstr_directory_path, bstr_guid, bstr_template)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_controller :: proc(file_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_file_path := to_bstr(file_path)
    defer bstr_free(bstr_file_path)
    hr := cbopenif->InsertController(bstr_file_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_controller :: proc(controller_name, new_controller_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_controller_name     := to_bstr(controller_name)
    bstr_new_controller_name := to_bstr(new_controller_name)
    defer {
        bstr_free(bstr_controller_name)
        bstr_free(bstr_new_controller_name)
    }
    hr := cbopenif->RenameController(bstr_controller_name, bstr_new_controller_name)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_controller :: proc(controller_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_controller_name := to_bstr(controller_name)
    defer bstr_free(bstr_controller_name)
    hr := cbopenif->DeleteController(bstr_controller_name)
    if !com_failed(hr) do return

    return true
}

cbopen_get_system_identity :: proc(controller_name: string) -> (system_identity: string, ok: bool) {
    if !com_connected() do return

    bstr_controller_name := to_bstr(controller_name)
    defer bstr_free(bstr_controller_name)

    bstr_system_identity: BStr
    hr := cbopenif->GetSystemIdentity(bstr_controller_name, &bstr_system_identity)
    if com_failed(hr) do return

    if bstr_system_identity != nil {
        defer bstr_free(bstr_system_identity)
        system_identity = from_bstr(bstr_system_identity)
    }

    return system_identity, true
}

cbopen_set_system_identity :: proc(controller_name, system_identity: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_controller_name := to_bstr(controller_name)
    bstr_system_identity := to_bstr(system_identity)
    defer {
        bstr_free(bstr_controller_name)
        bstr_free(bstr_system_identity)
    }
    hr := cbopenif->SetSystemIdentity(bstr_controller_name, bstr_system_identity)
    if !com_failed(hr) do return

    return true
}

cbopen_new_data_type :: proc(name, app_or_library_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_content             := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDataType(bstr_name, bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_data_type :: proc(data_type_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_data_type_path := to_bstr(data_type_path)
    defer bstr_free(bstr_data_type_path)

    bstr_content: BStr
    hr := cbopenif->GetDataType(bstr_data_type_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_data_type :: proc(data_type_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_data_type_path := to_bstr(data_type_path)
    bstr_content        := to_bstr(content)
    defer {
        bstr_free(bstr_data_type_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDataType(bstr_data_type_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_data_type :: proc(data_type_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_data_type_path := to_bstr(data_type_path)
    defer bstr_free(bstr_data_type_path)
    hr := cbopenif->DeleteDataType(bstr_data_type_path)
    if !com_failed(hr) do return

    return true
}

cbopen_new_function_block_type :: proc(fbstr_type_name, app_or_library_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(fbstr_type_name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_content             := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewFunctionBlockType(bstr_name, bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_function_block_type :: proc(fbstr_type_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(fbstr_type_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetFunctionBlockType(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_function_block_type :: proc(fbstr_type_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(fbstr_type_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetFunctionBlockType(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_function_block_type :: proc(fbstr_type_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(fbstr_type_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteFunctionBlockType(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_new_control_module_type :: proc(cm_type_name, app_or_library_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(cm_type_name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_content             := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewControlModuleType(bstr_name, bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_control_module_type :: proc(cm_type_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(cm_type_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetControlModuleType(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_control_module_type :: proc(cm_type_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(cm_type_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetControlModuleType(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_control_module_type :: proc(cm_type_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(cm_type_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteControlModuleType(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_new_control_module :: proc(cm_name, cm_type, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(cm_name)
    bstr_type    := to_bstr(cm_type)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewControlModule(bstr_name, bstr_type, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_single_control_module :: proc(cm_name, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(cm_name)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewSingleControlModule(bstr_name, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_control_module :: proc(cm_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(cm_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetControlModule(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_control_module :: proc(cm_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(cm_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetControlModule(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_control_module :: proc(cm_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(cm_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteControlModule(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_new_program :: proc(program_name, application_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(program_name)
    bstr_app_or_library_name := to_bstr(application_name)
    bstr_content             := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewProgram(bstr_name, bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_program :: proc(program_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(program_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetProgram(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_program :: proc(program_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(program_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetProgram(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_program :: proc(program_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(program_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteProgram(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_get_access_variables :: proc(controller_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetAccessVariables(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_access_variables :: proc(controller_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(controller_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetAccessVariables(bstr_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_task :: proc(task_name, controller_name, content: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(task_name)
    bstr_ctrl    := to_bstr(controller_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_ctrl)
        bstr_free(bstr_content)
    }
    hr := cbopenif->NewTask(bstr_name, bstr_ctrl, bstr_content)
    if !com_failed(hr) do return

    return true
}

cbopen_get_task :: proc(task_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(task_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetTask(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_task :: proc(task_path, content: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(task_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }
    hr := cbopenif->SetTask(bstr_path, bstr_content)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_task :: proc(task_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(task_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteTask(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_get_connected_applications :: proc(controller_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetConnectedApplications(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_connected_applications :: proc(controller_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(controller_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetConnectedApplications(bstr_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !com_connected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->Online(&vb, &bstr_messages)
    if com_failed(hr) do return

    is_online = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return is_online, messages, true
}

cbopen_download_and_go_online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !com_connected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->DownloadAndGoOnline(&vb, &bstr_messages)
    if com_failed(hr) do return

    is_online = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return is_online, messages, true
}

cbopen_test_mode :: proc() -> (is_test_mode: bool, messages: string, ok: bool) {
    if !com_connected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->TestMode(&vb, &bstr_messages)
    if com_failed(hr) do return

    is_test_mode = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return is_test_mode, messages, true
}

cbopen_offline :: proc() -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_messages: BStr
    hr := cbopenif->Offline(&bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_hardware_unit :: proc(hw_path: string, hw_type_id: Variant, hw_qualifier, hw_unit_content, redundant_to: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path      := to_bstr(hw_path)
    bstr_qualifier := to_bstr(hw_qualifier)
    bstr_content   := to_bstr(hw_unit_content)
    bstr_red       := to_bstr(redundant_to)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_qualifier)
        bstr_free(bstr_content)
        bstr_free(bstr_red)
    }

    bstr_messages: BStr
    hr := cbopenif->NewHardwareUnit(bstr_path, hw_type_id, bstr_qualifier, bstr_content, bstr_red, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_hardware_unit :: proc(hw_path: string, include_substr_units: bool) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(hw_path)
    defer bstr_free(bstr_path)

    vb: VariantBool = VariantBoolTrue if include_substr_units else VariantBoolFalse
    bstr_content: BStr
    hr := cbopenif->GetHardwareUnit(bstr_path, vb, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_get_hardware_type :: proc(hardware_library_name, hardware_type_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_lib  := to_bstr(hardware_library_name)
    bstr_type := to_bstr(hardware_type_name)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_type)
    }

    bstr_content: BStr
    hr := cbopenif->GetHardwareType(bstr_lib, bstr_type, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_hardware_unit :: proc(hw_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(hw_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetHardwareUnit(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_hardware_unit :: proc(hw_path: string, remove_redundant_only: bool) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(hw_path)
    defer bstr_free(bstr_path)

    vb: VariantBool = VariantBoolTrue if remove_redundant_only else VariantBoolFalse
    hr := cbopenif->DeleteHardwareUnit(bstr_path, vb)
    if !com_failed(hr) do return

    return true
}

cbopen_move_hardware_unit_to :: proc(old_hw_path, new_hw_path: string, do_swap: bool) -> (ok: bool) {
    if !com_connected() do return

    bstr_old := to_bstr(old_hw_path)
    bstr_new := to_bstr(new_hw_path)
    defer {
        bstr_free(bstr_old)
        bstr_free(bstr_new)
    }

    vb: VariantBool = VariantBoolTrue if do_swap else VariantBoolFalse
    hr := cbopenif->MoveHardwareUnitTo(bstr_old, bstr_new, vb)
    if !com_failed(hr) do return

    return true
}

cbopen_get_project_tree :: proc(path: string, depth: i32, include_runtime_instances: bool) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)

    vb: VariantBool = VariantBoolTrue if include_runtime_instances else VariantBoolFalse
    bstr_content: BStr
    hr := cbopenif->GetProjectTree(bstr_path, depth, vb, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_new_function_block :: proc(fbstr_name, fbstr_type, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(fbstr_name)
    bstr_type    := to_bstr(fbstr_type)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewFunctionBlock(bstr_name, bstr_type, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_function_block :: proc(fbstr_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(fbstr_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetFunctionBlock(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_function_block :: proc(fbstr_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(fbstr_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetFunctionBlock(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_function_block :: proc(fbstr_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(fbstr_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteFunctionBlock(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_reserve :: proc(fou_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(fou_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->Reserve(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_is_reserved_by :: proc(fou_name: string) -> (reserver: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(fou_name)
    defer bstr_free(bstr_name)

    bstr_reserver: BStr
    hr := cbopenif->IsReservedBy(bstr_name, &bstr_reserver)
    if com_failed(hr) do return

    if bstr_reserver != nil {
        defer bstr_free(bstr_reserver)
        reserver = from_bstr(bstr_reserver)
    }

    return reserver, true
}

cbopen_release_reservation :: proc(fou_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(fou_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->ReleaseReservation(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_get_setting :: proc(setting_name: string) -> (value: Variant, ok: bool) {
    if !com_connected() do return

    variant_init(&value)
    bstr_name := to_bstr(setting_name)
    defer bstr_free(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &value)
    if com_failed(hr) {
        variant_free(&value)
        return
    }

    return value, true
}

cbopen_set_setting_string :: proc(setting_name: string, setting: string) -> (ok: bool) {
    if !com_connected() do return

    v_setting_name := to_variant(setting_name)
    v_setting      := to_variant(setting)
    defer {
        variant_free(&v_setting_name)
        variant_free(&v_setting)
    }

    args := []Variant{ v_setting_name, v_setting }

    this := cast(^IUnknownIF)cbopenif
    ok = com_invoke_name(this, "SetSetting", args, nil)
    if !ok do return

    return true
}

cbopen_set_setting_bool :: proc(setting_name: string, setting: bool) -> (ok: bool) {
    if !com_connected() do return

    v_setting_name := to_variant(setting_name)
    v_setting      := to_variant(setting)
    defer {
        variant_free(&v_setting_name)
        variant_free(&v_setting)
    }

    args := []Variant{ v_setting_name, v_setting }

    this := cast(^IUnknownIF)cbopenif
    ok = com_invoke_name(this, "SetSetting", args, nil)
    if !ok do return

    return true
}

cbopen_get_application_control_modules :: proc(application_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(application_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetApplicationControlModules(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_application_control_modules :: proc(application_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(application_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetApplicationControlModules(bstr_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_parameter :: proc(parameter_kind: t.ParameterKind, parameter_name, data_type, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(parameter_name)
    bstr_dtype   := to_bstr(data_type)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_dtype)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewParameter(i32(parameter_kind), bstr_name, bstr_dtype, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_parameter :: proc(parameter_kind: t.ParameterKind, parameter_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(parameter_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetParameter(i32(parameter_kind), bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_parameter :: proc(parameter_kind: t.ParameterKind, parameter_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(parameter_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetParameter(i32(parameter_kind), bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_parameter :: proc(parameter_kind: t.ParameterKind, parameter_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(parameter_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteParameter(i32(parameter_kind), bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_new_variable :: proc(variable_kind: t.VariableKind, variable_name, data_type, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(variable_name)
    bstr_dtype   := to_bstr(data_type)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_dtype)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewVariable(i32(variable_kind), bstr_name, bstr_dtype, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_variable :: proc(variable_kind: t.VariableKind, variable_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(variable_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetVariable(i32(variable_kind), bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_variable :: proc(variable_kind: t.VariableKind, variable_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(variable_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetVariable(i32(variable_kind), bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_variable :: proc(variable_kind: t.VariableKind, variable_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(variable_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteVariable(i32(variable_kind), bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_get_cm_connection :: proc(connection_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(connection_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetCMConnection(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_cm_connection :: proc(connection_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(connection_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetCMConnection(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_code_block :: proc(codeblock_kind: t.CodeBlockKind, code_block_name, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(code_block_name)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewCodeBlock(i32(codeblock_kind), bstr_name, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_code_block :: proc(code_block_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(code_block_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetCodeBlock(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_code_block :: proc(code_block_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(code_block_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetCodeBlock(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_code_block :: proc(code_block_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(code_block_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteCodeBlock(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_get_one_instance_init_vals :: proc(instance_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(instance_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetOneInstanceInitVals(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_get_all_instances_init_vals :: proc(path_to_parent: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path_to_parent)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetAllInstancesInitVals(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_one_instance_init_vals :: proc(instance_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(instance_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetOneInstanceInitVals(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_set_all_instances_init_vals :: proc(path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetAllInstancesInitVals(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_one_instance_init_vals :: proc(instance_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(instance_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteOneInstanceInitVals(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_all_instances_init_vals :: proc(path_to_parent: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path_to_parent)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteAllInstancesInitVals(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_instance_data_path :: proc(old_path, new_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_old := to_bstr(old_path)
    bstr_new := to_bstr(new_path)
    defer {
        bstr_free(bstr_old)
        bstr_free(bstr_new)
    }
    hr := cbopenif->RenameInstanceDataPath(bstr_old, bstr_new)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_data_type :: proc(data_type_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(data_type_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameDataType(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_function_block_type :: proc(fbstr_type_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(fbstr_type_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameFunctionBlockType(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_control_module_type :: proc(cm_type_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(cm_type_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameControlModuleType(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_get_single_control_module :: proc(path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetSingleControlModule(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_single_control_module :: proc(path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetSingleControlModule(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_single_control_module :: proc(path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteSingleControlModule(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_get_connected_libraries :: proc(app_or_library_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(app_or_library_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetConnectedLibraries(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_connected_libraries :: proc(app_or_library_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(app_or_library_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetConnectedLibraries(bstr_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_set_library_version :: proc(library_name: string, major, minor, revision: i32) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(library_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->SetLibraryVersion(bstr_name, major, minor, revision)
    if !com_failed(hr) do return

    return true
}

cbopen_set_application_version :: proc(application_name: string, major, minor, revision: i32) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(application_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->SetApplicationVersion(bstr_name, major, minor, revision)

    if !com_failed(hr) do return

    return true
}

cbopen_set_controller_version :: proc(controller_name: string, major, minor, revision: i32) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->SetControllerVersion(bstr_name, major, minor, revision)
    if !com_failed(hr) do return

    return true
}

cbopen_get_library_state :: proc(library_name: string) -> (state: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(library_name)
    defer bstr_free(bstr_name)

    bstr_state: BStr
    hr := cbopenif->GetLibraryState(bstr_name, &bstr_state)
    if com_failed(hr) do return

    if bstr_state != nil {
        defer bstr_free(bstr_state)
        state = from_bstr(bstr_state)
    }

    return state, true
}

cbopen_set_library_state :: proc(library_name, state: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name  := to_bstr(library_name)
    bstr_state := to_bstr(state)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_state)
    }
    hr := cbopenif->SetLibraryState(bstr_name, bstr_state)
    if !com_failed(hr) do return

    return true
}

cbopen_connect_library :: proc(app_or_library_name, library_to_connect: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_lib                 := to_bstr(library_to_connect)
    defer {
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_lib)
    }
    hr := cbopenif->ConnectLibrary(bstr_app_or_library_name, bstr_lib)
    if !com_failed(hr) do return

    return true
}

cbopen_disconnect_library :: proc(app_or_library_name, library_to_disconnect: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_lib                 := to_bstr(library_to_disconnect)
    defer {
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_lib)
    }
    hr := cbopenif->DisconnectLibrary(bstr_app_or_library_name, bstr_lib)
    if !com_failed(hr) do return

    return true
}

cbopen_get_controller_properties :: proc(controller_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetControllerProperties(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_controller_properties :: proc(controller_name, content: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(controller_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }
    hr := cbopenif->SetControllerProperties(bstr_name, bstr_content)
    if !com_failed(hr) do return

    return true
}

cbopen_get_type_path_from_guid :: proc(app_or_library_name, guid: string) -> (type_path: string, ok: bool) {
    if !com_connected() do return

    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_guid := to_bstr(guid)
    defer {
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }

    bstr_path: BStr
    hr := cbopenif->GetTypePathFromGUID(bstr_app_or_library_name, bstr_guid, &bstr_path)
    if com_failed(hr) do return

    if bstr_path != nil {
        defer bstr_free(bstr_path)
        type_path = from_bstr(bstr_path)
    }

    return type_path, true
}

cbopen_rename_program :: proc(program_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(program_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameProgram(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_function_block :: proc(fbstr_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(fbstr_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameFunctionBlock(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_control_module :: proc(cm_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(cm_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameControlModule(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_task :: proc(task_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(task_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameTask(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_refresh_project :: proc() -> (ok: bool) {
    if !com_connected() do return

    hr := cbopenif->RefreshProject()
    if !com_failed(hr) do return

    return true
}

cbopen_refresh_library :: proc(library_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(library_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->RefreshLibrary(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_refresh_application :: proc(application_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(application_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->RefreshApplication(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_refresh_controller :: proc(controller_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)
    hr := cbopenif->RefreshController(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_replace_hardware_unit_type :: proc(hw_path: string, hw_type_id: Variant, hw_qualifier: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path      := to_bstr(hw_path)
    bstr_qualifier := to_bstr(hw_qualifier)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_qualifier)
    }
    hr := cbopenif->ReplaceHardwareUnitType(bstr_path, hw_type_id, bstr_qualifier)
    if !com_failed(hr) do return

    return true
}

cbopen_get_valid_hardware_positions :: proc(hw_father_path: string, hw_type_id: Variant, hw_qualifier: string) -> (positions: string, ok: bool) {
    if !com_connected() do return

    bstr_path      := to_bstr(hw_father_path)
    bstr_qualifier := to_bstr(hw_qualifier)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_qualifier)
    }

    bstr_positions: BStr
    hr := cbopenif->GetValidHardwarePositions(bstr_path, hw_type_id, bstr_qualifier, &bstr_positions)
    if com_failed(hr) do return

    if bstr_positions != nil {
        defer bstr_free(bstr_positions)
        positions = from_bstr(bstr_positions)
    }

    return positions, true
}

cbopen_insert_data_type :: proc(name, app_or_library_name, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_guid                := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertDataType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_function_block_type :: proc(name, app_or_library_name, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_guid                := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertFunctionBlockType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_control_module_type :: proc(name, app_or_library_name, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_guid                := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertControlModuleType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_program :: proc(name, application_name, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(application_name)
    bstr_guid                := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertProgram(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_single_control_module :: proc(module_name, path_to_parent, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name   := to_bstr(module_name)
    bstr_parent := to_bstr(path_to_parent)
    bstr_guid   := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertSingleControlModule(bstr_name, bstr_parent, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_get_application_properties :: proc(application_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(application_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetApplicationProperties(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_application_properties :: proc(application_name, content: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(application_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }
    hr := cbopenif->SetApplicationProperties(bstr_name, bstr_content)
    if !com_failed(hr) do return

    return true
}

cbopen_new_hardware_library :: proc(name, directory_path, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(name)
    bstr_directory_path  := to_bstr(directory_path)
    bstr_guid := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_directory_path)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->NewHardwareLibrary(bstr_name, bstr_directory_path, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_hardware_library :: proc(file_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(file_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->InsertHardwareLibrary(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_hardware_library :: proc(name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := cbopenif->DeleteHardwareLibrary(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_connect_hardware_library :: proc(controller_name, hw_lib: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_ctrl := to_bstr(controller_name)
    bstr_lib  := to_bstr(hw_lib)
    defer {
        bstr_free(bstr_ctrl)
        bstr_free(bstr_lib)
    }
    hr := cbopenif->ConnectHardwareLibrary(bstr_ctrl, bstr_lib)
    if !com_failed(hr) do return

    return true
}

cbopen_disconnect_hardware_library :: proc(controller_name, hw_lib: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_ctrl := to_bstr(controller_name)
    bstr_lib  := to_bstr(hw_lib)
    defer {
        bstr_free(bstr_ctrl)
        bstr_free(bstr_lib)
    }
    hr := cbopenif->DisconnectHardwareLibrary(bstr_ctrl, bstr_lib)
    if !com_failed(hr) do return

    return true
}

cbopen_get_hardware_library_state :: proc(name: string) -> (state: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)

    bstr_state: BStr
    hr := cbopenif->GetHardwareLibraryState(bstr_name, &bstr_state)
    if com_failed(hr) do return

    if bstr_state != nil {
        defer bstr_free(bstr_state)
        state = from_bstr(bstr_state)
    }

    return state, true
}

cbopen_set_hardware_library_state :: proc(name, state: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name  := to_bstr(name)
    bstr_state := to_bstr(state)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_state)
    }
    hr := cbopenif->SetHardwareLibraryState(bstr_name, bstr_state)
    if !com_failed(hr) do return

    return true
}

cbopen_set_hardware_library_version :: proc(name: string, major, minor, revision: i32) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := cbopenif->SetHardwareLibraryVersion(bstr_name, major, minor, revision)
    if !com_failed(hr) do return

    return true
}

cbopen_copy_hardware_type :: proc(src_lib, src_guid, dst_lib, dst_guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_src_lib  := to_bstr(src_lib)
    bstr_src_guid := to_bstr(src_guid)
    bstr_dst_lib  := to_bstr(dst_lib)
    bstr_dst_guid := to_bstr(dst_guid)
    defer {
        bstr_free(bstr_src_lib)
        bstr_free(bstr_src_guid)
        bstr_free(bstr_dst_lib)
        bstr_free(bstr_dst_guid)
    }
    hr := cbopenif->CopyHardwareType(bstr_src_lib, bstr_src_guid, bstr_dst_lib, bstr_dst_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_hardware_type :: proc(libstr_name, type_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_lib  := to_bstr(libstr_name)
    bstr_type := to_bstr(type_name)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_type)
    }
    hr := cbopenif->DeleteHardwareType(bstr_lib, bstr_type)
    if !com_failed(hr) do return

    return true
}

cbopen_get_connected_hardware_libraries :: proc(controller_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)

    bstr_content: BStr
    hr := cbopenif->GetConnectedHardwareLibraries(bstr_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_connected_hardware_libraries :: proc(controller_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(controller_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetConnectedHardwareLibraries(bstr_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_copy_hardware_library :: proc(src_name, dst_name, dst_guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_src  := to_bstr(src_name)
    bstr_dst  := to_bstr(dst_name)
    bstr_guid := to_bstr(dst_guid)
    defer {
        bstr_free(bstr_src)
        bstr_free(bstr_dst)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->CopyHardwareLibrary(bstr_src, bstr_dst, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_refresh_hardware_library :: proc(name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(name)
    defer bstr_free(bstr_name)
    hr := cbopenif->RefreshHardwareLibrary(bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_replace_connected_hardware_library :: proc(controller_name, connected_name, replacing_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_ctrl := to_bstr(controller_name)
    bstr_conn := to_bstr(connected_name)
    bstr_repl := to_bstr(replacing_name)
    defer {
        bstr_free(bstr_ctrl)
        bstr_free(bstr_conn)
        bstr_free(bstr_repl)
    }
    hr := cbopenif->ReplaceConnectedHardwareLibrary(bstr_ctrl, bstr_conn, bstr_repl)
    if !com_failed(hr) do return

    return true
}

cbopen_add_hardware_type_file :: proc(libstr_name, type_guid: string, file_type: t.HardwareFile, file_path, version, build_version, build_date, fw_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_lib   := to_bstr(libstr_name)
    bstr_guid  := to_bstr(type_guid)
    bstr_path  := to_bstr(file_path)
    bstr_ver   := to_bstr(version)
    bstr_bver  := to_bstr(build_version)
    bstr_bdate := to_bstr(build_date)
    bstr_fw    := to_bstr(fw_name)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_guid)
        bstr_free(bstr_path)
        bstr_free(bstr_ver)
        bstr_free(bstr_bver)
        bstr_free(bstr_bdate)
        bstr_free(bstr_fw)
    }
    hr := cbopenif->AddHardwareTypeFile(bstr_lib, bstr_guid, i32(file_type), bstr_path, bstr_ver, bstr_bver, bstr_bdate, bstr_fw)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_hardware_type :: proc(type_name, libstr_name, type_guid, type_id: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_type := to_bstr(type_name)
    bstr_lib  := to_bstr(libstr_name)
    bstr_guid := to_bstr(type_guid)
    bstr_id   := to_bstr(type_id)
    defer {
        bstr_free(bstr_type)
        bstr_free(bstr_lib)
        bstr_free(bstr_guid)
        bstr_free(bstr_id)
    }
    hr := cbopenif->InsertHardwareType(bstr_type, bstr_lib, bstr_guid, bstr_id)
    if !com_failed(hr) do return

    return true
}

cbopen_replace_connected_library :: proc(app_or_library_name, connected_name, replacing_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_conn                := to_bstr(connected_name)
    bstr_repl                := to_bstr(replacing_name)
    defer {
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_conn)
        bstr_free(bstr_repl)
    }
    hr := cbopenif->ReplaceConnectedLibrary(bstr_app_or_library_name, bstr_conn, bstr_repl)
    if !com_failed(hr) do return

    return true
}

cbopen_new_project_in_environment :: proc(project_name, guid, template_name, environment_guid_or_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(project_name)
    bstr_guid := to_bstr(guid)
    bstr_tmpl := to_bstr(template_name)
    bstr_env  := to_bstr(environment_guid_or_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_guid)
        bstr_free(bstr_tmpl)
        bstr_free(bstr_env)
    }
    hr := cbopenif->NewProjectInEnvironment(bstr_name, bstr_guid, bstr_tmpl, bstr_env)
    if !com_failed(hr) do return

    return true
}

cbopen_open_project_in_environment :: proc(project_guid_or_name, environment_guid_or_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_proj := to_bstr(project_guid_or_name)
    bstr_env  := to_bstr(environment_guid_or_name)
    defer {
        bstr_free(bstr_proj)
        bstr_free(bstr_env)
    }
    hr := cbopenif->OpenProjectInEnvironment(bstr_proj, bstr_env)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_hardware_library :: proc(name, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(name)
    bstr_new  := to_bstr(new_name)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_new)
    }
    hr := cbopenif->RenameHardwareLibrary(bstr_name, bstr_new)
    if !com_failed(hr) do return

    return true
}

cbopen_get_project_and_environment_information :: proc() -> (project_name, project_guid, environment_name, environment_guid: string, ok: bool) {
    if !com_connected() do return

    bstr_pname, bstr_pguid, bstr_ename, bstr_eguid: BStr
    hr := cbopenif->GetProjectAndEnvironmentInformation(&bstr_pname, &bstr_pguid, &bstr_ename, &bstr_eguid)
    if com_failed(hr) do return

    if bstr_pname != nil {
        defer bstr_free(bstr_pname)
        project_name = from_bstr(bstr_pname)
    }
    if bstr_pguid != nil {
        defer bstr_free(bstr_pguid)
        project_guid = from_bstr(bstr_pguid)
    }
    if bstr_ename != nil {
        defer bstr_free(bstr_ename)
        environment_name = from_bstr(bstr_ename)
    }
    if bstr_eguid != nil {
        defer bstr_free(bstr_eguid)
        environment_guid = from_bstr(bstr_eguid)
    }

    return project_name, project_guid, environment_name, environment_guid, true
}

cbopen_set_storage :: proc(p_iac_storage: rawptr) -> (ok: bool) {
    if !com_connected() do return

    hr := cbopenif->SetStorage(p_iac_storage)
    if !com_failed(hr) do return

    return true
}

cbopen_write_information :: proc(message: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_msg := to_bstr(message)
    defer bstr_free(bstr_msg)
    hr := cbopenif->WriteInformation(bstr_msg)
    if !com_failed(hr) do return

    return true
}

cbopen_write_warning :: proc(message: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_msg := to_bstr(message)
    defer bstr_free(bstr_msg)
    hr := cbopenif->WriteWarning(bstr_msg)
    if !com_failed(hr) do return

    return true
}

cbopen_write_error :: proc(message: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_msg := to_bstr(message)
    defer bstr_free(bstr_msg)
    hr := cbopenif->WriteError(bstr_msg)
    if !com_failed(hr) do return

    return true
}

cbopen_new_folder :: proc(folder_kind: t.Folder, folder_name, path_to_parent, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name   := to_bstr(folder_name)
    bstr_parent := to_bstr(path_to_parent)
    bstr_guid   := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->NewFolder(i32(folder_kind), bstr_name, bstr_parent, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_folder :: proc(folder_kind: t.Folder, folder_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(folder_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameFolder(i32(folder_kind), bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_delete_folder :: proc(folder_kind: t.Folder, folder_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(folder_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteFolder(i32(folder_kind), bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_move_folder :: proc(folder_kind: t.Folder, folder_path, destination_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(folder_path)
    bstr_dest := to_bstr(destination_path)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_dest)
    }
    hr := cbopenif->MoveFolder(i32(folder_kind), bstr_path, bstr_dest)
    if !com_failed(hr) do return

    return true
}

cbopen_move_folder_object :: proc(folder_kind: t.Folder, object_name, destination_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_obj  := to_bstr(object_name)
    bstr_dest := to_bstr(destination_path)
    defer {
        bstr_free(bstr_obj)
        bstr_free(bstr_dest)
    }
    hr := cbopenif->MoveFolderObject(i32(folder_kind), bstr_obj, bstr_dest)
    if !com_failed(hr) do return

    return true
}

cbopen_new_diagram :: proc(diagram_name, application_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(diagram_name)
    bstr_app_or_library_name := to_bstr(application_name)
    bstr_content             := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDiagram(bstr_name, bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_diagram :: proc(diagram_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(diagram_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetDiagram(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_diagram :: proc(diagram_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(diagram_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDiagram(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_diagram :: proc(diagram_path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(diagram_path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteDiagram(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_diagram :: proc(diagram_path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(diagram_path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameDiagram(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_diagram :: proc(diagram_name, application_name, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(diagram_name)
    bstr_app_or_library_name := to_bstr(application_name)
    bstr_guid                := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertDiagram(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_hardware_definition_file :: proc(hardware_library_name, file_path: string) -> (file_added: bool, messages: string, ok: bool) {
    if !com_connected() do return

    bstr_lib  := to_bstr(hardware_library_name)
    bstr_path := to_bstr(file_path)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_path)
    }

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->InsertHardwareDefinitionFile(bstr_lib, bstr_path, &vb, &bstr_messages)
    if com_failed(hr) do return

    file_added = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return file_added, messages, true
}

cbopen_get_execution_order :: proc(executioninstance_kind: t.ExecutionInstanceKind, application_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_app_or_library_name := to_bstr(application_name)
    defer bstr_free(bstr_app_or_library_name)

    bstr_content: BStr
    hr := cbopenif->GetExecutionOrder(i32(executioninstance_kind), bstr_app_or_library_name, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_execution_order :: proc(executioninstance_kind: t.ExecutionInstanceKind, application_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_app_or_library_name     := to_bstr(application_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetExecutionOrder(i32(executioninstance_kind), bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_new_diagram_type :: proc(name, app_or_library_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_content             := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDiagramType(bstr_name, bstr_app_or_library_name, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_diagram_type :: proc(path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetDiagramType(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_diagram_type :: proc(path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDiagramType(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_diagram_type :: proc(path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteDiagramType(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_diagram_type :: proc(path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameDiagramType(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_insert_diagram_type :: proc(name, app_or_library_name, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name                := to_bstr(name)
    bstr_app_or_library_name := to_bstr(app_or_library_name)
    bstr_guid                := to_bstr(guid)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_app_or_library_name)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertDiagramType(bstr_name, bstr_app_or_library_name, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_new_diagram_instance :: proc(name, diagram_type, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(name)
    bstr_type    := to_bstr(diagram_type)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_type)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewDiagramInstance(bstr_name, bstr_type, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_diagram_instance :: proc(path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetDiagramInstance(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_diagram_instance :: proc(path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetDiagramInstance(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_diagram_instance :: proc(path: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    defer bstr_free(bstr_path)
    hr := cbopenif->DeleteDiagramInstance(bstr_path)
    if !com_failed(hr) do return

    return true
}

cbopen_rename_diagram_instance :: proc(path, new_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(path)
    bstr_name := to_bstr(new_name)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_name)
    }
    hr := cbopenif->RenameDiagramInstance(bstr_path, bstr_name)
    if !com_failed(hr) do return

    return true
}

cbopen_new_signal :: proc(signal_kind: t.SignalKind, signal_name, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(signal_name)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->NewSignal(i32(signal_kind), bstr_name, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_signal :: proc(signal_kind: t.SignalKind, signal_name, path_to_parent: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_name   := to_bstr(signal_name)
    bstr_parent := to_bstr(path_to_parent)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
    }

    bstr_content: BStr
    hr := cbopenif->GetSignal(i32(signal_kind), bstr_name, bstr_parent, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_signal :: proc(signal_kind: t.SignalKind, signal_name, path_to_parent, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_name    := to_bstr(signal_name)
    bstr_parent  := to_bstr(path_to_parent)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetSignal(i32(signal_kind), bstr_name, bstr_parent, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_delete_signal :: proc(signal_kind: t.SignalKind, signal_name, path_to_parent: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name   := to_bstr(signal_name)
    bstr_parent := to_bstr(path_to_parent)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_parent)
    }
    hr := cbopenif->DeleteSignal(i32(signal_kind), bstr_name, bstr_parent)
    if !com_failed(hr) do return

    return true
}

cbopen_add_hardware_library_file :: proc(libstr_name: string, file_kind: t.HardwareLibraryFile, file_path, version: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_lib  := to_bstr(libstr_name)
    bstr_path := to_bstr(file_path)
    bstr_ver  := to_bstr(version)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_path)
        bstr_free(bstr_ver)
    }
    hr := cbopenif->AddHardwareLibraryFile(bstr_lib, i32(file_kind), bstr_path, bstr_ver)
    if !com_failed(hr) do return

    return true
}

cbopen_get_hardware_library_files :: proc(libstr_name: string) -> (files: string, ok: bool) {
    if !com_connected() do return

    bstr_lib := to_bstr(libstr_name)
    defer bstr_free(bstr_lib)

    bstr_files: BStr
    hr := cbopenif->GetHardwareLibraryFiles(bstr_lib, &bstr_files)
    if com_failed(hr) do return

    if bstr_files != nil {
        defer bstr_free(bstr_files)
        files = from_bstr(bstr_files)
    }

    return files, true
}

cbopen_delete_hardware_library_file :: proc(libstr_name: string, file_kind: t.HardwareLibraryFile, file_name: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_lib  := to_bstr(libstr_name)
    bstr_file := to_bstr(file_name)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_file)
    }
    hr := cbopenif->DeleteHardwareLibraryFile(bstr_lib, i32(file_kind), bstr_file)
    if !com_failed(hr) do return

    return true
}

cbopen_set_hardware_type :: proc(libstr_name, type_name, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_lib     := to_bstr(libstr_name)
    bstr_type    := to_bstr(type_name)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_type)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetHardwareType(bstr_lib, bstr_type, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_get_hardware_definition_info :: proc(libstr_name, type_name: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_lib  := to_bstr(libstr_name)
    bstr_type := to_bstr(type_name)
    defer {
        bstr_free(bstr_lib)
        bstr_free(bstr_type)
    }

    bstr_content: BStr
    hr := cbopenif->GetHardwareDefinitionInfo(bstr_lib, bstr_type, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_insert_hardware_unit :: proc(parent_hw_path, guid: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(parent_hw_path)
    bstr_guid := to_bstr(guid)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_guid)
    }
    hr := cbopenif->InsertHardwareUnit(bstr_path, bstr_guid)
    if !com_failed(hr) do return

    return true
}

cbopen_get_controller_settings :: proc(controller_name: string) -> (settings: string, ok: bool) {
    if !com_connected() do return

    bstr_name := to_bstr(controller_name)
    defer bstr_free(bstr_name)

    bstr_settings: BStr
    hr := cbopenif->GetControllerSettings(bstr_name, &bstr_settings)
    if com_failed(hr) do return

    if bstr_settings != nil {
        defer bstr_free(bstr_settings)
        settings = from_bstr(bstr_settings)
    }

    return settings, true
}

cbopen_set_controller_settings :: proc(controller_name, settings: string) -> (ok: bool) {
    if !com_connected() do return

    bstr_name     := to_bstr(controller_name)
    bstr_settings := to_bstr(settings)
    defer {
        bstr_free(bstr_name)
        bstr_free(bstr_settings)
    }
    hr := cbopenif->SetControllerSettings(bstr_name, bstr_settings)
    if !com_failed(hr) do return

    return true
}

cbopen_get_fd_connection :: proc(connection_path: string) -> (content: string, ok: bool) {
    if !com_connected() do return

    bstr_path := to_bstr(connection_path)
    defer bstr_free(bstr_path)

    bstr_content: BStr
    hr := cbopenif->GetFDConnection(bstr_path, &bstr_content)
    if com_failed(hr) do return

    if bstr_content != nil {
        defer bstr_free(bstr_content)
        content = from_bstr(bstr_content)
    }

    return content, true
}

cbopen_set_fd_connection :: proc(connection_path, content: string) -> (messages: string, ok: bool) {
    if !com_connected() do return

    bstr_path    := to_bstr(connection_path)
    bstr_content := to_bstr(content)
    defer {
        bstr_free(bstr_path)
        bstr_free(bstr_content)
    }

    bstr_messages: BStr
    hr := cbopenif->SetFDConnection(bstr_path, bstr_content, &bstr_messages)
    if com_failed(hr) do return

    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return messages, true
}

cbopen_list_available_libraries :: proc() -> (libraries: string, ok: bool) {
    if !com_connected() do return

    bstr_libs: BStr
    hr := cbopenif->ListAvailableLibraries(&bstr_libs)
    if com_failed(hr) do return

    if bstr_libs != nil {
        defer bstr_free(bstr_libs)
        libraries = from_bstr(bstr_libs)
    }

    return libraries, true
}

cbopen_list_available_hardware_libraries :: proc() -> (libraries: string, ok: bool) {
    if !com_connected() do return

    bstr_libs: BStr
    hr := cbopenif->ListAvailableHardwareLibraries(&bstr_libs)
    if com_failed(hr) do return

    if bstr_libs != nil {
        defer bstr_free(bstr_libs)
        libraries = from_bstr(bstr_libs)
    }

    return libraries, true
}

cbopen_loop_check_download_and_go_online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !com_connected() do return

    vb: VariantBool
    bstr_messages: BStr
    hr := cbopenif->LoopCheckDownloadAndGoOnline(&vb, &bstr_messages)
    if com_failed(hr) do return

    is_online = (vb == VariantBoolTrue)
    if bstr_messages != nil {
        defer bstr_free(bstr_messages)
        messages = from_bstr(bstr_messages)
    }

    return is_online, messages, true
}
