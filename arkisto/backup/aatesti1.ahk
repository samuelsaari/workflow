<!s::
{
	if WinExist("Snip & Sketch ahk_class ApplicationFrameWindow")
		if WinActive()
			WinMinimize
		else
			WinActivate
	else
		Run ms-screenclip:?source=QuickActions
	return
}

; sources
;https://www.intowindows.com/create-screen-sketch-snip-desktop-shortcut-in-windows-10/
;https://www.autohotkey.com/boards/viewtopic.php?t=13818

