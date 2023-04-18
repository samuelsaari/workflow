^!l::
WinGet, num, count,A
if num=1
msgbox, yksi
else
msgbox, ei yksi

Return

^!s::
WinGet,WinState,MinMax,A
msgbox,%winstate%
Return

