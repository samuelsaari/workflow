;Firefox
roa2(WINTITLE)
{
SetTitleMatchMode, 1
donts := "Quick Format Citation,ahk_exe zotero.exe"
DontArray := StrSplit(donts, ",")
Loop % DontArray.MaxIndex()
{
    this_dont := DontArray[A_Index]
	GroupAdd, %WINTITLE%, ahk_class MozillaWindowClass, , , ,%this_dont%
	;MsgBox, Color number %A_Index% is %this_dont%.
}

if WinActive("ahk_group %WINTITLE%") 
{
WinGet, num, count,ahk_group %WINTITLE%
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
GroupActivate, %WINTITLE%, R
Return
}
}
else if WinExist("ahk_group %WINTITLE%")
    WinActivate
else
{	
	MsgBox active
	Run, %WINTITLE%.exe
	WinWait, ahk_group %WINTITLE%
	WinActivate, ahk_group %WINTITLE%
}
Return
}

roa3(WINTITLE)
{
Run, %WINTITLE%.exe
;WinActivate, ahk_exe firefox
Return
}

<!g::roa2("firefox")
<!h::roa3("firefox")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,

;Firefox 
roa5(WINTITLE, MYGROUP,DONTLIST)
{
SetTitleMatchMode, 1

donts := % DONTLIST
DontArray := StrSplit(donts, ",")
Loop % DontArray.MaxIndex()
{
    this_dont := DontArray[A_Index]
	GroupAdd, this_group, %MYGROUP%, , , ,%this_dont%
	;MsgBox, Color number %A_Index% is %this_dont%.
}

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
{
GroupActivate, this_group, R
Return
}
}
else if WinExist("ahk_group this_group")
    WinActivate
else
{	
	Run, %WINTITLE%.exe
	WinWait, ahk_group this_group
	WinActivate, ahk_group this_group
}
Return
}

!u::roa5("firefox","ahk_class MozillaWindowClass","Quick Format Citation,ahk_exe zotero.exe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
;Firefox 
roa7(IDENTIFIER,TARGET_ONE, TARGET_TWO, DONTLIST)
{
;;;;;;;;Creating a group;;;;;;;;;
SetTitleMatchMode, 1
donts := % DONTLIST
DontArray := StrSplit(donts, ",")
Loop % DontArray.MaxIndex()
{
    this_dont := DontArray[A_Index]
	GroupAdd, this_group, %IDENTIFIER%, , , ,%this_dont%
	;MsgBox, Color number %A_Index% is %this_dont%.
}
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
; Run, %TARGET_THREE%
;!.::roa7("ahk_class MozillaWindowClass","notepad.exe","winword.exe","Quick Format Citation,ahk_exe zotero.exe")
;!.::roa7("ahk_exe chrome.exe","chrome.exe","chrome.exe","Google Keep,Google Keep")






















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/*
roa6(WINTITLE, MYGROUP,DONTLIST)
{

SetTitleMatchMode, 1
donts := % DONTLIST
DontArray := StrSplit(donts, ",")
Loop % DontArray.MaxIndex()
{
    this_dont := DontArray[A_Index]
	GroupAdd, this_group, %MYGROUP%, , , ,%this_dont%
	;MsgBox, Color number %A_Index% is %this_dont%.
}

if !Winexist("ahk_group this_group")
	{	
	Run, %WINTITLE%.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
	;Winmaximize, ahk_pid %OutputVarPID%
	Return
	}
		if WinExist("ahk_group this_group") && !WinActive("ahk_group this_group")
		{
		WinActivate, ahk_group this_group
		Return
		}
if WinActive("ahk_group this_group")
	{
	WinGet, num, count,ahk_group this_group
		if num=1 
		{
		WinGet,WinState,MinMax,ahk_group this_group
		If WinState = -1
		WinMaximize
		else
		WinMinimize
		Return
		} else
			{
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
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
	}
Return
}


^!i::roa5("firefox","ahk_class MozillaWindowClass","Quick Format Citation,ahk_exe zotero.exe")

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Firefox (toimii)
roa4(WINTITLE, MYGROUP,DONTLIST)
{
SetTitleMatchMode, 1

donts := % DONTLIST
DontArray := StrSplit(donts, ",")
Loop % DontArray.MaxIndex()
{
    this_dont := DontArray[A_Index]
	GroupAdd, this_group, %MYGROUP%, , , ,%this_dont%
	;MsgBox, Color number %A_Index% is %this_dont%.
}

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
{
GroupActivate, this_group, R
Return
}
}
else if WinExist("ahk_group this_group")
    WinActivate
else
{	
	Run, %WINTITLE%.exe
	WinWait, ahk_group this_group
	WinActivate, ahk_group this_group
}
Return
}

^!h::roa4("firefox","ahk_class MozillaWindowClass","Quick Format Citation,ahk_exe zotero.exe")

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;

;Firefox (toimii)
^!j::
SetTitleMatchMode, 1

donts := "Quick Format Citation,ahk_exe zotero.exe"
DontArray := StrSplit(donts, ",")
Loop % DontArray.MaxIndex()
{
    this_dont := DontArray[A_Index]
	GroupAdd, firefox, ahk_class MozillaWindowClass, , , ,%this_dont%
	;MsgBox, Color number %A_Index% is %this_dont%.
}

if WinActive("ahk_group firefox")
{
WinGet, num, count,ahk_group firefox
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
GroupActivate, FIREFOX, R
Return
}
}
else if WinExist("ahk_group firefox")
    WinActivate
else
{	
	Run, firefox.exe
	WinWait, ahk_group firefox
	WinActivate, ahk_group firefox
}
Return

^!u::
car:="truck"
blue:="red"
own:="sold"
I:="You"
a:="the"
MsgBox,,1, I own a blue car
MsgBox,,2, "I own a blue car"
MsgBox,,3, % I own a blue car
MsgBox,,4, % I " " own " " a " " blue " " car ; this includes literal strings of spaces
MsgBox,,5, % "I own a blue car"
return