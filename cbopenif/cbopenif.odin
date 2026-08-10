package cbopenif

access_level :: proc {
    component_access_level_get,
    component_access_level_set,
    cmparameter_access_level_get,
    cmparameter_access_level_set,
    extensibleparameter_access_level_get,
    extensibleparameter_access_level_set,
    parameter_access_level_get,
    parameter_access_level_set,
    externalvariable_access_level_get,
    externalvariable_access_level_set,
    globalvariable_access_level_get,
    globalvariable_access_level_set,
    variable_access_level_get,
    variable_access_level_set,
    functionblock_access_level_get,
    functionblock_access_level_set,
    controlmodule_access_level_get,
    controlmodule_access_level_set,
    singlecontrolmoduleinst_access_level_get,
    singlecontrolmoduleinst_access_level_set,
    program_access_level_get,
    program_access_level_set,
    diagram_access_level_get,
    diagram_access_level_set,
    diagraminstance_access_level_get,
    diagraminstance_access_level_set,
}

actual_parameter :: proc {
    cmconnection_actual_parameter_get,
    cmconnection_actual_parameter_set,
}

acknowledge_group :: proc {
    signal_acknowledge_group_get,
    signal_acknowledge_group_set,
    commvariable_acknowledge_group_get,
    commvariable_acknowledge_group_set,
}

address :: proc {
    hwchannel_address_get,
    hwchannel_address_set,
}

alarm_owner :: proc {
    functionblocktype_alarm_owner_get,
    functionblocktype_alarm_owner_set,
    controlmoduletype_alarm_owner_get,
    controlmoduletype_alarm_owner_set,
    singlecontrolmoduletype_alarm_owner_get,
    singlecontrolmoduletype_alarm_owner_set,
    diagramtype_alarm_owner_get,
    diagramtype_alarm_owner_set,
}

application_type :: applicationproperties_application_type_get

aspect_object :: proc {
    functionblock_aspect_object_get,
    functionblock_aspect_object_set,
    controlmodule_aspect_object_get,
    controlmodule_aspect_object_set,
    diagraminstance_aspect_object_get,
    diagraminstance_aspect_object_set,
}

attribute :: proc {
    component_attribute_get,
    component_attribute_set,
    extensibleparameter_attribute_get,
    extensibleparameter_attribute_set,
    parameter_attribute_get,
    parameter_attribute_set,
    externalvariable_attribute_get,
    externalvariable_attribute_set,
    globalvariable_attribute_get,
    globalvariable_attribute_set,
    variable_attribute_get,
    variable_attribute_set,
    commvariable_attribute_get,
    commvariable_attribute_set,
}

authentication_level :: proc {
    component_authentication_level_get,
    component_authentication_level_set,
    cmparameter_authentication_level_get,
    cmparameter_authentication_level_set,
    parameter_authentication_level_get,
    parameter_authentication_level_set,
    externalvariable_authentication_level_get,
    externalvariable_authentication_level_set,
    globalvariable_authentication_level_get,
    globalvariable_authentication_level_set,
    variable_authentication_level_get,
    variable_authentication_level_set,
}

autopoint :: proc {
    cmparameter_auto_point_get,
    cmparameter_auto_point_set,
}

autopos :: proc {
    autopoint_autopos_get,
    autopoint_autopos_set,
}

batch_object :: proc {
    controlmoduletype_batch_object_get,
    controlmoduletype_batch_object_set,
    singlecontrolmoduletype_batch_object_get,
    singlecontrolmoduletype_batch_object_set,
    diagram_batch_object_get,
    diagram_batch_object_set,
    diagramtype_batch_object_get,
    diagramtype_batch_object_set,
}

batch_property :: proc {
    cmparameter_batch_property_get,
    cmparameter_batch_property_set,
    variable_batch_property_get,
    variable_batch_property_set,
}

cmconnection_add :: proc {
    cmconnections_cmconnection_add_,
    cmconnections_cmconnection_add_at_index,
}

cmconnection_by_name :: proc {
    cmconnections_cmconnection_by_name,
    cmconnections_cmconnection_by_index,
}

cmconnection_index :: cmconnections_cmconnection_index

cmconnection_count :: cmconnections_cmconnection_count

cmconnection_remove :: proc {
    cmconnections_cmconnection_remove_by_name,
    cmconnections_cmconnection_remove_by_index,
}

cmconnections :: proc {
    controlmodule_cmconnections_get,
    controlmodule_cmconnections_set,
    singlecontrolmoduleinst_cmconnections_get,
    singlecontrolmoduleinst_cmconnections_set,
}

cmgraphics :: proc {
    controlmoduletype_cmgraphics_get,
    controlmoduletype_cmgraphics_set,
    singlecontrolmoduletype_cmgraphics_get,
    singlecontrolmoduletype_cmgraphics_set,
}

cmparameter_add :: proc {
    cmparameters_cmparameter_add_,
    cmparameters_cmparameter_add_at_index,
}

cmparameter_by_name :: cmparameters_cmparameter_by_name

cmparameter_by_index :: cmparameters_cmparameter_by_index

cmparameter_index :: cmparameters_cmparameter_index

cmparameter_count :: cmparameters_cmparameter_count

cmparameter_remove :: proc {
    cmparameters_cmparameter_remove_by_name,
    cmparameters_cmparameter_remove_by_index,
}

cmparameters :: proc {
    controlmoduletype_cmparameters_get,
    controlmoduletype_cmparameters_set,
    singlecontrolmoduletype_cmparameters_get,
    singlecontrolmoduletype_cmparameters_set,
}

codeblock :: proc {
    codeblocks_codeblock_by_name,
    codeblocks_codeblock_by_index,
}

codeblock_add :: proc {
    //codeblocks_icodeblock_add,
    //codeblocks_icodeblock_add_at_index,
    codeblocks_stcodeblock_add,
    codeblocks_ldcodeblock_add,
    codeblocks_fbdcodeblock_add,
    codeblocks_ilcodeblock_add,
    codeblocks_sfccodeblock_add,
    codeblocks_fdcodeblock_add,
}

codeblock_index :: codeblocks_codeblock_index

codeblock_count :: codeblocks_codeblock_count

codeblock_remove :: codeblocks_codeblock_remove

codeblocks :: proc {
    functionblocktype_codeblocks_get,
    functionblocktype_codeblocks_set,
    controlmoduletype_codeblocks_get,
    controlmoduletype_codeblocks_set,
    singlecontrolmoduletype_codeblocks_get,
    singlecontrolmoduletype_codeblocks_set,
    program_codeblocks_get,
    program_codeblocks_set,
    diagram_codeblocks_get,
    diagram_codeblocks_set,
    diagramtype_codeblocks_get,
    diagramtype_codeblocks_set,
}

column :: proc {
    posinfo_column_get,
    posinfo_column_set,
}

component_add :: proc {
    components_component_add_,
    components_component_add_at_index,
    datatype_component_add_,
    datatype_component_add_at_index,
}

component_by_name :: proc {
    components_component_by_name,
    datatype_component_by_name,
}

component_by_index :: proc {
    components_component_by_index,
    datatype_component_by_index,
}

component_index :: proc {
    components_component_index,
    datatype_component_index,
}

component_count :: proc {
    components_component_count,
    datatype_component_count,
}

component_remove :: proc {
    components_component_remove_by_name,
    components_component_remove_by_index,
    datatype_component_remove_by_name,
    datatype_component_remove_by_index,
}

components :: proc {
    datatype_components_get,
    datatype_components_set,
}

commvariable_add :: proc {
    commvariables_commvariable_add_,
    commvariables_commvariable_add_at_index,
}

commvariable_by_name :: commvariables_commvariable_by_name

commvariable_by_index :: commvariables_commvariable_by_index

commvariable_index :: commvariables_commvariable_index

commvariable_count :: commvariables_commvariable_count

commvariable_remove :: proc {
    commvariables_remove_by_name,
    commvariables_remove_by_index
}

commvariables :: proc {
    singlecontrolmoduletype_commvariables_get,
    singlecontrolmoduletype_commvariables_set,
    program_commvariables_get,
    program_commvariables_set,
    diagram_commvariables_get,
    diagram_commvariables_set,
}

con_variable :: proc {
    hwchannel_con_variable_get,
    hwchannel_con_variable_set,
}

connectedapplication_add :: proc {
    connectedapplications_connectedapplication_add_,
    connectedapplications_connectedapplication_add_at_index,
}

connectedapplication_by_name :: connectedapplications_connectedapplication_by_name

connectedapplication_by_index :: connectedapplications_connectedapplication_by_index

connectedapplication_index :: connectedapplications_connectedapplication_index

connectedapplication_count :: connectedapplications_connectedapplication_count

connectedapplication_remove :: proc {
    connectedapplications_connectedapplication_remove_by_name,
    connectedapplications_connectedapplication_remove_by_index,
}

connectedhwlibrary_add :: proc {
    connectedhwlibraries_connectedhwlibrary_add_,
    connectedhwlibraries_connectedhwlibrary_add_at_index,
}

connectedhwlibrary_by_name :: connectedhwlibraries_connectedhwlibrary_by_name

connectedhwlibrary_by_index :: connectedhwlibraries_connectedhwlibrary_by_index

connectedhwlibrary_index :: connectedhwlibraries_connectedhwlibrary_index

connectedhwlibrary_count :: connectedhwlibraries_connectedhwlibrary_count

connectedhwlibrary_remove :: proc {
    connectedhwlibraries_connectedhwlibrary_remove_by_name,
    connectedhwlibraries_connectedhwlibrary_remove_by_index,
}


connectedlibrary_add :: proc {
    connectedlibraries_connectedlibrary_add_,
    connectedlibraries_connectedlibrary_add_at_index,
}

connectedlibrary_by_name :: connectedlibraries_connectedlibrary_by_name

connectedlibrary_by_index :: connectedlibraries_connectedlibrary_by_index

connectedlibrary_index :: connectedlibraries_connectedlibrary_index

connectedlibrary_count :: connectedlibraries_connectedlibrary_count

connectedlibrary_remove :: proc {
    connectedlibraries_connectedlibrary_remove_by_name,
    connectedlibraries_connectedlibrary_remove_by_index,
}

controlmodule_add :: proc {
    controlmodules_icontrolmodule_add,
    controlmodules_icontrolmodule_add_at_index,
    controlmodules_controlmodule_add_,
    controlmodules_singlecontrolmodule_add,
}

controlmodule_by_name :: proc {
    controlmodules_controlmodule_by_name,
}

controlmodule_by_index :: proc {
    controlmodules_controlmodule_by_index,
}

controlmodule_index :: controlmodules_controlmodule_index

controlmodule_count :: controlmodules_controlmodule_count

controlmodule_remove :: proc {
    controlmodules_controlmodule_remove_by_name,
    controlmodules_controlmodule_remove_by_index,
}

controlmodules :: proc {
    controlmoduletype_controlmodules_get,
    controlmoduletype_controlmodules_set,
    singlecontrolmoduletype_controlmodules_get,
    singlecontrolmoduletype_controlmodules_set,
    diagram_controlmodules_get,
    diagram_controlmodules_set,
    diagramtype_controlmodules_get,
    diagramtype_controlmodules_set,
}

diagraminstance_add :: proc {
    diagraminstances_diagraminstance_add_,
    diagraminstances_diagraminstance_add_at_index,
}

diagraminstance_by_name :: diagraminstances_diagraminstance_by_name

diagraminstance_by_index :: diagraminstances_diagraminstance_by_index

diagraminstance_index :: diagraminstances_diagraminstance_index

diagraminstance_count :: diagraminstances_diagraminstance_count

diagraminstance_remove :: proc {
    diagraminstances_diagraminstance_remove_by_name,
    diagraminstances_diagraminstance_remove_by_index,
}

diagraminstances :: proc {
    diagram_diagraminstances_get,
    diagram_diagraminstances_set,
    diagramtype_diagraminstances_get,
    diagramtype_diagraminstances_set,
}

direction :: proc {
    cmparameter_direction_get,
    cmparameter_direction_set,
    extensibleparameter_direction_get,
    extensibleparameter_direction_set,
    parameter_direction_get,
    parameter_direction_set,
    signal_direction_get,
    signal_direction_set,
    commvariable_direction_get,
    commvariable_direction_set,
}

description :: proc {
    component_description_get,
    component_description_set,
    ilrow_description_get,
    ilrow_description_set,
    cmparameter_description_get,
    cmparameter_description_set,
    extensibleparameter_description_get,
    extensibleparameter_description_set,
    parameter_description_get,
    parameter_description_set,
    parametersetting_description_get,
    signal_description_get,
    signal_description_set,
    datatype_description_get,
    datatype_description_set,
    applicationvariables_description_get,
    applicationvariables_description_set,
    externalvariable_description_get,
    externalvariable_description_set,
    globalvariable_description_get,
    globalvariable_description_set,
    variable_description_get,
    variable_description_set,
    functionblock_description_get,
    functionblock_description_set,
    functionblocktype_description_get,
    functionblocktype_description_set,
    controlmodule_description_get,
    controlmodule_description_set,
    controlmoduletype_description_get,
    controlmoduletype_description_set,
    singlecontrolmoduletype_description_get,
    singlecontrolmoduletype_description_set,
    singlecontrolmoduleinst_description_get,
    singlecontrolmoduleinst_description_set,
    commvariable_description_get,
    commvariable_description_set,
    hwunit_type_description_get,
    hwunit_type_description_set,
    hwchannel_io_description_get,
    hwchannel_io_description_set,
    program_description_get,
    program_description_set,
    diagram_description_get,
    diagram_description_set,
    diagramtype_description_get,
    diagramtype_description_set,
    diagraminstance_description_get,
    diagraminstance_description_set,
}

element_name :: proc {
    posinfo_element_name_get,
    posinfo_element_name_set,
}

end_position :: proc {
    posinfo_end_position_get,
    posinfo_end_position_set,
}

error_number :: proc {
    errormsg_error_number_get,
    errormsg_error_number_set,
}

extrainfo :: proc {
    errormsg_extra_info_get,
    errormsg_extra_info_set,
    infomsg_extra_info_get,
    infomsg_extra_info_set,
    warningmsg_extra_info_get,
    warningmsg_extra_info_set,
}

expected_sil :: proc {
    commvariable_expected_sil_get,
    commvariable_expected_sil_set,
}

expected_type :: proc {
    extrainfo_expected_type_get,
    extrainfo_expected_type_set,
}

extensibleparameter_add :: proc {
    extensibleparameters_extensibleparameter_add_,
    extensibleparameters_extensibleparameter_add_at_index,
}

extensibleparameter_remove :: proc {
    extensibleparameters_extensibleparameter_remove_by_name,
    extensibleparameters_extensibleparameter_remove_by_index,
}

extensibleparameter_by_name :: extensibleparameters_extensibleparameter_by_name

extensibleparameter_by_index :: extensibleparameters_extensibleparameter_by_index

extensibleparameter_index :: extensibleparameters_extensibleparameter_index

extensibleparameter_count :: extensibleparameters_extensibleparameter_count

extensibleparameters :: proc {
    functionblocktype_extensibleparameters_get,
    functionblocktype_extensibleparameters_set,
}

externalvariable_add :: proc {
    externalvariables_externalvariable_add_,
    externalvariables_externalvariable_add_at_index,
}

externalvariable_by_name :: externalvariables_externalvariable_by_name

externalvariable_by_index :: externalvariables_externalvariable_by_index

externalvariable_index :: externalvariables_externalvariable_index

externalvariable_count :: externalvariables_externalvariable_count

externalvariable_remove :: proc {
    externalvariables_externalvariable_remove_by_name,
    externalvariables_externalvariable_remove_by_index,
}

externalvariables :: proc {
    functionblocktype_externalvariables_get,
    functionblocktype_externalvariables_set,
    controlmoduletype_externalvariables_get,
    controlmoduletype_externalvariables_set,
    singlecontrolmoduletype_externalvariables_get,
    singlecontrolmoduletype_externalvariables_set,
}

expose_properties_in_parent :: proc {
    functionblock_expose_properties_in_parent_get,
    functionblock_expose_properties_in_parent_set,
    controlmodule_expose_properties_in_parent_get,
    controlmodule_expose_properties_in_parent_set,
    diagraminstance_expose_properties_in_parent_get,
    diagraminstance_expose_properties_in_parent_set,
}

executioninstance_add :: proc {
    executiongroup_executioninstance_add_,
    executiongroup_executioninstance_add_at_index,
}

executioninstance_by_name :: executiongroup_executioninstance_by_name

executioninstance_by_index :: executiongroup_executioninstance_by_index

executioninstance_index :: executiongroup_executioninstance_index

executioninstance_count :: executiongroup_count

executioninstance_remove :: proc {
    executiongroup_executioninstance_remove_by_name,
    executiongroup_executioninstance_remove_by_index,
}

executiongroup_add :: proc {
    executionorder_executiongroup_add_,
    executionorder_executiongroup_add_at_index,
}

executiongroup_by_name :: executionorder_executiongroup_by_task_name

executiongroup_by_index :: executionorder_executiongroup_by_index

executiongroup_index :: executionorder_executiongroup_index

executiongroup_count :: executionorder_executiongroup_count

executiongroup_remove :: proc {
    executionorder_executiongroup_remove_by_task_name,
    executionorder_executiongroup_remove_by_index,
}

fdport :: proc {
    cmparameter_fdport_get,
    cmparameter_fdport_set,
    extensibleparameter_fdport_get,
    extensibleparameter_fdport_set,
    parameter_fdport_get,
    parameter_fdport_set,
}

fou_name :: proc {
    posinfo_fou_name_get,
    posinfo_fou_name_set,
}

fraction :: proc {
    hwchannel_fraction_get,
    hwchannel_fraction_set,
}

function_name :: proc {
    extrainfo_function_name_get,
    extrainfo_function_name_set,
}

functionblocks :: proc {
    functionblocktype_functionblocks_get,
    functionblocktype_functionblocks_set,
    controlmoduletype_functionblocks_get,
    controlmoduletype_functionblocks_set,
    singlecontrolmoduletype_functionblocks_get,
    singlecontrolmoduletype_functionblocks_set,
    program_functionblocks_get,
    program_functionblocks_set,
    diagram_functionblocks_get,
    diagram_functionblocks_set,
    diagramtype_functionblocks_get,
    diagramtype_functionblocks_set,
}

globalvariable_add :: proc {
    globalvariables_globalvariable_add_,
    globalvariables_globalvariable_add_at_index,
}

globalvariable_by_name :: globalvariables_globalvariable_by_name

globalvariable_by_index :: globalvariables_globalvariable_by_index

globalvariable_index :: globalvariables_globalvariable_index

globalvariable_count :: globalvariables_globalvariable_count

globalvariable_globalvariable_remove :: proc {
    globalvariables_globalvariable_remove_by_name,
    globalvariables_globalvariable_remove_by_index,
}

globalvariables :: proc {
    applicationvariables_globals_get,
    applicationvariables_globals_set,
}

graphnode_add :: proc {
    graphnodes_graphnode_add_,
    graphnodes_graphnode_add_at_index,
}

graphnode_by_name :: graphnodes_graphnode_by_name

graphnode_by_index :: graphnodes_graphnode_by_index

graphnode_index :: graphnodes_graphnode_index

graphnode_count :: graphnodes_graphnode_count

graphnode_remove :: proc {
    graphnodes_graphnode_remove_by_name,
    graphnodes_graphnode_remove_by_index,
}

graphnodes :: proc {
    cmparameter_graph_nodes_get,
    cmparameter_graph_nodes_set,
    externalvariable_graph_nodes_get,
    externalvariable_graph_nodes_set,
    globalvariable_graph_nodes_get,
    globalvariable_graph_nodes_set,
    variable_graph_nodes_get,
    variable_graph_nodes_set,
}

graphsize :: proc {
    controlmoduletype_graphsize_get,
    controlmoduletype_graphsize_set,
    singlecontrolmoduletype_graphsize_get,
    singlecontrolmoduletype_graphsize_set,
}

graphpos :: proc {
    singlecontrolmoduleinst_graphpos_get,
    singlecontrolmoduleinst_graphpos_set,
    controlmodule_graphpos_get,
    controlmodule_graphpos_set,
}

graphical_connection :: proc {
    cmconnection_graphical_connection_get,
    cmconnection_graphical_connection_set,
}

guid :: proc {
    task_guid_get,
    task_guid_set,
    datatype_guid_get,
    datatype_guid_set,
    functionblock_guid_get,
    functionblock_guid_set,
    functionblocktype_guid_get,
    functionblocktype_guid_set,
    controlmodule_guid_get,
    controlmodule_guid_set,
    controlmoduletype_guid_get,
    controlmoduletype_guid_set,
    hwunit_guid_get,
    hwunit_guid_set,
    diagramtype_guid_get,
    diagramtype_guid_set,
    diagraminstance_guid_get,
    diagraminstance_guid_set,
}

hidden :: proc {
    datatype_hidden_get,
    datatype_hidden_set,
    functionblocktype_hidden_get,
    functionblocktype_hidden_set,
    controlmoduletype_hidden_get,
    controlmoduletype_hidden_set,
    diagramtype_hidden_get,
    diagramtype_hidden_set,
}

hw_simulation :: proc {
    hwunit_hw_simulation_get,
    hwunit_hw_simulation_set,
}

hw_simulation_supported :: proc {
    hwunit_hw_simulation_supported_get,
    hwunit_hw_simulation_supported_set,
}

hwchannel_add :: proc {
    hwchannels_hwchannel_add_,
    hwchannels_hwchannel_add_at_index,
}

hwchannel_by_address :: hwchannels_hwchannel_by_address

hwchannel_by_index :: hwchannels_hwchannel_by_index

hwchannel_index :: hwchannels_hwchannel_index

hwchannel_count :: hwchannels_hwchannel_count

hwchannel_remove :: proc {
    hwchannels_hwchannel_remove_by_address,
    hwchannels_hwchannel_remove_by_index,
}

hwchannels :: proc {
    hwunit_hwchannels_get,
    hwunit_hwchannels_set,
}

hwunit_add :: proc {
    hwunits_hwunit_add_,
    hwunits_hwunit_add_at_index,
}

hwunit_by_path :: hwunits_hwunit_by_path

hwunit_by_index :: hwunits_hwunit_by_index

hwunit_index :: hwunits_hwunit_index

hwunit_vount :: hwunits_hwunit_count

hwunit_remove :: proc {
    hwunits_hwunit_remove_by_path,
    hwunits_hwunit_remove_by_index,
}

hwunits :: proc {
    hwunit_hwunits_get,
    hwunit_hwunits_set,
}

id :: proc {
    posinfo_id_get,
    posinfo_id_set,
}

initvalue_add :: proc {
    initvalues_initvalue_add_,
    initvalues_initvalue_add_at_index,
}

initvalue_by_name :: initvalues_initvalue_by_name

initvalue_by_index :: initvalues_initvalue_by_index

initvalue_index :: initvalues_initvalue_index

initvalue_count :: initvalues_initvalue_count

initvalue_remove :: proc {
    initvalues_initvalue_remove_by_name,
    initvalues_initvalue_remove_by_index,
}

initvalues :: proc {
    singlecontrolmoduletype_initvalues_get,
    singlecontrolmoduletype_initvalues_set,
    program_initvalues_get,
    program_initvalues_set,
    diagram_initvalues_get,
    diagram_initvalues_set,
}

initial_value :: proc {
    component_initial_value_get,
    component_initial_value_set,
    cmparameter_initial_value_get,
    cmparameter_initial_value_set,
    extensibleparameter_initial_value_get,
    extensibleparameter_initial_value_set,
    parameter_initial_value_get,
    parameter_initial_value_set,
    globalvariable_initial_value_get,
    globalvariable_initial_value_set,
    variable_initial_value_get,
    variable_initial_value_set,
    commvariable_initial_value_get,
    commvariable_initial_value_set,
}

inst_guid :: proc {
    singlecontrolmoduleinst_inst_guid_get,
    singlecontrolmoduleinst_inst_guid_set,
    program_inst_guid_get,
    program_inst_guid_set,
    diagram_inst_guid_get,
    diagram_inst_guid_set,
}

interaction_window :: proc {
    functionblocktype_interaction_window_get,
    functionblocktype_interaction_window_set,
    controlmoduletype_interaction_window_get,
    controlmoduletype_interaction_window_set,
    singlecontrolmoduletype_interaction_window_get,
    singlecontrolmoduletype_interaction_window_set,
}

interval_time :: proc {
    task_interval_time_get,
    task_interval_time_set,
    commvariable_interval_time_get,
    commvariable_interval_time_set,
}

instantiate_as_aspect_object :: proc {
    functionblocktype_instantiate_as_aspect_object_get,
    functionblocktype_instantiate_as_aspect_object_set,
    controlmoduletype_instantiate_as_aspect_object_get,
    controlmoduletype_instantiate_as_aspect_object_set,
    diagramtype_instantiate_as_aspect_object_get,
    diagramtype_instantiate_as_aspect_object_set,
}

instance_graphics :: proc {
    controlmodule_instance_graphics_get,
    controlmodule_instance_graphics_set,
    singlecontrolmoduleinst_instance_graphics_get,
    singlecontrolmoduleinst_instance_graphics_set,
}

instance_name :: proc {
    hwunit_instance_name_get,
    hwunit_instance_name_set,
}

ilrow_add :: proc {
    ilrows_ilrow_add_,
    ilrows_ilrow_add_at_index,
}

ilrow_by_index :: ilrows_ilrow_by_index

ilrow_count :: ilrows_ilrow_count

ilrow_remove :: ilrows_ilrow_remove

ilrows :: proc {
    ilcodeblock_ilrows_get,
    ilcodeblock_ilrows_set,
}

ipaddress :: proc {
    commvariable_ipaddress_get,
    commvariable_ipaddress_set,
}

isp_value :: proc {
    component_isp_value_get,
    component_isp_value_set,
    commvariable_isp_value_get,
    commvariable_isp_value_set,
}

jump_destination :: proc {
    extrainfo_jump_destination_get,
    extrainfo_jump_destination_set,
}

latency_supervision :: proc {
    task_latency_supervision_get,
    task_latency_supervision_set,
}

latency_percentage :: proc {
    task_latency_percentage_get,
    task_latency_percentage_set,
}

major_version :: proc {
    connectedapplication_major_version_get,
    connectedapplication_major_version_set,
    connectedlibrary_major_version_get,
    connectedlibrary_major_version_set,
    connectedhwlibrary_major_version_get,
    connectedhwlibrary_major_version_set,
}

max :: proc {
    hwchannel_max_get,
    hwchannel_max_set,
}

message :: proc {
    errormsg_message_get,
    errormsg_message_set,
    findmsg_message_get,
    findmsg_message_set,
    infomsg_message_get,
    infomsg_message_set,
    imessage_get,
    imessage_set,
    warningmsg_message_get,
    warningmsg_message_set,
}

minor_version :: proc {
    connectedapplication_minor_version_get,
    connectedapplication_minor_version_set,
    connectedlibrary_minor_version_get,
    connectedlibrary_minor_version_set,
    connectedhwlibrary_minor_version_get,
    connectedhwlibrary_minor_version_set,
}

message_add :: messagebucket_message_add

message_by_index :: messagebucket_message_by_index

message_count :: messagebucket_message_count

message_remove :: messagebucket_message_remove_by_index

message_type :: proc {
    posinfo_message_type_get,
    posinfo_message_type_set,
}

min :: proc {
    hwchannel_min_get,
    hwchannel_min_set,
}

name :: proc {
    //icodeblock_name_get,
    //icodeblock_name_set,
    fbdcodeblock_name_get,
    fbdcodeblock_name_set,
    fdcodeblock_name_get,
    fdcodeblock_name_set,
    ilcodeblock_name_get,
    ilcodeblock_name_set,
    ldcodeblock_name_get,
    ldcodeblock_name_set,
    sfccodeblock_name_get,
    sfccodeblock_name_set,
    stcodeblock_name_get,
    stcodeblock_name_set,
    component_name_get,
    component_name_set,
    cmconnection_name_get,
    cmconnection_name_set,
    graphnode_name_get,
    graphnode_name_set,
    initvalue_name_get,
    initvalue_name_set,
    cmparameter_name_get,
    cmparameter_name_set,
    extensibleparameter_name_get,
    extensibleparameter_name_set,
    parameter_name_get,
    parameter_name_set,
    parametersetting_name_get,
    parametersetting_name_set,
    projectconstant_name_get,
    projectconstant_name_set,
    sfcstep_name_get,
    sfcstep_name_set,
    sfcsubsequence_name_get,
    sfcsubsequence_name_set,
    sfctransition_name_get,
    sfctransition_name_set,
    signal_name_get,
    signal_name_set,
    task_name_get,
    task_name_set,
    datatype_name_get,
    datatype_name_set,
    externalvariable_name_get,
    externalvariable_name_set,
    globalvariable_name_get,
    globalvariable_name_set,
    variable_name_get,
    variable_name_set,
    functionblock_name_get,
    functionblock_name_set,
    functionblocktype_name_get,
    functionblocktype_name_set,
    controlmodule_type_name_get,
    controlmodule_type_name_set,
    controlmoduletype_name_get,
    controlmoduletype_name_set,
    singlecontrolmoduletype_name_get,
    singlecontrolmoduletype_name_set,
    singlecontrolmoduleinst_name_get,
    singlecontrolmoduleinst_name_set,
    icontrolmodule_name_get,
    icontrolmodule_name_set,
    commvariable_name_get,
    commvariable_name_set,
    hwchannel_name_get,
    hwchannel_name_set,
    connectedapplication_name_get,
    connectedapplication_name_set,
    connectedlibrary_name_get,
    connectedlibrary_name_set,
    connectedhwlibrary_name_get,
    connectedhwlibrary_name_set,
    executioninstance_name_get,
    executioninstance_name_set,
    executiongroup_task_name_get,
    executiongroup_task_name_set,
    ivaprotocol_name_get,
    ivaprotocol_name_set,
    vaaddressedprotocol_name_get,
    vaaddressedprotocol_name_set,
    vaaddressedvariable_name_get,
    vaaddressedvariable_name_set,
    vanamedprotocol_name_get,
    vanamedprotocol_name_set,
    vanamedvariable_name_get,
    vanamedvariable_name_set,
    program_name_get,
    program_name_set,
    diagram_name_get,
    diagram_name_set,
    diagramtype_name_get,
    diagramtype_name_set,
    diagraminstance_name_get,
    diagraminstance_name_set,
}

number_of_errors :: proc {
    messagebucket_number_of_errors_get,
    messagebucket_number_of_errors_set,
}

number_of_warnings :: proc {
    messagebucket_number_of_warnings_get,
    messagebucket_number_of_warnings_set,
}

offset :: proc {
    task_offset_get,
    task_offset_set,
}

output_update :: proc {
    task_output_update_get,
    task_output_update_set,
}

page_number :: proc {
    posinfo_page_number_get,
    posinfo_page_number_set,
}

parameter_add :: proc {
    parameters_parameter_add_,
    parameters_parameter_add_at_index,
}

parameter_by_name :: parameters_parameter_by_name

parameter_by_index :: parameters_parameter_by_index

parameter_index :: parameters_parameter_index

parameter_count :: parameters_parameter_count

parameter_remove :: proc {
    parameters_parameter_remove_by_name,
    parameters_parameter_remove_by_index,
}

parameters :: proc {
    functionblocktype_parameters_get,
    functionblocktype_parameters_set,
    diagramtype_parameters_get,
    diagramtype_parameters_set,
}

parametersetting_add :: proc {
    parametersettings_parametersetting_add_,
    parametersettings_parametersetting_add_at_index,
}

parametersetting_by_name :: parametersettings_parametersetting_by_name

parametersetting_by_index :: parametersettings_parametersetting_by_index

parametersetting_index :: parametersettings_parametersetting_index

parametersetting_count :: parametersettings_parametersetting_count

parametersetting_remove :: proc {
    parametersettings_parametersetting_remove_by_name,
    parametersettings_parametersetting_remove_by_index,
}

parametersetting_value :: proc {
    parametersetting_parameter_value_get,
    parametersetting_parameter_value_set,
}

parametersettings :: proc {
    hwunit_parametersettings_get,
    hwunit_parametersettings_set,
}

path :: proc {
    signal_path_get,
    signal_path_set,
    hwunit_path_get,
    hwunit_path_set,
    vaaddressedvariable_path_get,
    vaaddressedvariable_path_set,
    vanamedvariable_path_get,
    vanamedvariable_path_set,
}

point :: proc {
    points_point_by_index,
}

point_lower_left :: proc {
    graphsize_lower_left_get,
    graphsize_lower_left_set,
}

point_upper_right :: proc {
    graphsize_upper_right_get,
    graphsize_upper_right_set,
}

point_add :: proc {
    points_point_add_,
    points_point_add_at_index,
}

point_count :: points_point_count

point_remove :: points_point_remove_by_index

points :: proc {
    cmconnection_points_get,
    cmconnection_points_set,
}

posinfo :: proc {
    errormsg_posinfo_get,
    errormsg_posinfo_set,
    findmsg_posinfo_get,
    findmsg_posinfo_set,
    infomsg_posinfo_get,
    infomsg_posinfo_set,
    warningmsg_posinfo_get,
    warningmsg_posinfo_set,
}

pou_name :: proc {
    posinfo_pou_name_get,
    posinfo_pou_name_set,
}

pou_path :: proc {
    initvalue_pou_path_get,
    initvalue_pou_path_set,
}

priority :: proc {
    sfcbranch_priority_get,
    sfcbranch_priority_set,
    task_priority_get,
    task_priority_set,
    commvariable_priority_get,
    commvariable_priority_set,
}

projectconstant_by_name :: projectconstants_projectconstant_by_name

projectconstant_by_index :: projectconstants_projectconstant_by_index

projectconstant_index :: projectconstants_projectconstant_index

projectconstant_count :: projectconstants_projectconstant_count

projectconstant_remove :: proc {
    projectconstants_projectconstant_remove_by_name,
    projectconstants_projectconstant_remove_by_index,
}

protected :: proc {
    datatype_protected_get,
    datatype_protected_set,
    functionblocktype_protected_get,
    functionblocktype_protected_set,
    controlmoduletype_protected_get,
    controlmoduletype_protected_set,
    diagramtype_protected_get,
    diagramtype_protected_set,
}

read_permission :: proc {
    component_read_permission_get,
    component_read_permission_set,
    cmparameter_read_permission_get,
    cmparameter_read_permission_set,
    parameter_read_permission_get,
    parameter_read_permission_set,
    externalvariable_read_permission_get,
    externalvariable_read_permission_set,
    globalvariable_read_permission_get,
    globalvariable_read_permission_set,
    variable_read_permission_get,
    variable_read_permission_set,
    commvariable_read_permission_get,
    commvariable_read_permission_set,
}

redundant_pos :: proc {
    hwunit_redundant_pos_get,
    hwunit_redundant_pos_set,
}

release :: proc {
    icodeblock_release,
    codeblocks_release,
    fbdcodeblock_release,
    fdcodeblock_release,
    ilcodeblock_release,
    ldcodeblock_release,
    sfccodeblock_release,
    stcodeblock_release,
    component_release,
    components_release,
    cmconnection_release,
    cmconnections_release,
    graphnode_release,
    graphnodes_release,
    graphpos_release,
    graphsize_release,
    ilrow_release,
    ilrows_release,
    initvalue_release,
    initvalues_release,
    errormsg_release,
    extrainfo_release,
    findmsg_release,
    infomsg_release,
    messagebucket_release,
    imessage_release,
    posinfo_release,
    warningmsg_release,
    cmparameter_release,
    cmparameters_release,
    extensibleparameter_release,
    extensibleparameters_release,
    parameter_release,
    parameters_release,
    parametersetting_release,
    parametersettings_release,
    autopoint_release,
    point_release,
    points_release,
    projectconstant_release,
    sfcbranch_release,
    sfcbranches_release,
    sfcelement_release,
    sfcelements_release,
    sfcselection_release,
    sfcsimultaneous_release,
    sfcstep_release,
    sfcsubsequence_release,
    sfctransition_release,
    signal_release,
    signals_release,
    task_release,
    datatype_release,
    applicationvariables_release,
    externalvariable_release,
    externalvariables_release,
    globalvariable_release,
    globalvariables_release,
    variable_release,
    variables_release,
    functionblock_release,
    functionblocks_release,
    functionblocktype_release,
    controlmodule_release,
    controlmoduletype_release,
    singlecontrolmoduletype_release,
    controlmodules_release,
    singlecontrolmoduleinst_release,
    commvariable_release,
    commvariables_release,
    hwunits_release,
    hwchannels_release,
    hwunit_release,
    hwchannel_release,
    connectedapplication_release,
    connectedapplications_release,
    connectedlibrary_release,
    connectedlibraries_release,
    connectedhwlibrary_release,
    connectedhwlibraries_release,
    executioninstance_release,
    executionorder_release,
    executiongroup_release,
    accessvariables_release,
    ivaprotocol_release,
    vaprotocols_release,
    vanamedprotocol_release,
    vaaddressedprotocol_release,
    vanamedvariable_release,
    vaaddressedvariable_release,
    applicationproperties_release,
    program_release,
    diagram_release,
    diagramtype_release,
    diagraminstance_release,
    diagraminstances_release,
}

reserved_by_function :: proc {
    datatype_reserved_by_function_get,
    datatype_reserved_by_function_set,
    functionblocktype_reserved_by_function_get,
    functionblocktype_reserved_by_function_set,
    controlmoduletype_reserved_by_function_get,
    controlmoduletype_reserved_by_function_set,
    singlecontrolmoduletype_reserved_by_function_get,
    singlecontrolmoduletype_reserved_by_function_set,
    hwunit_reserved_by_function_get,
    hwunit_reserved_by_function_set,
    program_reserved_by_function_get,
    program_reserved_by_function_set,
    diagram_reserved_by_function_get,
    diagram_reserved_by_function_set,
    diagramtype_reserved_by_function_get,
    diagramtype_reserved_by_function_set,
}

restricted_sil :: proc {
    functionblocktype_restricted_sil_get,
    functionblocktype_restricted_sil_set,
    controlmoduletype_restricted_sil_get,
    controlmoduletype_restricted_sil_set,
    singlecontrolmoduletype_restricted_sil_get,
    singlecontrolmoduletype_restricted_sil_set,
    commvariable_restricted_sil_get,
    commvariable_restricted_sil_set,
    diagram_restricted_sil_get,
    diagram_restricted_sil_set,
    diagramtype_restricted_sil_get,
    diagramtype_restricted_sil_set,
}

reversed :: proc {
    hwchannel_reversed_get,
    hwchannel_reversed_set,
}

revision :: proc {
    connectedapplication_revision_get,
    connectedapplication_revision_set,
    connectedlibrary_revision_get,
    connectedlibrary_revision_set,
    connectedhwlibrary_revision_get,
    connectedhwlibrary_revision_set,
}

rotation :: proc {
    graphpos_rotation_get,
    graphpos_rotation_set,
}

row :: proc {
    posinfo_row_get,
    posinfo_row_set,
    vaaddressedvariable_row_get,
    vaaddressedvariable_row_set,
    vanamedvariable_row_get,
    vanamedvariable_row_set,
}

safety_type :: proc {
    component_safety_type_get,
    component_safety_type_set,
    cmparameter_safety_type_get,
    cmparameter_safety_type_set,
    extensibleparameter_safety_type_get,
    extensibleparameter_safety_type_set,
    parameter_safety_type_get,
    parameter_safety_type_set,
    externalvariable_safety_type_get,
    externalvariable_safety_type_set,
    globalvariable_safety_type_get,
    globalvariable_safety_type_set,
    variable_safety_type_get,
    variable_safety_type_set,
    functionblock_safety_type_get,
    functionblock_safety_type_set,
    controlmodule_safety_type_get,
    controlmodule_safety_type_set,
    singlecontrolmoduleinst_safety_type_get,
    singlecontrolmoduleinst_safety_type_set,
    program_safety_type_get,
    program_safety_type_set,
    diagram_safety_type_get,
    diagram_safety_type_set,
    diagraminstance_safety_type_get,
    diagraminstance_safety_type_set,
}

scope :: proc {
    datatype_scope_get,
    datatype_scope_set,
    functionblocktype_scope_get,
    functionblocktype_scope_set,
    controlmoduletype_scope_get,
    controlmoduletype_scope_set,
    diagramtype_scope_get,
    diagramtype_scope_set,
}

serialize :: proc {
    fbdcodeblock_serialize,
    fdcodeblock_serialize,
    ilcodeblock_serialize,
    ldcodeblock_serialize,
    sfccodeblock_serialize,
    stcodeblock_serialize,
    cmconnection_serialize,
    initvalue_serialize,
    messagebucket_serialize,
    cmparameter_serialize,
    extensibleparameter_serialize,
    parameter_serialize,
    projectconstants_serialize,
    signal_serialize,
    task_serialize,
    datatype_serialize,
    applicationvariables_serialize,
    externalvariable_serialize,
    globalvariable_serialize,
    variable_serialize,
    functionblock_serialize,
    functionblocktype_serialize,
    controlmodule_serialize,
    controlmoduletype_serialize,
    singlecontrolmoduletype_serialize,
    controlmodules_serialize,
    singlecontrolmoduleinst_serialize,
    commvariable_serialize,
    hwunit_serialize,
    connectedhwlibraries_serialize,
    connectedlibraries_serialize,
    connectedapplications_serialize,
    accessvariables_serialize,
    applicationproperties_serialize,
    program_serialize,
    diagram_serialize,
    diagramtype_serialize,
    diagraminstance_serialize,
}

simulation_mark :: proc {
    functionblocktype_simulation_mark_get,
    functionblocktype_simulation_mark_set,
    controlmoduletype_simulation_mark_get,
    controlmoduletype_simulation_mark_set,
    singlecontrolmoduletype_simulation_mark_get,
    singlecontrolmoduletype_simulation_mark_set,
    applicationproperties_simulation_mark_get,
    applicationproperties_simulation_mark_set,
    program_simulation_mark_get,
    program_simulation_mark_set,
    diagram_simulation_mark_get,
    diagram_simulation_mark_set,
    diagramtype_simulation_mark_get,
    diagramtype_simulation_mark_set,
}

start_position :: proc {
    posinfo_start_position_get,
    posinfo_start_position_set,
}

sil_level :: proc {
    task_sil_level_get,
    task_sil_level_set,
    functionblocktype_sil_level_get,
    functionblocktype_sil_level_set,
    controlmoduletype_sil_level_get,
    controlmoduletype_sil_level_set,
    singlecontrolmoduletype_sil_level_get,
    singlecontrolmoduletype_sil_level_set,
    applicationproperties_sil_level_get,
    applicationproperties_sil_level_set,
    program_sil_level_get,
    program_sil_level_set,
    diagram_sil_level_get,
    diagram_sil_level_set,
    diagramtype_sil_level_get,
    diagramtype_sil_level_set,
}


stcode :: proc {
    fbdcodeblock_stcode_get,
    fbdcodeblock_stcode_set,
    ldcodeblock_stcode_get,
    ldcodeblock_stcode_set,
    stcodeblock_stcode_get,
    stcodeblock_stcode_set,
    sfctransition_stcode_get,
    sfctransition_stcode_set,
}

sfcbrach_add :: proc {
    sfcbranches_sfcbranch_add_,
    sfcbranches_sfcbranch_add_at_index,
}

sfcbrach_by_index :: sfcbranches_sfcbranch_by_index

sfcbrach_count :: sfcbranches_sfcbranch_count

sfcbrach_remove :: sfcbranches_sfcbranch_remove_by_index

sfcbranches :: proc {
    sfcselection_branches_get,
    sfcselection_branches_set,
    sfcsimultaneous_branches_get,
    sfcsimultaneous_branches_set,
}

sfcelement_add :: proc {
    sfcelements_sfcstep_add,
    sfcelements_sfctransition_add,
    sfcelements_sfcselection_add,
    sfcelements_sfcsimultaneous_add,
    sfcelements_sfcsubsequence_add,
    sfcelements_sfcelement_add,
    sfcelements_sfcelement_add_at_index,
}

sfcelement_by_index :: sfcelements_sfcelement_by_index

sfcelement_count :: sfcelements_sfcelement_count

sfcelement_remove :: sfcelements_sfcelement_remove

sfcelements :: proc {
    sfccodeblock_elements_get,
    sfccodeblock_elements_set,
    sfcbranch_elements_get,
    sfcbranch_elements_set,
    sfcsubsequence_elements_get,
    sfcsubsequence_elements_set,
}

signal_add :: proc {
    signals_signal_add_,
    signals_signal_add_at_index,
}

signal_by_name :: signals_signal_by_name

signal_by_index :: signals_signal_by_index

signal_index :: signals_signal_index

signal_count :: signals_signal_count

signal_remove :: proc {
    signals_signal_remove_by_name,
    signals_signal_remove_by_index,
}

signals :: proc {
    applicationvariables_signals_get,
    applicationvariables_signals_set,
    singlecontrolmoduletype_signals_get,
    singlecontrolmoduletype_signals_set,
    program_signals_get,
    program_signals_set,
    diagram_signals_get,
    diagram_signals_set,
}

tab_name :: proc {
    posinfo_tab_name_get,
    posinfo_tab_name_set,
}

task_connection :: proc {
    functionblock_task_connection_get,
    functionblock_task_connection_set,
    controlmodule_task_connection_get,
    controlmodule_task_connection_set,
    singlecontrolmoduleinst_task_connection_get,
    singlecontrolmoduleinst_task_connection_set,
    program_task_connection_get,
    program_task_connection_set,
    diagram_task_connection_get,
    diagram_task_connection_set,
}

traverse_number :: proc {
    extrainfo_traverse_number_get,
    extrainfo_traverse_number_set,
}

type_guid :: proc {
    component_type_guid_get,
    cmparameter_type_guid_get,
    extensibleparameter_type_guid_get,
    parameter_type_guid_get,
    externalvariable_type_guid_get,
    globalvariable_type_guid_get,
    variable_type_guid_get,
    functionblock_type_guid_get,
    controlmodule_type_guid_get,
    singlecontrolmoduletype_type_guid_get,
    singlecontrolmoduletype_type_guid_set,
    singlecontrolmoduleinst_type_guid_get,
    singlecontrolmoduleinst_type_guid_set,
    commvariable_type_guid_get,
    hwunit_type_guid_get,
    hwunit_type_guid_set,
    program_type_guid_get,
    program_type_guid_set,
    diagram_type_guid_get,
    diagram_type_guid_set,
    diagraminstance_type_guid_get,
}

type_id :: proc {
    hwunit_type_id_get,
    hwunit_type_id_set,
}

type_path :: proc {
    component_type_path_get,
    cmparameter_type_path_get,
    extensibleparameter_type_path_get,
    parameter_type_path_get,
    externalvariable_type_path_get,
    globalvariable_type_path_get,
    variable_type_path_get,
    functionblock_type_path_get,
    controlmodule_type_path_get,
    commvariable_type_path_get,
    diagraminstance_type_path_get
}

type_name :: proc {
    component_type_name_get,
    component_type_name_set,
    cmparameter_type_name_get,
    cmparameter_type_name_set,
    extensibleparameter_type_name_get,
    extensibleparameter_type_name_set,
    parameter_type_name_get,
    parameter_type_name_set,
    externalvariable_type_name_get,
    externalvariable_type_name_set,
    globalvariable_type_name_get,
    globalvariable_type_name_set,
    variable_type_name_get,
    variable_type_name_set,
    functionblock_type_name_get,
    functionblock_type_name_set,
    commvariable_type_name_get,
    commvariable_type_name_set,
    diagraminstance_type_name_get,
    diagraminstance_type_name_set,
}

unit :: proc {
    hwchannel_unit_get,
    hwchannel_unit_set,
}

unique_id :: proc {
    commvariable_unique_id_get,
    commvariable_unique_id_set,
}

va_attribute :: proc {
    vanamedvariable_va_attribute_get,
    vanamedvariable_va_attribute_set,
}

va_type :: proc {
    vaaddressedvariable_va_type_get,
    vaaddressedvariable_va_type_set,
    vanamedvariable_va_type_get,
    vanamedvariable_va_type_set,
}

va_type_path :: proc {
    vaaddressedvariable_va_type_path_get,
    vanamedvariable_va_type_path_get,
}

vaaddressedvariable_add :: proc {
    vaaddressedprotocol_vaaddressedvariable_add_,
    vaaddressedprotocol_vaaddressedvariable_add_at_index,
}

vaaddressedvariable_by_name :: vaaddressedprotocol_vaaddressedvariable_by_name

vaaddressedvariable_by_index :: vaaddressedprotocol_vaaddressedvariable_by_index

vaaddressedvariable_index :: vaaddressedprotocol_vaaddressedvariable_index

vaaddressedvariable_count :: vaaddressedprotocol_vaaddressedvariable_count

vaaddressedvariable_remove :: proc {
    vaaddressedprotocol_vaaddressedvariable_remove_by_name,
    vaaddressedprotocol_vaaddressedvariable_remove_by_index,
}

vanammedvariable_add :: proc {
    vanamedprotocol_vanammedvariable_add_,
    vanamedprotocol_vanammedvariable_add_at_index,
}

vanamedvariable_by_name :: vanamedprotocol_vanamedvariable_by_name

vanamedvariable_by_index :: vanamedprotocol_vanamedvariable_by_index

vanamedvariable_index :: vanamedprotocol_vanamedvariable_index

vanamedvariable_count :: vanamedprotocol_vanamedvariable_count

vanamedvariable_remove :: proc {
    vanamedprotocol_vanamedvariable_remove_by_name,
    vanamedprotocol_vanamedvariable_remove_by_index,
}

vaprotocol_add :: proc {
    vaprotocols_vanammedprotocol_add,
    vaprotocols_vaaddressedprotocol_add,
    vaprotocols_ivaprotocol_add,
    vaprotocols_ivaprotocol_add_at_index,
}

vaprotocol_by_name :: vaprotocols_vaprotocol_by_name

vaprotocol_by_index :: vaprotocols_vaprotocol_by_index

vaprotocol_index :: vaprotocols_vaprotocol_index

vaprotocol_count :: vaprotocols_vaprotocol_count

vaprotocol_remove :: proc {
    vaprotocols_vaprotocol_remove_by_name,
    vaprotocols_vaprotocol_remove_by_index,
}

vaprotocols :: proc {
    accessvariables_vaprotocols_get,
    accessvariables_vaprotocols_set,
}

var_name :: proc {
    extrainfo_var_name_get,
    extrainfo_var_name_set,
}

variable_add :: proc {
    variables_variable_add_,
    variables_variable_add_at_index,
}

variable_by_name :: variables_variable_by_name

variable_by_index :: variables_variable_by_index

variable_index :: variables_variable_index

variable_count :: variables_variable_count

variable_remove :: proc {
    variables_variable_remove_by_name,
    variables_variable_remove_by_index,
}

variables :: proc {
    applicationvariables_variables_get,
    applicationvariables_variables_set,
    functionblocktype_variables_get,
    functionblocktype_variables_set,
    controlmoduletype_variables_get,
    controlmoduletype_variables_set,
    singlecontrolmoduletype_variables_get,
    singlecontrolmoduletype_variables_set,
    program_variables_get,
    program_variables_set,
    diagram_variables_get,
    diagram_variables_set,
    diagramtype_variables_get,
    diagramtype_variables_set,
}

visibility_In_graphics :: proc {
    functionblocktype_embedded_graphiscs_visible_get,
    functionblocktype_embedded_graphiscs_visible_set,
    controlmodule_visibility_in_graphics_get,
    controlmodule_visibility_in_graphics_set,
    controlmoduletype_embedded_graphiscs_visible_get,
    controlmoduletype_embedded_graphiscs_visible_set,
    singlecontrolmoduleinst_visibility_in_graphics_get,
    singlecontrolmoduleinst_visibility_in_graphics_set,
    diagramtype_embedded_graphics_visible_get,
    diagramtype_embedded_graphics_visible_set,
}

warning_number :: proc {
    warningmsg_warning_number_get,
    warningmsg_warning_number_set,
}

write_permission :: proc {
    component_write_permission_get,
    component_write_permission_set,
    cmparameter_write_permission_get,
    cmparameter_write_permission_set,
    parameter_write_permission_get,
    parameter_write_permission_set,
    externalvariable_write_permission_get,
    externalvariable_write_permission_set,
    globalvariable_write_permission_get,
    globalvariable_write_permission_set,
    variable_write_permission_get,
    variable_write_permission_set,
}

x :: proc {
    point_x_get,
    point_x_set,
    graphnode_x_get,
    graphnode_x_set,
    graphpos_x_get,
    graphpos_x_set,
}

xscale :: proc {
    graphpos_xscale_get,
    graphpos_xscale_set,
}

y :: proc {
    point_y_get,
    point_y_set,
    graphnode_y_get,
    graphnode_y_set,
    graphpos_y_get,
    graphpos_y_set,
}

yscale :: proc {
    graphpos_yscale_get,
    graphpos_yscale_set,
}
