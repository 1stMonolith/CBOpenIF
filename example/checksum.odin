package main

import "core:fmt"
import "core:os"
import "core:flags"
import "core:strconv"
import "core:strings"

import file "../cbopenif/file"

find_checksum :: proc(data: string) -> (tag_pos, value_pos, end_pos: int, ok: bool) {
    needle := `<CheckSum Value="`
    idx := strings.index(data, needle)
    if idx < 0 do return 0, 0, 0, false

    tag_pos   = idx
    value_pos = idx + len(needle)

    for i := value_pos; i < len(data); i += 1 {
        if data[i] == '"' {
            end_pos = i
            return tag_pos, value_pos, end_pos, true
        }
    }
    return 0, 0, 0, false
}

extract_checksum :: proc(data: string) -> (stored: u32, cutoff: int, err: string) {
    tag_pos, value_pos, end_pos, found := find_checksum(data)
    if !found {
        return 0, 0, `no <CheckSum Value="..."> found`
    }

    value_str := data[value_pos:end_pos]
    val, parse_ok := strconv.parse_u64(value_str)
    if !parse_ok {
        return 0, 0, "checksum value is not a valid integer"
    }

    // cutoff points at the start of the <CheckSum tag
    cutoff = tag_pos + len("<CheckSum")
    return u32(val), cutoff, ""
}

patch_checksum :: proc(data: string, new_value: u32, allocator := context.allocator) -> (patched: string, err: string) {
    _, value_pos, end_pos, found := find_checksum(data)
    if !found {
        return "", `no <CheckSum Value="..."> found`
    }

    new_str := fmt.tprintf("%d", new_value)

    b := strings.builder_make(allocator)
    defer strings.builder_destroy(&b)

    strings.write_string(&b, data[:value_pos])
    strings.write_string(&b, new_str)
    strings.write_string(&b, data[end_pos:])

    return strings.to_string(b), ""
}

pretty_print_xml :: proc(src: string, allocator := context.allocator) -> string {
    out := strings.builder_make(allocator)
    defer strings.builder_destroy(&out)

    indent := 0
    i := 0
    n := len(src)

    // Skip existing XML declaration
    if strings.has_prefix(src, "<?xml") {
        for i < n && src[i] != '>' do i += 1
        if i < n do i += 1
        for i < n && (src[i] == ' ' || src[i] == '\t' || src[i] == '\r' || src[i] == '\n') do i += 1
    }

    strings.write_string(&out, "<?xml version=\"1.0\" encoding=\"UTF-16\"?>\n")

    for i < n {
        // skip inter-tag whitespace
        for i < n && (src[i] == ' ' || src[i] == '\t' || src[i] == '\r' || src[i] == '\n') do i += 1
        if i >= n do break

        if src[i] == '<' {
            is_close := i+1 < n && src[i+1] == '/'
            is_self  := false

            j := i + 1
            for j < n && src[j] != '>' do j += 1
            if j >= n do break

            tag_content := strings.trim_space(src[i+1:j])
            
            if strings.has_prefix(tag_content, "/") {
                tag_content = strings.trim_left(tag_content, "/")
                tag_content = strings.trim_space(tag_content)
            }
            
            if strings.has_suffix(tag_content, "/") {
                is_self = true
                tag_content = strings.trim_right(tag_content, "/")
                tag_content = strings.trim_space(tag_content)
            }

            if is_close do indent = max(0, indent - 1)

            for _ in 0..<indent do strings.write_byte(&out, '\t')

            strings.write_byte(&out, '<')
            if is_close & !is_self do strings.write_byte(&out, '/')
            strings.write_string(&out, tag_content)
            if is_self do strings.write_byte(&out, '/')
            strings.write_byte(&out, '>')
            strings.write_byte(&out, '\n')

            if !is_close && !is_self do indent += 1
            i = j + 1
        } else {
            // text node
            start := i
            for i < n && src[i] != '<' do i += 1
            text := strings.trim_space(src[start:i])
            if len(text) > 0 {
                for _ in 0..<indent do strings.write_byte(&out, '\t')
                strings.write_string(&out, text)
                strings.write_byte(&out, '\n')
            }
        }
    }
    return strings.to_string(out)
}

write_string_to_file :: proc(path: string, data: string) -> os.Error {
    return os.write_entire_file(path, transmute([]u8)data)
}

Options :: struct {
    file:   string `args:"pos=0,required" usage:"Input ABB CCB XML file."`,
    output: string `args:"pos=1"          usage:"Optional output file. Defaults to overwriting the input."`,
    pretty: bool `usage:"Re-format XML into human-readable form before calculating CRC."`,
    patch:  bool `usage:"Write the calculated checksum back into the file."`,
    verify: bool `usage:"Exit with non-zero status on mismatch (useful for scripts). Implies no patch."`,
}

main :: proc() {
    opt: Options
    flags.parse_or_exit(&opt, os.args, .Odin)

    fmt.println("Compact Control Builder AC 800M Checksum Tool")
    fmt.println("----------------------------------------------")

    // ---- read ----
    fmt.printf("INFO: Opening \"%s\"...\n", opt.file)
    raw_bytes, err := os.read_entire_file(opt.file, context.temp_allocator)
    if err != nil {
        fmt.eprintf("ERROR: Cannot read file \"%s\"\n", opt.file)
        os.exit(1)
    }
    defer delete(raw_bytes)

    raw := string(raw_bytes)

    // ---- optional pretty-print ----
    work: string
    if opt.pretty {
        fmt.println("INFO: Formatting into human-readable XML...")
        work = pretty_print_xml(raw, context.temp_allocator)
    } else {
        work = raw
    }

    // ---- extract ----
    fmt.println("INFO: Extracting checksum value...")
    stored, cutoff, extract_err := extract_checksum(work)
    if extract_err != "" {
        fmt.eprintf("ERROR: %s\n", extract_err)
        os.exit(1)
    }
    fmt.printf("INFO: Extracted Checksum  = %d\n", stored)

    // ---- calculate ----
    fmt.println("INFO: Calculating checksum...")
    calculated, calc_ok := file.crc_calculate(work[:cutoff])
    if !calc_ok {
        fmt.eprintln("ERROR: Failed to calculate checksum (empty data?)")
        os.exit(1)
    }
    fmt.printf("INFO: Calculated Checksum = %d\n", calculated)

    // ---- decide action ----
    mismatch := stored != u32(calculated)

    if mismatch {
        fmt.println("INFO: Checksum mismatch!")

        if opt.verify {
            fmt.println("INFO: Verify mode - exiting with status 1")
            os.exit(1)
        }

        if opt.patch {
            fmt.println("INFO: Patching with calculated checksum...")
            patched, patch_err := patch_checksum(work, u32(calculated), context.temp_allocator)
            if patch_err != "" {
                fmt.eprintf("ERROR: %s\n", patch_err)
                os.exit(1)
            }

            out_path := opt.output if opt.output != "" else opt.file
            fmt.printf("INFO: Writing \"%s\"...\n", out_path)

            err := write_string_to_file(out_path, patched)
            if err != nil {
                fmt.eprintf("ERROR: Failed to write \"%s\"\n", out_path)
                os.exit(1)
            }
            fmt.println("INFO: File patched successfully")
        } else {
            fmt.println("INFO: (use -patch to write the calculated value, or -verify to fail on mismatch)")
        }
    } else {
        fmt.println("INFO: Checksum match!")
    }
}
