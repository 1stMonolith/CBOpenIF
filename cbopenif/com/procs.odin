package com

AccessLevel :: proc {
    GetComponentAccessLevel,
    SetComponentAccessLevel,
    GetCMParameterAccessLevel,
    SetCMParameterAccessLevel,
    GetExtensibleParameterAccessLevel,
    SetExtensibleParameterAccessLevel,
    GetParameterAccessLevel,
    SetParameterAccessLevel,
    GetExternalVariableAccessLevel,
    SetExternalVariableAccessLevel,
    GetGlobalVariableAccessLevel,
    SetGlobalVariableAccessLevel,
    GetVariableAccessLevel,
    SetVariableAccessLevel,
    GetFunctionBlockAccessLevel,
    SetFunctionBlockAccessLevel,
    GetControlModuleAccessLevel,
    SetControlModuleAccessLevel,
    GetSingleControlModuleAccessLevel,
    SetSingleControlModuleAccessLevel,
    GetProgramAccessLevel,
    SetProgramAccessLevel,
    GetDiagramAccessLevel,
    SetDiagramAccessLevel,
    GetDiagramInstanceAccessLevel,
    SetDiagramInstanceAccessLevel,
}

ActualParameter :: proc {
    GetCMConnectionActualParameter,
    SetCMConnectionActualParameter,
}

AcknowledgeGroup :: proc {
    GetSignalAcknowledgeGroup,
    SetSignalAcknowledgeGroup,
    GetCommVariableAcknowledgeGroup,
    SetCommVariableAcknowledgeGroup,
}

Address :: proc {
    GetHWChannelAddress,
    SetHWChannelAddress,
}

AlarmOwner :: proc {
    GetFunctionBlockTypeAlarmOwner,
    SetFunctionBlockTypeAlarmOwner,
    GetControlModuleTypeAlarmOwner,
    SetControlModuleTypeAlarmOwner,
    GetDiagramTypeAlarmOwner,
    SetDiagramTypeAlarmOwner,
}

AspectObject :: proc {
    GetFunctionBlockAspectObject,
    SetFunctionBlockAspectObject,
    GetControlModuleAspectObject,
    SetControlModuleAspectObject,
    GetControlModuleTypeAspectObject,
    SetControlModuleTypeAspectObject,
    GetDiagramInstanceAspectObject,
    SetDiagramInstanceAspectObject,
    GetFunctionBlockTypeAspectObject,
    SetFunctionBlockTypeAspectObject,
    GetDiagramTypeAspectObject,
    SetDiagramTypeAspectObject,
}

Attribute :: proc {
    GetComponentAttribute,
    SetComponentAttribute,
    GetExtensibleParameterAttribute,
    SetExtensibleParameterAttribute,
    GetParameterAttribute,
    SetParameterAttribute,
    GetExternalVariableAttribute,
    SetExternalVariableAttribute,
    GetGlobalVariableAttribute,
    SetGlobalVariableAttribute,
    GetVariableAttribute,
    SetVariableAttribute,
    GetCommVariableAttribute,
    SetCommVariableAttribute,
    GetVANamedVariableAttribute,
    SetVANamedVariableAttribute,
}

AuthenticationLevel :: proc {
    GetComponentAuthenticationLevel,
    SetComponentAuthenticationLevel,
    GetCMParameterAuthenticationLevel,
    SetCMParameterAuthenticationLevel,
    GetParameterAuthenticationLevel,
    SetParameterAuthenticationLevel,
    GetExternalVariableAuthenticationLevel,
    SetExternalVariableAuthenticationLevel,
    GetGlobalVariableAuthenticationLevel,
    SetGlobalVariableAuthenticationLevel,
    GetVariableAuthenticationLevel,
    SetVariableAuthenticationLevel,
}

GetAutoPoint :: proc {
    GetCMParameterAutoPoint,
}

SetAutoPoint :: proc {
    SetCMParameterAutoPoint,
}

AutoPosition :: proc {
    GetAutoPointAutoPosition,
    SetAutoPointAutoPosition,
}

BatchObject :: proc {
    GetControlModuleTypeBatchObject,
    SetControlModuleTypeBatchObject,
    GetDiagramBatchObject,
    SetDiagramBatchObject,
    GetDiagramTypeBatchObject,
    SetDiagramTypeBatchObject,
}

BatchProperty :: proc {
    GetCMParameterBatchProperty,
    SetCMParameterBatchProperty,
    GetVariableBatchProperty,
    SetVariableBatchProperty,
}

GetCMConnections :: proc {
    GetControlModuleCMConnections,
    GetSingleControlModuleCMConnections,
}

SetCMConnections :: proc {
    SetControlModuleCMConnections,
    SetSingleControlModuleCMConnections,
}

CMGraphics :: proc {
    GetControlModuleTypeCMGraphics,
    SetControlModuleTypeCMGraphics,
}

GetCMParameters :: proc {
    GetControlModuleTypeCMParameters,
}

SetCMParameters :: proc {
    SetControlModuleTypeCMParameters,
}

GetCodeBlock :: proc {
    GetCodeBlockWithName,
    GetCodeBlockAtIndex,
}

GetCodeBlocks :: proc {
    GetFunctionBlockTypeCodeBlocks,
    GetControlModuleTypeCodeBlocks,
    GetProgramCodeBlocks,
    GetDiagramCodeBlocks,
    GetDiagramTypeCodeBlocks,
}

SetCodeBlocks :: proc {
    SetFunctionBlockTypeCodeBlocks,
    SetControlModuleTypeCodeBlocks,
    SetProgramCodeBlocks,
    SetDiagramCodeBlocks,
    SetDiagramTypeCodeBlocks,
}

Column :: proc {
    GetPosInfoColumn,
    SetPosInfoColumn,
}

GetComponent :: proc {
    GetComponentWithName,
    GetComponentAtIndex,
}

GetComponents :: proc {
    GetDataTypeComponents,
}

SetComponents :: proc {
    SetDataTypeComponents,
}

GetCommVariables :: proc {
    GetProgramCommVariables,
    GetDiagramCommVariables,
}

SetCommVariables :: proc {
    SetProgramCommVariables,
    SetDiagramCommVariables,
}

ConVariable :: proc {
    GetHWChannelConVariable,
    SetHWChannelConVariable,
}


GetControlModules :: proc {
    GetControlModuleTypeControlModules,
    GetDiagramControlModules,
    GetDiagramTypeControlModules,
}

SetControlModules :: proc {
    SetControlModuleTypeControlModules,
    SetDiagramControlModules,
    SetDiagramTypeControlModules,
}

GetDiagramInstances :: proc {
    GetDiagramDiagramInstances,
    GetDiagramTypeDiagramInstances,
}

SetDiagramInstances :: proc {
    SetDiagramDiagramInstances,
    SetDiagramTypeDiagramInstances,
}

Direction :: proc {
    GetCMParameterDirection,
    SetCMParameterDirection,
    GetExtensibleParameterDirection,
    SetExtensibleParameterDirection,
    GetParameterDirection,
    SetParameterDirection,
    GetSignalDirection,
    SetSignalDirection,
    GetCommVariableDirection,
    SetCommVariableDirection,
}

Description :: proc {
    GetComponentDescription,
    SetComponentDescription,
    GetILRowDescription,
    SetILRowDescription,
    GetCMParameterDescription,
    SetCMParameterDescription,
    GetExtensibleParameterDescription,
    SetExtensibleParameterDescription,
    GetParameterDescription,
    SetParameterDescription,
    GetParameterSettingDescription,
    GetSignalDescription,
    SetSignalDescription,
    GetDataTypeDescription,
    SetDataTypeDescription,
    GetApplicationVariablesDescription,
    SetApplicationVariablesDescription,
    GetExternalVariableDescription,
    SetExternalVariableDescription,
    GetGlobalVariableDescription,
    SetGlobalVariableDescription,
    GetVariableDescription,
    SetVariableDescription,
    GetFunctionBlockDescription,
    SetFunctionBlockDescription,
    GetFunctionBlockTypeDescription,
    SetFunctionBlockTypeDescription,
    GetControlModuleDescription,
    SetControlModuleDescription,
    GetControlModuleTypeDescription,
    SetControlModuleTypeDescription,
    GetSingleControlModuleDescription,
    SetSingleControlModuleDescription,
    GetCommVariableDescription,
    SetCommVariableDescription,
    GetHWUnitDescription,
    SetHWUnitDescription,
    GetHWChannelIODescription,
    SetHWChannelIODescription,
    GetProgramDescription,
    SetProgramDescription,
    GetDiagramDescription,
    SetDiagramDescription,
    GetDiagramTypeDescription,
    SetDiagramTypeDescription,
    GetDiagramInstanceDescription,
    SetDiagramInstanceDescription,
}

ElementName :: proc {
    GetPosInfoElementName,
    SetPosInfoElementName,
}

EndPosition :: proc {
    GetPosInfoEndPosition,
    SetPosInfoEndPosition,
}

ErrorNumber :: proc {
    GetErrorMsgNumber,
    SetErrorMsgNumber,
}

GetExtraInfo :: proc {
    GetErrorMsgExtraInfo,
    GetWarningMsgExtraInfo,
    GetInfoMsgExtraInfo,
}

SetExtraInfo :: proc {
    SetErrorMsgExtraInfo,
    SetWarningMsgExtraInfo,
    SetInfoMsgExtraInfo,
}

ExpectedSIL :: proc {
    GetCommVariableExpectedSil,
    SetCommVariableExpectedSil,
}

ExpectedType :: proc {
    GetExtraInfoExpectedType,
    SetExtraInfoExpectedType,
}

GetExtensibleParameters :: proc {
    GetFunctionBlockTypeExtensibleParameters,
}

SetExtensibleParameters :: proc {
    SetFunctionBlockTypeExtensibleParameters,
}

GetExternalVariables :: proc {
    GetFunctionBlockTypeExternalVariables,
    GetControlModuleTypeExternalVariables,
}

SetExternalVariables :: proc {
    SetFunctionBlockTypeExternalVariables,
    SetControlModuleTypeExternalVariables,
}

ExposeProperties :: proc {
    GetFunctionBlockExposeProperties,
    SetFunctionBlockExposeProperties,
    GetControlModuleExposeProperties,
    SetControlModuleExposeProperties,
    GetDiagramInstanceExposeProperties,
    SetDiagramInstanceExposeProperties,
}

FDPort :: proc {
    GetCMParameterFDPort,
    SetCMParameterFDPort,
    GetExtensibleParameterFDPort,
    SetExtensibleParameterFDPort,
    GetParameterFDPort,
    SetParameterFDPort,
}

FOUName :: proc {
    GetPosInfoFOUName,
    SetPosInfoFOUName,
}

Fraction :: proc {
    GetHWChannelFraction,
    SetHWChannelFraction,
}

FunctionName :: proc {
    GetExtraInfoFunctionName,
    SetExtraInfoFunctionName,
}

GetFunctionBlocks :: proc {
    GetFunctionBlockTypeFunctionBlocks,
    GetControlModuleTypeFunctionBlocks,
    GetProgramFunctionBlocks,
    GetDiagramFunctionBlocks,
    GetDiagramTypeFunctionBlocks,
}

SetFunctionBlocks :: proc {
    SetFunctionBlockTypeFunctionBlocks,
    SetControlModuleTypeFunctionBlocks,
    SetProgramFunctionBlocks,
    SetDiagramFunctionBlocks,
    SetDiagramTypeFunctionBlocks,
}

GetGlobalVariables :: proc {
    GetApplicationVariablesGlobalVariables,
}

SetGlobalVariables :: proc {
    SetApplicationVariablesGlobalVariables,
}

GetGraphNodes :: proc {
    GetCMParameterGraphNodes,
    GetExternalVariableGraphNodes,
    GetGlobalVariableGraphNodes,
    GetVariableGraphNodes,
}

SetGraphNodes :: proc {
    SetCMParameterGraphNodes,
    SetExternalVariableGraphNodes,
    SetGlobalVariableGraphNodes,
    SetVariableGraphNodes,
}

GetGraphSize :: proc {
    GetControlModuleTypeGraphSize,
}

SetGraphSize :: proc {
    SetControlModuleTypeGraphSize,
}

GetGraphPos :: proc {
    GetSingleControlModuleGraphPos,
    GetControlModuleGraphPos,
}

SetGraphPos :: proc {
    SetSingleControlModuleGraphPos,
    SetControlModuleGraphPos,
}

GraphicalConnection :: proc {
    GetCMConnectionGraphicalConnection,
    SetCMConnectionGraphicalConnection,
}

Guid :: proc {
    GetTaskGuid,
    SetTaskGuid,
    GetDataTypeGuid,
    SetDataTypeGuid,
    GetFunctionBlockGuid,
    SetFunctionBlockGuid,
    GetFunctionBlockTypeGuid,
    SetFunctionBlockTypeGuid,
    GetControlModuleGuid,
    SetControlModuleGuid,
    GetControlModuleTypeGuid,
    SetControlModuleTypeGuid,
    GetHWUnitGuid,
    SetHWUnitGuid,
    GetDiagramTypeAlarmGuid,
    SetDiagramTypeAlarmGuid,
    GetDiagramInstanceGuid,
    SetDiagramInstanceGuid,
    GetConnectedApplicationGuid
}

Hidden :: proc {
    GetDataTypeHidden,
    SetDataTypeHidden,
    GetFunctionBlockTypeHidden,
    SetFunctionBlockTypeHidden,
    GetControlModuleTypeHidden,
    SetControlModuleTypeHidden,
    GetDiagramTypeHidden,
    SetDiagramTypeHidden,
}

Simulation :: proc {
    GetHWUnitSimulation,
    SetHWUnitSimulation,
}

SimulationSupported :: proc {
    GetHWUnitSimulationSupported,
    SetHWUnitSimulationSupported,
}

GetHWChannels :: proc {
    GetHWUnitHWChannels,
}

SetHWChannels :: proc {
    SetHWUnitHWChannels,
}

GetHWUnits :: proc {
    GetHWUnitHwUnits,
}

SetHWUnits :: proc {
    SetHWUnitHwUnits,
}

ID :: proc {
    GetPosInfoID,
    SetPosInfoID,
    GetHWUnitID,
    SetHWUnitID,
}

GetInitValues :: proc {
    GetProgramInitValues,
    GetDiagramInitValues,
}

SetInitValues :: proc {
    SetProgramInitValues,
    SetDiagramInitValues,
}

GetInitialValue :: proc {
    GetComponentInitialValue,
    GetCMParameterInitialValue,
    GetExtensibleParameterInitialValue,
    GetParameterInitialValue,
    GetGlobalVariableInitialValue,
    GetVariableInitialValue,
    GetCommVariableInitialValue,
}

SetInitialValue :: proc {
    SetComponentInitialValue,
    SetCMParameterInitialValue,
    SetExtensibleParameterInitialValue,
    SetParameterInitialValue,
    SetGlobalVariableInitialValue,
    SetVariableInitialValue,
    SetCommVariableInitialValue,
}

InstGuid :: proc {
    GetSingleControlModuleInstGuid,
    SetSingleControlModuleInstGuid,
    GetProgramInstGuid,
    SetProgramInstGuid,
    GetDiagramInstGuid,
    SetDiagramInstGuid,
}

InteractionWindow :: proc {
    GetFunctionBlockTypeInteractionWindow,
    SetFunctionBlockTypeInteractionWindow,
    GetControlModuleTypeInteractionWindow,
    SetControlModuleTypeInteractionWindow,
}

IntervalTime :: proc {
    GetTaskIntervalTime,
    SetTaskIntervalTime,
    GetCommVariableIntervalTime,
    SetCommVariableIntervalTime,
}

InstanceGraphics :: proc {
    GetControlModuleInstanceGraphics,
    SetControlModuleInstanceGraphics,
    GetSingleControlModuleInstanceGraphics,
    SetSingleControlModuleInstanceGraphics,
}

InstanceName :: proc {
    GetHWUnitInstanceName,
    SetHWUnitInstanceName,
}

GetILRows :: proc {
    GetILCodeBlockILRows,
}

SetILRows :: proc {
    SetILCodeBlockILRows,
}

IpAddress :: proc {
    GetCommVariableIpAddress,
    SetCommVariableIpAddress,
}

ISPValue :: proc {
    GetComponentISPValue,
    SetComponentISPValue,
    GetCommVariableISPValue,
    SetCommVariableISPValue,
}

JumpDestination :: proc {
    GetExtraInfoJumpDestination,
    SetExtraInfoJumpDestination,
}

LatencySupervision :: proc {
    GetTaskLatencySupervision,
    SetTaskLatencySupervision,
}

LatencyPercentage :: proc {
    GetTaskLatencyPercentage,
    SetTaskLatencyPercentage,
}

MajorVersion :: proc {
    GetConnectedApplicationMajorVersion,
    SetConnectedApplicationMajorVersion,
    GetConnectedLibraryMajorVersion,
    SetConnectedLibraryMajorVersion,
    GetConnectedHWLibraryMajorVersion,
    SetConnectedHWLibraryMajorVersion,
}

Max :: proc {
    GetHWChannelMax,
    SetHWChannelMax,
}

MinorVersion :: proc {
    GetConnectedApplicationMinorVersion,
    SetConnectedApplicationMinorVersion,
    GetConnectedLibraryMinorVersion,
    SetConnectedLibraryMinorVersion,
    GetConnectedHWLibraryMinorVersion,
    SetConnectedHWLibraryMinorVersion,
}

MsgText :: proc {
    GetMsgText,
    SetMsgText,
    GetErrorMsgText,
    SetErrorMsgText,
    GetFindMsgText,
    SetFindMsgText,
    GetInfoMsgText,
    SetInfoMsgText,
    GetWarningMsgText,
    SetWarningMsgText,
}

MsgType :: proc {
    GetPosInfoMsgType,
    SetPosInfoMsgType,
}

Min :: proc {
    GetHWChannelMin,
    SetHWChannelMin,
}

Name :: proc {
    GetCodeBlockName,
    SetCodeBlockName,
    GetFBDCodeBlockName,
    SetFBDCodeBlockName,
    GetFDCodeBlockName,
    SetFDCodeBlockName,
    GetILCodeBlockName,
    SetILCodeBlockName,
    GetLDCodeBlockName,
    SetLDCodeBlockName,
    GetSFCCodeBlockName,
    SetSFCCodeBlockName,
    GetSTCodeBlockName,
    SetSTCodeBlockName,
    GetComponentName,
    SetComponentName,
    GetCMConnectionName,
    SetCMConnectionName,
    GetGraphNodeName,
    SetGraphNodeName,
    GetInitValueName,
    SetInitValueName,
    GetCMParameterName,
    SetCMParameterName,
    GetExtensibleParameterName,
    SetExtensibleParameterName,
    GetParameterName,
    SetParameterName,
    GetParameterSettingName,
    SetParameterSettingName,
    GetProjectConstantName,
    SetProjectConstantName,
    GetSFCStepName,
    SetSFCStepName,
    GetSFCSubsequenceName,
    SetSFCSubsequenceName,
    GetSFCTransitionName,
    SetSFCTransitionName,
    GetSignalName,
    SetSignalName,
    GetTaskName,
    SetTaskName,
    GetDataTypeName,
    SetDataTypeName,
    GetExternalVariableName,
    SetExternalVariableName,
    GetGlobalVariableName,
    SetGlobalVariableName,
    GetVariableName,
    SetVariableName,
    GetFunctionBlockName,
    SetFunctionBlockName,
    GetFunctionBlockTypeName,
    SetFunctionBlockTypeName,
    GetControlModuleName,
    SetControlModuleName,
    GetControlModuleTypeName,
    SetControlModuleTypeName,
    GetSingleControlModuleName,
    SetSingleControlModuleName,
    GetIControlModuleName,
    SetIControlModuleName,
    GetCommVariableName,
    SetCommVariableName,
    GetHWChannelName,
    SetHWChannelName,
    GetConnectedApplicationName,
    SetConnectedApplicationName,
    GetConnectedLibraryName,
    SetConnectedLibraryName,
    GetConnectedHWLibraryName,
    SetConnectedHWLibraryName,
    GetExecutionInstanceName,
    SetExecutionInstanceName,
    GetExecutionGroupName,
    SetExecutionGroupName,
    GetIVAProtocolName,
    SetIVAProtocolName,
    GetVAAddressedProtocolName,
    SetVAAddressedProtocolName,
    GetVAAddressedVariableName,
    SetVAAddressedVariableName,
    GetVANamedProtocolName,
    SetVANamedProtocolName,
    GetVANamedVariableName,
    SetVANamedVariableName,
    GetProgramName,
    SetProgramName,
    GetDiagramName,
    SetDiagramName,
    GetDiagramTypeName,
    SetDiagramTypeName,
    GetDiagramInstanceName,
    SetDiagramInstanceName,
    GetModuleName,
    SetModuleName,
}

NumberOfErrors :: proc {
    GetMsgBucketNumberOfErrors,
    SetMsgBucketNumberOfErrors,
}

NumberOfWarnings :: proc {
    GetMsgBucketNumberOfWarnings,
    SetMsgBucketNumberOfWarnings,
}

Offset :: proc {
    GetTaskOffset,
    SetTaskOffset,
}

OutputUpdate :: proc {
    GetTaskOutputUpdate,
    SetTaskOutputUpdate,
}

PageNumber :: proc {
    GetPosInfoPageNumber,
    SetPosInfoPageNumber,
}

GetParameters :: proc {
    GetFunctionBlockTypeParameters,
    GetDiagramTypeParameters,
}

SetParameters :: proc {
    SetFunctionBlockTypeParameters,
    SetDiagramTypeParameters,
}

Value :: proc {
    GetParameterSettingValue,
    SetParameterSettingValue,
}

GetParameterSettings :: proc {
    GetHWUnitParameterSettings,
}

SetParameterSettings :: proc {
    SetHWUnitParameterSettings,
}

Path :: proc {
    GetSignalPath,
    SetSignalPath,
    GetHWUnitPath,
    SetHWUnitPath,
    GetVAAddressedVariablePath,
    SetVAAddressedVariablePath,
    GetVANamedVariablePath,
    SetVANamedVariablePath,
}

GetPoint :: proc {
    GetPointAtIndex,
}

LowerLeft :: proc {
    GetGraphSizeLowerLeft,
    SetGraphSizeLowerLeft,
}

UpperRight :: proc {
    GetGraphSizeUpperRight,
    SetGraphSizeUpperRight,
}

GetPoints :: proc {
    GetCMConnectionPoints,
}

SetPoints :: proc {
    SetCMConnectionPoints,
}

GetPosInfo :: proc {
    GetMsgPosInfo,
    GetErrorMsgPosInfo,
    GetWarningMsgPosInfo,
    GetInfoMsgPosInfo,
    GetFindMsgPosInfo,
}

SetPosInfo :: proc {
    SetErrorMsgPosInfo,
    SetWarningMsgPosInfo,
    SetInfoMsgPosInfo,
    SetFindMsgPosInfo,
}

POUName :: proc {
    GetPosInfoPOUName,
    SetPosInfoPOUName,
}

POUPath :: proc {
    GetInitValuePOUPath,
    SetInitValuePOUPath,
}

Priority :: proc {
    GetSFCBranchPriority,
    SetSFCBranchPriority,
    GetTaskPriority,
    SetTaskPriority,
    GetCommVariablePriority,
    SetCommVariablePriority,
}

Protected :: proc {
    GetDataTypeProtected,
    SetDataTypeProtected,
    GetFunctionBlockTypeProtected,
    SetFunctionBlockTypeProtected,
    GetControlModuleTypeProtected,
    SetControlModuleTypeProtected,
    GetDiagramTypeProtected,
    SetDiagramTypeProtected,
}

ReadPermission :: proc {
    GetComponentReadPermission,
    SetComponentReadPermission,
    GetCMParameterReadPermission,
    SetCMParameterReadPermission,
    GetParameterReadPermission,
    SetParameterReadPermission,
    GetExternalVariableReadPermission,
    SetExternalVariableReadPermission,
    GetGlobalVariableReadPermission,
    SetGlobalVariableReadPermission,
    GetVariableReadPermission,
    SetVariableReadPermission,
    GetCommVariableReadPermission,
    SetCommVariableReadPermission,
}

RedundantPos :: proc {
    GetHWUnitRedundantPOS,
    SetHWUnitRedundantPOS,
}

Release :: proc {
    ReleaseICodeBlock,
    ReleaseCodeBlock,
    ReleaseCodeBlocks,
    ReleaseFBDCodeBlock,
    ReleaseFDCodeBlock,
    ReleaseILCodeBlock,
    ReleaseLDCodeBlock,
    ReleaseSFCCodeBlock,
    ReleaseSTCodeBlock,
    ReleaseComponent,
    ReleaseComponents,
    ReleaseCMConnection,
    ReleaseCMConnections,
    ReleaseGraphNode,
    ReleaseGraphNodes,
    ReleaseGraphPos,
    ReleaseGraphSize,
    ReleaseILRow,
    ReleaseILRows,
    ReleaseInitValue,
    ReleaseInitValues,
    ReleaseMsg,
    ReleaseErrorMsg,
    ReleaseExtraInfo,
    ReleaseFindMsg,
    ReleaseInfoMsg,
    ReleaseMsgBucket,
    ReleaseIMsg,
    ReleasePosInfo,
    ReleaseWarningMsg,
    ReleaseCMParameter,
    ReleaseCMParameters,
    ReleaseExtensibleParameter,
    ReleaseExtensibleParameters,
    ReleaseParameter,
    ReleaseParameters,
    ReleaseParameterSetting,
    ReleaseParameterSettings,
    ReleaseAutoPoint,
    ReleasePoint,
    ReleasePoints,
    ReleaseProjectConstant,
    ReleaseSFCBranch,
    ReleaseSFCBranches,
    ReleaseSFCElement,
    ReleaseSFCElements,
    ReleaseSFCSelection,
    ReleaseSFCSimultaneous,
    ReleaseSFCStep,
    ReleaseSFCSubsequence,
    ReleaseSFCTransition,
    ReleaseSignal,
    ReleaseSignals,
    ReleaseTask,
    ReleaseDataType,
    ReleaseApplicationVariables,
    ReleaseExternalVariable,
    ReleaseExternalVariables,
    ReleaseGlobalVariable,
    ReleaseGlobalVariables,
    ReleaseVariable,
    ReleaseVariables,
    ReleaseFunctionBlock,
    ReleaseFunctionBlocks,
    ReleaseFunctionBlockType,
    ReleaseControlModule,
    ReleaseControlModuleType,
    ReleaseControlModules,
    ReleaseSingleControlModule,
    ReleaseCommVariable,
    ReleaseCommVariables,
    ReleaseHWUnits,
    ReleaseHWChannels,
    ReleaseHWUnit,
    ReleaseHWChannel,
    ReleaseConnectedApplication,
    ReleaseConnectedApplications,
    ReleaseConnectedLibrary,
    ReleaseConnectedLibraries,
    ReleaseConnectedHWLibrary,
    ReleaseConnectedHWLibraries,
    ReleaseExecutionInstance,
    ReleaseExecutionOrder,
    ReleaseExecutionGroup,
    ReleaseAccessVariables,
    ReleaseIVAProtocol,
    ReleaseVAProtocols,
    ReleaseVANamedProtocol,
    ReleaseVAAddressedProtocol,
    ReleaseVANamedVariable,
    ReleaseVAAddressedVariable,
    ReleaseApplicationProperties,
    ReleaseProgram,
    ReleaseDiagram,
    ReleaseDiagramType,
    ReleaseDiagramInstance,
    ReleaseDiagramInstances,
    ReleaseIControlModule,
    ReleaseModule,
}

ReservedBy :: proc {
    GetDataTypeReservedBy,
    SetDataTypeReservedBy,
    GetFunctionBlockTypeReservedBy,
    SetFunctionBlockTypeReservedBy,
    GetControlModuleTypeReservedBy,
    SetControlModuleTypeReservedBy,
    GetHWUnitReservedBy,
    SetHWUnitReservedBy,
    GetProgramReservedBy,
    SetProgramReservedBy,
    GetDiagramReservedBy,
    SetDiagramReservedBy,
    GetDiagramTypeReservedBy,
    SetDiagramTypeReservedBy,
}

RestrictedSIL :: proc {
    GetFunctionBlockTypeRestrictedSIL,
    SetFunctionBlockTypeRestrictedSIL,
    GetControlModuleTypeRestrictedSIL,
    SetControlModuleTypeRestrictedSIL,
    GetCommVariableRestrictedSIL,
    SetCommVariableRestrictedSIL,
    GetDiagramRestrictedSIL,
    SetDiagramRestrictedSIL,
    GetDiagramTypeRestrictedSIL,
    SetDiagramTypeRestrictedSIL,
}

Reversed :: proc {
    GetHWChannelReversed,
    SetHWChannelReversed,
}

Revision :: proc {
    GetConnectedApplicationRevision,
    SetConnectedApplicationRevision,
    GetConnectedLibraryRevision,
    SetConnectedLibraryRevision,
    GetConnectedHWLibraryRevision,
    SetConnectedHWLibraryRevision,
}

Rotation :: proc {
    GetGraphPosRotation,
    SetGraphPosRotation,
}

Row :: proc {
    GetPosInfoRow,
    SetPosInfoRow,
    GetVAAddressedVariableRow,
    SetVAAddressedVariableRow,
    GetVANamedVariableRow,
    SetVANamedVariableRow,
}

SafetyType :: proc {
    GetComponentSafetyType,
    SetComponentSafetyType,
    GetCMParameterSafetyType,
    SetCMParameterSafetyType,
    GetExtensibleParameterSafetyType,
    SetExtensibleParameterSafetyType,
    GetParameterSafetyType,
    SetParameterSafetyType,
    GetExternalVariableSafetyType,
    SetExternalVariableSafetyType,
    GetGlobalVariableSafetyType,
    SetGlobalVariableSafetyType,
    GetVariableSafetyType,
    SetVariableSafetyType,
    GetFunctionBlockSafetyType,
    SetFunctionBlockSafetyType,
    GetControlModuleSafetyType,
    SetControlModuleSafetyType,
    GetSingleControlModuleSafetyType,
    SetSingleControlModuleSafetyType,
    GetProgramSafetyType,
    SetProgramSafetyType,
    GetDiagramSafetyType,
    SetDiagramSafetyType,
    GetDiagramInstanceSafetyType,
    SetDiagramInstanceSafetyType,
}

Scope :: proc {
    GetDataTypeScope,
    SetDataTypeScope,
    GetFunctionBlockTypeScope,
    SetFunctionBlockTypeScope,
    GetControlModuleTypeScope,
    SetControlModuleTypeScope,
    GetDiagramTypeScope,
    SetDiagramTypeScope,
}

Serialize :: proc {
    SerializeCodeBlock,
    SerializeFBDCodeBlock,
    SerializeFDCodeBlock,
    SerializeILCodeBlock,
    SerializeLDCodeBlock,
    SerializeSFCCodeBlock,
    SerializeSTCodeBlock,
    SerializeCMConnection,
    SerializeInitValue,
    SerializeMsgBucket,
    SerializeCMParameter,
    SerializeExtensibleParameter,
    SerializeParameter,
    SerializeProjectConstants,
    SerializeSignal,
    SerializeTask,
    SerializeDataType,
    SerializeApplicationVariables,
    SerializeExternalVariable,
    SerializeGlobalVariable,
    SerializeVariable,
    SerializeFunctionBlock,
    SerializeFunctionBlockType,
    SerializeControlModule,
    SerializeControlModuleType,
    SerializeControlModules,
    SerializeSingleControlModule,
    SerializeCommVariable,
    SerializeHWUnit,
    SerializeConnectedHWLibraries,
    SerializeConnectedLibraries,
    SerializeConnectedApplications,
    SerializeAccessVariables,
    SerializeApplicationProperties,
    SerializeProgram,
    SerializeDiagram,
    SerializeDiagramType,
    SerializeDiagramInstance,
    SerializeModule,
}

SimulationMark :: proc {
    GetFunctionBlockTypeSimulationMark,
    SetFunctionBlockTypeSimulationMark,
    GetControlModuleTypeSimulationMark,
    SetControlModuleTypeSimulationMark,
    GetApplicationPropertiesSimulationMark,
    SetApplicationPropertiesSimulationMark,
    GetProgramSimulationMark,
    SetProgramSimulationMark,
    GetDiagramSimulationMark,
    SetDiagramSimulationMark,
    GetDiagramTypeSimulationMark,
    SetDiagramTypeSimulationMark,
}

StartPosition :: proc {
    GetPosInfoStartPosition,
    SetPosInfoStartPosition,
}

SILLevel :: proc {
    GetTaskSILLevel,
    SetTaskSILLevel,
    GetFunctionBlockTypeSILLevel,
    SetFunctionBlockTypeSILLevel,
    GetControlModuleTypeSILLevel,
    SetControlModuleTypeSILLevel,
    GetApplicationPropertiesSILLevel,
    SetApplicationPropertiesSILLevel,
    GetProgramSILLevel,
    SetProgramSILLevel,
    GetDiagramSILLevel,
    SetDiagramSILLevel,
    GetDiagramTypeSILLevel,
    SetDiagramTypeSILLevel,
}


STCode :: proc {
    GetCodeBlockStCode,
    SetCodeBlockStCode,
    GetFBDCodeBlockSTCode,
    SetFBDCodeBlockSTCode,
    GetLDCodeBlockStCode,
    SetLDCodeBlockStCode,
    GetSTCodeBlockStCode,
    SetSTCodeBlockStCode,
    GetSFCTransitionSTCode,
    SetSFCTransitionSTCode,
}

GetSFCBranches :: proc {
    GetSFCSelectionBranches,
    GetSFCSimultaneousBranches,
}

SetSFCBranches :: proc {
    SetSFCSelectionBranches,
    SetSFCSimultaneousBranches,
}

GetSFCElements :: proc {
    GetSFCCodeBlockElements,
    GetSFCBranchElements,
    GetSFCSubsequenceElements,
}

SetSFCElements :: proc {
    SetSFCCodeBlockElements,
    SetSFCBranchElements,
    SetSFCSubsequenceElements,
}

GetSignals :: proc {
    GetApplicationVariablesSignals,
    GetProgramSignals,
    GetDiagramSignals,
}

SetSignals :: proc {
    SetApplicationVariablesSignals,
    SetProgramSignals,
    SetDiagramSignals,
}

TabName :: proc {
    GetPosInfoTabName,
    SetPosInfoTabName,
}

TaskConnection :: proc {
    GetFunctionBlockTaskConnection,
    SetFunctionBlockTaskConnection,
    GetControlModuleTaskConnection,
    SetControlModuleTaskConnection,
    GetSingleControlModuleTaskConnection,
    SetSingleControlModuleTaskConnection,
    GetProgramTaskConnection,
    SetProgramTaskConnection,
    GetDiagramTaskConnection,
    SetDiagramTaskConnection,
}

TraverseNumber :: proc {
    GetExtraInfoTraverseNumber,
    SetExtraInfoTraverseNumber,
}

TypeGuid :: proc {
    GetComponentTypeGuid,
    SetComponentTypeGuid,
    GetExtensibleParameterTypeGuid,
    GetParameterTypeGuid,
    GetExternalVariableTypeGuid,
    GetGlobalVariableTypeGuid,
    GetVariableTypeGuid,
    GetFunctionBlockTypesGuid,
    GetControlModuleTypesGuid,
    GetSingleControlModuleTypeGuid,
    SetSingleControlModuleTypeGuid,
    GetCommVariableTypeGuid,
    GetHWUnitTypeGuid,
    SetHWUnitTypeGuid,
    GetProgramTypeGuid,
    SetProgramTypeGuid,
    GetDiagramTypesGuid,
    SetDiagramTypesGuid,
    GetDiagramInstanceTypeGuid,
}

TypePath :: proc {
    GetComponentTypePath,
    GetCMParameterTypePath,
    GetExtensibleParameterTypePath,
    GetParameterTypePath,
    GetExternalVariableTypePath,
    GetGlobalVariableTypePath,
    GetVariableTypePath,
    GetFunctionBlockTypesPath,
    GetControlModuleTypePath,
    GetCommVariableTypePath,
    GetDiagramInstanceTypePath,
    GetVAAddressedVariableTypePath,
    GetVANamedVariableTypePath,
}

TypeName :: proc {
    GetComponentTypeName,
    SetComponentTypeName,
    GetCMParameterTypeName,
    SetCMParameterTypeName,
    GetExtensibleParameterTypeName,
    SetExtensibleParameterTypeName,
    GetParameterTypeName,
    SetParameterTypeName,
    GetExternalVariableTypeName,
    SetExternalVariableTypeName,
    GetGlobalVariableTypeName,
    SetGlobalVariableTypeName,
    GetVariableTypeName,
    SetVariableTypeName,
    GetFunctionBlockTypesName,
    SetFunctionBlockTypesName,
    GetCommVariableTypeName,
    SetCommVariableTypeName,
    GetDiagramInstanceTypeName,
    SetDiagramInstanceTypeName,
    GetControlModuleTypesName,
    SetControlModuleTypesName,
}

Unit :: proc {
    GetHWChannelUnit,
    SetHWChannelUnit,
}

UniqueID :: proc {
    GetCommVariableUniqueID,
    SetCommVariableUniqueID,
}

Type :: proc {
    GetVAAddressedVariableType,
    SetVAAddressedVariableType,
    GetVANamedVariableType,
    SetVANamedVariableType,
}

VarName :: proc {
    GetExtraInfoVarName,
    SetExtraInfoVarName,
}

GetVariables :: proc {
    GetApplicationVariablesVariables,
    GetFunctionBlockTypeVariables,
    GetControlModuleTypeVariables,
    GetProgramVariables,
    GetDiagramVariables,
    GetDiagramTypeVariables,
}

SetVariables :: proc {
    SetApplicationVariablesVariables,
    SetFunctionBlockTypeVariables,
    SetControlModuleTypeVariables,
    SetProgramVariables,
    SetDiagramVariables,
    SetDiagramTypeVariables,
}

GraphicsVisible :: proc {
    GetFunctionBlockTypeGraphicsVisible,
    SetFunctionBlockTypeGraphicsVisible,
    GetControlModuleGraphicsVisibility,
    SetControlModuleGraphicsVisibility,
    GetControlModuleTypeGraphicsVisible,
    SetControlModuleTypeGraphicsVisible,
    GetSingleControlModuleGraphicsVisibility,
    SetSingleControlModuleGraphicsVisibility,
    GetDiagramTypeGraphicsVisible,
    SetDiagramTypeGraphicsVisible,
}

MsgNumber :: proc {
    GetWarningMsgNumber,
    SetWarningMsgNumber,
}

WritePermission :: proc {
    GetComponentWritePermission,
    SetComponentWritePermission,
    GetCMParameterWritePermission,
    SetCMParameterWritePermission,
    GetParameterWritePermission,
    SetParameterWritePermission,
    GetExternalVariableWritePermission,
    SetExternalVariableWritePermission,
    GetGlobalVariableWritePermission,
    SetGlobalVariableWritePermission,
    GetVariableWritePermission,
    SetVariableWritePermission,
}

X :: proc {
    GetPointX,
    SetPointX,
    GetGraphNodeX,
    SetGraphNodeX,
    GetGraphPosX,
    SetGraphPosX,
}

XScale :: proc {
    GetGraphPosXScale,
    SetGraphPosXScale,
}

Y :: proc {
    GetPointY,
    SetPointY,
    GetGraphNodeY,
    SetGraphNodeY,
    GetGraphPosY,
    SetGraphPosY,
}

YScale :: proc {
    GetGraphPosYScale,
    SetGraphPosYScale,
}
