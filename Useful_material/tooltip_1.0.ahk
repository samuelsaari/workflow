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

^Space:: // Tooltip appears, but disappears after 5 seconds

    SetTimer, WatchCursor1, -5000 // negative to run once and then stop, process not working
    MouseGetPos, x, y, id, control
    WinGetTitle, title, ahk_id %id%
    WinGetClass, class, ahk_id %id%
    ToolTip, -- Window Info --`n`tahk_id:`t%id%`n`tahk_class:`t%class%`n`tTitle:`t%title%`n`tControl:`t%control%`n`tProcess:`t%Process%`n`n-- Mouse Pos --`n`tX:`t%x%`n`tY:`t%y%

Return

WatchCursor1:
ToolTip
Return

WatchCursor:
MouseGetPos, x, y, id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
Winget, Process, ProcessName, A

ToolTip, -- Window Info --`n`tahk_id:`t%id%`n`tahk_class:`t%class%`n`tTitle:`t%title%`n`tControl:`t%control%`n`tProcess:`t%Process%`n`n-- Mouse Pos --`n`tX:`t%x%`n`tY:`t%y%

// if (A_TickCount - vTickCount1 > 5000)
// {
// SetTimer, WatchCursor, Off
// ToolTip
// }
Return // without this line the lines below in WatchCursor2 will also be triggered

WatchCursor2:
MouseGetPos, x, y, id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ToolTip, -- Window Info --`n`tahk_id:`t%id%`n`tahk_class:`t%class%`n`tTitle:`t%title%`n`tControl:`t%control%`n`tProcess:`t%Process%`n`n-- Mouse Pos --`n`tX:`t%x%`n`tY:`t%y%
Return