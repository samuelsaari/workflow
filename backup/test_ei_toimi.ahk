
stroke_count := 0

roar(ID_1,TARGET_1="",EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
{
stroke_count := stroke_count + 1
;MsgBox, Creating a group;;;;;
MsgBox, %stroke_count%
SetTitleMatchMode, 1

GroupAdd, this_groupA, %ID_1%
extitle_str:= % EX_TITLE
GroupAdd, this_groupB, ahk_group this_groupA, , ,%extitle_str%
GroupAdd, this_group,ahk_group this_groupB, , , , %EX_AHK%

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





;roa7(IDENTIFIER,TARGET_ONE,EX_TITLE:="",EX_AHK:="", TARGET_TWO:="notepad.exe")
; Run, %TARGET_THREE%
;!.::roa7("ahk_exe chrome.exe","chrome.exe",EX_TITLE:="Google Keep")
!.::roar("ahk_class MozillaWindowClass", "firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe")
;^!p::roar(ID_1:="ahk_exe spotify.exe",TARGET_1:="C:\Users\%A_Username%\AppData\Roaming\Spotify\Spotify.exe", TARGET_TWO:="C:\Users\%A_Username%\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
<!x::roar("Zoom") ; %A_Username%
<^!d::roar("ahk_exe teams.exe") ;"C:\Users\mmak\AppData\Local\Microsoft\Teams\Update.exe --processStart Teams.exe"
^!o::roar("ahk_exe opera.exe", "opera.exe")
;^!a::roar("ahk_class CabinetWClass", "explorer.exe") 
<^!m::roar("ahk_class Notepad++", "notepad++.exe")
<^!p::roar("ahk_exe spotify.exe")




MsgBox, % RegExReplace(RandomStr(), "\W", "i") ; only alphanum.

RandomStr(l = 10, i = 97, x = 122) { ; length, lowest and highest Asc value
	Loop, %l% {
		Random, r, i, x
		s .= Chr(r)
	}
	Return, s
}

^!y::
group_name:=RandomStr()
MsgBox, % group_name "1"
MsgBox, % group_name "2"


















;;;;;;;;;;;;;;;;;;;;;;
roarX(ID_1,TARGET_1:="",EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
{
;MsgBox, Creating a group ;;;;;
SetTitleMatchMode, 1
; creating a unique group name (at them moment cannot reset groups in ahk, it is available in future versions)
group_name:=RandomStr()
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
*/
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


;;;;;;;;;;;;;;;;;;; https://autohotkey.com/board/topic/8613-removing-windows-from-a-group-or-deleting-a-group/#entry131771

WinGroup(Cmd,ByRef GroupName,WinTitle= "",WinText= "",Label= "",ExcludeTitle= "",ExcludeText= "")
{
   Static WinGroupA:= "",WinGroupB:= "",WinGroupC:= "",WinGroupD:= "",WinGroupE:= ""      ; list of windows in the group
   Static WinGroupF:= "",WinGroupG:= "",WinGroupH:= "",WinGroupI:= "",WinGroupJ:= ""      ; list of windows in the group
   Static MaxGroups:= 10,FreeGroupIndex:= 1 ; first not used Group number

   If (Cmd= "add") {
      If (FreeGroupIndex> MaxGroups) {
         MsgBox,48,%A_ScriptName% - %A_thisFunc%,MaxGroups= %MaxGroups%!
         Return true    ; error
      }

      WinGroupName:= WinGroupName(GroupName)
      StringReplace, GroupIndex, WinGroupName, Dummy
      If errorlevel {    ; ->new group
         If (FreeGroupIndex< 27) {
            GroupIndex:= Chr(64 + FreeGroupIndex)
            GroupName:= "Dummy" GroupIndex "1"  ; -> GroupName= DummyA1 (or DummyB1,DummyC1,...)
            FreeGroupIndex++
         }
         else {
            MsgBox,48,%A_ScriptName% - %A_thisFunc%,Max. 26 groups allowed!
            Return true
         }
      }
      AddParameters:= WinTitle "," WinText "," Label "," ExcludeTitle "," ExcludeText "|"
      If InStr(WinGroup%GroupIndex%,AddParameters)
         Return false    ; don't add already existing windows
      else {
         WinGroup%GroupIndex% .= AddParameters
         GroupAdd, %GroupName%,%WinTitle%,%WinText%,%Label%,%ExcludeTitle%,%ExcludeText%
      }
      Return false
   }

   If (Cmd= "remove" || Cmd= "clear") {
      WinGroupName:= WinGroupName(GroupName,NewNameIndex)   ; e.g. WinGroup("DummyB21",...) ->DummyB and 21
      StringReplace, GroupIndex, WinGroupName, Dummy
      NewNameIndex++     ; ->GroupName DummyA1 becomes DummyA2 for remove command
      GroupName= %WinGroupName%%NewNameIndex%    ; assign new content (=name) to GroupName
      ; I.e. return to ByRef GroupName parameter too
      WinGroupTmp:= WinGroup%GroupIndex%
      WinGroup%GroupIndex%:= ""      ; clear to make new list by WinGroup("add",...)
      If (Cmd= "clear")
         Return false     ; finished re-add nothing to GroupName

      RemoveParameters= %WinTitle%,%WinText%,%Label%,%ExcludeTitle%,%ExcludeText%|
      StringReplace, WinGroupTmp, WinGroupTmp, %RemoveParameters%
      RemoveError:= errorlevel
      Loop, parse,WinGroupTmp,|
      {
         If (A_loopField= "")
            Continue

         Loop, parse,A_loopField,csv
         {
            If  (A_index= 1)
               ReAddTitle:= A_loopField
            else
            If  (A_index= 2)
               ReAddText:= A_loopField
            else
            If  (A_index= 3)
               ReAddLabel:= A_loopField
            else
            If  (A_index= 4)
               ReAddExcludeTitle:= A_loopField
            else
            If  (A_index= 5)
               ReAddExcludeText:= A_loopField
         }
         WinGroup("add",GroupName,ReAddTitle,ReAddText,ReAddLabel,ReAddExcludeTitle,ReAddExcludeText)
      }
      Return RemoveError
   }

}

WinGroupName(GroupName,ByRef NameIndex= "")
{
   ; Makes from e.g. DummyB23 -> AlphaName= DummyB  NameIndex= 23
   Loop {
      Char:= SubStr(GroupName,1 - A_index,1)
      If Char is alpha
      {
         AlphaName:= SubStr(GroupName,1,StrLen(GroupName) -A_index+1)
         NameIndex:= SubStr(GroupName,2 - A_index)
         ; Here always A_index > 1  (GroupName starts with e.g. DummyB1)
         Break
      }
   }
   Return AlphaName
}


;;;;;;;;;;;;;;;;;;;;;;;;;;,


















;https://www.autohotkey.com/boards/viewtopic.php?f=6&t=60272
;Uses a combined list & array Groups index,for ease of use & efficiency,respectively.

GroupAdd("mediaPlayers", "ahk_exe vlc.exe", "ahk_exe mpc-hc.exe")
;GroupDelete("mediaPlayers")

;create new group and make it a 'real' group...
GroupAdd("browsers", "ahk_exe chrome.exe", "ahk_exe firefox.exe")GroupTranspose("browsers")
SetTimer, listGroups, 300
;toogle group member
x::IsInGroup("mediaPlayers","vlc.exe") ? GroupDelete("mediaPlayers", "ahk_exe vlc.exe") : GroupAdd("mediaPlayers", "ahk_exe vlc.exe")

;(de)activate a group... of course group members can't be removed from the transposed 'real' group,only from the custom group they were inherited from...
a::GroupActivate % GroupTranspose("browsers")
d::GroupDeactivate % GroupTranspose("browsers")

#If GroupActive("mediaPlayers")
g::MsgBox 0x40040,, MEDIA PLAYER GROUP ACTIVE
#If

#IfWinActive ahk_group browsers	;Custom Group transformed to real group...
g::MsgBox 0x40040,, BROWSER GROUP ACTIVE
#IfWinActive

listGroups:
ToolTip % A_Groups "`n`n" GroupActive("mediaPlayers") "`n" GroupActive("browsers")
Return

;====================================================================================================

GroupAdd(groupName,groupMembers*){
	Global A_Groups,A_GroupsArr
	( !InStr(A_Groups, groupName ",") ? (A_Groups .= A_Groups ? "`n" groupName "," : groupName ",") : "" )	;initialise group if it doesn't exist...
	For i,groupMember in groupMembers
		( !InStr(A_Groups, groupMember) ? (A_Groups := StrReplace(A_Groups, groupName ",", groupName "," groupMember ",")) : )	;append to or create new group...
	A_Groups := RegExReplace(RegExReplace(A_Groups, "(^|\R)\K\s+"), "\R+\R", "`r`n")	;clean up groups to remove any possible blank lines
	,ArrayFromList(A_GroupsArr,A_Groups)	;rebuild group as array for most efficient cycling through groups...
}

GroupDelete(groupName, groupMember:=""){
	Global A_Groups,A_GroupsArr
	For i,group in StrSplit(A_Groups,"`n")
		( groupMember && group && InStr(A_Groups,groupMember) && groupName = StrSplit(group,",")[1] ? (A_Groups:=StrReplace(A_Groups,group,StrReplace(group,groupMember ","))) : !groupMember && groupName = StrSplit(group,",")[1] ? (A_Groups:=StrReplace(A_Groups,group))  )	;remove group member from group & update group in A_Groups
	A_Groups := RegExReplace(RegExReplace(A_Groups, "(^|\R)\K\s+"), "\R+\R", "`r`n")	;clean up groups to remove any possible blank lines
	,ArrayFromList(A_GroupsArr,A_Groups)	;rebuild group as array for most efficient cycling through groups...
}

ArrayFromList(ByRef larray, ByRef list, listDelim := "`n", lineDelim:=","){
	larray := []
	Loop, Parse, list, % listDelim
		larray.Push(StrSplit(A_LoopField,lineDelim))
}

;Function's below are subject to a performance overhead & hence use A_GroupsArr...as they are repeatedly called...
GroupActive(groupName){
	Global A_GroupsArr
	For i,group in A_GroupsArr
		If (group.1 = groupName)
			For iG,groupMember in group
				If (iG > 1 && groupMember && (firstMatchId := WinActive(groupMember)))
					Return group.1 "," firstMatchId
}

GroupTranspose(groupName){	;makes this custom group,a 'real' group,some use cases....
	Global A_GroupsArr
	For i,group in A_GroupsArr
		If (group.1 = groupName)
			For iG,groupMember in group
				If (iG > 1 && groupMember)
					GroupAdd, % group.1, % groupMember
	Return groupName
}

IsInGroup(groupName, groupMember){
	Global A_Groups
	Loop, Parse, A_Groups, `n
		If (StrSplit(A_LoopField,",")[1] = groupName && InStr(A_LoopField,groupMember))
			Return True
}

;====================================================================================================


