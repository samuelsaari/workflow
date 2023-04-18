#CommentFlag //
// #Persistent is not necessary for this script,
// the presence of at least one hotkey,
// is one way to make a script persistent

Toggle := False

// #p::Pause

^+Space:: // Toggle the tooltip and follow the mouse

    If (Toggle = False) {

        Toggle := True
        vTickCount1 := A_TickCount
        SetTimer, WatchCursor

    } Else If (Toggle = True) {

        Toggle := False
        SetTimer, WatchCursor, Off
        // ToolTip

    }

Return

^Space:: // Tooltip follows mouse, but disappears after 10 seconds

    SetTimer, WatchCursor, -10000 // negative to run once and then stop
    MouseGetPos, x, y, id, control
    WinGetTitle, title, ahk_id %id%
    WinGetClass, class, ahk_id %id%
    ToolTip, -- Window Info --`n`tahk_id:`t%id%`n`tahk_class:`t%class%`n`tTitle:`t%title%`n`tControl:`t%control%`n`n-- Mouse Pos --`n`tX:`t%x%`n`tY:`t%y%

Return



