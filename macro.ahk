#Requires AutoHotkey v2.0
#SingleInstance Force

enabled := false
clicking := false
lastState := false

F6::{
    global enabled, clicking
    enabled := !enabled
    clicking := false

    if (enabled) {
        SetTimer(CheckMouse, 10)
        ToolTip("Makro AKTİF")
    } else {
        SetTimer(CheckMouse, 0)
        SetTimer(AutoClick, 0)
        ToolTip("Makro PASİF")
    }

    SetTimer(() => ToolTip(), -1000)
}

CheckMouse() {
    global enabled, clicking, lastState

    if (!enabled)
        return

    state := GetKeyState("LButton", "P")

    ; Sadece fiziksel basışın ilk anını algıla
    if (state && !lastState) {
        clicking := !clicking

        if (clicking)
            SetTimer(AutoClick, 10) ; hız
        else
            SetTimer(AutoClick, 0)
    }

    lastState := state
}

AutoClick() {
    Click("Left")
}
