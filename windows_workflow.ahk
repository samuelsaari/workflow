;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Preliminaries;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
Global UserProfile ; Make userprofile a global variable
EnvGet, UserProfile, UserProfile ; Get userprofile from system variables

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; defining whether to use biblatex or natbib
global biblatex := 1

if (biblatex==1)
{
;msgbox, biblatex 1
global cite_normal:="\autocite{{}"
global cite_text :="\textcite{{}"
Return
}
else
{
;msgbox, biblatex not 1
global cite_normal :="\citep{{}"
global cite_text :="\citet{{}"
Return
}
Return

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



;1.1 Roar - or The "Run or Activate Robust" function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Many parts owe to Learning One(2009) and seperman(2017):

roar(ID_1,TARGET_1="",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")
;-------------------------------------------------------------------------------
;
; Toggles, Activates, Minimizes, Restores, or Runs program windows based on the whether the applications are running, how many windows there are and what state they are at
;
;1;		ID_1		= 1st critria to identify an existing window
;2;		TARGET_1	= executable program or a path to it
;3;		EX_TITLE	= exclude windows with titles that start with a given string
;4;		EX_AHK		= exclude processes (eg. ahk_exe firefox.ex) or strings in a window
;5;		TARGET_2	= alternative path to an excecutable file (if for example the paths are different in different machines you use)
;6;		ID_2 	 	= 2nd criteria to identify an existing window (adds windows to the group)
;7;		Mode 		= Mode of SetTitleMatchMode
;8;		ParamBox	= Show parameter values (1/0)
;9;		ID_3 	 	= 3rd criteria to identify an existing window (adds windows to the group)
;-------------------------------------------------------------------------------
{
;Creating groups with a uniques names;
	SetTitleMatchMode, %Mode%
	unique_group=%A_DDD%%A_YDay%%A_Hour%%A_Min%%A_MSec%
	unique_group1=% unique_group "1"
	unique_group2=% unique_group "2"
	GroupAdd, %unique_group1%, %ID_1%											;first criterion to include
	if (ParamBox==1)
		msgbox, ------Parameters-------- `n ID_1 `t`t %ID_1% `n TARGET_1 `t %TARGET_1% `n EX_TITLE  `t %EX_TITLE% `n EX_AHK `t %EX_AHK% `n TARGET_2 `t %TARGET_2% `n ID_2 `t`t %ID_2% `n mode `t`t %mode% `n ID_3 `t`t %ID_3%
	
	if (ID_2 !=""){
		GroupAdd, %unique_group1%, %ID_2%
		;MsgBox, ID_2 not empty
	}
	if (ID_3 !=""){
		GroupAdd, %unique_group1%, %ID_2%
		;MsgBox, ID_2 not empty
	}
	extitle_str:= % EX_TITLE
	GroupAdd, %unique_group2%,ahk_group %unique_group1%, , ,%extitle_str%		;exclude based on title
	GroupAdd, %unique_group%,ahk_group %unique_group2%, , , , %EX_AHK%			;exclude based on content (ahk_process)
; checking if the windows is active
	if WinActive("ahk_group" . unique_group) {
		WinGet, num, count,ahk_group %unique_group%
		;MsgBox, %num% ;;;
		; if only one window minimize or maximize
		if (num==1) || (ID_1=="ahk_exe spotify.exe") || (ID_1=="ahk_exe MobaXterm.exe")		; for some reason > 1 windows identified for these apps, this is a workaround
			{
			WinGet,WinState,MinMax,ahk_group %unique_group%
			If WinState = -1
				{
				;msgbox, restoring ;;;
				WinRestore ;;; was WinMaximize	
				}
			 else 
				{
				;msgbox, minimize
				WinMinimize
				}
			} 
		; if multiple windows, toggle
		else 
		{
		WinGet, List, List, ahk_group %unique_group%
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
	else if WinExist("ahk_group" . unique_group) {
		;msgbox, activating inactive ;;;
		WinActivate
	}
; if window does not exist, run the target
	else
	;msgbox, running target
	{	
		try {
			If InStr(TARGET_1, "\")==1 {  
				;MsgBox, % UserProfile . TARGET_2
				Run, % UserProfile . TARGET_1
			} Else {
				;msgbox, %TARGET_1%
				Run, %TARGET_1%
			}
		} catch e {
				;MsgBox, Trying to run target_2 ;;;
			If InStr(TARGET_2, "\")==1 {
				;MsgBox, % UserProfile . TARGET_2
				Run, % UserProfile . TARGET_2
				
			} Else 
				;msgbox, %TARGET_2%
				Run, %TARGET_2%
		}
	;MsgBox, waiting ;;;
	WinWait, ahk_group unique_group,,2
	WinActivate, ahk_group unique_group
	;WinMaximize, ahk_group unique_group
	}
	Return
}


;-----------------------------------------------------------------------------------------------------------------------------------------

;Applying Roar to different apps

;1.1.It is recommened – but not a prerequisite – to to pin programs to the taskbar in the following order.
; (1 Stata) 
; (2 Outlook)
; ...The hotkeys will work anyway but the build-in function Win + (1 or 2) works quite nicely together with...
; ...the hotkeys I have assigned for Stata and Outlook.




;-----------------------------------------------------------------------------------------
; Chart of hotkeys starting with Left Alt - also those not yet assigned to a programme
;-----------------------------------------------------------------------------------------
;Quick way to add new program
#IfWinActive, ahk_class Notepad++
<^!n::Send,roar(,,EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")
#IfWinActive

;---------------------------------------F1F2...F12HomeEndDelete---------------------------
<!delete::roar("ahk_class TaskManagerWindow", "taskmgr.exe")

;---------------------------------------1234567890---------------------------------------

<!§::roar("ahk_class PPTFrameClass", "powerpnt.exe") ; see also <
;<!1::roar("ahk_exe StataSE-64.exe", "C:\Program Files (x86)\Stata15\StataSE-64.exe")
;<!1::roar("ahk_exe StataMP-64.exe", "C:\Program Files\Stata17\StataMP-64.exe")
<!1::roar("ahk_exe StataMP-64.exe", "C:\Program Files\Stata18\StataMP-64.exe")

;<!2::roar("ahk_exe outlook.exe", "outlook.exe") ; old outlook
;<!2::roar("ahk_exe olk.exe", "outlook.exe") ; new outlook
;<!2::roar("Outlook","outlook.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=2,Parambox:=0,ID_3:="") ; add hoc subsitute, above does not work
roar("ahk_class rctr_renwnd32","outlook.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=2,Parambox:=0,ID_3:="") ;yet another try at outlook
<!2::roar("ahk_exe outlook.exe", "outlook.exe") ; old outlook
;<!3::roar("ahk_exe acrord32.exe","acrord32.exe") ;ADOBE READER
;<!3::roar("ahk_exe acrobat.exe","acrobat.exe") ;ADOBE READER
<!3::roar("ahk_exe acrobat.exe","acrobat.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="acrord32.exe",ID_2:="ahk_exe acrord32.exe",Mode:=1,Parambox:=0,ID_3:="ahk_class AcrobatSDIwindow")
<!4::roar("ahk_exe DigitalEditions.exe","DigitalEditions.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="C:\Program Files (x86)\Adobe\Adobe Digital Editions 4.5\DigitalEditions.exe",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")
<!5::roar("ahk_exe sam.exe","C:\Program Files\PDFsam Enhanced 7\sam-launcher.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")
;<!5::roar("ahk_exe soda.exe","C:\Program Files\Soda PDF Desktop 12\soda-launcher.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")

;<!6 - see toggle tooltip
;<!7 - see dep
;<!8
;<!9 
<!0::roar("- Paint 3D","ms-paint:",,,,,mode:=2)
;<!+:: 

;---------------------------------------qwertyuiopå---------------------------------------
<!q::roar("ahk_class XLMAIN", "excel.exe")
<!w::roar("ahk_class OpusApp", "winword.exe") ; WORD
;<!e::roar("ahk_exe zotero.exe", "zotero.exe") ; (- see section 2 for  zotero maneouvers)
<!e::roar("ahk_exe zotero.exe", "zotero.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")
<!r::roar("ahk_exe discord.exe","C:\Users\mmak\AppData\Local\Discord\Update.exe --processStart Discord.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=1,Parambox:=0,ID_3:="")
;<!t
<!y::roar("ahk_exe filezilla.exe", "filezilla.exe")
;<!u:: 
;<!i::roar("Photos ahk_class ApplicationFrameWindow","ms-photos:",,,,,Mode:=2)
<!i::roar("Pictureflect Photo Viewer ahk_class ApplicationFrameWindow","pictureflect-photo-viewer.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=2,Parambox:=0,ID_3:="") ; https://pictureflect.com/how-to/app-scripting-help
<!o::roar("ahk_exe opera.exe", "opera.exe")
<!p::roar("ahk_exe mspub.exe", "mspub.exe") ; PUBLISHER
;<!å::

;--------------------------------------- asdfghjklöä-----------------------------------------
<!CAPSLOCK::roar("ahk_class MozillaWindowClass", "firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe",TARGET_2:="C:\Program Files\Mozilla Firefox\firefox.exe")
<!a::roar("ahk_class CabinetWClass", "explorer.exe")
<!s::roar("ahk_exe code.exe", "\AppData\Local\Programs\Microsoft VS Code\Code.exe", "Google Keep")
<!d::roar("ahk_exe teams.exe", "\AppData\Local\Microsoft\Teams\Update.exe --processStart Teams.exe")
<!f::roar("ahk_exe slack.exe", "\AppData\Local\slack\slack.exe")
<!g::roar("ahk_class gdkWindowToplevel", "C:\Program Files\GIMP 2\bin\gimp-2.10.exe") ;NB!
;<!h
;<!j::roar("ahk_exe MobaXterm.exe", "C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe")
<!j::roar("ahk_exe MobaXterm.exe", "C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="ahk_class TMobaXtermForm",Mode:=1,Parambox:=0,ID_3:="")
<!k::roar("Snip & Sketch ahk_class ApplicationFrameWindow", "ms-screenclip:?source=QuickActions") ; built in combo #+s:: is a bit faster
<!l::roar("ahk_exe texstudio.exe","C:\Program Files\texstudio\texstudio.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="ahk_class Qt620QWindowIcon",Mode:=1,Parambox:=0,ID_3:="")
;<!ö - 
<!ä::roar("Quick Format Citation","zotero.exe",EX_TITLE:="Zotero",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=2,Parambox:=0,ID_3:="") ; See also section 2. for other Zotero hotkeys

;---------------------------------------<zxcvbnm,.----------------------------------------
<!SHIFT::roar("ahk_exe chrome.exe", "chrome.exe", "Google Keep")
#IfWinNotExist, Stata
<!<::roar("ahk_class PPTFrameClass", "powerpnt.exe")
#IfWinNotExist

<!z::roar("ahk_class Chrome_WidgetWin_1","msedge.exe")
<!x::roar("ahk_exe rstudio.exe","rstudio.exe")
;<!c::roar("ahk_exe powershell.exe", "powershell.exe") ; not sure how to execute anaconda powershell
<!c::roar("ahk_exe cmd.exe","cmd.exe",,,"C:\Windows\SysWOW64\cmd.exe") ; not sure how to execute anaconda powershell
;<!v::roar("Windows 10 for Staff", "vmware-view.exe",EX_TITLE:="",EX_AHK:="", TARGET_2:="",ID_2:="",Mode:=2,Parambox:=0,ID_3:="")

<!v::roar("Zoom ahk_exe Zoom.exe","\AppData\Roaming\Zoom\bin\Zoom.exe" , , , , ID_2:="Room ahk_exe zoom.exe",,Parambox:=0)
<!b::roar("Settings ahk_class ApplicationFrameWindow", "ms-settings:bluetooth") ; toggle (all) setting windows or launch bluetooth settings
<!n::roar("ahk_class Notepad", "notepad.exe")
<!m::roar("ahk_class Notepad++", "notepad++.exe")
;<!,
;<!.
;<!-



;---------------------------------------CtrlWinAltSPACE---------------------------------------
<!LCTRL::roar(ID_1:="ahk_exe spotify.exe",TARGET_1:="\AppData\Roaming\Spotify\Spotify.exe", , ,TARGET_2:="\AppData\Local\Microsoft\WindowsApps\Spotify.exe")


<!LWIN::roar("Google Keep", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://keep.google.com", , ,TARGET_2:="C:\Program Files\Google\Chrome\Application\chrome.exe --app=https://keep.google.com",ID_2:="",mode:=2,ParamBox:=0) ;NB!
;ahk_exe chrome.exe"
;<!SPACE::roar("A") ; Active process. Does not work
;<!-Ralt
;<!-RCtrl
;<!(Arrows)
;---------------------------------------------------------------------------------------------------------------------------------------------------





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 1.2 Working with windows, but not with the ROAR function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; "ahk_class ZPContentWndClass"

;Close current window and forcekill stubborn processes
#IfWinNotActive, Program Manager ;this, and following prevents windows from getting rid of desktop items
#IfWinNotActive, "" 
#IfWinNotActive, ahk_class WorkerW
<!ESC::
SetTitleMatchMode, 1
if Winactive("Zoom") && !Winexist("Zoom Meeting")
	{
		run, taskkill /f /im zoom.exe ; might not be needed anymore
		Return
	}
else if Winactive("ahk_exe Teams.exe")
	{
		run, taskkill /f /im Teams.exe ; this might not be needed in the future
		Return
	}
else if Winactive("ahk_exe discord.exe")
	{
		run, taskkill /f /im discord.exe ; this might not be needed in the future
		Return
	}
Else 
	WinClose A
Return
#IfWinNotActive
 Return


; Toggle tooltip (same hotkey exits in the tooltip.ahk file)

<!6::
;DetectHiddenWindows, On
SetTitleMatchMode, 3
IfWinNotExist,tooltip.ahk
	try {
		Run, "%UserProfile%\OneDrive\Autohotkey\Useful_material\tooltip.ahk" ;NB! Edit this where you have put this file
		Return
	} catch e{
		MsgBox, not implemented yet `n Search for "Toggle tooltip" in the the windows_workflow.ahk script 
		Return
	}
SetTitleMatchMode, 1
Return



;NB!  ; you may just want to delete this
;dep
<!7:: 
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
	Run, "C:\ProgramData\CentERdata\SHARE_CASE_CTRL_W9_2\casectrl\BlaiseCaseControl.exe",,,OutputVarPID ; OBS!
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
	WinMaximize, ahk_pid %OutputVarPID%
}
Return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;2. General windows, Zotero, Word & other microsoft applications
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1
;WORKAROUNDS FOR WORD THAT DOES NOT HAVE SPECIAL CHARACTERS OR SCANDINAVIAN LETTERS AS wdKeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NB! You need the VBA code for these to work


;Make paragraph green
; selecthighlight
#IfWinActive, ahk_exe winword.exe
$^-::
Send, ^+!l
Return
#IfWinActive


;Remove color from paragraph
;selecthighlightR
#IfWinActive, ahk_exe winword.exe
$^+-::
Send, ^+!k
Return
#IfWinActive

;Select paragraph
;Select para
#IfWinActive, ahk_exe winword.exe
$^'::
Send, ^+!p
Return
#IfWinActive

;Select paragraph, make normal
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^+'::
Send, ^+!n
Return
#IfWinActive


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ZoteroAddEditBibliography_SC
; press ctrl + Shift + B (built-in word shortcut, no ahk needed)


;Refresh bibliography ZOTERO
;note that word's own ctrl/alt/r works
#IfWinActive, ahk_exe winword.exe
$^!ä::
Send, ^+!r
Return
#IfWinActive

SetTitleMatchMode, 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2.2 Saving references to Zotero in firefox and chrome and other zotero functions
;; See also above for bibliography shortcuts in Word
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AddReference(BROWSER_EXE)
{
	If !Winexist("ahk_exe zotero.exe")
		{
			Run, zotero.exe,,,OutputVarPID
			WinWait, ahk_pid %OutputVarPID%
			Sleep, 300
			WinActivate, %BROWSER_EXE%
			;Sleep, 100
		}
		else
		{	
			if (BROWSER_EXE=="ahk_exe firefox.exe") 
			{
			Send, {Ctrl down}{Alt down}f{pause}{Alt up}{Ctrl up}
			}
			else if (BROWSER_EXE=="ahk_exe chrome.exe") 
			{
			Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
			}
		}
	Return
}


#IfWinActive, ahk_exe firefox.exe
$^$+$s::AddReference("ahk_exe firefox.exe")
#IfWinActive

#IfWinActive, ahk_exe chrome.exe
$^$+$s::AddReference("ahk_exe chrome.exe")
#IfWinActive



;; -  Active Quick Format or Suppress Author Ctrl & ä - NB! change this to your key of liking
SetKeyDelay,70,10
$^ä::
if WinActive("ahk_class OpusApp") && !WinExist("Quick Format Citation")
	{
		If !Winexist("ahk_exe zotero.exe")
		{	
			;MsgBox, Running Zotero
			Run, zotero.exe,,,OutputVarPID
			WinWait, ahk_pid %OutputVarPID%
			Sleep, 300
			WinActivate, ahk_class OpusApp	
		}
			;Msgbox, pressing CtrlShiftAlt j
			Send, ^+!j ; ZoteroAddEditCitation. this only works with the word macro (see the VBA script file)
			WinWait, Quick Format Citation
			WinActivate, Quick Format Citation
			Return
	}
if !WinActive("Quick Format Citation") && WinExist("Quick Format Citation")
	{
		;Msgbox, Activate Quick Format Citation
		WinActivate, Quick Format Citation
		Return
	}
else if WinActive("Quick Format Citation")
	{
		;MsgBox, Suppress Author
		Send,{Control down}{down}{Control up}
		Sleep, 80
		Send,{tab}{tab}{tab}{tab}{tab}{space}
		Sleep, 80
		Send,{enter}
		Sleep, 80
		Send,{enter}
		Return
	}
Return
SetKeyDelay,10,-1

;SetTitleMatchMode, 1







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.3
; VScode, citing and zotero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------
;2.3. VScode, citing and zoteroc
;;----------------------------------------------------------------------------------------------------------------------------------------
;Note that you can also assign shortcuts in VS Studio (file->preferences->keyboard shortcuts)


;Biblatex or Natbib globals defined at the beginning of this script

CiteFromZoteroInVsCode(WHAT_TO_TYPE:="NOTHING")
{
	If !Winexist("ahk_exe zotero.exe")
	{
		Run, zotero.exe,,,OutputVarPID
		WinWait, ahk_pid %OutputVarPID%
		Sleep, 300
		WinActivate, ahk_exe code.exe
	}
	else if WinExist("Quick Format Citation")
	{
		if Winactive("Quick Format Citation")
		{
			Send,{Enter}
			Return
			/*
			WinGet,WinState,MinMax,Quick Format Citation
			If WinState = -1 ; minimized
			   WinRestore, Quick Format Citation
			else
			   WinMinimize, Quick Format Citation
			Return
			*/
		}
		else
		{
			WinActivate, Quick Format Citation
			Return
		}
	}
	if (WHAT_TO_TYPE=="CITE_NORMAL") 
		{
		Send, %cite_normal%
		}
	else if (WHAT_TO_TYPE=="CITE_TEXT")
		{
		Send,%cite_text% 
		}
	Sleep,50
	Send,{Ctrl down}ä{pause}{Ctrl up} ; Ctrl+Ä needs to be activated in vscode shortcuts for "Cite from Zotero"
	Winwait, Quick Format Citation
	WinActivate, Quick Format Citation
	Return
}
Return


#IfWinActive, ahk_exe code.exe


	$^$ä::CiteFromZoteroInVsCode(WHAT_TO_TYPE:="NOTHING")
	;<$^+$ä::CiteFromZoteroInVsCode(WHAT_TO_TYPE:="CITEP_BRACKETS") ; currently not working
	<$^+$ö::CiteFromZoteroInVsCode(WHAT_TO_TYPE:="NOTHING")
	<$^+$å::CiteFromZoteroInVsCode(WHAT_TO_TYPE:="NOTHING")
	
	Return
#IfWinActive


; helper function for the next typings
AddBraceOutsideVScode()
{
if !Winactive("ahk_exe code.exe")
	{
		Send,{}}{left}
	}
}
Return


CiteFromZoteroInOverleaf(WHAT_TO_TYPE:="NOTHING")
{
	if (WHAT_TO_TYPE=="CITE_NORMAL") 
		{
		Send,%cite_normal% 
		}
	else if (WHAT_TO_TYPE=="CITE_TEXT")
		{
		Send,%cite_text%
		}
	if (WHAT_TO_TYPE!="NOTHING")
		{
		AddBraceOutsideVScode()
		Sleep,145
		}
	Send,{Ctrl down}{space}{pause}{Ctrl up} 
	Return
}


#IfWinActive,Overleaf
#IfWinActive,ahk_exe chrome.exe
<^ä::CiteFromZoteroInOverleaf("NOTHING")
<^+ö::CiteFromZoteroInOverleaf("CITE_NORMAL")
<^+å::CiteFromZoteroInOverleaf("CITE_TEXT")
#IfWinActive




<^!,::msgbox, %biblatex%
Return

SetTitleMatchMode,1

#IfWinNotActive, ahk_exe winword.exe 
#IfWinNotActive, Quick Format Citation

	; typing citep{}
	<^ö::
	Send, %cite_normal%
	AddBraceOutsideVScode()
	Return
	
	; typing citet{}
	<$^å::
	Send,%cite_text% 
	AddBraceOutsideVScode()
	Return
	
	; typing citep[][]{}
	<$^+$ä::
	Send, %cite_normal%
	Send, {backspace}
	Send,[][]{{}
	AddBraceOutsideVScode()
	Return
	
#IfWinNotActive

#IfWinActive, Quick Format Citation
	<^ö::
	<^å::
	Send,{Enter}
#IfWinActive


#IfWinActive, ahk_exe code.exe
	<^!m::
	Send,if __name__ == "__main__":
	Return
	
	<$^+$v::
	Send,print(f"{{}'
	Send,%Clipboard%
	Send,':<30{}}
	Send,{{}
	Send,%Clipboard%
	Send,{}}
	Send,")
	;Send,{right}{right}
	Return
#IfWinActive



;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.4 
; General Windows Life Hacks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; email formalities
#IfWinNotActive ahk_exe rstudio.exe
;formal tone
<^<!o::
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
#IfWinNotActive

;Typing special characters
;En dash
<#n::
Send,–
Return

;Em dash
<#m::
Send,—
Return


;;-----------------------
;-------ADOBE READER/ACROBAT-------
; Inverse colors in adobe reader (you might have to set sensible settings first)
; For some reason the input level will have to be 0 for this to work with the spotify alt+ctrl.

SetKeyDelay , 70,10
If WinActive(ahk_exe acrobat.exe) || WinActive(ahk_exe acrord32.exe)
{
$<^$!k::
Send,{Ctrl down}k{Ctrl up}
Winwait,Preferences
;ac for accessibility settings, then navigate to first checkbox to replace document colors
Send,ac
Sleep, 60
Send,{TAB}
Sleep, 20
Send,{SPACE}
Sleep, 20
Send,{ENTER}
;Send,ac{pause}{pause}{pause}{TAB}{pause}{pause}{pause}{SPACE}{pause}{pause}{pause}{ENTER}
Return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.1 plainpaste microsoft office

; not in use
/*
#If (WinActive("ahk_exe outlook.exe") or WinActive("ahk_exe winword.exe") or WinActive("ahk_exe powerpnt.exe"))
$^$+$v::
if WinActive("ahk_exe powerpnt.exe")
	POWERPOINT:=1
else
	POWERPOINT:=0
Send, {Control down}{pause}{Alt down}{pause}v{pause}{Control up}{pause}{Alt up}
Winwait,Paste Special,,1 ; wait for X seconds max
Winactivate
Sleep,20
If !WinExist("Paste Special")
{
	MsgBox, Paste special window did not open `n Press Enter and try again
	Return
}
else
	{
	;If options selected, will choose the bottom,
	if (POWERPOINT==1)
		{
		;Msgbox, powerpoint active
		Send,{tab}
		Sleep,20
		}
	Send,u
	Sleep,20
	Send, {enter}
	Return
	}

#IfWinActive

*/


/*
#IfWinActive ahk_exe powerpnt.exe
$^$+$v::
Send,{Control down}{Alt down}v{Control up}{Alt up}
Sleep, 80
Send,{tab}
Sleep,80
Send, {down}{down}
Sleep, 80
Send,{enter}
Return
#IfWinActive
*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;; 3. OTHER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Change primary mouse button
<!SPACE::
Run, main.cpl
Winwait, Mouse Properties,,0.5
if ErrorLevel
{
    MsgBox, Mouse Properties did not open in time
    return
}
Sleep,20
Send, {Space}{pause}{Enter}
MsgBox,64,Autohotkey message:,Primary mouse button changed,0.8
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; X Links
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Learning One(2009) Run application if not active - activate window if active [Accessed Oct 15, 2019] https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/
;seperman (2017) AutoHotkey_ErgoKeyboard [Accessed Oct 15, 2019] https://gist.github.com/seperman/8064659


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; Y. BACKUP CODE;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


<^!q::
MsgBox, This is a test, and it works nicely
Return


/*
#IfWinActive, ahk_exe notepad.exe
$^!ö::
Send, Toimii
Return
#IfWinActive
*/



/*
;Activate or minimize save as
<!ö::

	if WinExist("Save As")
		if WinActive()
			WinMinimize
		else
			WinActivate
	Else
		WinActivate
	return
}
*/

;SetKeyDelay back to default
SetKeyDelay , 10, -1