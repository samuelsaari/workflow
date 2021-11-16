; Only Zotero & some word hotkeys here. Most updated version always in the windows_workflow.ahk file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Preliminaries;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
Global UserProfile ; Make userprofile a global variable
EnvGet, UserProfile, UserProfile ; Get userprofile from system variables

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; ZoteroWord_only_workflow
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
;; 2.2 Saving references to Zotero in firefox and chrome and other zotero functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;Run or Activate Zotero and quick format citation
<!e:: 
if (WinActive("Zotero") && WinExist("Quick Format Citation"))
	{
	WinActivate, Quick Format Citation
	Return
	}
else if (WinActive("Zotero") && !WinExist("Quick Format Citation"))
	{
	WinGet,WinState,MinMax,ahk_exe zotero.exe
	If WinState = -1
	   WinMaximize
	else
	   WinMinimize
	Return
	}
else if (WinExist("Zotero") && WinExist("Quick Format Citation"))
{
	WinGet, List, List, Zotero
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



; Adding a zotero reference

#IfWinActive, ahk_exe firefox.exe
^+s::
If !Winexist("ahk_exe zotero.exe")
{
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_exe firefox.exe
}
	Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
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
	WinActivate, ahk_exe chrome.exe
	Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
Return
#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;



;; -  Making word do Zotero related stuff with Ctrl & å - NB! change this to your key of liking

$^å::
If !WinActive("Quick Format Citation") && WinActive("ahk_class OpusApp") && Winexist("Zotero")
{
Send, ^+!j ; ZoteroAddEditCitation. this only works with the word macro (see the VBA script file)
;Send, {Ctrl down}å{Ctrl up} ; ZoteroAddEditCitation. this only works with the word macro (see the VBA script file)
Return
}
If !WinExist("Quick Format Citation") && WinActive("ahk_class OpusApp") && !Winexist("Zotero")
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_class OpusApp
	Send, ^+!j ; ZoteroAddEditCitation. this only works with the word macro (see the VBA script file)
	;Send, {Ctrl down}å{Ctrl up} ; ZoteroAddEditCitation. this only works with the word macro (see the VBA script file)
	WinWait, Quick Format Citation
    WinActivate, Quick Format Citation
	Return
}
; Activate Quick format citation under certain conditions with Alt & r or suppress the author
If !WinActive("Quick Format Citation") && WinExist("Quick Format Citation") && !WinActive("ahk_class OpusApp")
{
WinActivate, Quick Format Citation
Return
}
;Suppress Author
If WinActive("Quick Format Citation")
{
;old ahk
;send,  {Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}

; new, quicker ahk
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
Send, ^+!r
Return
#IfWinActive


;Make paragraph green
; selecthighlight
#IfWinActive, ahk_exe winword.exe
$^ö::
Send, ^+!l
Return
#IfWinActive


;Remove color from paragraph
;selecthighlightR
#IfWinActive, ahk_exe winword.exe
$^ä::
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

;Select paragraph, make norma
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^¨::
Send, ^+!n
Return

#IfWinActive




SetTitleMatchMode, 1