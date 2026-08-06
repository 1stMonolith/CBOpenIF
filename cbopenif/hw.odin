package cbopenif

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

HardwareLibraryFileType :: enum {
    HelpFile = 0,
    IconFile = 1
}