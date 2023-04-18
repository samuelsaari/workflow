roar(ID_1,TARGET_1="",EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
{

;MsgBox, Creating a group;;;;;

SetTitleMatchMode, 1
;now_group= this_group%A_MSec%
;MsgBox, this_group%A_MSec%
;this_group=%A_MMM%%A_DDD%%A_Hour%%A_Min%%A_MSec%
;MsgBox, %this_group%
GroupAdd, this_group, %ID_1%
extitle_str:= % EX_TITLE
;GroupAdd, this_groupB, ahk_group this_groupA, , ,%extitle_str%
;GroupAdd, this_group,ahk_group this_groupB, , , , %EX_AHK%

;;if one window, minimize or maximize;;
if WinActive("ahk_group this_group")
{
;MsgBox, is active
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
;MsgBox, multiple windows
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
else if WinExist("ahk_group this_group") {
    WinActivate
	;MsgBox, winexists
}
else
;;;;;;;;in other cases when window exists, run;;;;;;;;
{	
	try {
		;t_one:= % TARGET_1
		;Run, %t_one%
		MsgBox, trying to run 1
		Run, %TARGET_1% ; possibly % TARGET_1 with a username
	} catch e {
		MsgBox, trying to run 2
		Run, %TARGET_2%
	}
;MsgBox, waiting
WinWait, ahk_group this_group,,2
WinActivate, ahk_group this_group
}
Return
}


;;;;;;;;;;;;;;;;



minimaxi(ID_1,TARGET_1="",EX_TITLE:="")
{
SetTitleMatchMode, 1
this_group=%A_DDD%%A_YDay%%A_Hour%%A_Min%%A_MSec%  
;this_group:=% this_group
MsgBox, %this_group%
extitle_str:= % EX_TITLE 						 	
GroupAdd, %this_group%, %ID_1%,,,%extitle_str%      ; works
if WinExist("ahk_group" . this_group)				; works
WinActivate, ahk_group %this_group%					; works
Return
}

^!SHIFT::minimaxi("ahk_exe chrome.exe", "chrome.exe", "Google Keep")
^!o::minimaxi("ahk_exe opera.exe", "opera.exe")


;roa7(IDENTIFIER,TARGET_ONE,EX_TITLE:="",EX_AHK:="", TARGET_TWO:="notepad.exe")
; Run, %TARGET_THREE%
;!.::roa7("ahk_exe chrome.exe","chrome.exe",EX_TITLE:="Google Keep")
!.::roar("ahk_class MozillaWindowClass", "firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe")
;^!p::roar(ID_1:="ahk_exe spotify.exe",TARGET_1:="C:\Users\%A_Username%\AppData\Roaming\Spotify\Spotify.exe", TARGET_TWO:="C:\Users\%A_Username%\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
<!x::roar("Zoom") ; %A_Username%
<^!d::roar("ahk_exe teams.exe") ;"C:\Users\mmak\AppData\Local\Microsoft\Teams\Update.exe --processStart Teams.exe"

;^!a::roar("ahk_class CabinetWClass", "explorer.exe") 
<^!m::roar("ahk_class Notepad++", "notepad++.exe")
<^!p::roar("ahk_exe spotify.exe")






^!2::
{
total++
MsgBox, %total%
Return 
}

test()
{
total++
MsgBox, %total%
Return 
}

^!1::test()

/*
minimaxi(ID_1,TARGET_1="",EX_TITLE:="")
{
SetTitleMatchMode, 1
this_group=%A_MMM%%A_DDD%%A_Hour%%A_Min%%A_MSec%  ; how to get this value to serve as a group name?
MsgBox, %this_group%
extitle_str:= % EX_TITLE 						  ; this title will be excluded
GroupAdd, this_group, %ID_1%,,,%extitle_str%      ; ????????
if WinExist("ahk_group this_group") {             ; ????????
	WinGet,WinState,MinMax,ahk_group this_group   ; ????????
	If WinState = -1
		WinMaximize
	else
		WinMinimize
	}
Return
}
*/




/*
now_group= this_group%A_MSec%
MsgBox, this_group%A_MSec%
GroupAdd, this_group, %ID_1%
*/



/*
;;;;;;;;;;;;;;;;;;;;;;
roarX(ID_1,TARGET_1:="",EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
{
;MsgBox, Creating a group ;;;;;
SetTitleMatchMode, 1
; creating a unique group name (at them moment cannot reset groups in ahk, it is available in future versions)
;group_name:=RandomStr()
group_name9:=% group_name "9"
group_name8:=% group_name "8"
MsgBox, %group_name9% %group_name8% %group_name%
GroupAdd, %group_name9%, %ID_1%
extitle_str:= % EX_TITLE
;GroupAdd, group_name8, ahk_group group_name9, , ,%extitle_str%
;GroupAdd, group_name,ahk_group group_name8, , , , %EX_AHK%
;;if one window, minimize or maximize;;
if WinActive("ahk_group this_group")
{
;MsgBox, is active
WinGet, num, count,ahk_group this_group
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else
;;exist but not active
{
;MsgBox, exists but not active
/*
WinGet, WinClassCount, Count, ahk_group this_group
IF WinClassCount = 1
    Return
Else

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
else if WinExist("ahk_group this_group") {
    WinActivate
	;MsgBox, winexists
}
else
;;;;;;;;in other cases when window exists, run;;;;;;;;
{	
	try {
		MsgBox, trying to run 1
		if (ID_1 == "Zoom") {
			MsgBox, zoom lauch
			;Run, "C:\Users\%A_Username%\AppData\Roaming\Zoom\bin\Zoom.exe"
			Run, "%A_AppData%\Zoom\bin\Zoom.exe"
		} else if (ID_1 == "ahk_exe teams.exe") {
			MsgBox, teams launch
			Run, C:\Users\%A_Username%\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"
		} else if (ID_1 == "ahk_exe spotify.exe") {
			MsgBox, spotify launch
			Run, "C:\Users\%A_Username%\AppData\Roaming\Spotify\Spotify.exe"
		} else {
			Run, %TARGET_1% ; possibly % TARGET_1 with a username
		}
	} catch e {
		MsgBox, trying to run target_2
		if (ID_1=="Zoom") {
			MsgBox, alternative path not specified
		} else {
		Run, %TARGET_2%
		}
	}
;MsgBox, waiting
WinWait, ahk_group this_group,,2
WinActivate, ahk_group this_group
}
Return
}
*/
