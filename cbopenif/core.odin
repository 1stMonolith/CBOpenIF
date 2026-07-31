package cbopenif

import "cbopen"
import "factory"

_As_Variable :: struct {}
_As_GlobalVariable :: struct {}
_As_Signal :: struct {}

As_Varialbe : _As_Variable = {}
As_GlobalVarialbe : _As_GlobalVariable = {}
As_Signal : _As_Signal = {}

online :: proc {
    controlbuilder_online,
}

offline :: proc {
    controlbuilder_offline,
}

get_setting :: proc {
    controlbuilder_get_setting,
}

name :: proc {
    datatype_name_,
    datatype_name_set,
    component_name_,
    component_name_set,
    variable_name_,
    variable_name_set,
    graphnode_name_,
    graphnode_name_set,
    signal_name_,
    signal_name_set,
    globalvariable_name_,
    globalvariable_name_set,
    externalvariable_name_,
    externalvariable_name_set,
    parameter_name_,
    parameter_name_set,
    parameter_setting_name_,
    parameter_setting_name_set,
    cmconnection_name_,
    cmconnection_name_set,
    cmparameter_name_,
    cmparameter_name_set,
    icodeblock_name_,
    icodeblock_name_set,
    fdcodeblock_name_,
    fdcodeblock_name_set,
    ldcodeblock_name_,
    ldcodeblock_name_set,
    fbdcodeblock_name_,
    fbdcodeblock_name_set,
    stcodeblock_name_,
    stcodeblock_name_set,
    ilrow_name_,
    ilrow_name_set,
    sfctransition_name_,
    sfctransition_name_set,
    sfcstep_name_,
    sfcstep_name_set,
    sfcsubsequence_name_,
    sfcsubsequence_name_set,
    sfccodeblock_name_,
    sfccodeblock_name_set,
}

comment :: proc {
    ilrow_row_comment_,
    ilrow_row_comment_set,
}

is_comment :: proc {
    ilrow_is_row_comment_,
    ilrow_is_row_comment_set,
}

x :: proc {
    graphnode_x_,
    graphnode_x_set,
    point_x_,
    point_x_set,
    graphpos_x_,
    graphpos_x_set,
}

y :: proc {
    graphnode_y_,
    graphnode_y_set,
    point_y_,
    point_y_set,
    graphpos_y_,
    graphpos_y_set,
}

xscale :: proc {
    graphpos_xscale_,
    graphpos_xscale_set,
}

yscale :: proc {
    graphpos_yscale_,
    graphpos_yscale_set,
}

rotation :: proc {
    graphpos_rotation_,
    graphpos_rotation_set,
}

lower_left :: proc {
    graphsize_lower_left_,
    graphsize_lower_left_set,
}

upper_right :: proc {
    graphsize_upper_right_,
    graphsize_upper_right_set,
}

type_name :: proc {
    component_type_name_,
    component_type_name_set,
    variable_type_name_,
    variable_type_name_set,
    globalvariable_type_name_,
    globalvariable_type_name_set,
    externalvariable_type_name_,
    externalvariable_type_name_set,
    parameter_type_name_,
    parameter_type_name_set,
    cmparameter_type_name_,
    cmparameter_type_name_set,
}

parameter_value :: proc {
    parameter_setting_parameter_value_,
    parameter_setting_parameter_value_set,
}

actual_parameter :: proc {
    cmconnection_actual_parameter_,
    cmconnection_actual_parameter_set,
}

graphical_connection :: proc {
    cmconnection_graphical_connection_,
    cmconnection_graphical_connection_set,
}

points :: proc {
    cmconnection_points_,
    cmconnection_points_set,
}

attribute :: proc {
    component_attribute_,
    component_attribute_set,
    variable_attribute_,
    variable_attribute_set,
    globalvariable_attribute_,
    globalvariable_attribute_set,
    externalvariable_attribute_,
    externalvariable_attribute_set,
    parameter_attribute_,
    parameter_attribute_set,
}

initial_value :: proc {
    component_initial_value_,
    component_initial_value_set,
    variable_initial_value_,
    variable_initial_value_set,
    globalvariable_initial_value_,
    globalvariable_initial_value_set,
    cmparameter_initial_value_,
    cmparameter_initial_value_set,
}

read_permission :: proc {
    component_read_permission_,
    component_read_permission_set,
    variable_read_permission_,
    variable_read_permission_set,
    globalvariable_read_permission_,
    globalvariable_read_permission_set,
    externalvariable_read_permission_,
    externalvariable_read_permission_set,
    parameter_read_permission_,
    parameter_read_permission_set,
    cmparameter_read_permission_,
    cmparameter_read_permission_set,
}

write_permission :: proc {
    component_write_permission_,
    component_write_permission_set,
    variable_write_permission_,
    variable_write_permission_set,
    globalvariable_write_permission_,
    globalvariable_write_permission_set,
    externalvariable_write_permission_,
    externalvariable_write_permission_set,
    parameter_write_permission_,
    parameter_write_permission_set,
    cmparameter_write_permission_,
    cmparameter_write_permission_set,
}

access_level :: proc {
    component_access_level_,
    component_access_level_set,
    variable_access_level_,
    variable_access_level_set,
    globalvariable_access_level_,
    globalvariable_access_level_set,
    externalvariable_access_level_,
    externalvariable_access_level_set,
    parameter_access_level_,
    parameter_access_level_set,
    cmparameter_access_level_,
    cmparameter_access_level_set,
}

authentication_level :: proc {
    variable_authentication_level_,
    variable_authentication_level_set,
    globalvariable_authentication_level_,
    globalvariable_authentication_level_set,
    externalvariable_authentication_level_,
    externalvariable_authentication_level_set,
    parameter_authentication_level_,
    parameter_authentication_level_set,
    cmparameter_authentication_level_,
    cmparameter_authentication_level_set,
}

safety_type :: proc {
    component_safety_type_,
    component_safety_type_set,
    variable_safety_type_,
    variable_safety_type_set,
    globalvariable_safety_type_,
    globalvariable_safety_type_set,
    externalvariable_safety_type_,
    externalvariable_safety_type_set,
    parameter_safety_type_,
    parameter_safety_type_set,
    cmparameter_safety_type_,
    cmparameter_safety_type_set,
}

fdport :: proc {
    parameter_fdport_,
    parameter_fdport_set,
    cmparameter_fdport_,
    cmparameter_fdport_set,
}

batch_property :: proc {
    variable_batch_property_,
    variable_batch_property_set,
    cmparameter_batch_property_,
    cmparameter_batch_property_set,
}

auto_pos :: proc {
    autopoint_autopos_,
    autopoint_autopos_set,
}

auto_point :: proc {
    cmparameter_auto_point_,
    cmparameter_auto_point_set,
}

graph_nodes :: proc {
    variable_graph_nodes_,
    variable_graph_nodes_set,
    globalvariable_graph_nodes_,
    globalvariable_graph_nodes_set,
    externalvariable_graph_nodes_,
    externalvariable_graph_nodes_set,
    cmparameter_graph_nodes_,
    cmparameter_graph_nodes_set,
}

isp_value :: proc {
    component_isp_value_,
    component_isp_value_set,
}

description :: proc {
    datatype_description_,
    datatype_description_set,
    component_description_,
    component_description_set,
    variable_description_,
    variable_description_set,
    applicationvariables_description_,
    applicationvariables_description_set,
    signal_description_,
    signal_description_set,
    globalvariable_description_,
    globalvariable_description_set,
    externalvariable_description_,
    externalvariable_description_set,
    parameter_description_,
    parameter_description_set,
    parameter_setting_description_,
    cmparameter_description_,
    cmparameter_description_set,
    ilrow_description_,
    ilrow_description_set,
}

path :: proc {
    signal_path_,
    signal_path_set,
}

guid :: proc {
    datatype_guid_,
    datatype_guid_set,
}

type_guid :: proc {
    component_type_guid,
    variable_type_guid,
    globalvariable_type_guid,
    externalvariable_type_guid,
    parameter_type_guid,
    cmparameter_type_guid,
}

direction :: proc {
    cmparameter_direction_,
    cmparameter_direction_set,
}

type_path :: proc {
    component_type_path,
    variable_type_path,
    globalvariable_type_path,
    externalvariable_type_path,
    parameter_type_path,
    cmparameter_type_path,
}

reserved_by_function :: proc {
    datatype_reserved_by_function_,
    datatype_reserved_by_function_set,
}

protected :: proc {
    datatype_protected_,
    datatype_protected_set,
}

hidden :: proc {
    datatype_hidden_,
    datatype_hidden_set,
}

scope :: proc {
    datatype_scope_,
    datatype_scope_set,
}

globals :: proc {
    applicationvariables_globals_,
    applicationvariables_globals_set,
}

variables :: proc {
    applicationvariables_variables_,
    applicationvariables_variables_set,
}

signals :: proc {
    applicationvariables_signals_,
    applicationvariables_signals_set,
}

is_st :: proc {
    icodeblock_is_st,
}

is_sfc :: proc {
    icodeblock_is_sfc,
}

is_il :: proc {
    icodeblock_is_il,
}

is_fbd :: proc {
    icodeblock_is_fbd,
}

is_ld :: proc {
    icodeblock_is_ld,
}

is_fd :: proc {
    icodeblock_is_fd,
}

is_step :: proc {
    isfcelement_is_step,
}

is_transition :: proc {
    isfcelement_is_transition,
}

is_subsequence :: proc {
    isfcelement_is_subsequence,
}

is_selection :: proc {
    isfcelement_is_selection,
}

is_simultaneous :: proc {
    isfcelement_is_simultaneous,
}

xml_string :: proc {
    fdcodeblock_xml_string_,
    fdcodeblock_xml_string_set,
}

stcode :: proc {
    ldcodeblock_stcode_,
    ldcodeblock_stcode_set,
    fbdcodeblock_stcode_,
    fbdcodeblock_stcode_set,
    stcodeblock_stcode_,
    stcodeblock_stcode_set,
    sfcstcode_,
    sfcstcode_set,
}

dest :: proc {
    sfctransition_dest_,
    sfctransition_dest_set,
}

initial_step :: proc {
    sfcstep_initial_step_,
    sfcstep_initial_step_set,
}

p1_action_stcode :: proc {
    sfcstep_p1_action_stcode_,
    sfcstep_p1_action_stcode_set,
}

p0_action_stcode :: proc {
    sfcstep_p0_action_stcode_,
    sfcstep_p0_action_stcode_set,
}

n_action_stcode :: proc {
    sfcstep_n_action_stcode_,
    sfcstep_n_action_stcode_set,
}

priority :: proc {
    sfcbranch_priority_,
    sfcbranch_priority_set,
}

elements :: proc {
    sfcbranch_elements_,
    sfcbranch_elements_set,
    sfcsubsequence_elements_,
    sfcsubsequence_elements_set,
    sfccodeblock_elements_,
    sfccodeblock_elements_set,
}

branches :: proc {
    sfcselection_branches_,
    sfcselection_branches_set,
    sfcsimultaneous_branches_,
    sfcsimultaneous_branches_set,
}

seq_control :: proc {
    sfccodeblock_seq_control_,
    sfccodeblock_seq_control_set,
}

elapsed_time :: proc {
    sfccodeblock_step_elapsed_time_,
    sfccodeblock_step_elapsed_time_set,
}

viewer_aspect :: proc {
    sfccodeblock_viewer_aspect_,
    sfccodeblock_viewer_aspect_set,
}

serialize :: proc {
    datatype_serialize,
    variable_serialize,
    applicationvariables_serialize,
    signal_serialize,
    globalvariable_serialize,
    externalvariable_serialize,
    parameter_serialize,
    cmconnection_serialize,
    cmparameter_serialize,
    fdcodeblock_serialize,
    ldcodeblock_serialize,
    fbdcodeblock_serialize,
    stcodeblock_serialize,
    sfccodeblock_serialize,
}

deserialize :: proc {
    datatype_deserialize,
    variable_deserialize,
    applicationvariables_deserialize,
    signal_deserialize,
    globalvariable_deserialize,
    externalvariable_deserialize,
    parameter_deserialize,
    cmconnection_deserialize,
    cmparameter_deserialize,
    icodeblock_deserialize,
}

add :: proc {
    datatype_component_add_,
    datatype_component_add_at_index,
    components_add_,
    components_add_at_index,
    variables_add_,
    variables_add_at_index,
    graphnodes_add_,
    graphnodes_add_at_index,
    applicationvariables_globals_add_,
    applicationvariables_globals_add_at_index,
    applicationvariables_variables_add_,
    applicationvariables_variables_add_at_index,
    applicationvariables_signals_add_,
    applicationvariables_signals_add_at_index,
    signals_add_,
    signals_add_at_index,
    globalvariables_add_,
    globalvariables_add_at_index,
    externalvariables_add_,
    externalvariables_add_at_index,
    parameters_add_,
    parameters_add_at_index,
    parametersettings_add_,
    parametersettings_add_at_index,
    cmconnections_add_,
    cmconnections_add_at_index,
    points_add_,
    points_add_at_index,
    cmparameters_add_,
    cmparameters_add_at_index,
    ilrows_add_,
    ilrows_add_at_index,
    sfcelements_add_sfcstep,
    sfcelements_add_sfctransition,
    sfcelements_add_sfcselection,
    sfcelements_add_sfcsimultaneous,
    sfcelements_add_sfcsubsequence,
    sfcelements_add_,
    sfcelements_add_at_index,
    codeblocks_add_,
	codeblocks_add_at_index,
	codeblocks_add_st,
	codeblocks_add_ld,
	codeblocks_add_fbd,
	codeblocks_add_il,
	codeblocks_add_sfc,
	codeblocks_add_fd,
}

by_name :: proc {
    datatype_component_by_name,
    components_component_by_name,
    variables_variable_by_name,
    graphnodes_graphnode_by_name,
    applicationvariables_global_by_name,
    applicationvariables_variable_by_name,
    applicationvariables_signal_by_name,
    signals_signal_by_name,
    globalvariables_global_by_name,
    externalvariables_external_by_name,
    parameters_external_by_name,
    parametersettings_parametersetting_by_name,
    cmconnections_cmconnection_by_name,
    cmparameters_cmparameter_by_name,
    codeblocks_codeblock_by_name,
}

by_index :: proc {
    datatype_component_by_index,
    components_component_by_index,
    variables_variable_by_index,
    graphnodes_graphnode_by_index,
    applicationvariables_global_by_index,
    applicationvariables_variable_by_index,
    applicationvariables_signal_by_index,
    signals_signal_by_index,
    globalvariables_global_by_index,
    externalvariables_external_by_index,
    parameters_external_by_index,
    parametersettings_parametersetting_by_index,
    cmconnections_cmconnection_by_index,
    points_point_by_index,
    cmparameters_cmparameter_by_index,
    ilrows_ilrow_by_index,
    sfcelements_sfcelement_by_index,
    codeblocks_codeblock_by_index,
}

index :: proc {
    datatype_component_index,
    components_component_index,
    variables_variable_index,
    graphnodes_graphnode_index,
    applicationvariables_global_index,
    applicationvariables_variable_index,
    applicationvariables_signal_index,
    signals_signal_index,
    globalvariables_global_index,
    externalvariables_external_index,
    parameters_external_index,
    parametersettings_parametersetting_index,
    cmconnections_cmconnection_index,
    cmparameters_cmparameter_index,
    codeblocks_codeblock_index,
}

count :: proc {
    datatype_component_count,
    components_count,
    variables_count,
    graphnodes_count,
    applicationvariables_global_count,
    applicationvariables_variable_count,
    applicationvariables_signal_count,
    signals_count,
    globalvariables_count,
    externalvariables_count,
    parameters_count,
    parametersettings_count,
    cmconnections_count,
    points_count,
    cmparameters_count,
    ilrows_count,
    sfcelements_count,
    codeblocks_count,
}

remove :: proc {
    datatype_component_remove_by_name,
    datatype_component_remove_by_index,
    variables_remove_by_name,
    variables_remove_by_index,
    components_remove_by_name,
    components_remove_by_index,
    applicationvariables_global_remove_by_name_,
    applicationvariables_global_remove_by_index_,
    applicationvariables_variable_remove_by_name_,
    applicationvariables_variable_remove_by_index_,
    applicationvariables_signal_remove_by_name_,
    applicationvariables_signal_remove_by_index_,
    graphnodes_remove_by_name,
    graphnodes_remove_by_index,
    signals_remove_by_name,
    signals_remove_by_index,
    globalvariables_remove_by_name,
    globalvariables_remove_by_index,
    externalvariables_remove_by_name,
    externalvariables_remove_by_index,
    parameters_remove_by_name,
    parameters_remove_by_index,
    parametersettings_remove_by_name,
    parametersettings_remove_by_index,
    cmconnections_remove_by_name,
    cmconnections_remove_by_index,
    points_remove_by_index,
    cmparameters_remove_by_name,
    cmparameters_remove_by_index,
    ilrows_remove,
    sfcelements_remove,
    codeblocks_remove,
}

release :: proc {
    datatype_release,
    components_release,
    component_release,
    variable_release,
    graphnodes_release,
    graphnode_release,
    signal_release,
    signals_release,
    globalvariables_release,
    globalvariable_release,
    applicationvariables_release,
    externalvariable_release,
    externalvariables_release,
    parameters_release,
    parameter_release,
    parametersettings_release,
    cmconnections_release,
    points_release,
    point_release,
    autopoint_release,
    graphpos_release,
    graphsize_release,
    cmparameters_release,
    cmparameter_release,
    icodeblock_release,
    fdcodeblock_release,
    ldcodeblock_release,
    fbdcodeblock_release,
    stcodeblock_release,
    ilrows_release,
    ilrow_release,
    sfctransition_release,
    sfcstep_release,
    sfcbranch_release,
    sfcsimultaneous_release,
    sfcbranches_release,
    sfcselection_release,
    sfcsubsequence_release,
    isfcelement_release,
    sfccodeblock_release,
    sfcelements_release,
    codeblocks_release,
}
