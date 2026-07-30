package cbopenif

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
    Guid             = 0x80040bd3,
    Decryption       = 0x80040bd4,
    Checksum         = 0x80040bd5,
    ChecksumCodePage = 0x80040bd6,
    InUse            = 0x80040bd7,
    Reservation      = 0x80040bd8
}

CBOpenIF :: struct #raw_union {
    #subtype unnknown_and_dispatch: UnknownAndDispatchIF,
    using vtable: ^CBOpenVTable,
}

cbopenif: ^CBOpenIF

CBOpenVTable :: struct {
    using unnknown_and_dispatch_vtable: UnknownAndDispatchVTable,
    NewProject:                          proc "system" (this: ^CBOpenIF, name, directory_path, guid, template_name: BStr) -> HResult,
    OpenProject:                         proc "system" (this: ^CBOpenIF, file_path: BStr) -> HResult,
    CloseProject:                        proc "system" (this: ^CBOpenIF) -> HResult,
    GetProjectConstants:                 proc "system" (this: ^CBOpenIF, constants: ^BStr) -> HResult,
    SetProjectConstants:                 proc "system" (this: ^CBOpenIF, constants: BStr, messages: ^BStr) -> HResult,
    NewLibrary:                          proc "system" (this: ^CBOpenIF, name, directory_path, guid: BStr) -> HResult,
    InsertLibrary:                       proc "system" (this: ^CBOpenIF, file_path: BStr) -> HResult,
    RenameLibrary:                       proc "system" (this: ^CBOpenIF, name, new_name: BStr) -> HResult,
    DeleteLibrary:                       proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    GetLibraryProjectConstants:          proc "system" (this: ^CBOpenIF, name: BStr, constants: ^BStr) -> HResult,
    SetLibraryProjectConstants:          proc "system" (this: ^CBOpenIF, name, constants: BStr, messages: ^BStr) -> HResult,
    NewApplication:                      proc "system" (this: ^CBOpenIF, name, directory_path, guid, template_name: BStr) -> HResult,
    InsertApplication:                   proc "system" (this: ^CBOpenIF, file_path: BStr) -> HResult,
    RenameApplication:                   proc "system" (this: ^CBOpenIF, name, new_name: BStr) -> HResult,
    DeleteApplication:                   proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    GetApplicationVariables:             proc "system" (this: ^CBOpenIF, name: BStr, variables: ^BStr) -> HResult,
    SetApplicationVariables:             proc "system" (this: ^CBOpenIF, name, variables: BStr, messages: ^BStr) -> HResult,
    GetTaskConnection:                   proc "system" (this: ^CBOpenIF, path: BStr, task_connection: ^BStr) -> HResult,
    SetTaskConnection:                   proc "system" (this: ^CBOpenIF, path, taskc_onnection: BStr) -> HResult,
    NewController:                       proc "system" (this: ^CBOpenIF, name, Type, directory_path, guid, template_name: BStr) -> HResult,
    InsertController:                    proc "system" (this: ^CBOpenIF, file_path: BStr) -> HResult,
    RenameController:                    proc "system" (this: ^CBOpenIF, name, new_name: BStr) -> HResult,
    DeleteController:                    proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    GetSystemIdentity:                   proc "system" (this: ^CBOpenIF, name: BStr, system_identity: ^BStr) -> HResult,
    SetSystemIdentity:                   proc "system" (this: ^CBOpenIF, name, system_identity: BStr) -> HResult,
    NewDataType:                         proc "system" (this: ^CBOpenIF, name, app_or_lib_name, content: BStr, messages: ^BStr) -> HResult,
    GetDataType:                         proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetDataType:                         proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteDataType:                      proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    NewFunctionBlockType:                proc "system" (this: ^CBOpenIF, name, app_or_lib_name, content: BStr, messages: ^BStr) -> HResult,
    GetFunctionBlockType:                proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetFunctionBlockType:                proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteFunctionBlockType:             proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    NewControlModuleType:                proc "system" (this: ^CBOpenIF, name, app_or_lib_name, content: BStr, messages: ^BStr) -> HResult,
    GetControlModuleType:                proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetControlModuleType:                proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteControlModuleType:             proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    NewControlModule:                    proc "system" (this: ^CBOpenIF, name, type, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    NewSingleControlModule:              proc "system" (this: ^CBOpenIF, name, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetControlModule:                    proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetControlModule:                    proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteControlModule:                 proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    NewProgram:                          proc "system" (this: ^CBOpenIF, path, application_name, content: BStr, messages: ^BStr) -> HResult,
    GetProgram:                          proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetProgram:                          proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteProgram:                       proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    GetAccessVariables:                  proc "system" (this: ^CBOpenIF, controller_name: BStr, content: ^BStr) -> HResult,
    SetAccessVariables:                  proc "system" (this: ^CBOpenIF, controller_name, content: BStr, messages: ^BStr) -> HResult,
    NewTask:                             proc "system" (this: ^CBOpenIF, name, controller_name, content: BStr) -> HResult,
    GetTask:                             proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetTask:                             proc "system" (this: ^CBOpenIF, path, content: BStr) -> HResult,
    DeleteTask:                          proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    GetConnectedApplications:            proc "system" (this: ^CBOpenIF, controller_name: BStr, content: ^BStr) -> HResult,
    SetConnectedApplications:            proc "system" (this: ^CBOpenIF, controller_name, content: BStr, messages: ^BStr) -> HResult,
    Online:                              proc "system" (this: ^CBOpenIF, is_online: ^VariantBool, messages: ^BStr) -> HResult,
    DownloadAndGoOnline:                 proc "system" (this: ^CBOpenIF, is_online: ^Variant, messages: ^BStr) -> HResult,
    TestMode:                            proc "system" (this: ^CBOpenIF, in_test_mode: ^Variant, messages: ^BStr) -> HResult,
    Offline:                             proc "system" (this: ^CBOpenIF, messages: ^BStr) -> HResult,
    NewHardwareUnit:                     proc "system" (this: ^CBOpenIF, path: BStr, hwTypeID: Variant, qualifier, content, redundant_to: BStr, messages: ^BStr) -> HResult,
    GetHardwareUnit:                     proc "system" (this: ^CBOpenIF, path: BStr, include_sub_units: Variant, content: ^BStr) -> HResult,
    GetHardwareType:                     proc "system" (this: ^CBOpenIF, name, type: BStr, content: ^BStr) -> HResult,
    SetHardwareUnit:                     proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteHardwareUnit:                  proc "system" (this: ^CBOpenIF, path: BStr, remove_redundant_only: Variant) -> HResult,
    MoveHardwareUnitTo:                  proc "system" (this: ^CBOpenIF, path, new_path: BStr, do_swap: Variant) -> HResult,
    GetProjectTree:                      proc "system" (this: ^CBOpenIF, path: BStr, depth: i32, include_runtime_instances: Variant, content: ^BStr) -> HResult,
    NewFunctionBlock:                    proc "system" (this: ^CBOpenIF, name, type, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetFunctionBlock:                    proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetFunctionBlock:                    proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteFunctionBlock:                 proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    Reserve:                             proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    IsReservedBy:                        proc "system" (this: ^CBOpenIF, name: BStr, reserver: ^BStr) -> HResult,
    ReleaseReservation:                  proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    GetSetting:                          proc "system" (this: ^CBOpenIF, name: BStr, value: ^Variant) -> HResult,
    SetSetting:                          proc "system" (this: ^CBOpenIF, name: BStr, value: Variant) -> HResult,
    GetApplicationControlModules:        proc "system" (this: ^CBOpenIF, name: BStr, content: ^BStr) -> HResult,
    SetApplicationControlModules:        proc "system" (this: ^CBOpenIF, name, content: BStr, messages: ^BStr) -> HResult,
    NewParameter:                        proc "system" (this: ^CBOpenIF, type: ParameterType, Name, data_type, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetParameter:                        proc "system" (this: ^CBOpenIF, type: ParameterType, path: BStr, content: ^BStr) -> HResult,
    SetParameter:                        proc "system" (this: ^CBOpenIF, type: ParameterType, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteParameter:                     proc "system" (this: ^CBOpenIF, type: ParameterType, path: BStr) -> HResult,
    NewVariable:                         proc "system" (this: ^CBOpenIF, type: VariableType, Name, data_type, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetVariable:                         proc "system" (this: ^CBOpenIF, type: VariableType, path: BStr, content: ^BStr) -> HResult,
    SetVariable:                         proc "system" (this: ^CBOpenIF, type: VariableType, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteVariable:                      proc "system" (this: ^CBOpenIF, type: VariableType, path: BStr) -> HResult,
    GetCMConnection:                     proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetCMConnection:                     proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    NewCodeBlock:                        proc "system" (this: ^CBOpenIF, type: CodeBlockType, Name, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetCodeBlock:                        proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetCodeBlock:                        proc "system" (this: ^CBOpenIF, Path, content: BStr, messages: ^BStr) -> HResult,
    DeleteCodeBlock:                     proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    GetOneInstanceInitVals:              proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    GetAllInstancesInitVals:             proc "system" (this: ^CBOpenIF, path_to_parent: BStr, content: ^BStr) -> HResult,
    SetOneInstanceInitVals:              proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    SetAllInstancesInitVals:             proc "system" (this: ^CBOpenIF, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    DeleteOneInstanceInitVals:           proc "system" (this: ^CBOpenIF, instance_path: BStr) -> HResult,
    DeleteAllInstancesInitVals:          proc "system" (this: ^CBOpenIF, path_to_parent: BStr) -> HResult,
    RenameInstanceDataPath:              proc "system" (this: ^CBOpenIF, path, new_path: BStr) -> HResult,
    RenameDataType:                      proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    RenameFunctionBlockType:             proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    RenameControlModuleType:             proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    GetSingleControlModule:              proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetSingleControlModule:              proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteSingleControlModule:           proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    GetConnectedLibraries:               proc "system" (this: ^CBOpenIF, app_or_lib_name: BStr, content: ^BStr) -> HResult,
    SetConnectedLibraries:               proc "system" (this: ^CBOpenIF, app_or_lib_name, content: BStr, messages: ^BStr) -> HResult,
    SetLibraryVersion:                   proc "system" (this: ^CBOpenIF, library_name: BStr, major_version, minor_version, revision: i32) -> HResult,
    SetApplicationVersion:               proc "system" (this: ^CBOpenIF, application_name: BStr, major_version, minor_version, revision: i32) -> HResult,
    SetControllerVersion:                proc "system" (this: ^CBOpenIF, controller_name: BStr, major_version, minor_version, revision: i32) -> HResult,
    GetLibraryState:                     proc "system" (this: ^CBOpenIF, library_name: BStr, libraryState: ^BStr) -> HResult,
    SetLibraryState:                     proc "system" (this: ^CBOpenIF, library_name, libraryState: BStr) -> HResult,
    ConnectLibrary:                      proc "system" (this: ^CBOpenIF, app_or_lib_name, library_name: BStr) -> HResult,
    DisconnectLibrary:                   proc "system" (this: ^CBOpenIF, app_or_lib_name, library_name: BStr) -> HResult,
    GetControllerProperties:             proc "system" (this: ^CBOpenIF, controller_name: BStr, content: ^BStr) -> HResult,
    SetControllerProperties:             proc "system" (this: ^CBOpenIF, controller_name, content: BStr) -> HResult,
    GetTypePathFromGuid:                 proc "system" (this: ^CBOpenIF, app_or_lib_name, guid: BStr, typePath: ^BStr) -> HResult,
    RenameProgram:                       proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    RenameFunctionBlock:                 proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    RenameControlModule:                 proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    RenameTask:                          proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    RefreshProject:                      proc "system" (this: ^CBOpenIF) -> HResult,
    RefreshLibrary:                      proc "system" (this: ^CBOpenIF, library_name: BStr) -> HResult,
    RefreshApplication:                  proc "system" (this: ^CBOpenIF, application_name: BStr) -> HResult,
    RefreshController:                   proc "system" (this: ^CBOpenIF, controller_name: BStr) -> HResult,
    ReplaceHardwareUnitType:             proc "system" (this: ^CBOpenIF, path: BStr, hwTypeID: Variant, qualifier: BStr) -> HResult,
    GetValidHardwarePositions:           proc "system" (this: ^CBOpenIF, hwFatherPath: BStr, hwTypeID: Variant, qualifier: BStr, positions: ^BStr) -> HResult,
    InsertDataType:                      proc "system" (this: ^CBOpenIF, name, app_or_lib_name, guid: BStr) -> HResult,
    InsertFunctionBlockType:             proc "system" (this: ^CBOpenIF, name, app_or_lib_name, guid: BStr) -> HResult,
    InsertControlModuleType:             proc "system" (this: ^CBOpenIF, name, app_or_lib_name, guid: BStr) -> HResult,
    InsertProgram:                       proc "system" (this: ^CBOpenIF, programName, application_name, guid: BStr) -> HResult,
    InsertSingleControlModule:           proc "system" (this: ^CBOpenIF, moduleName, path_to_parent, guid: BStr) -> HResult,
    GetApplicationProperties:            proc "system" (this: ^CBOpenIF, application_name: BStr, content: ^BStr) -> HResult,
    SetApplicationProperties:            proc "system" (this: ^CBOpenIF, application_name, content: BStr) -> HResult,
    NewHardwareLibrary:                  proc "system" (this: ^CBOpenIF, name, directory_path, guid: BStr) -> HResult,
    InsertHardwareLibrary:               proc "system" (this: ^CBOpenIF, file_path: BStr) -> HResult,
    DeleteHardwareLibrary:               proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    ConnectHardwareLibrary:              proc "system" (this: ^CBOpenIF, controller_name, hardwareLibraryToConnect: BStr) -> HResult,
    DisconnectHardwareLibrary:           proc "system" (this: ^CBOpenIF, controller_name, hardwareLibraryToDisconnect: BStr) -> HResult,
    GetHardwareLibraryState:             proc "system" (this: ^CBOpenIF, name: BStr, state: ^BStr) -> HResult,
    SetHardwareLibraryState:             proc "system" (this: ^CBOpenIF, name, state: BStr) -> HResult,
    SetHardwareLibraryVersion:           proc "system" (this: ^CBOpenIF, name: BStr, major_version, minor_version, revision: i32) -> HResult,
    CopyHardwareType:                    proc "system" (this: ^CBOpenIF, sourceHardwareLibraryName, sourceHardwareTypeGUID, destinationHardwareLibraryName, destinationHardwareTypeGUID: BStr) -> HResult,
    DeleteHardwareType:                  proc "system" (this: ^CBOpenIF, name, type_name: BStr) -> HResult,
    GetConnectedHardwareLibraries:       proc "system" (this: ^CBOpenIF, controller_name: BStr, connectedHardwareLibrariesContent: ^BStr) -> HResult,
    SetConnectedHardwareLibraries:       proc "system" (this: ^CBOpenIF, controller_name, connectedHardwareLibrariesContent: BStr, messages: ^BStr) -> HResult,
    CopyHardwareLibrary:                 proc "system" (this: ^CBOpenIF, sourceHardwareLibraryName, destinationHardwareLibraryName, destinationHardwareLibraryGUID: BStr) -> HResult,
    RefreshHardwareLibrary:              proc "system" (this: ^CBOpenIF, name: BStr) -> HResult,
    ReplaceConnectedHardwareLibrary:     proc "system" (this: ^CBOpenIF, controller_name, connectedHardwareLibraryName, replacingHardwareLibraryName: BStr) -> HResult,
    AddHardwareTypeFile:                 proc "system" (this: ^CBOpenIF, name, hardwareTypeGUID: BStr, fileType: HardwareFileType, file_path, version, buildVersion, buildDate, fwName: BStr) -> HResult,
    InsertHardwareType:                  proc "system" (this: ^CBOpenIF, type_name, library_name, hardwareTypeGUID, hardwareTypeID: BStr) -> HResult,
    ReplaceConnectedLibrary:             proc "system" (this: ^CBOpenIF, app_or_lib_name, connectedLibraryName, replacingLibraryName: BStr) -> HResult,
    NewProjectInEnvironment:             proc "system" (this: ^CBOpenIF, projectName, guid, template_name, environmentGuidOrName: BStr) -> HResult,
    OpenProjectInEnvironment:            proc "system" (this: ^CBOpenIF, projectGuidOrName, environmentGuidOrName: BStr) -> HResult,
    RenameHardwareLibrary:               proc "system" (this: ^CBOpenIF, name, new_name: BStr) -> HResult,
    GetProjectAndEnvironmentInformation: proc "system" (this: ^CBOpenIF, projectName, projectGuid, environmentName, environmentGuid: ^BStr) -> HResult,
    SetStorage:                          proc "system" (this: ^CBOpenIF, pIAcStorage: rawptr) -> HResult,   // IAcStorage*
    WriteInformation:                    proc "system" (this: ^CBOpenIF, message: BStr) -> HResult,
    WriteWarning:                        proc "system" (this: ^CBOpenIF, message: BStr) -> HResult,
    WriteError:                          proc "system" (this: ^CBOpenIF, message: BStr) -> HResult,
    NewFolder:                           proc "system" (this: ^CBOpenIF, type: FolderType, name, path, guid: BStr) -> HResult,
    RenameFolder:                        proc "system" (this: ^CBOpenIF, type: FolderType, path, new_name: BStr) -> HResult,
    DeleteFolder:                        proc "system" (this: ^CBOpenIF, type: FolderType, path: BStr) -> HResult,
    MoveFolder:                          proc "system" (this: ^CBOpenIF, type: FolderType, path, new_path: BStr) -> HResult,
    MoveFolderObject:                    proc "system" (this: ^CBOpenIF, type: FolderType, objectName, new_path: BStr) -> HResult,
    NewDiagram:                          proc "system" (this: ^CBOpenIF, name, application_name, content: BStr, messages: ^BStr) -> HResult,
    GetDiagram:                          proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetDiagram:                          proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteDiagram:                       proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    RenameDiagram:                       proc "system" (this: ^CBOpenIF, path, newDiagramName: BStr) -> HResult,
    InsertDiagram:                       proc "system" (this: ^CBOpenIF, name, application_name, guid: BStr) -> HResult,
    InsertHardwareDefinitionFile:        proc "system" (this: ^CBOpenIF, name, file_path: BStr, fileAdded: ^Variant, messages: ^BStr) -> HResult,
    GetExecutionOrder:                   proc "system" (this: ^CBOpenIF, typeOfExecutionInstance: ExecutionInstanceType, application_name: BStr, content: ^BStr) -> HResult,
    SetExecutionOrder:                   proc "system" (this: ^CBOpenIF, typeOfExecutionInstance: ExecutionInstanceType, application_name, content: BStr, messages: ^BStr) -> HResult,
    NewDiagramType:                      proc "system" (this: ^CBOpenIF, diagramTypeName, app_or_lib_name, content: BStr, messages: ^BStr) -> HResult,
    GetDiagramType:                      proc "system" (this: ^CBOpenIF, diagramTypePath: BStr, diagramTypeContent: ^BStr) -> HResult,
    SetDiagramType:                      proc "system" (this: ^CBOpenIF, diagramTypePath, diagramTypeContent: BStr, messages: ^BStr) -> HResult,
    DeleteDiagramType:                   proc "system" (this: ^CBOpenIF, diagramTypePath: BStr) -> HResult,
    RenameDiagramType:                   proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    InsertDiagramType:                   proc "system" (this: ^CBOpenIF, diagramTypeName, app_or_lib_name, guid: BStr) -> HResult,
    NewDiagramInstance:                  proc "system" (this: ^CBOpenIF, name, diagramType, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetDiagramInstance:                  proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetDiagramInstance:                  proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    DeleteDiagramInstance:               proc "system" (this: ^CBOpenIF, path: BStr) -> HResult,
    RenameDiagramInstance:               proc "system" (this: ^CBOpenIF, path, new_name: BStr) -> HResult,
    NewSignal:                           proc "system" (this: ^CBOpenIF, type: SignalType, name, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    GetSignal:                           proc "system" (this: ^CBOpenIF, type: SignalType, name, path_to_parent: BStr, content: ^BStr) -> HResult,
    SetSignal:                           proc "system" (this: ^CBOpenIF, type: SignalType, name, path_to_parent, content: BStr, messages: ^BStr) -> HResult,
    DeleteSignal:                        proc "system" (this: ^CBOpenIF, type: SignalType, name, path_to_parent: BStr) -> HResult,
    AddHardwareLibraryFile:              proc "system" (this: ^CBOpenIF, name: BStr, typeOfFile: HardwareLibraryFileType, file_path, version: BStr) -> HResult,
    GetHardwareLibraryFiles:             proc "system" (this: ^CBOpenIF, name: BStr, hardwareLibraryFiles: ^BStr) -> HResult,
    DeleteHardwareLibraryFile:           proc "system" (this: ^CBOpenIF, name: BStr, typeOfFile: HardwareLibraryFileType, file_name: BStr) -> HResult,
    SetHardwareType:                     proc "system" (this: ^CBOpenIF, library_name, type_name, content: BStr, messages: ^BStr) -> HResult,
    GetHardwareDefinitionInfo:           proc "system" (this: ^CBOpenIF, library_name, type_name: BStr, content: ^BStr) -> HResult,
    InsertHardwareUnit:                  proc "system" (this: ^CBOpenIF, parentHwPath, guid: BStr) -> HResult,
    GetControllerSettings:               proc "system" (this: ^CBOpenIF, controller_name: BStr, settings: ^BStr) -> HResult,
    SetControllerSettings:               proc "system" (this: ^CBOpenIF, controller_name, settings: BStr) -> HResult,
    GetFDConnection:                     proc "system" (this: ^CBOpenIF, path: BStr, content: ^BStr) -> HResult,
    SetFDConnection:                     proc "system" (this: ^CBOpenIF, path, content: BStr, messages: ^BStr) -> HResult,
    ListAvailableLibraries:              proc "system" (this: ^CBOpenIF, libraries: ^BStr) -> HResult,
    ListAvailableHardwareLibraries:      proc "system" (this: ^CBOpenIF, hardwareLibraries: ^BStr) -> HResult,
    LoopCheckDownloadAndGoOnline:        proc "system" (this: ^CBOpenIF, isOnline: ^Variant, messages: ^BStr) -> HResult,
}

cbopenif_connect :: proc() -> (ok: bool) {
    ok = false

    if cbopenif != nil do return
    
    ok = com_initialize()
    if !ok do return

    clsid := &GUID{
        0x45902D56,
        0xD537,
        0x486C,
        {0x89, 0x1B, 0x81, 0x1C, 0xDA, 0x41, 0x0C, 0x77},
    }

    iid := &GUID{
        0xEDF53D60,
        0xF499,
        0x4EDC,
        {0xAB, 0x7F, 0x10, 0x38, 0x95, 0xFE, 0x89, 0x91},
    }

    ok = com_create_instance(clsid, iid, cast(^rawptr)&cbopenif)
    if !ok {
        com_uninitialize()
        cbopenif = nil
        return
    }

    return true
}

cbopenif_disconnect :: proc() -> (ok: bool) {
    if cbopenif != nil {
        cbopenif->Release()
        cbopenif = nil
    }
    com_uninitialize()

    return true
}

online :: proc() -> (is_online: bool, messages: string, ok: bool) {
    if !connected() do return false, "", false
    vb: VariantBool
    bstr_messages: BStr

    hr := cbopenif->Online(&vb, &bstr_messages)
    if failed(hr) {
        return false, "", false
    }

    is_online = (vb == VariantBoolTrue)

    if bstr_messages != nil {
        defer SysFreeString(bstr_messages)
        messages = bstr_to_string(bstr_messages)
    }

    return is_online, messages, false
}

offline :: proc() -> (messages: string, ok: bool) {
    if !connected() do return "", false
    bstr_messages: BStr

    hr := cbopenif->Offline(&bstr_messages)
    if failed(hr) {
        return "", false
    }

    if bstr_messages != nil {
        defer SysFreeString(bstr_messages)
        messages = bstr_to_string(bstr_messages)
    }

    return messages, true
}

get_setting :: proc(setting_name: string) -> (value: Variant, ok: bool) {
    if !connected() do return {}, false
    VariantInit(&value) // caller must VariantClear(&value) when done, OR we clear on failure only!

    bstr_name := string_to_bstr(setting_name)
    defer SysFreeString(bstr_name)

    hr := cbopenif->GetSetting(bstr_name, &value)
    if failed(hr) {
        VariantClear(&value)
        return {}, false
    }

    return value, true
}
