package cbopenif

ParameterType :: enum i32 {
    Parameter     = 0,
    Extensible    = 1,
    ControlModule = 2,
}

VariableType :: enum i32 {
    Variable              = 0,
    ExternalVariable      = 1,
    GlobalVariable        = 2,
    CommunicationVariable = 3,
}

CodeBlockType :: enum i32 {
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

HardwareFileType :: enum i32 {
    Firmware         = 0,
    Update           = 1,
    FirmwareIdx      = 2,
    PHControlBuilder = 3,
    PHController     = 4,
    PHIdx            = 5,
    Help             = 6,
    FWFunctions      = 7,
    CopyRoutines     = 8,
}

Scope :: enum i32 {
    Public  = 0,
    Private = 1,
}

VisibilityInGraphics :: enum i32 {
    Default   = 0,
    Visible   = 1,
    Invisible = 2,
}

AutoPos :: enum i32 {
    Top    = 0,
    Bottom = 1,
    Left   = 2,
    Right  = 3,
}

SFCPriorityValue :: enum i32 {
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5,
}

MessageType :: enum i32 {
    UndefPOU      = 0,
    DataType      = 1,
    Function      = 2,
    FunctionBlock = 3,
    ModuleType    = 4,
    SingleModule  = 5,
    RootModule    = 6,
    ProgramType   = 7,
    SingleProgram = 8,
    HW            = 9,
    VarAccess     = 10,
    General       = 11,
    SingleDiagram = 12,
    DiagramType   = 13,
    Other         = 14,
}

Direction :: enum i32 {
    In    = 0,
    InOut = 1,
    Out   = 2,
}

TaskPriority :: enum i32 {
    Priority0 = 0,
    Priority1 = 1,
    Priority2 = 2,
    Priority3 = 3,
    Priority4 = 4,
    Priority5 = 5,
}

OutputUpdate :: enum i32 {
    First = 0,
    Last  = 1,
}

TaskSILLevel :: enum i32 {
    SIL0 = 0,
    SIL2 = 1,
    SIL3 = 2,
}

FolderType :: enum {
    ApplicationFolder = 0
}

ExecutionInstanceType :: enum {
    Diagrams = 0
}

SignalType :: enum {
    Siganl = 0
}

HardwareLibraryFileType :: enum {
    HelpFile = 0,
    IconFile = 1
}

_As_Variable :: struct {}
_As_GlobalVariable :: struct {}
_As_Signal :: struct {}

As_Varialbe : _As_Variable = {}
As_GlobalVarialbe : _As_GlobalVariable = {}
As_Signal : _As_Signal = {}

connect :: proc() -> (ok: bool) {
    cbopenif_connect()
    factory_connect()
    return true
}

disconnect :: proc() -> (ok: bool) {
    cbopenif_disconnect()
    factory_disconnect()
    return true
}

connected :: proc() -> (ok: bool) {
 if (cbopenif != nil) & (factoryif != nil) do return true
 return false
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
}

x :: proc {
    graphnode_x_,
    graphnode_x_set,
    point_x_,
    point_x_set,
}

y :: proc {
    graphnode_y_,
    graphnode_y_set,
    point_y_,
    point_y_set,
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
}

fdport :: proc {
    parameter_fdport_,
    parameter_fdport_set,
}

batch_property :: proc {
    variable_batch_property_,
    variable_batch_property_set,
}

graph_nodes :: proc {
    variable_graph_nodes_,
    variable_graph_nodes_set,
    globalvariable_graph_nodes_,
    globalvariable_graph_nodes_set,
    externalvariable_graph_nodes_,
    externalvariable_graph_nodes_set,
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
    parameter_setting_description_
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
}

type_path :: proc {
    component_type_path,
    variable_type_path,
    globalvariable_type_path,
    externalvariable_type_path,
    parameter_type_path,
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

serialize :: proc {
    datatype_serialize,
    variable_serialize,
    applicationvariables_serialize,
    signal_serialize,
    globalvariable_serialize,
    externalvariable_serialize,
    parameter_serialize,
    cmconnection_serialize,
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
    points_point_by_index
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
}
