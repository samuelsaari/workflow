 
; This example allows you to move the mouse around to see
; the title of the window currently under the cursor:
^!ö::
#Persistent
SetTimer, WatchCursor, 100
return



WatchCursor:
MouseGetPos,X, Y , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ToolTip, `X %X%`nY %Y%`nahk_id %id%`nahk_class %class%`n%title%`nControl: %control%
return


Toggle := False

^!ä::	;
; set the tooltip displayflag either on or off
ttflagw1 = ((ttflagw1 +1) & 1)
; if it's on, show the tooltip
if (ttflagw1)
{   ToolTip, Multiline`nTooltip, 100, 150
}
else
{   hotkey, #1, off
    tooltip 
}
return

/*
^!ä::Pause, Toggle

Return
*/
