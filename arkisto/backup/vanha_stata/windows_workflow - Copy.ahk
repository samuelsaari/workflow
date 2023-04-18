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

#IfWinExist, ahk_exe firefox.exe
^§:: WinActivate, ahk_exe firefox.exe
#IfWinExist

#IfWinExist, ahk_exe OUTLOOK.EXE
LCtrl & CapsLock:: WinActivate, ahk_exe OUTLOOK.EXE
#IfWinExist

;#IfWinExist, ahk_exe chrome.exe
LShift & CapsLock:: WinActivate, ahk_exe chrome.exe
;#IfWinExist

;#IfWinExist, ahk_exe rstudio.exe
;^q:: WinActivate, ahk_exe rstudio.exe
;#IfWinExist

#IfWinExist, ahk_exe Spotify.exe
+§:: WinActivate, ahk_exe Spotify.exe
#IfWinExist

;#IfWinExist, ahk_exe zotero.exe
;+§:: WinActivate, ahk_exe zotero.exe
;#IfWinExist

;#IfWinExist, ahk_exe SnippingTool.exe
;+w:: WinActivate, ahk_exe SnippingTool.exe
;#IfWinExist

;#IfWinExist, ahk_exe OUTLOOK.EXE
;+§:: WinActivate, ahk_exe OUTLOOK.EXE
;#IfWinExist



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


Return




