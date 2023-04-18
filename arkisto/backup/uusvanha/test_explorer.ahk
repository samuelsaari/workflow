^!q::
WinGet, num, count,ahk_class CabinetWClass
msgbox, ikkunoita %num% kpl


;EXPLORER
;NB! Unrobust
^!w::
if WinActive("ahk_class CabinetWClass")
{
WinGet, num, count,ahk_class CabinetWClass
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
} else 
{
WinGetClass, OutputVar , A
WinSet, Bottom,, A
WinActivate, ahk_class %OutputVar%
Return
}
}
else
Sleep, 10
Send, {Lwin down}
Sleep, 10
Send, {alt up}#3
Sleep, 100
Send, {Lwin up}
Sleep, 10
Return