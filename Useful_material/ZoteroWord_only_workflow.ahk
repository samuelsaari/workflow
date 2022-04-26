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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1
;WORKAROUNDS FOR WORD THAT DOES NOT HAVE SPECIAL CHARACTERS OR SCANDINAVIAN LETTERS AS wdKeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NB! You need the VBA code for these to work


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
$^+ö::
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
; press ctrl + Shift + B (built in in word, no ahk needed)


;Refresh bibliography ZOTERO
;note that word's own ctrl/alt/r works
#IfWinActive, ahk_exe winword.exe
$^+ä::
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