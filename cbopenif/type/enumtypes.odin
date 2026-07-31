package type

VariableType :: enum i32 {
    Variable              = 0,
    ExternalVariable      = 1,
    GlobalVariable        = 2,
    CommunicationVariable = 3,
}

SignalType :: enum {
    Siganl = 0
}

ParameterType :: enum i32 {
    Parameter     = 0,
    Extensible    = 1,
    ControlModule = 2,
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

FolderType :: enum {
    ApplicationFolder = 0
}

ExecutionInstanceType :: enum {
    Diagrams = 0
}

HardwareLibraryFileType :: enum {
    HelpFile = 0,
    IconFile = 1
}

ScopeType :: enum i32 {
    Public  = 0,
    Private = 1,
}

VisibilityInGraphicsType :: enum i32 {
    Default   = 0,
    Visible   = 1,
    Invisible = 2,
}

DirectionType :: enum i32 {
    In    = 0,
    InOut = 1,
    Out   = 2,
}

TaskPriorityType :: enum i32 {
    Priority0 = 0,
    Priority1 = 1,
    Priority2 = 2,
    Priority3 = 3,
    Priority4 = 4,
    Priority5 = 5,
}

OutputUpdateType :: enum i32 {
    First = 0,
    Last  = 1,
}

TaskSILLevelType :: enum i32 {
    SIL0 = 0,
    SIL2 = 1,
    SIL3 = 2,
}