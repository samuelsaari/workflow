;Workflow for Stata - shortcuts to make life easier with Autohotkey (1/2)

; the code won't work if parts 1 & 2 are in the same script

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

<#z:: 
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

<#a:: 
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