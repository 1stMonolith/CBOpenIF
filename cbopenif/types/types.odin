package types

Scope :: enum i32 {
    Public  = 0,
    Private = 1,
}

Direction :: enum i32 {
    Input  = 0,
    Output = 1,
    InOut  = 2,
}

// For Signal and CommVariable COM because it exposes Direction as BStr
direction_from_string :: proc(s: string) -> Direction {
    switch s {
    case "Input", "0":  return .Input
    case "Output", "1": return .Output
    case "InOut", "2":  return .InOut
    case:               return .Input
    }
}

// For Signal and CommVariable COM because it exposes Direction as BStr
direction_to_string :: proc(d: Direction) -> string {
    switch d {
    case .Input:  return "Input"
    case .Output: return "Output"
    case .InOut:  return "InOut"
    case:         return "Input"
    }
}

TaskOutputUpdate :: enum i32 {
    First = 0,
    Last  = 1,
}

TaskPriority :: enum i32 {
    Priority0 = 0,
    Priority1 = 1,
    Priority2 = 2,
    Priority3 = 3,
    Priority4 = 4,
    Priority5 = 5,
}

TaskSILLevel :: enum i32 {
    SIL0 = 0,
    SIL2 = 1,
    SIL3 = 2,
}

AutoPos :: enum i32 {
    Top    = 0,
    Bottom = 1,
    Left   = 2,
    Right  = 3,
}

CodeBlockKind :: enum i32 {
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

ExecutionInstanceKind :: enum {
    Diagrams = 0,
}

Folder :: enum {
    ApplicationFolder = 0,
}

HardwareFile :: enum i32 {
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

HardwareLibraryFile :: enum {
    HelpFile = 0,
    IconFile = 1,
}

Message :: enum i32 {
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

ParameterKind :: enum i32 {
    Parameter     = 0,
    Extensible    = 1,
    ControlModule = 2,
}

SFCElement :: enum i32 {
    Step         = 0,
    Transition   = 1,
    SubSequence  = 2,
    Selection    = 3,
    Simultaneous = 4,
}

SFCPriority :: enum i32 {
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5,
}

VariableKind :: enum i32 {
    Variable              = 0,
    ExternalVariable      = 1,
    GlobalVariable        = 2,
    CommunicationVariable = 3,
}

VisibilityInGraphics :: enum i32 {
    Default   = 0,
    Visible   = 1,
    Invisible = 2,
}

SignalKind :: enum i32 {
    Signal = 0,
}

Point :: struct {
    x: f64,
    y: f64,
}

GraphPos :: struct {
    x:        f64,
    y:        f64,
    rotation: f64,
    xscale:   f64,
    yscale:   f64,
}

GraphSize :: struct {
    lower_left:  Point,
    upper_right: Point,
}

GraphNode :: struct {
    name: string,
    x:    f64,
    y:    f64,
}

PosInfo :: struct {
    fou_name:      string,
    pou_name:      string,
    element_name:  string,
    tab_name:      string,
    page_number:   i32,
    row:           i32,
    column:        i32,
    start_position: i32,
    end_position:  i32,
    id:            string,
    message_type:  Message,
}

MessageKind :: enum {
    Error,
    Warning,
    Info,
    Find,
}

Msg :: struct {
    kind:             MessageKind,
    message:          string,
    error_number:     i32,
    warning_number:   i32,
    pos_info:         PosInfo,
    extra_info:       ExtraInfo,
}

ExtraInfo :: struct {
    jump_destination: string,
    var_name:         string,
    function_name:    string,
    expected_type:    string,
    traverse_no:      i32,
}

MessageBucket :: struct {
    messages: [dynamic]Msg,
}

Component :: struct {
    name:                 string,
    type_name:            string,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    isp_value:            string,
    type_guid:            string, // read-only from COM
    type_path:            string, // read-only from COM
}

Parameter :: struct {
    name:                 string,
    type_name:            string,
    direction:            Direction,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    fd_port:              string,
    type_guid:            string,
    type_path:            string,
}

ExtensibleParameter :: struct {
    name:                 string,
    type_name:            string,
    direction:            Direction,
    attribute:            string,
    initial_value:        string,
    description:          string,
    access_level:         string,
    safety_type:          string,
    fd_port:              string,
    type_guid:            string,
    type_path:            string,
}

CMParameter :: struct {
    name:                 string,
    type_name:            string,
    direction:            Direction,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    batch_property:       string,
    fd_port:              string,
    auto_point:           AutoPoint,
    graph_nodes:          [dynamic]GraphNode,
    type_guid:            string,
    type_path:            string,
}

AutoPoint :: struct {
    auto_pos: AutoPos,
}

Variable :: struct {
    name:                 string,
    type_name:            string,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    batch_property:       string,
    graph_nodes:          [dynamic]GraphNode,
    type_guid:            string,
    type_path:            string,
}

ExternalVariable :: struct {
    name:                 string,
    type_name:            string,
    attribute:            string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    graph_nodes:          [dynamic]GraphNode,
    type_guid:            string,
    type_path:            string,
}

GlobalVariable :: struct {
    name:                 string,
    type_name:            string,
    attribute:            string,
    initial_value:        string,
    description:          string,
    read_permission:      string,
    write_permission:     string,
    authentication_level: string,
    access_level:         string,
    safety_type:          string,
    graph_nodes:          [dynamic]GraphNode,
    type_guid:            string,
    type_path:            string,
}

CommVariable :: struct {
    name:              string,
    type_name:         string,
    attribute:         string,
    initial_value:     string,
    description:       string,
    direction:         Direction,
    acknowledge_group: string,
    expected_sil:      string,
    restricted_sil:    bool,
    interval_time:     string,
    priority:          string,
    ip_address:        string,
    unique_id:         i32,
    isp_value:         string,
    read_permission:   string,
    type_guid:         string,
    type_path:         string,
}

Signal :: struct {
    name:              string,
    path:              string,
    direction:         Direction,
    acknowledge_group: string,
    description:       string,
}

DataType :: struct {
    name:                 string,
    description:          string,
    protected:            bool,
    hidden:               bool,
    scope:                Scope,
    guid:                 string,
    reserved_by_function: string,
    components:           [dynamic]Component,
}

CodeBlock :: struct {
    kind:   CodeBlockKind,
    name:   string,
    stcode: string,
}

FunctionBlockType :: struct {
    name:                         string,
    description:                  string,
    protected:                    bool,
    hidden:                       bool,
    scope:                        Scope,
    guid:                         string,
    reserved_by_function:         string,
    sil_level:                    string,
    restricted_sil:               string,
    alarm_owner:                  bool,
    interaction_window:           string,
    instantiate_as_aspect_object: bool,
    simulation_mark:              bool,
    embedded_graphics_visible:    bool,
    parameters:                   [dynamic]Parameter,
    extensible_parameters:        [dynamic]ExtensibleParameter,
    variables:                    [dynamic]Variable,
    external_variables:           [dynamic]ExternalVariable,
    code_blocks:                  [dynamic]CodeBlock,
    function_blocks:              [dynamic]FunctionBlock,
}

FunctionBlock :: struct {
    name:                        string,
    type_name:                   string,
    description:                 string,
    access_level:                string,
    safety_type:                 string,
    aspect_object:               bool,
    expose_properties_in_parent: bool,
    task_connection:             string,
    type_guid:                   string,
    type_path:                   string,
}

ControlModuleType :: struct {
    name:                         string,
    description:                  string,
    protected:                    bool,
    hidden:                       bool,
    scope:                        Scope,
    guid:                         string,
    reserved_by_function:         string,
    sil_level:                    string,
    restricted_sil:               bool,
    alarm_owner:                  bool,
    batch_object:                 bool,
    interaction_window:           string,
    instantiate_as_aspect_object: bool,
    simulation_mark:              bool,
    embedded_graphics_visible:    bool,
    cm_graphics:                  string,
    graph_size:                   GraphSize,
    cm_parameters:                [dynamic]CMParameter,
    variables:                    [dynamic]Variable,
    external_variables:           [dynamic]ExternalVariable,
    code_blocks:                  [dynamic]CodeBlock,
    function_blocks:              [dynamic]FunctionBlock,
    control_modules:              [dynamic]ControlModule,
}

SingleControlModuleType :: struct {
    name:                 string,
    description:          string,
    guid:                 string,
    reserved_by_function: string,
    sil_level:            string,
    restricted_sil:       bool,
    alarm_owner:          bool,
    batch_object:         bool,
    interaction_window:   string,
    simulation_mark:      bool,
    cm_graphics:          string,
    graph_size:           GraphSize,
    type_guid:            string,
    cm_parameters:        [dynamic]CMParameter,
    variables:            [dynamic]Variable,
    external_variables:   [dynamic]ExternalVariable,
    code_blocks:          [dynamic]CodeBlock,
    function_blocks:      [dynamic]FunctionBlock,
    control_modules:      [dynamic]ControlModule,
    signals:              [dynamic]Signal,
    comm_variables:       [dynamic]CommVariable,
    init_values:          [dynamic]InitValue,
}

ControlModule :: struct {
    name:                        string,
    type_name:                   string,
    description:                 string,
    access_level:                string,
    safety_type:                 string,
    aspect_object:               bool,
    expose_properties_in_parent: bool,
    task_connection:             string,
    instance_graphics:           string,
    visibility_in_graphics:      string,
    graph_pos:                   GraphPos,
    type_guid:                   string,
    type_path:                   string,
    cm_connections:              [dynamic]CMConnection,
}

SingleControlModuleInst :: struct {
    name:                       string,
    description:                string,
    access_level:               string,
    safety_type:                string,
    task_connection:            string,
    instance_graphics:          string,
    visibility_in_graphics:     string,
    graph_pos:                  GraphPos,
    inst_guid:                  string,
    type_guid:                  string,
    cm_connections:             [dynamic]CMConnection,
}

CMConnection :: struct {
    name:                 string,
    actual_parameter:     string,
    graphical_connection: bool,
    points:               [dynamic]Point,
}

InitValue :: struct {
    name:     string,
    pou_path: string,
    value:    string,
}

Program :: struct {
    name:                 string,
    description:          string,
    access_level:         string,
    safety_type:          string,
    task_connection:      string,
    simulation_mark:      bool,
    sil_level:            string,
    inst_guid:            string,
    type_guid:            string,
    reserved_by_function: string,
    variables:            [dynamic]Variable,
    signals:              [dynamic]Signal,
    comm_variables:       [dynamic]CommVariable,
    code_blocks:          [dynamic]CodeBlock,
    function_blocks:      [dynamic]FunctionBlock,
    init_values:          [dynamic]InitValue,
}

DiagramType :: struct {
    name:                         string,
    description:                  string,
    protected:                    bool,
    hidden:                       bool,
    scope:                        Scope,
    guid:                         string,
    reserved_by_function:         string,
    sil_level:                    string,
    restricted_sil:               bool,
    alarm_owner:                  bool,
    batch_object:                 bool,
    instantiate_as_aspect_object: bool,
    simulation_mark:              bool,
    embedded_graphics_visible:    bool,
    parameters:                   [dynamic]Parameter,
    variables:                    [dynamic]Variable,
    code_blocks:                  [dynamic]CodeBlock,
    function_blocks:              [dynamic]FunctionBlock,
    control_modules:              [dynamic]ControlModule,
    diagram_instances:            [dynamic]DiagramInstance,
}

Diagram :: struct {
    name:                 string,
    description:          string,
    access_level:         string,
    safety_type:          string,
    task_connection:      string,
    simulation_mark:      bool,
    sil_level:            string,
    restricted_sil:       bool,
    batch_object:         bool,
    inst_guid:            string,
    type_guid:            string,
    reserved_by_function: string,
    variables:            [dynamic]Variable,
    signals:              [dynamic]Signal,
    comm_variables:       [dynamic]CommVariable,
    code_blocks:          [dynamic]CodeBlock,
    function_blocks:      [dynamic]FunctionBlock,
    control_modules:      [dynamic]ControlModule,
    diagram_instances:    [dynamic]DiagramInstance,
    init_values:          [dynamic]InitValue,
}

DiagramInstance :: struct {
    name:                        string,
    type_name:                   string,
    description:                 string,
    access_level:                string,
    safety_type:                 string,
    aspect_object:               bool,
    expose_properties_in_parent: bool,
    guid:                       string,
    type_guid:                  string,
    type_path:                  string,
}

Task :: struct {
    name:                string,
    interval_time:       i32,
    priority:            TaskPriority,
    offset:              i32,
    output_update:       TaskOutputUpdate,
    latency_supervision: bool,
    latency_percentage:  i32,
    sil_level:           TaskSILLevel,
    guid:                string,
}

HWChannel :: struct {
    name:           string,
    address:        string,
    unit:           string,
    min:            string,
    max:            string,
    fraction:       string,
    reversed:       bool,
    con_variable:   string,
    io_description: string,
}

HWUnit :: struct {
    path:                    string,
    instance_name:           string,
    type_id:                 string,
    type_guid:               string,
    type_description:        string,
    guid:                    string,
    reserved_by_function:    string,
    hw_simulation:           bool,
    hw_simulation_supported: bool,
    redundant_pos:           string,
    channels:                [dynamic]HWChannel,
    units:                   [dynamic]HWUnit,
    parameter_settings:      [dynamic]ParameterSetting,
}

ParameterSetting :: struct {
    name:            string,
    description:     string,
    parameter_value: string,
}

ConnectedApplication :: struct {
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

ConnectedLibrary :: struct {
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

ConnectedHWLibrary :: struct {
    name:          string,
    major_version: i32,
    minor_version: i32,
    revision:      i32,
}

ApplicationProperties :: struct {
    application_type: string,
    sil_level:        string,
    simulation_mark:  bool,
    // add more fields as they surface from the COM interface
}

ApplicationVariables :: struct {
    description: string,
    variables:   [dynamic]Variable,
    globals:     [dynamic]GlobalVariable,
    signals:     [dynamic]Signal,
}

ProjectConstant :: struct {
    name:  string,
    type:  string,
    value: string,
}

AccessVariables :: struct {
    protocols: [dynamic]VAProtocol, // union or tagged of named/addressed
}

// Tagged union for the protocol variants
VAProtocol :: struct {
    // refine this later with a proper tagged union
    named:     Maybe(VANamedProtocol),
    addressed: Maybe(VAAddressedProtocol),
}

VANamedVariable :: struct {
    name:         string,
    path:         string,
    row:          i32,
    va_attribute: string,
    va_type:      string,
    va_type_path: string,
}

VAAddressedVariable :: struct {
    name:         string,
    path:         string,
    row:          i32,
    va_type:      string,
    va_type_path: string,
}

VANamedProtocol :: struct {
    name:      string,
    variables: [dynamic]VANamedVariable,
}

VAAddressedProtocol :: struct {
    name:      string,
    variables: [dynamic]VAAddressedVariable,
}

ExecutionOrder :: struct {
    groups: [dynamic]ExecutionGroup,
}

ExecutionGroup :: struct {
    task_name:  string,
    instances:  [dynamic]ExecutionInstance,
}

ExecutionInstance :: struct {
    name: string,
}

ILRow :: struct {
    label:          string,
    instruction:    string,
    operand:        string,
    description:    string,
    row_comment:    string,
    is_row_comment: bool,
}
