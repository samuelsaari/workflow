^!i::
if (WinExist, ahk_exe chrome.exe,,Google Keep)
	WinActivate, ahk_exe chrome.exe,,Google Keep
else if (WinExist("ahk_exe chrome.exe")) && (!WinExist("Google Keep"))
	WinActivate, ahk_exe chrome.exe,,Google Keep
else
	Run, chrome.exe
Return


;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;


<!w:: 
if WinActive("ahk_exe powerpnt.exe") 
{
WinGet, num, count,A
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
else if WinExist("ahk_exe powerpnt.exe")
    WinActivate
else
    Run, powerpnt.exe
Return
