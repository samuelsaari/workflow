

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
;Firefox 
roa7(IDENTIFIER,TARGET_ONE,EX_TITLE:="",EX_AHK:="", TARGET_TWO:="notepad.exe")
{
;;;;;;;;Creating a group;;;;;;;;;
SetTitleMatchMode, 1
GroupAdd, this_group9, %IDENTIFIER%
extitle_str:= % EX_TITLE
GroupAdd, this_group8, ahk_group this_group9, , ,%extitle_str%
GroupAdd, this_group,ahk_group this_group8, , , , %EX_AHK%

;;;;;;;;if one window, minimize or maximize;;;;;;;;
if WinActive("ahk_group this_group")
{
WinGet, num, count,ahk_group this_group
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 

;;;;;;;;if multiple windows, toggle;;;;;;;;

{
;WinGetClass, ActiveClass, A
;WinGet, WinClassCount, Count, ahk_group this_group
;IF WinClassCount = 1
;    Return
;Else
WinGet, List, List, ahk_group this_group
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return
}

;;;;;;;;in other cases when window exists, active;;;;;;;;
}
else if WinExist("ahk_group this_group")
    WinActivate
else
;;;;;;;;in other cases when window exists, active;;;;;;;;
{	
	try {
		Run, %TARGET_ONE%
	} catch e {
		Run, %TARGET_TWO%
	}
WinWait, ahk_group this_group,,2
WinActivate, ahk_group this_group
}
Return
}

;roa7(IDENTIFIER,TARGET_ONE,EX_TITLE:="",EX_AHK:="", TARGET_TWO:="notepad.exe")
; Run, %TARGET_THREE%
;!.::roa7("ahk_exe chrome.exe","chrome.exe",EX_TITLE:="Google Keep")
!.::roa7("ahk_class MozillaWindowClass", "ahk_exe firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe")

; Quick Format Citation
;EX_AHK:="ahk_exe zotero.exe"
;EX_AHK:="ahk_exe zotero.exe"
/*
SetTitleMatchMode, 1
donts := % DONTLIST
If InStr(donts,",") { ; checking if there are more than one dont-condition
    DontArray := StrSplit(donts, ",")
	Loop % DontArray.MaxIndex()
	{
		this_dont := DontArray[A_Index]
		GroupAdd, this_group, %IDENTIFIER%, , , %this_dont%
		;MsgBox, Color number %A_Index% is %this_dont%.
	}
} Else {
    DontArray := donts
	GroupAdd, this_group, %IDENTIFIER%, , , %this_dont%
}
*/




