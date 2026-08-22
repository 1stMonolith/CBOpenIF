package cbopenif

import "com"

CodeBlockKind :: enum i32 {
    ST  = 0,
    SFC = 1,
    FBD = 2,
    LD  = 3,
    IL  = 4,
    FD  = 5,
}

SFCElementKind :: enum i32 {
    Step         = 0,
    Transition   = 1,
    SubSequence  = 2,
    Selection    = 3,
    Simultaneous = 4,
}

SFCPriorityKind :: enum i32 {
    Default = 0,
    Lowest  = 1,
    Low     = 2,
    Medium  = 3,
    High    = 4,
    Highest = 5,
}

CodeBlock :: struct {
    kind:   CodeBlockKind,
    name:   string,
    stcode: string,
}

ILRow :: struct {
    label:          string,
    instruction:    string,
    operand:        string,
    description:    string,
    row_comment:    string,
    is_row_comment: bool,
}

codeblock_from_com :: proc(codeblock: CodeBlock, allocator := context.allocator) -> (result: t.CodeBlock, ok: bool) {
    context.allocator = allocator

    result.name, ok = name(codeblock)
    if !ok do return

    switch cb in codeblock {
        case STCodeBlock:
            result.kind = .ST
            result.stcode, ok = stcode(cb)
            if !ok do return
        case FBDCodeBlock:
            result.kind = .FBD
            result.stcode, ok = stcode(cb)
            if !ok do return
        case LDCodeBlock:
            result.kind = .LD
            result.stcode, ok = stcode(cb)
            if !ok do return
        case SFCCodeBlock:
            return // TODO
        case ILCodeBlock:
            return // TODO
        case FDCodeBlock:
            return // TODO
    }

    return result, true
}

codeblock_to_com :: proc(src: t.CodeBlock) -> (result: CodeBlock, ok: bool) {
    cb: CodeBlock

    switch src.kind {
        case .ST:
            block: STCodeBlock
            block, ok = stcodeblock_new1(src.name, src.stcode)
            if !ok do return
            block = block
        case .FBD:
            block: FBDCodeBlock
            block, ok = fbdcodeblock_new1(src.name, src.stcode)
            if !ok do return
            block = block
        case .LD:
            block: LDCodeBlock
            block, ok = ldcodeblock_new1(src.name, src.stcode)
            if !ok do return
            block = block
        case .SFC:
            return // TODO
        case .IL:
            return // TODO
        case .FD:
            return // TODO
    }

    return cb, true
}

codeblocks_from_com :: proc(cbs: CodeBlocks, allocator := context.allocator) -> (result: [dynamic]t.CodeBlock, ok: bool) {
    if cbs == nil do return
    context.allocator = allocator

    count: i32
    count, ok = codeblock_count(cbs)
    if !ok do return

    result = make([dynamic]t.CodeBlock, 0, int(count), allocator)
    for i in 0..<count {
        cb: CodeBlock
        cb, ok = codeblock(cbs, i)
        if !ok do return
        defer codeblock_release(cb)

        cbs_: t.CodeBlock
        cbs_, ok = codeblock_from_com(cb)
        if !ok do return
        append(&result, cbs_)
    }
    return result, true
}

codeblocks_to_com :: proc(cbs: CodeBlocks, src: []t.CodeBlock) -> (ok: bool) {
    if cbs == nil do return
    for item in src {
        cb: CodeBlock
        cb, ok = codeblock_to_com(item)
        if !ok do return
        defer codeblock_release(cb)

        ok = codeblock_add(cbs, cb)
        if !ok do return
    }
    return true
}

ilrow_from_com :: proc(ilrow: ILRow, allocator := context.allocator) -> (result: t.ILRow, ok: bool) {
    if ilrow == nil do return

    context.allocator = allocator

    result.label, ok = ilrow_label_get(ilrow)
    if !ok do return
    result.instruction, ok = ilrow_instruction_get(ilrow)
    if !ok do return
    result.operand, ok = ilrow_operand_get(ilrow)
    if !ok do return
    result.description, ok = description(ilrow)
    if !ok do return
    result.row_comment, ok = ilrow_row_comment_get(ilrow)
    if !ok do return
    result.is_row_comment, ok = ilrow_is_row_comment_get(ilrow)
    if !ok do return

    return result, true
}

ilrow_to_com :: proc(src: t.ILRow) -> (result: ILRow, ok: bool) {
    ilrow: ILRow
    if src.is_row_comment {
        ilrow, ok = ilrow_new1(src.row_comment)
        if !ok do return
        return ilrow, true
    }

    ilrow, ok = ilrow_new(src.label, src.instruction, src.operand, src.description)
    if !ok do return
    defer if !ok do release(ilrow)

    ok = ilrow_row_comment_set(ilrow, src.row_comment)
    if !ok do return

    return ilrow, true
}

ilrows_from_com :: proc(rows: ILRows, allocator := context.allocator) -> (result: [dynamic]t.ILRow, ok: bool) {
    if rows == nil do return
    context.allocator = allocator

    count: i32
    count, ok = ilrow_count(rows)
    if !ok do return

    result = make([dynamic]t.ILRow, 0, int(count), allocator)
    for i in 0..<count {
        r: ILRow
        r, ok = ilrow_by_index(rows, i)
        if !ok do return
        defer release(r)

        rs: t.ILRow
        rs, ok = ilrow_from_com(r)
        if !ok do return
        append(&result, rs)
    }
    return result, true
}

ilrows_to_com :: proc(rows: ILRows, src: []t.ILRow) -> (ok: bool) {
    if rows == nil do return
    for item in src {
        r: ILRow
        r, ok = ilrow_to_com(item)
        if !ok do return
        defer release(r)
        ok = ilrow_add(rows, r)
        if !ok do return
    }
    return true
}
