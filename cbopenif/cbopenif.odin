package cbopenif

import "codeblock"
import "component"
import "connection"
import "controlbuilder"
import "graph"
import "il"
import "parameter"
import "point"
import "project"
import "sfc"
import "signal"
import "type"
import "variable"

// ---------------------------------------------------------------------------
// Shared property overload groups
// ---------------------------------------------------------------------------

access_level :: proc {
    component.component_access_level_get,
    component.component_access_level_set,
    variable.variable_access_level_get,
    variable.variable_access_level_set,
    variable.globalvariable_access_level_get,
    variable.globalvariable_access_level_set,
    variable.externalvariable_access_level_get,
    variable.externalvariable_access_level_set,
}

actual_parameter :: proc {
    connection.cmconnection_actual_parameter_get,
    connection.cmconnection_actual_parameter_set,
}

attribute :: proc {
    component.component_attribute_get,
    component.component_attribute_set,
    parameter.parameter_attribute_get,
    parameter.parameter_attribute_set,
    variable.variable_attribute_get,
    variable.variable_attribute_set,
    variable.globalvariable_attribute_get,
    variable.globalvariable_attribute_set,
    variable.externalvariable_attribute_get,
    variable.externalvariable_attribute_set,
}

authentication_level :: proc {
    component.component_authentication_level_get,
    component.component_authentication_level_set,
    variable.variable_authentication_level_get,
    variable.variable_authentication_level_set,
    variable.globalvariable_authentication_level_get,
    variable.globalvariable_authentication_level_set,
    variable.externalvariable_authentication_level_get,
    variable.externalvariable_authentication_level_set,
}

AutoPoint :: point.AutoPoint
autopoint_new :: point.autopoint_new

autopos :: proc {
    point.autopoint_autopos_get,
    point.autopoint_autopos_set,
}

ApplicationVariables :: variable.ApplicationVariables

applicationvariables_new  :: variable.applicationvariables_new

applicationvariables_globals :: proc {
    variable.applicationvariables_globals_get,
    variable.applicationvariables_globals_set,
}

applicationvariables_variables :: proc {
    variable.applicationvariables_variables_get,
    variable.applicationvariables_variables_set,
}

applicationvariables_signals :: proc {
    variable.applicationvariables_signals_get,
    variable.applicationvariables_signals_set,
}

CMConnection  :: connection.CMConnection

cmconnection_new :: connection.cmconnection_new

cmconnection_add :: proc {
    connection.cmconnections_add_,
    connection.cmconnections_add_at_index,
}

cmconnection :: proc {
    connection.cmconnections_cmconnection_by_name,
    connection.cmconnections_cmconnection_by_index,
}

cmconnection_index :: connection.cmconnections_cmconnection_index
cmconnection_count :: connection.cmconnections_count

cmconnection_remove :: proc {
    connection.cmconnections_remove_by_name,
    connection.cmconnections_remove_by_index,
}

CMConnections :: connection.CMConnections

CMParameter :: parameter.CMParameter

cmparameter_new :: parameter.cmparameter_new

cmparameter_add :: proc {
    parameter.cmparameters_add_,
    parameter.cmparameters_add_at_index,
}

cmparameter_by_name  :: parameter.cmparameters_cmparameter_by_name
cmparameter_by_index :: parameter.cmparameters_cmparameter_by_index
cmparameter_index    :: parameter.cmparameters_cmparameter_index
cmparameter_count    :: parameter.cmparameters_count

cmparameter_remove :: proc {
    parameter.cmparameters_remove_by_name,
    parameter.cmparameters_remove_by_index,
}

CMParameters      :: parameter.CMParameters

CodeBlock     :: codeblock.CodeBlock
CodeBlocks    :: codeblock.CodeBlocks
CodeBlockType :: codeblock.CodeBlockType
FBDCodeBlock  :: codeblock.FBDCodeBlock
FDCodeBlock   :: codeblock.FDCodeBlock
ILCodeBlock   :: codeblock.ILCodeBlock
LDCodeBlock   :: codeblock.LDCodeBlock
SFCCodeBlock  :: codeblock.SFCCodeBlock
STCodeBlock   :: codeblock.STCodeBlock

fbdcodeblock_new :: codeblock.fbdcodeblock_new
ilcodeblock_new  :: codeblock.ilcodeblock_new
ldcodeblock_new  :: codeblock.ldcodeblock_new
sfccodeblock_new :: codeblock.sfccodeblock_new
stcodeblock_new  :: codeblock.stcodeblock_new

codeblock :: proc {
    codeblock.codeblocks_codeblock_by_name,
    codeblock.codeblocks_codeblock_by_index,
}

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

codeblock_index  :: codeblock.codeblocks_codeblock_index
codeblock_count  :: codeblock.codeblocks_count
codeblock_remove :: codeblock.codeblocks_remove

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

Component  :: component.Component

component_new :: component.component_new

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

Components :: component.Components

components :: proc {
    type.datatype_components_get,
    type.datatype_components_set,
}

controlbuilder_connect    :: controlbuilder.controlbuilder_connect
controlbuilder_connected  :: controlbuilder.controlbuilder_connected
controlbuilder_disconnect :: controlbuilder.controlbuilder_disconnect
controlbuilder_online     :: controlbuilder.controlbuilder_online
controlbuilder_offline    :: controlbuilder.controlbuilder_offline

controlbuilder_setting :: proc {
    controlbuilder.controlbuilder_get_setting,
    controlbuilder.controlbuilder_set_setting_string,
}

DataType :: type.DataType

datatype_new :: type.datatype_new

deserialize :: proc {
    codeblock.codeblock_deserialize,
    connection.cmconnection_deserialize,
    parameter.parameter_deserialize,
    parameter.cmparameter_deserialize,
    signal.signal_deserialize,
    type.datatype_deserialize,
    variable.variable_deserialize,
    variable.globalvariable_deserialize,
    variable.externalvariable_deserialize,
    variable.applicationvariables_deserialize,
}

description :: proc {
    component.component_description_get,
    component.component_description_set,
    il.ilrow_description_get,
    il.ilrow_description_set,
    parameter.parameter_description_get,
    parameter.parameter_description_set,
    parameter.cmparameter_description_get,
    parameter.cmparameter_description_set,
    signal.signal_description_get,
    signal.signal_description_set,
    type.datatype_description_get,
    type.datatype_description_set,
    variable.variable_description_get,
    variable.variable_description_set,
    variable.globalvariable_description_get,
    variable.globalvariable_description_set,
    variable.externalvariable_description_get,
    variable.externalvariable_description_set,
    variable.applicationvariables_description_get,
    variable.applicationvariables_description_set,
}

ExternalVariable :: variable.ExternalVariable

externalvariable_new :: variable.externalvariable_new

externalvariable_add :: proc {
    variable.externalvariables_add_,
    variable.externalvariables_add_at_index,
}

externalvariable_by_name  :: variable.externalvariables_external_by_name
externalvariable_by_index :: variable.externalvariables_external_by_index
externalvariable_index    :: variable.externalvariables_external_index
externalvariable_count    :: variable.externalvariables_count

externalvariable_remove :: proc {
    variable.externalvariables_remove_by_name,
    variable.externalvariables_remove_by_index,
}

ExternalVariables :: variable.ExternalVariables

GlobalVariable :: variable.GlobalVariable

globalvariable_new :: variable.globalvariable_new

globalvariable_add :: proc {
    variable.globalvariables_add_,
    variable.globalvariables_add_at_index,
}

globalvariable_by_name  :: variable.globalvariables_global_by_name
globalvariable_by_index :: variable.globalvariables_global_by_index
globalvariable_index    :: variable.globalvariables_global_index
globalvariable_count    :: variable.globalvariables_count

globalvariable_remove :: proc {
    variable.globalvariables_remove_by_name,
    variable.globalvariables_remove_by_index,
}

GlobalVariables :: variable.GlobalVariables

GraphNode :: graph.GraphNode

graphnode_new :: graph.graphnode_new
graphpos_new  :: graph.graphpos_new
graphsize_new :: graph.graphsize_new

graphnode_add :: proc {
    graph.graphnodes_add_,
    graph.graphnodes_add_at_index,
}

graphnode_by_name  :: graph.graphnodes_graphnode_by_name
graphnode_by_index :: graph.graphnodes_graphnode_by_index
graphnode_index    :: graph.graphnodes_graphnode_index
graphnode_count    :: graph.graphnodes_count

graphnode_remove :: proc {
    graph.graphnodes_remove_by_name,
    graph.graphnodes_remove_by_index,
}

GraphNodes :: graph.GraphNodes

GraphPos :: graph.GraphPos

GraphSize :: graph.GraphSize

graphical_connection :: proc {
    connection.cmconnection_graphical_connection_get,
    connection.cmconnection_graphical_connection_set,
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
    parameter.parameter_initial_value_get,
    parameter.parameter_initial_value_set,
    parameter.cmparameter_initial_value_get,
    parameter.cmparameter_initial_value_set,
    variable.variable_initial_value_get,
    variable.variable_initial_value_set,
    variable.globalvariable_initial_value_get,
    variable.globalvariable_initial_value_set,
}

ILRow  :: il.ILRow
ILRows :: il.ILRows

ilrow_new :: proc {
    il.ilrow_new_,
    il.ilrow_new_comment,
}

ilrow_comment :: proc {
    il.ilrow_row_comment_get,
    il.ilrow_row_comment_set,
}

ilrow_instruction :: proc {
    il.ilrow_instruction_get,
    il.ilrow_instruction_set,
}

ilrow_is_comment :: proc {
    il.ilrow_is_row_comment_get,
    il.ilrow_is_row_comment_set,
}

ilrow_label :: proc {
    il.ilrow_label_get,
    il.ilrow_label_set,
}

ilrow_operand :: proc {
    il.ilrow_operand_get,
    il.ilrow_operand_set,
}

ilrow_add :: proc {
    il.ilrows_add_,
    il.ilrows_add_at_index,
}

ilrow_by_index :: il.ilrows_ilrow_by_index
ilrow_count    :: il.ilrows_count
ilrow_remove   :: il.ilrows_remove

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
    connection.cmconnection_name_get,
    connection.cmconnection_name_set,
    graph.graphnode_name_get,
    graph.graphnode_name_set,
    parameter.parameter_name_get,
    parameter.parameter_name_set,
    parameter.cmparameter_name_get,
    parameter.cmparameter_name_set,
    parameter.parametersetting_name_get,
    parameter.parametersetting_name_set,
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
    variable.variable_name_get,
    variable.variable_name_set,
    variable.globalvariable_name_get,
    variable.globalvariable_name_set,
    variable.externalvariable_name_get,
    variable.externalvariable_name_set,
}

Parameter  :: parameter.Parameter
Parameters :: parameter.Parameters

parameter_new         :: parameter.parameter_new

parameter_add :: proc {
    parameter.parameters_add_,
    parameter.parameters_add_at_index,
}

parameter_by_name  :: parameter.parameters_parameter_by_name
parameter_by_index :: parameter.parameters_parameter_by_index
parameter_index    :: parameter.parameters_parameter_index
parameter_count    :: parameter.parameters_count

parameter_remove :: proc {
    parameter.parameters_remove_by_name,
    parameter.parameters_remove_by_index,
}

ParameterSetting :: parameter.ParameterSetting

parametersetting_new  :: parameter.parametersetting_new


parametersetting_add :: proc {
    parameter.parametersettings_add_,
    parameter.parametersettings_add_at_index,
}

parametersetting_by_name  :: parameter.parametersettings_parametersetting_by_name
parametersetting_by_index :: parameter.parametersettings_parametersetting_by_index
parametersetting_index    :: parameter.parametersettings_parametersetting_index
parametersetting_count    :: parameter.parametersettings_count

parametersetting_remove :: proc {
    parameter.parametersettings_remove_by_name,
    parameter.parametersettings_remove_by_index,
}

ParameterSettings :: parameter.ParameterSettings

path :: proc {
    signal.signal_path_get,
    signal.signal_path_set,
}

Point :: point.Point

point_new :: point.point_new

point :: proc {
    point.points_point_by_index,
}

point_lower_left :: proc {
    graph.graphsize_lower_left_get,
    graph.graphsize_lower_left_set,
}

point_upper_right :: proc {
    graph.graphsize_upper_right_get,
    graph.graphsize_upper_right_set,
}

point_add :: proc {
    point.points_add_,
    point.points_add_at_index,
}

point_count    :: point.points_count
point_remove   :: point.points_remove_by_index

Points :: point.Points

points :: proc {
    connection.cmconnection_points_get,
    connection.cmconnection_points_set,
}

project_new     :: project.project_new
project_open    :: project.project_open
project_close   :: project.project_close
project_refresh :: project.project_refresh

protected :: proc {
    type.datatype_protected_get,
    type.datatype_protected_set,
}

read_permission :: proc {
    component.component_read_permission_get,
    component.component_read_permission_set,
    parameter.parameter_read_permission_get,
    parameter.parameter_read_permission_set,
    parameter.cmparameter_read_permission_get,
    parameter.cmparameter_read_permission_set,
    variable.variable_read_permission_get,
    variable.variable_read_permission_set,
    variable.globalvariable_read_permission_get,
    variable.globalvariable_read_permission_set,
    variable.externalvariable_read_permission_get,
    variable.externalvariable_read_permission_set,
}

release :: proc {
    codeblock.codeblock_release,
    codeblock.codeblocks_release,
    codeblock.fbdcodeblock_release,
    codeblock.fdcodeblock_release,
    codeblock.ilcodeblock_release,
    codeblock.ldcodeblock_release,
    codeblock.sfccodeblock_release,
    codeblock.stcodeblock_release,
    component.component_release,
    component.components_release,
    connection.cmconnection_release,
    connection.cmconnections_release,
    graph.graphnode_release,
    graph.graphnodes_release,
    graph.graphpos_release,
    graph.graphsize_release,
    il.ilrow_release,
    il.ilrows_release,
    parameter.parameter_release,
    parameter.parameters_release,
    parameter.cmparameter_release,
    parameter.cmparameters_release,
    parameter.parametersetting_realease,
    parameter.parametersettings_release,
    point.point_release,
    point.points_release,
    point.autopoint_release,
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
    variable.variable_release,
    variable.variables_release,
    variable.globalvariable_release,
    variable.globalvariables_release,
    variable.externalvariable_release,
    variable.externalvariables_release,
    variable.applicationvariables_release,
}

rotation :: proc {
    graph.graphpos_rotation_get,
    graph.graphpos_rotation_set,
}

safety_type :: proc {
    component.component_safety_type_get,
    component.component_safety_type_set,
    variable.variable_safety_type_get,
    variable.variable_safety_type_set,
    variable.globalvariable_safety_type_get,
    variable.globalvariable_safety_type_set,
    variable.externalvariable_safety_type_get,
    variable.externalvariable_safety_type_set,
}

scope :: proc {
    type.datatype_scope_get,
    type.datatype_scope_set,
}

serialize :: proc {
    codeblock.fbdcodeblock_serialize,
    codeblock.fdcodeblock_serialize,
    codeblock.ilcodeblock_serialize,
    codeblock.ldcodeblock_serialize,
    codeblock.sfccodeblock_serialize,
    codeblock.stcodeblock_serialize,
    connection.cmconnection_serialize,
    parameter.parameter_serialize,
    parameter.cmparameter_serialize,
    signal.signal_serialize,
    type.datatype_serialize,
    variable.variable_serialize,
    variable.globalvariable_serialize,
    variable.externalvariable_serialize,
    variable.applicationvariables_serialize,
}

SFCBranch       :: sfc.SFCBranch
SFCBranches     :: sfc.SFCBranches
SFCElement      :: sfc.SFCElement
SFCElementType  :: sfc.SFCElementType
SFCElements     :: sfc.SFCElements
SFCPriorityType :: sfc.SFCPriorityType
SFCSelection    :: sfc.SFCSelection
SFCSimultaneous :: sfc.SFCSimultaneous
SFCStep         :: sfc.SFCStep
SFCSubSequence  :: sfc.SFCSubSequence
SFCTransition   :: sfc.SFCTransition

sfcselection_new    :: sfc.sfcselection_new
sfcsimultaneous_new :: sfc.sfcsimultaneous_new
sfcstep_new         :: sfc.sfcstep_new
sfcsubsequence_new  :: sfc.sfcsubsequence_new
sfctransition_new   :: sfc.sfctransition_new

sfcpriority :: proc {
    sfc.sfcbranch_priority_get,
    sfc.sfcbranch_priority_set,
}

sfcbranches :: proc {
    sfc.sfcselection_branches_get,
    sfc.sfcselection_branches_set,
    sfc.sfcsimultaneous_branches_get,
    sfc.sfcsimultaneous_branches_set,
}

sfcelements :: proc {
    sfc.sfcbranch_elements_get,
    sfc.sfcbranch_elements_set,
    sfc.sfcsubsequence_elements_get,
    sfc.sfcsubsequence_elements_set,
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

sfcelement_by_index :: sfc.sfcelements_sfcelement_by_index
sfcelement_count    :: sfc.sfcelements_count
sfcelement_remove   :: sfc.sfcelements_remove

sfcelement_is_step         :: sfc.sfcelement_is_step
sfcelement_is_transition   :: sfc.sfcelement_is_transition
sfcelement_is_subsequence  :: sfc.sfcelement_is_subsequence
sfcelement_is_selection    :: sfc.sfcelement_is_selection
sfcelement_is_simultaneous :: sfc.sfcelement_is_simultaneous

Signal :: signal.Signal

signal_new :: signal.signal_new

signal_add :: proc {
    signal.signals_add_,
    signal.signals_add_at_index,
}

signal_by_name  :: signal.signals_signal_by_name
signal_by_index :: signal.signals_signal_by_index
signal_index    :: signal.signals_signal_index
signal_count    :: signal.signals_count

signal_remove :: proc {
    signal.signals_remove_by_name,
    signal.signals_remove_by_index,
}

Signals :: signal.Signals

SignalType :: signal.SignalType

type_guid :: proc {
    component.component_type_guid_get,
}

type_path :: proc {
    component.component_type_path_get,
}

type_name :: proc {
    component.component_type_name_get,
    component.component_type_name_set,
    parameter.parameter_type_name_get,
    parameter.parameter_type_name_set,
    parameter.cmparameter_type_name_get,
    parameter.cmparameter_type_name_set,
    variable.variable_type_name_get,
    variable.variable_type_name_set,
    variable.globalvariable_type_name_get,
    variable.globalvariable_type_name_set,
    variable.externalvariable_type_name_get,
    variable.externalvariable_type_name_set,
}

Variable :: variable.Variable

variable_new :: variable.variable_new

variable_add :: proc {
    variable.variables_add_,
    variable.variables_add_at_index,
}

variable_by_name  :: variable.variables_variable_by_name
variable_by_index :: variable.variables_variable_by_index
variable_index    :: variable.variables_variable_index
variable_count    :: variable.variables_count

variable_remove :: proc {
    variable.variables_remove_by_name,
    variable.variables_remove_by_index,
}

Variables :: variable.Variables

write_permission :: proc {
    component.component_write_permission_get,
    component.component_write_permission_set,
    parameter.parameter_write_permission_get,
    parameter.parameter_write_permission_set,
    parameter.cmparameter_write_permission_get,
    parameter.cmparameter_write_permission_set,
    variable.variable_write_permission_get,
    variable.variable_write_permission_set,
    variable.globalvariable_write_permission_get,
    variable.globalvariable_write_permission_set,
    variable.externalvariable_write_permission_get,
    variable.externalvariable_write_permission_set,
}

x :: proc {
    point.point_x_get,
    point.point_x_set,
    graph.graphnode_x_get,
    graph.graphnode_x_set,
    graph.graphpos_x_get,
    graph.graphpos_x_set,
}

xscale :: proc {
    graph.graphpos_xscale_get,
    graph.graphpos_xscale_set,
}

y :: proc {
    point.point_y_get,
    point.point_y_set,
    graph.graphnode_y_get,
    graph.graphnode_y_set,
    graph.graphpos_y_get,
    graph.graphpos_y_set,
}

yscale :: proc {
    graph.graphpos_yscale_get,
    graph.graphpos_yscale_set,
}

// ---------------------------------------------------------------------------
// TODO: Sort
// ---------------------------------------------------------------------------


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
