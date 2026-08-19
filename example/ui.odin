package main

import "core:fmt"
import "core:slice"
import "core:os"
import rl "vendor:raylib"
import cb "../cbopenif"

main :: proc() {

    comps := make([dynamic]cb.Component)
    defer delete(comps)

    append(&comps, cb.Component{
        name = "Component1",
        type_name = "Bool",
        attribute = "",
        initial_value = "false",
        description = "A component of type Bool",
    })

    append(&comps, cb.Component{
        name = "Component2",
        type_name = "Dint",
        attribute = "",
        initial_value = "200",
        description = "A component of type Dint",
    })

    append(&comps, cb.Component{
        name = "Component3",
        type_name = "Dword",
        attribute = "constant",
        initial_value = "16#3000",
        description = "A component of type Dword",
    })

    append(&comps, cb.Component{
        name = "Component4",
        type_name = "Real",
        attribute = "",
        initial_value = "4.44",
        description = "A component of type Real",
    })

    dt1: cb.DataType
    dt1.name = "MyTestDataType1"
    dt1.description = "This is a datatype with name MyTestDataType1!"
    dt1.hidden = false
    dt1.protected = false
    dt1.scope = cb.Scope.Public
    dt1.components = slice.clone_to_dynamic(comps[:])
    defer delete(dt1.components)

    dt2: cb.DataType
    dt2.name = "MyTestDataType2"
    dt2.description = "This is a datatype with name MyTestDataType2!"
    dt2.hidden = false
    dt2.protected = false
    dt2.scope = cb.Scope.Public
    dt2.components = slice.clone_to_dynamic(comps[:])
    defer delete(dt2.components)
    
    y:  f32 = 20
    x:  f32 = 20
    bw: f32 = 150
    bh: f32 = 30

    rl.InitWindow(i32(bw + 2*x), i32(bh*7 + 5*7 + 2*y), "CBOpenIF UI Example")
    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)

        x = 20
        y = 20

        if cb.connected() {
            rl.GuiDisable()
        }

        if rl.GuiButton({x, y, bw, bh}, "Connect") {
            cb.connect()
        }

        if cb.connected() {
            rl.GuiEnable()
        }

        y = y + bh + 5

        if !cb.connected() {
            rl.GuiDisable()
        }

        if rl.GuiButton({x, y, bw, bh}, "Disconnect") {
            cb.disconnect()
        }
        
        y = y + bh + 5

        if rl.GuiButton({x, y, bw, bh}, "New Library") {
            cb.library_new("MyTestlib", "")
        }
        
        y = y + bh + 5

        if rl.GuiButton({x, y, bw, bh}, "New DataType 1") {
            cb.datatype_new("MyTestlib", dt1)
        }

        y = y + bh + 5

        if rl.GuiButton({x, y, bw, bh}, "New DataType 2") {
            cb.datatype_new("MyTestlib", dt2)
        }

        y = y + bh + 5

        if rl.GuiButton({x, y, bw, bh}, "Delete DataType 1") {
            cb.datatype_delete("MyTestlib", "MyTestDataType1")
        }

        y = y + bh + 5

        if rl.GuiButton({x, y, bw, bh}, "Delete DataType 2") {
            cb.datatype_delete("MyTestlib", "MyTestDataType2")
        }

        if !cb.connected() {
            rl.GuiEnable()
        }

        rl.EndDrawing()
    }

    cb.disconnect()
    rl.CloseWindow()
}