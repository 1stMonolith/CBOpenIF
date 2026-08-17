package file

import "core:sync"

POLY :: u16(0x1021)
SEED :: u16(0xFFFF)

@(private)
crc_table: [256]u16

@(private)
table_once: sync.Once

@(private)
crc_table_init :: proc "contextless" () {
    for b in 0..<256 {
        crc := u16(b) << 8
        for _ in 0..<8 {
            if (crc & 0x8000) != 0 {
                crc = ((crc << 1) ~ POLY) & 0xFFFF
            } else {
                crc = (crc << 1) & 0xFFFF
            }
        }
        crc_table[b] = crc
    }
}

crc_calculate :: proc(data: string, seed: u16 = SEED) -> (crc: u16, ok: bool) {
    if len(data) == 0 do return 0, false

    sync.once_do(&table_once, crc_table_init)

    crc = seed
    bytes := transmute([]u8)data
    for b in bytes {
        crc = ((crc << 8) & 0xFFFF) ~ crc_table[crc >> 8] ~ u16(b)
    }
    return crc & 0xFFFF, true
}
