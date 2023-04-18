^Space::
WinGet, Active_ID, ID, A
WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
MsgBox, Running %Active_Process%
Return