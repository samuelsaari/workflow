

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Windows workflow
;;;; Author: Miika Mäki

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0. Quick Guide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; # = Win-key
;;;; <#= Left win-key
;;;; + = Shift
;;;; ^ = Ctrl
;;;; ! = Alt
;;;; <!= Left Alt-key
;;;; $ = will not fire any key but will prevent the hotkey itself from firing
;;;;
;;;; Complete Guide for hotkeys:	https://autohotkey.com/docs/Hotkeys.htm
;;;;                    	 		https://autohotkey.com/docs/KeyList.htm
;;;;
;;;; Syntax Highlighting 
;;;; & Auto-Completion:				https://www.autohotkey.com/boards/viewtopic.php?f=7&t=50		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0. General Windows - simple typing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;0.1 Matrix multiplication in Rstudio - shorcut for %*%
#IfWinActive ahk_exe rstudio.exe
<!'::
Send,{SHIFT DOWN}5'5{SHIFT UP}
Return
#IfWinActive

;0.2 Text stutio

; typing \keys
#IfWinActive ahk_exe texstudio.exe
<^k::
;Send, keys
Send,  {\}keys{{}{}}{left}
;Send, {left}
Return
#IfWinActive

;;;;;;;;;;;;
; email formalities

;formal tone
<^<!f::
Send,I hope this message finds you well{.}{Enter}{Enter}{Enter}{Enter}
Send,Wishing you a great day ahead.{Enter}{Enter}
Send,Kind regards{,}{Enter}{Up}{Up}{Up}{Up}{Up}
Return

;informal tone
<^<!i::
Send,I hope your day is off to a good start{.}{Enter}{Enter}{Enter}{Enter}
Send,Have a good one{!}{Enter}{Enter}
Send,Take care{,}{Enter}{Up}{Up}{Up}{Up}{Up}
Return

;[FLH-THESIS]
<^<!t::
Send,[FLH-THESIS]
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1.1 Roar - or Run or Activate (Robust) function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Credit and simplified version of the functions
;https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/



;RunOrActivate(Robust) function
roar(ID_1,TARGET_1="",EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
;-------------------------------------------------------------------------------
;
; Toggles, Activates, Minimizes, Restores, or Runs program windows based on the whether the applications are running, how many windows there are and what state they are at
;
;ID_1		= 1st critria to identify an existing window
;TARGET_1	= executable program or a path to it
;EX_TITLE	= exclude windows with titles that start with a given string
;EX_AHK		= exclude processes (eg. ahk_exe firefox.ex) or strings in a window
;TARGET_2	= alternative path to an excecutable file (if for example the paths are different in different machines you use)
;ID_2 = 	= 2nd criteria to identify an existing window (not implemented yet)
;-------------------------------------------------------------------------------
{
;Creating groups with a uniques names;
	SetTitleMatchMode, 1
	this_group=%A_DDD%%A_YDay%%A_Hour%%A_Min%%A_MSec%
	this_group1=% this_group "1"
	this_group2=% this_group "2"
	GroupAdd, %this_group1%, %ID_1%											;first criterion to include
	extitle_str:= % EX_TITLE
	GroupAdd, %this_group2%,ahk_group %this_group1%, , ,%extitle_str%		;exclude based on title
	GroupAdd, %this_group%,ahk_group %this_group2%, , , , %EX_AHK%			;exclude based on content (ahk_process)
; checking if the windows is active
	if WinActive("ahk_group" . this_group) {
		WinGet, num, count,ahk_group %this_group%
		;MsgBox, %num%
		; if only one window minimize or maximize
		if (num==1) || (ID_1=="ahk_exe spotify.exe")						; for some reason it identifies 3 windows for spotify
			{
			WinGet,WinState,MinMax,ahk_group %this_group%
			If WinState = -1 
				WinRestore ;was WinMaximize	
				; MsgBox, winstate -1
			 else 
				WinMinimize
				;MsgBox, winstate up front
			} 
		; if multiple windows, toggle
		else 
		{
		;msgbox, multiple windows
		WinGet, List, List, ahk_group %this_group%
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
; activate window if exists but not active
	else if WinExist("ahk_group" . this_group) {
		;msgbox, activate window
		WinActivate
	}
; if window does not exist, run the target
	else
	{	
		try {
			If InStr(TARGET_1, "\")==1 {  
				Run, % UserProfile . TARGET_1
				;MsgBox, % TARGET_1
			} Else 
				Run, %TARGET_1%
		} catch e {
			MsgBox, Trying to run target_2
			If InStr(TARGET_2, "\")==1 {
				Run, % UserProfile . TARGET_2
			} Else 
				Run, %TARGET_2%
		}
	;MsgBox, waiting
	WinWait, ahk_group this_group,,2
	WinActivate, ahk_group this_group
	;WinMaximize, ahk_group this_group
	}
	Return
}



;Applying Roar to different apps
;---------------------------------------1234567890---------------------------------------
<!§::roar("ahk_exe winword.exe", "winword.exe") ; WORD
;<!1 - see stata-files 
<!2::roar("ahk_exe outlook.exe", "outlook.exe")
<!3::roar("ahk_exe acrord32.exe","acrord32.exe") ;ADOBE READER

;<!+ - see CaseCtrl

;---------------------------------------qwertyuiopå---------------------------------------
<!q::roar("ahk_exe excel.exe", "excel.exe")
<!w::roar("ahk_class PPTFrameClass", "powerpnt.exe")
;<!e - see section 2 for zotero maneouvers
<!y::roar("ahk_exe filezilla.exe", "filezilla.exe")
<!i::roar("Photos ahk_exe ApplicationFrameHost.exe","ms-photos:")
<!o::roar("ahk_exe opera.exe", "opera.exe")
<!p::roar("ahk_exe mspub.exe", "mspub.exe")


;--------------------------------------- asdfghjklöä-----------------------------------------
<!CAPSLOCK::roar("ahk_class MozillaWindowClass", "firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe")
<!a::roar("ahk_class CabinetWClass", "explorer.exe")
<!s::roar("ahk_exe code.exe", "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
<!d::roar("ahk_exe teams.exe", "\AppData\Local\Microsoft\Teams\Update.exe --processStart Teams.exe")

<!k::roar("Snip & Sketch ahk_class ApplicationFrameWindow", "ms-screenclip:?source=QuickActions")
;<!l::roar("ahk_exe texstudio.exe", "C:/Program Files (x86)/texstudio/texstudio.exe") ; NB!

;---------------------------------------zxcvbnm,.----------------------------------------
<!SHIFT::roar("ahk_exe chrome.exe", "chrome.exe", "Google Keep")
<!z::roar("Zoom","\AppData\Roaming\Zoom\bin\Zoom.exe") 
<!x::roar("ahk_exe rstudio.exe","rstudio.exe")
<!c::roar("ahk_exe powershell.exe", "powershell.exe") ; not sure how to execute anaconda powershell


<!n::roar("ahk_exe notepad.exe", "notepad.exe")
<!m::roar("ahk_class Notepad++", "notepad++.exe")


;---------------------------------------CtrlWinAltSPACE---------------------------------------
!LCtrl::roar(ID_1:="ahk_exe spotify.exe",TARGET_1:="\AppData\Roaming\Spotify\Spotify.exe", TARGET_2:="\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
<!LWin::roar("Google Keep", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://keep.google.com", TARGET_2:="C:\Program Files\Google\Chrome\Application\chrome.exe --app=https://keep.google.com")






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;2. Zotero & Word & other microsoft applications
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;2.1 plainpaste microsoft office
#If (WinActive("ahk_exe outlook.exe") or WinActive("ahk_exe winword.exe"))
$^$+$v::
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{down}{pause}{down}{pause}{down}{pause}{down}{pause}{enter}
Return
#IfWinActive

#IfWinActive ahk_exe powerpnt.exe
$^$+$v::
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{tab}{pause}{down}{down}{pause}{enter}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.2 Saving references to Zotero in firefox and chrome and other zotero functions





;NB! Work in progress
;VScode, citing and zotero
;Note that you can also assign shortcuts in VS Studio (file->preferences->keyboard shortcuts)
#IfWinActive, ahk_exe code.exe
;adding a citation -Citation picker zotero
<^!.::
Send, +!z
Return

<!u::
Send,if __name__ == "__main__":
Return



;typing citep
<^+.::
Send, \citep{{}{ctrl down}{shift down}{p}{ctrl up}{shift up}{pause}{pause}cite from{pause}{pause}{Enter}
Return 

#IfWinActive

;compiling latex
/* ^Enter::
Send, {ctrl down}{alt down}{b down}{b up}{alt up}{ctrl up}
Return */
;view pdf
/* ^+Enter::
Send, {ctrl down}{alt down}{v down}{v up}{alt up}{ctrl up}
Return */

<$^.::
If Winexist("Zotero")
{
Send, {ctrl down}{shift down}{p}{ctrl up}{shift up}{pause}{pause}cite from{pause}{pause}{Enter}
WinWait, Quick Format Citation
WinActivate, Quick Format Citation
Return
}
Else If WinExist("Quick Format Citation")
{
WinActivate, Quick Format Citation
Return
}
Else
{
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	;Sleep, 500
	WinActivate, ahk_exe code.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Send,{ctrl down}{shift down}{p}{ctrl up}{shift up}{pause}{pause}cite from{pause}{pause}{Enter}
	WinWait, Quick Format Citation
    WinActivate, Quick Format Citation
	Return
}
;}


#IfWinActive




; Adding zotero citation
#IfWinActive, ahk_exe firefox.exe
^+s::
If Winexist("ahk_exe zotero.exe")
{
Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Sleep, 500
	WinActivate, ahk_exe firefox.exe
	Sleep, 200
	Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
Return
#IfWinActive

#IfWinActive, ahk_exe chrome.exe
^+s::
If Winexist("ahk_exe zotero.exe")
{
Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Sleep, 500
	WinActivate, ahk_exe chrome.exe
	Sleep, 200
	Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;



;; -  Making word do Zotero related stuff with Ctrl & å - NB! change this to your key of liking

$^å::
If !WinActive("Quick Format Citation") && WinActive("ahk_class OpusApp") && Winexist("Zotero")
{
Send, ^!j ; this only works with the word macro (see the VBA script file)
Return
}
If !WinExist("Quick Format Citation") && WinActive("ahk_class OpusApp") && !Winexist("Zotero")
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_class OpusApp
	Sleep, 100
	Send, ^!j
	WinWait, Quick Format Citation
    WinActivate, Quick Format Citation
	Return
}
; Activate Quick format citation under certain conditions with Alt & r or suppress the author
If !WinActive("Quick Format Citation") && WinExist("Quick Format Citation") && !WinActive("ahk_class OpusApp")
<!r::
{
WinActivate, Quick Format Citation
Return
}
;Suppress Author
If WinActive("Quick Format Citation")
{
send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)
Return
}
Return


;Run or Active Zotero and quick format citation
<!e:: 
if (WinActive("ahk_exe zotero.exe") && WinExist("Quick Format Citation"))
	{
	WinActivate, Quick Format Citation
	Return
	}
if (WinActive("ahk_exe zotero.exe") && !WinExist("Quick Format Citation"))
{
WinGet,WinState,MinMax,ahk_exe zotero.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("Quick Format Citation") && WinExist("ahk_exe zotero.exe")) 
	{
	WinActivate, ahk_exe zotero.exe
	Return
	}
else if (WinExist("ahk_exe zotero.exe") && WinExist("Quick Format Citation"))
	{
    	WinActivate, ahk_exe zotero.exe
	Return
	}
else if WinExist("ahk_exe zotero.exe")
	Winactivate
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
;SetTitleMatchMode, 1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.3
;WORKAROUNDS FOR WORD THAT DOES NOT HAVE SPECIAL CHARACTERS OR SCANDINAVIAN LETTERS AS wdKeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NB! You need the VBA code for these to work

;ZoteroAddEditBibliography_SC
; press ctrl + Shift + B (built in in word, no ahk needed)


;Refresh bibliography
;note that word's own ctrl/alt/r works
#IfWinActive, ahk_exe winword.exe
$^+å::
Send, ^!r
Return
#IfWinActive

;Make paragraph green
; selecthighlight_SC
#IfWinActive, ahk_exe winword.exe
$^ö::
Send, ^!l
Return
#IfWinActive

;Remove color from paragraph
;selecthighlightR_SC
#IfWinActive, ahk_exe winword.exe
$^ä::
Send, ^!k
Return
#IfWinActive

;Select paragraph
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^¨::
Send, ^!n
Return
#IfWinActive

;Select paragraph, make normal
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^'::
Send, ^!i
Return
#IfWinActive

SetTitleMatchMode, 1


/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;; 4. TOGGLE WINDOWS OF ACTIVE PROGRAM - currently not in use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; Credit and simplified version of the functions
;https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/


;PREVIOUS WINDOW
§::    
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

;;;;;;;;; 
;Send to bottom
^§::    
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return

*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;; 5. OTHER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;NB! 
;Larger and smaller than with an american keyboard with Scandinavian settings

#,::
Send, <
Return


#.::
Send, >
Return

; Launch an autohotkey script


ahk_launch(ID_1, TARGET_1, TARGET_2:="")
{
DetectHiddenWindows, On
SetTitleMatchMode, 2
IfWinNotExist, %ID_1% 
	try {
		Run, % UserProfile . TARGET_1
	} catch e{
		Run, % UserProfile . TARGET_2
	}
SetTitleMatchMode, 1
Return
}

<^SPACE::ahk_launch("tooltip.ahk", "\OneDrive - University of Helsinki\Autohotkey\Useful_material\tooltip.ahk") ; change your path here


/*
<^SPACE::
;DetectHiddenWindows, On
SetTitleMatchMode, 2
IfWinNotExist, tooltip.ahk 
	try {
		Run, "%UserProfile%\OneDrive - University of Helsinki\Autohotkey\Useful_material\tooltip.ahk"
	} catch e{
		MsgBox, not implemented yet
	}
SetTitleMatchMode, 1
Return
*/





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 1.0 Windows run or activate commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;

;1.1.It is recommened to to pin programs to the taskbar in the following order.
; (1 Stata) 
; (2 Outlook)
; ...The hotkeys will work anyway but the build in function Win + (1 or 2) works quite nicely together with...
; ...the hotkeys I have assigned for Stata and Outlook.



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 1.2 Working with functions, but not with the ROAR function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



#IfWinNotActive, Program Manager ;this, and following prevents windows from getting rid of desktop items
#IfWinNotActive, "" 
#IfWinNotActive, ahk_class WorkerW
<!ESC::
WinClose A
Return
#IfWinNotActive


;NB! 
;CASE CONTROL - only for CaseCtrl, which is not available to the public
<!+:: 
if (WinActive("ahk_exe Dep.exe"))
{
WinGet,WinState,MinMax,ahk_exe Dep.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("ahk_exe BlaiseCaseControl.exe") && !WinExist("ahk_exe Dep.exe")) 
{
WinGet,WinState,MinMax, ahk_exe BlaiseCaseControl.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("ahk_exe BlaiseCaseControl.exe") && WinExist("ahk_exe Dep.exe")) 
	{
	WinActivate, ahk_exe Dep.exe
	Return
	}
else if (WinExist("ahk_exe Dep.exe") && WinExist("ahk_exe BlaiseCaseControl.exe"))
	{
    	WinActivate, ahk_exe Dep.exe
	Return
	}
else if WinExist("ahk_exe BlaiseCaseControl.exe")
	Winactivate
else
{	
	Run, "C:/ProgramData/CentERdata/SHARE_CASE_CTRL_W8_2/casectrl/BlaiseCaseControl.exe",,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
	WinMaximize, ahk_pid %OutputVarPID%
}
Return

;Activate or minimize save
<!ö::
{
	if WinExist("Save As")
		if WinActive()
			WinMinimize
		else
			WinActivate
	Else
		WinActivate
	return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 1.3. Robust, but cannot use generic function  (see below for "X.4. Run or Activate functions or roa" )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;













;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; Y. BACKUP CODE;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

