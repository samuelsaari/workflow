^!m::
WinGet, fensterID, List, ahk_exe Notepad.exe
Loop, %fensterID% { ; will run loop for number of windows in array
  	WinActivate, % "ahk_id " fensterID%A_Index%
  	MsgBox, This is window %A_Index% in the list.
}
Return

;

^!t::
WinGet, fensterID, List, ahk_exe Notepad.exe
#MaxThreadsPerHotkey %fensterID%
Toggle := !Toggle
Loop, %fensterID% 
{
	If not Toggle
		break
  	WinActivate, % "ahk_id " fensterID%A_Index%
  	MsgBox, This is window %A_Index% in the list.
}
Return


^!k::
Groupadd, miika, ahk_exe notepad.exe
GroupActivate, miika,R
Return
; toimii

^!l::
WinGet, OutputVar, ProcessName, A
GroupAdd, toggle_test, ahk_exe %Outputvar%
GroupActivate, toggle_test,R
Return


ToggleActive(A) {
Groupadd, toggle_group,processname, %A%
GroupActivate, toggle_group,R
Return
}

^!a::ToggleActive("A")
^!i::ToggleActive("ahk_exe notepad.exe")
^!o::ToggleActive("ahk_class PPTFrameClass")

;;;;;;;;;;;;;;;;;;;;
;https://superuser.com/a/691418
^!g:: ; Next window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^!b:: ; Last window
WinGet, List, List, ahk_exe Notepad.exe
Loop, %List%
{
    WinGet, State, MinMax, "ahk_id " A_Index
    if (State <> -1)
    {
        WinID := A_Index
        break
    }
}
WinActivate, % "ahk_id " WinID
return

