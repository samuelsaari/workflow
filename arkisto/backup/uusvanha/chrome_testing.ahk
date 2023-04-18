
;Return

;^!a::
;GroupActivate, notkeep

^!ö::
SetTitleMatchMode, 1
;GroupAdd, notkeep,ahk_exe chrome.exe
GroupAdd, notkeep,ahk_class Chrome_WidgetWin_1, , ,Google Keep
if WinExist("ahk_group notkeep")
msgbox, kyllä
else
msgbox, ei
Return

^!ä::
SetTitleMatchMode, 1
GroupAdd, notkeep,ahk_class Chrome_WidgetWin_1, , ,Google Keep
if WinActive("ahk_group notkeep")
{
WinGet, num, count,ahk_group notkeep
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinSet, Bottom,, A
WinActivate, ahk_group notkeep
Return
}
}
else if WinExist("ahk_group notkeep")
    WinActivate
else
    Run, chrome.exe
Return


