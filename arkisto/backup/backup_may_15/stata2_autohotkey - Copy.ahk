;;;;;;;;;;;
;DATA EDITOR

<#q::
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;
;VIEWER

<#a:: 
If (WinActive("Viewer") && WinExist(Stata) && !WinExist("Do-file"))
{
	WinActivate,Stata
	Return
}
If (WinActive("Viewer") && WinExist(Stata) && WinExist("Do-file"))
{
	WinActivate,Do-file
	Return
}
else if WinExist("Viewer")
{
	WinActivate, Viewer
	Return
}
Return

;;;;;;;;;
;GRAPH

<#z:: 
If (WinActive("Graph") && WinExist(Stata) && !WinExist("Do-file"))
{
	WinActivate,Stata
	Return
}
If (WinActive("Graph") && WinExist(Stata) && WinExist("Do-file"))
{
	WinActivate,Do-file
	Return
}
else if WinExist("Graph")
{
	WinActivate, Graph
	Return
}
Return

;;;;;;;;;