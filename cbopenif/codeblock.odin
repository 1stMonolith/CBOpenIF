package cbopenif

import "com"

CodeBlockKind :: enum i32
{
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

SFCElementKind :: enum i32
{
    Step         = 0,
    Transition   = 1,
    SubSequence  = 2,
    Selection    = 3,
    Simultaneous = 4,
}

SFCPriorityKind :: enum i32
{
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5,
}

CodeBlock :: struct
{
    kind:   CodeBlockKind,
    name:   string,
    stcode: string,
}

ILRow :: struct
{
    label:       string,
    instruction: string,
    operand:     string,
    description: string,
    comment:     string,
    iscomment:   bool,
}

CodeBlocksFromCom :: proc(comcodeblocks: com.CodeBlocks, codeblocks: ^[dynamic]CodeBlock) -> (ok: bool)
{
    if comcodeblocks == nil do return

    count: i32
    count, ok = com.CodeBlockCount(comcodeblocks)
    if !ok do return

    for i in 0..<count {
        comcodeblock: com.CodeBlock
        comcodeblock, ok = com.GetCodeBlock(comcodeblocks, i)
        if !ok do return
        defer com.ReleaseCodeBlock(comcodeblock)

        codeblock: CodeBlock
        codeblock, ok = CodeBlockFromCom(comcodeblock)
        if !ok do return
        append(codeblocks, codeblock)
    }

    return true
}

CodeBlockFromCom :: proc(comcodeblock: com.CodeBlock) -> (codeblock: CodeBlock, ok: bool)
{
    if comcodeblock == nil do return

    codeblock.name, ok = com.Name(comcodeblock)
    if !ok do return

    switch cb in comcodeblock {
        case com.STCodeBlock:
            codeblock.kind = .ST
            codeblock.stcode, ok = com.STCode(cb)
            if !ok do return

        case com.FBDCodeBlock:
            codeblock.kind = .FBD
            codeblock.stcode, ok = com.STCode(cb)
            if !ok do return

        case com.LDCodeBlock:
            codeblock.kind = .LD
            codeblock.stcode, ok = com.STCode(cb)
            if !ok do return

        case com.SFCCodeBlock:
            return // TODO

        case com.ILCodeBlock:
            return // TODO

        case com.FDCodeBlock:
            return // TODO
    }

    return codeblock, true
}

CodeBlocksToCom :: proc(comcodeblocks: com.CodeBlocks, codeblocks: []CodeBlock) -> (ok: bool)
{
    if comcodeblocks == nil do return

    for codeblock in codeblocks {
        comcodeblock: com.CodeBlock
        comcodeblock, ok = CodeBlockToCom(codeblock)
        if !ok do return
        defer com.Release(comcodeblock)

        ok = com.AddCodeBlock(comcodeblocks, comcodeblock)
        if !ok do return
    }

    return true
}

CodeBlockToCom :: proc(codeblock: CodeBlock) -> (comcodeblock: com.CodeBlock, ok: bool)
{
    switch codeblock.kind {
        case .ST:
            comstcodeblock: com.STCodeBlock
            comstcodeblock, ok = com.NewSTCodeBlockEx(codeblock.name, codeblock.stcode)
            if !ok do return
            comcodeblock = comstcodeblock

        case .FBD:
            comfbdcodeblock: com.FBDCodeBlock
            comfbdcodeblock, ok = com.NewFBDCodeBlockEx(codeblock.name, codeblock.stcode)
            if !ok do return
            comcodeblock = comfbdcodeblock

        case .LD:
            comldcodeblock: com.LDCodeBlock
            comldcodeblock, ok = com.NewLDCodeBlockEx(codeblock.name, codeblock.stcode)
            if !ok do return
            comcodeblock = comldcodeblock

        case .SFC:
            return // TODO

        case .IL:
            return // TODO

        case .FD:
            return // TODO
    }

    return comcodeblock, true
}

ILRowsFromCom :: proc(comilrows: com.ILRows, ilrows: ^[dynamic]ILRow) -> (ok: bool)
{
    if comilrows == nil do return

    count: i32
    count, ok = com.ILRowCount(comilrows)
    if !ok do return

    for i in 0..<count {
        comilrow: com.ILRow
        comilrow, ok = com.GetILRow(comilrows, i)
        if !ok do return
        defer com.Release(comilrow)

        ilrow: ILRow
        ilrow, ok = ILRowFromCom(comilrow)
        if !ok do return
        append(ilrows, ilrow)
    }
    return true
}

ILRowFromCom :: proc(comilrow: com.ILRow) -> (ilrow: ILRow, ok: bool)
{
    if comilrow == nil do return

    ilrow.label, ok = com.GetILRowLabel(comilrow)
    if !ok do return

    ilrow.instruction, ok = com.GetILRowInstruction(comilrow)
    if !ok do return

    ilrow.operand, ok = com.GetILRowOperand(comilrow)
    if !ok do return

    ilrow.description, ok = com.Description(comilrow)
    if !ok do return

    ilrow.comment, ok = com.GetILRowComment(comilrow)
    if !ok do return

    ilrow.iscomment, ok = com.GetILRowIsComment(comilrow)
    if !ok do return

    return ilrow, true
}

ILRowsToCom :: proc(comilrows: com.ILRows, ilrows: []ILRow) -> (ok: bool)
{
    if comilrows == nil do return

    for ilrow in ilrows {
        comilrow: com.ILRow
        comilrow, ok = ILRowToCom(ilrow)
        if !ok do return
        defer com.Release(comilrow)

        ok = com.AddILRow(comilrows, comilrow)
        if !ok do return
    }
    
    return true
}

ILRowToCom :: proc(ilrow: ILRow) -> (comilrow: com.ILRow, ok: bool)
{
    if ilrow.iscomment {
        comilrow, ok = com.NewILRowEx(ilrow.comment)
        if !ok do return
        return comilrow, true
    }

    comilrow, ok = com.NewILRow(ilrow.label, ilrow.instruction, ilrow.operand, ilrow.description)
    if !ok do return
    defer if !ok do com.Release(comilrow)

    ok = com.SetILRowComment(comilrow, ilrow.comment)
    if !ok do return

    return comilrow, true
}
