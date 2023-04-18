^!k::
if (WinActive("Data Editor") && WinExist(Do-file))
{
msgbox, WinActivate Do-file
}
else if WinActive("Data Editor")
{
msgbox, WinActivate Stata
}
else
{}
Return

^!j::
If (WinActive("Data Editor") && WinExist(Stata) && !WinExist("Do-file"))
{
	WinActivate,Stata
	Return
}
If (WinActive("Data Editor") && WinExist(Stata) && WinExist("Do-file"))
{
	WinActivate,Do-file
	Return
}
else if WinExist("Data Editor")
{
	WinActivate, Data Editor
	Return
}
Return