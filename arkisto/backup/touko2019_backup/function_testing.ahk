;;;;;;;;;;;;;;;;;;;;;;;;;
;functions
;https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/
;;;;;;;;;;;;;;;;;;;;;;;;;

;F1::RoA("ahk_class CalcFrame", "calc")
;F2::RoA("ahk_class Notepad", "Notepad")
; etc...

/*
roa1(WinTitle, Target) {	
	IfWinExist, %WinTitle%
		WinActivate, %WinTitle%
	else
		Run, %Target%
}
*/

roa1(WinTitle, Target) {
if WinActive(WinTitle)
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
}
else if WinExist(WinTitle)
    WinActivate
else
{	
	Run, %Target%,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
}
^!r::roa1("ahk_exe snippingtool.exe", "snippingtool.exe")


;;;;;;;;;;;



roa2(WINTITLE, TARGET) {
if WinActive(WINTITLE)
{
WinGet, num, count,%WINTITLE%
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist(WINTITLE)
    WinActivate, %WINTITLE%
else
{	
	Run, %TARGET%,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
}

#h::roa2("ahk_exe rstudio.exe","rstudio.exe")