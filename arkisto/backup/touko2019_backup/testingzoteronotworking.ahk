;ZOTERO
<!e:: 
if (WinActive("Zotero") && WinExist("Quick Format Citation"))
	{
	WinActivate, Quick Format Citation
	Return
	}
if (WinActive("Zotero") && !WinExist("Quick Format Citation"))
{
WinGet,WinState,MinMax,Zotero
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("Quick Format Citation") && WinExist("Zotero")) 
	{
	WinActivate, Zotero
	Return
	}
else if (WinExist("Zotero") && WinExist("Quick Format Citation"))
	{
    	WinActivate, Zotero
	Return
	}
else if WinExist("Zotero")
	Winactivate
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return