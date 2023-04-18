;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Windows workflow
;;;; Author: Miika Mäki
;;;; Quide for hotkeys: https://autohotkey.com/docs/Hotkeys.htm
;;;;                    https://autohotkey.com/docs/KeyList.htm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;1. Zotero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;ZOTERO PLUGIN HOTKEYS
#IfWinActive, ahk_class MozillaDialogClass

;Suppress Author
$^å::send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)

#IfWinActive



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

§ & q::
if WinExist("ahk_exe chrome.exe")
    WinActivate
else
    Run, chrome.exe
Return

§ & LAlt::  
if WinExist("ahk_exe firefox.exe")
    WinActivate
else
    Run, firefox.exe
Return


§ & Lwin::
if WinExist("ahk_exe OUTLOOK.EXE")
    WinActivate
else
    Run, OUTLOOK.EXE
Return


§ & LCtrl::
if WinExist("ahk_exe rstudio.exe")
    WinActivate
else
    Run, rstudio.exe
Return


§ & s::
if WinExist("ahk_exe spotify.exe")
    WinActivate
else
    Run, spotify.exe
Return


§ & z:: 
if WinExist("ahk_exe zotero.exe")
    WinActivate
else
    Run, zotero.exe
Return



§ & d:: 
if WinExist("ahk_exe SnippingTool.exe")
    WinActivate
else
    Run, SnippingTool.exe
Return

§ & x:: 
if WinExist("ahk_exe excel.exe")
    WinActivate
else
    Run, excel.exe
Return

§ & w:: 
if WinExist("ahk_exe word.exe")
    WinActivate
else
    Run, word.exe
Return


§ & e:: 
if WinExist("ahk_exe Explorer.exe")
    WinActivate
else
    Run, Explorer.exe
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


Return




