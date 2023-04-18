^!e:: 
WinGet, OutputVar, ProcessName, A
MsgBox, %OutputVar%
Return


^!c:: 
WinGetClass, OutputVar , A
MsgBox, %OutputVar%
Return

^!t:: 
WinGetTitle, OutputVar, A
MsgBox, %OutputVar%
Return

^!i:: 
WinGet, OutputVar ,ID, A
MsgBox, %OutputVar%
Return


^!p:: 
WinGet, OutputVar ,PID, A
MsgBox, %OutputVar%
Return

^!n::
WinGet, OutputVar, count,A 
MsgBox, %OutputVar%
Return