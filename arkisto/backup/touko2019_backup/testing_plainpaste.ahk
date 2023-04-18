;plainpaste microsoft
#If (WinActive("ahk_exe outlook.exe") or WinActive("ahk_exe winword.exe"))
$^$+$v::
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{down}{pause}{enter}
Return
#IfWinActive

#IfWinActive ahk_exe powerpnt.exe
$^$+$v::
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{tab}{pause}{down}{down}{pause}{enter}
Return
#IfWinActive






/*
;toimii
;plainpaste microsoft
$^$+$v::
If (WinActive("ahk_exe outlook.exe") or WinActive("ahk_exe winword.exe"))
{
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{down}{pause}{enter}
Return
}
If WinActive("ahk_exe powerpnt.exe")
{
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{tab}{pause}{down}{down}{pause}{enter}
Return
}
else
{
Send, {Control down}{Shift down}v{Control up}{Shift up}
Return
}
Return
*/