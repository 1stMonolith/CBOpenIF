package cbopenif

import "codeblock"
import "controlbuilder"
import "component"
import "point"
import "sfc"
import "signal"
import "type"

// properties procedures

access_level :: proc {
    component.component_access_level_get,
    component.component_access_level_set,
}

attribute :: proc {
    component.component_attribute_get,
    component.component_attribute_set,
}

authentication_level :: proc {
    component.component_authentication_level_get,
    component.component_authentication_level_set,
}

autopos :: proc {
    point.autopoint_autopos_get,
    point.autopoint_autopos_set,
}

description :: proc {
    component.component_description_get,
    component.component_description_set,
    signal.signal_description_get,
    signal.signal_description_set,
    type.datatype_description_get,
    type.datatype_description_set,
}

guid :: proc {
    type.datatype_guid_get,
    type.datatype_guid_set,
}

hidden :: proc {
    type.datatype_hidden_get,
    type.datatype_hidden_set,
}

initial_value :: proc {
    component.component_initial_value_get,
    component.component_initial_value_set,
}

isp_value :: proc {
    component.component_isp_value_get,
    component.component_isp_value_set,
}

name :: proc {
    codeblock.codeblock_name_get,
    codeblock.codeblock_name_set,
    codeblock.fbdcodeblock_name_get,
    codeblock.fbdcodeblock_name_set,
    codeblock.fdcodeblock_name_get,
    codeblock.fdcodeblock_name_set,
    codeblock.ilcodeblock_name_get,
    codeblock.ilcodeblock_name_set,
    codeblock.ldcodeblock_name_get,
    codeblock.ldcodeblock_name_set,
    codeblock.sfccodeblock_name_get,
    codeblock.sfccodeblock_name_set,
    codeblock.stcodeblock_name_get,
    codeblock.stcodeblock_name_set,
    component.component_name_get,
    component.component_name_set,
    sfc.sfcstep_name_get,
    sfc.sfcstep_name_set,
    sfc.sfcsubsequence_name_get,
    sfc.sfcsubsequence_name_set,
    sfc.sfctransition_name_get,
    sfc.sfctransition_name_set,
    signal.signal_name_get,
    signal.signal_name_set,
    type.datatype_name_get,
    type.datatype_name_set,
}

path :: proc {
    signal.signal_path_get,
    signal.signal_path_set,
}

priority :: proc {
    sfc.sfcbranch_priority_get,
    sfc.sfcbranch_priority_set,
}

protected :: proc {
    type.datatype_protected_get,
    type.datatype_protected_set,
}

read_permission :: proc {
    component.component_read_permission_get,
    component.component_read_permission_set,
}

reserved_by_function :: proc {
    type.datatype_reserved_by_function_get,
    type.datatype_reserved_by_function_set,
}

safety_type :: proc {
    component.component_safety_type_get,
    component.component_safety_type_set,
}

scope :: proc {
    type.datatype_scope_get,
    type.datatype_scope_set,
}

type_guid :: proc {
    component.component_type_guid_get
}

type_name :: proc {
    component.component_type_name_get,
    component.component_type_name_set,
}

type_path :: proc {
    component.component_type_path_get
}

write_permission :: proc {
    component.component_write_permission_get,
    component.component_write_permission_set,
}

x :: proc {
    point.point_x_get,
    point.point_x_set,
}

y :: proc {
    point.point_y_get,
    point.point_y_set,
}

// xml deserialize and serialize procedures

deserialize :: proc {
    signal.signal_deserialize,
    type.datatype_deserialize,
}

serialize :: proc {
    codeblock.fbdcodeblock_serialize,
    codeblock.fdcodeblock_serialize,
    codeblock.ilcodeblock_serialize,
    codeblock.ldcodeblock_serialize,
    codeblock.sfccodeblock_serialize,
    codeblock.stcodeblock_serialize,
    signal.signal_serialize,
    type.datatype_serialize,
}

// release procedures

release :: proc {
    codeblock.codeblock_release,
    codeblock.codeblocks_release,
    codeblock.fbdcodeblock_release,
    codeblock.fdcodeblock_release,
    codeblock.ilcodeblock_release,
    codeblock.ldcodeblock_release,
    codeblock.sfccodeblock_release,
    codeblock.stcodeblock_release,
    component.components_release,
    component.component_release,
    point.autopoint_release,
    point.point_release,
    point.points_release,
    sfc.sfcbranch_release,
    sfc.sfcbranches_release,
    sfc.sfcelement_release,
    sfc.sfcelements_release,
    sfc.sfcselection_release,
    sfc.sfcsimultaneous_release,
    sfc.sfcstep_release,
    sfc.sfcsubsequence_release,
    sfc.sfctransition_release,
    signal.signal_release,
    signal.signals_release,
    type.datatype_release,
}

// codeblock package types and procedures

CodeBlock        :: codeblock.CodeBlock
CodeBlocks       :: codeblock.CodeBlocks
FBDCodeBlock     :: codeblock.FBDCodeBlock
fbdcodeblock_new :: codeblock.fbdcodeblock_new
FDCodeBlock      :: codeblock.FDCodeBlock
ILCodeBlock      :: codeblock.ILCodeBlock
ilcodeblock_new  :: codeblock.ilcodeblock_new
LDCodeBlock      :: codeblock.LDCodeBlock
ldcodeblock_new  :: codeblock.ldcodeblock_new
SFCCodeBlock     :: codeblock.SFCCodeBlock
sfccodeblock_new :: codeblock.sfccodeblock_new
STCodeBlock      :: codeblock.STCodeBlock
stcodeblock_new  :: codeblock.stcodeblock_new

CodeBlockType    :: codeblock.CodeBlockType

//codeblocks :: proc {
//
//}

codeblock_add :: proc {
    codeblock.codeblocks_add_,
    codeblock.codeblocks_add_at_index,
    codeblock.codeblocks_add_st,
    codeblock.codeblocks_add_ld,
    codeblock.codeblocks_add_fbd,
    codeblock.codeblocks_add_il,
    codeblock.codeblocks_add_sfc,
    codeblock.codeblocks_add_fd,
}

codeblock_by_name  :: codeblock.codeblocks_codeblock_by_name
codeblock_by_index :: codeblock.codeblocks_codeblock_by_index
codeblock_index    :: codeblock.codeblocks_codeblock_index
codeblock_count    :: codeblock.codeblocks_count
codeblock_remove   :: codeblock.codeblocks_remove

codeblock_stcode :: proc {
    codeblock.fbdcodeblock_stcode_get,
    codeblock.fbdcodeblock_stcode_set,
    codeblock.ilcodeblock_stcode_get,
    codeblock.ilcodeblock_stcode_set,
    codeblock.ldcodeblock_stcode_get,
    codeblock.ldcodeblock_stcode_set,
    codeblock.stcodeblock_stcode_get,
    codeblock.stcodeblock_stcode_set,
}

fdcodeblock_xml_string :: proc {
    codeblock.fdcodeblock_xml_string_get,
    codeblock.fdcodeblock_xml_string_set,
}

sfccodeblock_seq_control :: proc {
    codeblock.sfccodeblock_seq_control_get,
    codeblock.sfccodeblock_seq_control_set,
}

sfccodeblock_step_elapsed_time :: proc {
    codeblock.sfccodeblock_step_elapsed_time_get,
    codeblock.sfccodeblock_step_elapsed_time_set,
}

sfccodeblock_viewer_aspect :: proc {
    codeblock.sfccodeblock_viewer_aspect_get,
    codeblock.sfccodeblock_viewer_aspect_set,
}

sfccodeblock_elements :: proc {
    codeblock.sfccodeblock_elements_get,
    codeblock.sfccodeblock_elements_set,
}

// component package types and procedures

Component     :: component.Component
Components    :: component.Components

component_new :: component.component_new

components :: proc {
    type.datatype_components_get,
    type.datatype_components_set,
}

component_add :: proc {
    component.components_add_,
    component.components_add_at_index,
    type.datatype_components_add_,
    type.datatype_components_add_at_index,
}

component_by_name :: proc {
    component.components_component_by_name,
    type.datatype_component_by_name,
}

component_by_index :: proc {
    component.components_component_by_index,
    type.datatype_component_by_index,
}

component_index :: proc {
    component.components_component_index,
    type.datatype_component_index,
}

component_count :: proc {
    component.components_count,
    type.datatype_components_count,
}

component_remove :: proc {
    component.components_remove_by_name,
    component.components_remove_by_index,
    type.datatype_remove_by_name,
    type.datatype_remove_by_index,
}

// control builder package procedures

connect     :: controlbuilder.connect
connected   :: controlbuilder.connected
disconnect  :: controlbuilder.disconnect
online      :: controlbuilder.online
offline     :: controlbuilder.offline
get_setting :: controlbuilder.get_setting

// point package types and procedures

AutoPoint     :: point.AutoPoint
Point         :: point.Point
Points        :: point.Points

autopoint_new :: point.autopoint_new
point_new     :: point.point_new

point_add :: proc {
    point.points_add_,
    point.points_add_at_index,
}

point_by_index :: proc {
    point.points_point_by_index,
}
point_count :: proc {
    point.points_count,
}

point_remove :: proc {
    point.points_remove_by_index,
}

// sfc pacakge types and procedures

SFCBranch           :: sfc.SFCBranch
SFCBranches         :: sfc.SFCBranches
SFCElement          :: sfc.SFCElement
SFCElementType      :: sfc.SFCElementType
SFCElements         :: sfc.SFCElements
SFCPriorityType     :: sfc.SFCPriorityType
SFCSelection        :: sfc.SFCSelection
SFCSimultaneous     :: sfc.SFCSimultaneous
SFCStep             :: sfc.SFCStep
SFCSubSequence      :: sfc.SFCSubSequence
SFCTransition       :: sfc.SFCTransition

sfcselection_new    :: sfc.sfcselection_new
sfcsimultaneous_new :: sfc.sfcsimultaneous_new
sfcstep_new         :: sfc.sfcstep_new
sfcsubsequence_new  :: sfc.sfcsubsequence_new
sfctransition_new   :: sfc.sfctransition_new

sfcbranche_add :: proc {
    sfc.sfcbranches_add_branch_,
    sfc.sfcbranches_add_branch_before,
}

sfcbranch_by_index :: proc {
    sfc.sfcbranches_branch,
}

sfcbranch_count :: proc {
    sfc.sfcbranches_count,
}

sfcbranch_remove :: proc {
    sfc.sfcbranches_remove,
}

sfcbranches_add :: proc {
    sfc.sfcbranches_add_,
    sfc.sfcbranches_add_at_index,
}

sfcbranches :: proc {
    sfc.sfcselection_branches_get,
    sfc.sfcselection_branches_set,
    sfc.sfcsimultaneous_branches_get,
    sfc.sfcsimultaneous_branches_set,
}

sfcelement_add :: proc {
    sfc.sfcelements_add_sfcstep,
    sfc.sfcelements_add_sfctransition,
    sfc.sfcelements_add_sfcselection,
    sfc.sfcelements_add_sfcsimultaneous,
    sfc.sfcelements_add_sfcsubsequence,
    sfc.sfcelements_add_,
    sfc.sfcelements_add_at_index,
}

sfcelement_by_index :: proc {
    sfc.sfcelements_sfcelement_by_index,
}

sfcelement_count :: proc {
    sfc.sfcelements_count,
}

sfcelement_remove :: proc {
    sfc.sfcelements_remove
}

sfcelement_is_step :: proc {
    sfc.sfcelement_is_step,
}

sfcelement_is_transition :: proc {
    sfc.sfcelement_is_transition,
}

sfcelement_is_subsequence :: proc {
    sfc.sfcelement_is_subsequence,
}

sfcelement_is_selection :: proc {
    sfc.sfcelement_is_selection,
}

sfcelement_is_simultaneous :: proc {
    sfc.sfcelement_is_simultaneous,
}

sfcelements :: proc {
    sfc.sfcbranch_elements_get,
    sfc.sfcbranch_elements_set,
    sfc.sfcsubsequence_elements_get,
    sfc.sfcsubsequence_elements_set,
}

// signal package types and procedures

Signal     :: signal.Signal
Signals    :: signal.Signals
SignalType :: signal.SignalType

signal_new :: signal.signal_new

signal :: proc {
    signal.signals_signal_by_name,
    signal.signals_signal_by_index,
}

signal_add :: proc {
    signal.signals_add_,
    signal.signals_add_at_index,
}

signal_index :: proc {
    signal.signals_signal_index,
}

signal_count :: proc {
    signal.signals_count,
}

signal_remove :: proc {
    signal.signals_remove_by_name,
    signal.signals_remove_by_index,
}

// type package types and procedures

DataType                 :: type.DataType
datatype_new             :: type.datatype_new

AutoPosType              :: type.AutoPosType
DirectionType            :: type.DirectionType
ExecutionInstanceType    :: type.ExecutionInstanceType
FolderType               :: type.FolderType
HardwareFileType         :: type.HardwareFileType
HardwareLibraryFileType  :: type.HardwareLibraryFileType
MessageType              :: type.MessageType
OutputUpdateType         :: type.OutputUpdateType
ParameterType            :: type.ParameterType
ScopeType                :: type.ScopeType
TaskPriorityType         :: type.TaskPriorityType
TaskSILLevelType         :: type.TaskSILLevelType
VariableType             :: type.VariableType
VisibilityInGraphicsType :: type.VisibilityInGraphicsType
