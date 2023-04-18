^!m::
MouseGetPos, xpos, ypos 
MsgBox, The cursor is at X%xpos% Y%ypos%.
Return 

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

^!ä::ExitApp

/*

#IfWinActive, ahk_class MozillaWindowClass
^+s::
If Winexist("Zotero")
{
Click, 1230, 60
Mousemove, 600, 300
}
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Sleep, 500
	WinActivate, ahk_exe firefox.exe
	Sleep, 200
	Click, 1230, 60
	Mousemove, 600, 300
}
Return
#IfWinActive

*/