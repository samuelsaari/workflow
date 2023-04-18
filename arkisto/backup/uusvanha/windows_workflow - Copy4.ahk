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


NumpadIns::  
if WinExist("ahk_exe firefox.exe")
    WinActivate
else
    Run, firefox.exe
Return

NumpadEnd:: 
if WinExist("ahk_exe word.exe")
    WinActivate
else
    Run, winword.exe
Return

NumpadDown::
if WinExist("ahk_exe OUTLOOK.EXE")
    WinActivate
else
    Run, OUTLOOK.EXE
Return

NumpadPgDn:: 
if WinExist("ahk_exe excel.exe")
    WinActivate
else
    Run, excel.exe
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadLeft::
if WinExist("ahk_exe chrome.exe")
    WinActivate
else
    Run, chrome.exe
Return


;NB! Unrobust
;explorer
NumpadClear::
Send, {Lwin down}{2 down}
Sleep, 100
Send,{2 up}{Lwin up}
Return


;NB! Unrobust
NumpadRight::
if WinExist("ahk_exe spotify.exe")
WinActivate
else
Send, {Lwin down}{4 down}
Sleep, 100
Send,{4 up}{Lwin up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


NumpadHome:: 
if WinExist("ahk_exe SnippingTool.exe")
    WinActivate
else
    Run, SnippingTool.exe
Return

NumpadUp:: 
if WinExist("ahk_exe zotero.exe")
    WinActivate
else
    Run, zotero.exe
Return

NumpadPgUp:: 
if WinExist("ahk_exe zilezilla.exe")
    WinActivate
else
    Run, "C:\Program Files\FileZilla FTP Client\filezilla.exe"
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadEnter::
if WinExist("ahk_exe rstudio.exe")
    WinActivate
else
    Run, rstudio.exe
Return

;NB! unrobust
NumpadAdd:: 
if WinExist("Google Keep")
    WinActivate
else
Send, {Lwin down}{3 down}
Sleep, 100
Send,{3 up}{Lwin up}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


Return




