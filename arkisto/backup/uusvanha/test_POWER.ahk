^!y::
;if WinActive("ahk_exe powerpnt.exe") {
WinGet, num, count,A
If %num%=1
msgbox, yksi
else
msgbox, ei yksi
Return
;
;else
;Msgbox, powerpoint ei aktiivinen

