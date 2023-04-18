

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;run or activate - robust
roar(ID_1,TARGET_1,EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
{
;;Creating a group;;
SetTitleMatchMode, 1
GroupAdd, this_group8, %ID_1%
;GroupAdd, this_group8, %ID_2%
extitle_str:= % EX_TITLE
GroupAdd, this_group7, ahk_group this_group8, , ,%extitle_str%
GroupAdd, this_group,ahk_group this_group6, , , , %EX_AHK%

;;if one window, minimize or maximize;;
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

;;if multiple windows, toggle;;
{

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

;;in other cases when window exists, activate;;
}
else if WinExist("ahk_group this_group")
    WinActivate
else
;;;;;;;;in other cases when window exists, run;;;;;;;;
{	
	try {
		;t_one:= % TARGET_1
		;Run, %t_one%
		Run, %TARGET_1%
	} catch e {
		Run, %TARGET_2%
	}
WinWait, ahk_group this_group,,2
WinActivate, ahk_group this_group
}
Return
}

;roa7(IDENTIFIER,TARGET_ONE,EX_TITLE:="",EX_AHK:="", TARGET_TWO:="notepad.exe")
; Run, %TARGET_THREE%
;!.::roa7("ahk_exe chrome.exe","chrome.exe",EX_TITLE:="Google Keep")
!.::roar("ahk_class MozillaWindowClass", "firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe")
;^!p::roar(ID_1:="ahk_exe spotify.exe",TARGET_1:="C:\Users\%A_Username%\AppData\Roaming\Spotify\Spotify.exe", TARGET_TWO:="C:\Users\%A_Username%\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
!x::roar("Zoom", TARGET_1:="C:\Users\mmak\AppData\Roaming\Zoom\bin\Zoom.exe")
^!o::roar("ahk_exe opera.exe", "opera.exe")
^!a::("ahk_class CabinetWClass", "explorer.exe")

^!c::
{
SetTitleMatchMode, 1
	if WinExist("Zoom")
		if WinActive()
			WinMinimize
		else
			WinActivate
	else
		Run, C:\Users\%A_Username%\AppData\Roaming\Zoom\bin\Zoom.exe
	return
}

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




