
^!j::
WinGet, num, count,ahk_class CabinetWClass
msgbox, %num%
Return

^!h::
;EXPLORER
;NB! Unrobust
<!a::
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
Sleep, 100
Return
}
}
else
Sleep, 10
Send, {Lwin down}{3 down}{3 up}
Sleep, 100
Send, {Lwin up}
Return


