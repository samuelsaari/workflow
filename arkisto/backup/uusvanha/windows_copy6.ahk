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
;;;; 2. Windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for everything to work, 

;1.you will have to pin programs to the taskbar in the following order.
; If you dont have, say stata installed, just make sure that the rest of the programs are 2nd, 3rd..."nth" in the taskbar
; These are programs are the ones that do not work in a robust way (see the script below)
; 1 Stata
; 2 Any 
; 3 explorer (folders)
; 4 Goolgle keep 
; 5 spotify
; 6 filezilla
; The rest won't matter

;2. numlock has to be off


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0-3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad0::
;NumpadIns::  
if WinExist("ahk_exe firefox.exe")
    WinActivate
else
    Run, firefox.exe
Return

Numpad1::
;NumpadEnd:: 
if WinExist("ahk_exe word.exe")
    WinActivate
else
    Run, winword.exe
Return

Numpad2::
;NumpadDown::
if WinExist("ahk_exe OUTLOOK.EXE")
    WinActivate
else
    Run, OUTLOOK.EXE
Return

Numpad3::
;NumpadPgDn:: 
if WinExist("ahk_exe excel.exe")
    WinActivate
else
    Run, excel.exe
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 4-6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad4::
;NumpadLeft::
if WinExist("ahk_exe chrome.exe")
    WinActivate
else
    Run, chrome.exe
Return


;NB! Unrobust
;explorer
Numpad5::
;NumpadClear::
Send, {Lwin down}{4 down}
Sleep, 100
Send,{4 up}{Lwin up}
Return

;NB! Unrobust
Numpad6::
;NumpadRight::
if WinExist("ahk_exe spotify.exe")
WinActivate
else
Send, {Lwin down}{5 down}
Sleep, 100
Send,{5 up}{Lwin up}
Return
;Run, "C:\Users\mmak\AppData\Roaming\Spotify\Spotify.exe"
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 7 - 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad7::
;NumpadHome:: 
if WinExist("ahk_exe SnippingTool.exe")
    WinActivate
else
    Run, SnippingTool.exe
Return

Numpad8::
;NumpadUp:: 
if WinExist("ahk_exe zotero.exe")
    WinActivate
else
    Run, zotero.exe
Return

;NB! unrobust
Numpad9::
;NumpadPgUp:: 
Send, {Lwin down}{6 down}
Sleep, 100
Send,{6 up}{Lwin up}
;Run, "C:\Program Files\FileZilla FTP Client\filezilla.exe"
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; additional numpad buttons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadDot::
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

NumpadDiv::
if WinExist("ahk_exe notepad.exe")
    WinActivate
else
    Run, notepad.exe
Return


;NumpadMult::



;+NumpadDiv

;+NumpadAdd

;+NumpadMult::




;NumpadEnter:: Reserved for stata (see stata-script for details)
;+NumpadEnter:: Reserved for stata (see stata-script for details)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Close active program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadSub::
+NumpadSub::
Send, {LAlt down}{F4}{LAlt up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


Return




